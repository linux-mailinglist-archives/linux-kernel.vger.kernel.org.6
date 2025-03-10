Return-Path: <linux-kernel+bounces-553919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5558BA59099
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A58188F2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878BC225A29;
	Mon, 10 Mar 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="H41kcfGV"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4C18C02E;
	Mon, 10 Mar 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600873; cv=pass; b=ZOTc5yktWf4bS7PeU9RBynShLDSt9IrANoY89RO6kK0qO3M382nkGVJZ7iSU6Nf8OJ6WBwfYuG0gTv2l2/uMU282rxscLjxmWtvFcjc8qOCQRnSBgsFuwD17HJIKQiYUB6Pbo0EzIA5skfgKs875A+xaoUHFLGHlfQgsybsdSUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600873; c=relaxed/simple;
	bh=Rm3gOZ31VuZ+SKZ3tMs4s7MfGetnjl0qusm9vId4TOs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XK+SnBfTcoFBhnNno90gtBmTPRO5eeVwl5Zep73JTsqDDpUT6/0OYdJ+0yNf7gnK/+NlzCzETqDPmpwDERAlIRhIRp5UV8qwR0cxzVeuDyJHh+Q+RlUKw3sG9jgk2ZjOcdUqz+iXbNQjYP/MEivk6rPI5KmRTgxHiQHZV2SDmDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=H41kcfGV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741600834; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dob90s3z+DONEzCUXvAaOGYEGDPs+bd4jgxP31YtrPBNE5GxV4QlxFaWohCjFzrWzA11X4kNHqzW+z9MelRjDmBcaA1t57uYfZUIq9zgFC8vMn/jK430n3L/lp1iWawoIQn5EedojvNh839bKCYolkT5Vsf/MQuUz+UUXT1Sl4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741600834; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZT8kUfSIqR+U8jrdTEq3259tcSEYOxweQkSV2xoZlKM=; 
	b=RH9E2xuXmJP1UAgRBfLw546oEGYFEFhDpNrHIkkF1mMB5nziRoJM4HxGN3/BBHyH36dBcMw2Jk/mzO3taQ1CmhbQq0FzzGXoNLa8NzUEgNjBokGThCILxYNpDCFPkMCnQmYu8e1sL+l31mhP+6VGeTesKQGAgmS8f+Sm+MGFytY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741600834;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=ZT8kUfSIqR+U8jrdTEq3259tcSEYOxweQkSV2xoZlKM=;
	b=H41kcfGVxS+NJd7AoxBHL0YbVoPVD1GftC5jSHsAdnKxn4HHq95F7V6bcRpA/aXD
	Ycccp/ZEjkZkDQcYY4MLMpsMuve3R2YE8PpGQbOActapzRbBf9QdKKTAhg3X94L+uVQ
	UrlKhd11KF4B2+cwfqfyN5c6ucxkIi3vR81Ysynk=
Received: by mx.zohomail.com with SMTPS id 1741600832221948.8309673820739;
	Mon, 10 Mar 2025 03:00:32 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/2] Fix CPU and GPU clocks on RK3576
Date: Mon, 10 Mar 2025 10:59:55 +0100
Message-Id: <20250310-rk3576-scmi-clocks-v1-0-e165deb034e8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABu4zmcC/yXMQQrDIBCF4avIrDtgFCPkKiULY6btkKqt2hIIu
 XulLv8H7zugUGYqMIkDMn25cIothosA/3DxTshra1BSGakHiXnTxo5YfGD0z+S3gk7L0ZjVSmc
 VtOMr0433P3qde2d6f5pd+wiLK4Q+hcB1EpH2it2XFubz/AFYKoUflQAAAA==
X-Change-ID: 20250310-rk3576-scmi-clocks-a30655d70a72
To: Jonas Karlman <jonas@kwiboo.se>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Chen <cl@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

As Jonas Karlman pointed out on the #linux-rockchip IRC channel on
Libera yesterday, mainline has once again chosen a different set of
clock IDs compared to downstream, with hugely detrimental effects to
mainline's ability to use SCMI for clock operations. This is because
TF-A will use the downstream IDs, and when we reclock things through
SCMI, TF-A will get the wrong clock ID from us.

So this series adds the three relevant clock IDs to the bindings in
patch 1, and then uses them in the SoC .dtsi in patch 2. That way, we
actually get functional GPU reclocking, and cpufreq will work as well.
As a bonus, we no longer change random unrelated clocks all over the
place, and it seems somewhat miraculous this didn't blow up in our faces
in a much bigger way before this.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (2):
      dt-bindings: clock: rk3576: add SCMI clocks
      arm64: dts: rockchip: fix RK3576 SCMI clock IDs

 arch/arm64/boot/dts/rockchip/rk3576.dtsi        | 18 +++++++++---------
 include/dt-bindings/clock/rockchip,rk3576-cru.h |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)
---
base-commit: f064b0a4aa5f2bc61c9611a23a7fc83855751626
change-id: 20250310-rk3576-scmi-clocks-a30655d70a72

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


