Return-Path: <linux-kernel+bounces-274866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0BA947DD1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943F0283430
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1085F14B976;
	Mon,  5 Aug 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbShwCcr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3513C9C4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871112; cv=none; b=HOw12ffUC00oxqXEBlwYRN8mfdsRVp5UfX8k21PniPVj+a6jZq0Zi5SZaAXy8W3+iNnKggt9dibw0s1na5sGfDdE0+Qmv9uCsg2/lGXGA8594kwrUMyOLZVW57i+F1oBiuvW8XtLbDIX6HlO/oeIThKTFj6EGZ84PBGy501CtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871112; c=relaxed/simple;
	bh=kkvGoi0f0c5PpGxgHArGJ5Ke+O/35l1auQGnTlvYrRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nccDdWrn4rU1o+MWo1CtYS4Nao0z67wk/iiRxWf+dm/Clni8LoToHcabE2848jGqkFw2Vmk3Ia2/ILsIWPeTqhJyS+6tyr3fWMZdE8pwjzogkEloQuCi1/KRFzorjNf4AqsCS2PQm4U+5TyrkA9rAW+pjsuoDikEwKDNq3qRUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbShwCcr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722871108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrDM2KuIhRw2gmftz8XlBvUcpa2vmPZk/i+1I5URTgY=;
	b=KbShwCcrVeyvKBbGHyvXLz7pzPEGqgAaCdGWzmlyldzk0Vh2qCtYRN26RynahJuAUf0jvo
	TEW3DKMrexaYeG/ZVaPBrHewel1VvY1uNPrJBYmf5fWsioKUtYFGyx9aR5hxziaO3VpwY8
	N79M4jhV6YIgskShwHsnMhiIm9g6Bj0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-w9j86ed8P-G0MFknnwax4g-1; Mon, 05 Aug 2024 11:18:24 -0400
X-MC-Unique: w9j86ed8P-G0MFknnwax4g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5b122f40f64so7334330a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871103; x=1723475903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrDM2KuIhRw2gmftz8XlBvUcpa2vmPZk/i+1I5URTgY=;
        b=CGOnCtYhNQ0k/I3vvcx3azIB6S64wYkG+mHjzAT40RJoqGk8P3jU1/PjcharSZ7V5q
         wAiIRet44J4hgSvs1RqT/7iocnb6lIqRrk63U2LTahXY2Yzw0qVyphgdedvAm4OIsiVr
         UfR58J3D9kWZ7sg+EiKZFWpziQDOnPshaCqcCmKJfIdvPXIpLqIpQwAdiCxL5oLZd4nV
         hkFN4b0r64abkGwdFqYXHA6JCG0HsMqb3NlToQbj5VSljr8pwsTrsbTiRVHEjzm+rOFu
         pAfXfSvETLeNyXWEu8+Jpw9FVzNgmMlyKXNhb1LZ1bLs8neaWFnKNUjyL3e6xfcHmNIp
         hjJg==
X-Forwarded-Encrypted: i=1; AJvYcCUmXTuld+u4vKX8gzHCCKULSY0k9lPn8dV3sYRwtbTP7MT+Nt1e/MC84Q/7NPaJA30fMOon6Isb1QlnDt1hueS/Q2uQ87og1hDRZkXq
X-Gm-Message-State: AOJu0YycZlsSz7ly+pdD3nuf2kfXHyuFoFMX5hzURQLuDX/G4LUG/G0P
	oVNcD+piyBDQu1CmCMgVF7zarvih/6Ifrk4AXS1fmS6hEOsmwoWsCjyixoNi/LK6Mf7E8niL6dD
	JJggxkr08bH6lteAdfx5fNyhD5Hnl7caavW/3Z3EugNlsiojmnQ7kAkTr9koOZg==
X-Received: by 2002:a17:907:6e9f:b0:a77:d441:c6f1 with SMTP id a640c23a62f3a-a7dc4e6cc2dmr917807066b.33.1722871103652;
        Mon, 05 Aug 2024 08:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgBBb8Vnn38uxWxtoDdQN//1QoihGDm9GoBI2yfEDi6U/GFMX7lDJqB017d9qiYNaaHZ30FA==
X-Received: by 2002:a17:907:6e9f:b0:a77:d441:c6f1 with SMTP id a640c23a62f3a-a7dc4e6cc2dmr917805266b.33.1722871103184;
        Mon, 05 Aug 2024 08:18:23 -0700 (PDT)
Received: from [192.168.211.203] ([109.38.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3cfesm464524266b.2.2024.08.05.08.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:18:22 -0700 (PDT)
Message-ID: <517aa9f5-00cf-4a68-b1d7-a6dc9f942e7c@redhat.com>
Date: Mon, 5 Aug 2024 17:18:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] platform/x86: introduce asus-bioscfg
To: Luke Jones <luke@ljones.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240716051612.64842-1-luke@ljones.dev>
 <8273ed57-4c65-41da-ad7d-907acf168c07@redhat.com>
 <e9f4fb37-5277-a7f0-2bec-8a6909b4e674@linux.intel.com>
 <1e309d39-43d3-4054-88a9-0c1da3de26eb@app.fastmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1e309d39-43d3-4054-88a9-0c1da3de26eb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luke,

On 7/17/24 4:34 AM, Luke Jones wrote:
> On Wed, 17 Jul 2024, at 3:11 AM, Ilpo Järvinen wrote:
>> On Tue, 16 Jul 2024, Hans de Goede wrote:
>>> On 7/16/24 7:16 AM, Luke D. Jones wrote:
>>>> This is the first major patch I've ever done with the intention of
>>>> introducing a new module, so it's highly likely I've made some mistakes
>>>> or misunderstood something.
>>>>
>>>> TL;DR:
>>>> 1. introduce new module to contain bios attributes, using fw_attributes_class
>>>> 2. deprecate all possible attributes from asus-wmi that were added ad-hoc
>>>> 3. remove those in the next LTS cycle
>>>>
>>>> The idea for this originates from a conversation with Mario Limonciello
>>>> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
>>>>
>>>> It is without a doubt much cleaner to use, easier to discover, and the
>>>> API is well defined as opposed to the random clutter of attributes I had
>>>> been placing in the platform sysfs.
>>>
>>> This is a bit of a novel use of the fw_attributes_class and I'm not
>>> entirely sure of what to think of this.
>>>
>>> The fw_attributes_class API was designed for (mostly enterprise)
>>> x86 machines where it is possible to change all BIOS settings directly
>>> from the OS without entering the BIOS.
>>>
>>> Here some ACPI or WMI function is present to actually enumerate all
>>> the BIOS options (which can be set this way) and get there type.
>>>
>>> IOW there is not a static list of options inside the driver, nor
>>> is there special handling in the driver other then handling differences
>>> per type.
>>>
>>> And if a new BIOS version has new options or a different machine model
>>> has different options then these are discovered automatically.
>>>
>>> This new use is quite different from this. Although I do see that
>>> at least for the attributes using WMI_STORE_INT() + WMI_SHOW_INT()
>>> that there is quite some commonality between some of the attributes.
>>>
>>> I see how using the existing firmware-attributes class API definition
>>> for this, including allow tweaking this with some of the fwupd
>>> firmware-attributes class commandline util work Mario did is a useful
>>> thing to have.
>>>
>>> I guess using the firmware-attributes class for this is ok, but
>>> this _must_ not be named bioscfg, since the existing hp-bioscfg
>>> driver is a "classic" firmware-attributes drivers enumerating all
>>> the options through BIOS provided enumeration functions and I want
>>> the name to make it clear that this is not that. And the Dell
>>> implementation is called dell-wmi-sysman so lets also avoid sysman
>>> as name.
>>>
>>> Maybe call it "asus-bios-tunables" ?   And then if Asus actually
>>> implements some more classic firmware-attributes enumerable interface
>>> we can use "asus-bioscfg" for that.
>>>
>>> Mario, Ilpo what is your opinion on this ?
>>
>> What you suggested sounds good to me.
> 
> Thanks guys. I think there might be a few names that could be suitable
> 
> 1. asus_bios_tuning/tunables
> 2. asus_fw_tuning/tunables
> 3. asus_fw_settings
> 4. asus_armoury
> 
> I'm shying away from the "tuning/tunables" label since there are also a lot of settings which are just toggles for various features rather than actual tunable things. It makes sense in some contexts at least.
> 
> Armoury Crate is the software collection that Asus uses for the gaming laptops, and they tend to lump these settings under that label.
> 
> Personally I'm leaning towards "asus_fw_settings" as it more accurately describes what the module does.

"asus_fw_settings" sounds good to me. I'm looking forward to v2 of this series.

Regards,

Hans



