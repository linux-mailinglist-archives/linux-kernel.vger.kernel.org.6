Return-Path: <linux-kernel+bounces-428311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B39E0CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F94B16568E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689581DED78;
	Mon,  2 Dec 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLoILcxR"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6901DE4E6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169645; cv=none; b=CiQJDVxrZmapyr4xx0sAoxsk7VGtfRzev+ylptgxMZqMqk67Cr9kiFiM/en84zxk/oWp5SPGz6aOTg1QLkNd4B9/YJnfM2JotzrCl31weAo3FAJHU7LcpxXTISz+bbkz6Pti6PBycMAhuuly5ksigiL5a+g6h1c2pHEzLyQiLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169645; c=relaxed/simple;
	bh=ZwT9XETIGPRtoz06e9/Bz1xnjU0UUFwfd1/wc/ZJOT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljqEagcDJHFHi+t6UxmiTwqH3J/xT4p/lJN09+EtNEmRL6NLqCNlQ+GBjARaFFNkBQ1dfHdFjRmoeSGbLMrC2DgBi8hhjzWm0FF0b1u50yXeFU7KmAko3X7d/DAG6mh5pDG4/X7wMQdHbYSekZfqOV54pLW5/cVakQE68GYkhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLoILcxR; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53df119675dso5664416e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 12:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733169642; x=1733774442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXAhtq60I6waVpW/O2JwlPsYrhNNVeFfaONkbV0wS/U=;
        b=eLoILcxRM3AmrUCxOGkNENSkBe1t/WhBa7Srj5s2SrXQoKOshUxRyDoap0Rmn9IuNk
         0RNMdwzGZkwbcPANhyF5bzB4a9dHHtE/Mb/VJh9a7ovFx7YmWrcHXxEQuUlrMxtK9gF5
         Fee6fVsy1niD5nt3VedUCT2slYSrdlLskoF5WTKJfO/YEQgnpYWrKV5PY3tr+PMu+/Uq
         VkYj4SerPwlc1jKuZ1QosIGA08QfQ6BlRiPKtahnopZQ3pAPbDW2vOCV8JVe8pE1KfoM
         K5Bfd9U3d4NB7w0nRUQVKyYrnnS5O8PMdtfKYsWOACxb2ad5y+4jUatNJSY8XP/KLlh7
         km2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169642; x=1733774442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXAhtq60I6waVpW/O2JwlPsYrhNNVeFfaONkbV0wS/U=;
        b=aY183JFKanZzh4pvSinjTq72wwQBnWH/az5Lx3JdZWRltcmB6EFwYyBhjI5E2c5XzM
         CD7JdPGzgReyGouNtHqhgb4T/7/ncx9PVinlJh5MYnc1omXbgWy2yEP6hAqS1ehirxec
         x9fddLEZ9eLqYtZyFcGcsi8uisUSWVXBdk8dD/nMJMpezouuyffjTxLoOLX0b/iV0f/t
         9F4CT3+eGsNrcug9LJqjL2G0PPa8lO+8acwG/Vah03EsR9Rx8mKqWDz6LWfv+ROn3Ycq
         q4f/ua/L79z3qCno3ZKo5LSF8tnicOzFI5R4edLV2vhj8ZI0R05pZbHEB+dD1GB8QAWG
         Wn/w==
X-Forwarded-Encrypted: i=1; AJvYcCWdJhDrxqHf7vC9elpF7wcsEoPpAPo8DXHGk4QlBe1vVGTo4/JplVrGp+7QC2Rtyjmb56rtGROXFTgHMW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJlv3/ZWV00dGaRk7gMsBayxsoqiwBMsMJy6mg6H1x4Agu4my
	pCjl3zvRPST4W3rZGjKBWyfk0nD7WVTU5OQIrA3M/z93hO13SkOjKbuG375pxos=
X-Gm-Gg: ASbGncsn85U1WBy/V1uTkdrWy4K+ZdCOVfSHaBqEB1mjqFrXaF2sQDMh607hszjQwxo
	bVrfO2dGW3pOFF070Zptqqqi++Tug8laXOBtej5uTdy4V13z0DZv6c++t3Ht+CvS4IkqfhEnSNa
	CPHcqyPSqBfT2Y164lsRDMTGhye/rph48aoSX78MkV1WWZPYrApEbXZ8AWYDuVduNb7P9cWJHiI
	1tPeOrJ8brxOQ0bdcm4BUy2uYuqAlN0N7dlkxVWZohNq/bmMyP/ftLKKpoJ4a4MqyPHe33Jd58O
	q8qDYHOY+0wYLmFZVvk4ghqFZrLwgg==
X-Google-Smtp-Source: AGHT+IHlBla2bkS939rzD6EaoiaSpmSshKV9IUflTjWZle/0CJSDrrxy8jwAJY6npjQNBvZiqQHQNA==
X-Received: by 2002:a05:6512:1286:b0:53d:e88b:eb4 with SMTP id 2adb3069b0e04-53df00d1ba7mr12812129e87.21.1733169642056;
        Mon, 02 Dec 2024 12:00:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f136sm1550171e87.166.2024.12.02.12.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:00:40 -0800 (PST)
Date: Mon, 2 Dec 2024 22:00:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: rpmpd: Fix comment for SM6375
Message-ID: <yo5cc3cvvwwdrqrrgwlquztj52sijip3ffyyqag55jrnztxi2m@hn75ylkhnxie>
References: <20241202-rpmpd-sm6375-v1-1-12a4f0182133@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-rpmpd-sm6375-v1-1-12a4f0182133@fairphone.com>

On Mon, Dec 02, 2024 at 04:45:02PM +0100, Luca Weiss wrote:
> During an earlier commit, the comment from SM6350 was copied without
> modifying. Adjust the comment to reflect the defines.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Fixes tag, please.

> ---
>  include/dt-bindings/power/qcom-rpmpd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index df599bf462207267a412eac8e01634189a696a59..d9b7bac309537cbfd2488e7d4fe21d195c919ef5 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -65,7 +65,7 @@
>  #define SM6350_MSS	4
>  #define SM6350_MX	5
>  
> -/* SM6350 Power Domain Indexes */
> +/* SM6375 Power Domain Indexes */
>  #define SM6375_VDDCX		0
>  #define SM6375_VDDCX_AO	1
>  #define SM6375_VDDCX_VFL	2
> 
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241202-rpmpd-sm6375-06582e126d7f
> 
> Best regards,
> -- 
> Luca Weiss <luca.weiss@fairphone.com>
> 

-- 
With best wishes
Dmitry

