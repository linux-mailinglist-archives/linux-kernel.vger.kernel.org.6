Return-Path: <linux-kernel+bounces-253840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08329327BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC431C22E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0988919B3C8;
	Tue, 16 Jul 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PeNXiryn"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB7A197A72
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137489; cv=none; b=DkAiDCrpImDlasViP467YPlYMUMtocaKwjMDtfv/LCMM7EJ663bc0yvlJL18UaKp5YoAFTBlpr07ajD8J2VfOtpdwapD51xHZcMl/GKLpYnVOuV8dG7r57TzQpexv+aZDovCb1H2CEpf0ZVLu6Ab+tA6hfwd0E6q7hBy/61d+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137489; c=relaxed/simple;
	bh=qF2z35+sMltHxOc1VgxTfEf8aDED8ki06NXvVuf7QCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXENy01AXQvK9hpEekhDClNEfny/XKcArXiuXNPOVRW+djE00f+3FKfZgrFGvR/uA6iwbKwF019TrUNIj6vTGINLIFC+POhb9xm1XszaoOkl5ZLL2ajz6I50coQi3lzXOXu2/c0R67xZFU7bBUfU0hSyA9RtUEEVcfzB4+ZXZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PeNXiryn; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-64b417e1511so52382517b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721137486; x=1721742286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hMSSp6veBmjTrsSFSHpHaaBnQdaSZwPgrQ/EgS/wyFs=;
        b=PeNXiryn8BdqicRO8oh2b9XMIACUhk9asPxHm7+2NqB1FlmdS2iYbpMAAieFMaLDSD
         XE3XQE8uh5NjhYI04P+A0YODI1BkU3jepL0eHz71VGwDCPjYtUfx3veCZktS//XXkziT
         u4sK9Fnj4PpjDFdYiaMSwdqV29OD660WSOJsZpF6MIA7H/pz9WSHBDWgtAX88qCqoTe5
         bMCor/54WsCDESeEGDUuxrSU7B6M1GZ0BPu84un9Mz4bZjijCK6NJO/+Hss3dWmgcelN
         uL7VH4cKwNRpcToV9aRXp5j1xD+RHV35Gb4in6eUs+CEiBRk61O32lc2aWMwh1BtPJNg
         1L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721137486; x=1721742286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMSSp6veBmjTrsSFSHpHaaBnQdaSZwPgrQ/EgS/wyFs=;
        b=tceVJ8R5mBmQgbSPKuevneO6ZW7b3+5mrul2nHqqtLhoTo92QdeSbHwzokyrEpCSZq
         H9OH5dz1/36CaMsglKLzcO+mtq1ROC9Dz01tzqBedXRf/q2p6PRZQs2Nwx/ywtTBu+67
         7HGpPqeode3wNsnRQEDf3D7yWuk+CHjTpfPVKWtqCHNcZwQWJkwBC9+J6TD0vO57r8O3
         Da/b2YL3tg2ZbfaR+wNtiUwQ4WS5/LuoSKYX8M706HK/MVUnTHy1C+ful/xI+VyKgi9U
         lXec+Cj1pdJ6TctgQphOCpE5a+M0kEvBLkdWCKrs9twAOmAc8bBYpsANDHq5R0ijBycK
         24Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUcaimqAmUvpQmhGD172ausk2obHpIFiIDb9q6O2Nn9uGZ1piOooOvchHOxBpZ7oAbaZbs9FUEutsQ9RDQLx6aCWrCxO6X7TIrPvHlV
X-Gm-Message-State: AOJu0Yw4LcdqyvFzj1hADPj3CtRfmhegEpEfu0wVZhiI6xfylZXacMsR
	s7MDgzML4WEbbUdCybB0WYjKOO9Ix57SP1JXLN+uaB9duu4L/SPPtZAQL73ouTWIltog9ZKr/Se
	TOYIYFNPokXoUvxg3SHuZwM8nbHD38PPECprJvg==
X-Google-Smtp-Source: AGHT+IG/rzM+ieKCxdAt0e72AO2CIHO0AW2zvcYWqKkpa7h2Gpwy3XK13dCbfyR1XJ2KNkhxFbb/u/RN2U+IHqQ03c0=
X-Received: by 2002:a05:6902:c01:b0:dc2:5553:ca12 with SMTP id
 3f1490d57ef6-e05d56cd8bdmr3129594276.14.1721137486142; Tue, 16 Jul 2024
 06:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716-topic-sm8650-upstream-fix-dispcc-v3-0-5bfd56c899da@linaro.org>
 <20240716-topic-sm8650-upstream-fix-dispcc-v3-2-5bfd56c899da@linaro.org>
 <dccttz5b44bl3lwmcaqz6wjx3n4sv3eq4yh6276vzwrtkcvqcw@qxhbo7bylnsg> <9ad10d92-d755-4fae-b206-6e8648be6d48@linaro.org>
In-Reply-To: <9ad10d92-d755-4fae-b206-6e8648be6d48@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Jul 2024 16:44:34 +0300
Message-ID: <CAA8EJpr9L+AKDhuHfQa=Nco7fvG9vLH3a+gxVhENrhz12b3n=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clk: qcom: dispcc-sm8650: add missing
 CLK_SET_RATE_PARENT flag
To: neil.armstrong@linaro.org
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 15:32, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 16/07/2024 13:20, Dmitry Baryshkov wrote:
> > On Tue, Jul 16, 2024 at 11:05:22AM GMT, Neil Armstrong wrote:
> >> Add the missing CLK_SET_RATE_PARENT for the byte0_div_clk_src
> >> and byte1_div_clk_src, the clock rate should propagate to
> >> the corresponding _clk_src.
> >>
> >> Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
> >> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> ---
> >>   drivers/clk/qcom/dispcc-sm8650.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >
> > This doesn't seem correct, the byte1_div_clk_src is a divisor, so the
> > rate should not be propagated. Other platforms don't set this flag.
> >
>
> Why not ? the disp_cc_mdss_byte1_clk_src has CLK_SET_RATE_PARENT and a div_table,
> and we only pass DISP_CC_MDSS_BYTE1_CLK to the dsi controller.

Yes, the driver sets byte_clk with the proper rate, then it sets
byte_intf_clk, which results in a proper divisor.
If we have CLK_SET_RATE_PARENT for byte1_div_clk_src, then setting
byte_intf_clk rate will also result in a rate change for the byte_clk
rate.

Note, all other platforms don't set that flag for this reason (I think
I had to remove it during sm8450 development for this reason).

-- 
With best wishes
Dmitry

