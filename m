Return-Path: <linux-kernel+bounces-190221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F0A8CFB85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF8C1C20C85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01562171;
	Mon, 27 May 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FF9L4rB4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GXF8+aJF"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0E54657;
	Mon, 27 May 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798858; cv=none; b=UuryfcGXV6wIBGHdLSMDCZF7n/iM9YmRBR1xWDiMz5tjSpnphPfeBom5Lx4L9kIVuvbtXrMzqmLTJdNY8wx0tTl2ZuMUkCxKlrjjkm6T62X6PzS1373qCrvhnaPIQk5voecPuczHE8rM7tnbpcPuex5kOrqPXEYNm43ryHKXZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798858; c=relaxed/simple;
	bh=3A4hcLLH9DbujS1o6ucKP6RvJcSm8e8YMLoVA2QjTo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Al3EzP8VsStdImnzhqdW6BSckxhVwtBheLKRK6Z5TPdMG1l29MmSxKIXE2amZsvsamHI76xCSoxyF2k9JKAdBSz+o9v3RW9CidFmH2gEIuXc34qQqACbTDSM2jhidIx6nH+S7r8eiqG6YgzJ2VyWek8fnlMaD1QRgV0HqGeYHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FF9L4rB4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GXF8+aJF reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716798856; x=1748334856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=14a5RxSRpaQNqSYabsn0c0LCDLx+Q2lxEk6Fc22o0Eg=;
  b=FF9L4rB4tlOE9VAa1kIS5rm/KpCMT8Vy8JJKSkI5prOdJGc4kJHQjy3C
   bsPTMkF3k4FWpb/X2eT3bRV658Qoh3sg0jALDV/5aTF+diskVpu1yLnRY
   yMEJAVhfhBKBxPRwbOHj20B8hR/3+8kzLjAQ63ZqctV5GZ+9xk+Jj1lOR
   FBz4mGAghAerQxNrU/SgVjs+5Ng5FQdLiljRts71oP70fH2AfaxqYMuO8
   C5f9AzfOrJMAH2Q98HeXrEKSS6xZYKou0UkrXjyvMnQDjAyrIhY0L9mKk
   UumetxCnRNUBp1mbvl4OU9atZiS2R9rYxjoby+QToed/8Hm9mncGyDlb9
   g==;
X-CSE-ConnectionGUID: bMGbv8CMTZSVwQDCl9fnJw==
X-CSE-MsgGUID: JBQtOhVMQ3SQs+pueUFKPA==
X-IronPort-AV: E=Sophos;i="6.08,192,1712613600"; 
   d="scan'208";a="37075684"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 May 2024 10:34:08 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 520C31637E4;
	Mon, 27 May 2024 10:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716798844; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=14a5RxSRpaQNqSYabsn0c0LCDLx+Q2lxEk6Fc22o0Eg=;
	b=GXF8+aJFKUqz09WtmlnjIfEehEfD7jaS+EsXcEhJQ8xrE4FKEoEE5Twdm/NbMYTn4VQXc/
	p8ZXzR6qORO+gThKDFHLERDXGbk0kLRJOW7NSuuGWoksyJzAwF0ER9a3BY90FUi0SMs4hQ
	YU+JUEJrhTStf6SyxLZx4ssvVfAWxLavu+JOA5+LR5iWcwpBsevnY+FLHvIVrTs7068CHE
	j432a0dACZ+GS3y08TEAiQZ6mdGYepU0GHMytT6PQv+bwr/i1NkSL+KFTiE9SSDqkZLhDw
	+b2H7r16RZBhyaOIbcg0MEbSx0pWxHxkoGzw6X7MEKqXZL4oRuIzquVwJhqWtQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: fsl,irqsteer: Add imx8mp/imx8qxp support
Date: Mon, 27 May 2024 10:34:01 +0200
Message-Id: <20240527083402.30895-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527083402.30895-1-alexander.stein@ew.tq-group.com>
References: <20240527083402.30895-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Some SoC like i.MX8MP or i.MX8QXP use a power-domain for this IP. Add
SoC-specific compatibles, which also requires a power-domain.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../interrupt-controller/fsl,irqsteer.yaml    | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 20ad4ad82ad64..924995191404b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -14,7 +14,10 @@ properties:
     oneOf:
       - const: fsl,imx-irqsteer
       - items:
-          - const: fsl,imx8m-irqsteer
+          - enum:
+              - fsl,imx8m-irqsteer
+              - fsl,imx8mp-irqsteer
+              - fsl,imx8qxp-irqsteer
           - const: fsl,imx-irqsteer
 
   reg:
@@ -42,6 +45,9 @@ properties:
   clock-names:
     const: ipg
 
+  power-domains:
+    maxItems: 1
+
   interrupt-controller: true
 
   "#interrupt-cells":
@@ -70,6 +76,21 @@ required:
   - fsl,channel
   - fsl,num-irqs
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+                - fsl,imx8mp-irqsteer
+                - fsl,imx8qxp-irqsteer
+    then:
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains: false
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


