Return-Path: <linux-kernel+bounces-401381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84679C1981
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5A01C21E98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB41E0B76;
	Fri,  8 Nov 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CHSGivyi"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94A1CC152
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059362; cv=none; b=NnW0pqEIrMviThmD4Ozmid9jgCK/rAKpGp+l0JJ8bT9J4JU5VYL6pocR0gUNZLPti5v0Mpc+8oaUEiREK62zQzzJDDwIFZb666ifryrKgVsK93N5aEcVw3yE6r6AZo0qpo/SJ1gRYeLMIU11QjdpHK1fzdd+cZWLja1/WIjYYls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059362; c=relaxed/simple;
	bh=PXvut3Vo+m5s6hjZebEMEvM3H0niTeOoVZ5iaSEkSOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQ6QLySkg/DDL6XJVb5E2u3Qknpp7ViTTYrAro+AzKV3uKh8B4OiLtBisvzx8bS0CCmaRyR1eqWwjrz+kLBOd9oW4RWTkrMWCyt5iyAnBDs+cp42LYMWoChzVTKPBQqbE+jBxNa3U4fBQgFnPFWvnv4k5JDmNve67dP6rnD7X4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CHSGivyi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A89e7A7001975;
	Fri, 8 Nov 2024 09:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=y/p3P3mwMqo3YL4RmYx19kAvOKcnUNWKfwWqWgLH9
	gg=; b=CHSGivyiSbXf0+3jn7j3b/u8JmezvUYfuJrprnuO70k9XFcjA58IDOr7e
	uH1vFr1fGWIMNaMB2m4n18230T7dyqvB3Nhu4QMxU/yBtBPs871DIp+MHE16P2+2
	2DEUOv5IYsG9uc7UlyWr0qMfV0GdKEiIH9kNIfSEy5jjeWygrDIN4In2bJBMyFw1
	kceIDA94wGCEdxy/JxkVAPhy7p5z8ipYsGfsi09cG705CNG9v7gnZKoKhQ4NcgZN
	tVq8TuOXy8yEpbfP0EjVrISUQ6fLmI7QhyPp7Pc/ili0w+CpN8YOPMxwUaZL4miG
	c9VwDxkMbZ/SfmiOh47R+Zt73q/HQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sg75819q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 09:48:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A89mn3A020305;
	Fri, 8 Nov 2024 09:48:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sg75819j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 09:48:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Nm7hp012243;
	Fri, 8 Nov 2024 09:48:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p1411wpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 09:48:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A89miwC23003758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 09:48:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 743FE20043;
	Fri,  8 Nov 2024 09:48:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 735F320040;
	Fri,  8 Nov 2024 09:48:42 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.124.214.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Nov 2024 09:48:42 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, maddy@linux.ibm.com, vaibhav@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arch/powerpc/pseries: Fix KVM guest detection for disabling hardlockup detector
Date: Fri,  8 Nov 2024 15:18:37 +0530
Message-ID: <20241108094839.33084-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TqaLWbICowCfrMa8p4l-NLqSb7OTJbhA
X-Proofpoint-GUID: 3heSwDM0UHwUDkhfVkZZM3-R6wXFLhnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080077

As per the kernel documentation[1], hardlockup detector should be
disabled in KVM guests as it may give false positives. On PPC, hardlockup
detector is enabled inside KVM guests because disable_hardlockup_detector()
is marked as early_initcall and it relies on kvm_guest static key 
(is_kvm_guest()) which is initialized later during boot by 
check_kvm_guest(), which is a core_initcall. check_kvm_guest() is also 
called in pSeries_smp_probe(), which is called before initcalls, but it is
skipped if KVM guest does not have doorbell support or if the guest is 
launched with SMT=1.

Call check_kvm_guest() in disable_hardlockup_detector() so that
is_kvm_guest() check goes through fine and hardlockup detector can be
disabled inside the KVM guest.

[1]: Documentation/admin-guide/sysctl/kernel.rst

Fixes: 633c8e9800f3 ("powerpc/pseries: Enable hardlockup watchdog for PowerVM partitions")
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Call check_kvm_guest() call in disable_hardlockup_detector() instead
of relying on pSeries_smp_probe()
2. Add the fixes and stable tags
3. Some changes in patch description

 arch/powerpc/kernel/setup_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 22f83fbbc762..1edc7cd68c10 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -920,6 +920,7 @@ static int __init disable_hardlockup_detector(void)
 	hardlockup_detector_disable();
 #else
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
+		check_kvm_guest();
 		if (is_kvm_guest())
 			hardlockup_detector_disable();
 	}
-- 
2.47.0


