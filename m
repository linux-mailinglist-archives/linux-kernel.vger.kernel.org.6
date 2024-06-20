Return-Path: <linux-kernel+bounces-222672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D61D910590
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D61E1F23D86
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F02175579;
	Thu, 20 Jun 2024 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FNjMccZP"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BEC8175E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889193; cv=none; b=d5pFKdsVxDkOjpcnjxthDgklpdyGbYX2YrFDSBwF+zO7J+U4nWe3knm0D/KgdCiOvZ3h0XmMCq0MElXX/c8+QfDmEDH5Juu22hmafilBPDkY6pnx+jlbBiERdIKE0eZNAwesDIeVEd7H/9FAe2f0Pyi+/BRtfwt6LRwJB2X9oRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889193; c=relaxed/simple;
	bh=5QobGKcMzWS0L/imv386TX9RQ22yKwBKkNioynEKs3U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FegkbHKUqcjrG4ilzy4KLZfuR2+s1SCNSCk5VawEJPEI2nHCloRdWIeNpy3eef2B2Kc1FNNelNpAnZ6SZlm/lME41GFIeSBKu3vhxt03VuWZuxQM+0SIHxije8gPDDeAhMeKmMp0S7R34Eb7a1Z+qknIVL/jE9rksfn6QOslRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FNjMccZP; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KC5CF4014642;
	Thu, 20 Jun 2024 06:13:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=OAkMbYlZ3HVuDROEb9uqOGw
	BlriAuNGM+bvkvRBxTIs=; b=FNjMccZPwtGNxPAoCuG4rVnq6gdvDgmZEof3W/I
	K5Kz3Yb0JzsLKqIIcK2pMCn2aA0r10DsPBSBoJLE8KaZJ9GqFoLwxhRK4+mAi7kd
	t3NSphcd46urDblBpxPNwPUjtEmqHV9Zrm26rfPv8N5rAuHgCcc60NljrBRe0MQ5
	ZNF4YnQazTB3Qwd3dlHTcp8Z3Sli/djujNu7oL6OHUv54O9DXmaRUNjTRfmCX93Y
	jX+nRhXS7WpsmqVNxTxmbsopR8PX5id/HBDtgtE26fveMrQOkXX7AquzvRGsrYnk
	TBeSuDVa7NNamgT9/7CJlXRz3fgm5JmwUH3WNpKm3QAaPfg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yvbdya518-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 06:13:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 20 Jun 2024 06:13:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 20 Jun 2024 06:13:01 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 8089D3F70C9;
	Thu, 20 Jun 2024 06:12:59 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Gowthami Thiagarajan
	<gthiagarajan@marvell.com>
Subject: [PATCH v5 0/3] Marvell Odyssey uncore performance monitor support
Date: Thu, 20 Jun 2024 18:42:53 +0530
Message-ID: <20240620131256.590903-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vA_BB6_2SrmUgoBe5BFwy8dKGyP0Qb5W
X-Proofpoint-GUID: vA_BB6_2SrmUgoBe5BFwy8dKGyP0Qb5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01

Odyssey is a 64 bit ARM based SoC with multiple performance monitor
units for various blocks.

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the DDR PMU and LLC-TAD PMU.

v4->v5:
- Fixed warnings.

Gowthami Thiagarajan (3):
  perf/marvell: Refactor to extract platform data - no functional change
  perf/marvell: perf/marvell: Odyssey DDR Performance monitor support
  perf/marvell : Odyssey LLC-TAD performance monitor support

 drivers/perf/marvell_cn10k_ddr_pmu.c | 530 +++++++++++++++++++++++----
 drivers/perf/marvell_cn10k_tad_pmu.c |  66 +++-
 2 files changed, 521 insertions(+), 75 deletions(-)

-- 
2.25.1


