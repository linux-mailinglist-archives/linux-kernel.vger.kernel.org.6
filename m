Return-Path: <linux-kernel+bounces-225731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7CE913489
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA514B2303F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D3916F8FB;
	Sat, 22 Jun 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AIMJOJdR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458C1E4A2;
	Sat, 22 Jun 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719068165; cv=none; b=KBdkPGDDqQpugZQyo6Z4sh4jbPVVJJqSSeTpQErFIaFApNMv47tDf3RZF0yJt33v+e5jnuHq39mBaJjqefUQB0CIEoeEhJNlXvraKXT/niFbxoXHce9sFt7NBlIagPiOFER2WzfeeXq7snOKGWRkqLWGIhPQ8/Kp6mW+8h57CXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719068165; c=relaxed/simple;
	bh=NeoI3xvdLm7NoU1TbJs5tzVg8Bg6lxLZpLDuhK8t5GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=BpTN9cKDawKd1XiS5gWknQI4pBpPQOGud+vb7fFWHPubVF5dlbUXFIQMJQNfLyiMpuNuB38/AB6zqESLS0ckTLUsf0Tll9rN3xmsPuH8wMc89jZnn0hUJ2oCSgUIA2LJuippHI1svYvsgmZg3aeFHptz2gITZ/DZZQFoQvvyOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AIMJOJdR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45M9dnsk016444;
	Sat, 22 Jun 2024 14:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5hTgnXM8mYs+52SiKJhSMX
	/kzBTQLHCsOqadyvQNGnI=; b=AIMJOJdRZOBo+9jNFMZZvsXJd+rNPy2rZR9DX1
	+y+KzEWqIM6hvqfKBScv78xHkZaFy5mC3WUK2okFeCC91WD9d/XnW8ufwAqsO4Ka
	wFwq32JxPztyvIMzP79Y+nwG4WAAVu3XAkuEsfMD3Fgz/24n43Mtt/dk5kKh/aau
	+/9Icp5x69BssIns5H9xBl5nJWrt2jaPuHdE9i3t3xps+EYBOqpHHIV3unloNv6I
	3I6SUtygdkFENwZS0idvZYH7nfP4dtiDPKiCEvHpN8NqH9iRIIefVwqo1OzKiGXX
	Evj3miCTKd1lpLbM4p/UxyXMIqxQg1UtXBGSlIYDWcqrz8KQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqce8kac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 14:55:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45MEtIII024121
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 14:55:18 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 22 Jun
 2024 07:55:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 22 Jun 2024 07:55:05 -0700
Subject: [PATCH] selftests/fpu: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240622-md-i386-lib-test_fpu_glue-v1-1-a4e40b7b1264@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMnldmYC/x3MQQqDMBBA0avIrDtgk6Btr1KKJGaiAzGVTCyCe
 PemXb7F/wcIZSaBR3NApg8Lv1PF9dLAONs0EbKvBtUq03ZK4eKR9a3DyA4LSRnCug1T3AiN7u+
 q98YG0lD7NVPg/f9+vqqdFUKXbRrn3zFy2nZcrBTKcJ5fJwEgvYoAAAA=
To: Andrew Morton <akpm@linux-foundation.org>,
        Samuel Holland
	<samuel.holland@sifive.com>
CC: Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, WANG Xuerui <git@xen0n.name>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oYICXAE-m-AOEtK5PCQ_K1820wuWYhZv
X-Proofpoint-ORIG-GUID: oYICXAE-m-AOEtK5PCQ_K1820wuWYhZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_10,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406220108

make allmodconfig && make W=1 C=1 now reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_fpu.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Fixes: 9613736d852d ("selftests/fpu: move FP code to a separate translation unit")
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_fpu_glue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_fpu_glue.c b/lib/test_fpu_glue.c
index eef282a2715f..074f30301f29 100644
--- a/lib/test_fpu_glue.c
+++ b/lib/test_fpu_glue.c
@@ -59,4 +59,5 @@ static void __exit test_fpu_exit(void)
 module_init(test_fpu_init);
 module_exit(test_fpu_exit);
 
+MODULE_DESCRIPTION("Test cases for floating point operations");
 MODULE_LICENSE("GPL");

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240622-md-i386-lib-test_fpu_glue-437927d4afe3


