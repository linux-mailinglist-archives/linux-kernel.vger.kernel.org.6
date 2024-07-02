Return-Path: <linux-kernel+bounces-237281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16691EEAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C13F1C21A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392535C8EF;
	Tue,  2 Jul 2024 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7XXWNXI"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF0374C6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719899829; cv=none; b=g2rS07i3wpBRlv87yZ862KRAjwNp7g+AZzm3RbHDAfsOd20hB4ivt7RlYh8Djhaot5Zk84bljMjwC7OJTDhkEjyCBvPQPXz0gE3a0stFugbzxzDteEPAk/Up3NElqjzQ9LX8pHlYuE2xUbuectxm/66rFbfIYZGTLFMzs6bbr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719899829; c=relaxed/simple;
	bh=hrWd+DMfhLdhgvgZ6CcFG8Yrdx//qAY+wVKO8Ywgkv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnTTr3p+3GlR+82Fs0JLWoBX/kJhwYYgyL4cDjMiZgjKsH3afqAXorX8b0DJHeWLaOVywGMakorJJYjYetBVAd+xHQxuELhnDgOHgXgrjFb0371A7Hh1ks/p0IHyk/1bNdU/DmVDspKmw3rYlpO2bw+VNwD5Jc57c6Y51AgBM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q7XXWNXI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f480624d0fso22221725ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 22:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719899826; x=1720504626; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5rG7724QFwFDpF6Kn0xpJ+NJU0J1nnnGMkvWaoZGyc=;
        b=Q7XXWNXImDCrtYHPdzBHtx39ccJ1r7eAdGwnAnwgJUBky6uKE8qDY6noZ5qDUGggBg
         K0bkA5gNWFkYQrUo+NmXhwLO7qkV90ACGgfEhs+vSDf3u/6S1R4SKyriuUjl4z4jPAsa
         6LTnrI18muMeE2piIJLNeoEjt0h3rISrzVZ2H+JSizWaoWJHvZbToK0LOI0PikJCy3rl
         9Te6evRbuA1MXR7dv0r6TY8AXaVd1rCcX5WQiX/jWY5oDr0C0Be7c9ISbBxGqAKHb5E5
         I4/gbTQpumopUjOards1Hsluz+R+3mrskMUV7fsKNGeauCfjXs2UGYqX6wJclVc5OEix
         Z+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719899826; x=1720504626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5rG7724QFwFDpF6Kn0xpJ+NJU0J1nnnGMkvWaoZGyc=;
        b=vnWeO5B53g0yH0BB/xqylXqGVpWP2wUCsb3fogCBhA+byzNcbkLvTsNtHSY5sEXH0e
         4zmoWygTC19TNIMQCMmB7Mg+s50Gu8r1H7miPsA0xIA/Fd6QJGM+P+DEPYS5nVM7YX8j
         Ez5U4MtWMkhTSg0dceNQ/1zi/m+vwGhoSAPy3meWgJ0+djNHeVIj1ulIGEQcC1kEyXL2
         VCmn5TSkicaciGqx/bmYzWxLyKlRWyHpQba6PNhtYO/2H4ufjf/Hhb7dWBikWX0pa889
         1jSCfdTDupbwsvOA9dvkH7yYuWN+VEPA9MPy9i866FyY6oarXoPqQ9WIPHZb7C3iJUKg
         cbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5IYP5msCFzU7Rey7EVk/qbGMX+G6+9cf4JHIAOvlzgD26+1gXymSUmHEMR9PqyPxohFNIvb5UEviRkCgIA0X7XaPN+MwurXcsGPLZ
X-Gm-Message-State: AOJu0YzZ5xAkWHyOiaYBsBfKJupsnbztXBzMVjnXpKUWPkT+btpfyTph
	m3F/g6oO9ozN8myLIDycX2V3x/F77RRMCTJJI4uZ/XpciaMPUa+12PKaRbOB9yM=
X-Google-Smtp-Source: AGHT+IHCa/XZ44PQvOPHK1Yiee37rkwXi6KHLsgAh7cZkOVdJcrPdLHRisJCUzRqNJuStcv8fmZSkw==
X-Received: by 2002:a17:903:2446:b0:1fa:d1df:d41e with SMTP id d9443c01a7336-1fadbcf4690mr46300745ad.58.1719899826024;
        Mon, 01 Jul 2024 22:57:06 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fad067031fsm66279735ad.259.2024.07.01.22.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 22:57:05 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:27:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
Message-ID: <20240702055703.obendyy2ykbbutrz@vireshk-i7>
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>

On 28-06-24, 15:48, Nícolas F. R. A. Prado wrote:
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -629,11 +630,9 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>  	int cpu, ret;
>  
>  	data = dev_get_platdata(&pdev->dev);
> -	if (!data) {
> -		dev_err(&pdev->dev,
> -			"failed to get mtk cpufreq platform data\n");
> -		return -ENODEV;
> -	}
> +	if (!data)
> +		return dev_err_probe(&pdev->dev, -ENODEV,

What's the point of calling dev_err_probe() when we know for sure that
the error isn't EPROBE_DEFER ?

> +				     "failed to get mtk cpufreq platform data\n");
>  
>  	for_each_possible_cpu(cpu) {
>  		info = mtk_cpu_dvfs_info_lookup(cpu);
> @@ -643,24 +642,21 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>  		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>  		if (!info) {
>  			ret = -ENOMEM;
> +			dev_err_probe(&pdev->dev, ret, "Failed to allocate dvfs_info\n");

Same here.

-- 
viresh

