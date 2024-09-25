Return-Path: <linux-kernel+bounces-339479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B9D9865B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CF72811DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D44B12BF02;
	Wed, 25 Sep 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4SJSJqP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D66329422;
	Wed, 25 Sep 2024 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285686; cv=none; b=fqljDUgU3VJTOtR2nhul5B/4kaAJ8GI3i9icMnwbNBRr1mSrGfjzi5wMlChTW8jS5HNrJ8Yh+sXsoaeYcdTu8GPLKEOwWzEAUA4IpAHiNaBqh1hY0f+0Az7v0GUAl8wfrjW80kadSTNea9IlLDRFa1W/bNfJsaoGOy3+ISWY8/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285686; c=relaxed/simple;
	bh=OYKPh1RAnlj0Qe43FuhvXRjKXiFpZ5OHCC87f9SRnT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zwdl8O1rscsW1h0tGqJ2WLGf/7Dzu0lEsB2om5tOFj4jpqr0Nq43SB9T1eNNaikvUZ+WSCMbZqDAjQGF2MLG90WcKPh1V3n1f1ADcKi3GYsxehBeg2gYFvF0/qd3nUBQlzltXDLOJMpG8j6VeeJ+1nPfc4j8th2wozD0gWvAnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4SJSJqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E510DC4CEC3;
	Wed, 25 Sep 2024 17:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727285686;
	bh=OYKPh1RAnlj0Qe43FuhvXRjKXiFpZ5OHCC87f9SRnT4=;
	h=From:To:Cc:Subject:Date:From;
	b=g4SJSJqPJp5fago4G4LX8mAAuM2JzEa4pHUJ6l0Kh4AnkmFYt7pv2OhySoF9n5Fsf
	 dWHWgQcCAAkeLerDCmVGtzY2KnhEhKWFiCI21jqExbEngWQoPZLlqxUz8P7rpCUem6
	 cDYfN1DXFdMEFHliDGqom5boGgW8Eg54k8/7c92xpkWrn/YxQVQYBPYFC0oVcfDxZg
	 Hz6u8Ki4sxtO34U4JR/NfpWFwkYKW6KMGZ/Zs8S4HrN9EsWk6W+3OvCDYOBW6SPFiM
	 SlSFz/aORYFvZbVqPOazwFcDCXLAIuC31Dkfkwd1ORouSmynNiNxCQbVLfQJ+OjVzG
	 otFfr3tSNr5lg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: fsl,mu-msi: Drop "interrupt-controller" property
Date: Wed, 25 Sep 2024 12:34:38 -0500
Message-ID: <20240925173438.1906339-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Freescale MU-MSI is an MSI provider, not an interrupt provider, so
drop the "interrupt-controller" property. This fixes dtc "interrupt_provider"
warning.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
If this is not correct, then #interrupt-cells needs to be added.
---
 .../devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml  | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
index 799ae5c3e32a..b5282c857f44 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
@@ -62,8 +62,6 @@ properties:
       - const: processor-a-side
       - const: processor-b-side
 
-  interrupt-controller: true
-
   msi-controller: true
 
   "#msi-cells":
@@ -73,7 +71,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - interrupt-controller
   - msi-controller
   - "#msi-cells"
 
@@ -88,7 +85,6 @@ examples:
         compatible = "fsl,imx6sx-mu-msi";
         msi-controller;
         #msi-cells = <0>;
-        interrupt-controller;
         reg = <0x5d270000 0x10000>,     /* A side */
               <0x5d300000 0x10000>;     /* B side */
         reg-names = "processor-a-side", "processor-b-side";
-- 
2.45.2


