Return-Path: <linux-kernel+bounces-410995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5F9CF350
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718CCB47565
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AC71D63C5;
	Fri, 15 Nov 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dqxPlzsq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64531D54E1;
	Fri, 15 Nov 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687698; cv=none; b=dWCJYYmUYevJOX02wdPsotCtwgjME3BeWrv467Rmq50p0vANZNIikawc+WcWSnAYbXbGh+ccb5T7es3cNHsMJ298xwiszz2ZNPsFaouKrVbuf848X2W7K6QmXJLhP30KX+o+2eLdOkraJk2AuPnhPMyylEJErasvwAFxh8JDz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687698; c=relaxed/simple;
	bh=hzMNqFzjJmXhupDySrBmjKOmiFy0n0jBgxntqS1KgZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtcvM4PVudC3Iay4uX/kEIAuvneNyD6c1ocPfQnz5tE5phyVjqhkshMlLUcPXwp0ywhiiAPkmHKNC7K2hoJgAV7kCgBYe8NZtRlhzDRwS/VmqMWNMDMNwMHcCkGg+JYlpbRR+M5N33Kbwp12YMFe9oHNbYvvJfnGWx+1SgtAhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dqxPlzsq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731687695;
	bh=hzMNqFzjJmXhupDySrBmjKOmiFy0n0jBgxntqS1KgZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqxPlzsqQKMa2GOkMp5zMof02/OGqnSj/Xa2IvDASQM2MsCQ+Gx7cmVHQkL517wDh
	 d/MDFCf1+aEqZ6GDz32dUuYiNyERNFCOPR29Vnq5L0T9OXqPzhS2P/+p76TlfgeSRO
	 53ocPXS/kla7CH46o+rfvfOgt3ERTH1LaroAZ3ArO+B/NLyDjLuu5mEIxJmnk52OLQ
	 KDvefA8k6dmtX/UkDZOtp2RBpz9Sdzm9jxEt8rwSU/ICepyQ6G8yRfuQjqiaJjZthO
	 e9mlVLAOWkrfb0vu++5EiqcdXyha13WcDWStjUYY02MFUdTr67x82daHsnv/DSNLLy
	 Zk+9OX6jqcrAA==
Received: from bootstrap.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 74A6D17E3756;
	Fri, 15 Nov 2024 17:21:32 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Alexey Charkov <alchark@gmail.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 3/3] arm64: dts: rockchip: Add VOP clock resets for rk3588s
Date: Fri, 15 Nov 2024 11:20:42 -0500
Message-ID: <20241115162120.83990-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115162120.83990-1-detlev.casanova@collabora.com>
References: <20241115162120.83990-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the needed clock resets for all rk3588(s) based SOCs.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index d97d84b888375..b5c19423de9b6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1268,6 +1268,18 @@ vop: vop@fdd90000 {
 			      "pclk_vop";
 		iommus = <&vop_mmu>;
 		power-domains = <&power RK3588_PD_VOP>;
+		resets = <&cru SRST_A_VOP>,
+			 <&cru SRST_H_VOP>,
+			 <&cru SRST_D_VOP0>,
+			 <&cru SRST_D_VOP1>,
+			 <&cru SRST_D_VOP2>,
+			 <&cru SRST_D_VOP3>;
+		reset-names = "aclk",
+			      "hclk",
+			      "dclk_vp0",
+			      "dclk_vp1",
+			      "dclk_vp2",
+			      "dclk_vp3";
 		rockchip,grf = <&sys_grf>;
 		rockchip,vop-grf = <&vop_grf>;
 		rockchip,vo1-grf = <&vo1_grf>;
-- 
2.47.0


