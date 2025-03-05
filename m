Return-Path: <linux-kernel+bounces-547338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D39E7A50600
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355B81890A04
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2923E2517AE;
	Wed,  5 Mar 2025 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Fi9GF/8g"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E81A5BB7;
	Wed,  5 Mar 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194458; cv=none; b=IAwB+NhL2EZXyc1v8rek9pkWa1OvtLK19qju1SVXp1X361lhjLflyY0Kv8SDJF5bYyQPYfnmsdB2oQQq7ol+xyQTVJA53nxZq1Erhmp3Ck8Am+0Xd5ZvBuuqCEuyGbmkenHGqy4DjNwvApxsp6xgZ+rufAARgiXKxDarPSjdIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194458; c=relaxed/simple;
	bh=LCoNFPIoKLKfexlPdpKMBQgXeJ0QG2nntHCMg9GWdxA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UAoadEVLis07CBhr22txJOYLv7Eso3ZJlTAL6g/TghxshB7Lixgtxcit/Ms6dSGld0C6eH1V6AugFb4TCBnnrevHpKAx4oB1jlKzUPL2JUPnf99bIAFjvGWjMFxM7FQnsknuZkEsdvIJeumHq/46jcuKg/ZEEa1jX67fqWHlO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Fi9GF/8g; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5254p2Q8002458;
	Wed, 5 Mar 2025 11:07:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=E0zPzR1RM+rEurPg
	SBBLezN7MBLNtE+MlO7cS5Or/6Q=; b=Fi9GF/8g7wvrqHSHetC5dgat+zSHccTA
	uZgiThloI/zbscmhFCjbII7YpTDC8pCP2t1m2EzuW2R0fVfF2+qU4v5H79B+ZDln
	/2HLKE5hXsaokheniinqbJpHkIihfHonSsLGBM54UkyIHYAU4q2Dv6jeSzyaCISl
	E9MPfIr60QzlITYHeMuu8FCuBFBgkWDyIMR+z7BgcwuvgOhoE7slHvY9IAphLiqm
	mYBsgo7zpFYQV3JFkQ89PxAoFC1aqY7PPV4t2ExsT3WNcWIHQDlrNBsELwKj9YOX
	J3wVmR71XHPo3QpPt1tH/YcLHTZWIDM29XjuzGCzt75wspic/fGJtw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 456e8nsap8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 11:07:21 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 17:07:19 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 17:07:19 +0000
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7AD5682025A;
	Wed,  5 Mar 2025 17:07:19 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding
	<sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/7] Add Support for various ASUS laptops using CS35L41
Date: Wed, 5 Mar 2025 17:06:44 +0000
Message-ID: <20250305170714.755794-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DpWs+H/+ c=1 sm=1 tr=0 ts=67c884c9 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=Fv_gtQbQqxOJfXE8ilcA:9
X-Proofpoint-GUID: oqzrTVlP5dG-CZFhv6Xpv5IU6W2kq3nR
X-Proofpoint-ORIG-GUID: oqzrTVlP5dG-CZFhv6Xpv5IU6W2kq3nR
X-Proofpoint-Spam-Reason: safe

Add support for several Commercial and Consumer laptops using CS35L41 HDA.
These laptops use combinations of Internal and External boost, as well as
SPI and I2C.

Stefan Binding (7):
  ALSA: hda/realtek: Add support for ASUS ROG Strix G814 Laptop using
    CS35L41 HDA
  ALSA: hda/realtek: Add support for ASUS ROG Strix GA603 Laptops using
    CS35L41 HDA
  ALSA: hda/realtek: Add support for ASUS ROG Strix G614 Laptops using
    CS35L41 HDA
  ALSA: hda/realtek: Add support for various ASUS Laptops using CS35L41
    HDA
  ALSA: hda/realtek: Add support for ASUS B3405 and B3605 Laptops using
    CS35L41 HDA
  ALSA: hda/realtek: Add support for ASUS B5405 and B5605 Laptops using
    CS35L41 HDA
  ALSA: hda/realtek: Add support for ASUS Zenbook UM3406KA Laptops using
    CS35L41 HDA

 sound/pci/hda/patch_realtek.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.43.0


