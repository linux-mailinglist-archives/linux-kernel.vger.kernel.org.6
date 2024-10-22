Return-Path: <linux-kernel+bounces-376023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023899A9EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A240C1F22937
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB73A198E7F;
	Tue, 22 Oct 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9WBJG16"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF32198E6F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590152; cv=none; b=vAG7ceY8Oo90wCfieMNuRZjL12sOm3IfVaSKO130RSEZo6by5eEmYRXBHwFYHoeasZJBl1lobQyNh9Ct9R6WqX+YY5S5+NyzWNCFYg3YtreMYHSuxMUIWcgOT9YV1AaK0eaCVYxOGPVokZ2npqwYg9yiHck2KmiWcOa85keNU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590152; c=relaxed/simple;
	bh=HuAY5n51adJLfl9SSuBb/Ym7ySTk+KcEs66eV3O0sS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pne56zHiWLQvTZt6cxr9uCxxZfiA6Yeh/sL56GeSxBN6j4st0gCVEpJHlk1lJFUcYEs/Ly1JeD5PBdMaSbrPThFVpjhMAmADSkKzo/RGLBlkkQF82BP/DO1hjLOXnsRa26gGcGD6Npv9XPi8CChl4uJSaMFrfK4LMs7NWxf7qhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P9WBJG16; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e34339d41bso47770057b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729590149; x=1730194949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kvPBUHYcPgoJ7bNqomFz1zo5qrkinbCt2cqO1I0haao=;
        b=P9WBJG16tHg3sgEqDGLKt9d/WZ3O73vb9cwzPSlAKfocAfwoXBzDahBPzNn1t8kLLT
         q8raHH+CuZoqVnrT9331XdK9KaWcMGdTOf8b9F8wVp+6Ml486yUjFkceuhrzekJU/nR8
         cudsvoalMNCxXXa1myQz1Kb63nS/XtlDTM/KvsIqYXrBVCAVrONwFdL4olO6+NZaDUVu
         T/7JA2Ult4cmG6HZBz+Rw2v73l54fU7wRKD2lTRMT/kTx1zJqG9wuOXcr+NX4uah5kmz
         ssGtx+An8ERlA5thYlaqo9dgRcvEGB5rHgnQFI2+HMOAi0IXC3vHVsr/tvoKNx2aIEgQ
         8uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590149; x=1730194949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvPBUHYcPgoJ7bNqomFz1zo5qrkinbCt2cqO1I0haao=;
        b=LtgUiVUHADumlrAV+hvoT/hgLEnaafGynGOaNJfThFcgap55jgLJ8DL3iA/3BEo2Bf
         FAHDBA7MaEkJyCyo2O5d+UCnnpd8HEfvzhKJL0DQlHapgMABARByJYjGBDt4QF/zia2n
         DHXfgjuz9gx8SzFaHuuqOHnVh8xWAzVmMicvWaPVAlrypUkF/2tGXa2VNH7gHVmls1b4
         QdX5mIe20Y0x+RnBB+9pyQr4LlVpix00/81l4mmYu9ru6rFJWh5AqcXZkcK8PO4KHo1g
         hFlLKrwgXOTtKlM5h7yJY6JGfmDiYK3MSDZU8Wed6RSk9OAGxMPUrQzJVOsMyrhZRyVR
         cqrA==
X-Forwarded-Encrypted: i=1; AJvYcCUEj/VBWwQO+jkZkAcq2Lz2a22f3oKUcoM1bCH+2/zeI7rOROdZia2I+xrElclkftXSjF+dsQj28zUKcRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5qMcSr5vfz5uHp7IXWk1a+iMu6I+7qJEsLghqIIlktjPW4sP
	q3QVkuujTHFj63k69tfLCg8FhWQNxnxuUOxBsO7uR8dvZZcvEQ5e61/4sqCoqi2JPHEVb/MRgSj
	OKGvdtbK24AKUKo2dfpLtzDVIyTc5W4WK7D+uTA==
X-Google-Smtp-Source: AGHT+IGnUOtYmX5ZH6+sexWWxd3fc/JZBgGGYU1bAhBppjpfROT2I4TY5FJU9HPUqqv2SGgdLdfvXK6BIRqS07uaRk8=
X-Received: by 2002:a05:690c:4b01:b0:6e2:1062:9b90 with SMTP id
 00721157ae682-6e5bfd89b4dmr148306427b3.44.1729590149614; Tue, 22 Oct 2024
 02:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-sar2130p-clocks-v2-0-383e5eb123a2@linaro.org>
 <20241021-sar2130p-clocks-v2-7-383e5eb123a2@linaro.org> <73abe2b9-ad72-449f-b3e3-a96128cf75a4@quicinc.com>
In-Reply-To: <73abe2b9-ad72-449f-b3e3-a96128cf75a4@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 22 Oct 2024 12:42:18 +0300
Message-ID: <CAA8EJprmVyzyWJaE_rsH84Z4uDK1kvQgAzEScV3mdONv4qXAsg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] clk: qcom: rpmh: add support for SAR2130P
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 09:34, Taniya Das <quic_tdas@quicinc.com> wrote:
>
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
> >
> > +static struct clk_hw *sar2130p_rpmh_clocks[] = {
> > +     [RPMH_CXO_CLK]          = &clk_rpmh_bi_tcxo_div1.hw,
> > +     [RPMH_CXO_CLK_A]        = &clk_rpmh_bi_tcxo_div1_ao.hw,
> > +};
> > +
>
> Dimtry, could you please add these clocks as well?
>
> DEFINE_CLK_RPMH_VRM-- > rf_clk1, rf_clk1_ao, "clka1", 1
> DEFINE_CLK_RPMH_VRM --> ln_bb_clk7, ln_bb_clk7_ao, "clka7", 2
> DEFINE_CLK_RPMH_VRM --> ln_bb_clk8, ln_bb_clk8_ao, "clka8", 4
> DEFINE_CLK_RPMH_VRM --> ln_bb_clk9, ln_bb_clk9_ao, "clka9", 2

Just to check, I don't see these clocks being defined in msm-5.10 for
the corresponding platform. Am I missing something?

>
> > +static const struct clk_rpmh_desc clk_rpmh_sar2130p = {
> > +     .clks = sar2130p_rpmh_clocks,
> > +     .num_clks = ARRAY_SIZE(sar2130p_rpmh_clocks),
> > +};
> > +


-- 
With best wishes
Dmitry

