Return-Path: <linux-kernel+bounces-544507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B0AA4E1DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3387AA644
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B43276D3B;
	Tue,  4 Mar 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eETCHX43"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493192517A3;
	Tue,  4 Mar 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099818; cv=none; b=gh9IoDWNzMBjThVSdXhoCzmRu69gRklA8LQyK0b39KnyuZnKuIbjwGWpazZoUoa9UAGrJOaPkuVJOj/BPSTWdj6dfkg37GVTTEsvjpLvsIbNqg6ukzmR3ZwVI3eXzaDyBssHSWnQETMIDGpsWLCipf4N67+NWHXRbgvuTFNhav0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099818; c=relaxed/simple;
	bh=S2vv2I0lRAzTLQjy6aBkrV5She4YB6ok9cGpfqGx440=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SP100m+ZVoMm4JxMDQ+zo+YFLoJ3OcRTdcJuykorjHqeWGzlVeCyETuTlgl4ytRBNESQfyamMANC68///+qh0PWDSWxn4X1D1l89KSGdIgUAUo0s6VST5I86Ir+7cv4LnLSTq519uNa+N+NP351yCuCROVfuUAWTiTojLHV+5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=eETCHX43; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5245gdjw021938;
	Tue, 4 Mar 2025 08:50:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=1k08KFxenrMqy7/G
	8yBibnQNuQBMeEok4mRyNMtNPuk=; b=eETCHX430bsYZMrjo8R5QCdywkbg2wlJ
	C8oDrVAjOHbMTS9wM2+MeXWH3d2APBgil88iifO7+kkEAkHRqrPXkLrubVAtjivi
	hh1Z9Qk3XBdWUB66/dCzSZBWUUBWM4ZFiDN2//BHn7NTpQgvLgUBEIigsXiwhbm0
	Mg0jhD9Gch9XndABI/QVkrRe1mZVreHLQng+gZ0rOQWx4Vq3pZ23lCC9mliGLsRT
	2PXrLco0wU/9xDZRU8Db1Yb3tphfz+kHNTNo/29hccv4rE4VS7YAQyPHWTlVmMah
	MZ75WUgAM05qKe6K5T+UY8mXyF3K81roM7Vwz1I0lJnU+NjbYgb3pg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj3j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:50:13 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:50:11 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:50:11 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 05DAA820248;
	Tue,  4 Mar 2025 14:50:11 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH for-next 0/2] ASoC: Add Intel machine driver support for CS35L56 on SSP
Date: Tue, 4 Mar 2025 14:50:08 +0000
Message-ID: <20250304145010.288082-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: B9PELdNn_n7S6-bw8CuyD6uJ1nywRCgh
X-Proofpoint-ORIG-GUID: B9PELdNn_n7S6-bw8CuyD6uJ1nywRCgh
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c71325 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=r3wmAV2J7K43Z6TldlcA:9
X-Proofpoint-Spam-Reason: safe

This adds support to the Intel machine drivers for CS35L56 codecs on
Intel SSP port using TDM. Also adds the match entries for this on
Tigerlake systems.

Richard Fitzgerald (2):
  ASoC: Intel: Add sof_cs35l56 driver for CS35L56 on SSP2.
  ASoC: Intel: tgl-match: Add CS35L56 on SSP2 for CDB35L56-FOUR board

 MAINTAINERS                                   |   1 +
 include/sound/soc-acpi-intel-ssp-common.h     |   2 +
 sound/soc/intel/boards/Kconfig                |  15 ++
 sound/soc/intel/boards/Makefile               |   2 +
 sound/soc/intel/boards/sof_cs35l56.c          | 254 ++++++++++++++++++
 .../intel/common/soc-acpi-intel-ssp-common.c  |   1 +
 .../intel/common/soc-acpi-intel-tgl-match.c   |   5 +
 7 files changed, 280 insertions(+)
 create mode 100644 sound/soc/intel/boards/sof_cs35l56.c

-- 
2.39.5


