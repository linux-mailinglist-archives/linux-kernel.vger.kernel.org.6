Return-Path: <linux-kernel+bounces-311746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282B5968CFF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7901C22C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9121C199;
	Mon,  2 Sep 2024 17:52:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4C921C170;
	Mon,  2 Sep 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299541; cv=none; b=EzGMseSerfeQdd9/Cp/HdLp+oZg/I3Lit6hKVE+QQlD7Dh8RdcpInVjXggp3DHhfORoS9iCSac0raYacuB0qhxcdYJO5tj2A7yfw8h2qwnygpSapHSBhlAs5SoKuSEqjrNzhbG2a8eC3cJs+Tl4GqE2gke+B6OPhVHbk2cwyz8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299541; c=relaxed/simple;
	bh=4kHiA5VbJNw+84j6qIES1rmY1aKL3z1ug0pTAXVVNn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=enWNMYpVEHvJ5KH372zN43l1MMNSbdI2uYqOdarrym2+ZEomfDIQhgu3goIah/FCdoM848omrmt+TXU44vJWvb/jZOVkjh06EjbW1qFBIi7aQq7XSfUSno1SZtwnlQT9a5udY2k3LgUdW4jTCgwdANeL1rQyqQXvd70sRmtVLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F10BFEC;
	Mon,  2 Sep 2024 10:52:46 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24F023F73B;
	Mon,  2 Sep 2024 10:52:19 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 7/8] dt-bindings: perf: arm-cmn: Add CMN S3
Date: Mon,  2 Sep 2024 18:52:03 +0100
Message-Id: <2150e87f33284ba55cf6594def018a02bcf809fe.1725296395.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1725296395.git.robin.murphy@arm.com>
References: <cover.1725296395.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CMN S3 PMU is functionally still very similar to CMN-700, however
while the register contents are compatible, many of them are moved to
different offsets. While this is technically discoverable by a careful
driver that understands the part number in the peripheral ID registers
(which do at least remain in the same place), a new unique compatible
seems warranted to avoid any surprises.

CC: <devicetree@vger.kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/devicetree/bindings/perf/arm,cmn.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/perf/arm,cmn.yaml b/Documentation/devicetree/bindings/perf/arm,cmn.yaml
index 2e51072e794a..0e9d665584e6 100644
--- a/Documentation/devicetree/bindings/perf/arm,cmn.yaml
+++ b/Documentation/devicetree/bindings/perf/arm,cmn.yaml
@@ -16,6 +16,7 @@ properties:
       - arm,cmn-600
       - arm,cmn-650
       - arm,cmn-700
+      - arm,cmn-s3
       - arm,ci-700
 
   reg:
-- 
2.39.2.101.g768bb238c484.dirty


