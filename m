Return-Path: <linux-kernel+bounces-278666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD5294B350
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EA9283C66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D9C15534D;
	Wed,  7 Aug 2024 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffZTSfCo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C413B7BE;
	Wed,  7 Aug 2024 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071611; cv=none; b=hrrnSPWWz2X4MsnwAn42DvqJYIz82RbYs4Ndec45NdLlGarITcdMpLBTdFEfGNYoSbPh0SWH6Y66BWM8xF1IIdbdBBhpj55rof9NMjSzYXhM3Q0+8DPiCHy0yM6OA2lmkONwStxfM3VFtj4uJV7SMU7IFKqrtE8fYyVW1+/hT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071611; c=relaxed/simple;
	bh=QkTkuaRVDpA9vzbecEbJkM5kfVkcV8lY4WmiXV2vYms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqHcoMeBl2zZWq4d9VxbVtyxvI3xJ4tJiNNMHhW9RHNWZiNFeC9tIOBoJEMW5rc0N2mROYIar4STx+1SXCbd0yxCgDWsRCPrMOHsRboikXhiIZDMg7traeQxp51h19b4K0cYvkru8F24XUqsT3BGMAKMi02bsmIXNCBP7LAZTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffZTSfCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D10C32781;
	Wed,  7 Aug 2024 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723071610;
	bh=QkTkuaRVDpA9vzbecEbJkM5kfVkcV8lY4WmiXV2vYms=;
	h=From:To:Cc:Subject:Date:From;
	b=ffZTSfCoDbtCNtiXHJ7CHdKILWGULYytRJHcEK5vAdHnfXz12aKyDkHF7Lqw+sxbb
	 1Vdfm3Tf2rIpdrLgiY2FYkcvSEKw2BI9ktzQBllhC9FJKWglqpM4/0sk9weDmh1NGV
	 JUvHwfLn3XU1ZLowzRNyQUI6ktWYMAlDU1XU4YxlkjceWyupyhaY9IBLQ+IzXf8Rbf
	 DceZX5LPflrtELRyOYmgelguz9fMyb20XuEgxusezmof+bc7GeZexe5nYfJ6s6XK+h
	 AOVaAFX2FRWNLTkJWRsvNiQWTTCv7Qn0y+IokLKZEUTXVAr1V3kmPLtO7QSeLyLUk9
	 +8INAVjg89xng==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: memory-controllers: fsl,imx-weim: Fix "fsl,weim-cs-timing" schema
Date: Wed,  7 Aug 2024 16:59:58 -0600
Message-ID: <20240807225959.3343093-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "fsl,weim-cs-timing" property is an array, but the constraints in
the if/then schema are for a matrix. That worked fine when all
properties were decoded into a matrix, but now dtschema decodes
properties into scalars and arrays based on their type.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../memory-controllers/fsl/fsl,imx-weim.yaml  | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim.yaml
index 3f40ca5b13f6..ce4ec94a561c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim.yaml
@@ -134,9 +134,8 @@ allOf:
           properties:
             fsl,weim-cs-timing:
               items:
-                items:
-                  - description: CSxU
-                  - description: CSxL
+                - description: CSxU
+                - description: CSxL
   - if:
       properties:
         compatible:
@@ -151,10 +150,9 @@ allOf:
           properties:
             fsl,weim-cs-timing:
               items:
-                items:
-                  - description: CSCRxU
-                  - description: CSCRxL
-                  - description: CSCRxA
+                - description: CSCRxU
+                - description: CSCRxL
+                - description: CSCRxA
   - if:
       properties:
         compatible:
@@ -171,13 +169,12 @@ allOf:
           properties:
             fsl,weim-cs-timing:
               items:
-                items:
-                  - description: CSxGCR1
-                  - description: CSxGCR2
-                  - description: CSxRCR1
-                  - description: CSxRCR2
-                  - description: CSxWCR1
-                  - description: CSxWCR2
+                - description: CSxGCR1
+                - description: CSxGCR2
+                - description: CSxRCR1
+                - description: CSxRCR2
+                - description: CSxWCR1
+                - description: CSxWCR2
 
 additionalProperties: false
 
-- 
2.43.0


