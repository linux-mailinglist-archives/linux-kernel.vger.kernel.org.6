Return-Path: <linux-kernel+bounces-347310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D4998D0D6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3BCB239FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95E1E5018;
	Wed,  2 Oct 2024 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="k08CTneI"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD491FA5;
	Wed,  2 Oct 2024 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863728; cv=none; b=sMeVNGoitHPV6wGwNe0eimzVqCgORFthM8ojO8zz1majZts/SrF73MrM1AKp7D91XRKtCZ6dNaqB7oy2mEE7J3ToH+2DRFSjVI9ixzrtfQICTJ8Fg+AUqIhqYu8D3yVl6hG4oqM1we3pGBfxLSB5qWwlCw/XHWmZ+09SfRG50iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863728; c=relaxed/simple;
	bh=xq5qb9kkulN99Q7U1ADjv0fIaGu8fXT6nM4OPnQEMNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2zPpjmX4/3bOs/DS0YXt2K9r4kRtO0x/ljqP5aF/jTn1W5dL6FrC5oXHZLoGLMc0aPTn+rzO3xyXfqZruFzDLP7Hy3bddqCIUndNWi3RCGBGQp7lB9UHYFez/kqvBl0cuo9lqsrP4WmAzpk9itAxF7pK9JxXZlAZWxVPlnVHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=k08CTneI; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1354A23CC7;
	Wed,  2 Oct 2024 12:08:45 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FrrN-HP1gQTM; Wed,  2 Oct 2024 12:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727863724; bh=xq5qb9kkulN99Q7U1ADjv0fIaGu8fXT6nM4OPnQEMNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k08CTneI4AItkWuzjLybxLenme2gBwIs85Ei4+GWmwungB65VZfEcqVVePxA0zQn8
	 MltM5BlWd7ND6zsi9H8SJZJpYPVotoPeTB8KmTD+Z+2b4FG0TlVGPBDk48PWz/l7v2
	 LN07NTXjAWXmpiSrloB9q4ThtSrfL8PPOpPhgneOEynNMthh2JbEmnteSOr9UlIC5O
	 SH0ZA/I6WiJ0kjK0NUvK5HN49IXx8ny0YPyKjHBPordPdpWiXwfJ3rIRT4EIRo9anf
	 XTeaCY0FUg1u7gHMuf3bmOKi7gz2KwCg4s1J71Q7MUL8PD5SdBRMMRHrkTpW+o1c1k
	 /rP5fnuiUrdLQ==
Date: Wed, 2 Oct 2024 10:08:20 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 4/8] clk: rockchip: Add PLL flag ROCKCHIP_PLL_FIXED_MODE
Message-ID: <Zv0blIPaF0Y2Pmn1@pineapple>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-6-ziyao@disroot.org>
 <8495918.NyiUUSuA9g@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8495918.NyiUUSuA9g@diego>

On Wed, Oct 02, 2024 at 10:16:49AM +0200, Heiko Stübner wrote:
> Hi,
> 
> Am Dienstag, 1. Oktober 2024, 06:23:58 CEST schrieb Yao Zi:
> > RK3528 comes with a new PLL type, flagged by ROCKCHIP_PLL_FIXED_MODE,
> > which should operate in normal mode only. Add corresponding definition
> > and handle it in code.
> > 
> 
> More commit message would be nice ;-) .

Good idea.

> It's the PPLL for the pcie controller that is specified in the manual to
> only work in normal mode. This is helpful for people reading along :-) .
> 
> Heiko

btw, for the documentation, is there any technical reference manual
of RK3528 available publicly? Please let me know if it's true, it will
be quite helpful to understand clock tree better :)

Thanks,
Yao Zi

