Return-Path: <linux-kernel+bounces-410838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B69D9CE1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C291F23056
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFACC1D45E0;
	Fri, 15 Nov 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="qhmIrwRV"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205811BBBE4;
	Fri, 15 Nov 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682051; cv=none; b=R9O5Xr0xI6p8y566zGEKvwL5YZc1uMzQhwBisvUkyIbeYGz1+tNJx4JDCLfYk7Y+MErTPHB5R1I1Mj9uYFGa4W8my3ZZF52BNUHFkey/zbKcT4nCHe94CXqDjzVirgz9MN/BBI1GRycNVeGMUMST8S9ORGNwMhSZ3F6vObh2rMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682051; c=relaxed/simple;
	bh=Qg8gnVAsmfCB/g7+xbU0TVaPP29VNMj1CAYSqDn76Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyBYNZqhQD/bluWtq/gu6jn1RTyZ/wt2R/ZHtkdMfyH8FPwxUOz2pwyFNM9oHMHX1DXyOeFyy85Bi/1oqzV1Tm2Q5i8Fre976l6Rl9pTPvjmVEJpxRwHfVoWU2Mz4svXpEb64LLuQvsNtUwRUZRSvWcOUjDy597gdI3Mqwr+vmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=qhmIrwRV; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 069631FABF;
	Fri, 15 Nov 2024 15:47:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1731682040;
	bh=dEafRjM9IWWfFCvBUry05pVj1A8yYFWrnbi6Fe6UClU=;
	h=Received:From:To:Subject;
	b=qhmIrwRVvBxbRBpDh+0Cndd7H7nsHSH1iQwB+RU1HjFWFGA/ccBxUuSpSLWYs4lX/
	 GtRu+OmFXYLqXpsOG4rNgzvkA/EAa6NIlgK1qro/Gq/wAIvwjXJi1AomDpEtzrvX4W
	 NlSpqSreFmjXDIm4wqKcY6OnJSmUlNL4Bk8Dvf5Q7L8bx9/D5qE8IgtNbrByFg75zq
	 2qq8R8fa7Q49KMMFFdDL001NvzWZQafkiqV5bTLgYfP0eMBgJO14za7ofXy5RII266
	 tXHayEA+eydm1jiFD35vxDy5eQ11sL/HwxHsFByit33wmpYpKDjJ9p4c9jH0j1sxLi
	 K+rTZenRyeg/Q==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id A6EFC7F9AA; Fri, 15 Nov 2024 15:47:19 +0100 (CET)
Date: Fri, 15 Nov 2024 15:47:19 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Adam Ford <aford173@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mark Brown <broonie@kernel.org>, ulf.hansson@linaro.org
Subject: Re: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on
 v6.12
Message-ID: <Zzde9xS0zGJhcoUb@gaggiata.pivistrello.it>
References: <20241007132555.GA53279@francesco-nb>
 <20241112075958.GA8092@francesco-nb>
 <20241112092054.GA18139@francesco-nb>
 <CAA+D8AO3a5WsZ4=V-9CDifDZYjJjwQmQQDDQM7ZKgZ6_-CNDPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AO3a5WsZ4=V-9CDifDZYjJjwQmQQDDQM7ZKgZ6_-CNDPA@mail.gmail.com>

On Fri, Nov 15, 2024 at 11:13:58AM +0800, Shengjiu Wang wrote:
> On Tue, Nov 12, 2024 at 5:20 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > On Tue, Nov 12, 2024 at 08:59:58AM +0100, Francesco Dolcini wrote:
> > > On Mon, Oct 07, 2024 at 03:25:55PM +0200, Francesco Dolcini wrote:
> > > > it seems that an old regression is back on v6.12, reproduced on -rc2
> > > > (not sure about rc1).
> > > >
> > > > The original report is from https://lore.kernel.org/all/20240424164725.GA18760@francesco-nb/
> > > > and it was fixed with https://lore.kernel.org/all/1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com/.
> > > >
> > > > Is it now back?
> > >
> > > I was able to reproduce this issue once more, this time with 6.11.7.
> > > As I wrote in another email the issue is not systematic as it used to
> > > be.
> > >
> > > Any idea?
> >
> > Frank, Shengjiu, could it be that the udelay(5) in imx_pgc_power_up() is
> > too short and therefore we have such non-systematic failures?
> >
> 
> Francesco,  it seems hard to reproduce it on my i.MX8MP-EVK board.
> 
> If it is easy to reproduce on your side, you can try to enlarge the delay
> time to see if there is any improvement.

It's hard also for me to reproduce, we just have a relatively extensive
test farm and 2 times it happened while doing unrelated tests. I was hoping we
could have some idea on what's going on, I'll see if I can put together some
kind of stress test, being able to reproduce it more systematically would
certainly help.

Francesco



