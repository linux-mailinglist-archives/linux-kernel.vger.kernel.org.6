Return-Path: <linux-kernel+bounces-190175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C98CFA97
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FE7281A47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4F839AD6;
	Mon, 27 May 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="af4ADy7j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C432E40E
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796433; cv=none; b=swUNzdC/4WgQ/7dbcaXzOITl2CHxdX1GUV3XNg6uiAOpS7bgvY/xDLrC4uCNKsFL/pgXA/eWDVWj9TmNXDNj5L3sKntYgxEFwftZtCIDGo7+PmivE9MOb1TopSliuHMI9SNWrljiEZ1CBN40hyA1tD0Bt+NExtCYCdtM/N7mirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796433; c=relaxed/simple;
	bh=AWDlsUuU3fzJ88Pnde1vxfBNUMwQ9EQS+ojm3Zkxj0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skoD3gb9m6zzVdSBwjCCqtwvU82FUNCm65MFZiWOwA9fGl5cw8Ju0O7Uv4t4DoTV/5BFjNZ5iQ1D3hCUyyjm70EpSQsLk41UTCzreRyCRgUVF9LtYlBKf1KIv/xKKtSYk8z5u3MdNt3o6fxgi/axMLLV6xUY2hryAHBW7p0S238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=af4ADy7j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716796431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJjt/5eGKxcl58g00wlGk6b60hoVQeRf0JP1mWdixGc=;
	b=af4ADy7jVB7V5Qu2lnN2gVEVOagguWmhe4vm8DcivckyaiMSHi4TLnt1WtOWdkm5ZXY4Cz
	XT8zWrjTuHUtG3pYLSYKzmaLwTnIoxsP4D24R7qr1n9pTy4+Vg1b1x0tohmq5WRYTneqTy
	w6HkxVPNoHrkZZOthg8hHFE074x97DE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-8ZmvauevOOCbRxErjhi0Mw-1; Mon, 27 May 2024 03:53:47 -0400
X-MC-Unique: 8ZmvauevOOCbRxErjhi0Mw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5798d7ed735so664575a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716796426; x=1717401226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJjt/5eGKxcl58g00wlGk6b60hoVQeRf0JP1mWdixGc=;
        b=jYuydropryf8TvtePea7CrY6ONuwLB167LzJvk/P0cKrRCDZA4HBfOy8+lm+G1y83/
         OI0qhK6bWgSOaQFKrhF3VrtzhZObOjRcPu3ljUojINsa7u8k2SJGBYTsHWR9FRsR6q7I
         a6tzu3n/0mSRhzIzfRa58vHqM4q5kf0KIytyp7FFjqBefB4hIyPflPjW3dNz/9lCvJBC
         ZzUEMW0QqHMPoG6DusDQGDbCkSs7dfQ4vB//g7aFQUElSH7Yb4SylZwbIKZ4863v+cch
         kE7HUSRx7RGrCrnidVOm/CnnD1GZ7BZfh8WPU5DL0kKgyEcic+86Id4ozsvxsVh1RxHQ
         /ieQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMbsFu0tMZwxch2pXCO++r1cfPgh4fM+3VttUkcr5kA6hUvUMYxaAlidgwov02QbL9eyDgUPeTaGgEMFqL3uolxfLwUinMJ/l4TUaz
X-Gm-Message-State: AOJu0YzFUHlJy5IMOR/Sat5wl6i0A1yqN3AaqnSOutGs8PqocXxCtQzi
	20plre7XpUiqHSn6EUvyM7hUQPq0A5ZFGnfWFrunbl0+KlN/m4UvOP9StWYoq+hx502lAlsf+2R
	WJBS843NNpKcu9snK2/TcOhlPJA0mLB71i0As/Ph8CNECs78vJGbf++hOoOcFYWOCodQFlrEQ
X-Received: by 2002:a50:a402:0:b0:572:cfa4:3ccb with SMTP id 4fb4d7f45d1cf-578519160c0mr5264441a12.8.1716796426435;
        Mon, 27 May 2024 00:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYComI9Zs83TUUKd5sk4qJypKkiyjT/f+YVwWOi2cC0zev/7gmccLbH/HmGbUWT9nHKsPWgA==
X-Received: by 2002:a50:a402:0:b0:572:cfa4:3ccb with SMTP id 4fb4d7f45d1cf-578519160c0mr5264429a12.8.1716796425953;
        Mon, 27 May 2024 00:53:45 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785234b3e3sm5408865a12.19.2024.05.27.00.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 00:53:45 -0700 (PDT)
Message-ID: <0fdc6519-5d34-4191-a41d-13f49463ad17@redhat.com>
Date: Mon, 27 May 2024 09:53:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Input: novatek-nvt-ts: replace generic i2c device
 id with specific IC variant
To: joelselvaraj.oss@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240526-nvt-ts-devicetree-regulator-support-v3-0-aa88d10ccd9a@gmail.com>
 <20240526-nvt-ts-devicetree-regulator-support-v3-1-aa88d10ccd9a@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240526-nvt-ts-devicetree-regulator-support-v3-1-aa88d10ccd9a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/27/24 5:26 AM, Joel Selvaraj via B4 Relay wrote:
> From: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> 
> This is done in preparation to introduce other variants of the Novatek NVT
> touchscreen controller that can be supported by the driver.
> 
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> ---
>  drivers/input/touchscreen/novatek-nvt-ts.c       | 2 +-
>  drivers/platform/x86/x86-android-tablets/other.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/touchscreen/novatek-nvt-ts.c
> index 1a797e410a3fa..224fd112b25a9 100644
> --- a/drivers/input/touchscreen/novatek-nvt-ts.c
> +++ b/drivers/input/touchscreen/novatek-nvt-ts.c
> @@ -278,7 +278,7 @@ static int nvt_ts_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id nvt_ts_i2c_id[] = {
> -	{ "NVT-ts" },
> +	{ "NT11205-ts" },

I know this was my own suggestion, but it would be better to make this lower case ("nt11205-ts"),
I'll explain why in my review of patch 3/3.
 
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, nvt_ts_i2c_id);
> diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
> index eb0e55c69dfed..5ecee6e66fb4d 100644
> --- a/drivers/platform/x86/x86-android-tablets/other.c
> +++ b/drivers/platform/x86/x86-android-tablets/other.c
> @@ -40,7 +40,7 @@ static const struct x86_i2c_client_info acer_b1_750_i2c_clients[] __initconst =
>  	{
>  		/* Novatek NVT-ts touchscreen */
>  		.board_info = {
> -			.type = "NVT-ts",
> +			.type = "NT11205-ts",

This then also needs to belower case.

>  			.addr = 0x34,
>  			.dev_name = "NVT-ts",
>  		},
> 

Regards,

Hans


