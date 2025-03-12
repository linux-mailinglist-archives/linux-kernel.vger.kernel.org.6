Return-Path: <linux-kernel+bounces-557343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B53A5D793
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6738617A341
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E222FF42;
	Wed, 12 Mar 2025 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="kpFBKee7"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3F22B8C1;
	Wed, 12 Mar 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765612; cv=none; b=tUUYjFVbSNZNd8zZJeemCXf29gmwfsXS+ikYyQzle7roKiUcQhzxOTbredu/abbVb/P2OTV96FSXKj+XktOHJSZWjRb+TBcrsVpat9IzNqvO0YKYVlGLeeMrDlFrr8i9WzVX+rYopIjHcioXYlRCh7yLCG4huDcs6HLdP5qmmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765612; c=relaxed/simple;
	bh=TAqW1YuAZHAKFKALClxmB/FC2ZS1vo1TN42U8pGIXB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6PdxOca9N+eBD4D/sRgG1zZOGjiFmvRteXkLcO6KrPQMtMkXCUZ+rzmAhyVv3bHV63DhWjHIi/KjGoFOEkuq4BFl3cyhiW3ksSsM2LY3I6ybWzoXk78ZjRyFt4+Po6JRq/qCT7xjusA/FjmrNH8aRcD3kw+2E9QmExc71oNaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=kpFBKee7; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=i5XPMcckjmDVkHGDw8w21+ux0A2sZ5HJ62F/iHvIQ+E=; b=kpFBKee75VSxjlRgtAgD1lkUuR
	dYMVNKJQY/VTwFqstKyHjwOIM/AICZIX+vNG8twShJ9imJOk4/hs1yp/IEPMVOMl6amC/2GiEr1Ye
	2sfTgboFTOF89X+krJN/pUPpw8dlEkL5GGnA3aQbf3admlFKKEk6dNraDp1VSAy/bK052EQhnCKRL
	nIx7MO/YZGwHbBkU/B/Ve/1lq1fljszLVvECU9QU1/7J7NXAZCxmN9FXOX5qnatycMWhuo8V+9YZ2
	v53XU4KinGhFX7exrtU7xh3ofBVo1uI8aR9+cFx2EjqIiAkagzZL/NCEs8RuT4V/JUcuoBSMB31Kf
	exN84kGA==;
Received: from ip-185-104-138-79.ptr.icomera.net ([185.104.138.79] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsGnY-0005zY-HN; Wed, 12 Mar 2025 08:46:40 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liang Chen <cl@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix CPU and GPU clocks on RK3576
Date: Wed, 12 Mar 2025 08:46:01 +0100
Message-ID: <174176555624.249409.2523115865031259262.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310-rk3576-scmi-clocks-v1-0-e165deb034e8@collabora.com>
References: <20250310-rk3576-scmi-clocks-v1-0-e165deb034e8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 10 Mar 2025 10:59:55 +0100, Nicolas Frattaroli wrote:
> As Jonas Karlman pointed out on the #linux-rockchip IRC channel on
> Libera yesterday, mainline has once again chosen a different set of
> clock IDs compared to downstream, with hugely detrimental effects to
> mainline's ability to use SCMI for clock operations. This is because
> TF-A will use the downstream IDs, and when we reclock things through
> SCMI, TF-A will get the wrong clock ID from us.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: clock: rk3576: add SCMI clocks
      commit: 33a409dd1fc8be5ef8f33ebed76856c4cbc5bc15
[2/2] arm64: dts: rockchip: fix RK3576 SCMI clock IDs
      commit: 825f48a12e597e7556768088b74f3384840df5e6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

