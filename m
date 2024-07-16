Return-Path: <linux-kernel+bounces-253536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF6A932299
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B52F1F2355D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF525195B35;
	Tue, 16 Jul 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6h83RmS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B44157A43
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121629; cv=none; b=mGGnmPGBFi46dpw1mHSdz6vyOujwXHHEpld+WExred+DEQPMMXrFw0+RD1sD6HOo162BtdzR8UTjzHpgaCtIu7uhLdhSliKvQ+D6Y9gkdjdPW+Ixg/qH3UMxU2/xE5q/++Iauz3SNoQNdRG2OZNqI2flLaodcBUuSnBf0fVITD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121629; c=relaxed/simple;
	bh=1/a/yfY0TjRJwxbZeY/ns27L44GCeG6929a15uNimF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/Hkw5RIBh+uuIh1vS5suDpNgnBgvUwYOorhSziHAOvdqO1Kv0HQr6KuzKau5K4zmsZuxnE7/24qDjHfBNdGlyBss+M3MdZFRpYnpTkThgdzlZCT/ZP/C/Dhm4cm686OkkyROb6dG9M22iQJp4dH2QwPlcxNQkqpcux9iErV+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6h83RmS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721121626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdCPq+U46ySE0zyw6mUy09hUxN+0LCiqbk6pLbsUD44=;
	b=S6h83RmSOB/Qj8wOP8722nQGRlRJsnh4iDzGeqmWtfz1U0/UcEiLDShy7PPObEoCV0ohWs
	smorBnnpLRszxV/7sMWQJIFor+TO5bX1264Qj6vIgxhWu6yspykRuS3HhNj+U8+mfuauS7
	ADZ9XNnZ687iXB/hE79BOaYrS23hw8k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-YhrADwczP_Geho9NpPUqUA-1; Tue, 16 Jul 2024 05:20:22 -0400
X-MC-Unique: YhrADwczP_Geho9NpPUqUA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a77f0eca759so397323766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721121621; x=1721726421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdCPq+U46ySE0zyw6mUy09hUxN+0LCiqbk6pLbsUD44=;
        b=mifAi5Q0aga95PF9qZ3IXUGeylys9Mt5zNRhfSfU/pDVfBNgymo9lVxHY0k69FypFF
         jPI90R4zfOVv71sMcI/iP9aqnj/vINzmZpZWOAaKLp7wZp4FvoQxrQ0R/+QmjuA4aecU
         HTtB3mFY63eihgteJpRbpZx1fTl//gV8z1QBCNZrdDXOkzdydwWCHMx6HZzg1VLq7S7Z
         col/k/j3uJ9B3C7PuJfw5RapZCgbmcR9MGXqQPWr2KZRfeYXg84QNbxdIcYejOBJblwl
         jqKsOBms455Vdz0ZW8dIv+yGqyE8tOrbIGkIKZJu0vhAYlsM8RSt3aux7uSMfKVgZeBn
         KUeA==
X-Forwarded-Encrypted: i=1; AJvYcCXCQ384oGW2rJGqN7yc2+LOB4IjsBlEApvbAzeFwQHBaK5B5Az2qrMSC7kiZc9o5DKKCrCwkUSD/ODIlEBsTKQ7gGHKQov7wOo8mx71
X-Gm-Message-State: AOJu0Yzbk3VhLhYioXr3ei23GERnNajitEgpMA60yEn9b5vtgHCKtd4Z
	7+5qs5kd4fLYrABooqzTfrfrpCMhRsPZHFDxHcoSyMnIOm/QZCo7yeyLFwyuYgn9FmHLv6MhQVZ
	Do/KilD79FioAeKN0cniYAqEpbEbnkxPIEnPTZmyEZ75rjJFa2RybTsBz6UywgQ==
X-Received: by 2002:a17:907:7b8d:b0:a6f:4e1f:e613 with SMTP id a640c23a62f3a-a79ea46d7c7mr116985266b.37.1721121620912;
        Tue, 16 Jul 2024 02:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Q4gXbO33pY/K/+W8CI52EKCa4YRbHywZ2eE0EP0YYT2rgJqMwTnbQ9LovHqj4KSIV23TPQ==
X-Received: by 2002:a17:907:7b8d:b0:a6f:4e1f:e613 with SMTP id a640c23a62f3a-a79ea46d7c7mr116983666b.37.1721121620520;
        Tue, 16 Jul 2024 02:20:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7f00sm285964166b.63.2024.07.16.02.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:20:20 -0700 (PDT)
Message-ID: <8273ed57-4c65-41da-ad7d-907acf168c07@redhat.com>
Date: Tue, 16 Jul 2024 11:20:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] platform/x86: introduce asus-bioscfg
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, ilpo.jarvinen@linux.intel.com,
 mario.limonciello@amd.com, linux-kernel@vger.kernel.org
References: <20240716051612.64842-1-luke@ljones.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240716051612.64842-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Luke, Mario,

On 7/16/24 7:16 AM, Luke D. Jones wrote:
> This is the first major patch I've ever done with the intention of
> introducing a new module, so it's highly likely I've made some mistakes
> or misunderstood something.
> 
> TL;DR:
> 1. introduce new module to contain bios attributes, using fw_attributes_class
> 2. deprecate all possible attributes from asus-wmi that were added ad-hoc
> 3. remove those in the next LTS cycle
> 
> The idea for this originates from a conversation with Mario Limonciello
> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
> 
> It is without a doubt much cleaner to use, easier to discover, and the
> API is well defined as opposed to the random clutter of attributes I had
> been placing in the platform sysfs.

This is a bit of a novel use of the fw_attributes_class and I'm not
entirely sure of what to think of this.

The fw_attributes_class API was designed for (mostly enterprise)
x86 machines where it is possible to change all BIOS settings directly
from the OS without entering the BIOS.

Here some ACPI or WMI function is present to actually enumerate all
the BIOS options (which can be set this way) and get there type.

IOW there is not a static list of options inside the driver, nor
is there special handling in the driver other then handling differences
per type.

And if a new BIOS version has new options or a different machine model
has different options then these are discovered automatically.

This new use is quite different from this. Although I do see that
at least for the attributes using WMI_STORE_INT() + WMI_SHOW_INT()
that there is quite some commonality between some of the attributes.

I see how using the existing firmware-attributes class API definition
for this, including allow tweaking this with some of the fwupd
firmware-attributes class commandline util work Mario did is a useful
thing to have.

I guess using the firmware-attributes class for this is ok, but
this _must_ not be named bioscfg, since the existing hp-bioscfg
driver is a "classic" firmware-attributes drivers enumerating all
the options through BIOS provided enumeration functions and I want
the name to make it clear that this is not that. And the Dell
implementation is called dell-wmi-sysman so lets also avoid sysman
as name.

Maybe call it "asus-bios-tunables" ?   And then if Asus actually
implements some more classic firmware-attributes enumerable interface
we can use "asus-bioscfg" for that.

Mario, Ilpo what is your opinion on this ?

Regards,

Hans




