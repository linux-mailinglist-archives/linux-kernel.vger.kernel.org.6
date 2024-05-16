Return-Path: <linux-kernel+bounces-181532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FA48C7D43
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFE4285BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D349156F43;
	Thu, 16 May 2024 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jwbbNtdh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA348156F29
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715887854; cv=none; b=VRpa4ROw+8ZdEklBBUCjXjuHZagc/0GHtpph/245U52Fqfc3EZzwi0nVEdCntQFH93qD2cciEElPt38Dr44rZGC8++5i7ezdGkNAV8zMe++YspB0j8snNF/cQnOSWW6BlbwvQXLDhxZwalmILas1i8pbvpNJ6nmfQ1dfAoItP8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715887854; c=relaxed/simple;
	bh=fHPQQvEebj4CGLf7Tcw69wXDLmMQSbx7Cu+MmXyUVoc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IvmkCEvd14Ke96rgWFQoaVk2jTknyQjHgiOrrXIOTY82UFXwyd4nOf3I46qBrAJ2dwMPHnDz+NLrmgBaz8qD58pN95IX9yZrZNbWmqYzjM4wbUFOO24XNx0gp7wnKoyCjvo4f+sj6Bx/fOLRZipPbw/ebnekNPOnH5CEiJMz21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jwbbNtdh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GIK6HI012591;
	Thu, 16 May 2024 19:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=v4Hy9vgPlqEwpi8ML5a7lKaruYKTTqHgBrgOL6Gyf2A=; b=jw
	bbNtdhaXIF0RI3kjMWjKABq+Yj0JXJMSEcb2KecL68zlBKJ6q2OodEw8rjLE8wx/
	dXJEz3WRxMR7lAsI1hGcn3VJKuWB9VMBOCHkTV58ZgqlFt4xau1SlWG6a9hM/DPk
	TSLRmTwhgpA9wd6NO3Vx0uZrPh+4OkK25tDjLJVzqSKkMpFMsV3TmZhqZAlTThZq
	dBcZ4sJKEsCRXdRKhyzjOwEA6X0XnbDYmFLPcejaQCNb1DG2eKIptO3y2cYaSb8y
	ixca2964CemGz9dD8+n5l9aWW7ho8hk0teXhtfB5KwfxdrLlDxfbsPA48KQbla/G
	qUzwK86BAUOiqCz1kzpQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y5e9csfdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 19:30:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GJUhoK024476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 19:30:43 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 16 May 2024 12:30:42 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] genirq/chip: Fix the warn for non-SMP system
Date: Fri, 17 May 2024 01:00:25 +0530
Message-ID: <1715887825-1031-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v5_Ju6jc2n1FVQ3WFbc-v7XWG-axmSBk
X-Proofpoint-ORIG-GUID: v5_Ju6jc2n1FVQ3WFbc-v7XWG-axmSBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 mlxlogscore=977
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160140

__irq_startup_managed() for !SMP system returns IRQ_STARTUP_NORMAL
which may result in a WARNING during enablement of an irq i.e.,
starting a irq while it is not activated.

Fix this by appropriately returning IRQ_STARTUP_MANAGED.

[   11.129246] ------------[ cut here ]------------
[   11.133891] WARNING: CPU: 0 PID: 39 at kernel/irq/chip.c:243 irq_startup+0x87/0x88
[   11.146370] CPU: 0 PID: 39 Comm: kworker/0:5 Tainted: G   OE     5.15.123-perf-gc692140b4d58-dirty #1
[   11.156289] Hardware name: Generic DT based system
[   11.161081] Workqueue: pm pm_runtime_work
[   11.165112] (unwind_backtrace) from [<c0108c37>] (show_stack+0xb/0xc)
[   11.172695] (show_stack) from [<c01154d5>] (__warn+0x8d/0x8e)
[   11.179581] (__warn) from [<c0115525>] (warn_slowpath_fmt+0x4f/0x68)
[   11.187063] (warn_slowpath_fmt) from [<c0146d89>] (irq_startup+0x87/0x88)
[   11.194992] (irq_startup) from [<c0144969>] (enable_irq+0x31/0x70)
[   11.202313] (enable_irq) from [<c05726bb>]

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c94..a243f5ce786c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -228,7 +228,7 @@ static __always_inline int
 __irq_startup_managed(struct irq_desc *desc, const struct cpumask *aff,
 		      bool force)
 {
-	return IRQ_STARTUP_NORMAL;
+	return IRQ_STARTUP_MANAGED;
 }
 #endif
 
-- 
2.7.4


