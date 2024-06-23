Return-Path: <linux-kernel+bounces-225930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A99137A2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 06:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EE71F21FDC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E9D179B2;
	Sun, 23 Jun 2024 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dQOnNuir"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857C38B;
	Sun, 23 Jun 2024 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719117307; cv=none; b=ek5Tn5GD3PZuTcsVdZ1rvbBi11aprZ8kwTWVQzbQCnu/zVPaeEKOEQnUuo/GZ5/lE1IW6QR9oOH7FoCo1Wm1Q8YV2VIdWcnXTRbPN0deJQFJJ4XWsImEnDZQyrZZzslEmkje89lL3YQu9/o9F7+6PihKd62RFrIbEuWfUWYOT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719117307; c=relaxed/simple;
	bh=x2/i2mDMDWuFx0aYELfA/M4ZaXwnc6/oI0MDKQHto3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=PtbS7ArHyTzIYUMbVhpAKwhc0bLdHG45r9aNKYpTLMgCWLZi5ktu7+ukELIinup0LMQG0bagtfVAXWji2Ec1Innsg68ytrs0RP1HjpJSCobnayWNbVvKJmUIn0aIcQjdHiEmY1aS+CnEel04EyBZHL6bT/1UZg9gnKlA4wJMqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dQOnNuir; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45N2Ue3P013657;
	Sun, 23 Jun 2024 04:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=64E+NkOOnR1B+78MYqKrSn
	noPyxZl9GmnOyi76daGq4=; b=dQOnNuirD71iD7baiOJ7THsd9k1dtBQl+YO85d
	ViOJ7J4gZwGjaFNlGKBKI4xASvUmNAPg7QOTXRiQDJ3pzm+2fWzWfnNs+VeNogke
	dN6RrgPzueN8Xeufm7FQkcQX7inWh9geVlKhtji92D1xkQI97gQcMmpl9SlASiGT
	xJbDBdsfgN1wv3cqZNsZHEyuE4wNgvinI0F/RPefTQhLnq9MZYXVzYiipF5wEGUs
	KzfYeq+uongSspeGktQiRxk4oHbBWyQcdxQvV9nurJTs4wqKNBhDJ+6JEvifolGW
	8xI2g1cqXVaeBnT33eOo7DmJNp0wl3JripJ+hkr2lDtBdPwQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywq0719pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 04:34:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45N4Ypdd030837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 04:34:51 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 22 Jun
 2024 21:34:50 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 22 Jun 2024 21:34:48 -0700
Subject: [PATCH] arm: kprobes: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240622-md-arm-arch-arm-probes-kprobes-v1-1-0832bd6e45db@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOeld2YC/y2NSw7CMAxEr1J5jaWQVPyugrpwUkMsaFrZgCpVv
 TuhYjGaeZs3CxirsMGlWUD5IyZjqbDfNZAylTuj9JXBO9+6g/c49Eg61KS8jUnHyIaPf4fWhaM
 7n8inAFUyKd9k3g6uXeVIxhiVSso/7VPKe8aB7MUK6/oFhcbTjo8AAAA=
To: Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Oc94u13o8bpKUFBewIOZl0vcx75mtEkv
X-Proofpoint-GUID: Oc94u13o8bpKUFBewIOZl0vcx75mtEkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_19,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=964 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406230034

With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/arm/probes/kprobes/test-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index 171c7076b89f..6e9041a76b8b 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -1664,6 +1664,7 @@ static void __exit kprobe_test_exit(void)
 
 module_init(run_all_tests)
 module_exit(kprobe_test_exit)
+MODULE_DESCRIPTION("ARM kprobes test module");
 MODULE_LICENSE("GPL");
 
 #else /* !MODULE */

---
base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
change-id: 20240622-md-arm-arch-arm-probes-kprobes-34037098a2c3


