Return-Path: <linux-kernel+bounces-565590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C073DA66B61
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273C2175ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9811DE4DC;
	Tue, 18 Mar 2025 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aPL7B7l9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D391991CA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282205; cv=none; b=NrQxU4YZYR4NcoL8qeAQImc3DDN1viY7nsXe3KKd+Lj8jyrQZJSEkzfcecF7Vic8Z72q576zY3qSJ/Y8UNErCceJ5GGKl8rg8vsCGH1Pq321YQslejAYNICuKRa1Pdts2HmXd3py8gF4T/yoppe9E5dgwZoo78dY0hyQQw1VW/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282205; c=relaxed/simple;
	bh=sVI5li7zvcd1pH6z4AYwCc5njky85LYB4G2kExKkZjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W2fQ/q7C8pxDOSXIJky/U1MIgNKPdfdKqFYxCxFbjv8RrmXAzF3/5U7QQrOfwWTPVOXLhYwzBoLW0lntAStxqGZypIYgrU928gHW06RdRoyJBD1gCAvfnXhrqBTiuIw5/3b9F65a4n1MywwSLv5irt1hrsuLzHm6mADW3lXIAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aPL7B7l9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I19MTN022924;
	Tue, 18 Mar 2025 07:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=F8a+4l8TMkdELCWcO4w+wq
	QmkABNz+z8FK1Fg3zE718=; b=aPL7B7l9ffmddI1K1Gfv3LukeC+mAICO5S3/lF
	1zp32ey/uzezm+gayoRaUiHDY0mEZBhsV/t71hIIjlhBPjAP+AWJQkZLTi6PTqa9
	kC0R6d+0o5Rknw//Jtj0LlcJPEosFBmgb7EUNLWehmlpxiXcRYVpSHUZOuLb9tsc
	h+XoPiTB5vAxCh62L1G1ZA/LNeLsuHc4Tk+WjvfF4C7b3kN0nzLiamJJTjEyLmMN
	y49lbgkRLQ3ok9ybU2XqOFAc2L/F6mJneaxuGxo62c/DvxVxe2S5qXG3TGP4SmcN
	j5WP9qruLBoLd+sJWkCB5EPACGYyUVKugIaOHERFAs6Xbrzw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwx0trg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 07:16:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52I7GbIl015281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 07:16:37 GMT
Received: from nsssdc-sh01-lnx.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Mar 2025 00:15:48 -0700
From: Luo Jie <quic_luoj@quicinc.com>
To: <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>
CC: <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_pavir@quicinc.com>
Subject: [PATCH] bitfield: add FIELD_MODIFY() helper
Date: Tue, 18 Mar 2025 15:15:26 +0800
Message-ID: <20250318071526.1836194-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qArQmmIdXbQ7PQbOdNoXGWi9v55bfRE6
X-Authority-Analysis: v=2.4 cv=INICChvG c=1 sm=1 tr=0 ts=67d91dd6 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=O1cLxb1THHesT-zVNQIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qArQmmIdXbQ7PQbOdNoXGWi9v55bfRE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=849 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180050

Add a helper for replacing the contents of bitfield in memory
with the specified value.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---

The new added macro FIELD_MODIFY() is expected to be used by the
following Ethernet PPE driver as link below.
https://lore.kernel.org/linux-arm-msm/20250209-qcom_ipq_ppe-v3-0-453ea18d3271@quicinc.com/

 include/linux/bitfield.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 63928f173223..13484e09797f 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -7,8 +7,9 @@
 #ifndef _LINUX_BITFIELD_H
 #define _LINUX_BITFIELD_H
 
-#include <linux/build_bug.h>
 #include <asm/byteorder.h>
+#include <linux/build_bug.h>
+#include <linux/typecheck.h>
 
 /*
  * Bitfield access macros
@@ -156,6 +157,23 @@
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
 
+/**
+ * FIELD_MODIFY() - modify a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_reg_p: pointer to the memory that should be updated
+ * @_val: value to store in the bitfield
+ *
+ * FIELD_MODIFY() modifies the set of bits in @_reg_p specified by @_mask,
+ * by replacing them with the bitfield value passed in as @_val.
+ */
+#define FIELD_MODIFY(_mask, _reg_p, _val)				\
+	({								\
+		typecheck_pointer(_reg_p);				\
+		__BF_FIELD_CHECK(_mask, *(_reg_p), _val, "FIELD_MODIFY: "); \
+		*(_reg_p) &= ~(_mask);					\
+		*(_reg_p) |= ((_val) << __bf_shf(_mask)) & (_mask);	\
+	})
+
 extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
-- 
2.34.1


