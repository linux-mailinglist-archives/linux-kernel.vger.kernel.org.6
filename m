Return-Path: <linux-kernel+bounces-383351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840BA9B1A74
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEFD1F21D6F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471592231C;
	Sat, 26 Oct 2024 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yrMr/o/B"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2A1D54FA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729968966; cv=none; b=Py0+P2VQfOuRmaDtB2S4RehK0Jc5XJEefhW0zdxtlse2vBGuYbMkoOgDor/lknYOJR27YykLG91fhbuAhG7ydDIBfFMSf45G5qyelqwtRMAEaS3usVyBXfFqlEturoCFz87NxxJsRbfySvKfDi/gzdVulRl9FJvwAuBqoGyECks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729968966; c=relaxed/simple;
	bh=QpC8YVpB40Z6U1Lv/iZ2wuaqETufaSWOZ9EgEu4KImk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atbHJMKMXlt015qPN19Og1QCW9yVBJZRiBGCApC0SxRbpdAZ6jC7Vd8QnPAf869bLtjcTD6gNSsspYFw1sxJo1Pf+hfM0AUMNn0ltWanxHlS7ajM+0z86IvwR69NT7m2V1bKig/9R5KMKRg9shBa8UrRzwKdasjo9EiAnv/tK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yrMr/o/B; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fc968b3545so30008481fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729968962; x=1730573762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l7NYgtXYY+/uZDllEcjAHtzUzuPVhJCmDywI+NC6CaQ=;
        b=yrMr/o/Bo+Vdn9kgEXF1m0A7JBHWA6+DQqw0tbZ1uCF2qzfkumdMM5hNkUQysA2vvB
         BcmMTjrpVexzM4iJimMsV6TTsLZDCkG7hbDpwj49D0x8AXYsBHQsRuiDhv2VRO+ADBv7
         dnNFbQxrrbPhsK1CZG5qdO7V9kbFH2pnpfaF5zYMkvoVn5uUHSdVkdBsB43mdwx7pn9q
         Zhp5ktEul1UtIr+NAum11XE3KUOsPx2ApvC5g1UEfZfGvcYhI7rx3EWDZfYwK+c2asZt
         IyVhNr4eyk1q+pa4LSFZg6WT/HWfiFT6QvDQrAw7p7gGzm2CyISRw9iWGKAJN/QFFt0S
         4u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729968962; x=1730573762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7NYgtXYY+/uZDllEcjAHtzUzuPVhJCmDywI+NC6CaQ=;
        b=JnZ1kfk+Oe31f1q4hDu6k+BlkWuj32yXl8KSFmgRirK9IQMwrMU0Ppz9+kFoekhRoq
         dWet0F9vTUEgGiXJTxvEgA4j8l+WD0ny+ROxdAJTy2fzWwoSnRl43RZOyvr/VxHf46ot
         hEbXIuZPmJro37Rr1Lkw8yzdmQLEOqyFWe14UiIt2eN3aTTw2IvaaMxaLHgBav6XRorA
         ijqQc5LBk1LEgCKvDUMzdpsetrCmuuIJRqFoWld8J1ImkTieXtpRKZ2nzRnQ/gTrOc+S
         J1YQ8BHlMDNPNqu1sAOG3mLl7RYj/P9y52MnMloDGO2ry+EdV0r2co6Eg14D0cI2j87+
         1exQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXfq2BNeWJLACS1UdFf3cyv5+vmQbmjdqcXd539hWGU7kUdkz+s+glfJyv55mPACMkKXGCiqipoMMimG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqmGoRcHbd5JJTSZHNYMQEj3JMsVgCRnuvgtCjEQZx67LTxdb
	sm8uwpEszWpv3zbaCw+plnQ/COGGrzzxfP/Bb6Jxxfcmxzw201a+ZAcYoLVUl+A=
X-Google-Smtp-Source: AGHT+IG9dImdPHGpADDEloy0+Zfu4O/+8WjoU10sz+7Yl6LFvGYaZ/pBLY7FwvHZ34Io4qq6Tv5k8w==
X-Received: by 2002:a2e:515a:0:b0:2fa:be1a:a4b0 with SMTP id 38308e7fff4ca-2fcbdfd8152mr10741631fa.21.1729968962346;
        Sat, 26 Oct 2024 11:56:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4507b9csm6110761fa.28.2024.10.26.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 11:56:00 -0700 (PDT)
Date: Sat, 26 Oct 2024 21:55:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] clk: qcom: apss-ipq-pll: drop 'alpha_en_mask' from
 IPQ5018 PLL config
Message-ID: <64vqb56a5gvpy5mut47n34nlqmbtfctvyljgylwuapgp53un5y@mj7k4awd3fay>
References: <20241021-alpha-mode-cleanup-v1-0-55df8ed73645@gmail.com>
 <20241021-alpha-mode-cleanup-v1-1-55df8ed73645@gmail.com>
 <yplfg55afv4vucpcxbkqsxmn44mzwr3tepbuvgtswhupx7fzfi@mwofp7v3uarm>
 <45461b57-cb5a-43a5-8b9c-09ae059805a9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45461b57-cb5a-43a5-8b9c-09ae059805a9@gmail.com>

On Fri, Oct 25, 2024 at 10:05:04PM +0200, Gabor Juhos wrote:
> 2024. 10. 25. 8:24 keltezéssel, Dmitry Baryshkov írta:
> > On Mon, Oct 21, 2024 at 10:21:57PM +0200, Gabor Juhos wrote:
> >> Since neither 'alpha' nor 'alpha_hi' is defined in the configuration,
> >> those will be initialized with zero values  implicitly. By using zero
> >> alpha values, the output rate of the PLL will be the same whether
> >> alpha mode is enabled or not.
> >>
> >> Remove the superfluous initialization of the 'alpha_en_mask' member
> >> to make it clear that enabling alpha mode is not required to get the
> >> desired output rate.
> >>
> >> No functional changes, the initial rate of the PLL is the same both
> >> before and after the patch.
> > 
> > After going through DISPCC changes, I think the whole series is
> > incorrect: these PLL can change the rate (e.g. to facilitate CPU
> > frequency changes). Normally PLL ops do not check the alpha_en bit when
> > changing the rate, so the driver might try to set the PLL to the rate
> > which requires alpha value, while the alpha_en bit isn't set.
> 
> Both clk_alpha_pll_stromer_set_rate() which is used for IPQ5018 (patch 1), and
> clk_alpha_pll_stromer_plus_set_rate() used for IPQ5332 (patch 2) sets the
> ALPHA_EN bit unconditionally.
> 
> For the PLLs affected by the remaining patches, clk_alpha_pll_set_rate() is used
> which also unconditionally sets the ALPHA_EN bit via __clk_alpha_pll_set_rate().
> 
> I have created the patches after analysing the side effects of [1]. Due to the
> bug described in that change, the clk_alpha_pll_configure() function in the
> current kernel never sets the ALPHA_EN bit in the USER_CTL register. This means
> that setting 'alpha_en_mask' in the configurations has no effect actually.
> 
> So, if we assume that the affected PLLs are working correctly now, it is not
> because the 'alpha_en_mask' is specifed in the configuration but due to the fact
> that the set_rate op sets the ALPHA_EN bit.
> 
> At least, I came to this after the analysis.

Ack. Please mention in the commit message that it's safe to drop the
alpha_en bit, because it will get reset by the set_rate function.

> 
> [1]
> https://lore.kernel.org/r/20241021-fix-alpha-mode-config-v1-1-f32c254e02bc@gmail.com
> 
> Regards,
> Gabor
> 
> 

-- 
With best wishes
Dmitry

