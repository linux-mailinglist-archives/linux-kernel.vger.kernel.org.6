Return-Path: <linux-kernel+bounces-207534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117EF901891
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 00:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71902B20C1E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D4D208CB;
	Sun,  9 Jun 2024 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="L3grKSon"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A66FC6
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717973225; cv=none; b=ufKhe0ZtSDNG2KnfIMnCkwtkvVxlBtlvQs/bC9UKUCZs72YLdWIqRJ7vD0gUY9tKRoZdbkMLsgxpSQC6O2ux6qiN4KvKFum6Ngyzm0LFUBFA0QTXObe4neGqxFXxOwwZT7wauR1mRevPaNRmM8Vm8sSqoxbsBwyPFYnVEkZ+MjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717973225; c=relaxed/simple;
	bh=CF+cO1pSinPGWgCkR6VFs6IZwJ4BytxCPSPFPveyHtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0gqDNu7vLUmfeOZhetMvj6NC448uelOOYPEm9F+ZsOe8Hlz0tEu2c37PScLq7uJ0gjEVk2hJYIWoCvekR3692bKymPSCdOj0ApF9sxaKanYMNY4+uk5wkGhuo0kn96QPaT9T9ofATU0EZSbvKJAWaWPCR4lVw6OATl7Qj5BQGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=L3grKSon; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4217a96de38so10564435e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717973222; x=1718578022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WtKTGPRhj0z7HQ6EPmJaANaylZUzntqsNLAHly3ENA=;
        b=L3grKSonXsj1Ell1Q1dDrBvdu5mg09BodMzUq3cCxnaod1fMc6xVGmRM/kLl1rPnII
         BI+n4XkN9Z1kJw/PVDtA75HfWch9yNABx95He5QSSiPfwYdH9/3Ofm/k+wxDCIGHNmUc
         U+SeKVexG2gXQvc8V/1ycwIM7xtU14w+9aF8wVIaQfSpYQVrnof1DVSEkGm+tWcmi31j
         2ZwBR8YZZTdvJUPRjAhcJYikRtuqRRjwHs7CtO8eKVf6Hz4TNGbZwc7zBFAn1gWSKool
         AgQp9MKbIEbSJesTmmS7/F8zbmBlxu36A8+aQqva/ZneGn/jiYUi5NGGLaHkoYo2Nc/a
         VifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717973222; x=1718578022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WtKTGPRhj0z7HQ6EPmJaANaylZUzntqsNLAHly3ENA=;
        b=hMvj6l51KtHdJiw8HLPDwLfFQlxeRfcTqTJefHiNXJLYjxeojigKofrS/FJaNZd+zF
         A+3eAY3/l9A7EyWVVaXCTiuoVwWzeQgbPxMi0CYortmnVxgmbUwF2Dka+sFvAiLyUx88
         rNnYR4uf7cx9i8pbYoySL6gQHJpB0ojsscIBG9s8uf3/5AiyK33qbKIquxngFTGsrMB1
         S5IhBm+QDdrJCAf4rqRz3nKNsmRnmaPihjKzpEVerKq6C32QfwzKBTaebOLkctlPYoNg
         q/L0OmKE5bFQTANPvcwXcwvXkpR2/VXpAt3wAxIn+ecfUn3M48i+WY7JzyDX4EI49sW5
         U0bg==
X-Forwarded-Encrypted: i=1; AJvYcCWi2yVhOAXSQiZzzt68fbLgp6F0hu4xihRjqJrwLrIoOCOPza2U6PRF5EH1IkfWXK7PbaSox2kBHHCcxU41OQpRmhtRaqOmIdCxq8I7
X-Gm-Message-State: AOJu0Yyh4g19H2T5bbyEfPfloQcZqhTKnwCaHKmdNt/YaixpngDKsYrk
	pizbkx81NJfxzMPVqJRGBISFrwVQSmRT0jY88nhF4IhjcCf1YMqIC3yaOuPsOZk=
X-Google-Smtp-Source: AGHT+IFeLN3Eubzn1uX7ekPwZGluQ4RwPDVnJ0LDW2iX1nYkbJDRca0Ehd7IGNHlN/ZzwllLO+GXbg==
X-Received: by 2002:a05:600c:500f:b0:41f:9ae3:57f2 with SMTP id 5b1f17b1804b1-42164a3f64cmr64627845e9.37.1717973222593;
        Sun, 09 Jun 2024 15:47:02 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421c20e9f51sm20248635e9.17.2024.06.09.15.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 15:47:02 -0700 (PDT)
Date: Sun, 9 Jun 2024 23:47:01 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, vincent.guittot@linaro.org, peterz@infradead.org,
	daniel.lezcano@linaro.org, anna-maria@linutronix.de,
	kajetan.puchalski@arm.com, lukasz.luba@arm.com,
	dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/6] cpuidle: teo: Increase util-threshold
Message-ID: <20240609224701.pc6om2o5ep6btywe@airbuntu>
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-2-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606090050.327614-2-christian.loehle@arm.com>

On 06/06/24 10:00, Christian Loehle wrote:
> Increase the util-threshold by a lot as it was low enough for some
> minor load to always be active, especially on smaller CPUs.
> 
> For small cap CPUs (Pixel6) the util threshold is as low as 1.
> For CPUs of capacity <64 it is 0. So ensure it is at a minimum, too.
> 
> Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
> Reported-by: Qais Yousef <qyousef@layalina.io>
> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> Suggested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpuidle/governors/teo.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index 7244f71c59c5..45f43e2ee02d 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -146,13 +146,11 @@
>   * The number of bits to shift the CPU's capacity by in order to determine
>   * the utilized threshold.
>   *
> - * 6 was chosen based on testing as the number that achieved the best balance
> - * of power and performance on average.
> - *
>   * The resulting threshold is high enough to not be triggered by background
> - * noise and low enough to react quickly when activity starts to ramp up.
> + * noise.
>   */
> -#define UTIL_THRESHOLD_SHIFT 6
> +#define UTIL_THRESHOLD_SHIFT 2
> +#define UTIL_THRESHOLD_MIN 50
>  
>  /*
>   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
> @@ -671,7 +669,8 @@ static int teo_enable_device(struct cpuidle_driver *drv,
>  	int i;
>  
>  	memset(cpu_data, 0, sizeof(*cpu_data));
> -	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> +	cpu_data->util_threshold = max(UTIL_THRESHOLD_MIN,
> +				max_capacity >> UTIL_THRESHOLD_SHIFT);

Thanks for trying to fix this. But I am afraid this is not a solution. There's
no magic number that can truly work here - we tried. As I tried to explain
before, a higher util value doesn't mean long idle time is unlikely. And
blocked load can cause problems where a decay can take too long.

We are following up with the suggestions I have thrown back then and we'll
share results if anything actually works.

For now, I think a revert is more appropriate. There was some perf benefit, but
the power regressions were bad and there's no threshold value that actually
works. The thresholding concept itself is incorrect and flawed - it seemed the
correct thing back then, yes. But in a hindsight now it doesn't work.


Thanks!

--
Qais Yousef

>  
>  	for (i = 0; i < NR_RECENT; i++)
>  		cpu_data->recent_idx[i] = -1;
> -- 
> 2.34.1
> 

