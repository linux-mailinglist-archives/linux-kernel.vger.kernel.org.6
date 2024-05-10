Return-Path: <linux-kernel+bounces-175193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6DC8C1C08
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D7B284AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8196413B5B3;
	Fri, 10 May 2024 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TleeSAL+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6223C9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304233; cv=none; b=kKAILzwHZwFNpgHAfiZOpiAhsohjXhWyctOICyvajyCIoYrOJCim5fkm0EZPX7uq9lDH+KYwFDNBvrLxjPhVG6Rk8cixPe0zg99dfwtKH2fJQxati0UL9jkfpodT7Q0G+6N3NYuOEu04gjFXxYFt1NsxtkG+AQdarQjxp+9RZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304233; c=relaxed/simple;
	bh=cdUJgKIsZHjvCIaWjuK+Kp0Wr54Cac0GouvSaRcwKNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=QZceaKAPmys0ha2Uih5tpr/jnpM7BlJOOZ3YIqPz5pP6wQ5lk2x/xtXpbZI0HZ5kXJxYK/usOM1nntzWW234JXDqm8eP+OFb01VexqWYNfvff4W1KBx81Rpp+4gioz3nh7Hetu5iFpUvmBK0Fm3M1wJ+XfOvXfn1+CdxN1ejrhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TleeSAL+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A1AkjK005609;
	Fri, 10 May 2024 01:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=gc+
	DpAPE3hy1bbPVBRLZx3SKoA09Krm2CCzQKf5uzKk=; b=TleeSAL+f4a2/dbuUvR
	0BxZnwDK0fqKiuGx4ddqX4NE+pTqJdpbpJ4ybkYPy4RgYJy4c9SSryyK3ifd7eOD
	kyPzbWr8G5WxByMoDwSOl7eXSDqMNP9oHTRwwF6PeAYPCr3XoZkEfTpRwFUkBndu
	yucVb/cV7SZljCFV/SUzMZGRReUUGdtLgpFygq6BG3Di90aZhNy7YYcyWU6lHKsm
	/A98OHUDthfAhzac8gByeqoYKJf9xdBX3na4w2blK/NWwvkWMwJ3jwH7K0CUstri
	0Go5rIz51iTMVoZR35opOJemZQcrnDsCm6vb1GgXgWO6913Qj4i3AiOVY0MGeUVr
	o0w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w1g9b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 01:23:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A1Ni2V000473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 01:23:44 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 18:23:44 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 9 May 2024 18:23:37 -0700
Subject: [PATCH] macintosh/mac_hid: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240509-mac_hid-md-v1-1-4091f1e4e4e0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABh3PWYC/x3MTQrCQAxA4auUrA2M/aHUq4jINJM6ATtKYkuh9
 O5Gl9/ivR2MVdjgUu2gvIrJqzjOpwoox/JglOSGOtRt6MKAc6R7loRzwj5NgZp26LuGwIO38iT
 bf3a9ucdojKPGQvm3eEpZNu/twwrH8QXhREcCewAAAA==
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zwIG1ynGz6b3KvqAWsNbWkIF4Ow9m_ZE
X-Proofpoint-GUID: zwIG1ynGz6b3KvqAWsNbWkIF4Ow9m_ZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_12,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxlogscore=877 mlxscore=0 impostorscore=0 clxscore=1011 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100007

Fix the make W=1 warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/macintosh/mac_hid.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/macintosh/mac_hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index 1ae3539beff5..eb7a173da071 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+MODULE_DESCRIPTION("Macintosh mouse button 2+3 emulation");
 MODULE_LICENSE("GPL");
 
 static int mouse_emulate_buttons;

---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240509-mac_hid-md-7df0c349753c


