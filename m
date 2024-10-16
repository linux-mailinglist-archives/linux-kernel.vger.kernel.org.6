Return-Path: <linux-kernel+bounces-367529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4CB9A0378
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D899FB2453B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E771CBA1B;
	Wed, 16 Oct 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kMa7zmI1"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA9165F1A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065750; cv=none; b=OC+Es5mMqFHPmUICeW4aEABeHrjshdBldW51mPh5SIi+DAF47Zq2gDggXvarlyZ/QbMZ+DRW4Xz471yGeRxsOIQTlOcRlCoQHK4MAsgSUkswfo9Ry4ziDB1TRGR6iwB6pjPkluUAM86/0seaKK8KH2oPyHimJmKN3g2PCPQ+ENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065750; c=relaxed/simple;
	bh=cMG59VbWtdd6kbGdD1k9MKeyHbvip4f0lbniB6UTT4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JLdUJadsq0Q6keFN8zsJDpzCMXJNL5gkU9sNAgAKJfK8LsiM21I9uKljS+CPZTGc49yVkqOU6z0voiAxAviJOE0Z0U9QLWuXWx7D1BEG/Cvn5MFPyVUwiFqW7mr2/ja+Bj4l3ocO49Gy9BUB8o/U+1m4y5Ly/iVrCzS8PEtBN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kMa7zmI1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G37u71008286;
	Wed, 16 Oct 2024 01:02:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=/x962+IYdit39k/M4/0b8X4
	fRrDBungmMIOQSwSbcOM=; b=kMa7zmI1UZvLKNlqOH3aweEBrpqe03oQ/Z6aASm
	ShtGKRsGrM+BLskiC/dEvItlWCVRE8GPWAdJBCz8DUJ3hp2pnjUPt1gI+jNVTfL1
	mFZieDLhJC/XRJqD8KoIFgWGeLjZFX5OS+q+dWFs70muEHIWbfGdQsHRrPPc3UQK
	VcltBgG/16VUK0mMh/JXmD0OaDz92GP8FcXUymNB16E6iRJpD5+pzvWPMQtuBMJ/
	jUEh9pJWBufb2O1g21i5bZCUR3gGovtwNlsslQ7NLOVBmKloD0Yz/Wvz5xumBmPP
	6phvVDR5mfHJlzO9kpZxjaKByyf2e4O9L+ojoN+bkKVRlSg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42a5ahre34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 01:02:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 01:02:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 01:02:07 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 0B26A3F706D;
	Wed, 16 Oct 2024 01:02:04 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <bbhushan2@marvell.com>, <gcherian@marvell.com>, <sgoutham@marvell.com>,
        <jonathan.cameron@huawei.com>,
        Gowthami Thiagarajan
	<gthiagarajan@marvell.com>
Subject: [PATCH v9 0/5] Marvell Odyssey uncore performance monitor support
Date: Wed, 16 Oct 2024 13:31:48 +0530
Message-ID: <20241016080153.3546353-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JG5qzsqowmdtQt8NkvvceT5fAEaIERD_
X-Proofpoint-ORIG-GUID: JG5qzsqowmdtQt8NkvvceT5fAEaIERD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Odyssey is a 64 bit ARM based SoC with multiple performance monitor
units for various blocks.

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the DDR PMU and LLC-TAD PMU.

v8->v9:
- Addressed the review comments.
- Added platform specific flag in DDR PMU driver instead of version
  as there is already a platform specific data.

Gowthami Thiagarajan (5):
  perf/marvell: Refactor to extract platform data - no functional change
  perf/marvell: Refactor to extract platform specific ops - no
    functional change
  perf/marvell: Odyssey DDR Performance monitor support
  perf/marvell : Refactor to extract platform data - no functional
    change
  perf/marvell : Odyssey LLC-TAD performance monitor support

 Documentation/admin-guide/perf/index.rst      |   2 +
 .../admin-guide/perf/mrvl-odyssey-ddr-pmu.rst |  80 +++
 .../admin-guide/perf/mrvl-odyssey-tad-pmu.rst |  37 ++
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 516 +++++++++++++++---
 drivers/perf/marvell_cn10k_tad_pmu.c          |  66 ++-
 5 files changed, 630 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst
 create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-tad-pmu.rst

-- 
2.25.1


