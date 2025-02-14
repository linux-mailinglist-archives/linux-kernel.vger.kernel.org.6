Return-Path: <linux-kernel+bounces-514491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C651A357AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04B11887ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D3206F1D;
	Fri, 14 Feb 2025 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0N96O70"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7284205519
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517028; cv=none; b=j3lTbKFsbUiRXuuGgQcX5aBLnfUT3Fvl6ABlsAXGDS44wN8A6f3+VIJty01yVa5v8atDFnLyVPpxxpifpjlRe4wLq1hI1p9lwXX+KCM0JVtnouxjKKJjgTmgChKF2XWkS/sKEozLA7H5MCtoNmtG4KZmsY5koqsRezmakWB1iHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517028; c=relaxed/simple;
	bh=MFTdgdlExpqx8TY76AlrGCz5tN5VnT5stMEnutUk1/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XNWKBP6yJM87phcoW4r/JRfc++8FeVzgkD9YQE8PclSJ7kUQC7bKD6H4eE6F6ahFmEWIWz7eYRwfRMgbYth8takpwNy3iSIa7cTHw7SnzPGf6bbr8LHORsTCM11/Ydu1WA0QcljwZyiK6Hxy1PJZXxvtgARrzuEVL1IgdaDaH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O0N96O70; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7c14b880dso366838866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739517025; x=1740121825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3KRD6Y81KP0hnKo/0jrjQjgKZ+r4kg7mu+pEFOiLI4=;
        b=O0N96O70xOcPoqujVsaCZ3lujDp61gTywZBB4UWVXCCSwbJbgcG7Q1u9vaPG0rkueA
         0uFDGGo7nMy/Wk64VzGtzeVAc276BMXvGjUWcGScBfBdp9OCqSb77L7kAwlzzEWyuDm/
         yeKCrhzy+acC/rqcfsIT8zqYz//Y9dTNcfWJytgrARVFJQ/l0yhWBdal0s1cgyzTawud
         141cpus2f/j1KzKVfoQt8pmvwxje2ep4wrYGQlf4xe3gfeWt6BkJI5YGaHB0IvLHEbXM
         1VzRRrRZDcJTQR6DaHr3DE6CLTxNL4GWdWSAK6I967XSHbvyEeCcJ/OGyRNVU3o0Zwc5
         8QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739517025; x=1740121825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3KRD6Y81KP0hnKo/0jrjQjgKZ+r4kg7mu+pEFOiLI4=;
        b=NMveV31M5UKXMYxv/l+8dqhdK01oqOPowSBdPF/LqCTfTUcBnN79JJ6NZp9u7henvT
         7IAaOzr23nqq8aoU7MVrLUUPlIYcPxfxcTzkL7g7egLZfqI1e3CpwcVZkDLf0uEAt286
         nERFKZvIWbCJ6VCEFbLajE6/mzbwe+QAXNn8TXyN4tQ1+eHoWQY/r6szHChdrl9vkbaB
         c0cZfhIcq+AmaQXsCPLt0+KGpN4f/42W/ruKJxfN9VFEqqBybb1ywNDJIlpSYelIcuIE
         /JOurOnn4BmsoJSZSdwIzCSgtr2vU7dwwOxPBArzl8zObtXpPGrtlEB2MgACj2z+DUe7
         CruA==
X-Forwarded-Encrypted: i=1; AJvYcCXfzjs6yC4NoU/t5DBwjdCxTNZjjyRjiIcSi5Q67CY60OVP3IJ9don/Lwx8Bnjack8B5I1qrG9gS2orKeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz0QYo/iCGm6Wsq+2NMQHdfZH7RgNQVGNCh1l04iEKcGd6hMS5
	lBO2LMdLKCrUzlsF79mOf5bYvYFwysmaShvtU/MUZv4WEjMi1Vjr4An9x9uSDmU=
X-Gm-Gg: ASbGncu9mmnuLz1z9d3JUETCGOH6kz972sxgjMriTNiunK2sgwotXIDZsqve98fnWuU
	XEtGP275j0T8tXUKbDFO/BDeZu5cieyjzpdB/hNoU+ujodT24fNlUB4bvdwmZJjQQL7rlwoPevg
	GOWeErmdjpSuH1GulQvOwWeHiS6hsq1BWUUukRtNYgu3bBx9MMbtQvbwAj1qVdmEfSB6F0IGGFg
	2To3q8/q8OkaGdIatHSypguvnjAQ0d+NocHKHINP6EiPJQNFRLxwkzI1Vj6/gmwxRiepLK4tVJr
	dHJZK39S6qElk/5rmxY0yKoi
X-Google-Smtp-Source: AGHT+IGi8WLS5WHEderG6CbIqrMmNonKomIvShKsRt+y2awNKUvUu9Cp4ZCauxABS0cVTnSGyBw2GQ==
X-Received: by 2002:a17:906:7316:b0:ab7:effd:a395 with SMTP id a640c23a62f3a-ab7f389fdf1mr929358566b.52.1739517025159;
        Thu, 13 Feb 2025 23:10:25 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bdc41sm279199866b.162.2025.02.13.23.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:10:24 -0800 (PST)
Message-ID: <12a67e21-220c-40d6-a6e0-64ba23cf6ecf@linaro.org>
Date: Fri, 14 Feb 2025 07:10:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] spi: s3c64xx: prioritize fifo-depth from DT over
 port_config
To: Denzeel Oliva <wachiturroxd150@gmail.com>, andi.shyti@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250214043343.263-1-wachiturroxd150@gmail.com>
 <20250214043343.263-3-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250214043343.263-3-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/25 4:33 AM, Denzeel Oliva wrote:
> Rearrange s3c64xx_spi_probe() to ensure that the 'fifo-depth' property
> from the device tree (DT) is always prioritized over the fallback
> values in port_config.
> 
> Previously, if port_config had a fifo_depth value, it would override
> the DT property. This prevented DT from correctly setting the depth
> per node.

sigh. You had a fifo_depth of 0 in the driver at v1, this proves you
didn't test your patches, otherwise you would get a divide by zero.

You can't do that, you risk to get your contributions ignored:
https://lore.kernel.org/linux-samsung-soc/fbd06330-ccf3-485b-800f-83f624a7c90e@kernel.org/

Please provide prove of testing in v4.

Anyway, you shouldn't prioritize dt over compatible driver data, see my
replies in your v2.

