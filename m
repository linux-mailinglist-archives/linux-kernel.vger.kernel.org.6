Return-Path: <linux-kernel+bounces-571730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69818A6C14E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D52E7A2A23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37922FF41;
	Fri, 21 Mar 2025 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvNJ4VMY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824222D7A0;
	Fri, 21 Mar 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577816; cv=none; b=P7xKkvrZojrtIQN5tFRt/DJwXtCt+AJ2X2h7NfH6vBjOVzmWER/tYp3sOtGfbJ/WMmZUn0R/YB+yb2N/YVccpW4kVpn0QAcwwQm77cVR0/rSzDJJE/tNj8oF5DJ48kzHiyU1PU3Qd/3UFdS+iErrSA/iBIy+MiP4h5vMi/+GH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577816; c=relaxed/simple;
	bh=js28aTzobaVq0lLOj3miTgsiXAxIDM2wJUkCtN7LbIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZh3ky/yA7Z6LIci4wsW96M77t1CLKCo4DeAgIzOb8cwsm25Rh/4Ah2y0wXZHWBSb/4X7jWLIFNel1P9F9hFnUw01TAXfu1w0TcrhSk5GhauncYEpHW/+jrflHwIngcHDowErSlMH4x01NE7aqRVyTZUrKsPkc5AnuyPLdNKuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvNJ4VMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD39C4CEEA;
	Fri, 21 Mar 2025 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577814;
	bh=js28aTzobaVq0lLOj3miTgsiXAxIDM2wJUkCtN7LbIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvNJ4VMYMELWa8gkQccAfXnjCKHIiI95QI9gzYRLw42/AGzTGFxi8VCz8msVY1geP
	 GYKjj4AFA+dZOjRsV8H3KGw2GKkwox4tMRZo5w7VVv0x3grhBEzIGJYrffO70D0Ds9
	 hOVKZwnRkUcgeJ+E1DpdwRypVunhb5wUjAolv19ac1cdy9UNbRCEot5UEmotjtokVQ
	 pMS0Ni50085baM0UTuVCEvdqq5tBlliM5t0wQIbjO5kfCbrbxw2cQpl8DEG31R38z4
	 dFVH+QCA2sa0MM05klnCnzOteN09QUyRGva/Tt5PIQM+cKLou0AIE+h7GHzF409C9R
	 DjPrQbpaC4Erg==
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 6/9] riscv: dts: microchip: fix mailbox description
Date: Fri, 21 Mar 2025 17:22:39 +0000
Message-ID: <20250321-culminate-greyhound-941bce25856e@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=oTMuiGOOhhC3GQAioxBkdjP6pkdPZ7VZK2gf4k/K1jo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl3F0QtOfF2kcD7Uq3DrTMvtatOSIj4e3y/4EPvR+923 r/H9afIvqOUhUGMg0FWTJEl8XZfi9T6Py47nHvewsxhZQIZwsDFKQAT6XjE8E/z2W/nFP5vO96s P+F6WjYh++/TExZz+t8sbN65pMOLYf8kRoYpN6bYKni84//1/qt5xVbvjDnTk8TWcPBvl1367fS E0685AA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When the binding for the mailbox on PolarFire SoC was originally
written, and later modified, mistakes were made - and the precise
nature of the later modification should have been a giveaway, but alas
I was naive at the time.

A more correct modelling of the hardware is to use two syscons and have
a single reg entry for the mailbox, containing the mailbox region. The
two syscons contain the general control/status registers for the mailbox
and the interrupt related registers respectively. The reason for two
syscons is that the same mailbox is present on the non-SoC version of
the FPGA, which has no interrupt controller, and the shared part of the
rtl was unchanged between devices.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 9883ca3554c5..f9d6bf08e717 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -259,6 +259,11 @@ clkcfg: clkcfg@20002000 {
 			#reset-cells = <1>;
 		};
 
+		sysreg_scb: syscon@20003000 {
+			compatible = "microchip,mpfs-sysreg-scb", "syscon";
+			reg = <0x0 0x20003000 0x0 0x1000>;
+		};
+
 		ccc_se: clock-controller@38010000 {
 			compatible = "microchip,mpfs-ccc";
 			reg = <0x0 0x38010000 0x0 0x1000>, <0x0 0x38020000 0x0 0x1000>,
@@ -521,10 +526,14 @@ usb: usb@20201000 {
 			status = "disabled";
 		};
 
-		mbox: mailbox@37020000 {
+		control_scb: syscon@37020000 {
+			compatible = "microchip,mpfs-control-scb", "syscon";
+			reg = <0x0 0x37020000 0x0 0x100>;
+		};
+
+		mbox: mailbox@37020800 {
 			compatible = "microchip,mpfs-mailbox";
-			reg = <0x0 0x37020000 0x0 0x58>, <0x0 0x2000318C 0x0 0x40>,
-			      <0x0 0x37020800 0x0 0x100>;
+			reg = <0x0 0x37020800 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <96>;
 			#mbox-cells = <1>;
-- 
2.45.2


