Return-Path: <linux-kernel+bounces-378591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49869AD2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351B31F21CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C91DC19E;
	Wed, 23 Oct 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BfGzXaI8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695861D319B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704295; cv=none; b=uoMNBlUJVjPZwxYO+Mg/JaXa9PjFs7T4wQSoAXjgmj1cp11IzGJm0nzqSIU/SqBp1eDF+Y/a5Iot2BHQKkVoTyeX20BQcXosZJQnctxH1u30uA4RRs5Xj4c+rwFsThsO+kMZq/ATy4CbIl2RjUhwlE84Sge8JA0qB/yZBnQ7iAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704295; c=relaxed/simple;
	bh=xOCRfMZplEN4lL5EAl7eiotn/mi8rdebzdBN70EmVDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=To0sfOA7RLKeYBlI8iQBuglrCK7FNXfCfs3NLbgDO6V9jVc0UAkXBTHnpVc8AdHV5rUN/GokUJLMb1flD9fXP7uD+koFic4njI3Uv9U7hpcB99tiiCx95UphzjVB2ELq5JS2gcYped234Lgg3y7uCgn7yTh3XEezzDcA2KHp3l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BfGzXaI8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9T32B028304
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6MyjRgUVKCgKeUMK1+TqDeLCghlcb2cp+pwcGYb/W+k=; b=BfGzXaI89pwyfRea
	lJlgyJikLPd6gGr0LNRLHQhmU0VZRMbn0Omceq5v1C5wgM4sE5M7BN+feepwDLbB
	1fI7siJAux4pWCuSGUZeE34JE3bcp9swqfbIUluzdX3v0cFMxS654hvf4XwrMMT5
	YgbVTaL7Vykdl7B61X/BmjyUjSRznOhkqAciINW2M6bqxyyEnf/a4uVry5qnXm30
	rv9kPntj9yHlVCCyM4eNTvSSv156Asrw9hkE2FwWshU5pzslDu18SH4Myhk3RhkX
	x5UzI6uHVNIpESWIOQD69GK3CaljJ1aSQfIFJru5Rj7M190oCbXGDuRexZClvkWc
	g36BHw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em41txm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:24:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-20c94c1f692so9289525ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704291; x=1730309091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MyjRgUVKCgKeUMK1+TqDeLCghlcb2cp+pwcGYb/W+k=;
        b=eCzwrcscqKwok0Ip3E0IpPviJq9+h3smO7TlkkMYQGriQC7QkRqTP2Wj3FgVRoy1Jo
         Uj1ISbDPvhSEtDQXHnDR84Bx1ZZis3RDwOh7ZU1Vzc+htQMQDxn/G2SmVDauqA9G35ti
         jzRLPX8r8itqio9GPFU67LePoiRThZreNH15pX0jKOJkIh+flB3B8glznlLI1J8yTwCy
         1IiJvH2SltbIhTHQB+m7z5hlInEPdciTFXmM+2FOldJQlczTDA3uoZ/hRsShsK181JgG
         nAif6lLLyFCsZ5Vf/aAvv/kM7RyEUQ3p9mIP03Gk2lB7B6ozeEgObsqEUdG6gey7NB6O
         pCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGZVSkZNUPO6zweHKBs8bWa95b9GQCjy5Fs35aACuIi3IPLKVtO7d998CMuirYRL6NOHs138nsudVjSm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwh3hs0idkBfaUX3UPfFqR4yTO7pDYVf4HbSvTCZp9hbDI/5t
	As2pTXOpou+PKpMd8Hsdi4NbszF1pGTT48LIdoDl2+HyRQP+uuNil/9XemvuhvvtBll8TkY4K17
	vDGI+8001iy/mP6Iodf2h857oAm69/5oCeYhUqYYR8q4GPKZS/9DWSpIh1rjhK2I=
X-Received: by 2002:a17:902:ce8d:b0:205:5d71:561e with SMTP id d9443c01a7336-20fab359d7emr55523525ad.26.1729704290919;
        Wed, 23 Oct 2024 10:24:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYJiQWMKPGKTinfN1ycfn0iszn1oRJ2Vq+Fv5kLbeQDb34PUfw7b82Mw9fdm3PNpgEndnlLg==
X-Received: by 2002:a17:902:ce8d:b0:205:5d71:561e with SMTP id d9443c01a7336-20fab359d7emr55523205ad.26.1729704290456;
        Wed, 23 Oct 2024 10:24:50 -0700 (PDT)
Received: from ip-172-31-25-79.us-west-2.compute.internal (ec2-35-81-238-112.us-west-2.compute.amazonaws.com. [35.81.238.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f20aesm59525435ad.246.2024.10.23.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:24:50 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Wed, 23 Oct 2024 17:24:33 +0000
Subject: [PATCH v2 2/2] soc: qcom: pmic_glink: Handle GLINK intent
 allocation rejections
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-pmic-glink-ecancelled-v2-2-ebc268129407@oss.qualcomm.com>
References: <20241023-pmic-glink-ecancelled-v2-0-ebc268129407@oss.qualcomm.com>
In-Reply-To: <20241023-pmic-glink-ecancelled-v2-0-ebc268129407@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729704288; l=3195;
 i=bjorn.andersson@oss.qualcomm.com; s=20241022; h=from:subject:message-id;
 bh=xOCRfMZplEN4lL5EAl7eiotn/mi8rdebzdBN70EmVDo=;
 b=sMW0URP9GdXIzZSR/llq7GbeNK9/gY6MxGuh9PYwDfyjno2R424IjxAMkJMAqd8L6zHcCQj27
 xco0w84zEOJC59147iMlnToYWgD4nlSYpS5/fNlDF9AampbM4pKa1wO
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=ed25519;
 pk=SAhIzN2NcG7kdNPq3QMED+Agjgc2IyfGAldevLwbJnU=
X-Proofpoint-GUID: 7kZKhMV6S25B47uzUP_6jFbx86TFlHo3
X-Proofpoint-ORIG-GUID: 7kZKhMV6S25B47uzUP_6jFbx86TFlHo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230109

Some versions of the pmic_glink firmware does not allow dynamic GLINK
intent allocations, attempting to send a message before the firmware has
allocated its receive buffers and announced these intent allocations
will fail. When this happens something like this showns up in the log:

    pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to send altmode request: 0x10 (-125)
    pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to request altmode notifications: -125
    ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI read request: -125
    qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: failed to request power notifications

GLINK has been updated to distinguish between the cases where the remote
is going down (-ECANCELED) and the intent allocation being rejected
(-EAGAIN).

Retry the send until intent buffers becomes available, or an actual
error occur.

To avoid infinitely waiting for the firmware in the event that this
misbehaves and no intents arrive, an arbitrary 5 second timeout is
used.

This patch was developed with input from Chris Lew.

Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/all/Zqet8iInnDhnxkT9@hovoldconsulting.com/#t
Cc: stable@vger.kernel.org # rpmsg: glink: Handle rejected intent request better
Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/soc/qcom/pmic_glink.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 9606222993fd78e80d776ea299cad024a0197e91..baa4ac6704a901661d1055c5caeaab61dc315795 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Linaro Ltd
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -13,6 +14,8 @@
 #include <linux/soc/qcom/pmic_glink.h>
 #include <linux/spinlock.h>
 
+#define PMIC_GLINK_SEND_TIMEOUT (5 * HZ)
+
 enum {
 	PMIC_GLINK_CLIENT_BATT = 0,
 	PMIC_GLINK_CLIENT_ALTMODE,
@@ -112,13 +115,29 @@ EXPORT_SYMBOL_GPL(pmic_glink_client_register);
 int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
 {
 	struct pmic_glink *pg = client->pg;
+	bool timeout_reached = false;
+	unsigned long start;
 	int ret;
 
 	mutex_lock(&pg->state_lock);
-	if (!pg->ept)
+	if (!pg->ept) {
 		ret = -ECONNRESET;
-	else
-		ret = rpmsg_send(pg->ept, data, len);
+	} else {
+		start = jiffies;
+		for (;;) {
+			ret = rpmsg_send(pg->ept, data, len);
+			if (ret != -EAGAIN)
+				break;
+
+			if (timeout_reached) {
+				ret = -ETIMEDOUT;
+				break;
+			}
+
+			usleep_range(1000, 5000);
+			timeout_reached = time_after(jiffies, start + PMIC_GLINK_SEND_TIMEOUT);
+		}
+	}
 	mutex_unlock(&pg->state_lock);
 
 	return ret;

-- 
2.43.0


