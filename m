Return-Path: <linux-kernel+bounces-218523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D7C90C154
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8C42829EF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6613FF9;
	Tue, 18 Jun 2024 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BDMVx1BV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2690FC0C;
	Tue, 18 Jun 2024 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674642; cv=none; b=JNAwIAt3XAOCVoSgMZvt6VyNi3ibhXuYeqW96Z+86nQRWfulZUVo2M6styfOn1YKNBy1YsmsHVAkvr8Rm5nBo/OLHJmhO6nxf/6uq3zBn5pawKJTwKvJXI2FpB4dwjgD5wNd6W83Xqbu6iT0c7/thaXm40txnO7iow8Y5fg8wzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674642; c=relaxed/simple;
	bh=ZCxXsmDoBj5cP7xmfFJ0FJxotceeXczVqyGFhIBJQhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qUCWjHUZetXwyPfCuWEAiIuztRj/3L/pV6jJicIBIZOEl35kS36qm52naUEeqhJmsTclxOKBKg2VKCy/wWUGDTKB4hD2+lpMnNx+/jlbqMS++o3d3MGdQShzKTwUrBqi6NeUqPHlM1bQxQuwJ4kxCLrJIB4PZYHNNX7rxhM9GFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BDMVx1BV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HI3bDj005282;
	Tue, 18 Jun 2024 01:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g1wdLtvXj4www4hzRwlM1Q
	0k4zjfx6II30nytPOxhnU=; b=BDMVx1BVD+hGdjvvbpUc0vgneiIDebG2dyNr4l
	YKa96QiZm6abvGePzfZdPC34X7fgOJyQ3Hzwoi1aQrNLCRG9rDdhyWg9TR8BuwKc
	epWkoHQ6o56pZIFGeTEpft030wGIVmeYNEcODVYMbxYI1amQFoec6zaVw3HnRGV6
	+672liux7Fa5nUv0V7WKjpRmcTnnCHtdGcpsdN2+RTNdctsEkU1YNbK57mRsorKw
	7WH7vVwgmKi+/J5gJpt7GhbGN7mHrXj0YDGDeebNRly58CnXZNFGJfS9i1K8JJ8/
	onxSsk6vyfGZeQInAe4vnOoDl9io2myvRM/LxXYUSQ7dEbmA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytt378sxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 01:37:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I1bBDg005114
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 01:37:11 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 18:37:10 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 17 Jun 2024 18:37:09 -0700
Subject: [PATCH] sound/oss/dmasound: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-md-m68k-sound-oss-dmasound-v1-1-5c19306be930@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMTkcGYC/yXMQQ6CMBBA0auQWTtJqaSiVzEshnaUibY1HSEkh
 LtbdfkW/2+gXIQVLs0GhRdRyamiPTTgJ0p3RgnVYI3tjGtPGANG1z9Q85wCZlUMkf44mz6QJ+v
 s0UIdvArfZP3Nr0P1SMo4Fkp++i6fkuYVa/zmAvv+ATScFWaLAAAA
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: moh1qhAxtf_dMn5dNmEKsGjniZ6IOXhY
X-Proofpoint-GUID: moh1qhAxtf_dMn5dNmEKsGjniZ6IOXhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180011

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/oss/dmasound/dmasound_core.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 sound/oss/dmasound/dmasound_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 164335d3c200..4b1baf4dd50e 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -204,6 +204,7 @@ module_param(numWriteBufs, int, 0);
 static unsigned int writeBufSize = DEFAULT_BUFF_SIZE ;	/* in bytes */
 module_param(writeBufSize, int, 0);
 
+MODULE_DESCRIPTION("Atari/Amiga/Q40 core DMA sound driver");
 MODULE_LICENSE("GPL");
 
 static int sq_unit = -1;

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240617-md-m68k-sound-oss-dmasound-908daca26232


