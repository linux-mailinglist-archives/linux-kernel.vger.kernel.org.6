Return-Path: <linux-kernel+bounces-394537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C83A9BB0B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83A3B236EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B1A1AF4F6;
	Mon,  4 Nov 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn9niZHu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD151AF0D9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715223; cv=none; b=eTCOpEnDtheSIST6+CcCZbIJrV7Bmv6n23nMYzYBaxY7tSmrw/9agCrfCukgHu7O6c/2sMV7/WF1cUnjBDi19GDoXQM4FOA+8nV4LlhPitSGtslwvwLkCe2pnNM0iUhhGCw/iONf0I8IeGeCnQH+WJT+gwEuCTb0FAw85GJNW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715223; c=relaxed/simple;
	bh=PTgox4e9FSSerGJRrnB4bOuIWsvK3BVoF5lju/xszuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EB/xOtxX4lrMSEmmqGdUPVD0tj+6qISE/knhcvX111DFJNFwSz385e64SjF9E4m2DAaWFxCNCNyR5yNcwdg6FwEt/YZFXRmdgtHfo2VlanANdNaRQjPy6G9eStjimywhGTBoXkTTX4n7LvCG0bA4II84r+huz40iinVYEOa3pg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mn9niZHu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730715220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGJ0ZAsOD6ODggfUDM3kNDHwIHDU79YqayeKJjeKiv8=;
	b=Mn9niZHu6DkNESHJKU5+0Oe7ow3XZcBmhPVyGZVuW0S45SBqDbjZ5CARYtXLsgd30A24F9
	kaRJ0KfXOwzQ/3gPjc28FsI848FYduSm6JCYgEBdjZA03T3sRHgTevV631CsTi3B5uG1tr
	fhjC8NevEbvkbxwzCQ8ap5Mcgnd0iHA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Badu_ilsPo-BbjJM2yE6jA-1; Mon, 04 Nov 2024 05:13:39 -0500
X-MC-Unique: Badu_ilsPo-BbjJM2yE6jA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a1b872d8bso291126066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730715218; x=1731320018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGJ0ZAsOD6ODggfUDM3kNDHwIHDU79YqayeKJjeKiv8=;
        b=CaSEkPd8SNoMYkouoURb5TuUJvCZLTdiff6WDOGtFuYqw7PqXp8fwPWZXr5v8JzDXd
         mHHPrQFR9x7AVlVDbJuWJ9Rh1kiTtGXgwhW3w+8eCBxiWkqQHr1dI1pYWRfT0B53iKd2
         nECllcqclZY7UoaWlrAOIGX/44C3ZMxQlJj6L1C0wfPU26IlJk5i/aiFTsvZAA04fQFW
         2E+W+3qRUgmqgVytKxxMBmU0gdnC4Te+PlaA9NDapgNGpQ7u4h1OUXdMnbOUuHowLpjF
         MVHSeD2io0NOnz/HkP6MkqC7c4EWFhoxSuRjX4km4KaqIYJzdZHgihZgnANjiWXUiFXd
         xNvA==
X-Forwarded-Encrypted: i=1; AJvYcCVkChkFlbfsGWZq/ViWqb9RnP+eID3wVXJAHcJGamY4mfiXT6+i6i8O0rGRk+vxlXzqbvPFM0xgrekJXw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNCqnOp3wu3Na7kan3VyfFjOvYjXO7gxVrpl7XCWjGxCIZlwk
	nEeHMHVECaermr5/yjh5gHXv0UIxI1eDG5szhBRAFmFx70JJNzoPqF+jef+I/6lro+ccFRQUSb3
	yF2jA4JkzN0SlxqGsC6beQZfAdXlk1T1BvRlfF56h2EuRtWrzHQTw4KC1fhPVvg==
X-Received: by 2002:a17:907:6e94:b0:a9a:67aa:31f5 with SMTP id a640c23a62f3a-a9e508aaa56mr1498409566b.10.1730715218346;
        Mon, 04 Nov 2024 02:13:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOmlFQ0C8DWcquNm6+JN7DJdW4bYk/a7WmMMRlzVpP2U9cmDUiA6/Y87bCbHqpOWtgvnyTMg==
X-Received: by 2002:a17:907:6e94:b0:a9a:67aa:31f5 with SMTP id a640c23a62f3a-a9e508aaa56mr1498406466b.10.1730715217668;
        Mon, 04 Nov 2024 02:13:37 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c574asm536889466b.60.2024.11.04.02.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 02:13:37 -0800 (PST)
Message-ID: <4dc23457-e70a-4dfa-880b-ca1c3f6c362b@redhat.com>
Date: Mon, 4 Nov 2024 11:13:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dell-smbios-base: Extends support to Alienware
 products
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, pali@kernel.org,
 platform-driver-x86@vger.kernel.org, w_armin@gmx.de
References: <20241031154023.6149-2-kuurtb@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241031154023.6149-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 31-Oct-24 4:40 PM, Kurt Borja wrote:
> Fixes the following error:
> 
> dell_smbios: Unable to run on non-Dell system
> 
> Which is triggered after dell-wmi driver fails to initialize on
> Alienware systems, as it depends on dell-smbios.
> 
> This effectively extends dell-wmi, dell-smbios and dcdbas support to
> Alienware devices, that might share some features of the SMBIOS intereface
> calling interface with other Dell products.
> 
> Tested on an Alienware X15 R1.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Thank you for your patches, I've applied both patches to
my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note they will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include these patches in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans

>
> ---
> v2:
>  - Commit message reflects Alienware devices may not necessarily support
>    the SMBIOS interface
>  - Commit message now has "Tested on"
> ---
>  drivers/platform/x86/dell/dell-smbios-base.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index 73e41eb69..01c72b91a 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -576,6 +576,7 @@ static int __init dell_smbios_init(void)
>  	int ret, wmi, smm;
>  
>  	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
>  	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
>  		pr_err("Unable to run on non-Dell system\n");
>  		return -ENODEV;


