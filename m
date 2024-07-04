Return-Path: <linux-kernel+bounces-240713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4C2927190
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F24283A4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425D1A3BBC;
	Thu,  4 Jul 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oOYmZ+0M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2940BF2;
	Thu,  4 Jul 2024 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081164; cv=none; b=fse9wiwqMMNItjN7WSWWUpemJl5IPTZE5UogPBPVzVLXFWtH9X0MWr4qlKVM7mK4jpsivyTN5AJTUL49oAgRtp27mqDyzSoU2kuW7sIX0tFp8L8mLSEoyrQYgRcOiXwkiGUXePAeX8OzPzKgSbtAuNTp1KQwwb5pbNcjcNiLV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081164; c=relaxed/simple;
	bh=3knMpZHgzR7f69CQVQ68vB+p7FEWmq4/tjkWzISEutM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uWBhF07fWH4XirKy1sN1QaCtL2n4fpJfxNrfZujDzzlgkN/26r7N+T1swzzjZnmN1ODIBQ5gBByMfmw6jqG2zS+VabV9HdFtxKpF+2OLR2hAsEmcslHPDsrdRlSBtl78ZCf6PFRcsuGhQwuIydsco51di8IhC4y97dgcMwc+Tvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oOYmZ+0M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463JPdMo006059;
	Thu, 4 Jul 2024 08:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1TWDs8bthjJxV46juERV9k
	GY3wi9oWria9K9paXfeEg=; b=oOYmZ+0MEVv2wcUpT4Nj8V47VtZT1pjZ8VhvV5
	FGTXhQJS+CcFv5yTt1G6HPrTGi+vlZOAab4qyt1nOIP43jaVoDYxQ5OyG7TvXX1d
	U8Kl3qMzeCSsipANB6W7ziYdLglwyK3KKErNOZ5HIEYTXOwX/Ic5bqhUPYUe8MhZ
	YPSYgPv0df62BrZUGdQ1xrwqN0wGIhZXQWRCG8Ct/vPWSjeb1IHPTkbD3xaOfHpT
	YAfeG8gL9zU/2FM3yMgHb+TkQ+bDX1UDGuM5d6cmNhtP/4SUeGiILhVgjidf2Png
	/HKLXQi81RTkwWffx/uIC3B59A4odTDvIIjh50y9Soo1d2qw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029uxjv0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 08:18:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4648IrEw029958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 08:18:53 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 4 Jul 2024 01:18:50 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mohammad
 Rafi Shaik" <quic_mohs@quicinc.com>,
        Prasad Kumpatla
	<quic_pkumpatl@quicinc.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
Subject: [PATCH v2 0/3] Fix the unbalanced pm_runtime_enable in wcd937x-sdw soundwire slave
Date: Thu, 4 Jul 2024 13:47:20 +0530
Message-ID: <20240704081723.3394153-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MQcdktzic7wLO2nI32H81Ykq6f_jXYtu
X-Proofpoint-ORIG-GUID: MQcdktzic7wLO2nI32H81Ykq6f_jXYtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=816
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040057

This patch set change will fix the unbalanced pm_runtime_enable in wcd937x-sdw soundwire slave.

And removed the string compare with widget name in MIC BIAS settings, instead
of string compare use the MIC BIAS id's as value.

Removed separate handling for vdd-buck regulator supply which is not
required. The vdd-buck regulator supply enabled using bulk enable.

Added the error handling in wcd937x_probe() and disable the regulators in error case.

Changes in v2:
 - Remove Unrelated devm_free_irq change as suggested by Mark Brown
 - Link to v1: https://lore.kernel.org/linux-sound/a8a670f9-f03f-eff8-5cb2-b40b06267bc6@quicinc.com/
  
Changes in v1:
 - Fixed the unbalanced pm_runtime_enable in wcd937x-sdw soundwire slave
 - Removed the string compare with widget name in MIC BIAS widget settings
   suggested by Srinivas Kandagatla
   https://lore.kernel.org/all/33772eab-74c6-c5c3-fa25-3a643a2f9c57@quicinc.com/
 - Removed separate handling for vdd-buck supply
   Suggested by Christophe JAILLET
   https://lore.kernel.org/all/834d31cc-f4bc-4db7-a25b-f9869e550eb6@wanadoo.fr/
   https://lore.kernel.org/all/288156b9-2f72-6929-3422-c3aecb9c2c07@quicinc.com/   

Mohammad Rafi Shaik (3):
  ASoC: codecs: wcd937x-sdw: Fix Unbalanced pm_runtime_enable
  ASoC: codecs: wcd937x: Remove the string compare in MIC BIAS widget
    settings
  ASoC: codecs: wcd937x: Remove separate handling for vdd-buck supply

 sound/soc/codecs/wcd937x-sdw.c | 18 +++----
 sound/soc/codecs/wcd937x.c     | 95 ++++++++--------------------------
 sound/soc/codecs/wcd937x.h     |  2 +-
 3 files changed, 30 insertions(+), 85 deletions(-)


base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
-- 
2.25.1


