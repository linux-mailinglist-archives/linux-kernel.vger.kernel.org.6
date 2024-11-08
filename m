Return-Path: <linux-kernel+bounces-401039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896B9C154D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0221F23E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252D81C4608;
	Fri,  8 Nov 2024 04:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z+EnQ3G2"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378841946DF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039086; cv=none; b=Jq8mskrifC98gY5s0zTeCYO8TRrFarn6hrqHiUqZsEJWOE4twqcG3QsxqzL+gl57QbGXirBqRNoBRRoC4jLmDLA3zvuI4U1NZwsbZWv6XXBRf4CJB1j9ZbSFnkalTM0GJ/dujq+K/QMlI5RsuHDmaJEDjhZc1+iOKCEivMvKheA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039086; c=relaxed/simple;
	bh=IrvRtzJHYX7R+xU1NLf/gdadFNJf3YpMiCueopYwaMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uMhnhflbFaTtly08xNwfBlR7mzX5dS+xzvlo44M0T53DEjvu/oK66O+GmpSemgx0JVcVPFyVZhMjICxAuzE9GajexmPUBKnCNdJxcqD4Ox/CrXZ6/T63viJBKYMdyJfpLsBxulm9tMmzuMKgxaSI/1bHQ8bQKuqe47MZiQI/fl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Z+EnQ3G2; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Mbwh6022799;
	Thu, 7 Nov 2024 20:11:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=1wEGUjdpFgNACr5ZDL63iBN
	nbF5aVkt4S1/n5E5N3fQ=; b=Z+EnQ3G2inp/kj2YwU2u4wX18p1DwZv7knnwK3y
	6g/66+MgDXPZPhtqq5mqZpJwk4IEpgD6CCPyqYCXQgACp+BiB60gUyfuza0uShLB
	tOsG0Qdit6TcqgW7kHRETA5V1TPa4zx7dfC0zj1dflrQvaDqDAoq9/ze769+w9Ru
	cEt+fXq/qKnNr/7vZEH33WZpFES4/+ORhH0u50KtvaegvtsWIb7vanmjkWnmciqL
	TOOk1MBtWRCylAE29L6UCafPgmH0QZoJaTXPTKxj0is6vURwiiLnUSoSi44qZQmx
	F5MPMvUv7fAWkyYp8gQkNZwk2LKDvlyHmMuY6USbomRwZSA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42s6gu8mba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 20:11:13 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 20:06:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 20:06:25 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 6C6405B6926;
	Thu,  7 Nov 2024 20:06:22 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <bbhushan2@marvell.com>, <gcherian@marvell.com>, <sgoutham@marvell.com>,
        <jonathan.cameron@huawei.com>,
        Gowthami Thiagarajan
	<gthiagarajan@marvell.com>
Subject: [PATCH v10 0/5] Marvell Odyssey uncore performance monitor support
Date: Fri, 8 Nov 2024 09:36:14 +0530
Message-ID: <20241108040619.753343-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qN7GfIEKEURhK3vqd4vwn4JlRO34r2BG
X-Proofpoint-GUID: qN7GfIEKEURhK3vqd4vwn4JlRO34r2BG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Odyssey is a 64 bit ARM based SoC with multiple performance monitor
units for various blocks.

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the DDR PMU and LLC-TAD PMU.

v9->v10:
- Minor code rearrangement based on the feedback
- Typo fix
- Updated commit description
- Added RB tag to one of the patches

v8->v9:
- Addressed the review comments.
- Added platform specific flag in DDR PMU driver instead of version
  as there is already a platform specific data.

Gowthami Thiagarajan (5):
  perf/marvell: Refactor to extract platform data - no functional change
  perf/marvell: Refactor to extract PMU operations
  perf/marvell: Odyssey DDR Performance monitor support
  perf/marvell : Refactor to extract platform data - no functional
    change
  perf/marvell : Odyssey LLC-TAD performance monitor support

 Documentation/admin-guide/perf/index.rst      |   2 +
 .../admin-guide/perf/mrvl-odyssey-ddr-pmu.rst |  80 +++
 .../admin-guide/perf/mrvl-odyssey-tad-pmu.rst |  37 ++
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 530 +++++++++++++++---
 drivers/perf/marvell_cn10k_tad_pmu.c          |  66 ++-
 5 files changed, 641 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst
 create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-tad-pmu.rst

-- 
2.25.1


