Return-Path: <linux-kernel+bounces-225361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4262F912F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C8DB218B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C417C221;
	Fri, 21 Jun 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwIadPYT"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410617A92C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005724; cv=none; b=TV0RLK2QtKeYRXcaPmWrxr/P6l8J1JmuCrnTwSGBGgU3EazzYd6mp+yOPN+Q68LQlBWwcMbKIhHac1PiUQqSenzF9CvqFCTrkED1XIaey5LmRGaDO0Pd6BlKd54zAOx+CAdhFUQTBdcKkJuf8kgv73IyHkx0hSjh8v1Z8iZQSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005724; c=relaxed/simple;
	bh=qTMEby76e+phzeqNSFga3ZWYraPCTO0fmLO7nBbtIFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avUncfBkAD1d4B1ZTrFJmgKOYDZHWy3X7sVDfDXozlRqppUDGW0wqIigndXJel4wo4qw+ZiMqu7f/IczuqGqrL7aOx3qCv1J+qE1BhdvhTz2U8oDIEOBB+zVVB8f0zWtnjDNyn4MPHdqSQeVbOWBvU5b4x3k2xYiD0AeD3ot9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UwIadPYT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd8897c73so1111188e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719005721; x=1719610521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7QzofDMIJnox4m27cbx2yoWL76uSEp1G3gfH6bMGlo=;
        b=UwIadPYTXnfrJfPIYo0729ZpMZCawESKyQ7vgeufxAhb4GutOU64L+cDuYQRlSqj7o
         6I/mp2yJEJH5ZxlXd2GM+bama0iHy/qbsW9x1WEkmvqkFda0HPjHprmQpvnfisVIKIOi
         VMqQpqYW2qtFOZvUXeBRU7IPW1zKJZctX2gshliVGLtDcdprKy2xsoofAJZh5HN7UmeW
         YeZrgMJATDFRCDfKa5uimT2fFqc6Rqnn1k4tgbU64vjOOQdTgL+gT5alnbKO3JrSUKSL
         64lV8ebOF+Eg7sA1ZJ/Hhfwgc2XFLCI23xGm5AU2+wGbodJ12T88kYv70p5LymvckiRE
         n52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005721; x=1719610521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7QzofDMIJnox4m27cbx2yoWL76uSEp1G3gfH6bMGlo=;
        b=eaQ12kXdXdRRCrMJoOF2dqnKaxY9gHllS1DzwoWv3nwqtWxDIIaIHUM09Er2B6Ydfq
         kPVxaBFYrpIDe3OtZGcL74H4WOpubP70bnqa5Aza7ym7iaimf1ElaTd+MkH2nEUDhkah
         SATMrQ5QNbgr3jXXILBPrgmWOTdhcsGqhrcY8+Ctmrwl4y/z/IKm/q7EC83QZKS4rxG2
         6dw+d9cZKnWO8fkzWG6bfLyjOm9wd4AGmGrLdCSo0eTWqJKmW/yJ/OL8pDkdYqOBoA/k
         FP7VJSAfn7LLg7Ehr6TH21X/xcdL81+TA8c9J82v+6HB/NnCJbu5CVsFK2+HTuUuOi/R
         xw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXab9HVElrJECT+qOThg4SEeWjhBW9DhvtAxV2O9/o3w81ygnKPA+e8Har1x52m1jIbuhdRuP7x6jWnXnCwNzCCxYllrSlSMTSbbJyF
X-Gm-Message-State: AOJu0YzZ/6hzEReG0WqsXhmMl6/JLabaZ9ehg7BR8jx8wHYMAwRGl796
	2lZyrMxIut3rnqHrQceGObLsBVBgoUAZ3eiT9GNZEIbwWUFaaSDckNcSQ3PVRpspTEXe1R3G34A
	tdJA=
X-Google-Smtp-Source: AGHT+IE3I1OW3tps/gbJ7JLgMTs4va9JJcfWhFkgP0GEwspZ6da7/hcUMk7cMNq1x48Qb2faeRouvg==
X-Received: by 2002:ac2:4c01:0:b0:52b:c14d:733c with SMTP id 2adb3069b0e04-52ccaaa2947mr5347391e87.68.1719005720668;
        Fri, 21 Jun 2024 14:35:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63bcf2asm314624e87.74.2024.06.21.14.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:35:20 -0700 (PDT)
Date: Sat, 22 Jun 2024 00:35:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jonathan Marek <jonathan@marek.ca>, Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, quic_jkona@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gpucc-sm8350: Park RCG's clk source at XO
 during disable
Message-ID: <cehpfdrqxcz6azrbswscsp5xubqey3ogmsyxw6y6n7lphvrfez@nep3r2nua23i>
References: <20240621-sm8350-gpucc-fixes-v1-1-22db60c7c5d3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-sm8350-gpucc-fixes-v1-1-22db60c7c5d3@quicinc.com>

On Fri, Jun 21, 2024 at 05:34:23PM GMT, Taniya Das wrote:
> The RCG's clk src has to be parked at XO while disabling as per the
> HW recommendation, hence use clk_rcg2_shared_ops to achieve the same.
> 
> Fixes: 160758b05ab1 ("clk: qcom: add support for SM8350 GPUCC")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/gpucc-sm8350.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8350-HDK

Thank you!


-- 
With best wishes
Dmitry

