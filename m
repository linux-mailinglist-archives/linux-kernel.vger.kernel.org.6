Return-Path: <linux-kernel+bounces-561086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20312A60D64
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689763BBCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329A81E9B37;
	Fri, 14 Mar 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tp2MxNfo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE001EB187
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944885; cv=none; b=LypYRAtsS0QK/sUpbGjta8lNzyJON37Xmr/tUiGV0kMIsjsQfVz68o4mSOLvxBvecmxI4PzNgU0/BNLWn+VsNHnNwgj4R5tks/oCWl0UjerYyhEZwaQVSMnahob06vXO/AMykcOBVwaqEx2tuDbHwRj+xPK62n5DawrWFowyUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944885; c=relaxed/simple;
	bh=/QHGyNTxkBGYmNxvkaV7Ph8WtB7cBiAo9r7H7Fk9QrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fI0RfkGcIGmSvcf8WT50U3xveREOTo2G+NlWiClQyguaGP5KDnfW9NpSQu7jcyNAh0gR2+ppmQbXXPaBqtB+VkUXzRjI9kuzlTWdStY8sdjTz4FEZ+MR4sOeGjO/Fs53nAjCEeLVznK3875ZK+d0bdDYUP4LITefAVqGO+tM/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tp2MxNfo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741944882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8xq5quBupqWX+TKt9jL3mL8tzKVIibeaTozXMKawhk=;
	b=Tp2MxNfoI0Ysneww18BLvgh5QKe/4VCuBP01X0cjpYhr6Bw4xqr5p/KBOIhgV3V4JfmH2N
	jEuRiH/oR0j+LWp0nBQS+c9fqhIll1DezK3fwUg7uSwIOH5x6NPgJrMkFhk1LPJ/lPOgfa
	0yIn6mlRGXTZ5PxMvLg7Idn14AMApdo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-0LkdxIcWND2QIX7J0l0gJA-1; Fri, 14 Mar 2025 05:34:41 -0400
X-MC-Unique: 0LkdxIcWND2QIX7J0l0gJA-1
X-Mimecast-MFC-AGG-ID: 0LkdxIcWND2QIX7J0l0gJA_1741944880
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e5d8a28de7so1975525a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944880; x=1742549680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8xq5quBupqWX+TKt9jL3mL8tzKVIibeaTozXMKawhk=;
        b=hTbHm+CKQg9rN3Uc5VRaFihYZef//F/Y7735KOIQWuJBNYCmZSYmfqZMXRjFU1wJEm
         1kzsNJRsUcgoNA6/O7VfpvbfVlRXjZrSUs3juKZrEHI/1Sn1iQ7M7WfX5MnFKA8v8ddh
         PmcHrTL8bhilVwQ8A9YvKbW1eVtGfOAGb8ABO5rh8e6qEJDhY4UNB49/oy2kIZXo33M/
         axGaE8PQjMaIUlwfnfwmyXHRHDfXLDUCG1LSxnVwur/RLmOH161LQj72APGBhd3a8SXE
         vCUqZ14/kD1FAPtVxer2nqggZPBvHxQmbF67QqQszZv3QKEHzilIkJhM3EfJxy48rE85
         T2EA==
X-Gm-Message-State: AOJu0YyKAidZfjl3nTykAUiiT+XO8/3qou8syeCD1kGZIf2zsD/D8cHf
	V34mjFdV2Bgm5PJmSLYTUZzRvTDz0lPI4pHNiW15RLW/KUi83UPPPtnPKD0N9zPaZ5Sb5nNNyhq
	LDSYdSqCu2FaXBl6Q6KkWAJCWUBliLEan4E8Hffd7BXrL9qvpiODD61EwDgpRlQ==
X-Gm-Gg: ASbGnctor1WZOGlGjdu3gXlxG94YeB4HVdDe8PRSeyIJHImO0vv7pRYLXbT25K4Scj6
	7KObMIie9NN3S8Oy+gehJg6tuKFyVuW2K2w3jGhAPXn2ZBXNS4lm5Y04pBcj4ItmCkTAej0BeCe
	Z9BjhyhxyVeaKZgtjQ/K9ePTi3MPNW6KL+8LsnpZJIsgnQBYjVfxt9PInR5Fb9HhdHyj2TdOALU
	GKmaOEwlyjdI2U3bk1Zfgr8gmA+HVtgBS+b5E+iI8R3cKAFxQONOZdMYQbNrJ0Qt5fgoD7tTuis
	3uNaDVPD+AH/oo9ZRlVXGZgT7gvTPie8k8TaUUYCT9EWUK/A6SuYyrz4Svl37gv3au/1KthguAe
	6XduXEAjSskeVtnrEM097N6664CdSL3U27ig/VHGo6iuROWw5Ipfj5zLzfyDX9LmXcA==
X-Received: by 2002:a05:6402:5186:b0:5de:39fd:b2f5 with SMTP id 4fb4d7f45d1cf-5e89e6b0197mr1954917a12.1.1741944880045;
        Fri, 14 Mar 2025 02:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpliGVYSifHjurmVbgm/VmWpvbgqgAQYjQGwczC1Nf1XUS4HyN4u1bKDnD5mrJoxrR0ct+mA==
X-Received: by 2002:a05:6402:5186:b0:5de:39fd:b2f5 with SMTP id 4fb4d7f45d1cf-5e89e6b0197mr1954881a12.1.1741944879441;
        Fri, 14 Mar 2025 02:34:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad3921sm1792779a12.61.2025.03.14.02.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 02:34:38 -0700 (PDT)
Message-ID: <4970c2cd-9637-460a-8e85-bc44f7b0a550@redhat.com>
Date: Fri, 14 Mar 2025 10:34:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixed ideapad-laptop driver to support Yoga 9 2 in 1
 14imh9 unknown keys
To: =?UTF-8?Q?Ga=C5=A1per_Nemgar?= <gasper.nemgar@gmail.com>,
 ike.pan@canonical.com
Cc: linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <20250313151744.34010-1-gasper.nemgar@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250313151744.34010-1-gasper.nemgar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gašper,

Thank you for your patch. 

First if all a few generic notes:

1. When sending out v2 of the patch please add
   platform-driver-x86@vger.kernel.org to the Cc

2. The patch subject (first line of commit message) should have
   a prefix describing the subsystem + driver, e.g. use:
   "platform/x86: ideapad-laptop: Add a few new keymap entries"

3. Your patch is missing a signed-off-by, see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

4. Your commit message / patch should also have a body, e.g.
   the entirety of the commit message could look something like this:

-- begin --
platform/x86: ideapad-laptop: Add a few new keymap entries

The Yoga 9 2 in 1 14imh9 introduces 4 new hotkeys which are not
yet in ideapad_keymap[], add entries to map these keys.

Signed-off-by: Gašper Nemgar <your-email-here>
-- end --

A few more specific remarks below based on looking at
this picture of the keyboard:

https://ardes.bg/uploads/original/lenovo-yoga-9-2-in-1-14-g9-550178.jpg

On 13-Mar-25 4:17 PM, Gašper Nemgar wrote:
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 30bd366d7..af124aafe 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1308,6 +1308,14 @@ static const struct key_entry ideapad_keymap[] = {
>  	/* Specific to some newer models */
>  	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
>  	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
> +	/*Star- (User Asignable Key)*/
> +	{ KE_KEY,	0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },

Ack.

> +	/*Eye*/
> +	{ KE_KEY,	0x45 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },

It looks like the laptop already does display-toggle as Fn-F7 although
it like sends super + P for this (AKA meta + P).

So mapping this to KEY_DISPLAYTOGGLE seems wrong, what does this
do under Windows?

Maybe KEY_ZOOM ?

> +	/*Performance*/
> +	{ KE_KEY,	0x3d | IDEAPAD_WMI_KEY, { KEY_SPORT } },

I think that instead of mapping this it should be handled specially
and call platform_profile_cycle() instead of sending a key-press
to userspace

> +	/*shift + prtsc*/
> +	{ KE_KEY,	0x2d | IDEAPAD_WMI_KEY, { KEY_PROG3 } },

Looking a the symbol on the keyboard this should send
KEY_SELECTIVE_SCREENSHOT

>  
>  	{ KE_END },
>  };
> 

Regards,

Hans



