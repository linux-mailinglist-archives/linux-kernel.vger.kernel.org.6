Return-Path: <linux-kernel+bounces-288043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98ED953219
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCE71F221EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B5A1A7065;
	Thu, 15 Aug 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXN5gDEv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E81A4F1C;
	Thu, 15 Aug 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730492; cv=none; b=AESIYeAKxqsr4db9RYIh6y0zkxTq3bDJttq4zSXwy3pXwDyhFZI3L0dbn+8dABAv9KR9Ksv7rpFSfDg984u0jv8Kexba+0l7kWKAnPLu7HcO0VEU3Uv1gzfQd/av6pnJRE7XSUV60caULwtRz4+5zapTqsi+81dB/haEG3uxLos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730492; c=relaxed/simple;
	bh=R98AF+O5bdBgSMjboAKPR/52YCoaa6Qj8a/0Ad8DcEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPzz6TDxaCNyi7D+T1m4exmAl/CAvUs674fER5ksbyVBRl50nUO0zEisFWy4PliY/L46rdgkeCDhLdu/ErkoS7tXbeQ8/Ji/OFXil+jkGG+MyAQctEpdEhV9J30/W+rJB5skE62QZ9sppUREWRCbrixhGOYMeEGi6DHIBAEYzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXN5gDEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD57BC4AF0A;
	Thu, 15 Aug 2024 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730492;
	bh=R98AF+O5bdBgSMjboAKPR/52YCoaa6Qj8a/0Ad8DcEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXN5gDEvHt36mHKhS605FWzDh1m2kJqZMfr9sWkWT5Vd8HM1PWKOcBVBa6rtUJNQc
	 MN8pNtngGErguro7AoZTRvJAHuz8Mcgizs9NLUtZccRrgdLhxRRru1B8TTjFmz/H62
	 neMQUbLYAZOBH4vHdJE7EWEgH/pdXJt1XN5ZF9Bx8RZqPeBHqCJhakl9Ry93zNdYTp
	 GZ7FaT10nPWHFAIjRwh7LBoJ5NW+816HWhVyI4qz1Hz6YOPYI2mlxpJRog+US0VHbz
	 uWzlTs0A1/O3TRqBWCnanmhIbn3mtXtQWcr1nEoZn+/RYMB+UIZIRq9iKeHfyWqOOs
	 +iT+qujgmLFHw==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/11] dt-bindings: mailbox: mpfs: fix reg properties
Date: Thu, 15 Aug 2024 15:01:03 +0100
Message-ID: <20240815-premiere-given-1dab82e67eba@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=XNHaAfGhWICPeOWwwDbdps/abFlbrTVfGKjKGH4+NlY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uLQbko7+usq5dNfyvrg7fMlO2zhmbSpwlrmwXTfQe cqtRQ5PO0pYGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRphiGn4zvHZ6fnCLHesgg foJDU9dOo8PGjdfvr6lZ/jPEpdZl+gSGH19vvD3x4FfEJv3tVUsCMlr9qhbrzfUI+Gye+2+5Yv8 RFgA=
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
 .../bindings/mailbox/microchip,mpfs-mailbox.yaml       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
index 404477910f02..3af599efd359 100644
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
@@ -41,12 +44,9 @@ additionalProperties: false
 examples:
   - |
     soc {
-      #address-cells = <2>;
-      #size-cells = <2>;
-      mbox: mailbox@37020000 {
+      mailbox@37020800 {
         compatible = "microchip,mpfs-mailbox";
-        reg = <0x0 0x37020000 0x0 0x58>, <0x0 0x2000318C 0x0 0x40>,
-              <0x0 0x37020800 0x0 0x100>;
+        reg = <0x37020800 0x100>;
         interrupt-parent = <&L1>;
         interrupts = <96>;
         #mbox-cells = <1>;
-- 
2.43.0


