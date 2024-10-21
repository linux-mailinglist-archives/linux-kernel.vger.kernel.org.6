Return-Path: <linux-kernel+bounces-373966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2C79A5FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC681C21461
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C731E32BC;
	Mon, 21 Oct 2024 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nEtEdCJr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D141E1C0F;
	Mon, 21 Oct 2024 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502738; cv=none; b=XaBEFFYwVFtzAAplWpxhGOexbCuDfzea62PZN0x2nK6Pdd3or72zhaVV0TFtC+maxxbQT6G9mprtMyBt67z7WIUFwPAegNzMZ4L0+dFf2lMfsDy2Qo8MjDO5j8D4LXLmRhRQ5muI0d3gewsBzRsBLj7fiMXC9uNz+COj0V56mIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502738; c=relaxed/simple;
	bh=az3ST4yKQO1us9La4XNRz5pm1652UmW7o5mq2zeYkKQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LkTsUGmoQJwo9iav/v/6dIM8Y5HDpMassZUIjBssNiA5G6gEwPEJtCKdLqSusf6auYD59a2XJmWBChJNxtiZp4GyvIEUf76vXvFMO/nJgO8u2mchBXbhom32TC8rweigS6LGuNzyqTQqsOCEYcXu4eYuftJBhNA04u6K6AeJ5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nEtEdCJr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8Vp2D014299;
	Mon, 21 Oct 2024 09:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=ryzM+UHBU4Bb
	aXP1dpvs3Okdt/gwCxSKTmxPF2TiCEs=; b=nEtEdCJrerTG5qOZujczWJ0spUsO
	iK/d37yNo7VbSI2Q5j3M0ufVsejJwbCYuqM+B6Mr9vZFtbU1yXBKB5QR+sqfjoge
	xJAlkYRu8zZk1KcSREiAQA/PGtOsN2E0+I33aBz/XCLKTEDJgFgumfz3CkhuiO4R
	nvqXbESYe1ecmc2IOeJ3Nu0JdmChs7DhuC4rFDb5YG/ZBQYEwlE5xfhh/k2+2AEU
	dyx7HW97S5sPRQ942zkTlywG7Kqw6+fu+DM6VcYeAFI0q9aEakLvTT4zoxWx4YV/
	6Ge8hh8QXbxtcZNDiQECmp+Lz/XcL2Ki56eE1fH91sQiSkw0TX7jI16zEg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd07sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 09:25:34 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8tBho003519;
	Mon, 21 Oct 2024 09:25:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 42cp9rb6s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Oct 2024 09:25:33 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49L9Ld4Z019774;
	Mon, 21 Oct 2024 09:25:32 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-vtanuku-lv.qualcomm.com [10.47.206.121])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 49L9PWxF025908;
	Mon, 21 Oct 2024 09:25:32 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 410733)
	id 5417B5005B0; Mon, 21 Oct 2024 02:25:32 -0700 (PDT)
From: Visweswara Tanuku <quic_vtanuku@quicinc.com>
To: linux-kernel@vger.kernel.org
Cc: srinivas.kandagatla@linaro.org, linux-sound@vger.kernel.org,
        Visweswara Tanuku <quic_vtanuku@quicinc.com>
Subject: [PATCH] slimbus: messaging: Free transaction ID in delayed interrupt scenario
Date: Mon, 21 Oct 2024 02:25:05 -0700
Message-Id: <20241021092505.31240-1-quic_vtanuku@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cGK4F46DWsca6usXkkhkUf05UiQdA22i
X-Proofpoint-GUID: cGK4F46DWsca6usXkkhkUf05UiQdA22i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=799
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410210067
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In case of interrupt delay for any reason, slim_do_transfer()
returns timeout error but the transaction ID (TID) is not freed.
This results into invalid memory access inside
qcom_slim_ngd_rx_msgq_cb() due to invalid TID.

Fix the issue by freeing the TID in slim_do_transfer() before
returning timeout error to avoid invalid memory access.

Call trace:
__memcpy_fromio+0x20/0x190
qcom_slim_ngd_rx_msgq_cb+0x130/0x290 [slim_qcom_ngd_ctrl]
vchan_complete+0x2a0/0x4a0
tasklet_action_common+0x274/0x700
tasklet_action+0x28/0x3c
_stext+0x188/0x620
run_ksoftirqd+0x34/0x74
smpboot_thread_fn+0x1d8/0x464
kthread+0x178/0x238
ret_from_fork+0x10/0x20
Code: aa0003e8 91000429 f100044a 3940002b (3800150b)
---[ end trace 0fe00bec2b975c99 ]---
Kernel panic - not syncing: Oops: Fatal exception in interrupt.

Signed-off-by: Visweswara Tanuku <quic_vtanuku@quicinc.com>
---
 drivers/slimbus/messaging.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 242570a5e565..455c1fd1490f 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -148,8 +148,9 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	}
 
 	ret = ctrl->xfer_msg(ctrl, txn);
-
-	if (!ret && need_tid && !txn->msg->comp) {
+	if (ret == -ETIMEDOUT) {
+		slim_free_txn_tid(ctrl, txn);
+	} else if (!ret && need_tid && !txn->msg->comp) {
 		unsigned long ms = txn->rl + HZ;
 
 		time_left = wait_for_completion_timeout(txn->comp,
-- 
2.17.1


