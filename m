Return-Path: <linux-kernel+bounces-537178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEBCA488E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FA37A8976
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9B26E955;
	Thu, 27 Feb 2025 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nVizH7JB"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63226E648;
	Thu, 27 Feb 2025 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684062; cv=none; b=bzmFNItQxuN8PUXx7ts6Gf3jjHaJ8GJhlNdC/eVM5JqQbNaevk6B229viJsIcrb72BVA7RkrXdqGsYr48EpCQNGCMFtUR11mdIE1Izy4cErGnvx5llbkTrL2/4g1dr4n+8cJVap28DnIwtzxFRv2W6ofs7lOg8yCvSy6x3/zac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684062; c=relaxed/simple;
	bh=LAHYGW6aEdOPky0rkEil/TkK8FvlUee/5AdEvTj1Z8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W12eL5DtcYfCy8U+5beXwHPHnZ4QMtmHDv5ju00+s1iKVGmz275Ao9T8Xb6ezhi+f7LU2jFprO0y/oQcHJTVWvB6tuupOxewO1rxUXRCY1tA4O5w35Ra2ohx0GEZ3S5vaTOIaacrrjsgXtYMFQhADT6s8TiM5fkWBziJRB/Z4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nVizH7JB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2nIp4OdR2z6qhnWaz8PyWS7YQAJ1zv2iXHLQMFhsuG0=; b=nVizH7JBdfpOazpQiOrbNj8tAP
	j9rufvbQMJimYcjaEfKd77ViNwf0qSPWJOVH/yUqtMt+OxFUXhRZdXrJFbvIce5YlwPsZvKu2zjO8
	99uDyEjVdQo8q22Fz6W8v53xISBjS7lLqlMMkCpt1fR2r6o1imVUbzETr0FvZbIShSwGIyLc5elOq
	taaaNJuET4c7R95LkGIsad9vPH8/FP69c5jd6+kcYfsLiGSrgqvvMcLV8lwt5GiiSUwEs4CDM9zMY
	Rw13ZGBkkl57hbmB3fYm4LoT616yaZRZcmW+RIGdc2fpaahZHFxpCVQ9FJnAPmZswk9NdYxSeLihd
	OwLQF5DA==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnjRF-0003cw-He; Thu, 27 Feb 2025 20:20:53 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Yao Zi <ziyao@disroot.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] clk: rockchip: Add reset lookup table for RK3528
Date: Thu, 27 Feb 2025 20:20:52 +0100
Message-ID: <3022099.BaHzMo0RvP@diego>
In-Reply-To: <Z8CzMNI_1CjUgSrl@pie.lan>
References:
 <20250227175302.2950788-1-jonas@kwiboo.se> <Z8CzMNI_1CjUgSrl@pie.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 27. Februar 2025, 19:47:12 MEZ schrieb Yao Zi:
> On Thu, Feb 27, 2025 at 05:52:57PM +0000, Jonas Karlman wrote:
> > In the commit 5d0eb375e685 ("clk: rockchip: Add clock controller driver
> > for RK3528 SoC") only the dt-binding header was added for the reset
> > controller for the RK3528 SoC.
> > 
> > Add a reset lookup table generated from the SRST symbols used by vendor
> > linux-6.1-stan-rkr5 kernel to complete support for the reset controller.
> > 
> 
> Thanks for completing the reset part! The patch looks good to me, but
> 
> > Fixes: 5d0eb375e685 ("clk: rockchip: Add clock controller driver for RK3528 SoC")
> 
> I wonder whether it deserves a Fix tag: to me it's more like a new
> feature. Please correct me if I'm wrong.

while one can see both sides, I agree that the Fixes is unnecessary in
this case. I've applied the clock controller mere hours ago and it was
not broken, just missing functionality ;-)

I've applied the patch now, and removed the Fixes line.


Heiko



