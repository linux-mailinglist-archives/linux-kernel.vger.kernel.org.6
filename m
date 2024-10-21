Return-Path: <linux-kernel+bounces-374562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE959A6BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FCC1C218DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3630F1F6678;
	Mon, 21 Oct 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNhjfg+j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D61E0E0E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520601; cv=none; b=BIcbvhjU766Vg6MPOAz8ygAh1j1v8l32gEutL4hNzut5zek+gnXdMbt2FkNo5Hu58a/s2d52V3iLRRs2QmmUyqVb+/Z86pKO7S4klYVRH/oen8bmJrbX/OguYtpX+eaOCFDoyUY2K4TJxJ+i3AhhF7+xzD5xipnFLOBqNeWVz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520601; c=relaxed/simple;
	bh=HPoTI4wfBNW7mlNWtn/TpUsjOkIC7PizoJKkN5K4VeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYFYaQkpW0nj4y8nOj6XmdWev0h9pJHZX7+lIS0cGMoaMe2P2Ncx4iotI3UlPchsjKuDsah+wX18XcQlIURjgLAAX1N4nZMT+isDnNl30+b1BFPTdOJDF0YOsPcX36mrQeqGCffpwVWBsz8iNezTq02v7lZtPwwUCvjqSdJTRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNhjfg+j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729520598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45kL1DgBIGNDWwId+Q2AQnmJdYSSdQR/WS6d8E/wgHk=;
	b=FNhjfg+joUlio12ekW6ltNZTLZ6az42EVZOXT3zqy1+OQQKaeBcIwxWsCp3S+X95gmsREc
	wQttcpF3PHbtfMIBY8CwCo/vSyf5r2elOXyD2ZeiLU4fu30hra+s/9Ebs23s7Cn8YTb39j
	AotaAt09PubyDZeJQSLUVWMTPUvkZbo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-YeJvLWr8NZGJ_P8Ieg_Bwg-1; Mon, 21 Oct 2024 10:23:17 -0400
X-MC-Unique: YeJvLWr8NZGJ_P8Ieg_Bwg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2fb44181f04so27005811fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729520596; x=1730125396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45kL1DgBIGNDWwId+Q2AQnmJdYSSdQR/WS6d8E/wgHk=;
        b=f1EOVx4l+WRtEvm9HEVyeoFybh+i0v6s4+AfF3uYlRootPYFvSjtbVmHKJCtiKkYji
         PGq/Yso9YTNeQnkMM926Mk6px9s9LKE1gyU4rkHIoVs6aaQOZyk6ZoGr6gOaUbIJvNmH
         oWHCIjTZpXURspq+42xe7e/B7CsUG9/gxplMS1maTXCN/k0sgpQgyHkivD6vbqGoxVot
         VUB11QVpX4qKewa3GkBW+H+F9qwgYCGiVjh/mmntASLsPJ5W1a86raTrUXLjHwc3M64/
         +aRTHzeta/KZQKv5yjLd2oPgSYs+67IClNNgfKXlAo5mmkyul/BY8Xs7wCc5G/MkvO2O
         kMZg==
X-Forwarded-Encrypted: i=1; AJvYcCXsjg+2NGKoWWxt/qRuq39kiUz2yzOXgDVnOiYatXDxTD/HYHRM5UkcPAvdwxcmfLCkmPwwoOIAUYpRssQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ofHCf9emwk8ZHrMiHnzSGMDwFbEP24/3/gvZdZ6fxazJmz9R
	W6d2ZLrMXOdLLV0uUeBxfXoAxnm5SMN4WoOtSEOa4UIMPOijz8f7bVAwXyTVcYKfVWx9TMWGTOr
	JazoJMru2ldKjpVhRxM9D5q2CH3HGYAcaNLOldpN1g3M9vzu4jbqwg3qazWtjadn3kCsYVHa5
X-Received: by 2002:a2e:b04d:0:b0:2fb:411e:d979 with SMTP id 38308e7fff4ca-2fb831e6cb9mr43476691fa.31.1729520595600;
        Mon, 21 Oct 2024 07:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2XIDzdCLYKaFR5S8qkVFM9Oys5/ZSPG7zKV8k4dZvGRurypxE4/MiOXmNLCASYpED62iHAA==
X-Received: by 2002:a2e:b04d:0:b0:2fb:411e:d979 with SMTP id 38308e7fff4ca-2fb831e6cb9mr43476501fa.31.1729520595051;
        Mon, 21 Oct 2024 07:23:15 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c72757sm1980539a12.92.2024.10.21.07.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:23:14 -0700 (PDT)
Message-ID: <40a76a97-b3e4-42cb-bee2-ca54731cc8ef@redhat.com>
Date: Mon, 21 Oct 2024 16:23:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-wmi: Ignore suspend notifications
To: Armin Wolf <W_Armin@gmx.de>, pali@kernel.org
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, siddharth.manthan@gmail.com
References: <20241014220529.397390-1-W_Armin@gmx.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241014220529.397390-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 15-Oct-24 12:05 AM, Armin Wolf wrote:
> Some machines like the Dell G15 5155 emit WMI events when
> suspending/resuming. Ignore those WMI events.
> 
> Tested-by: siddharth.manthan@gmail.com
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
> For some reason mjg59@srcf.ucam.org causes a local error in processing.
> ---
>  drivers/platform/x86/dell/dell-wmi-base.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> index 502783a7adb1..24fd7ffadda9 100644
> --- a/drivers/platform/x86/dell/dell-wmi-base.c
> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> @@ -264,6 +264,15 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
>  	/*Speaker Mute*/
>  	{ KE_KEY, 0x109, { KEY_MUTE} },
> 
> +	/* S2Idle screen off */
> +	{ KE_IGNORE, 0x120, { KEY_RESERVED }},
> +
> +	/* Leaving S4 or S2Idle suspend */
> +	{ KE_IGNORE, 0x130, { KEY_RESERVED }},
> +
> +	/* Entering S2Idle suspend */
> +	{ KE_IGNORE, 0x140, { KEY_RESERVED }},
> +
>  	/* Mic mute */
>  	{ KE_KEY, 0x150, { KEY_MICMUTE } },
> 
> --
> 2.39.5
> 


