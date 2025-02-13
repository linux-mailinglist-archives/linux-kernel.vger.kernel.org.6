Return-Path: <linux-kernel+bounces-513234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD63A34567
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F993AE0F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86681FF1D8;
	Thu, 13 Feb 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V9c3VuQg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471F13F434;
	Thu, 13 Feb 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458786; cv=none; b=RZ+iQHK43KbN7V2C9PbNeYouRnzgBedtz18oCLaGId6NCePVKoZCziXnGV12jnzN94Sd7zfFAn1gXEj/6+RroRSoFtWNLW2zwrgiQaCN+MgcySfnaPGuzCtUZLDeL49sLF64y8qcnvual6kN6NYeUcDfa6JzkUZQJfbijgds41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458786; c=relaxed/simple;
	bh=PzugOx+4ra1PqnGgELz15+sqXj+M3ESMLusQKl3awcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ddmlKmibiM245AnE/nyQjqbdi6M4tAwziGdfg9Tw6XaRhsStlCMMBQcAZ0ykXj9YLKlGU+jJpdlDM7AL8JoJhixTSFoCv7z6bAPhz6nrtg6yEuwz32tXkdQa1bcZhznBXyP/bDuSzRygY9UMcgHa88J03QAs/8tXj8ZxoTt9YFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V9c3VuQg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739458782;
	bh=PzugOx+4ra1PqnGgELz15+sqXj+M3ESMLusQKl3awcw=;
	h=From:To:Cc:Subject:Date:From;
	b=V9c3VuQgJPJnOP5JULePngdkBX3xZ5UZ2bAz8KAHU+t2upUY8ohekBnv3wk/gcMjE
	 Gw3HUyJC0qG0toMNifhEC+NsJcSaRYTT014JpqzjEfu51PbAkJtWRS7r8j6lAIef3B
	 /tzBvcBc1lY1XEBNcMh5A5Ma3CXIvZ/ot2na2zt+6W7Ivuy5C1Eb32NX0yXPLMS2LK
	 fgcQdriTeFlEMh9MrDPDVSs4skj8JTdkARzGthPVMg5eVCoKIkPpVFViM+Y3EgxU9Q
	 2uRgHMYEqSMGxf+C3PPhRqSA5+UbXml7UfhgOdecUtPC/7vnUUxCnMKEPqghigF/Ls
	 BLD4t825ueBDA==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D7D817E0391;
	Thu, 13 Feb 2025 15:59:39 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chris Morgan <macromorgan@hotmail.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Tim Lunn <tim@feathertop.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Weizhao Ouyang <weizhao.ouyang@arm.com>,
	Elon Zhang <zhangzj@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>,
	Stephen Chen <stephen@radxa.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 0/2] Add Radxa Rock 4D support
Date: Thu, 13 Feb 2025 09:57:14 -0500
Message-ID: <20250213145921.133412-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the basic support for the board. (Not officially released yet)
It is based on the Rockchip rk3576 SoC, so I haven't added the
following devices yet:
 - VOP/HDMI
 - UFS
as the support for those has not been merged yet, but are close to be
and I already validated that they work.
It will come with another patch set.

The following devices are supported and working:
 - UART
 - SD Card
 - Ethernet
 - USB
 - RTC

Changes since v1:
 - Add missing dt bindings
 - Remove clock-frequency in rtc node
 - Add line break in pmic pinctrls

Detlev Casanova (1):
  dt-bindings: arm: rockchip: Add Radxa ROCK 4D board

Stephen Chen (1):
  arm64: dts: rockchip: Add Radxa ROCK 4D device tree

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 651 ++++++++++++++++++
 3 files changed, 657 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts

-- 
2.48.1


