Return-Path: <linux-kernel+bounces-381917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037BD9B0647
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D97283B06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3313B787;
	Fri, 25 Oct 2024 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCWnncXf"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC01384B3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867998; cv=none; b=FQeKkov9efYYWyaNmvWjxzd9Df+8B/U/lb9uDs6bmG+8s5d4tMQ51gSKXKaS3gQB0L3/G0Vadb84Mnj3upkNzmAwzUSM//rR9u08jYEvRguk3owAwVqwtBoCQ1LYNTaiRj8q3EhRkWdUhdmYVwNicQuo4i3TjgeabsI4ea+JWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867998; c=relaxed/simple;
	bh=RkxaRv1gHOBT5sh/vvRuNysi24qX6kjeWyH6s3MjGn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLr2FE4n6B6uQGWu+XD85eEXuiJROQbnoPP6qhfINBXw21fQCi6ZWPf023fV89JB5xmKKlYzha4EdIfBaKChktlrJiOmzhfZuGIod6y9ke/3qt8Kg/G9nIioD7kdzZ5q0PXHMtlWK7f1pqfq2tJu2o7/+bmz2YTJxuvn6RG8xKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oCWnncXf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53a0c160b94so2568045e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729867994; x=1730472794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlD/UX/UlEtCuduPsSkXnCNtF99PZp3JNh+pZLqHh0U=;
        b=oCWnncXfiu5uT5bc5lDFE3Z0rcAr0v3+EpE2fytXfG5HI9U7VhV2aZ5C3em6GCtyOO
         jGloDYv0pe8Dz0W7wFa3sfIVN2ZtFNbLHsFO8SPXBTxGtjiYtkPr4XJDR9mnbOCofF/9
         5ooEsgraIevam5zHluy7Y6DjruMJRsd9nhaPynsVcbc9aqFRfrfulnUoYIdHQ9oAOkNW
         4IFAvOAIUfSNZyoqD+M+ROWNgIoI7f9eFjiIKMFUAOTqprwYbjxRlchLrGcWvQyLUjOW
         lmCSaX9+duYuY/MiqN5hrDjWEh6yhGCCktsGQD9H3hmJqFHt1DfqGTD7jN/F7LO15vOK
         6RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867994; x=1730472794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlD/UX/UlEtCuduPsSkXnCNtF99PZp3JNh+pZLqHh0U=;
        b=Y7ib80TIli0QFQFiBRW1rZl+GokvxSRPjy3OzFFS9hTkBKUqZck1iZskBbkfDTZPMU
         80Wrprgg+wnzOPPCXvd5xukq9iJFmTgElv2lVw0otWd8JiFLOHhBQkWRpzxh7A1QS1mD
         TO4vA0EvOrYg3jk/EccTUS2DXvC5j2o+xNPUIwoP8s7pIP2NPzTP78qgO8oFkb5NWt8C
         tAxKmwN/y20lKAZHw9Mg1bVAXJltN8/mWK2WgY4l8hGJHIcaIJJBphU7B2OgJodiyfyB
         l77J6+iTrKryuFrLF8S0d2IhC5DWKOIFUglFPToft8h/sLjfMXl1zkEPjmQbvPM00Sqe
         9Ztg==
X-Forwarded-Encrypted: i=1; AJvYcCWTS/DtPr0xMNGP4GChvrw1ke84NT5LayH0Pumpnh0Po4v3XITnaMrJyhz0RqoDsOvX5XDYcjh25JI20SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfW6qcEddXyB5oC8mPZpLsSRZsK7ONFtSgdhzXI+3IZSdOmOP
	u9Ne3tgCZqvu8CxY6pdPw/7JWjcx28dZD9ShUyFrxucKQrQ4c4R1rG527DKrzXFHkwRqO2K96Ft
	6
X-Google-Smtp-Source: AGHT+IGYL7YFASRGtXttT1u3S3dz3+QkWO94FgOJfA6qslUxvxu3N5rdwJmVrNF6PekjkBHAAKd4gw==
X-Received: by 2002:a05:6512:31c1:b0:52b:de5b:1b30 with SMTP id 2adb3069b0e04-53b1a36196amr5948206e87.44.1729867994390;
        Fri, 25 Oct 2024 07:53:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1dcbbdsm208100e87.236.2024.10.25.07.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:53:13 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:53:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] clk: qcom: rpmh: add support for SAR2130P
Message-ID: <as72zsmycangcy7yyivavpwb2p5wptvbnvyfycrdoaz3kqrcle@luj3hgoqffri>
References: <20241021-sar2130p-clocks-v2-0-383e5eb123a2@linaro.org>
 <20241021-sar2130p-clocks-v2-7-383e5eb123a2@linaro.org>
 <73abe2b9-ad72-449f-b3e3-a96128cf75a4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73abe2b9-ad72-449f-b3e3-a96128cf75a4@quicinc.com>

On Tue, Oct 22, 2024 at 12:03:57PM +0530, Taniya Das wrote:
> 
> 
> On 10/21/2024 4:00 PM, Dmitry Baryshkov wrote:
> > Define clocks as supported by the RPMh on the SAR2130P platform. It
> > seems that on this platform RPMh models only CXO clock.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/clk/qcom/clk-rpmh.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> > index 4acde937114af3d7fdc15f3d125a72d42d0fde21..8cb15430d0171a8ed6b05e51d1901af63a4564c4 100644
> > --- a/drivers/clk/qcom/clk-rpmh.c
> > +++ b/drivers/clk/qcom/clk-rpmh.c
> > @@ -389,6 +389,16 @@ DEFINE_CLK_RPMH_BCM(ipa, "IP0");
> >   DEFINE_CLK_RPMH_BCM(pka, "PKA0");
> >   DEFINE_CLK_RPMH_BCM(qpic_clk, "QP0");
> > +static struct clk_hw *sar2130p_rpmh_clocks[] = {
> > +	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div1.hw,
> > +	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div1_ao.hw,
> > +};
> > +
> 
> Dimtry, could you please add these clocks as well?
> 
> DEFINE_CLK_RPMH_VRM-- > rf_clk1, rf_clk1_ao, "clka1", 1
> DEFINE_CLK_RPMH_VRM --> ln_bb_clk7, ln_bb_clk7_ao, "clka7", 2
> DEFINE_CLK_RPMH_VRM --> ln_bb_clk8, ln_bb_clk8_ao, "clka8", 4
> DEFINE_CLK_RPMH_VRM --> ln_bb_clk9, ln_bb_clk9_ao, "clka9", 2

After checking the CMD-DB, I can see "rfclka1", which I can add, but I
don't see clka7/clka8/clka9. Are you sure they are present on the
platform?

I'll add rfclka1 only for now and skip the rest.

> 
> > +static const struct clk_rpmh_desc clk_rpmh_sar2130p = {
> > +	.clks = sar2130p_rpmh_clocks,
> > +	.num_clks = ARRAY_SIZE(sar2130p_rpmh_clocks),
> > +};
> > +
> 
> 
> -- 
> Thanks & Regards,
> Taniya Das.

-- 
With best wishes
Dmitry

