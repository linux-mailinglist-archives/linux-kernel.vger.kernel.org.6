Return-Path: <linux-kernel+bounces-198980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FD18D8013
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323DE1C22AB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0682D6C;
	Mon,  3 Jun 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="H1LEL9pp"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DCD282ED;
	Mon,  3 Jun 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410942; cv=none; b=rphhR+1O71GsXch+hQsAsycOyizN/28e1iEetyFCwAjD1iT2K0XGwd4w7g/PQr9eRImi2KbqmHBA3c8xf58PKS3p+jRz9HtDodY99kjt2+ZwsfSUlPx1qx6sUHgPYeU91RFIFllPU76/ZEWH+OXCrQp8u1yhyOM7mFNbQ1HAhBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410942; c=relaxed/simple;
	bh=baScvVV423t4e+VkQ5YMVh9kY4BKIx6DRtRf9/Ehr8Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXODK8XT6r/uI64qoIpEi2KDMo9DsOXGdh7/HbUUN7xfqBPWD2MRMRFVL9TksQ2XSPE+EfhDuWoGMAdnbwuTanAXWfPof/G76IHoL5eCbbbKzUr9qFr5pbRosOTuhVjrEq5A3TrKgTHYqZ/HrR4vklbHY3nH0Y8VxRqcnzCf+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=H1LEL9pp; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45350SKr024505;
	Mon, 3 Jun 2024 05:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=W4exEjotWKI1CI+T
	j8zwikkt7tJTdgTM16vK6Pqc+Sk=; b=H1LEL9ppJrnwiSBJ04eaMI9a5oXClPDJ
	7Q4nn7o1XL8NaWCBVFVFklT9ZFy0tSrMJoNdI1Kty2sv+RTCTzTUQU1pVo1n2YHz
	XO++C6I9aIucrFXE9ebPYQF24Nn88Kac7Ayv/eK8lh/6OiHikF70gIIUp2CQk/ye
	eHYUESdRa5mo/El3BC+TgylVmUDS4f1p5VLyx2aE5dJDE6TlTEcQk9hQ9vHKmZEE
	85IIp/8DkloXZWsY0J1ityXjBza6nNAYBICjvoCJnkbKjMFlfTsMtdNVxJFSwnGd
	MszstPp896oJhjY62BVAP9cD1spFI/cwV4AwUgkHbd1pKbCRnQFPVw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yg02hhdrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 05:35:28 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 11:35:26 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 3 Jun 2024 11:35:26 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.64.166])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CD11A820249;
	Mon,  3 Jun 2024 10:35:25 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <kailang@realtek.com>,
        Simon Trimmer
	<simont@opensource.cirrus.com>
Subject: [PATCH v2 0/7] ALSA: hda: Improvements to hda_component
Date: Mon, 3 Jun 2024 11:35:17 +0100
Message-ID: <20240603103524.32442-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0e99rMdBQF0miLEo9vYmj9jHyiB1CfhF
X-Proofpoint-ORIG-GUID: 0e99rMdBQF0miLEo9vYmj9jHyiB1CfhF
X-Proofpoint-Spam-Reason: safe

This series of patches makes sure that the existing consumers of
the infrastructure unbind their interface before they begin
destroying the driver, moves duplicated members from the
instanced component structures into a new parent structure and
introduces locking so that consumers of the interface do not use
stale data.

v2:
 - Correct application of sizeof to pointer flagged by kernel test robot

Simon Trimmer (7):
  ALSA: hda: cs35l56: Component should be unbound before deconstruction
  ALSA: hda: cs35l41: Component should be unbound before deconstruction
  ALSA: hda/tas2781: Component should be unbound before deconstruction
  ALSA: hda: hda_component: Introduce component parent structure
  ALSA: hda: hda_component: Change codecs to use component parent
    structure
  ALSA: hda: hda_component: Move codec field into the parent
  ALSA: hda: hda_component: Protect shared data with a mutex

 sound/pci/hda/cs35l41_hda.c     | 47 ++++++++++++---------
 sound/pci/hda/cs35l56_hda.c     | 29 +++++++------
 sound/pci/hda/hda_component.c   | 75 ++++++++++++++++++++-------------
 sound/pci/hda/hda_component.h   | 48 ++++++++++++++-------
 sound/pci/hda/patch_realtek.c   | 17 ++++----
 sound/pci/hda/tas2781_hda_i2c.c | 37 ++++++++--------
 6 files changed, 147 insertions(+), 106 deletions(-)

-- 
2.34.1


