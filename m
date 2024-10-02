Return-Path: <linux-kernel+bounces-347353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883DC98D195
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125FEB235B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91641EBFF4;
	Wed,  2 Oct 2024 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9IeHa1j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29D1E130F;
	Wed,  2 Oct 2024 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866096; cv=none; b=WQVFZ0Z7j2psrSjNm7UrlIpIERC2Dh65r5oK9PpmV8i3sLXYQq5DBZQ/SIydGuAkHzdMZIkjKC9taeV37Ys6Tg2/2+qGaXXc098rzso1svSZ9gO6fnHQ0wrLMNwRt/HBY4x/pYGcjpCnYw/N4evexzhGCiYvcsVcm2Myl8FDdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866096; c=relaxed/simple;
	bh=w1Hu48WwSe36hDwxxCLQSb4anYqbbgR4csAAzUyw8CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/Y4RpfQKFbm5NVdrMWoBy8v9gxQ2RTYHu7AlYn3Uq1Hw5vSOhpatgpFYh9XW9bgWKUp0DTUU9TUdlOgn8ish/yCthDnqIElW876SjcF+LdQmlHKfbFnPxmJcnmmDv6CbS/rk70nkZGVuDpZBqDNMR1hisRL1xbHSFWMAM9EA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9IeHa1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BA6C4CED2;
	Wed,  2 Oct 2024 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866095;
	bh=w1Hu48WwSe36hDwxxCLQSb4anYqbbgR4csAAzUyw8CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9IeHa1jphL9ex86hNVHAPTc3840PN+lmtU2/VSkMf1/9a3DlKzRkFSnPvJGO3ZQQ
	 bTID8vjjAslTkiauvWcmX/O0kOiZOniWrCUP/YKgySHeNk6+/8j1IrHHHMW6D+yz2v
	 HkyVc11TMXxiLg/eiljYe5u22prkkGWt40THrt2q7ThMkHnfR0nLHobe/eBQh8QEqI
	 sv6LcLeWMfMBCjQW7UCuqInhqaDpgbhsVCJr5GtJc4W+ZjjzTyBpDTslRDoetRhAnD
	 z5cwrXmeEvAOIjUjBdQf6hklMw7pz5ll9uuSNRAaFc3NpPJ0/mcp3eP6ZUcPDjS1Al
	 An4idv6KpixvQ==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 01/11] dt-bindings: mailbox: mpfs: fix reg properties
Date: Wed,  2 Oct 2024 11:47:59 +0100
Message-ID: <20241002-stingily-condone-576e948e6d67@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-private-unequal-33cfa6101338@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Wlw0Jwuc/8eGDJh454E9EF1WuAuS4lI9nJV8z679wP8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/Ve5HirypeJvb+expSafkiYYUR76TvBp95qISbb9OP bwVmr+8o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABN5l8HIsP1/U4wy75IFdaY+ lgvqtmq/VrdLsD38V3bCqqtHF7x13M/IcGcFq9L7HlOGM2Wb6uzSc7+95fu068SE2y+2mkSnX8p N5AAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When the binding for this was originally written, and later modified,
mistakes were made - and the precise nature of the later modification
should have been a giveaway, but alas I was naive at the time.

A more correct modelling of the hardware is to use two syscons and have
a single reg entry for the mailbox, containing the mailbox region. The
two syscons contain the general control/status registers for the mailbox
and the interrupt related registers respectively. The reason for two
syscons is that the same mailbox is present on the non-SoC version of
the FPGA, which has no interrupt controller, and the shared part of the
rtl was unchanged between devices.

This is now coming to a head, because the control/status registers share
a register region with the "tvs" (temperature & voltage sensors)
registers and, as it turns out, people do want to monitor temperatures
and voltages...

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/mailbox/microchip,mpfs-mailbox.yaml    | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
index 404477910f029..1332aab9a888f 100644
--- a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
@@ -15,6 +15,8 @@ properties:
 
   reg:
     oneOf:
+      - items:
+          - description: mailbox data registers
       - items:
           - description: mailbox control & data registers
           - description: mailbox interrupt registers
@@ -23,6 +25,7 @@ properties:
           - description: mailbox control registers
           - description: mailbox interrupt registers
           - description: mailbox data registers
+        deprecated: true
 
   interrupts:
     maxItems: 1
@@ -41,12 +44,12 @@ additionalProperties: false
 examples:
   - |
     soc {
-      #address-cells = <2>;
-      #size-cells = <2>;
-      mbox: mailbox@37020000 {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      mailbox@37020800 {
         compatible = "microchip,mpfs-mailbox";
-        reg = <0x0 0x37020000 0x0 0x58>, <0x0 0x2000318C 0x0 0x40>,
-              <0x0 0x37020800 0x0 0x100>;
+        reg = <0x37020800 0x100>;
         interrupt-parent = <&L1>;
         interrupts = <96>;
         #mbox-cells = <1>;
-- 
2.45.2


