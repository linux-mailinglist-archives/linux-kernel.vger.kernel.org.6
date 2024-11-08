Return-Path: <linux-kernel+bounces-402395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584249C270E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0E41C21290
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433641DF977;
	Fri,  8 Nov 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B0TATyu9"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFA198823;
	Fri,  8 Nov 2024 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731101698; cv=none; b=CZd5IPAIBbY9qyrWvxNPPc4PVE+bL/rgUoufgH4/T4eKkGPsjCGLX2arbFXJsqMXuTIZyDQ9l4eN9DilJXGUDVi4LStGMk+2j7Yn6EDPYUXrye1i+tScYeKF/7oR3cnBxY5Pt7LJDpnQU8lkOo+UBdcIC+LBTwyAXWCsdNH7t+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731101698; c=relaxed/simple;
	bh=CG5O0aBXAGi4FDAzWkIA2qBzxYUOk1Yt2uloAymezk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ew5pCL8OBTn4eBMoOoJp5piMmgfVUyo6nSEE5jCcg2tgD1XYRFJbjBo6BBSgvP0xfgRyvkck+UoloXgTbjiUkh4jpYk07hcXxgcET93SPn5BkCykTohPlkRtf+e0H+e2ln78QXn/e6vNt7YpuqIrZi84B3eC6EY9wd4+k2e3heY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B0TATyu9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731101694;
	bh=CG5O0aBXAGi4FDAzWkIA2qBzxYUOk1Yt2uloAymezk4=;
	h=From:To:Cc:Subject:Date:From;
	b=B0TATyu93JB58fz0X5PBVvGj6TAz+RnFZXLYcJGrAZv3OmxCyTMlmTkFB0OgL4wd1
	 LtS0dpWK16E2zrANDjmgfSgGE6FL+uXGAF5BGP47PFwbI0A66kRAFzz9EWEVp90RjG
	 EEq5oMhrFQpAypIhDuslSOI5LmFelKhtyoNHmT58gFi48OM+gcf6UCpxS+6Rg3AeLq
	 OlNVSesqxy6JN+YXQPxl/34h2QeEn2cE+csbMqT75BI7suDyhPShMGlC3JcpJHqE83
	 ePIfm+1vdYG0jxhyWzqQmlN8ujpWV8e3y3lwMTTaHziVb6hx7n31z2uxj/JI1qbclr
	 4IQTqOoJ3WUDg==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B6A3717E37A4;
	Fri,  8 Nov 2024 22:34:52 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Andy Yan <andyshrk@163.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Weizhao Ouyang <weizhao.ouyang@arm.com>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] dts: arm64: rk3576-sige5: Remove non-removable flag from sdmmc
Date: Fri,  8 Nov 2024 16:33:57 -0500
Message-ID: <20241108213357.268002-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sdmmc node represents a removable SD card host. Make sure it is
considered removable so that SD cards are detected when inserted.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts b/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
index a56109b4f071..7c7331936a7f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
@@ -646,7 +646,6 @@ &sdmmc {
 	max-frequency = <200000000>;
 	no-sdio;
 	no-mmc;
-	non-removable;
 	sd-uhs-sdr104;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vccio_sd_s0>;
-- 
2.47.0


