Return-Path: <linux-kernel+bounces-408907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DD69C84F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3495AB275D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6091F80B0;
	Thu, 14 Nov 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QK3SBp0T"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2A1E573
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573652; cv=none; b=cw7Q86bz7L1vP4r2+POcBphe2hKHyDSq1qe9CZtUQ6xCg0vOUT3hxYGozqjH0G9xpkDD/jLxLpBmCLcs1wwLxf7Vyb0fX6LGd7nLMFtNWDjeXcTivYBbXnpCAqGCCm4cqnJDladp16C6aYeMHyiiNb42T90ymp02HxrviJaS25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573652; c=relaxed/simple;
	bh=nPlBAgJ9GwqBYKjSuwcNZkJcQMux7DJcfkkj7iS/6rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+8vSTr1pIIqu6x1erGVJo9N9todWKc1IX/S2w/6F7Rx7d1CbFKTjDRY9lfG/F1wM4DKCaZ7Yi3ziLFdxBJBhXCs3fpxUQPbPsnxQVMM3wF0+1xVgkOtma74aRUfcpVszhAN/9BXRBK0ZhFeuyI7T/B/Smvlol+h8uuO8xZm9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QK3SBp0T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE5A26E009041;
	Thu, 14 Nov 2024 08:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QIo7D5G7DTqD/8xkY
	q3voEunJz39pNM1luASLgOCAeA=; b=QK3SBp0TkvBx3xIewuAIO7MGB2DQLx3cm
	3cAJAiD4+vJ8mfGgEXxCrHzDd+9g14pZggJSXv4TuIt1h4B9P1Puy8S6y73oIyoZ
	Oh+AhFukWvV/HOZNhZL+msLCi04IfO0xmKdN2Zdf0uSqLKTMDql11IP72oeL4nXP
	v1zANuZ0gingM5Hs0c+tdIlcBVVcEZ9QUBSSkW/MrN5IMNM3nSnAgEdY3bDjvYyW
	+BaOA4v3eHXvfs5ieQPaDaEJJDKevIodPGzuZoRwPZuZLpEX+ED39ZYSzbqwlwka
	6LLFxmQOQoSpGUjIi3JswcRNTXHpl3jODy+XjUt3MA0QSMGKL28Kg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42watksgnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:40:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNgxxf011017;
	Thu, 14 Nov 2024 08:40:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s81c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:40:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AE8ebPD62325090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 08:40:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7A3520043;
	Thu, 14 Nov 2024 08:40:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFAC32004B;
	Thu, 14 Nov 2024 08:40:34 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.39.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Nov 2024 08:40:34 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, maddy@linux.ibm.com
Cc: atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com,
        hbathini@linux.ibm.com, adubey@linux.ibm.com, gautam@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] powerpc/perf: Add per-task/process monitoring to vpa_pmu driver
Date: Thu, 14 Nov 2024 14:10:13 +0530
Message-ID: <20241114084013.1140010-4-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114084013.1140010-1-kjain@linux.ibm.com>
References: <20241114084013.1140010-1-kjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2p8VqhY1VhEukmyhXK7qtDcZ_rCiCZTo
X-Proofpoint-ORIG-GUID: 2p8VqhY1VhEukmyhXK7qtDcZ_rCiCZTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140065

Enhance the vpa_pmu driver with a feature to observe context switch
latency event for both per-task (tid) and per-pid (pid) option.
Couple of new helper functions are added to hide the abstraction of
reading the context switch latency counter from kvm_vcpu_arch struct
and these helper functions are defined in the "kvm/book3s_hv.c".

"PERF_ATTACH_TASK" flag is used to decide whether to read the counter
values from lppaca or kvm_vcpu_arch struct.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Co-developed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |  3 ++
 arch/powerpc/kvm/book3s_hv.c             | 45 ++++++++++++++++++++++++
 arch/powerpc/perf/vpa-pmu.c              | 15 ++++++--
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index b9bcbf999bd9..300d0a774ce3 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -691,6 +691,9 @@ void kvmhv_set_l2_counters_status(int cpu, bool status);
 u64 kvmhv_get_l1_to_l2_cs_time(void);
 u64 kvmhv_get_l2_to_l1_cs_time(void);
 u64 kvmhv_get_l2_runtime_agg(void);
+u64 kvmhv_get_l1_to_l2_cs_time_vcpu(void);
+u64 kvmhv_get_l2_to_l1_cs_time_vcpu(void);
+u64 kvmhv_get_l2_runtime_agg_vcpu(void);
 
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index b5bdb981c3e3..e65b840d5f2a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4214,6 +4214,51 @@ u64 kvmhv_get_l2_runtime_agg(void)
 }
 EXPORT_SYMBOL(kvmhv_get_l2_runtime_agg);
 
+u64 kvmhv_get_l1_to_l2_cs_time_vcpu(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu_arch *arch;
+
+	vcpu = local_paca->kvm_hstate.kvm_vcpu;
+	if (vcpu) {
+		arch = &vcpu->arch;
+		return arch->l1_to_l2_cs;
+	} else {
+		return 0;
+	}
+}
+EXPORT_SYMBOL(kvmhv_get_l1_to_l2_cs_time_vcpu);
+
+u64 kvmhv_get_l2_to_l1_cs_time_vcpu(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu_arch *arch;
+
+	vcpu = local_paca->kvm_hstate.kvm_vcpu;
+	if (vcpu) {
+		arch = &vcpu->arch;
+		return arch->l2_to_l1_cs;
+	} else {
+		return 0;
+	}
+}
+EXPORT_SYMBOL(kvmhv_get_l2_to_l1_cs_time_vcpu);
+
+u64 kvmhv_get_l2_runtime_agg_vcpu(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu_arch *arch;
+
+	vcpu = local_paca->kvm_hstate.kvm_vcpu;
+	if (vcpu) {
+		arch = &vcpu->arch;
+		return arch->l2_runtime_agg;
+	} else {
+		return 0;
+	}
+}
+EXPORT_SYMBOL(kvmhv_get_l2_runtime_agg_vcpu);
+
 #else
 int kvmhv_get_l2_counters_status(void)
 {
diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
index 0382973aeb8e..e0035fd52e9b 100644
--- a/arch/powerpc/perf/vpa-pmu.c
+++ b/arch/powerpc/perf/vpa-pmu.c
@@ -97,13 +97,22 @@ static unsigned long get_counter_data(struct perf_event *event)
 
 	switch (config) {
 	case L1_TO_L2_CS_LAT:
-		data = kvmhv_get_l1_to_l2_cs_time();
+		if (event->attach_state & PERF_ATTACH_TASK)
+			data = kvmhv_get_l1_to_l2_cs_time_vcpu();
+		else
+			data = kvmhv_get_l1_to_l2_cs_time();
 		break;
 	case L2_TO_L1_CS_LAT:
-		data = kvmhv_get_l2_to_l1_cs_time();
+		if (event->attach_state & PERF_ATTACH_TASK)
+			data = kvmhv_get_l2_to_l1_cs_time_vcpu();
+		else
+			data = kvmhv_get_l2_to_l1_cs_time();
 		break;
 	case L2_RUNTIME_AGG:
-		data = kvmhv_get_l2_runtime_agg();
+		if (event->attach_state & PERF_ATTACH_TASK)
+			data = kvmhv_get_l2_runtime_agg_vcpu();
+		else
+			data = kvmhv_get_l2_runtime_agg();
 		break;
 	default:
 		data = 0;
-- 
2.43.5


