Return-Path: <linux-kernel+bounces-408908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4309C84F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8722B27691
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2015B1F7554;
	Thu, 14 Nov 2024 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dl/wdgv4"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C061F77B1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573652; cv=none; b=qXm6dUDmgpu+aPOoQWgvMv0PFlYKCdRASOhw1NSyndkVrL4oQ8gPN5qIakaRq3R7ECn8DEP0vuvgO0M6knYf688bkM0iP8ZnV6/2ret70+Tzx3u9v3q8kD8XwKQ1etd4Uai4LCF6C2rPUJriUUFbTIT/dy5v+6HMZvLIe2hP3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573652; c=relaxed/simple;
	bh=Vh8YQWQxgaH13RrwGGCtOVWf6mKThkIvFsFVcQZH21E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdk+Yt2JN1AzYQjcZT3fxE2iolkGcl0vld54MBKXEIXOYSGQKK8hgEnhmNg2ErbHAz91FaZkP1gVKBYyUOukxIfxXKxn0N+n+ZMbEn0+FFLBEln1wFefKnu5TxgfHVWn8bZKSScluh618101K9UGxHnljD+W3vE4DL6gUDaZT7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dl/wdgv4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE7eKHZ012480;
	Thu, 14 Nov 2024 08:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Nts+ViAU3rrk8ZSLj
	BQCOLQxx67frAOELXyU/nk2O9k=; b=Dl/wdgv4kx/Uc7pzYNOhl+UpSa/xl+bIW
	VfqAOUzziaW/Mq4hxzSXrUEhjgeRNkeCRytJ8BeDOm94GrcMuauCqVLLKpQfyDuy
	NQhgH+347nsr9nUr61iXQosu/SGrU+iPDL3UI7WQsnSG0bIdPKLaR2gU1Jf4OhMr
	pU8nj/aRAiE1kc/ikjPD13EmaJJACIcNWz/4X9VaCinmhdgafRkMG5u1eewwHq7i
	p+9To/O3OBcbPs43z9oZ3GFAMPHnfP+LUUT0A0H49/oL+kaafI8U9jrJ+GPLMFFr
	j78vKFSJMaxFZ2sUcTI98yqM+2tC4ZT6oXbD3lCmjn7F+TwUyp3mQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wd0ygefw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:40:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE1ssGT006674;
	Thu, 14 Nov 2024 08:40:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9jfuwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:40:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AE8eYZI56295898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 08:40:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5548920040;
	Thu, 14 Nov 2024 08:40:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E13BC2004B;
	Thu, 14 Nov 2024 08:40:31 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.39.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Nov 2024 08:40:31 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, maddy@linux.ibm.com
Cc: atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com,
        hbathini@linux.ibm.com, adubey@linux.ibm.com, gautam@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kajol Jain <kjain@Linux.ibm.com>
Subject: [PATCH 3/4] powerpc/kvm: Add vpa latency counters to kvm_vcpu_arch
Date: Thu, 14 Nov 2024 14:10:12 +0530
Message-ID: <20241114084013.1140010-3-kjain@linux.ibm.com>
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
X-Proofpoint-GUID: Qk-A4vCrCdNs7waXlP9rZhuaBtpuy9tJ
X-Proofpoint-ORIG-GUID: Qk-A4vCrCdNs7waXlP9rZhuaBtpuy9tJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140065

Commit e1f288d2f9c69 ("KVM: PPC: Book3S HV nestedv2: Add support
for reading VPA counters for pseries guests") introduced support for new
Virtual Process Area(VPA) based software counters. These counters are
useful when observing context switch latency of L1 <-> L2. It also
added access to counters in lppaca, which is good enough to understand
latency details per-cpu level. But to extend and aggregate
per-process level(qemu) or per-pid/tid level(vcpu), these
counters also needs to be added as part of kvm_vcpu_arch struct.
Additional code added to update these new kvm_vcpu_arch variables
in do_trace_nested_cs_time function.

Signed-off-by: Kajol Jain <kjain@Linux.ibm.com>
Co-developed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h | 5 +++++
 arch/powerpc/kvm/book3s_hv.c        | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 37e581c5b201..6e1108f8fce6 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -871,6 +871,11 @@ struct kvm_vcpu_arch {
 	struct kvmhv_tb_accumulator cede_time;	/* time napping inside guest */
 #endif
 #endif /* CONFIG_KVM_BOOK3S_HV_EXIT_TIMING */
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	u64 l1_to_l2_cs;
+	u64 l2_to_l1_cs;
+	u64 l2_runtime_agg;
+#endif
 };
 
 #define VCPU_FPR(vcpu, i)	(vcpu)->arch.fp.fpr[i][TS_FPROFFSET]
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index bc45cf09debc..b5bdb981c3e3 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4191,6 +4191,9 @@ static void do_trace_nested_cs_time(struct kvm_vcpu *vcpu)
 	*l1_to_l2_cs_ptr = l1_to_l2_ns;
 	*l2_to_l1_cs_ptr = l2_to_l1_ns;
 	*l2_runtime_agg_ptr = l2_runtime_ns;
+	vcpu->arch.l1_to_l2_cs = l1_to_l2_ns;
+	vcpu->arch.l2_to_l1_cs = l2_to_l1_ns;
+	vcpu->arch.l2_runtime_agg = l2_runtime_ns;
 }
 
 u64 kvmhv_get_l1_to_l2_cs_time(void)
-- 
2.43.5


