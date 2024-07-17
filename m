Return-Path: <linux-kernel+bounces-255034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0352D933AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711FAB20BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557BC17F4FB;
	Wed, 17 Jul 2024 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHgaUbjT"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857A17E901
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210750; cv=none; b=ndEWvi7E4AanvIzFzaQO2c/vXcFBUNxhbEN6cUIccQnHP6jh3Er9FNoXI7eED/EnS11i4aZjaQnUMXzGFxmfRJUq5i3320BKL+fzWT39tnqfag7qarV50AxJIOPJpbSbrxhC3BGqEvaykW3YZJYw5HRNxglqCCbMSqvUPcFTOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210750; c=relaxed/simple;
	bh=chH+ucYVFollBpWofReK7yIO2W2cQCdc+Y402fQusJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+7b5uQlzfQEvpr1qd7KEEVFHkk1cdGy132oLwFH2TI38Wkqpv4PC29qZN+MO8UB04diErCTg2vnahygOelbs33R2ZrK4qAjliKKyMLc489PAMfVKdS6PbSBPeiCtBmhxxoYXF1yDIfvB0gRuY+BzuqBEzSRwnEhlRBBkzsWk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MHgaUbjT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64f4fd64773so73977297b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210747; x=1721815547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoUdOZLlQAAmruOrbVsxcaV8sc5lR/mg/6r1PDCx+D4=;
        b=MHgaUbjTxFa4sb3U5Fe1s+s4pJjXrLw7qPqmKCOFZbVB6VLZADtVn+tKOUFmmCxJ3e
         nJ8fRj4TsTJJ0W04Bt+aL+4CUT5wOhEeME9v4GrGoVh1oBStUmYNllqbiAhCVGZkLpxV
         hz//tbw5mCesmkSJZ4mwKppTtAQG+wsSh+5JlXv3/daW29hDSDgh1EkIBnd8vG6Cyls2
         VsBovnQbDH1N6BBC9vWtXsoZDp+ATUlSY9XrOfR5bzsuxELo7EKQWCZLBao+5rDjlGDp
         k437e+X2b/wVjtisDb3bqo+njXYZVUiHrmvsrb/V+RCmql+9LcP6nH2qhdk1t00ergMZ
         mQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210747; x=1721815547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZoUdOZLlQAAmruOrbVsxcaV8sc5lR/mg/6r1PDCx+D4=;
        b=OFVrCP/z2KWi9kiX7x0qAx2+Y+UcwrE/f0ejQRYspvO6SEK3uzxBB9PRAfkTdPrRi0
         vJeAbfFUHjr0se2DYoi44Sb+GBM2WiF+YFkodE4OmSqpN9+v2PPgs/CxxQnUMwmFoOZ3
         wt3DGEANzalVdq9eot3OwVvmIzy8sHmAMNnjCRDEgaiaDdZy3EYZQy0KX7V2Xut3bbjO
         lmUWt6jFTCGAcVVHzcGBAwxFw3TJ39shmEL8m1hzPEn7NjqfNNToQEq9YWFR9zMQ+Imm
         kDbhwdhgeH/BwB+izQuVLvCh4cwaD1k/nVqC1svy5a6eE/B4+SMzx1Etbr98HQEBeSic
         J34A==
X-Forwarded-Encrypted: i=1; AJvYcCVaAJYkeY1k7sPfxsaKGiOB8polZzVs2tFfhT+s8jHDPNFmagVbsjuIMcn/cH0hJF/4XJmmpDMB161sChS1cMi2ItdlgeVn3h4DhxRe
X-Gm-Message-State: AOJu0Yz3F5k0kBKuWpCLtEVu8IZACgWGTDECqloiW0szQ3mhiJRNh9pf
	g+6bvBr1t8gbbU7+xHkzHB5QG0n+ZafpXj+beLMA+ze1Nmfl5I4wIp7huGIaFtDjHCDAuaBd8TC
	KnK45S8isBD3o6JvvrDADpUsq7O0tmMPC8LEZHg==
X-Google-Smtp-Source: AGHT+IHYh/6i/8hq7tpOwurvTcspC0p58XaYzPylkrOGMSKDPt0iy/Je6Pf446cf1ZySUgGleEGSE6zosAzFkMtIqyk=
X-Received: by 2002:a05:6902:1102:b0:e03:4ead:a32c with SMTP id
 3f1490d57ef6-e05ed6ed999mr1472948276.30.1721210746690; Wed, 17 Jul 2024
 03:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717-dispcc-sm8550-fixes-v1-0-efb4d927dc9a@linaro.org>
 <20240717-dispcc-sm8550-fixes-v1-2-efb4d927dc9a@linaro.org> <ef1e4d78-7e94-4853-90c0-73f0b80f9a63@linaro.org>
In-Reply-To: <ef1e4d78-7e94-4853-90c0-73f0b80f9a63@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jul 2024 13:05:35 +0300
Message-ID: <CAA8EJpoCtEOK=qgqKqFENiu1zCdXsBpR5EXzPZMrQQnuVMqnCQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: qcom: dispcc-sm8550: use rcg2_ops for mdss_dptx1_aux_clk_src
To: neil.armstrong@linaro.org
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 11:09, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 16/07/2024 23:13, Dmitry Baryshkov wrote:
> > clk_dp_ops should only be used for DisplayPort pixel clocks. Use
> > clk_rcg2_ops for disp_cc_mdss_dptx1_aux_clk_src.
> >
> > Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/clk/qcom/dispcc-sm8550.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
> > index 09e4b1e40e20..8ceeb17bbb37 100644
> > --- a/drivers/clk/qcom/dispcc-sm8550.c
> > +++ b/drivers/clk/qcom/dispcc-sm8550.c
> > @@ -400,7 +400,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_aux_clk_src = {
> >               .parent_data = disp_cc_parent_data_0,
> >               .num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> >               .flags = CLK_SET_RATE_PARENT,
> > -             .ops = &clk_dp_ops,
> > +             .ops = &clk_rcg2_ops,
> >       },
> >   };
> >
> >
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Oops... Neil, excuse me, I didn't pick up your R-B tags for v2. I'll
send v3 tomorrow, with your tags fixed.

-- 
With best wishes
Dmitry

