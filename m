Return-Path: <linux-kernel+bounces-566617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D102A67A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721833AA19B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C16212F98;
	Tue, 18 Mar 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="aLqdbZzF"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32821171D;
	Tue, 18 Mar 2025 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318112; cv=none; b=Zat/WG4MfyxuXIh/CBFSDbwwlVFWyyOPOy7yEcXWerJjcVhp+fU5x/nalUQLZJVuGhf3yF6qHnx5Zfh6TtUSL2LBbAK9ClzXayhlLM00dll1OU2dKsk0GtWHsV+hx77L6VDfZEnz9XHDz+wFciPE/0LtaZQId8Ax7FH5DkwfL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318112; c=relaxed/simple;
	bh=IO3L5BgRgsafncnTaZpY5uoby/SIhMyLcJSxCOnqWIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FkYEEpenWNO+mBz2U6PxqfWj0IFcX9gt9/gdfiOFJrv/2AF5C4yvv1Us9idZhM35CIxmJyaOXU/ie18xTOmk21D7uGK2nAbSmnOmNax6MJgRo9k9WrocTXNKEVL8IQHqZnd95Nw4Cg83TZbetxiqCG0sGML6uUn/AnX8Xnkh3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=aLqdbZzF; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I5qiuB018522;
	Tue, 18 Mar 2025 12:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=8k51J9Oghs5JvbWH
	u+ZkYzQv0RCP1OenpzA2ShDfHHM=; b=aLqdbZzF5eJSUtGMKuycq75aFcKuN/gX
	Eg7EyGyD3MvfYJowxrUwGDbcQqoxSkYCFP3cYA3EBango/W7+GNMzgnQHkfznENb
	GgCYRVRmU1ntI/XXiMPRuuT0yKJS4Ovf0QXAyNODFpaTvABNSeF3UiaMupOlpUcd
	72fhIQFc53ZVIW8b2tCIsq8uYoPhOdIiuSSMQteXCB6SJjBTXJNRpsdi4I35wF3D
	kyNk6uPCyO14euBK119y6+AP8O2t7ZARUrlmf1YuiCpQmwIw2CpNTF3CZI4XTEqN
	G+GZefzpb8/H3PPbvS69UMJP5HiBkaREPjVGLUnfTvfPPKA3/QX6UA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:01 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7987282255A;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 00/15] Tidy up ASoC control get and put handlers
Date: Tue, 18 Mar 2025 17:14:44 +0000
Message-ID: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa15 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=dA91AMQFZq1surh0KrwA:9
X-Proofpoint-GUID: -UKVJgNFf_c1FJfaa-xRoXzUbLk3Dktv
X-Proofpoint-ORIG-GUID: -UKVJgNFf_c1FJfaa-xRoXzUbLk3Dktv
X-Proofpoint-Spam-Reason: safe

There is a lot of duplicated and occasionally slightly incorrect code
around the ASoC control get and put handlers. This series add some kunit
tests and then refactors the code to get all the tests passing and
reduce some of the duplication. The focus here is on the volsw handlers,
future work could still be done on some of the others but these were the
ones that most required attention.

Hopefully the only slightly controversal change is the very last patch
which changes platform_max to be applied after the control type is
determined, more discussion in the commit message for that one.

Thanks,
Charles

Charles Keepax (15):
  ASoC: ops-test: Add some basic kunit tests for soc-ops
  ASoC: ops: Minor formatting fixups
  ASoC: ops: Update comments for xr_sx control helpers
  ASoC: ops: Update mask generation to use GENMASK
  ASoC: ops: Factor out helper to check valid control values
  ASoC: ops: Replace snd_soc_read_signed() with new helper
  ASoC: ops: Add control to register value helper
  ASoC: ops: Remove snd_soc_info_volsw_range()
  ASoC: ops: Remove snd_soc_get_volsw_range()
  ASoC: ops: Remove snd_soc_put_volsw_range()
  ASoC: ops: Factor out common code from info callbacks
  ASoC: ops: Factor out common code from put callbacks
  ASoC: ops: Factor out common code from get callbacks
  ASoC: ops: Remove some unnecessary local variables
  ASoC: ops: Apply platform_max after deciding control type

 include/sound/soc.h             |  24 +-
 sound/pci/hda/tas2781_hda_i2c.c |   2 +-
 sound/pci/hda/tas2781_hda_spi.c |   2 +-
 sound/soc/Kconfig               |   7 +
 sound/soc/Makefile              |   4 +
 sound/soc/codecs/wm5110.c       |   4 +-
 sound/soc/soc-ops-test.c        | 541 ++++++++++++++++++++++++
 sound/soc/soc-ops.c             | 712 +++++++++++---------------------
 sound/soc/soc-topology.c        |   4 +-
 9 files changed, 807 insertions(+), 493 deletions(-)
 create mode 100644 sound/soc/soc-ops-test.c

-- 
2.39.5


