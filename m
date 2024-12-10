Return-Path: <linux-kernel+bounces-440497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0353B9EBF18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FC91887EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F03211260;
	Tue, 10 Dec 2024 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Fvt3fmai"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105731AA786;
	Tue, 10 Dec 2024 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872389; cv=none; b=YRGhAV8ZrY3JBqolsYL6+/uNIGHwht98d6NntTdJMzyTLnr9pTdZQiTjoXPFSKpWG+JMjB8jsj+XeeXhq5jOdK5oMUMj+dUMKjuyC/3lbADLTcZHBBjSNjVpUOnhIoMhc2S17J7X4rV9PlGMhyRqo8WPtOMWCuJSzqv3914UtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872389; c=relaxed/simple;
	bh=rwSI/k5t1lP3PQ+ti+TGoJ2AZ0ITXnabjNI4Oct44CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R24aSqJ2FD962RQaBfhyp+rAsjQzD4f2rAsTolVzOaWiiHyxg/NE2mlmfkLs+KMsSlkqo2zeDCSSs4JajIYSXFrXwnHLG2+f6BRAEc65zyy9lrFbefMoHPGaOmq+XaSnQiH+XyOFl1dITH4HRLQ9o32wEzt3hTPZ1I8BaMLhKNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Fvt3fmai; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a6qMZJoDhXUbvrzz8pOdo34xzZMBBlZ49Lix3rFbxyQ=; b=Fvt3fmaiFWWht9AoPwUG+KIf0p
	12noGPd5E/Sp8r3lrbpNIs3BSUMyILLWEq33ywtYHA0n/dwVmueG/+vzSQBkYATKDHnEoCnXeZGla
	WTx26uZYi4XR1sRSr3EsLmYb++KbsTg+V9Raxn630JkmsFQstRXtJ9koraEs85oaD3ZqTTYKK8Lql
	P+9aySQBo6X2+OWyKwxuIivL8WJEgdScN6N1KnsJhmtdYrik8NessFkk5S8pFGhGUoANuh+713CZc
	26jjlvijLyPU6c4CeF3XQxOkL4QE+X4A66tLcngqctCnOH/IHr0bHaBboFFsaBaUHTgCIW++JftBy
	JZfuo+0A==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tL9PZ-0007R7-RF; Wed, 11 Dec 2024 00:13:01 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	hjc@rock-chips.com,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: (subset) [PATCH v5 00/18] VOP Support for rk3576
Date: Wed, 11 Dec 2024 00:12:58 +0100
Message-ID: <173387236508.2374456.8629854054013827389.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209122943.2781431-1-andyshrk@163.com>
References: <20241209122943.2781431-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 09 Dec 2024 20:29:10 +0800, Andy Yan wrote:
> Thanks for the basic work from Collabora, I can bringup a HDMI
> display out on rk3576.
> 
> PATCH 1 is a carryover from the working when add support for
>     rk3588[0], is very usefull when some people want me
>     help debug some issue online, so I really hope it can
>     be merged at this round.
> PATCH 2~8 are bugfix of rk3588 alpha blending which report and
>     test by Derek
> PATCH 9~13 are preparations for rk3576 support
> PATCH 17~18 are real support for rk376
> 
> [...]

Applied, thanks!

[02/18] drm/rockchip: vop2: Fix cluster windows alpha ctrl regsiters offset
        commit: 17b4b10a0df1a1421d5fbdc03bad0bd3799bc966
[03/18] drm/rockchip: vop2: Fix the mixer alpha setup for layer 0
        commit: 6b4dfdcde3573a12b72d2869dabd4ca37ad7e9c7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

