Return-Path: <linux-kernel+bounces-240792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6739272D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BC6287B2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8221A4F3A;
	Thu,  4 Jul 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="j77lwI7/"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CE16F8EC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084838; cv=none; b=cTIYA/41/BTDlDP32xjtJZLHxfzBlCc6HYKb24U+BRl8vIVcqT1J9fPHlkLH5M1T7kxl5wuZhdLYQykK9kiIF4DwJRW+bMEzgB1n/0918/qRbwrkf4pX3JZulvq6BIAkenT7cSAVbge1cF86Y3SbIT5Ue8v7CaXBBlok1/YPJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084838; c=relaxed/simple;
	bh=+2ua+XYIcxbadw7T3I3lIrVAQEP5vGpulBFWqklRWgc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nLihGHT3E6L3ell8V9EG2oeBEGVyuv4xVFqQOXK2OM8aBipeSMJYDYh1AtmsHYNRXO8ApJv5BVDxpkrLpfpEXQNdunIP/yM/2igVNy7KMwvlGKHW0p8FdMe1zu2B7a1GVmyYT8TbTuiS6ajbuEk6WbD66tBfJJd0r4Kco1KoGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=j77lwI7/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4649IgSX007482;
	Thu, 4 Jul 2024 02:20:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=QeBEnYN3w5j0p0EMoC3lnOv
	Ms21dtE1iXd+uxnu+ZRI=; b=j77lwI7/HHXdzKvoFis1KgqR5i5crmjzI+di2Er
	KlvYj1xmeX0X02bkLoJl0WAI99cHL2/Pw+j+9+t55DpzjZni8Rh8P6NULUnnBhK8
	4mxRjk7jhPKoAVnGvf0cEOSOyoKLTWS9dFiRovCb3mbuCO7IqLq+xjCz/Rfx4l5P
	aj8PXZ2pImbAGXTcH/pFcaYrxJ9uBW+UhegGwdaObU8eN5AjIZMG4WXNjab+dv04
	KpQM/ApSHrKPZCnqX/YT2vwDakn9ienhzqlt/UETD9BoK1VxhTmK/AL+a08lmMrp
	DJWtNlul5QXKRMTgCjM8ZMo9JMYVe32qMQVnhnAn+oCtYxw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 405s01r07t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 02:20:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Jul 2024 02:20:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 4 Jul 2024 02:20:27 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 18EA75B692B;
	Thu,  4 Jul 2024 02:20:24 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v6 0/3] Marvell Odyssey uncore performance monitor support
Date: Thu, 4 Jul 2024 14:50:19 +0530
Message-ID: <20240704092022.1136805-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fNjQD6bCm_8qf1FjA6WWX00jPGgZIU1j
X-Proofpoint-ORIG-GUID: fNjQD6bCm_8qf1FjA6WWX00jPGgZIU1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01

Odyssey is a 64 bit ARM based SoC with multiple performance monitor
units for various blocks.

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the DDR PMU and LLC-TAD PMU.

v5->v6:
- Previous patch series didn't apply properly. Fixed the issue. 

Gowthami Thiagarajan (3):
  perf/marvell: Refactor to extract platform data - no functional change
  perf/marvell: perf/marvell: Odyssey DDR Performance monitor support
  perf/marvell : Odyssey LLC-TAD performance monitor support

 drivers/perf/marvell_cn10k_ddr_pmu.c | 530 +++++++++++++++++++++++----
 drivers/perf/marvell_cn10k_tad_pmu.c |  66 +++-
 2 files changed, 521 insertions(+), 75 deletions(-)

-- 
2.25.1


