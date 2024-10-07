Return-Path: <linux-kernel+bounces-352668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CC999226E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18D51C218DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 00:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761A7B673;
	Mon,  7 Oct 2024 00:14:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD263C2F;
	Mon,  7 Oct 2024 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728260095; cv=none; b=IvIluLsNRH1aFAt9ydWhSzwx+by3E2OzV5fxqmh/hDPX9Fnhu8sB4xHPyp5LZ8iSxT83LISfUVtful1BUJqBIChdi5Sqph8RyJiaeYyNUXCTH5o1moFrj04937bD9B4jZ36GRXTU0k++5tCvJ1Wu+wPcn1dbiiaKGxsa45ScrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728260095; c=relaxed/simple;
	bh=F3MvYsqwn0fo9JQlrrxZFS9dBzp6tOLz4f0HKJr7jCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjexT2+ZvdCoSYl9McIYIcHcHyzX38oEZB8E1YsvbLnOPd52W0gwfpGu1t6IMSiWM4H+t/yjG7fOpth/CT13df7rbgcr0SQ+5IH5ari2VT9S83uPEkq3/bza4EPb1oOIJeOZQMdk9pHoss4bdxp+G87qvXQNNdHWAQvluTymqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 303081007;
	Sun,  6 Oct 2024 17:15:22 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECDA23F640;
	Sun,  6 Oct 2024 17:14:50 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Martin Botka <martin.botka@somainline.org>,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v2 1/5] dt-bindings: mfd: x-powers,axp152: Document AXP323
Date: Mon,  7 Oct 2024 01:14:04 +0100
Message-ID: <20241007001408.27249-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007001408.27249-1-andre.przywara@arm.com>
References: <20241007001408.27249-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X-Powers AXP323 is a PMIC used on some newer Allwinner devices.
It is almost the same as the AXP313, but supports dual-phasing the first
two DC/DC converters. A pure AXP313 driver wouldn't know about this, and
might turn the linked DCDC2 regulator off, as it does not seem to be
used. This makes the AXP323 incompatible to the AXP313a.

Add the new compatible string, and treat it like the AXP313a.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 14ab367fc8871..3f7661bdd2020 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -71,6 +71,7 @@ allOf:
                 - x-powers,axp15060
                 - x-powers,axp305
                 - x-powers,axp313a
+                - x-powers,axp323
 
     then:
       required:
@@ -82,6 +83,7 @@ allOf:
           contains:
             enum:
               - x-powers,axp313a
+              - x-powers,axp323
               - x-powers,axp15060
               - x-powers,axp717
 
@@ -100,6 +102,7 @@ properties:
           - x-powers,axp221
           - x-powers,axp223
           - x-powers,axp313a
+          - x-powers,axp323
           - x-powers,axp717
           - x-powers,axp803
           - x-powers,axp806
-- 
2.46.2


