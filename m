Return-Path: <linux-kernel+bounces-186636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC028CC6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C531F214DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8D51465B5;
	Wed, 22 May 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="45kzaSJ9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BFE14658D;
	Wed, 22 May 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404412; cv=none; b=PNJNY/oaECjvlJQfEUlQrsbFgSUArdadBW8NEibXtWvMx03yRBpbzAgLrEKxY405w1bogFkCfzkhYqvr5H5GdNmnDyaZnJsFd+APaErtzdaYFJ9NxrLKq8yUy/RNlHmKgEgj/qqqanaCGxhUpV+fNihhNZZtJraQ8gqD++AVPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404412; c=relaxed/simple;
	bh=LfctjAd5uH9RnEI2V0jx8z9y7pEnFvsn8ifaV8F3Mx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJPQgHJlUs6BnV2LFyOrrFWnTzuhJI/CqZAQ7ltFRevXyrkogOqwW+iU+PpQ3ZQRH/NV5Byx8jXnVsdBJ5BSYdmGxxcjZ61h6ZxC41/0KokbiZHeQuzf4RCLzqB2v2Q0iAZzy8hohrum5IQ8KBZ/2sP5kq5UUDlkqn40meQ9hzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=45kzaSJ9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716404405;
	bh=LfctjAd5uH9RnEI2V0jx8z9y7pEnFvsn8ifaV8F3Mx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=45kzaSJ9T8lf1/Zh9CeVPM38MgoiD8SDrf9tCrazJTsjXVyWvNSa/nIDKi7WRfbj2
	 6I9b89QkEE95FUQkExwMerQySbVOMOE8TWimMwgB3Nzji4cUiwRvYjf3iBsNbxoYHH
	 qJiH5xRlMKYotPQm2MiQ8/h6ftj7W7NlepNWewPpLSraNtJ1t4UCOwV6tjXxFQ0hIy
	 Dx4R++SLb7DKY8gU2DyZZKqFmjm5LKf+SPONJ7IV4ULmuO/wZ4GjbD3i+QOYY5kxOt
	 Cof3tOtLPyloyx3Vf5yhvtp19dVbfz9Bnii+/yDs8/JcjS07CgSAs55t7naznmaRfC
	 lOIcKq9MC0QgQ==
Received: from arisu.mtl.collabora.ca (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5C6BD37821A4;
	Wed, 22 May 2024 19:00:02 +0000 (UTC)
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
Subject: [PATCH v2 2/3] arm64: dts: rockchip: Add VOP clock resets for rk3588s
Date: Wed, 22 May 2024 14:57:49 -0400
Message-ID: <20240522185924.461742-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240522185924.461742-1-detlev.casanova@collabora.com>
References: <20240522185924.461742-1-detlev.casanova@collabora.com>
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
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 6ac5ac8b48abb..490a525700498 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1193,6 +1193,18 @@ vop: vop@fdd90000 {
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
2.44.1


