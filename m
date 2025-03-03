Return-Path: <linux-kernel+bounces-545189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE1A4EA21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428B71890A32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6E28FFE7;
	Tue,  4 Mar 2025 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq0wc9mP"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A228F94C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109523; cv=pass; b=mWkgp/jaA5lzlyVOQuIRyzTFM3i7G1/2AerFmp0WF/RP1TTYftWaocPK6s3Cg5DWRH3CF5+O61XtqvWZPSDUeaf8A7LHEnJ4YcsoJfehex09ezcEeeNem0VijC9CRQEbcM3ZN7/TOAN/oyED/TeBg5SdVQDc8GyITj0nIWqLc58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109523; c=relaxed/simple;
	bh=KD/u2uj8WkbEL97tLItjWeuPMc7ZQab5ZdYmsWVBdF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hUoIW/iccJAHAS2MIEtcr7R4WPkEhKfY9fq02sSKp4OVsSCMkM4uDXyJibRN72OnP0gT1ENAb0kMXMFQhtcZP3tVX5JJReBNqVItXhrTwFiYfja9PaUN1F4FgTNiHc3l3s+MAZxOh1F111s/SehhHDxf5Jrh87kWdwISQGfewo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq0wc9mP; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id D30A740D51FF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:31:59 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Nq0wc9mP
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g1C07D6zG188
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:42:39 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6F5B142731; Tue,  4 Mar 2025 18:42:26 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq0wc9mP
X-Envelope-From: <linux-kernel+bounces-541761-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq0wc9mP
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 8B7014261C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:07:20 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id D55122DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:07:19 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6EE7A2581
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095EB211707;
	Mon,  3 Mar 2025 13:07:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26713FEE;
	Mon,  3 Mar 2025 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007223; cv=none; b=h0HM2SGzxFYec7/QB7DNpJaJxFyNUeAP15Rx/yP1sVIF1pmj5zeI3AVrD03NFiJ3H/8m61Fn94ZJPpfR4//+EWnA4oKyqR6Jz60lRQWMleZ/YhzxO+1FqjL8R+bMsmI599mFkaR2BFw33NZasyO9Uw6/KKTHFf7jfKVWIjfOQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007223; c=relaxed/simple;
	bh=KD/u2uj8WkbEL97tLItjWeuPMc7ZQab5ZdYmsWVBdF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kp0slKdJrq2TfP+8ltHXw9/39JY1oo68cgPAeIpoAZLkKmTI1LDTMHuhvnTg6vDABid9XSsiz0QNgt/WuY/LlRrbcETK09t286B36V7btmIoO64k6pP7F67jx1yl9Z5h6JkQKpNo8SUSscYdy5ov/NDkTooJ8Gfn4E8grlL+OwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq0wc9mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4F7DC4CED6;
	Mon,  3 Mar 2025 13:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007222;
	bh=KD/u2uj8WkbEL97tLItjWeuPMc7ZQab5ZdYmsWVBdF8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Nq0wc9mPshq8VCggTjzNZISVHcZ4iX0WG/pkAbnAhdY0iu+OXmWJhHQmIz7I+8hQf
	 jZFsbgo2kUQJiGuAzarrlvtP21ZPl1UgLisuRUA3JLeZtA73GWrpI2Zizr8cUgbiJZ
	 53i9SLDsEkVRK7XR2i13xpGZQXaTULLKSPlhqQ1g302pZdKxrenULZBjGQlRmOqTbJ
	 IC2RWx56coREVyBpnUKsYG0vAVKT9Qu1Rr9OAawClystfs6xKQGEDks4kcE8JSF2sa
	 OcPPUFxLgIZEZ7Y9khJZAGklQ7cXevHLEZb8z21tuE2HX6W5rzV82aLjckGWK/MvTs
	 eKyWYY0qBZzpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BCC282D1;
	Mon,  3 Mar 2025 13:07:02 +0000 (UTC)
From: "Chester A. Unal via B4 Relay" <devnull+chester.a.unal.arinc9.com@kernel.org>
Date: Mon, 03 Mar 2025 13:06:50 +0000
Subject: [PATCH] ARM: dts: BCM5301X: Fix switch port labels of ASUS
 RT-AC5300
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-for-broadcom-fix-rt-ac5300-switch-ports-v1-1-e058856ef4d3@arinc9.com>
X-B4-Tracking: v=1; b=H4sIAGmpxWcC/x2NQQqDMBAAvyJ77sI20Yb2K6WHmKx1DzWyG2xB/
 HuDx4FhZgdjFTZ4dDsob2JSlgbXSwdpjsubUXJjcOQG8uRxKoqjlphT+eAkP9SKMQ2eCO0rNc2
 4Fq2GIdzGQD1nF+7Qaqtys8/T83Ucf/OpD9N5AAAA
X-Change-ID: 20250303-for-broadcom-fix-rt-ac5300-switch-ports-776b704ed279
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tom Brautaset <tbrautaset@gmail.com>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Chester A. Unal" <chester.a.unal@arinc9.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741007221; l=1355;
 i=chester.a.unal@arinc9.com; s=arinc9; h=from:subject:message-id;
 bh=pnEACfUXw4i/i7KomdhkZyj3vwZ11bi8No1VYOFnwDs=;
 b=qLc0CTqWEMG6zp53x9qNafll5DaO+iOLlCT86V716Yc1ca2n5cHbE8Kbt6Cg9WBKQgh9SCUWJ
 F5fOYwVex56C5CTxFBl9oDM/M4keZbY0lv0dqahvCYqSn3bKx9yQyqv
X-Developer-Key: i=chester.a.unal@arinc9.com; a=ed25519;
 pk=/g3vBAV0YSvcIpSQ052xJbid7nrPXz8ExGKhTEuc6IY=
X-Endpoint-Received: by B4 Relay for chester.a.unal@arinc9.com/arinc9 with
 auth_id=306
X-Original-From: "Chester A. Unal" <chester.a.unal@arinc9.com>
Reply-To: chester.a.unal@arinc9.com
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g1C07D6zG188
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714186.40408@hWfpT3mzm9T6rufHE218NQ
X-ITU-MailScanner-SpamCheck: not spam

From: "Chester A. Unal" <chester.a.unal@arinc9.com>

After using the device for a while, Tom reports that he initially described
the switch port labels incorrectly. Correct them.

Reported-by: Tom Brautaset <tbrautaset@gmail.com>
Fixes: 961dedc6b4e4 ("ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300")
Signed-off-by: Chester A. Unal <chester.a.unal@arinc9.com>
---
 arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts
index 6c666dc7ad23ef7c31ac22904c39789838caea2e..01ec8c03686a66dd1efa439333f83737fe572191 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts
@@ -126,11 +126,11 @@ &srab {
 
 	ports {
 		port@0 {
-			label = "lan4";
+			label = "wan";
 		};
 
 		port@1 {
-			label = "lan3";
+			label = "lan1";
 		};
 
 		port@2 {
@@ -138,11 +138,11 @@ port@2 {
 		};
 
 		port@3 {
-			label = "lan1";
+			label = "lan3";
 		};
 
 		port@4 {
-			label = "wan";
+			label = "lan4";
 		};
 	};
 };

---
base-commit: 768953614c1c13fdf771be5742f1be573eea8fa4
change-id: 20250303-for-broadcom-fix-rt-ac5300-switch-ports-776b704ed279

Best regards,
-- 
Chester A. Unal <chester.a.unal@arinc9.com>




