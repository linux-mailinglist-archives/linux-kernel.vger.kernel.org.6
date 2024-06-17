Return-Path: <linux-kernel+bounces-218295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0030190BC32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CDA1C22C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0714B199259;
	Mon, 17 Jun 2024 20:30:42 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7018FDD6;
	Mon, 17 Jun 2024 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656241; cv=none; b=DFBm2IgF/DL+tAcTFLtXHH9r8ihUuqx15NvCy8UBIxmw/6yTHmXRV9DYOrXe6+k8+G2vjJdTsTTP9R083UfTEWIQ7jw2TJsmxFSDwxWIuwDJAzEAQ9sGroN0h8qEvFt1NGiKMforYeqVgT9rcerWemzcWY6lMUmbg+dmtvdS6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656241; c=relaxed/simple;
	bh=82nr2wqrnMIAbD4IDcYEq25agDxWcQZ1RLNzuw+uTsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr+bQG2Mp7oyTtxIPucEdS9fEwmOQhDFdG0G8uuql93LhEERXhqPTpRrLJUsGD+7AnbcPP4RI/M4bBmqrCVopxumjxN6rsbLa5bdhj8PU6o8oa8PvEAXqJccc/lClCncMN7LH42YJAsEyF9mk6oS58Y5S9ERN68m6SXPVPP2Vs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c2.versanet.de ([94.134.22.194] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sJIzi-0003be-1t; Mon, 17 Jun 2024 22:30:26 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Yakir Yang <kuankuan.y@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
 linux-clk@vger.kernel.org
Subject:
 Re: [PATCH 02/13] clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228
Date: Mon, 17 Jun 2024 22:30:25 +0200
Message-ID: <19757196.sIn9rWBj0N@diego>
In-Reply-To: <20240615170417.3134517-3-jonas@kwiboo.se>
References:
 <20240615170417.3134517-1-jonas@kwiboo.se>
 <20240615170417.3134517-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 15. Juni 2024, 19:03:53 CEST schrieb Jonas Karlman:
> Similar to DCLK_LCDC on RK3328, the DCLK_VOP on RK3228 is typically
> parented by the hdmiphy clk and it is expected that the DCLK_VOP and
> hdmiphy clk rate are kept in sync.
> 
> Use CLK_SET_RATE_PARENT and CLK_SET_RATE_NO_REPARENT flags, same as used
> on RK3328, to make full use of all possible supported display modes.
> 
> Fixes: 0a9d4ac08ebc ("clk: rockchip: set the clock ids for RK3228 VOP")
> Fixes: 307a2e9ac524 ("clk: rockchip: add clock controller for rk3228")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

did your mailer have a hickup? Somehow I got patch2 (only this one)
2 times



