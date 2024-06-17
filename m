Return-Path: <linux-kernel+bounces-217872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF1B90B56E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA21F22212
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1713C91C;
	Mon, 17 Jun 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fyewrraM"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E913C909;
	Mon, 17 Jun 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639004; cv=none; b=kwTSqHnb9xZAmPEuaQHVleyFmBDa1W80yn9+EEzHF5lYaxcdNprqr1sK8Bq9iFSCupo9VsZkmQnv8DqlhnTB2zur1FVnJy3jLS7fW8iuPxLapycggyxKPXmVaWqjSZI3XNhQbvgQug8m63DUNExHv8+12XuVQHQZwg2DpjZ9s1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639004; c=relaxed/simple;
	bh=5EBDDBE1vnWBgN770hldZP0JQKfpjmzXK7XyfzJtl+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CSMNyI+qnP7DjnusGG/KpGNMJdWKPPPCq7zVK9vsMI8YDi6h5gLsL2D/006Jdfb6aIqrwc1PognlXOer1E67KL4fQm250LARrnQhN8+ruB9AQZraYkilDa9JLkjifAZkirUuqSDVqoHsSs/d1slWMEMgPqaH6MLDhjP+QC0cExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fyewrraM; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HFYCxq023861;
	Mon, 17 Jun 2024 10:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=X91mzxfXMCn2bJmd
	FzbP55B/9zkijFCsomFlIi3vsw4=; b=fyewrraMYY0/Dq9nZjlT2y7t1Y1pe0Xr
	oCowargM2HLrfEGT3BZ3NA0YQ6vQRsCLJdSIRXdRyq9bA/s9mnVhKsgm+Y9vtmB9
	bFl0FZSYLh+n3Dpew5u5wiVE+eYv1fJC4cxql6PmjjHexml6MlWALH66gWcXWia8
	sqalZkMJIXG+hN90KicIfhktQ3Me15rxLwz08ZJdKiC0OfM8HLl22+mQ/GCe4T5H
	zbgllvYRaXOVqtE06iN+NddkYajV+0inAojsP/HtKD/WnccXQtB3vzk66FaSmbis
	F/a5ErFe19MW5kOS9/RTa3+kKzwBUKrjpVXKuPMocEDtq5z+JpqT5Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ys7cjt0f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 10:43:12 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 16:42:55 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 17 Jun 2024 16:42:55 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.31])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CCF43820248;
	Mon, 17 Jun 2024 15:42:54 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH v3 0/4] ALSA: hda: Improvements to hda_component
Date: Mon, 17 Jun 2024 16:41:01 +0100
Message-ID: <20240617154105.108635-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: gySmoCg_5vijXd0aN3iIlPqZ_KDUeChw
X-Proofpoint-ORIG-GUID: gySmoCg_5vijXd0aN3iIlPqZ_KDUeChw
X-Proofpoint-Spam-Reason: safe

This series of patches moves duplicated members from the
instanced component structures into a new parent structure and
introduces locking so that consumers of the interface do not use
stale data.

Changes in v3:
 - These Fixes separated from this series to make them easier
   to manage:
   https://lore.kernel.org/all/20240613133713.75550-1-simont@opensource.cirrus.com/

Simon Trimmer (4):
  ALSA: hda: hda_component: Introduce component parent structure
  ALSA: hda: hda_component: Change codecs to use component parent structure
  ALSA: hda: hda_component: Move codec field into the parent
  ALSA: hda: hda_component: Protect shared data with a mutex

 sound/pci/hda/cs35l41_hda.c     | 43 +++++++++++--------
 sound/pci/hda/cs35l56_hda.c     | 25 ++++++-----
 sound/pci/hda/hda_component.c   | 75 ++++++++++++++++++++-------------
 sound/pci/hda/hda_component.h   | 48 ++++++++++++++-------
 sound/pci/hda/patch_realtek.c   | 17 ++++----
 sound/pci/hda/tas2781_hda_i2c.c | 33 ++++++++-------
 6 files changed, 141 insertions(+), 100 deletions(-)

-- 
2.34.1

