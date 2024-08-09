Return-Path: <linux-kernel+bounces-281457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B79594D719
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EE0282FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D5116CD24;
	Fri,  9 Aug 2024 19:16:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A116B75C;
	Fri,  9 Aug 2024 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230964; cv=none; b=chZfaYe4D+FWPdSreInL6HJ+I9HnrJzBzO+fciRY+fcxb6QjuBCkEj2L9/E6XrPcK+IrsFF2yz2NofrOrkzAh7ndWR+tre0dD+BvM9L1alPIRThyvliHvc+U+CswAC9bg/EJ24QfxXxPDTNVrIiWrurrVb4BRR0A+4BDdBE6QNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230964; c=relaxed/simple;
	bh=mQG4EkxvpGIgH8SkmbXczVm5EQzJrZs9/CQUdWaHImo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRGLLN+1haJEYPuS+Y6EA+RXUOj6b8dDthC9qoRgvKFd1yRyzcOgk9hf2fcz8KMrHyw41X7JiGAABn98z8am9z3fefnYXpR6lPTXi7A509M+1mPb1tmG/Wlvo3gmJSun+Xw4tc/eX+c+NIIhyycnC3KrK8quDlnPiA/umjXMSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 636E413D5;
	Fri,  9 Aug 2024 12:16:28 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD6F13F71E;
	Fri,  9 Aug 2024 12:16:01 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com,
	devicetree@vger.kernel.org
Subject: [PATCH 7/8] dt-bindings: perf: arm-cmn: Add CMN S3
Date: Fri,  9 Aug 2024 20:15:46 +0100
Message-Id: <ec64f4d13b3b30c2ff242deddd302b1d1e256bd1.1723229941.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1723229941.git.robin.murphy@arm.com>
References: <cover.1723229941.git.robin.murphy@arm.com>
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


