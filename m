Return-Path: <linux-kernel+bounces-193903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A4D8D33E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D531C22273
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829917A92D;
	Wed, 29 May 2024 10:00:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F017A902;
	Wed, 29 May 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976848; cv=none; b=cwbpd+JjaZgkDw+f/KSknAfAQIJRr1lmB6GWDuuiHe91moVRKseGw1vioEPWqnMe4xQtRjovCu12DAWIEvkuhobaDNsGj8ISg7fR9wqygkM9vJpAek5flgTWqT9WpIRCP1UxY7ES755yNdKVzgtW81C2SMCgxXu5Q7P73UQOtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976848; c=relaxed/simple;
	bh=6+6AnpQgR3pDE8mI5akLFxEbAHbXPqAvUTnwheuwBVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bk9iyBenKmTM0mahu5w5Kt++6IeyzkUbtbs7hOXzOOo8Zn1jjT9D1QH++fvJLQ28MV7PVdJhRJHWe5iyTFqVMaHdUf2LtOrtlNSfXhh01wIlFEC/QLuALTDNZ/XznWxaVAVnCW8AAvrX+6vjpR2J0r5ojLD1yCSQgEmUfnnNiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80677C2BD10;
	Wed, 29 May 2024 10:00:45 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix GMAC's phy-mode definitions in dts
Date: Wed, 29 May 2024 18:00:25 +0800
Message-ID: <20240529100025.2865868-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GMAC of Loongson chips cannot insert the correct 1.5-2ns delay. So
we need the PHY to insert internal delays for both transmit and receive
data lines from/to the PHY device. Fix this by changing the "phy-mode"
from "rgmii" to "rgmii-id" in dts.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/boot/dts/loongson-2k0500-ref.dts | 4 ++--
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts | 4 ++--
 arch/loongarch/boot/dts/loongson-2k2000-ref.dts | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k0500-ref.dts b/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
index 8aefb0c12672..a34734a6c3ce 100644
--- a/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
@@ -44,14 +44,14 @@ linux,cma {
 &gmac0 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	bus_id = <0x0>;
 };
 
 &gmac1 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	bus_id = <0x1>;
 };
 
diff --git a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
index 8463fe035386..23cf26cc3e5f 100644
--- a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
@@ -43,7 +43,7 @@ linux,cma {
 &gmac0 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 	mdio {
 		compatible = "snps,dwmac-mdio";
@@ -58,7 +58,7 @@ phy0: ethernet-phy@0 {
 &gmac1 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy1>;
 	mdio {
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/loongarch/boot/dts/loongson-2k2000-ref.dts b/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
index 74b99bd234cc..ea9e6985d0e9 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k2000-ref.dts
@@ -92,7 +92,7 @@ phy1: ethernet-phy@1 {
 &gmac2 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy2>;
 	mdio {
 		compatible = "snps,dwmac-mdio";
-- 
2.43.0


