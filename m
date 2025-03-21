Return-Path: <linux-kernel+bounces-570650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092AAA6B2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DA01893089
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D81E0E00;
	Fri, 21 Mar 2025 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="G7VBacue"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43531876
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524396; cv=none; b=THud+0uhrhCZ45y9Ems7Q33IpYIBg7majk7iTMp9IcTNU0ccWfNhtWiyxduiws8kvJeoji84xJRtsR33XiKNdonGy1T0FXhiCUnM4m+DhJnHJRrFVW1HEjkU0I+wqWZHqQTztbT0i3ijP0sVDoo/snRC4XdLyNJG1CoarzgBW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524396; c=relaxed/simple;
	bh=fh8/hKnhmAdMmulO3dOA/fUcq3ROAQN7CvfWvXaT2R0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7zohtygyL82h1NqOWOng7ZhuU9DcYJAkHBcn5ZSEdNi+LNSdKA08Wk7Y+9NYcC//Qc/Ubq61F39spBkYSUplyKuDlssekm6S2gPdzhuxP2A05uVJd6H5apDqrmflv4sYuc5klEy8i7K5EPYCgoWpvCEwkkFkpYNUTD9n/FHiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=G7VBacue; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4710C3FCC7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742524384;
	bh=yGdWxK9JVirSn2lLRI6kllOEuz1GJUXaDgPsY8xB3Nc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=G7VBacueHBf7j1V+0EYTbxRmcoJVUOtLDBFxh7oxQUuXALmXATwit/UKk2JCWP28f
	 2FFDnP/rLydtR+c3GjyelhnD48WAbIUIvtik14Qs5Ptg390ButZ+IM3njY6filITA8
	 9zjvnGCCaPlnLWDTwMfxhGMAUiZIn2XDrCxj2rEchGKoPHRkjqLs5blM8hzRXX+eaR
	 2sI2Kcc6lCjOtsNJWgsELyFSUT2o1ggZl/Hss8gcqsRSc/MNySINWf0vd3oF78cBuL
	 BgyB5Q19bgZ+MW7npzq9MD526XXIJUQ/KgWHBvTB+zdMzIdP1Ps3PEaTz9OPaYF22m
	 hdS0kPStG1QAw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22403329f9eso19311605ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742524383; x=1743129183;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGdWxK9JVirSn2lLRI6kllOEuz1GJUXaDgPsY8xB3Nc=;
        b=iylGNwB8alOlBmxDlhdDGqc8ulbINildwijAFdgpFPw7O+zZzz7VpBi79kaN4rBdhe
         8X5nKQWoW5/OFTTHJjJ5oRpVrXX36yOjpiZLlboyZY4D3k6SO/dtsU7xTkJustgzLWio
         39dTbcfRLSxOlxfdZ1RIZSc2KE90Bivaq9xlowSC8tzFplRC7HTDbbYpjMwPB93rR0Ch
         EZLtDFsBrrezdjNyhjVzDvfqrwKU2rho2Amidft9XHsj9Tu9KxSb7M8EUiGkLPSe9Y1m
         uYIxpIrtf0PyzeMfGLjOi+pyQ5tHQz6suBxoExhfiwo7bx23ZCsVgQQw6tePWKbJKAgQ
         vWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6yPsIKjFACtLxckjdLNxSgZXbo+uZB37w0IA9lSrfv+0Svq/xrQ89IQPcVG6BTuAa+wkGlRLTkeyggYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnKR3Ic5I+iVhrxYhUd74gldP7bTqRd2149sFgasRJwToiRSZ
	W3D4gWtA8tKZRYqpEyizl9TW8FaPPybjsVgkF5e4zmrPg7BDV+uVpq9LO3Lhv5odJD+XBUmIMcO
	xZhxrGbPyJwtSAV8EGcdq9zRFZmaQ6MI/b/2qn5z2D9TKOrO1HNNzjxNWq95HA2N4iUrybwLIA0
	psnA==
X-Gm-Gg: ASbGncvFd/6+TkhGzuIHNTm3msefYpF6ewYTyVKlwaXv2XvIPqHuUn+/frHchUfUFhz
	sHwyJ9EU8FxEwGrNgpfKtJKpXrMOPrXswqzFId9J6AUIbl1yARCcZeFhXeWZnIG4ZgtCr7B9n9t
	SCzgpBgql5+Xx2ENvsuYg2Ggru+xmAw41ZA7/xm3sRG2rGihrkbZ/N7qo15k9fCW0+ttsnh7Fzu
	X9FkHeVT9FRbPQXQ7Ion7uo1mXoLelW1MHueqbsUx+CYadBhLkLS9Ql4KX+ubkHyR6uAVDZG9I3
	RffO71xaDPw0gRdi+vrynFVOxP3L7eCJUbKSNs+gzw+nG+GfnRy2FXtEBffKGm+FuPM=
X-Received: by 2002:a17:902:e78f:b0:224:c46:d162 with SMTP id d9443c01a7336-22780c7bfecmr26407565ad.20.1742524382842;
        Thu, 20 Mar 2025 19:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGOUGS7kWShHwzPKCmuY0RVOFosLtvfv77lN3gqgOkwEjIa7sd9qLWWEZv2O+6vYApUGXhmw==
X-Received: by 2002:a17:902:e78f:b0:224:c46:d162 with SMTP id d9443c01a7336-22780c7bfecmr26407305ad.20.1742524382384;
        Thu, 20 Mar 2025 19:33:02 -0700 (PDT)
Received: from acelan-precision5470 (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f39692sm5535345ad.44.2025.03.20.19.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:33:01 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:32:57 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: Add quirk for another Chicony Electronics
 HP 5MP Camera
Message-ID: <sgvhxwvrylxdev77hb4hlfcviopljj3i64vempkxaigioyvcki@2fgjvotmp6d4>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321022540.4016923-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321022540.4016923-1-acelan.kao@canonical.com>

On Fri, Mar 21, 2025 at 10:25:40AM +0800, Chia-Lin Kao (AceLan) wrote:
> The Chicony Electronics HP 5MP Camera (USB ID 04F2:B824) reports a HID
> sensor interface that is not actually implemented. Attempting to access
> this non-functional sensor via iio_info causes system hangs as runtime PM
> tries to wake up an unresponsive sensor.
> 
> Add this device to the HID ignore list since the sensor interface is
> non-functional by design and should not be exposed to userspace.
We found another Chicony device with the same issue.
Please apply this patch after the previous submitted one.
Thanks.

https://lore.kernel.org/lkml/20250312063532.551938-1-acelan.kao@canonical.com/T/
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  drivers/hid/hid-ids.h    | 1 +
>  drivers/hid/hid-quirks.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5fdea9116a3e..554dbed3f3ed 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -298,6 +298,7 @@
>  #define USB_DEVICE_ID_CHICONY_TOSHIBA_WT10A	0x1408
>  #define USB_DEVICE_ID_CHICONY_ACER_SWITCH12	0x1421
>  #define USB_DEVICE_ID_CHICONY_HP_5MB_CAMERA	0xb82c
> +#define USB_DEVICE_ID_CHICONY_HP_5MB_CAMERA2	0xb824
>  
>  #define USB_VENDOR_ID_CHUNGHWAT		0x2247
>  #define USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH	0x0001
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 452fac15550b..91b3d121bb1f 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -371,6 +371,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_ACER_SWITCH12) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_HP_5MB_CAMERA) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_HP_5MB_CAMERA2) },
>  #endif
>  #if IS_ENABLED(CONFIG_HID_CMEDIA)
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM6533) },
> -- 
> 2.43.0

