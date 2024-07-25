Return-Path: <linux-kernel+bounces-262150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1E893C199
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13611C20A10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6E9199E99;
	Thu, 25 Jul 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IWbdMilk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC11991DC;
	Thu, 25 Jul 2024 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909806; cv=none; b=MXUoRWENrZwUBtmrr4t3aBybBXVILiGnQ/0tY0VG/FN7sWdbIiOsjaBAHFujkP7gmmdjNsjYt3h6S7vccJWjnsh4Damxt8H5zLj1uP7HCPaDcYQIzNqcW7n8m7tzw7xKUgWf2BnygJwUIBXFbAJCD9UIb4QwYm1lsU8uZ9X41EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909806; c=relaxed/simple;
	bh=69lFbB2jeTYBiUaoNoQ4L8pJt0Z/rKLzQZrqDV7Af4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3quWQp5O3f2iemqpyIuvG4l7J2SqrQUOp5panbpMyxpD21BAiynlqkmX7ydb96JgRFDzFB+DSqd5NMVLMTmSYYbOZi3xsHNlbZ0ylSqQFGEAoauPtxB+UtEIX29ewAARmrS4yrWnhYkm3QsG98alAQ7bZXj+X74+VNakll6wvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IWbdMilk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909804; x=1753445804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=69lFbB2jeTYBiUaoNoQ4L8pJt0Z/rKLzQZrqDV7Af4E=;
  b=IWbdMilkDOoyZHbev8aEfvbUy4LP5IBPgBEJ4wtSja5e0KqjerwQCvbb
   HoahM3ufUp/xsl0dzynGhvDA/MoSGhRnpSiFr9wZYlyInUbFmF9zFvKiD
   J6UQojcA9UIBXDzVdbdYUujB4HPozDD8WGqiMkmVed9A15pDVcgyoAEkY
   ih9m7YxHsd1EiSvsDRJFD2nZKih+5FnZdjxDGazVOWqeehEwsPxk0u+JW
   tXE+/rCTNXr/3rD77EpGXXIHj0cIiQblFONCGiGk36GwgQkKKokyLOixt
   thA4SdxhJn9B6f1OxFOutHNJkzA9KUrXq6oIVIX7SljY+S7VtpEvqESZN
   g==;
X-CSE-ConnectionGUID: 7H0adE5mRmid6ymnvkB3VA==
X-CSE-MsgGUID: Y8om+FnmQmCfo95fR/6Z2Q==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="197092680"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:16:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:16:31 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:16:29 -0700
From: <pierre-henry.moussay@microchip.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 06/17] dt-bindings: riscv: sifive-l2: add a PIC64GX compatible
Date: Thu, 25 Jul 2024 13:15:58 +0100
Message-ID: <20240725121609.13101-7-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

The PIC64GX use an IP similar to MPFS one, therefore add compatibility with
MPFS as fallback

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
index 7e8cebe21584..9d064feb2ab1 100644
--- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
+++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
@@ -47,6 +47,11 @@ properties:
           - const: microchip,mpfs-ccache
           - const: sifive,fu540-c000-ccache
           - const: cache
+      - items:
+          - const: microchip,pic64gx-ccache
+          - const: microchip,mpfs-ccache
+          - const: sifive,fu540-c000-ccache
+          - const: cache
 
   cache-block-size:
     const: 64
@@ -93,6 +98,7 @@ allOf:
               - starfive,jh7100-ccache
               - starfive,jh7110-ccache
               - microchip,mpfs-ccache
+              - microchip,pic64gx-ccache
 
     then:
       properties:
-- 
2.30.2


