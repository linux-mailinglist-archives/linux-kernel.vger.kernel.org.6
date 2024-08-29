Return-Path: <linux-kernel+bounces-306367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0855963E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C711F22B38
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1F18A6CA;
	Thu, 29 Aug 2024 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbWCssqK"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B116EB50
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918941; cv=none; b=Hg4usAQiG2Yy+gS0cWOMArxsLs/b2Ao3wWftfJ1R36hQgB3wcaTdZ+oLSJ0omVK5OzQ2+hcB5LRIkjPrJuLX96u9NOrNdAmDcCL84RPad6ylsyfFvcFJbzr1LiP2QFvZ6IESwtwwfXX16uPovzErOdw2zgFh/uYj9pfS+RdtlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918941; c=relaxed/simple;
	bh=0e9bY22JQmIjY9HBX7LF3J4B5mh4hs3ZuYvXQ1yj598=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiq38Lt+20OO+e0X+sSTFldnXXfAHjsOz3gavlAJT2pZyWuPjX6l2h4WIynXsO9g4uVxwLKCDiawuELDtgF3hXrR6DIYlEL+TYhK764G45JgC9Wxp0m6RW0nNOSr9BCaSpoFpXTYZ+64TJhCBnH+/968ji9ARLZ0R15nZEvpUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CbWCssqK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53343bf5eddso460261e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724918937; x=1725523737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzdVHNvVFZs/r7z8d45DArC5y0n0ZEzQ/sfa0ZzJkSQ=;
        b=CbWCssqKoTJVlpVVJfkL53T94GUo7/CF47g1xobEvYBoYH1RkOVPwhv7cjujcMzr8k
         psvLXA5J1i6ci8Am9sxLVaHeNnLp0Rud12VknV4p82nbWFoNSsiVAcg6Lavail0RtaU8
         pe/aAphgF+e+kzapBUF4tC0mnr+aCruPpbdrwvUPFM6hlGA6mS35ozovN1diHDofbxQ5
         Eaj3mtFWkveoGxHbQdrhKSRNec3p9eRVxw1/oqSE8/WuwwVNkzlHkV2y3GOVYUassoPd
         6G5p3hMqCJm2ZSV7EMkvYpVX0nHEBFEVsBGyQBlKqnHPKDxKfqbB6XtCy4cjHOVk+q5W
         jdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724918937; x=1725523737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzdVHNvVFZs/r7z8d45DArC5y0n0ZEzQ/sfa0ZzJkSQ=;
        b=QhcsUH0/+u8OFFUxrbSWNLNlbZiqC+bd+J7gap8HIEOR9iLGxNZdMef5XTiI9GbENI
         TxK5FAN+CZVM0gjmXCqC3LMSKbilkMv3IXmUCiZ7A/TaiF8P5rUX3AG8+sih2QvQ49ny
         h+sQFl/UBsSLpqS7H6Ngt8AgIFGWkKLXBnY7QqoxsWLTh4X/hsaiG0aquyhF38veRm6J
         sQwQtHN6kCbof2met+IFEt4cYwFcQzYjCutgOj/PrewE5nPjTMwCvcGIGjbxoSoCO+3x
         /4QV4QTAS87L0E/GU+wCcZdZgjtUIFeCtjojQwTof0h2SGN1ASvHdgpBxPXvzOLPMak1
         qsgg==
X-Forwarded-Encrypted: i=1; AJvYcCWK3tXS5NJY083IFtLvDcLP+UkiqHupS6l8rMA6NwBcX+YjZqRii7HrcQVq4DJ6aSDBhB3zS9LnXe9IJsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmnW7uRR8CVLtkKizhrou+9G4g2dPcLPlDlWKPjrl7mghXfs6
	f1pM0tZJ4XgeZ2skw5cjBSo0piRizWGgk2LB7iPraxOSPFrWnX6yCbwexrbFUoM=
X-Google-Smtp-Source: AGHT+IFIE5FdgmQvSzVx3ReotP0YOU4OOkMPEDzM9mZ+yWZ3XKm1Dl6erwST516kO7jI6UlRoSAIng==
X-Received: by 2002:a05:6512:3e13:b0:52e:9ab9:da14 with SMTP id 2adb3069b0e04-5353e5744e8mr1286311e87.31.1724918936864;
        Thu, 29 Aug 2024 01:08:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084116bsm86523e87.214.2024.08.29.01.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:08:56 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:08:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yangtao Li <frank.li@vivo.com>
Cc: vkoul@kernel.org, kishon@kernel.org, krzk@kernel.org, 
	alim.akhtar@samsung.com, konrad.dybcio@linaro.org, liubo03@inspur.com, robh@kernel.org, 
	yuvaraj.cd@gmail.com, ks.giri@samsung.com, vasanth.a@samsung.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 3/4] phy: qualcomm: phy-qcom-ipq806x-sata: Convert to
 devm_clk_get_enabled()
Message-ID: <bo3hx7ma3np3wjpjc3zmya7iagefnlkwyh4s5gv7jxhr3ompob@cpehveanuxmw>
References: <20240822084417.1596110-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822084417.1596110-1-frank.li@vivo.com>

On Thu, Aug 22, 2024 at 02:44:16AM GMT, Yangtao Li wrote:
> Convert devm_clk_get(), clk_prepare_enable() to a single
> call to devm_clk_get_enabled(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c | 22 ++++----------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

