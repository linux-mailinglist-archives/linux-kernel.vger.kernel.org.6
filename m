Return-Path: <linux-kernel+bounces-347326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45EA98D11C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1851F22D2C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDF61E631D;
	Wed,  2 Oct 2024 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ZAUbyOdm"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302652F56;
	Wed,  2 Oct 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864560; cv=none; b=DZ4qTdv0sfAs+dyXToiaLwpqH5ZNTvpYiN33eats7Glwe0LsXVJOEYRL/+usxSC9nnMMeaymZQPCx3zr7mrYCftixpaQYQblNJqze6jAF+XWj70U+44XeiB5NCv0ShzQnyLo5ZQFSqPVHanBO3vXFFSfr0UyrcCGCQb2sGq5iEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864560; c=relaxed/simple;
	bh=mJKvs9FLRZJEhIPy4X5obYmCOTWrv4Y6lROopBRIP0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvrYeDLGMQz+H4r/3iHoa1UPj+g/Bqtqiz85/laGdpwsAQzgWUeduEwS/N/ycEb9qu/6UriNG6Grn7lgMXydFYZqlCVL2RorqrXBvs9rWsnKbAK6JHK+K0r/8XwqvIdgFhXsLq0E3AlDBWsX6nNCwe7QXBTBAMOB8/aYGifT7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ZAUbyOdm; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A677D23CB3;
	Wed,  2 Oct 2024 12:22:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpG7VOy15MuO; Wed,  2 Oct 2024 12:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727864557; bh=mJKvs9FLRZJEhIPy4X5obYmCOTWrv4Y6lROopBRIP0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZAUbyOdmY1iWScCGppAp8saDjp7y/6eUmxNQjbT2zYu8/q+STLhhrCjb2J7gotCOk
	 7aY3oWJuqtLAjs+jIQnqNjP49GsKu4jI8yWHKMk5bS8yiCn2Kl/VMABiBPDhuXka3H
	 QMbFMNBfardQhG/pTgPFNy3inTf396+nbzZitoiMuN75kO3rJcGhiqUmm785U6PaxB
	 nW4xm7PttncmUtKOOK+0FTbZttA8nWJo3szNesn1s68Y4YK+O/rLh6fyPYjyJj+eZ0
	 jpWrZIRt4V8ZVs2VJMeTWeKxmYCGpn7isvCXFUA0thlmj3fNoXo44GP/1dsiwPsR5G
	 DzuEwFqnAas2Q==
Date: Wed, 2 Oct 2024 10:22:15 +0000
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
Message-ID: <Zv0e1_9AdNASLQMr@pineapple>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <8495918.NyiUUSuA9g@diego>
 <Zv0blIPaF0Y2Pmn1@pineapple>
 <3798659.MHq7AAxBmi@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3798659.MHq7AAxBmi@diego>

On Wed, Oct 02, 2024 at 12:12:11PM +0200, Heiko Stübner wrote:
> Am Mittwoch, 2. Oktober 2024, 12:08:20 CEST schrieb Yao Zi:
> > On Wed, Oct 02, 2024 at 10:16:49AM +0200, Heiko Stübner wrote:
> > btw, for the documentation, is there any technical reference manual
> > of RK3528 available publicly? Please let me know if it's true, it will
> > be quite helpful to understand clock tree better :)
> 
> Sadly not. So far there hasn't been a "leak" yet and Rockchip also seems
> to have gotten more restrictive for whatever strange reason, so with my
> NDA I also only got part1 of the manual.

Oops, sad but also much thanks.

Best regards,
Yao Zi

