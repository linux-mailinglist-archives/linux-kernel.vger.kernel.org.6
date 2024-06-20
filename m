Return-Path: <linux-kernel+bounces-222669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D0F91058C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B97B263A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88591AD402;
	Thu, 20 Jun 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LImavZfu"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E541ACE7C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889127; cv=none; b=pGp802Q5bnbXybsZEtd2om/6BNRk7KX0GN8D/41d0QbT9MoADKIQaUenhNqNzwAtKxWpRQucUMLuA4YfLhRmTAbM3DIoUrpu27VenV2v7Tta2efRoNpWoGs0efuc4UQLH4X3ejDJKJfeBn39r4S/GkhMg5hnyoVpxo9jx7HNfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889127; c=relaxed/simple;
	bh=5QobGKcMzWS0L/imv386TX9RQ22yKwBKkNioynEKs3U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hmgGvmYU4VtB4Igscxn5ygFe3KImWpAVXSO/xl0Qz1vD3hZhctkWF092FN4xdcBQnJZGCQZ/DG+CUYxahjRyqCr1LR7zN0Bypcp1BIPSjTJNjFU+kRF5nXUbTaCC/DkckEq5NziBKV4EZWX7tdcur8ayVj5d1rK2y04oCQ+pi28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LImavZfu; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KASrTw027624;
	Thu, 20 Jun 2024 06:11:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=OAkMbYlZ3HVuDROEb9uqOGw
	BlriAuNGM+bvkvRBxTIs=; b=LImavZfuHc2DSNVqQ5H2FE2lDHgcroqED8cKubC
	n7opL6r5Le8kSu+zTc5x/8AKn3cNl6gfxS3V2+Oh6RFBKOK/lxTixivex0ALQEIR
	HqWvGG+NHIkaQlFgQKx80d3dVJniAe1kyEndSRQfBETcuGUvo5fRwlIs48X5EJne
	PAHKujTu2ZwJd6vZkr7QMaKrOcPprdKawHLhcB7wMia2T2G9WJMIyWI0GXIn9FWo
	LClCLFlXVYAIwegGPH5KQzYvdzT+a1kG5FTLs/IDVVENBmqar1j4mLmxMkYtz4Vm
	YAbwgKFy6U4G9y9gN+8oTQNmhEa6o5S7ZJPW64V5Py98fIg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yvjq0gkr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 06:11:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 20 Jun 2024 06:11:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 20 Jun 2024 06:11:55 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 10A673F70C3;
	Thu, 20 Jun 2024 06:11:52 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Gowthami Thiagarajan
	<gthiagarajan@marvell.com>
Subject: [PATCH v5 0/3] Marvell Odyssey uncore performance monitor support
Date: Thu, 20 Jun 2024 18:41:46 +0530
Message-ID: <20240620131149.590748-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rtp5BQEb5BWfMxOpvfN7AjIT9SiOFM1L
X-Proofpoint-GUID: rtp5BQEb5BWfMxOpvfN7AjIT9SiOFM1L
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


