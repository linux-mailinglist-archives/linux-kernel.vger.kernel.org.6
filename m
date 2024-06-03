Return-Path: <linux-kernel+bounces-199466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A045A8D877F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85101C21519
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00717136E1C;
	Mon,  3 Jun 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OkAGC+Mb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3D13699A;
	Mon,  3 Jun 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433736; cv=none; b=SYrXyNDpbqYGeb6a5r/F0pHr6aQVMcL8pmR03HDlKa9WkoYB7LFH8UYu6A6A0odOCTg+6uyLhPJGex23ziYUToVuSLuBto3L4AkA08dCZ+vWU3g4+RoKf847Rwh0kj+9rUK50COWbwZAh/6qft7wDLZTQPC/VvXZpCLBlMcjnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433736; c=relaxed/simple;
	bh=ods3sryTC/Ft9e0aoXj4dhw/pY8sg2Kv0+NfnehDbZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=SQwdtTtuYCsJ05oyMdiLyTpGxTe/1sEwqJ27YbuG6c5lk3KLjrqb+e/sgM6JoWiBTX+fyP+oQohfFk97j4TsuFAxPFCmPLLbJABca6LvMoVsGm27tdaDhRUE9XBk/HnSsZTdVw7ylLF9NlRO6t+2i5i05ydhIh9whjvd7cOdYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OkAGC+Mb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453C87oX032680;
	Mon, 3 Jun 2024 16:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VueaKyjEH6RqLLRvMnhN1y
	RPnhwgQQXom/YngbRmc8M=; b=OkAGC+Mb3GqRb1BzkNeZUchJeA6CC4iBX+Vgfi
	9M1nUVYYCtFklmeoZh5kNZ+0ZVNDW1wLfszLs/dZ87HL83tQEX0y8PZCV5nIhN6E
	A0PnNio3IP72XiAzMgFeBo5KqGUPNPGtJ5tyX88H5uxKcqFP8GEVpO09MaJu5Yy6
	KXxNfxHcoCEXHAAWr2K8HUnNCEPMpGNk3cnyI26n9BlWgF4DRusYGAUQ0wAL+aC5
	sJBcNd98Lx6HeEfolEthyKXO90mPNQ5Jrc5TMdSyEeOSNel8ZgK2eb5SZtP6F7k1
	nN0NvdizfgfN7yvaKyiouejbw+LOtF8/Q/d5eNfjHUgQMfoQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5t4a15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 16:55:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453GtQk7023556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 16:55:26 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 09:55:25 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 09:55:25 -0700
Subject: [PATCH] agp: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-agp-v1-1-9a1582114ced@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHz1XWYC/x3MSwqEQAxF0a1IxgZKbfz0VsRB1KgBrZZERRD3b
 rXDA/e9C4xV2OAbXaB8iMnPByRxBN1EfmSUPhhSl35c7jJceqRxxbykirPSJQUNEOJVeZDzPaq
 b4JaMsVXy3fSfz+L3ExeyjRXu+wE+Rsr0dwAAAA==
To: David Airlie <airlied@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DmZhTFL3-uMb7zTxA3W4e1Uf5yWYgi1J
X-Proofpoint-GUID: DmZhTFL3-uMb7zTxA3W4e1Uf5yWYgi1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030139

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/amd64-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/intel-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/intel-gtt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/sis-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/via-agp.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/char/agp/amd64-agp.c | 1 +
 drivers/char/agp/intel-agp.c | 1 +
 drivers/char/agp/intel-gtt.c | 1 +
 drivers/char/agp/sis-agp.c   | 1 +
 drivers/char/agp/via-agp.c   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index ce8651436609..8e41731d3642 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -802,4 +802,5 @@ module_exit(agp_amd64_cleanup);
 
 MODULE_AUTHOR("Dave Jones, Andi Kleen");
 module_param(agp_try_unsupported, bool, 0);
+MODULE_DESCRIPTION("GART driver for the AMD Opteron/Athlon64 on-CPU northbridge");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index c518b3a9db04..2c55264a031e 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -920,4 +920,5 @@ module_init(agp_intel_init);
 module_exit(agp_intel_cleanup);
 
 MODULE_AUTHOR("Dave Jones, Various @Intel");
+MODULE_DESCRIPTION("Intel AGPGART routines");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index bf6716ff863b..e54649027407 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -1461,4 +1461,5 @@ void intel_gmch_remove(void)
 EXPORT_SYMBOL(intel_gmch_remove);
 
 MODULE_AUTHOR("Dave Jones, Various @Intel");
+MODULE_DESCRIPTION("Intel GTT (Graphics Translation Table) routines");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/char/agp/sis-agp.c b/drivers/char/agp/sis-agp.c
index 484bb101c53b..a0deb97cedb0 100644
--- a/drivers/char/agp/sis-agp.c
+++ b/drivers/char/agp/sis-agp.c
@@ -433,4 +433,5 @@ module_param(agp_sis_force_delay, bool, 0);
 MODULE_PARM_DESC(agp_sis_force_delay,"forces sis delay hack");
 module_param(agp_sis_agp_spec, int, 0);
 MODULE_PARM_DESC(agp_sis_agp_spec,"0=force sis init, 1=force generic agp3 init, default: autodetect");
+MODULE_DESCRIPTION("SiS AGPGART routines");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index bc5140af2dcb..8b19a5d1a09b 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -575,5 +575,6 @@ static void __exit agp_via_cleanup(void)
 module_init(agp_via_init);
 module_exit(agp_via_cleanup);
 
+MODULE_DESCRIPTION("VIA AGPGART routines");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dave Jones");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-agp-68a9e38017af


