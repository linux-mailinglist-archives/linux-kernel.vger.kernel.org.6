Return-Path: <linux-kernel+bounces-516432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D0BA3715B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46EC188F8CA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189821FC0FC;
	Sat, 15 Feb 2025 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="I+Ys1hJK"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C491509BD;
	Sat, 15 Feb 2025 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739663707; cv=pass; b=Wq33008AXJBGgqHwevcXUeaaTGtdNkWDIuM8nWI5Wxl9B0ANnE31Tj3HwY7LQnW4+YK1PuDCXf72ponAzI0Rpkn8Gxra6p3TqKqKAkhgIjQ5sj/ugvzihyTmptB8x+7VnmBnpj6U/hlSlh+G49S5VHAHZDuxEOX6tCZX02LxAAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739663707; c=relaxed/simple;
	bh=kXeZO5JNyko3qN725x+xcA/yyLHNw/0GxxmNbYLfHnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QronB/65hXY7pSkelgcJTmgNy4ioUXSqkTXDmYC3IV5a1vk92cCSKXzKes5r22YFXa29piZgaJhI/r3zE8xr2PmMOv/GeWs0oA/HTSdbce/WkiU1Pd/bZ8Xnr88yIY0mXrPPbRvCwmg+iNKwf1mW6dF6k5Wf1KrIrwvXKLaYp0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=I+Ys1hJK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739663682; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OB8jNtOTdSTvBuuqCwbu3QUtCBdL9cp+7fnRodE6I2Yb2JP6X0psSdQutHCRIQfOJltgip7MssM7Of/J3ctEBsEvoE57nXuYTu0ZT/wSd1C7s5uXMnjm9M5o83qc1ZlWKZi4K5WNa6/GYBBRFxGtHZeAe5lcmnmLpN5yZVkVHX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739663682; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XX8SVPjXGD/M5xwZb5E4iQN2OwwF5DZ+dOEjFgE5/DY=; 
	b=WY1OP7aPGw4XaDQj9yfTVSXewAKKZscrFxljswdn4wlcNwMzlyXP4zkPLyhSd6MpBzJX5pab1uBYqPcSpQyS3snmB2R7A+SEPUN2GlyT3I0Dt1adhZH4QFdeVmiKkpIju54bt8tZAgx/vN0fKs2Os9XUU4Si1VUJa8EL9qA9sr4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739663682;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XX8SVPjXGD/M5xwZb5E4iQN2OwwF5DZ+dOEjFgE5/DY=;
	b=I+Ys1hJK0P4WcWX+5P2t8+2v1Ng8vYYa9/5uG9pR6MD4Mw23LTFg2cH0wYPoZarl
	CYyIxb+vTbXspYMOcPjiBiS937wR14eIGfYYactlKhjEOZE4iY8kF8re6r8uqvjpZeb
	N1GbaLuYwKXTRaLPeWiUDJHutsxn1KvClLsfQsUw=
Received: by mx.zohomail.com with SMTPS id 1739663679905558.4270282900428;
	Sat, 15 Feb 2025 15:54:39 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kever Yang <kever.yang@rock-chips.com>,
	XiaoDong Huang <derrick.huang@rock-chips.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	kernel@collabora.com
Subject: [PATCH v1 0/4] Add Rockchip 3568001/2 errata workarounds and enable ITS on RK356x
Date: Sun, 16 Feb 2025 02:54:27 +0300
Message-ID: <20250215235431.143138-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Enable GIC ITS support on Rockchip RK3566/RK3568 SoCs by adding
necessary GIC erratum workarounds and moving RK356x PCIe MSI to use
ITS instead of MBI.

Dmitry Osipenko (4):
  irqchip/gic-v3: Add Rockchip 3568002 erratum workaround
  arm64: dts: rockchip: rk356x: Add dma-noncoherent property to GIC node
  arm64: dts: rockchip: rk356x: Add MSI controller node
  arm64: dts: rockchip: rk356x: Move PCIe MSI to use GIC ITS instead of
    MBI

 Documentation/arch/arm64/silicon-errata.rst   |  2 ++
 arch/arm64/Kconfig                            |  9 ++++++++
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 14 ++++++++++-
 drivers/irqchip/irq-gic-v3-its.c              | 23 ++++++++++++++++++-
 4 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.48.1


