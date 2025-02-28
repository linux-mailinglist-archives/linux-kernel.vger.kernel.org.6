Return-Path: <linux-kernel+bounces-538727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FC5A49C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA091891305
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB22702C2;
	Fri, 28 Feb 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gc0Zx0+K"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1392686A0;
	Fri, 28 Feb 2025 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754400; cv=none; b=SUoGPaO+g3rnGrib0FMixgiGJvaT3SEzBLFvEktSOqfEgZN818BVkYPxBN2XCu39+E+fO/ZWlOS+AtURUymZUaEzgTFbxn86BbWzoexK+xl2QlKqt/T/i0LUWHADXKDM0hw2RNHr4hoVWaaV3mX0TFm9MXD5vj5tq8eBkayCdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754400; c=relaxed/simple;
	bh=wdIQ7vUQ7x92S2Va/xZB5CNU6OC3vUqW5+VjhTMkLJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdJ5ltbhinRxGGvcTmlyGrtkbXhO5Fe6A2tDIgY5BKzFMHPAZPtN89Ujb/wSb+h3aGek91qcn2lfvLUI4QaIMmSBPzRusWZ1XULXOK16k+QQBb2byA5VvVW0ibYiZDvmlTYh0RsOiUBQxs6ueCzbnVZ6luiNyXZs3naXIHOfsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gc0Zx0+K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740754395;
	bh=wdIQ7vUQ7x92S2Va/xZB5CNU6OC3vUqW5+VjhTMkLJo=;
	h=From:To:Cc:Subject:Date:From;
	b=gc0Zx0+K0yAfUIVS1KGT1nscNtSaU2c0+JgPWBomF97LobjS18ILBHWe60X0Uh8uN
	 V2SJ73ZbvNibCJIgQzskhV6MWkhk9h26hs6IA1QRP8JTTUxrh9ZQBJzzLz1d0vOJOy
	 XTkqgXAGV4QyVvdkWuzBMcOuC4YXR/SyKi3Ae4lhXgxoRtma0MSE5HIkYU1prp2dL9
	 Ij2W39nTBMLAjecKpCUTyhGcaqyTo6M5EALLeBUC7NgBOYey9pIHp+naurRdBYiNi9
	 OrsDINbS/Fdyfe7sm8pHXEIYNzjuR20H/WBesWS/eJwuZm0lPLwBTZn6U5PrJ1Y9VV
	 uqSoVWPofNmJA==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4388117E0AFB;
	Fri, 28 Feb 2025 15:53:13 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Stephen Chen <stephen@radxa.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 0/2] Add SPI support for Radxa ROCK 4D
Date: Fri, 28 Feb 2025 09:50:46 -0500
Message-ID: <20250228145304.581349-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The board comes with a SPI NOR chip connected on the FSPI0 interface.

Add the SFC nodes for the rk3576 SoC and enable sfc0 for the Radxa ROCK
4D.

Detlev Casanova (2):
  arm64: dts: rockchip: Add SFC nodes for rk3576
  arm64: dts: rockchip: Add SPI NOR device on the ROCK 4D

 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 16 ++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 22 +++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.48.1


