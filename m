Return-Path: <linux-kernel+bounces-449302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E599F4CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6945A16A299
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2F21F4E34;
	Tue, 17 Dec 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ov39MocW"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D31F472B;
	Tue, 17 Dec 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443987; cv=none; b=Wq0Nl6b7INp2fMSGLkuGX7t7gydcxq3B29Mej2Pqsd7Y7TmcD4p433u4aVVggTGysT2c8cOKL3iEZznfrGEJt+1FD9wLeZ4G7g6K9DAkG7CMxjSXyOOHoJM4YOWB7m/wrRSxglIUtUzEZ3mlLdz3Qwc1pAJQaUtBDnwcHnKwGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443987; c=relaxed/simple;
	bh=vcaWvU1mVvKkb8LGy5dgDo2p8II6fCGT2Wy2n/tfYws=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=inpfdWEDafma9sagWJTUwlG356aGMpqSC9JeOZm0bm13as5UADgOHZtMPLCABp5HC721r0WVtZf65VhS0QvN3jQ7LUpUhBvY1sCi+W81s0CstZUvQKaFWZ4i+VOPZ58FxJ6LI65i7AnPX51tCnO7m/IXOdElTakSypPNi4PPyg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ov39MocW; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH47Fax011049;
	Tue, 17 Dec 2024 07:59:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=ontzcTJ3Wt7tFRxO
	6o+t+jYROLL/GkNDAlK0bLDJ00g=; b=Ov39MocWl/knlsPZJg8RQt29eiG+lRRZ
	k/OljDsrrzjUw8eyIGYMhmjMxHdwkZBoY6BvTCgfqWr8LQg8FLGlptnbM1HF0PfV
	2krTnzdfbQ0pwCSMQPrWxwqQMiA2wyzL5kB1szy2YmZoh+pX54lk2PuZFmxMSjbU
	8j1JRM5AZZwIEQETCKBEy6Cy8G8lucgjudtkiooLHKffAul3L/KKXsCm+KfFiVgH
	8p01oXCdDVEgjgMSBxWs/Q2cmaa6lrVgJd1v7jguFOBNnTX5+MMF9FXVre41o60+
	1qfuQQqEmMtT3zWbhqNoTNj+7jzXBuqhRHzWg6QkvEERLjnDfYbFTA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43h7akbb0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 07:59:23 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 13:59:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 13:59:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C2C00820248;
	Tue, 17 Dec 2024 13:59:21 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>, <oder_chiou@realtek.com>
CC: <jack.yu@realtek.com>, <shumingf@realtek.com>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 0/5] Expand SoundWire MBQ register map support
Date: Tue, 17 Dec 2024 13:59:16 +0000
Message-ID: <20241217135921.3572496-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IIWbzRAlfIpAAB7dNJzxJA_V10zuuB6X
X-Proofpoint-ORIG-GUID: IIWbzRAlfIpAAB7dNJzxJA_V10zuuB6X
X-Proofpoint-Spam-Reason: safe

The current SDCA MBQ (Multi-Byte Quantities) register map only
supports 16-bit types, add support for more sizes and then update
the rt722 driver to use the new support. We also add support for
the deferring feature of MBQs to allow hardware to indicate it is
not currently ready to service a read/write.

Afraid I don't have hardware to test the rt722 change so it is
only build tested, but I thought it good to include a change to
demonstrate the new features in use.

Thanks,
Charles

Charles Keepax (5):
  soundwire: SDCA: Add additional SDCA address macros
  ASoC: SDCA: Update list of entity_0 controls
  regmap: sdw-mbq: Add support for further MBQ register sizes
  regmap: sdw-mbq: Add support for SDCA deferred controls
  ASoC: rt722-sdca: Make use of new expanded MBQ regmap

 drivers/base/regmap/regmap-sdw-mbq.c    | 219 +++++++++++++++++++++---
 include/linux/regmap.h                  |  62 ++++++-
 include/linux/soundwire/sdw_registers.h |  30 +++-
 include/sound/sdca_function.h           |  33 +++-
 sound/soc/codecs/rt722-sdca-sdw.c       |  81 +++------
 sound/soc/codecs/rt722-sdca-sdw.h       |  99 ++++++-----
 sound/soc/codecs/rt722-sdca.c           | 135 ++++-----------
 sound/soc/codecs/rt722-sdca.h           |   4 +-
 8 files changed, 409 insertions(+), 254 deletions(-)

-- 
2.39.5


