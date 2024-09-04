Return-Path: <linux-kernel+bounces-315732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F796C655
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B8E284581
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8145C1E202C;
	Wed,  4 Sep 2024 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="V78vCTsN"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F91E2019
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474396; cv=none; b=i4KeAlIv3/6INiv0mzqqJsqpUYScLMMy4K/oBRRBP/N0vE5twsVhwCYWKIg/Fi05CeaansUTdlOfaVPYMV2rTRpjUsXqevcuT3VAixecgdds8k40v0GPRewcPDhcdVECbs9fD3n+I+58CDeX6/5FIifknjLoQrTnb3cD3dmDKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474396; c=relaxed/simple;
	bh=LmoqPMydPkqri6UTLapaQSsSa+2+cXFQg9obs7qRHsI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s97ZVXCVtYbZX3GcwHvMrUMjMsbByU1AccY44B4Ui3Afti99HTHQbTtKlpco1InYscnN0dRsjcmTVmcnz+agcQXnTFC0y4aNQhN0Jyx+tu/IsLHQbbaWv47gSCAWkoYRMwtH0FgOKKctx8Etoaz4aSW7KmvEfQQFvF8czmKfRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=V78vCTsN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484HZw47031921;
	Wed, 4 Sep 2024 11:26:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=9tP4dx79zoZsiDcBgNxes3v
	/QTiBOiCbvxndNVPHuts=; b=V78vCTsNGZOXYrwxY4E1ToN47dWJVLmBw6sFSZB
	abfoDtqYVnB5QY2LFfzlqILEqT/f+kWIQLs89oujeSmlly0tKnoEoPWdd18Cn029
	zRP65x4VHwEmyVQF2lG9rxCXQ7eRK7yAs/AodJhVZ1B3reffYN5qs5S/CB/yMh24
	H+OAhWgsLp3BSq8ESbUZw+UNqVSsG/ihi2YURiNsrhsYFVIJrAynHbfbmYWq18pG
	U5ZlgVSZfoKavkXFDLWQR0xMeUyy/20JDH004xK9W9N+XHS43pAAwa/rIxfDRCG7
	1NXGJUk5yD0VZiiINguPTjyE8YXt91Z4m3yvX9+mFt4ykTw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ev31r6fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:26:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 11:26:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 11:26:24 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id DB5623F7044;
	Wed,  4 Sep 2024 11:26:21 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v7 0/6] Marvell Odyssey uncore performance monitor support
Date: Wed, 4 Sep 2024 23:55:59 +0530
Message-ID: <20240904182605.953927-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: q_-X9WBHhbH9k30u0bYHb6g9sQWbJp9S
X-Proofpoint-GUID: q_-X9WBHhbH9k30u0bYHb6g9sQWbJp9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01

Odyssey is a 64 bit ARM based SoC with multiple performance monitor
units for various blocks.

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the DDR PMU and LLC-TAD PMU.

v6->v7:
- Split the refactor patches
- Added documentation
- Addressed minor review comments

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
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 533 +++++++++++++++---
 drivers/perf/marvell_cn10k_tad_pmu.c          |  66 ++-
 5 files changed, 642 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst
 create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-tad-pmu.rst

-- 
2.25.1


