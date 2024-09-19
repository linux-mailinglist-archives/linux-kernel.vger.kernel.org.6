Return-Path: <linux-kernel+bounces-333189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C691D97C536
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67687B216AF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D08194C8B;
	Thu, 19 Sep 2024 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AtKbkD5l"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD92194C78
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732091; cv=none; b=hQRWTdMaItiU4Cy2O+OS3AnWv2CjL9Ixk+zYTUP9L9Uj970ACjj6ItRNSlejinQnnikCZ1D7cltXdpuoatwt8LY24bwn2euHEE5SeGwXMgj1jNbhA6u50Ej0+lmqqCUqVpAXxR70fVslX1phKvr/A7A15B3Aac7qFvKsYVvXXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732091; c=relaxed/simple;
	bh=fMK2vHKt72NaOxlFFmitjq9xSEOHIXJsPivzWFZb4T0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TuaEwCaF7OxikvEIoBLtifc7TFnbV2iswelml/hj2m5Q3Q9A6ps9ClwlhNOQORMORYAXWSW771KYIcD1EHNjBH3ig4OQawGEUbAVvVC3YrtlO3HaCbr6C6EijSMqqii5T6OdBNzNYqMDl7dzlHn1RUBc1PlgOxlcvx1Uh26dK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AtKbkD5l; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J6KVN0031226;
	Thu, 19 Sep 2024 00:47:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=fis1F+2vLYA5jjS4Brh0rDa
	ABLlMjF6lNOqFy5q0M6s=; b=AtKbkD5lWp0cKTtVpnIUp0hjd2xsAoWcgk27C0h
	BY9mYltROSklDlTMVdAU1f8dl9nuQNoBDtwBgZtjltni+NR6bHOYVr8+H5XAwTrV
	TNH5wknJePcpok3lYEQRtL1V6mLsY7JAzkM2pLNW5R4FnKGxjZYlharG5CUgxh7c
	ixztE5kkftpTc4fP3kVvYvR4VQ8b3KF+ver+8AhiEpseXUEyI5+rBJzSOSg2FPWg
	mZYgHfQUWylKDfudoXPJXbEzkWBXgzoAgW7YzUCbHKkOUCh4m3PMO251m+5FpFpN
	AY0hysvBaknhcQF1/yGoFgIox1t3oy33jgkNadzt8CV/cUQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41qdwgg7um-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 00:47:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Sep 2024 00:47:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Sep 2024 00:47:22 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 4C9AE3F7082;
	Thu, 19 Sep 2024 00:47:20 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v8 0/6] Marvell Odyssey uncore performance monitor support
Date: Thu, 19 Sep 2024 13:17:11 +0530
Message-ID: <20240919074717.3276854-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EW4bdoqcaSomDFz09W3jh7kl71zgbiiA
X-Proofpoint-ORIG-GUID: EW4bdoqcaSomDFz09W3jh7kl71zgbiiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Odyssey is a 64 bit ARM based SoC with multiple performance monitor
units for various blocks.

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the DDR PMU and LLC-TAD PMU.

v7->v8:
- Fixed the warning reported by kernel test robot

Gowthami Thiagarajan (6):
  perf/marvell: Refactor to extract platform data - no functional change
  perf/marvell: Refactor to extract platform specific ops - no
    functional change
  perf/marvell: Refactor to add version - no functional change
  perf/marvell: Odyssey DDR Performance monitor support
  perf/marvell : Refactor to extract platform data - no functional
    change
  perf/marvell : Odyssey LLC-TAD performance monitor support

 Documentation/admin-guide/perf/index.rst      |   2 +
 .../admin-guide/perf/mrvl-odyssey-ddr-pmu.rst |  80 +++
 .../admin-guide/perf/mrvl-odyssey-tad-pmu.rst |  37 ++
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 535 +++++++++++++++---
 drivers/perf/marvell_cn10k_tad_pmu.c          |  66 ++-
 5 files changed, 644 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst
 create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-tad-pmu.rst

-- 
2.25.1


