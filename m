Return-Path: <linux-kernel+bounces-438728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D49EA4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F8A28740D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBFB1CEE88;
	Tue, 10 Dec 2024 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1WIgW8u"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9275418A94C;
	Tue, 10 Dec 2024 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796673; cv=none; b=MbDuMRHJGxf6nnpdcIXNq5h8vPdZZhhT3k2pZ3dtWmZxrvGrsxWrAPit96QiDC6hAaSzA/Qs5t1eHYNFbXKvmAA6IcMOMm3zuXcQv7IP+945PhKm/MNRN3r8JgmrlSpk+Up/oBa7Pm66qadt+NraejWHjJqzMf4F76e24aggYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796673; c=relaxed/simple;
	bh=Y1paDHAZryavy2dZ2mMhQFQQD2mz0VBvLfEIvMI1XHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2muVdTJ3wGBQH7z1mCrdV6FtgSAP21/qmiy1IgkkW8dLwDfHviAk+pQv+4ZkyRxZ3ROE0zajvdKXvwZGF+UV+aAYhqB6M7DO2uUqqL/waSZ5esH8ndGkqXSM2JE5uyQzUQcksN4Da1A3lZsIiOKa8wALOwDaZOjYV1zEuCWK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1WIgW8u; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725c86bbae7so2797787b3a.3;
        Mon, 09 Dec 2024 18:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733796671; x=1734401471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOZIKt0bFPSGKmOzo4t4qSgnBLd3lwCXFJNT3HqXBN0=;
        b=K1WIgW8uF2EFjpEGOp+EhYm78mYP+kWEb/q4aD96n3BySsVbpt6c4bL103QMf+3bP5
         S1DwgCSUTTIeVIYve6UWBT7ksvY6VtyaP9aN9sVOlZrhAyMdu9Hyf/TS4AoJgYqUohFV
         Yleec0nE61wCPSDHCZdWUb0aEQNjlD6mQzemkCaTUPpeJpWDYjr8K5tY2OMK6ex8pNA4
         bFqI6YmE17wYKtXpikd+Dzt+lq48XCKNu5tOfEIM/F7z/tbZTQMgW/42pri1iYkEmcxd
         AsnLxp1t9qEygf1HS0k4KlIpf1401EPfkZfQx5RHD4yqFJFscCkX8b8z0y2mSSAbMnNo
         cprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733796671; x=1734401471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOZIKt0bFPSGKmOzo4t4qSgnBLd3lwCXFJNT3HqXBN0=;
        b=eDrJcUNsDmXELA5QzAliJMeTIC1g0Ic6ot/LEEsfNDLKwbBFHuON99TbH9oD8bSHtC
         pgsP+WMfQOAcW1YigMPe+vCEPR0nCpJTazMxRhH0D63hcVYssNh5fQYm5jp1eN+XYw4F
         C0c6CaPGuHhQjydHyAx1OeZCII8Klvkz9QWPsNPWhjlsfp8t1Q82CUvsQ2cPT0c3aiWt
         LVrzXjrOsHIjcPhnZ9xN71n4RSkQAdr4BHweUuKWE6MVmlWzgv5svqcAkTz/YjC4rKBB
         0DAYJYRJVPJiDvgwM0VA15PWToOwJK8TC3F7WTPqPpVFqHS40wR3O6OOoVac/ioNP7Tq
         USSA==
X-Forwarded-Encrypted: i=1; AJvYcCWWoW1NLMNjJELAe9bfcmm7HQCGRq3ixtxp7bvpSrGOgoO0x2Pu71ttqh03ke+2y3TtSH1Vi4q98XuER5yzmo50/iOO3Q==@vger.kernel.org, AJvYcCXiP8hk+c6iPqXO/2sVRpOpZRopnXvel5Dwg2moYTRA1NULb+gO852cSBy8CCinp+H9CLs+en/Iwm0xOkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxAKywxxDszV6FV8Isk3ANaCKfF6OYa5HMBILIUaKwzCjf5uU
	At3I/pOFsyhLWPHQYuOMjMd1y/YPp3jhBjlTiXc4C652Jxe/tQCDvN2dBQ==
X-Gm-Gg: ASbGncsnxF3M5LLBD7kJo38uwbikc16nSVtI9axyP8v7o8spNHKYMQfd4AZPAhMiQiK
	xRPRiunTDslZGYzl/B9uGjSMSaTBwxXHXuRDHnUR78FDevVvRepfHT3psirBVGXCegzqQTFLU9P
	GCFouNRUUveni7wqkBdxDwNBqGX7RfPpZ2yy+BAh1Pic8cacqaXRKFwe8nM/14GADP8LnCvvLrL
	QqSsHoZtMSw65IJ508H6PH+htD7qCApTXGufVxpma5Q0WTrBlN37kZYgM/IttkKAsCqeaT11cWr
	tmNMx7uTkNm5
X-Google-Smtp-Source: AGHT+IH3Wfym1SYu+U7j7MtdnjgU3L70JGzgl5EJBX48ob+wAaSTQM5wwXwfE3/CXOkOMBafaZYvCw==
X-Received: by 2002:a05:6a00:2d85:b0:725:ebab:bb2e with SMTP id d2e1a72fcca58-7273cb134e1mr3079754b3a.11.1733796670859;
        Mon, 09 Dec 2024 18:11:10 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a9205fsm8215567b3a.99.2024.12.09.18.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 18:11:10 -0800 (PST)
Date: Mon, 9 Dec 2024 23:11:06 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] platform/x86: acer-wmi: Rename
 ACER_CAP_FAN_SPEED_READ
Message-ID: <2emajkofqh6hwih7cnetj4j4b6rhnncnsrhkbve6yxn55rzy7b@atfif46fugf3>
References: <20241210001657.3362-1-W_Armin@gmx.de>
 <20241210001657.3362-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210001657.3362-3-W_Armin@gmx.de>

On Tue, Dec 10, 2024 at 01:16:54AM +0100, Armin Wolf wrote:
> Rename ACER_CAP_FAN_SPEED_READ to ACER_CAP_HWMON to prepare for
> upcoming changes in the hwmon handling code.

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

> 
> Tested-by: Rayan Margham <rayanmargham4@gmail.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 5cff538ee67f..dd57787466b9 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -246,7 +246,7 @@ struct hotkey_function_type_aa {
>  #define ACER_CAP_TURBO_LED		BIT(8)
>  #define ACER_CAP_TURBO_FAN		BIT(9)
>  #define ACER_CAP_PLATFORM_PROFILE	BIT(10)
> -#define ACER_CAP_FAN_SPEED_READ		BIT(11)
> +#define ACER_CAP_HWMON			BIT(11)
> 
>  /*
>   * Interface type flags
> @@ -358,7 +358,7 @@ static void __init set_quirks(void)
> 
>  	if (quirks->predator_v4)
>  		interface->capability |= ACER_CAP_PLATFORM_PROFILE |
> -					 ACER_CAP_FAN_SPEED_READ;
> +					 ACER_CAP_HWMON;
>  }
> 
>  static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -2551,7 +2551,7 @@ static int acer_platform_probe(struct platform_device *device)
>  			goto error_platform_profile;
>  	}
> 
> -	if (has_cap(ACER_CAP_FAN_SPEED_READ)) {
> +	if (has_cap(ACER_CAP_HWMON)) {
>  		err = acer_wmi_hwmon_init();
>  		if (err)
>  			goto error_hwmon;
> --
> 2.39.5
> 

