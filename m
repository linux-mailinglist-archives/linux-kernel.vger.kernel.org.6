Return-Path: <linux-kernel+bounces-533775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E93A45E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AF83B372E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84413223327;
	Wed, 26 Feb 2025 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2UYJFhO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480C218AB2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571533; cv=none; b=htI2idrgj6/xNAcB1pej4Q8W7ORpJTalkZqwKdnp9vo49K9KoM5GFEknkNQntTW8PJbQ/cqwBb/3rIPz+KM2iw227pD2wIja1xAdDYgm29voYJyUwABBu7Itp4MmMynvYrFAQNG6exNBxKL2P05j8rQ+3O1NBRSKYAqUfqVjIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571533; c=relaxed/simple;
	bh=fP0sGdp3jpwxy/Pb8vlYK55k1s7gQsE0DIkSN6h8f5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3Qj1pTTTs+boNPKaYhfQ9x5fV1msHS9AppBMuI1Y+2q2bS6Xsj4MgWJZPhSZsOSuJNH1jksWsqVfqUXV4EQTKMxlAZAyCRzNcPbTGc7yDrHhcL9PFXfEEG5LhNpEINJoqDuWegroYtgCCs2snfyx5kVqpbWYqahzd1bEN6oWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2UYJFhO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740571530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZONKr8gjSUHK5a82Fy5e7G5ZxvpLwOBguDakYGue1KI=;
	b=R2UYJFhO8vn26680QzoxGdUjwJCieUnLqkR+l9I8Wtv/+kFqpGLyptkQGwNkJ2vMZY2b7Z
	Hj+uSCuFYBPbNnNXply559YdwVYej1yPB2s7YJL8cHpjslSHZOOnInwLorOAvbiQeBO8Nr
	J5u85QskoOI1liHVWyfDFAszEQ9mouE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-feOyFm_dPi-wB29qUW7mKw-1; Wed, 26 Feb 2025 07:05:29 -0500
X-MC-Unique: feOyFm_dPi-wB29qUW7mKw-1
X-Mimecast-MFC-AGG-ID: feOyFm_dPi-wB29qUW7mKw_1740571528
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399a5afc95so28618195e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740571528; x=1741176328;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZONKr8gjSUHK5a82Fy5e7G5ZxvpLwOBguDakYGue1KI=;
        b=TeBgRhobYcPMYNy2h5MXZd8SShdfXjpu4VhcHoLL6iHemWQECx3Um6fcSlukgoaBtN
         Uir9NkSh/lWmGzQ6lpFTvCcHP9nqTknvxZ/AMFEH62tnxLpy/caLEj9rYjhNZ2tw25/G
         ecRwN3IM9AbUWA3UicMFgFs48T3zM+we96EKfsdRm7TyyonArMFEu17rfhzRW+1WGGqU
         yfg53MmAGVu0ckhBpj6H9KBGc90Ke0I1WklcoVZHFU3mSmgOuN8/DDfmLpiZUNdSUQmC
         8lyU5DBRj/dSujaI3jvwvIlYodSRuSrn2CYDbIZnWkFT1h1YsI9fVfSZCb85Ntih+0ZS
         ZUXw==
X-Forwarded-Encrypted: i=1; AJvYcCVQszoMcvAolHpNNpMq93YGdYYL4kvPJtHF4a4r9ECvwk02B8FeEa377bh40VJpkJoWWkBQa0huAMG2n3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ZAgjOs4ElLmWcvaXugiV53J4+3WlNhybsGfu0ldTE2FSjxbi
	RmyMZY8+GTnNFLyhmykTW5m2UlYjuNrsf2VBHNXH5ccsxqr1qXSPOSG9JcM/Fi+D0KaWTNkI6VC
	oqawSdQmb6XlNKfzeHFoVz/9G2sFAZgxjXpHxZijNFrbRFqZozmzbJgl6wCq16w==
X-Gm-Gg: ASbGncuTDGYbbIhPTQrC53oWM7eCmng0zP1gzZQkvzLy1h+DIQ2R6tVwxJv+zIOzrf0
	B9mSGkgJFIN+y7i7HaKiZo2W9zo3bA00CmPXGKujEgKxNCCB6bb+rwB/VUaM9qoGcBLVJRe+4qf
	DGBHFiaMMuI2bg+A8GUSt2r3upJ13rPTMKLr9T7vK3alvHiuwkr71mfXtm0A8Qwv7uQlrG9H1tm
	Fow4qWMZGUDxsc78/9/dxeYxX54z25jeh4nXar44Tyv0cZ/2LvEcbuNFJlSCKhqUBTwBuMyt1gA
	rrk3mghRRI+M5v1s60xcVbjSpEHUU191Jnw3Vv7glGPHHXFowXKiUbmiqB0vC5PiOpbqwNCe1A=
	=
X-Received: by 2002:a05:600c:458e:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-439ae221d72mr172909835e9.29.1740571528150;
        Wed, 26 Feb 2025 04:05:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnrm0qM7DRHfCVZy3zVClFVQEZc0d79QmfHyW/xrSQhIhkvownRWDY6I4pd1YTGG105oIX1w==
X-Received: by 2002:a05:600c:458e:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-439ae221d72mr172909435e9.29.1740571527760;
        Wed, 26 Feb 2025 04:05:27 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5871f4sm19373245e9.39.2025.02.26.04.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:05:26 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Arnd Bergmann <arnd@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dummycon: only build module if there are users
In-Reply-To: <79d35e3b-9a0d-41a5-ab07-797bfa1e19cb@app.fastmail.com>
References: <20250225164436.56654-1-arnd@kernel.org>
 <4d047af3-fd30-4fa4-aa3d-c0359856d750@suse.de>
 <a2c0e681-2cdf-4dc9-82fc-be35f54ff795@app.fastmail.com>
 <29ecc7c4-2887-4989-a1d3-aa76b44c0387@suse.de>
 <79d35e3b-9a0d-41a5-ab07-797bfa1e19cb@app.fastmail.com>
Date: Wed, 26 Feb 2025 13:05:23 +0100
Message-ID: <87mse8zzb0.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

Hello Arnd,

> On Wed, Feb 26, 2025, at 09:16, Thomas Zimmermann wrote:
>> Am 26.02.25 um 08:55 schrieb Arnd Bergmann:
>> Here's another general question. vgacon and fbcon only seem usable with 
>> CONFIG_VT=y. Wouldn't it make sense to have them depend on CONFIG_VT=y? 
>> dummycon could then be implemented as part of the vt code, maybe even 
>> become a vt-internal thing. The console code is complex, so I'm probably 
>> missing something here?
>
> I think in theory one may have a system use fbcon purely to get the
> boot logo, but not actually support VT.  I had also assumed there might
> be a way to use fbcon as the console (i.e. printk) but not register
> the tty, but it looks like the console code still requires vt.
>
> After I looked at the vt and conswitchp code some more, I wonder
> if we could go the other way and instead of integrating it more
> make the conswitchp logic optional: most of the complexity here
> deals with switching between text console and fbcon dynamically,
> but having any text console support is getting very rare (vga
> on alpha/mips/x86-32, newport on mips-ip22, sti on parisc).
>
> If we do this, the conswitchp code could be merged with dummycon

This sounds like a much better approach indeed.

> in drivers/video/console, with the simpler alternative just
> calling into fbcon functions. I'm not sure if we can already drop
> vgacon from normal x86-64 distro configs, i.e. if there are cases
> that are not already covered by any of efi-earlycon, efifb,
> vga16fb, vesafb/uvesafb or a PCI DRM driver.
>

I believe vgacon is still useful for x86 with legacy BIOS, because
vesafb (and simpledrm) only works if the user defines a mode using
the vga= kernel cmdline parameter.

>     Arnd
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


