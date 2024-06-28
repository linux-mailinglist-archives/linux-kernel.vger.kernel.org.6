Return-Path: <linux-kernel+bounces-233742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD7091BC70
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AB21F23276
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A8155321;
	Fri, 28 Jun 2024 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ca1doqUa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCF548E1;
	Fri, 28 Jun 2024 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569574; cv=none; b=NfXqyIcBhFMjtEGdtDnc5ZXyS4B3nPpiMqmQvdYO+4jZcF0Up8NEX7fJxq8eWOZYGct/oTi27SsZLpR4FDgx7U/IzqcDTjZgHiDr7B4u3KXiHEIdUi85oOARZ3etcMPzgN581DqMiTXe0MOzjv+v6Cg1RD4a/eGDKFsV9+xrgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569574; c=relaxed/simple;
	bh=tlqzXOWXQgoNen47Ba3v0qwjriKJxD1QYb5W+N/xeGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ExlMoMT8a4DOtAx7+HpOGf1YL4zWGQ1vz6lPO0JG/Km3MBT3fhY3xIYHC6fhdm69tqwGj1Xrw9DtjTPqsaLtihrZXcPrP3Ylj/XenwSJ1hHk9vgz6y2K0aVnt+i2IXMZeZccFlmCoPZSN9NCByiLKvvuUYz0v1ZLktkueUO0L7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ca1doqUa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S4wRT0032233;
	Fri, 28 Jun 2024 10:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FqUbrPuKY0UjkNY75U3red
	TP6KpzZZUse/RKjCR/zYo=; b=ca1doqUacJNvIGEzoR/F7y1HXYo84/Dv0VvvMY
	yi+Sa+VTr6+SUV34MoKKj8Z+wvFMY4GLsdc9BPFjt6FRsmFqxypFnpwXTjgWgrXC
	Af6Tbp73lyExLQcSL1JGmS8PJf3Zx9o2b1kFX1HzYGIhPGWByJpl5kMwEf+bPTUr
	OvCjZBSg5a+Erp79As84F/hRqSzPLwKS5SnUolSxd3kgLC5SZzocct1Xq7NPEEJ7
	IwtLER14KvaCOrDSXCwD5eM45WDPm/T/h5LB+nvJjGQTJofiLE/1ZqQpnqTJ4gGa
	5x4WmqmXaeEZxKA2Vz2NsLMGic5ucZkglF3nbzV74brlaqkw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 401pm58wkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:12:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SACdCG016421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:12:39 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 03:12:36 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Prasad
 Kumpatla" <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik
	<quic_mohs@quicinc.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
Subject: [PATCH v1 0/3] Fix the unbalanced pm_runtime_enable in wcd937x-sdw soundwire slave
Date: Fri, 28 Jun 2024 15:41:40 +0530
Message-ID: <20240628101143.1508513-1-quic_mohs@quicinc.com>
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
X-Proofpoint-GUID: m_I0a4T8m8nvRRGie5rTHcQVxPk63D5d
X-Proofpoint-ORIG-GUID: m_I0a4T8m8nvRRGie5rTHcQVxPk63D5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=762 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280075

This patch set change will fix the unbalanced pm_runtime_enable in wcd937x-sdw soundwire slave.

And removed the string compare with widget name in MIC BIAS settings, instead
of string compare use the MIC BIAS id's as value.

Removed separate handling for vdd-buck regulator supply which is not
required. The vdd-buck regulator supply enabled using bulk enable.

Added the error handling in wcd937x_probe() and disable the regulators in error case
and also replace free_irq() with devm_free_irq() because irq has been requested
with devm_request_threaded_irq().

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

 sound/soc/codecs/wcd937x-sdw.c |  18 +++---
 sound/soc/codecs/wcd937x.c     | 101 ++++++++-------------------------
 sound/soc/codecs/wcd937x.h     |   2 +-
 3 files changed, 33 insertions(+), 88 deletions(-)


base-commit: df9574a57d02b265322e77fb8628d4d33641dda9
-- 
2.25.1


