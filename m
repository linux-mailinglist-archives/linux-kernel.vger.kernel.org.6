Return-Path: <linux-kernel+bounces-281450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC0494D70E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C785F1F239C0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974015ECFA;
	Fri,  9 Aug 2024 19:15:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ECD182B3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230956; cv=none; b=RrfNHpBLu5PJqFzyeb6WC0R8sLVf3WbIOIq1NeBc8bV7u0JvrfbME120ftx6vN5yugeJadFqhvghrWztE5uhfAiGSLBHxPuud9GcBDCny2V+D+K3BabVk6uy5c6cECGEyZ6GMLGX43FOav2vvkUGIfBDSY8ICM7yA6kjwIURWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230956; c=relaxed/simple;
	bh=gU3uwBFgSfTnkqIBC6HiH9Kbtmt5IVITHtD62dG3Swg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UlCOUmiGCjXGGI2JghDLLGn1/lBlkL8Tdx3MylTdCZZCIiIO1LJ5vXMrkbWTIgYIg3HlgpPZ3woudGfAyATJExM7+RNRhZ6Av4pOQxPcXvdtMvYgJUNgh07bKXjquZ0S/k/opT+GqTqjpJByRlzSKEgTxdrbPxZ/ks+yPBv74ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 413F213D5;
	Fri,  9 Aug 2024 12:16:19 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A466A3F71E;
	Fri,  9 Aug 2024 12:15:52 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH 0/8] perf/arm-cmn: Fixes and updates
Date: Fri,  9 Aug 2024 20:15:39 +0100
Message-Id: <cover.1723229941.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Will,

Here's the latest collection of accrued CMN fixes, along with a
surprisingly small update (way more refactoring than new content!)
for the newest product iteration.

Thanks,
Robin.


Robin Murphy (8):
  perf/arm-cmn: Refactor node ID handling. Again.
  perf/arm-cmn: Fix CCLA register offset
  perf/arm-cmn: Ensure dtm_idx is big enough
  perf/arm-cmn: Improve build-time assertions
  perf/arm-cmn: Make cycle counts less surprising
  perf/arm-cmn: Refactor DTC PMU register access
  dt-bindings: perf: arm-cmn: Add CMN S3
  perf/arm-cmn: Support CMN S3

 .../devicetree/bindings/perf/arm,cmn.yaml     |   1 +
 drivers/perf/arm-cmn.c                        | 300 ++++++++++--------
 2 files changed, 169 insertions(+), 132 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty


