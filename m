Return-Path: <linux-kernel+bounces-303888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF4961685
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A231F2163B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0E31D3180;
	Tue, 27 Aug 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MqRSE37Q"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111A1D279D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782355; cv=none; b=Z1L/Tm4zd8+Mpil2SWAepdtSNTbmpM5hM2NEO2dK4pdbzVXirUlT7ORVld3Huz+vHOI0VXYdInWnG8ONsiGTOMh6gqZ9rYxvtVSLHJoODbPuEOeXlg9QywI9Cf0+OGRWa5AqdAbCp2twDy4IpEwgTx2Eh2M4rrPUpqqdQiuiEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782355; c=relaxed/simple;
	bh=2Gq+2musOhFx/RMETG21n43RSloaFRXCaGyo+L3E4Wg=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUP7ekptteE9oMzdjbGGwCDd9LQ5z0DiurpzTWN5IWJk6Fm+oqCFugOcWYTlCPCalZev5lLyhxRsAC1Yqi953cya1RwzJ2NvFOun+kdfyQ98y/bD+8X0QlGjpkhSmYeqxhKHwS9No2pSwLdltJeRr9UFbstc2XSv9/eilOCPku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MqRSE37Q; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db16129143so549410b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724782353; x=1725387153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+UZugxSnKhmm7RFCDsmleDRPP8DXg1UAuzoT1y4+P4=;
        b=MqRSE37QYR6tDVPksZ7r+UQJrE1wWQCz/ZDGXZEHnPoIqYDPTHnyBBqhGboHLS1N/D
         Zkkc4v1QBEabawegSsFJrvVa3OFdLh/WNjVnbX9nLoDcXwLAKiMScsCpmDtuxs/6vhm/
         hkbkbf2/Nc5eUvt8Vy15xLvTTaH8RqjOeIAvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782353; x=1725387153;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+UZugxSnKhmm7RFCDsmleDRPP8DXg1UAuzoT1y4+P4=;
        b=BsQLr9qIhPuOHlvvhqEnjk2XSO7ePPnq1gEZBfe59WE8igoKJUzOFjgSvl8Am5IMqp
         Z3kr203p+nqC1giJ2+AOnr7Jc8LctaDLT4Ol1PrxvwNh5NCVy0xzea6AOuV6D1AahgkK
         RrcWe+3EYyNVUDrELIBnZw+5TDMExNr+rQZ5r1vdZDoCg45zqEEqRrq+Bb/Lm8e5TA9E
         4YaabMzgh596FctaLhd2cumHIw1jjZ2NkjThEX0zpX3e7RKzVTKjLYld3xqGX77nBEI+
         DbNVzq6po/TpiEjt+nwXxi/TkMwfzztogVWjLgkT5fnbcJmTRhgqH0Hdzq3Gmy2NVReO
         aFQQ==
X-Gm-Message-State: AOJu0Yx0pMDH7rq/O/uS+HgH38Fu3xG8RXZZMa1CulpFHUzg1heovBwT
	U2s+3MMFzJWullTfkVVBs7DPwAn74Ej6EhzdZzLH+OdmHrPxX9Lju9mn8QKkUc2d02GB+9O3KDu
	3/PjLr3zwpsWX2tMICVy1tVi4J+nRvp7vO/Hi
X-Google-Smtp-Source: AGHT+IGl0H4rNd8NW0ENgt9xGW7rk51tX57pU2aohNgYNq8W5Pr4zVblVKQwHr9lpbRFsQig9r5rX8R15eQqRrrD7jQ=
X-Received: by 2002:a05:6808:2118:b0:3d5:4256:26d4 with SMTP id
 5614622812f47-3de2a86e26amr17368925b6e.7.1724782352645; Tue, 27 Aug 2024
 11:12:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Aug 2024 11:12:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240819233628.2074654-3-swboyd@chromium.org>
References: <20240819233628.2074654-1-swboyd@chromium.org> <20240819233628.2074654-3-swboyd@chromium.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 27 Aug 2024 11:12:32 -0700
Message-ID: <CAE-0n52rYVs81jtnFHyfc+K4wECvyCKmnHu2w9JhPNqvMYEeOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: qcom: gcc-sm8550: Don't park the USB RCG at
 registration time
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	patches@lists.linux.dev, linux-clk@vger.kernel.org, 
	Konrad Dybcio <konradybcio@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Stephen Boyd (2024-08-19 16:36:27)
> Amit Pundir reports that audio and USB-C host mode stops working if the
> gcc_usb30_prim_master_clk_src clk is registered and
> clk_rcg2_shared_init() parks it on XO. Skip parking this clk at
> registration time to fix those issues.
>
> Partially revert commit 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon
> registration") by skipping the parking bit for this clk, but keep the
> part where we cache the config register. That's still necessary to
> figure out the true parent of the clk at registration time.
>
> Fixes: 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon registration")
> Fixes: 929c75d57566 ("clk: qcom: gcc-sm8550: Mark RCGs shared where applicable")
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Closes: https://lore.kernel.org/CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/clk/qcom/clk-rcg.h    |  1 +
>  drivers/clk/qcom/clk-rcg2.c   | 30 ++++++++++++++++++++++++++++++
>  drivers/clk/qcom/gcc-sm8550.c |  2 +-
>  3 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index d7414361e432..8e0f3372dc7a 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -198,6 +198,7 @@ extern const struct clk_ops clk_byte2_ops;
>  extern const struct clk_ops clk_pixel_ops;
>  extern const struct clk_ops clk_gfx3d_ops;
>  extern const struct clk_ops clk_rcg2_shared_ops;
> +extern const struct clk_ops clk_rcg2_shared_no_init_park_ops;

I'm considering inverting these two rcg2_shared clk_ops so that only a
few clks are parked at clk registration time, to minimize the impact of
commit 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon registration").
We're up to three or four band-aids, that we can probably wait on
applying if we make all the shared RCGs determine the correct parent at
registration time but skip the parking, except for the display clks on
sc7180 where that exposes another problem with shared parents getting
turned off during probe. It's possible that other SoCs will want to park
their display clks as well to avoid that secondary problem, but it can
be an opt-in case instead of a change to all shared RCGs.

