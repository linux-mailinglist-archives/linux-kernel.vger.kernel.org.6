Return-Path: <linux-kernel+bounces-427642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F269E0428
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D59A167693
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC05202F96;
	Mon,  2 Dec 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TN/+P2xt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA1201266;
	Mon,  2 Dec 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147841; cv=none; b=pQ96Gc+ii+sehxncXTCNapJkAfUiFAzCsOuktN2MnUbps6/bWIVk5oDpasnfdgBlzWfnW64P6WjMui4aRe25XI4JdM6t+4y9l5DgVuCwvY9gyzeUItXerfyUx6ilsIwJef16CCpAxj/N9ouMDxBiiQL3qsH47b5A5NQvhB5bGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147841; c=relaxed/simple;
	bh=az3ST4yKQO1us9La4XNRz5pm1652UmW7o5mq2zeYkKQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hb5cZE3uNDUarlLxqHAiq2Zp+7N8Wro1K5HeDPHs7wjUZ5b335B/Am2Ook7ZJ0ZJjTY8PYn3PP+Fte4R/7i9ef1M3Pr0XwKSl8BwGlfRexI9jyYGFo+WB4ZRjInF9nSySNnBTHT7sHUE6QX9QtgE06Vr7Lhy1phf1Yfcj0HSSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TN/+P2xt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28O112030853;
	Mon, 2 Dec 2024 13:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=ryzM+UHBU4Bb
	aXP1dpvs3Okdt/gwCxSKTmxPF2TiCEs=; b=TN/+P2xtwgd8+hB5c9RDyii87SuI
	4dYw31An+ay7YiO6XG/I3AkvQ7wm4lIfYdfrUgX0JGhEPru2E/mil3X+zQeTYF0i
	U18HrboMoKtGoqnp0RLx4OnFIixaZdPrf7Hv06T8jx0NSkgC3la5KWBstYfX+N1p
	oW4WKu176sf1VXhY1AzHH+T5EOPtufG1vVL/Xl7ks+ziirs7LE9sk2aOpqoMhjcl
	UR9RkTDh3zZfhVZ0s5G1rWcOn3cBK2m4+lywBhGwuUA/++qJLVmpw9cuJc1InQhZ
	Kr+Tuh2vZt59pmJuIeV7oDQIc9GhXPjpyPadW7MIkIg70W+rMJtbnZF2rw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437t1gd22b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 13:57:16 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DrBFq027303;
	Mon, 2 Dec 2024 13:57:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 437usm05u0-1;
	Mon, 02 Dec 2024 13:57:15 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DqVrF025688;
	Mon, 2 Dec 2024 13:57:15 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-vtanuku-lv.qualcomm.com [10.47.206.121])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 4B2DvEP4000607;
	Mon, 02 Dec 2024 13:57:15 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 410733)
	id DB3065005B3; Mon,  2 Dec 2024 05:57:14 -0800 (PST)
From: Visweswara Tanuku <quic_vtanuku@quicinc.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vtanuku@quicinc.com
Subject: [PATCH v1 RESEND] slimbus: messaging: Free transaction ID in delayed interrupt scenario
Date: Mon,  2 Dec 2024 05:57:08 -0800
Message-Id: <20241202135708.26219-1-quic_vtanuku@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qpoGXw126fHd_fJVeM4DByAYtL9gNSR9
X-Proofpoint-ORIG-GUID: qpoGXw126fHd_fJVeM4DByAYtL9gNSR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 mlxlogscore=876 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020121
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


