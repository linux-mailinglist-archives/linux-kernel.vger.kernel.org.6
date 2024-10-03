Return-Path: <linux-kernel+bounces-348920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1DE98EDB4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F807283116
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674BC155757;
	Thu,  3 Oct 2024 11:15:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7A6155389;
	Thu,  3 Oct 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954107; cv=none; b=tgqs/YLW9KZLQoyCoicnwP2f/1nFb6l91uALnbzhDOmkvBW4R07g9p4lxWKAzho0wIfq/D6LcJ/peJFqK/FUmROMo4/9lzJyXmR32pg4kR0Qz+a7LRt4JIBWd7CWWZ1pRH5DsiwrU7GOb8HsC8jDX/2MtmUB2yGT/MwY/UcubTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954107; c=relaxed/simple;
	bh=3v6BWUEr5bFFLRShtA8lbJG5VpVmcDRdGnW1qFqpO7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tBsqO21E4KUFYd0YsBaLPkEDPRQKsWAMi/BooTY6BvYHZW3B7Hmh/Zn2TnuRVDe19ePcVx+Ox82eRGjLPzjIx5cNRWsDuaNDGQBiEKgAbDgcP3/k8QMmPRBZx3r4ZwBAnfkEzxTKn/edGTTZxfsaLOJp6/b+hdlRPvORiJg/kIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A84497;
	Thu,  3 Oct 2024 04:15:33 -0700 (PDT)
Received: from e110479.arm.com (unknown [10.57.55.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF03F3F640;
	Thu,  3 Oct 2024 04:15:00 -0700 (PDT)
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
Subject: [PATCH 1/5] dt-bindings: mfd: x-powers,axp152: Document AXP323
Date: Thu,  3 Oct 2024 12:14:40 +0100
Message-Id: <20241003111444.543964-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003111444.543964-1-andre.przywara@arm.com>
References: <20241003111444.543964-1-andre.przywara@arm.com>
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
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 14ab367fc887..3f7661bdd202 100644
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
2.25.1


