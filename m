Return-Path: <linux-kernel+bounces-254996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B35933A43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619642817CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58917DE29;
	Wed, 17 Jul 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSPdeGXt"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B3178CC5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209754; cv=none; b=FL0gXpXW12CVMg3V0J/oQpIKEHd5t0LVi/BPbGG9L63gZO+ThY5F7z3u5uP7iuvZ4GmgjLe9yBbaidmRZt6YywWx5Egh/P/81VfzZ9DVA9ih2c9A52GpjyEY3VQQX0tF6TakwyeB8+f/tr1ho5RYfRTTkdFt8Rf0LqK+j7NJMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209754; c=relaxed/simple;
	bh=drdFYOrEjEZZrQPn6blYFIY9QhufSQCcwyTzafmSIHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elPYDlMDkINHX4DAY3OCvmOSHmcTr0GTtGks2iM8E1xJ0dkb/Ov4CxS+WAEcJQBcn3IzKOCaqZTaHCt3dDniwMizNQYqlFe5TtVzN3cDwxKonTJ1z/4D0u2Cz5cUebQIWpra/CRiXS2+Rn3eVi51iRVSnS0fbpkURGjwriQIecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VSPdeGXt; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-65fc94099a6so38858397b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721209752; x=1721814552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LL2uY9ouT8695FraeZM3uIpWSuZKwhAInrpmi+yLgbM=;
        b=VSPdeGXtUq3LDXlfUm7MAyQINhPS8/mPB4tkgq9Sv4NRPo6Q1p/K5Q4+KrkMMvlHgL
         B9+JKZtAphoCYnkYbn4WC+46OOJG8Ud15V42lf5/XIoGPgcrV8tVICgKjp2V9nvgRLQK
         uB2xVYELCSqie4GgOKH9h+GlTkRsvhvNjv+TPmskCIcu2x4GzGzQ6PZMqWGVBxtYYW7E
         vt6zD9Rn9S8rubzWVxKLE4rEMCL1f1zL2hiTXDadGrpyAanpb/oxtVahwLcxruVEN9/s
         hlqNs0RUro5gYOO0u7m1NiXDuAeOJihYT4C/xUQPNMZxWdRrwtTDGZZ2h8PoPClSarzq
         7udQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721209752; x=1721814552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LL2uY9ouT8695FraeZM3uIpWSuZKwhAInrpmi+yLgbM=;
        b=FCVOgYJPxiZCWpw1DsqxnWvluWYjGye7oo9MoFDsR0DYVFaGUkHb7muK1nYqpXcIRn
         nMmUGJwAg708NSJi8YeaDAL4MwnU7aNiZiuJkFlV/hzt2zpH+FQQ23mAHr4LQ3ZIWWWQ
         XUk6K3u9dHC6soYw+OiecxMY+bkS+t6Kkq3IEUPveVxYHYRoXQE6K5OfubslyI2F1CBX
         +IFCeDp4gR2YpuWIXIdsGceHe36G9iapmxBhYn3J1wKCyda6oGCCjKb5h4LGD0BcZniv
         bFfTdcd+U/DJ1SI+IwANS9Sjg7jGd1UndaxNZXyt+N+n4864oMO6HFocaRQXotplfzwe
         UWtg==
X-Forwarded-Encrypted: i=1; AJvYcCUu9JvO++V+LqYrzgIn3VTVz5CVd9bI+UMjcAndf7s/HlsqxgLlVoN5xYfLPOJmGNyq3/RL7DUz8mcqCC57867uB874uHBneXBHcLnN
X-Gm-Message-State: AOJu0Yywlta/SeZh0eE1Giz3WKJZqhDqjcixSfzuZ5z0utc9A1Fokl1V
	5GruQjBiKYC70Xdmo7j/xA9WW5Pssa8q8+WJHxM1bHQPYdO9Gq+P+4z6cobyMQstLtQLOLHSZkN
	Gn5w6EA+/7o+GPPWG8ai4UmB46uySO6yBtYefEQ==
X-Google-Smtp-Source: AGHT+IHjmMFD6c3evR25tinvxOr2rkpD+ML4O2P6BsHhDsyGohpJopMXy1cyYtbnmZhlLNx7godvFt8mE4znoTGHtng=
X-Received: by 2002:a81:77d5:0:b0:664:4b9c:3ec with SMTP id
 00721157ae682-664fd78f3bamr16513537b3.10.1721209751656; Wed, 17 Jul 2024
 02:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717-dispcc-sm8550-fixes-v1-0-efb4d927dc9a@linaro.org>
 <20240717-dispcc-sm8550-fixes-v1-1-efb4d927dc9a@linaro.org> <d60cd97b-a1da-4dbd-910d-92cd62762afd@linaro.org>
In-Reply-To: <d60cd97b-a1da-4dbd-910d-92cd62762afd@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jul 2024 12:49:00 +0300
Message-ID: <CAA8EJprvS-bM47BTmgtA=9NunW1Lpy-9dLdYmSy9RuL6JyQENw@mail.gmail.com>
Subject: Re: [PATCH 1/7] clk: qcom: dispcc-sm8550: fix several supposed typos
To: neil.armstrong@linaro.org
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 11:08, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 16/07/2024 23:13, Dmitry Baryshkov wrote:
> > Fix seveal odd-looking places in SM8550's dispcc driver:
> >
> > - duplicate entries in disp_cc_parent_map_4 and disp_cc_parent_map_5
> > - using &disp_cc_mdss_dptx0_link_div_clk_src as a source for
> >    disp_cc_mdss_dptx1_usb_router_link_intf_clk
> >
> > The SM8650 driver has been used as a reference.
> >
> > Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/clk/qcom/dispcc-sm8550.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >


> > @@ -1146,7 +1146,7 @@ static struct clk_branch disp_cc_mdss_dptx1_usb_router_link_intf_clk = {
> >               .hw.init = &(struct clk_init_data) {
> >                       .name = "disp_cc_mdss_dptx1_usb_router_link_intf_clk",
> >                       .parent_hws = (const struct clk_hw*[]) {
> > -                             &disp_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> > +                             &disp_cc_mdss_dptx1_link_div_clk_src.clkr.hw,
> >                       },
> >                       .num_parents = 1,
> >                       .flags = CLK_SET_RATE_PARENT,
> >
>
> This one is NAK, I checked and on SM8550 the parent of disp_cc_mdss_dptx1_usb_router_link_intf_clk is really disp_cc_mdss_dptx0_link_div_clk_src
>
> I checked on the SM8650 side, and disp_cc_mdss_dptx1_link_div_clk_src is the parent of disp_cc_mdss_dptx1_usb_router_link_intf_clk,
> so it's different on both platforms.

Interesting. On sm8450 disp_cc_mdss_dptx1_usb_router_link_intf_clk is
also sourced from disp_cc_mdss_dptx0_link_div_clk_src (at least
judging from the driver file). I'll drop this chunk and update the
clock from the sm8650 branch.

-- 
With best wishes
Dmitry

