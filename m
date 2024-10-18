Return-Path: <linux-kernel+bounces-371403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023FF9A3A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7751F250D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CFD201023;
	Fri, 18 Oct 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIM3AfgM"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B3200CB6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245415; cv=none; b=g4qG81cODNfVU7ZjedB4jAX+QNS2eVhyAVTa5ZanCumKgZTUgFpFB8U5ROl8D/QxGUFLrPkiEFVV6ZnIgh+YDctEsE0KE75J8rpycqoCeYKceiHYBDJCFnMDPAAKBaq8XWE7v9CZqZZQBlx/Qo6lMpNCO8tEj/2ah7+CuSGg3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245415; c=relaxed/simple;
	bh=7F02LSuaYG6QJFBmCRDKkgg4PK0fEcpJQMSscDg7UlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft9gZ/zYkqPfWvqv88dzzIgJDwjgCamVngaaGTvoofJ3ynbog7Oa7vmVKQ19dq0RNreom7uk81koV7w9/yJQY7o2rE9dxAbwzD6q93NXSmWQDT/Y+RYCDxhowuJaN9yRZ8VTtc9bNtlo2fiVH040x7r/qXHVsLq4Trcv83jtA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BIM3AfgM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb599aac99so20685511fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729245412; x=1729850212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LNTOM/u0GLXGMOI0m9ADZhvsMR3Q86VPixhtk5oFIY=;
        b=BIM3AfgMvpJS9rTaYmiGjRV26sQbxtxXSenjIjGpWs9EsiCbI64jdLUP3cuNkjK+Ag
         6kuEi3GZg8X87YyOGjBwJkUSP4ISP4nye58NfH8GU0Kmg9T1BsRJqG87qwg5Rx8EP9c2
         qkLOQvVdopL+v4k7lvXnuu3D+AdZN8YpHv818PYI+yqw5r/UUe+bSmNldKvqFOiPkUS7
         7yEKf8MLDn+yG6mp9bQmpH9e8waoXstOUK6EnAT18eUAiFxpqORiEuRq4zYgTDSu952B
         DW2AWmlJLL5pCzeUiaxgncBGZ9iQH6sQ1kbVZcK1AcnpzuMjXCoiHV3Wv7ZUL/tMKCX3
         oEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729245412; x=1729850212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LNTOM/u0GLXGMOI0m9ADZhvsMR3Q86VPixhtk5oFIY=;
        b=h7Ap8chRfN8wgCaByX6Md7af7lI6a2vOjnUnegsOFuN1kkYwQH3l9txur/uNkdjfwa
         tMzmXlYNEtHsngVkk+WSFiomYr6tXzJdedNP5ShFnvBiqBFkayXxQi/NopgIWFl61RSg
         vedLT/qAEQiHRcEjpGwTbrt1h1p19iB33yyKnzcB9RKQVYP06BzsMn6jXfS+2HtCSao6
         CGn3AyS0SBm2wm8Y5iOq+Ltt/Ds1AwGk3efOhYj/84d1j0Y756okORysvJM0XfBzzRs8
         APrJfAs8dIFLhBvGyTDSIGqv8I/BEWEfMnb8lRpjvlNO8iUbvoSvRFSF+nC3bpXL1ZVn
         iu3g==
X-Forwarded-Encrypted: i=1; AJvYcCUKEU4yUSVeP9aNS1yCoytRdfTv/ac/S04JrtOF5JIcN8vMSoSvgpTqs+UON873qZOKy2E/NPOnMOyBRrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrydXpR5/1qwHxZxqYgWsBGv7cZKYiNqhz1PoBGHcuOVgfJ9H
	vkzpSvRHD1OeZGLZSwyWjfnJU0NOKg6XRSnbnWas45OtrI5KsXp+JzRtMeGemEE=
X-Google-Smtp-Source: AGHT+IGeK8KzMr9lXPmuFDOy4a4IgVl3STdpDnUlPNvFi3vc36Dx0SsuLqG1dmfqX8sdyi9pbmxBAg==
X-Received: by 2002:a05:651c:211d:b0:2fa:cc12:67de with SMTP id 38308e7fff4ca-2fb83208e04mr9201491fa.32.1729245411950;
        Fri, 18 Oct 2024 02:56:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809a6a7dsm1776881fa.10.2024.10.18.02.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:56:50 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:56:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kalpak Kawadkar <quic_kkawadka@quicinc.com>
Subject: Re: [PATCH 07/14] clk: qcom: clk-branch: Add support for SREG branch
 ops
Message-ID: <scwpcovoazmd4yrwtczghx4e5eopqoknknqzcr23wjve65bmxh@ih5efkh53g3h>
References: <20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org>
 <20241017-sar2130p-clocks-v1-7-f75e740f0a8d@linaro.org>
 <be8639d0add779bcac0314d3c433d01b.sboyd@kernel.org>
 <we4stuv7td5jmvicsvsjowqg76merg5lmlgqj6dvqvqecsw7xk@bfz2kdjnt6kb>
 <5904599efffa7ce747772c0dcc1c897b.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5904599efffa7ce747772c0dcc1c897b.sboyd@kernel.org>

On Thu, Oct 17, 2024 at 03:28:13PM -0700, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2024-10-17 15:00:03)
> > On Thu, Oct 17, 2024 at 11:10:20AM -0700, Stephen Boyd wrote:
> > > Quoting Dmitry Baryshkov (2024-10-17 09:56:57)
> > > > From: Kalpak Kawadkar <quic_kkawadka@quicinc.com>
> > > > 
> > > > Add support for SREG branch ops. This is for the clocks which require
> > > 
> > > What is SREG? Can you spell it out?
> > 
> > Unfortunately, no idea. This is the only register name I know.
> > 
> 
> Can someone inside qcom tell us?

Taniya, could you possibly help us? This is for gcc_video_axi0_sreg /
gcc_video_axi1_sreg / gcc_iris_ss_hf_axi1_sreg /
gcc_iris_ss_spd_axi1_sreg clocks on the SAR2130P platform.

> 
> > 
> > > 
> > > >         u8      halt_check;
> > > 
> > > Instead of adding these new members can you wrap the struct in another
> > > struct? There are usually a lot of branches in the system and this
> > > bloats those structures when the members are never used.
> > > 
> > >       struct clk_sreg_branch {
> > >               u32 sreg_enable_reg;
> > >               u32 sreg_core_ack_bit;
> > >               u32 sreg_periph_ack_bit;
> > >               struct clk_branch branch;
> > >       };
> > > 
> > > But I'm not even sure that is needed vs. just putting a clk_regmap
> > > inside because the clk_ops don't seem to use any of these other members?
> > 
> > Yes, nice idea. Is it ok to keep the _branch suffix or we'd better
> > rename it dropping the _branch (and move to another source file while we
> > are at it)?
> > 
> 
> I don't really care. Inside qcom they called things branches in the
> hardware and that name was carried into the code. If sreg is a branch
> then that would make sense. From the 'core_ack' and 'periph_ack' it
> actually looks like some sort of power switch masquerading as a clk.

Ack.


-- 
With best wishes
Dmitry

