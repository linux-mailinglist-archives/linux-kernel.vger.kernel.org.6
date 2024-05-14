Return-Path: <linux-kernel+bounces-178854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3138C58AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E221B2310C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC217F388;
	Tue, 14 May 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BXK1+Wkl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78817F377;
	Tue, 14 May 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700261; cv=none; b=eQPllJbZXvJhpa+r1cUVF5wjYc2Cz6mCLWP8D44y7QpWib8Sp02420R5Z1G4jwpa/MNwnE7GK6/U81ij1PyUpc//lBVi4a5QoyLm8dmbO7lUW+BmrAE6WbkF80OGvTld8WOL0QqulCqEo8DQ6iHnunRZyKeFBe8U11WIrCkA15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700261; c=relaxed/simple;
	bh=r3Fx1MKTIpt0X27ue0Y4XgM4MOWhxwM0vB8PYtwySfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiUHIeQiVyOYvQTWlHNBxfBgpVHzFcBFv9b/onOE8lt7BYijuu52GzHzK5QOz9ld2WR/Q/RK7Rw5s8yLpf5gc+TRhW97LEusIxLFN5vDC6DWD3cB8nbET97ZCE/v3+n3m5Twrvn9mfWSeBKV80iDa/6SR/z8jyNYeL7fIQPDbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BXK1+Wkl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715700258;
	bh=r3Fx1MKTIpt0X27ue0Y4XgM4MOWhxwM0vB8PYtwySfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXK1+Wklm7FOLRZkfhUFoZSpyv6Dym+xBQ18JYUutLSyxwrBvBzgFT5cweUI3jcvj
	 K1JiI654qKuV0zDABaBUJ/jgC0gqyXX12BCLd4JPtnqi6bFcCKDZOMA44KLA4O+6xN
	 +czk+HRC89F2Fufc58nRVkWyx4xWX5L7el+lOfvSB1VdkFjcxMQroIPg2tyiHXhQax
	 lkp6TOo4jjdjMZImi814JUwawbanqzYR5JmzXhAurJvCIYtnWLdumVvefw6PgwGWdg
	 2syvr382zNcyr1xQsu/OPwQoPbXOaCb1gOFrzfQwZGXCZg2RQ77uH2V6z7mDEIj7Yq
	 8i3I7rTp12WeA==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C30FE3782197;
	Tue, 14 May 2024 15:24:14 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 2/3] arm64: dts: rockchip: Add VOP clock resets for rk3588s
Date: Tue, 14 May 2024 11:19:46 -0400
Message-ID: <20240514152328.21415-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240514152328.21415-1-detlev.casanova@collabora.com>
References: <20240514152328.21415-1-detlev.casanova@collabora.com>
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
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 6ac5ac8b48abb..8560c92cd406c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1193,6 +1193,14 @@ vop: vop@fdd90000 {
 			      "pclk_vop";
 		iommus = <&vop_mmu>;
 		power-domains = <&power RK3588_PD_VOP>;
+		resets = <&cru SRST_D_VOP0>,
+			 <&cru SRST_D_VOP1>,
+			 <&cru SRST_D_VOP2>,
+			 <&cru SRST_D_VOP3>;
+		reset-names = "dclk_vp0",
+			      "dclk_vp1",
+			      "dclk_vp2",
+			      "dclk_vp3";
 		rockchip,grf = <&sys_grf>;
 		rockchip,vop-grf = <&vop_grf>;
 		rockchip,vo1-grf = <&vo1_grf>;
-- 
2.43.2


