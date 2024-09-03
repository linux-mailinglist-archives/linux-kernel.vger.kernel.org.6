Return-Path: <linux-kernel+bounces-313080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE9C969FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356E61F25C46
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D716C184554;
	Tue,  3 Sep 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7hw1Bbi"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E1153BE4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372502; cv=none; b=dIdSFyvCkkm/WcMXet2wIOKa2Lw1kiINJkY3+DCPwK3UH0WrezRV/PUHzC8wGS+Y7tFza/gpjJD2PVILiUywhDBKnfiLgal+5P8USUBr+HEYGaoXWckHhSdv8WBMmWhyV9Orfixi1017TbswNh19CornrqjMx1GBc+giSzdEMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372502; c=relaxed/simple;
	bh=PYDFmhH004F05lzTv1GKSY6wqwPlgkWOeG78AnecACA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlwuVb8735lyVQWlv9/cTS3VTanS/dqgSKntvsXJlu48gBTfx2Dz/2dv3V1Da8ckCCizdMj4OEoDDta/qWmUUIsmIA7hzbEklfTajRkbyxyMAoBjERCcaUOJG1LS/likPu9rWwi3RVUeMUn6DsK3RxSEuVzG5VUtQq32n/yzgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K7hw1Bbi; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e026a2238d8so5478192276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725372499; x=1725977299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5ZjoGlDyH7WTupR02DGYrQPD4B+RoOSwZCsEGdWmkU=;
        b=K7hw1BbisNJx5otamQIxk1hHwG5B4EC2JZqcORHEDloateLWrWiSodBieuhpsBuUsv
         13wlGzTQN77jbZ9mz2iTptDDNJIYqIUr5ewbDVqXCJ+jGPSkW3O0NVe1guwIKCg8ahIV
         uftMGPw3ElDbFTuiJ3eqrc0wYXBpyZ6kHU1k1vqJVLljMy+NtcgEkLEaLL6uUv2Gqg8g
         m8PaqNe3IBKGV69BRq2IPh/CTuedzjhvwEHjqCHS6J2S8crDtPRGrxB3Qk20CFBALIQd
         Gefb3oRtpRW5OnbldLdbr+JELHGPJ1IGwQxapn9njlBI2vb/yJi+RSYpAiWfbZuCDUcG
         o6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372499; x=1725977299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5ZjoGlDyH7WTupR02DGYrQPD4B+RoOSwZCsEGdWmkU=;
        b=G6IdI5rX6A9AnUoIkjd7A8jq0YNC8rGiyEWMw3IoZXO4bGIfXlxzXFYQERlJcb0cvf
         Wtj7O4Vu0OKPzcT9V3E5n+liKs2ASECGUlVy0Tt4z0uGm1eLfArRJJwfGIcxsUzCnbq0
         D3OEePzP4YPmXXa4oke9c0AL583DP9fI5ZSyqOh/15gx282LMJ8p/HkEoysVp1HZ3trD
         4S1mBqBImVDKFMqjAL15ls7jNTLWQedjvtyb9SzBSZqzfV8cUUgexVXYauKS3ARwCp6I
         ksGA/vZyeCE0MzW3AvW1HsWT9kjymh2zk+oYZr0ZsvuecaW1JAenxfNRklu4p7eCX+jn
         p2og==
X-Forwarded-Encrypted: i=1; AJvYcCW/W6yBERAt+/qYtaqZ1gBKUJl7PhtxP6Dfs0j802uqlkk7FhGJyw9MC04sY2BlKMcWgm5Ox2p6Vo4BHes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjlNFfsPeO2G5a3NkMHm/34iqFmLkT227LhPaVytqnWUdG2L6
	ucbch9K1RcvuDSpTUCEyPEoFP1F9uKa9oV5nxP+Ko00hNwteqjaH7Xh/aClw9UfP8Oab2T2U9PL
	bIlDpkL/UzUU9sCD4bOrMZCSI4jH/ByDyIPk0ig==
X-Google-Smtp-Source: AGHT+IHOJqt3dK+xwatmPRONcTjksoCVRekZUAmbh32HsEjF/j6bm6l8pQayA56IIHJJvdniQqggzEe+KANvQ7eVwtc=
X-Received: by 2002:a05:690c:4706:b0:664:a85d:47c6 with SMTP id
 00721157ae682-6d410cb4214mr110396847b3.33.1725372498831; Tue, 03 Sep 2024
 07:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827-qcom_ipq_cmnpll-v3-0-8e009cece8b2@quicinc.com>
 <20240827-qcom_ipq_cmnpll-v3-2-8e009cece8b2@quicinc.com> <d7b374670eb2f6d442f351106ab1221a.sboyd@kernel.org>
 <7f4d41a0-b1b9-4b63-8590-63f4fcf1a359@quicinc.com> <7736d0d0-634d-403d-b70f-f33b7402456c@quicinc.com>
 <04944b77ce6327ba5f4ec96348a9cda2.sboyd@kernel.org> <ecc34401-68c2-463f-b630-6a81ad95625e@quicinc.com>
 <6sk7sx4pz2gnne2tg3d5lsphmnp6vqjj2tjogqcop7fwn3yk3r@ftevsz77w6pt> <492e3c19-c06d-4faa-8064-e6b73c46b13e@quicinc.com>
In-Reply-To: <492e3c19-c06d-4faa-8064-e6b73c46b13e@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Sep 2024 17:08:07 +0300
Message-ID: <CAA8EJpqSFp_cETNE_3iiC1viLhPD5TE+H1F=m8UksybEpAvKHQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] clk: qcom: Add CMN PLL clock controller driver for
 IPQ SoC
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com, 
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com, quic_linchen@quicinc.com, 
	quic_leiwei@quicinc.com, bartosz.golaszewski@linaro.org, 
	srinivas.kandagatla@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 17:00, Jie Luo <quic_luoj@quicinc.com> wrote:
>
>
>
> On 9/3/2024 2:39 AM, Dmitry Baryshkov wrote:
> > On Mon, Sep 02, 2024 at 11:33:57PM GMT, Jie Luo wrote:
> >>
> >>
> >> On 8/31/2024 6:24 AM, Stephen Boyd wrote:
> >>> Quoting Jie Luo (2024-08-30 09:14:28)
> >>>> Hi Stephen,
> >>>> Please find below a minor update to my earlier message on clk_ops usage.
> >>>
> >>> Ok. Next time you can trim the reply to save me time.
> >>
> >> OK.
> >>
> >>>
> >>>> On 8/28/2024 1:44 PM, Jie Luo wrote:
> >>>>> On 8/28/2024 7:50 AM, Stephen Boyd wrote:
> >>>>>> Quoting Luo Jie (2024-08-27 05:46:00)
> >>>>>>> +       case 48000000:
> >>>>>>> +               val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
> >>>>>>> +               break;
> >>>>>>> +       case 50000000:
> >>>>>>> +               val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 8);
> >>>>>>> +               break;
> >>>>>>> +       case 96000000:
> >>>>>>> +               val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
> >>>>>>> +               val &= ~CMN_PLL_REFCLK_DIV;
> >>>>>>> +               val |= FIELD_PREP(CMN_PLL_REFCLK_DIV, 2);
> >>>>>>> +               break;
> >>>>>>> +       default:
> >>>>>>> +               return -EINVAL;
> >>>>>>> +       }
> >>>>>>
> >>>>>> Why isn't this done with struct clk_ops::set_rate() or clk_ops::init()?
> >>>>>
> >>>>> OK, I will move this code into the clk_ops::init().
> >>>>
> >>>> This code is expected to be executed once for initializing the CMN PLL
> >>>> to enable output clocks, and requires the parent clock rate to be
> >>>> available. However the parent clock rate is not available in the
> >>>> clk_ops::init(). Hence clk_ops::set_rate() seems to be the right option
> >>>> for this. Please let us know if this approach is fine. Thanks.
> >>>
> >>> Sure. It actually sounds like the PLL has a mux to select different
> >>> reference clks. Is that right? If so, it seems like there should be
> >>> multiple 'clocks' for the DT property and many parents possible. If
> >>> that's the case then it should be possible to have something like
> >>>
> >>>     clocks = <0>, <&refclk>, <0>;
> >>>
> >>> in the DT node and then have clk_set_rate() from the consumer actually
> >>> set the parent index in hardware. If that's all static then it can be
> >>> done with assigned-clock-parents or assigned-clock-rates.
> >>
> >> Thanks Stephen. The CMN PLL block always uses a single input reference
> >> clock pin on any given IPQ SoC, however its rate may be different on
> >> different IPQ SoC. For example, its rate is 48MHZ on IPQ9574 and 96MHZ
> >> on IPQ5018.
> >>
> >> Your second suggestion seems more apt for this device. I can define the
> >> DT property 'assigned-clock-parents' to configure the clock parent of
> >> CMN PLL. The code for reference clock selection will be added in
> >> clk_ops::set_parent(). Please let us know if this approach is fine.
> >
> > What is the source of this clock? Can you call clk_get_rate() on this
> > input?
> >
>
> The source (parent clock) for CMN PLL is always from on-board Wi-Fi
> block for any given IPQ SoC.
>
>  From the discussion so far, it seems there are two approaches possible
> which I would like to summarize below to be clear. Please let us know
> if this understanding or approach needs correction. Thanks.
>
> 1. clk_get_rate() requires the parent clock instance to be acquired by
> devm_clk_get(). Per our understanding from Stephen's previous comment,
> it is preferred that a clock provider driver (this) does not use the
> _get_ APIs on the parent clock to get the rate. Instead the parent rate
> should be passed to the clk_ops using parent data. So the parent clock
> should be specified in the DT using assigned-clock-parents property, and
> can be accessed from the clk_ops::set_parent(). This seems like a more
> reasonable method.

assigned-clock-parents is necessary if there are multiple possible
parents. As you wrote that there is just one possible parent, then
there is no need to use it.
Stephen, your opinion?

> 2. Alternatively, if it is architecturally acceptable to use
> devm_clk_get() and clk_get_rate() in this clock provider driver, we can
> save this parent clock rate into a local driver data structure and then
> access it from clk_ops::init() for configuring the PLL.


-- 
With best wishes
Dmitry

