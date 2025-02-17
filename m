Return-Path: <linux-kernel+bounces-517755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AD1A3854A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C17188E236
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50921CFEC;
	Mon, 17 Feb 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XeBHt+5d"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052621CC42;
	Mon, 17 Feb 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800937; cv=none; b=u25qMco5EFBYhpHWUUHFXf8WuttWFAUnp4AzyVfavMmcJVa5w/732kepHjZToIvuvdjbZeNJ6bhPTDhVALxBv7J2fTAZ26cREizJbpBAj/1CCTrWHSXk4fsqHL32FTgP9yVVsIXGEggJF05pAzQbWQGYr/EnA/Wo0vqKPtIqcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800937; c=relaxed/simple;
	bh=kfkeDYaU/dVnJVEN5e+VabJI8XJNukmOaSEstRDdNKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VpP3TE25B13/sZBlQHhYdMzMzysR4lIHP3Cclphr4eU9vP1G2LztVr0fQHVbSvOAR6Lbj4oUNbyR78yoDN7qDu7QtLW0NjVXYZBJyiuhKA4pBTDHZiJJgNX++2V0QcwLMP5VT8jjViGGY7t+Mm5947lbJc2UsO+ZExDmvViNmk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XeBHt+5d; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HCcKM0008975;
	Mon, 17 Feb 2025 08:02:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=aXywMi9MJQ31GNPV
	ZBE09RlVxjK+AkC/PXIrTo2PFI8=; b=XeBHt+5d33atooeewNQ7Fd0QlbzWmZou
	xwaXRbYl+vH4ZK/5N2mWUVOitG3/aodxShoE7QTHQB2VmjtPpUfky6SzGJk1t/Kb
	YnygF8ZH96sGB9RRPdapDhINET5kFtR3Cu1vrF8wLlETb9iysKpb1sQyBHJQlVc3
	Rh9xqzDk/vlL9xrlS+ZG3boDnwOKOqQmBU36gmyz/dqh7lVBuubcpGtYPdOEXpfk
	Kb3vgRez2Fppi5L1oTOUSq/xOEisvLbFl6PnlAuj9E5efypDeiHC3YV1Km2MOlFR
	yU5ZhX6L5KkZfBE8riVZVknLx8alraGDL6fZnSkzBFxAi36QaiVbhQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44uwg18x31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 08:02:01 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 14:01:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 14:01:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B5451822561;
	Mon, 17 Feb 2025 14:01:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 0/4] Add SDCA register map support
Date: Mon, 17 Feb 2025 14:01:55 +0000
Message-ID: <20250217140159.2288784-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AgCBs5DDDpcugdzOABSlKJvgIPrnCma_
X-Proofpoint-ORIG-GUID: AgCBs5DDDpcugdzOABSlKJvgIPrnCma_
X-Authority-Analysis: v=2.4 cv=CYzy5Krl c=1 sm=1 tr=0 ts=67b34159 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=Vaa6vib34c3EycRUSZkA:9
X-Proofpoint-Spam-Reason: safe

This series is the next step of adding SDCA support. Here we add
helper functions to allow drivers to easily use the SDCA DisCo
information to create a register map for the device.

The basic idea here is the code takes the list of SDCA controls parsed
from DisCo and uses primarily the Access Mode to determine if the
register should be marked as readable/writable etc. Further more
some additional concepts such as DisCo Constants and Defaults are
handled. There is some potential confusion, as DisCo Constants are
handled as an entry in the regmap defaults table, whereas a DisCo
Default is simply handled as a write to the register. Alas the naming
confusion is an unavoidable result of the slight impedance mismatch
between the two systems.

Thanks,
Charles

Charles Keepax (4):
  regcache: Add support for sorting defaults arrays
  ASoC: SDCA: Add generic regmap SDCA helpers
  ASoC: SDCA: Add regmap helpers for parsing for DisCo Constant values
  ASoC: SDCA: Add helper to write out defaults and fixed values

 drivers/base/regmap/regcache.c |  31 ++++
 include/linux/regmap.h         |   7 +
 include/sound/sdca_regmap.h    |  31 ++++
 sound/soc/sdca/Makefile        |   2 +-
 sound/soc/sdca/sdca_regmap.c   | 321 +++++++++++++++++++++++++++++++++
 5 files changed, 391 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/sdca_regmap.h
 create mode 100644 sound/soc/sdca/sdca_regmap.c

-- 
2.39.5


