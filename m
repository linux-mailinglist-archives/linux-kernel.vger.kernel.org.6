Return-Path: <linux-kernel+bounces-238346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16D492489D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237791F241E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061D1CD5B9;
	Tue,  2 Jul 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c/37CnBk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575C129E93;
	Tue,  2 Jul 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949829; cv=none; b=uvNA49D4sfaoG21CX6P1ByXx/sO6FeGXYq9NqqnU1lh4ER5udnkmEiR0NZ/7aXOheZkUFZ6uq+6sQWlIyuHGPNznul7OhGLsI2SX4pYJ6fUeRHEBxYTsTuJg7s2FQsHJbTSBhHGzUt0lH60al+KwZXbAByiIqignNsXsEHcJA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949829; c=relaxed/simple;
	bh=o+vvPmSt6cMytrcP0spRNiIUB3VFa7o2SwGLT3i29Pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=i3OPArIyDrDUyUV93nRqYq/igCskb62wE5BKB3DhnoJ+eJ0HDqdyLySIvEScbhAKSmI56fwFq3x0zTOLeM6Ys3+4I2+Zaxsv0c0ipykORSA8DC4Gb5JAtFCUIn9kBNOa6BSk1pVOY5FI0rUhCzPBr1Df4DeHz6XM2YZs7toQU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c/37CnBk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462HEvFV009458;
	Tue, 2 Jul 2024 19:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=X9k8irR/hjfHe9E2iDRNhO
	+8kHtzMs2pvoUZ0QJlGYM=; b=c/37CnBkWdAONoYR4nDXGJ6VzXuSJ1l1LMxBZN
	At2LWdvjCxXAbytGrgE7aB9BnmM4Trcw7CSlRb/l0i8E+1ANKFTunYjkkRw/H+tE
	gBeGlGqk4xW0IvuQYjD8U9bwkAYlPvd3xNjktR5fcxwzrwpkvH6NudSQE5xtDKPh
	5QhA5qj3xdZmUtf/+oNMs5StBonHecf7DVQQ/wAirbzAyQJN8/czwkLghmNvCMd/
	AqzSj7buzDWBMjYzGmzgHkQQgm+1ce5iylLh10y90XT1qbInFqdxNmPCzYOEdlMi
	gbyhnUE8TMXtM4EKef31/L9P4UYr21IRY2D5k4QLoQnsNebg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029kh6ur7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 19:50:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462Jo77E008191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 19:50:07 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 12:50:07 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 2 Jul 2024 12:50:02 -0700
Subject: [PATCH] um: harddog: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-md-um-arch-um-drivers-v1-1-79e4f50b5bab@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOpZhGYC/x3MQQrCMBCF4auUWTsQQyTiVcTFNBnNgIkyY0uh9
 O5NXT2+xftXMFZhg9uwgvIsJp/WcT4NkAq1F6PkbvDOBxedx5pxqkiayrFZZWY1pGug4LOLcbx
 A/36Vn7L8u/dH90jGOCq1VI7aW9q0YCX7scK27fAiSeqGAAAA
To: Richard Weinberger <richard@nod.at>,
        Anton Ivanov
	<anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j6JyB1mUKIKkcTJGQPu2pa9ccsk8Y1Du
X-Proofpoint-ORIG-GUID: j6JyB1mUKIKkcTJGQPu2pa9ccsk8Y1Du
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_14,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020145

With ARCH=um, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/um/drivers/harddog.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Description taken from the file prologue:
/* UML hardware watchdog, shamelessly stolen from:
---
 arch/um/drivers/harddog_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
index 60d1c6cab8a9..99a7144b229f 100644
--- a/arch/um/drivers/harddog_kern.c
+++ b/arch/um/drivers/harddog_kern.c
@@ -49,6 +49,7 @@
 #include "mconsole.h"
 #include "harddog.h"
 
+MODULE_DESCRIPTION("UML hardware watchdog");
 MODULE_LICENSE("GPL");
 
 static DEFINE_MUTEX(harddog_mutex);

---
base-commit: 1dfe225e9af5bd3399a1dbc6a4df6a6041ff9c23
change-id: 20240702-md-um-arch-um-drivers-a84a42d077b5


