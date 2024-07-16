Return-Path: <linux-kernel+bounces-253699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA393257F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FD3B23D58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D15F199EB9;
	Tue, 16 Jul 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qM2oJ7fj"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A1199391
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128856; cv=none; b=H01mP8isokUCltirmTJMHg27sMF4hPYK2cfV9L3jI2lp7m/ZCvBfWK5+5JJF0Y3SMPhH5ratus00JecgeitLvvTFYYIfi4TGC4X+Ovg892eTdvgq+msfapFBqmXC6hhL6JGKXuTF+ieDEZd9hr1LA5x4OohnyyvReAykFyigC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128856; c=relaxed/simple;
	bh=fDsipehTFQ1zqnPAjs6XM+Km5Z6Ld2LCDihrL1BOuaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr0TDoiIijFRlhZGFVPafE+0OLh2iuQEjjn3i0plzwixQyfah+lxZRo8ngBsU0QdzjYm9zsHYdPilZ34vX/Sqgb9w7I+fqsXP8FsPNqq81JG4v0XJ5x8yVE/sPWPRAVQGfHhzdgTSG8EM9clStZVcQXzq7owsFEuQNLrifrk9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qM2oJ7fj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eee083c044so33627431fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721128852; x=1721733652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MB8dWskGGog6BZUIVGbqIDdq5qdkeZBw32MBXf2k8U=;
        b=qM2oJ7fjytmbT16YSpv8rM47gCQOSAX/8JzHL05YSFLNrBZcQYiTn9J+QYvLW1nhTZ
         1vjcbFS3lFDvUGgt8j/KUOaB6qbpJHLl6u5og/OLYmjpt+GimT36SrUhxe65UPD6zgo4
         ZlNgMcoAKBXhjLKprNoa7l+iK9cQ/EC7aBsspxdktbge/IFDoSOqe7nwaeqHtQbrjHnp
         gNC6pyPT79KSmWKINa4nBghXmsMVl19rz3TxOVDn55LVJlQDOA06zznVO3bZhzcKbliT
         aXve1MivGXpOaYLk4n0uGcQzAgtPIf4u1JV7SnQEAeNK9IgXLMG4GYEuoRIlc1uxqRwM
         JjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721128852; x=1721733652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MB8dWskGGog6BZUIVGbqIDdq5qdkeZBw32MBXf2k8U=;
        b=Lsqdd3TnsjBjRCjNnK/cb0CwmVzip8u/l5Bl8YPTCAFfNhdqrQYWtQcWLrpMNm6oZL
         RdEgpSvF0mw5J7v3zKqS4d7GBoc+vOttx3e+ZwDXSulCkiUZvk2NxNYcY+V2oFEgFUNo
         GJejunN+gU1pw5vj4hz6MfPm9V8eCBtojzEw+g+gfxOfvH4oq9xPZVx6NiWY97+LsV77
         5Wo6mFf6NMtb0aMufq9Mp/BuYoTI48OBs3vG+toQQr+4NivIkH52AjOz4JQJkFS0lHmj
         1gmlGoMNGWF2md/IoN2uGLUyCSZs5Jyjswhk3z4stxJFNj+dQzwFqeaIvgRqcqgq50t7
         r7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf7pTpGRI1Ta0ukJO2+TKr1PrZVewYXkWsB/pn8UTIBPEjmPlfEA4NsPQhy8sGzqYFkhYoJ+ogXt4TzkxvCUKLcRmrzNZu3760Fh5H
X-Gm-Message-State: AOJu0YzpHaJxX8GTdpWiSwhbniwVNwF+NTqCb2awN5UsgDiT6U7h0N2n
	IRKBLhplkH5w7Qx61PX772nm2dm4XdkxMBiy3GZeLujVNKSDwxHcXOORgdFDeG0=
X-Google-Smtp-Source: AGHT+IHei+Ksc0Jgp1d9PgvEAOF1zzPbcYMBjOQLNyF9dppFt3bYWZTsQzp8tH4DhPGsjVWbMYFMkg==
X-Received: by 2002:a2e:9f48:0:b0:2ec:59d8:a7e6 with SMTP id 38308e7fff4ca-2eef41d7646mr12595601fa.30.1721128852263;
        Tue, 16 Jul 2024 04:20:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eee1940db3sm11336981fa.128.2024.07.16.04.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:20:51 -0700 (PDT)
Date: Tue, 16 Jul 2024 14:20:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Taniya Das <quic_tdas@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] clk: qcom: dispcc-sm8650: add missing
 CLK_SET_RATE_PARENT flag
Message-ID: <dccttz5b44bl3lwmcaqz6wjx3n4sv3eq4yh6276vzwrtkcvqcw@qxhbo7bylnsg>
References: <20240716-topic-sm8650-upstream-fix-dispcc-v3-0-5bfd56c899da@linaro.org>
 <20240716-topic-sm8650-upstream-fix-dispcc-v3-2-5bfd56c899da@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716-topic-sm8650-upstream-fix-dispcc-v3-2-5bfd56c899da@linaro.org>

On Tue, Jul 16, 2024 at 11:05:22AM GMT, Neil Armstrong wrote:
> Add the missing CLK_SET_RATE_PARENT for the byte0_div_clk_src
> and byte1_div_clk_src, the clock rate should propagate to
> the corresponding _clk_src.
> 
> Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/qcom/dispcc-sm8650.c | 2 ++
>  1 file changed, 2 insertions(+)

This doesn't seem correct, the byte1_div_clk_src is a divisor, so the
rate should not be propagated. Other platforms don't set this flag.

-- 
With best wishes
Dmitry

