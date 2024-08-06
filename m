Return-Path: <linux-kernel+bounces-275938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECABB948C35
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2925283AE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D06516C69A;
	Tue,  6 Aug 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2mITSr5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720114D70B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936868; cv=none; b=Pkt3XnX3ju8vVytTN+oMm8q7loI1JUozr3kGo/iWSb2qpPG4JKDQOlsW4KS6s5u9lYgrP6zNTtM2c4zfz7QMJFi/chPDEv98xdyTqJe1AdDoGiP5slznPS/Rl8pRP+F+xfQ+h1xWcaamxksVMh/GUFgufaJDVSVhwogZza6wyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936868; c=relaxed/simple;
	bh=ezIZa+SGim0HsdafsDPubDccuBC+e82Zv1jaF//tGaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0AiZ2V8PRWbOcGeiSnEynCkVqw97I1qQ/q0LUj1ipOqNSsBQbK5bAWG9iFlSVGyz9h9A8XqwWZiXACYI57NdwnCzqxAMuvc1HJ7HZIfyO8idQDInaXB1nWP8tOZwolS/DMN6e1WeyUkeFl1T10ol8MhSHOaB7rEAKP38a4r1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2mITSr5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722936866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/mZOK2Acfhq1mHKEIENCFyI9POxKfWEgNkeRverf7Q=;
	b=Z2mITSr5TyrgvO7i+THph/+/756z7DftpBpEYu2yfhn4ZvC32Zr43n+eY+7fYAg2QI2fkP
	CDASBl/bWm2jgvhkpV90Kk6BRjZcodSwW0ttaWxT40FMRo3ewVpq9LIsMc7ZrhVQYWrmN7
	0memvERiziNCx25xr4pYYc/Lmti5WIc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-WoLgGI0ZMKOwRflfskDtYA-1; Tue, 06 Aug 2024 05:34:25 -0400
X-MC-Unique: WoLgGI0ZMKOwRflfskDtYA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7abee2b4b0so32087666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722936864; x=1723541664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/mZOK2Acfhq1mHKEIENCFyI9POxKfWEgNkeRverf7Q=;
        b=SlxHIOYqiljRVOrmDbtfGWlPDJBKWAy9muxj33rs7V/qEMfz7+f+al/gXRFuiIukro
         msTnWgJXiwbmZwNRMOgVw7WaKqB/k0Xsi0bWM0A161dSO9gZfUdJk2jYwdEiFmvH7ZRh
         00W1yKpXxZhqxOzs9iuBRelF26F3Q6hani7eSm42j0ClvVfACPyEV/FF2BRch1OjR+ZP
         XKeC8hykxee60IJN3OlNWO1IMCamSB4ZY6KEAz4wC4Ctb6ekz3Of7VIveXbGiKDu5Y3E
         cf/5x4YEh6O6ismgtrD1K40vV4eEfaXdmt6FCkxcNfQEE4HUD0KRWBco5WcIjiwkiJ9/
         k76Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7kIhDfVMqgQF63VkbfW+eT/+U0NMdpwLi2rNA0aAz21nxsMmmjYxKbR1l7TScTxGsX8AWQlfC2+4xsFpAACVY+IB5LhMzAbDzCcEv
X-Gm-Message-State: AOJu0YyapdbqIcQRWnNAKWU49vbAC1QNVyvqX05yGi/S2pfec+fiHyG7
	Bix3v9oIgiuvwfgkg4y+WHthX7YPsqCvGX4a0pKb2srTnMOkA62nPIb3srtSf6Nmn1CbYeAiZ47
	d8ZzKsau3dsB4aiP0Dtfd5LwwnOEph69AjEXhX1IvMRqOM27c7ij6RkoaIPoQ8w==
X-Received: by 2002:a17:907:3e94:b0:a77:da14:8409 with SMTP id a640c23a62f3a-a7dc5098872mr1017509266b.48.1722936863645;
        Tue, 06 Aug 2024 02:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8RczngD6jvnwd8RGPtWVtBq5IevuWHaI5+qZSMZJouO8g2r/vOVM+ZMf/ISoJ/EPz9CZQgw==
X-Received: by 2002:a17:907:3e94:b0:a77:da14:8409 with SMTP id a640c23a62f3a-a7dc5098872mr1017507866b.48.1722936863000;
        Tue, 06 Aug 2024 02:34:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0f8d2sm532682966b.46.2024.08.06.02.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 02:34:22 -0700 (PDT)
Message-ID: <55756822-4eb8-419e-ae57-655caa70edd9@redhat.com>
Date: Tue, 6 Aug 2024 11:34:21 +0200
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
 <517aa9f5-00cf-4a68-b1d7-a6dc9f942e7c@redhat.com>
 <a35c923e-be2c-4083-8c65-c83b49fe4350@app.fastmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a35c923e-be2c-4083-8c65-c83b49fe4350@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/5/24 11:41 PM, Luke Jones wrote:
> On Tue, 6 Aug 2024, at 3:18 AM, Hans de Goede wrote:
>> Hi Luke,
>>
>> On 7/17/24 4:34 AM, Luke Jones wrote:
>>> On Wed, 17 Jul 2024, at 3:11 AM, Ilpo Järvinen wrote:
>>>> On Tue, 16 Jul 2024, Hans de Goede wrote:
>>>>> On 7/16/24 7:16 AM, Luke D. Jones wrote:
>>>>>> This is the first major patch I've ever done with the intention of
>>>>>> introducing a new module, so it's highly likely I've made some mistakes
>>>>>> or misunderstood something.
>>>>>>
>>>>>> TL;DR:
>>>>>> 1. introduce new module to contain bios attributes, using fw_attributes_class
>>>>>> 2. deprecate all possible attributes from asus-wmi that were added ad-hoc
>>>>>> 3. remove those in the next LTS cycle
>>>>>>
>>>>>> The idea for this originates from a conversation with Mario Limonciello
>>>>>> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
>>>>>>
>>>>>> It is without a doubt much cleaner to use, easier to discover, and the
>>>>>> API is well defined as opposed to the random clutter of attributes I had
>>>>>> been placing in the platform sysfs.
>>>>>
>>>>> This is a bit of a novel use of the fw_attributes_class and I'm not
>>>>> entirely sure of what to think of this.
>>>>>
>>>>> The fw_attributes_class API was designed for (mostly enterprise)
>>>>> x86 machines where it is possible to change all BIOS settings directly
>>>>> from the OS without entering the BIOS.
>>>>>
>>>>> Here some ACPI or WMI function is present to actually enumerate all
>>>>> the BIOS options (which can be set this way) and get there type.
>>>>>
>>>>> IOW there is not a static list of options inside the driver, nor
>>>>> is there special handling in the driver other then handling differences
>>>>> per type.
>>>>>
>>>>> And if a new BIOS version has new options or a different machine model
>>>>> has different options then these are discovered automatically.
>>>>>
>>>>> This new use is quite different from this. Although I do see that
>>>>> at least for the attributes using WMI_STORE_INT() + WMI_SHOW_INT()
>>>>> that there is quite some commonality between some of the attributes.
>>>>>
>>>>> I see how using the existing firmware-attributes class API definition
>>>>> for this, including allow tweaking this with some of the fwupd
>>>>> firmware-attributes class commandline util work Mario did is a useful
>>>>> thing to have.
>>>>>
>>>>> I guess using the firmware-attributes class for this is ok, but
>>>>> this _must_ not be named bioscfg, since the existing hp-bioscfg
>>>>> driver is a "classic" firmware-attributes drivers enumerating all
>>>>> the options through BIOS provided enumeration functions and I want
>>>>> the name to make it clear that this is not that. And the Dell
>>>>> implementation is called dell-wmi-sysman so lets also avoid sysman
>>>>> as name.
>>>>>
>>>>> Maybe call it "asus-bios-tunables" ?   And then if Asus actually
>>>>> implements some more classic firmware-attributes enumerable interface
>>>>> we can use "asus-bioscfg" for that.
>>>>>
>>>>> Mario, Ilpo what is your opinion on this ?
>>>>
>>>> What you suggested sounds good to me.
>>>
>>> Thanks guys. I think there might be a few names that could be suitable
>>>
>>> 1. asus_bios_tuning/tunables
>>> 2. asus_fw_tuning/tunables
>>> 3. asus_fw_settings
>>> 4. asus_armoury
>>>
>>> I'm shying away from the "tuning/tunables" label since there are also a lot of settings which are just toggles for various features rather than actual tunable things. It makes sense in some contexts at least.
>>>
>>> Armoury Crate is the software collection that Asus uses for the gaming laptops, and they tend to lump these settings under that label.
>>>
>>> Personally I'm leaning towards "asus_fw_settings" as it more accurately describes what the module does.
>>
>> "asus_fw_settings" sounds good to me. I'm looking forward to v2 of this series.
> 
> I've actually done a poll on my discord, folks voted overwhelmingly for `asus-armoury` and I went with this before your response. The reasoning here is that many of these users are coming from windows where Armoury Crate is an app that exposes all the same functions and so that's what they look for on linux.
> 
> If you don't think this is suitable I'm happy to change.

asus-armoury works for me, I like that that name makes it clear that this
is not changing BIOS settings like other firmware_attributes class devices
are doing.

So asus-armoury it is.

Regards,

Hans




> 
>> Regards,
>>
>> Hans
>>
>>
>>
> 


