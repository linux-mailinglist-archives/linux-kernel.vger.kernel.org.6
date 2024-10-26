Return-Path: <linux-kernel+bounces-383353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E39B1A7B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 21:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A331F21D88
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708F1D63C6;
	Sat, 26 Oct 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7ktOMAd"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAEF1BC5C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729969229; cv=none; b=TVgfjH7DGlYnopDEkKCoQwux1NK/RWL8BSwmHDt7FHFMEXIayb76C3NdSZ5O4wZx61Mm6pgIDcGZwglfYs7+y2O7O/i5PRSE7jHGRdn2jxuo79OTL4EcPIIsujhIQMaVwJxh0RSYqH9bMIlNykQM9viIUyfiw8R7wgC6hT+Wr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729969229; c=relaxed/simple;
	bh=xrVsv1f3J/a+cca/uMoeNLvZWTqMW3/fAkM+gO4sxNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTpsz/l5apFdxx+wi3eKJrwMfr2+P0NZGQOXno6yFfU1LSz1lTiUOxoXGB0xmTUvTdSag71SaspeqLwi/7yJ/cL7gmgZCQnyOtF4vRnXm9Ui/TeYBi8FdomWyJd7EAEWKpMVdfyP53ACx0DV5siE37d6Zxn3yybUIELR2KLpyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w7ktOMAd; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb518014b9so24496521fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729969216; x=1730574016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0aXmywXtFQzoylk5jPq1Mx0yS1/kK3ooi5YJXNL6+g=;
        b=w7ktOMAdnMsIJsoXqnORj2KLrejdEFJdlTukV5GW6Fp8aEga3nZWEm2jZ9PK0g6Sub
         FnCJR5U0WOLLrETZZBunwCXPRF8jeedZp5GGHy5rpRrJHUJiNMoAUjt0WNVQSIMWgkA+
         sBQaOmJXQzFQMwoNgCNCHnsjT828N4PH01U3ZqCAOoYGI+qjvmGeQKpS8iucpUu2bSHj
         YrFiOjttbnRZfOYrUWpa60jeT6qzbfhMBA0DyArVvWspbFnHPf9RXfcb3GK6HMdwnU7V
         PfzTkOUpMm/Cx1bJOL3En3gFnf25LWUvbc9OAaU9cjAZ2ELJX3x7CRM7a5aCKvVytong
         sB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729969216; x=1730574016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0aXmywXtFQzoylk5jPq1Mx0yS1/kK3ooi5YJXNL6+g=;
        b=aZ0LukFMLaDoXCx+1KZzOR/h2+mNwNNQ2oVL4BsCdB3I6v6Fg1E7ajjTcwDVcKOJO8
         CGCCp+paABNmj//s/JpPWTYFUO6gX20537Kh77FFlKkx6xSDvGObkW+5OyfpHJyQakmd
         AKBmf0QbiQ9t/yb26440lAkX7gz/HCkZUIzZ7jtDdVbdwgNbWn6IGPOruYzU3O0mYqUN
         oGcKnn2gJl5cyqvpBUHjp0+ertp7XYzIA3WBZzOnAtQ2iY8cAEdHX/6Fs3jLtl8pjoMF
         LJBuj5kzFG9Yq4s2e/lTsTMZo9OVc1azERENIvqCMsPFuiwD7chp0gPpwdJBXSqrSU0x
         rEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXizfe+OfLj3lEsn6QgDySb+VqVocQQdclLlMVR6WGZHhgubHJlLOwglheasu4RHolh9eIivOYbv0ag/H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKdhw1fq3zra/IQGrX7JtDESm1R3Zt93d+QCQt7lRDTMfK5fF
	h61mDwKnhjj56XOdDRmH/tz399PGa5QcXiL7FjQtprF4YEloOVoPEMpKJ/pil/g=
X-Google-Smtp-Source: AGHT+IGu214Hc9cQ6fEog3SHe3ebMYcsV+Syoqqb9zKvV7wHW6Q1l+26kvcR25z4oE0yzUT5NcWPjw==
X-Received: by 2002:a05:651c:b0f:b0:2fb:4abb:6fe1 with SMTP id 38308e7fff4ca-2fcbdf58a83mr11724311fa.4.1729969216500;
        Sat, 26 Oct 2024 12:00:16 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4601dcfsm6216711fa.118.2024.10.26.12.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 12:00:15 -0700 (PDT)
Date: Sat, 26 Oct 2024 22:00:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] clk: qcom: dispcc-sm6115: remove alpha values from
 disp_cc_pll0_config
Message-ID: <t4erivkxr6dayt4vh3jjowdcj24dgtz3oph5rxztthbgizsani@c6ii3bt2pswv>
References: <20241021-alpha-mode-cleanup-v1-0-55df8ed73645@gmail.com>
 <20241021-alpha-mode-cleanup-v1-5-55df8ed73645@gmail.com>
 <ifbybdn7nhsw2skgshjtskijrnyfn3r3fsg4znmf2olc2esbmn@gkurcqjlddj7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ifbybdn7nhsw2skgshjtskijrnyfn3r3fsg4znmf2olc2esbmn@gkurcqjlddj7>

On Fri, Oct 25, 2024 at 09:20:37AM +0300, Dmitry Baryshkov wrote:
> On Mon, Oct 21, 2024 at 10:22:01PM +0200, Gabor Juhos wrote:
> > Since both the 'alpha' and 'alpha_hi' members of the configuration is
> > initialized (the latter is implicitly) with zero values, the output
> > rate of the PLL will be the same whether alpha mode is enabled or not.
> > 
> > Remove the initialization of the alpha* members to make it clear that
> > the alpha mode is not required to get the desired output rate.
> > 
> > No functional changes intended, compile tested only.
> > 
> > Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> > ---
> >  drivers/clk/qcom/dispcc-sm6115.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/dispcc-sm6115.c b/drivers/clk/qcom/dispcc-sm6115.c
> > index 939887f82ecc3da21a5f26168c3161aa8cfeb3cb..2b236d52b29fe72b8979da85c8bd4bfd1db54c0b 100644
> > --- a/drivers/clk/qcom/dispcc-sm6115.c
> > +++ b/drivers/clk/qcom/dispcc-sm6115.c
> > @@ -48,8 +48,6 @@ static const struct pll_vco spark_vco[] = {
> >  /* 768MHz configuration */
> >  static const struct alpha_pll_config disp_cc_pll0_config = {
> >  	.l = 0x28,
> > -	.alpha = 0x0,
> > -	.alpha_en_mask = BIT(24),
> 
> NAK, this isn't a fixed rate PLL.

clk_alpha_pll_set_rate() hadnles this bit.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



> 
> >  	.vco_val = 0x2 << 20,
> >  	.vco_mask = GENMASK(21, 20),
> >  	.main_output_mask = BIT(0),
> > 
> > -- 
> > 2.47.0
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
With best wishes
Dmitry

