Return-Path: <linux-kernel+bounces-408930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB059C8542
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C030B221C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB09D1F709E;
	Thu, 14 Nov 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sz99PODo"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A838213B5A1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574255; cv=none; b=COCdwYfj422T9ihxdJJR3j+NiJ6wQqo1TeIGEcVyCkgL8qxj6iqPo6kEC9SyAFPrplKDvPbvOcozc7toYzInFv0eNzHkjR5pT/P/YT2R412nR32mAwWp9YyRTV44bqbfTV8Bmx4EBEk0vEBe5iYMvAqhW3KEedKDd2WCmXR0NWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574255; c=relaxed/simple;
	bh=jZVUWNFS0ya95qtBjQMQZvF9jzgWerBIuARLBrYfRdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEM6ExAgxOEFv8+qYXLK+j64yBbavBzNEKpcyD8YeUiNA3O5RBn7542wS3SvAdQZl9KIIPyf+9LVX3hf8NK7CSwoH6ZZwS9gGw8OcSvP85YuPRK6o0RzWw5Y6Y5GJ5zTPvwCOV/YvZ+RBHphX+zVSjmJaCzwjXpGmGI1I+MWB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sz99PODo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE6e2PN002177;
	Thu, 14 Nov 2024 08:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ELkof2PiSVln1EcDwzuMJK2QV+4Zo2YPwe//gRAwQ
	yw=; b=sz99PODoyVvp7pQ+dRIbqxvdy67/EE/hJmNBvL1FM/mq/X98XRW4fk2BY
	6KUne+fpSkXS+WwH0GSgtWy2QyMWdbUzIiK16U6yeiGoR0aOcorJugB02eRc5o7M
	22NGSFHxGZGoQ0770sCY1TAR8ZlkhflJGdLGGPKnjonbOtqw/KD1WTX51OKKTzZt
	U7rYS+sci3ukG3bkbjRMI2JlVRjR0AlHHiXVsxsLn5WfbbK6HxCM4d4Nj6C6EcTz
	dh28ddvhi4Dg1dJNxNkeFLWFYntjXJjg7ctOJbln+3GiBdDaG9jLnPkGPsovy+FI
	GpeQAKMbqaGuNjKetNo1CynPDxtkg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wc4s90dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:50:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AE8oKOL020216;
	Thu, 14 Nov 2024 08:50:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wc4s90de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:50:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNBcI8010514;
	Thu, 14 Nov 2024 08:50:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s81pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:50:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AE8obKb51184116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 08:50:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED7902004B;
	Thu, 14 Nov 2024 08:50:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24A1420043;
	Thu, 14 Nov 2024 08:50:34 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.39.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Nov 2024 08:50:33 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, maddy@linux.ibm.com
Cc: atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com,
        hbathini@linux.ibm.com, adubey@linux.ibm.com, gautam@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v2] powerpc/kvm: Fix typo in the kvm functions
Date: Thu, 14 Nov 2024 14:20:20 +0530
Message-ID: <20241114085020.1147912-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yqhisDeqyWFdh94OjWDw3CTCOvnS5d6x
X-Proofpoint-ORIG-GUID: FploZy_ECxRphi9DMk_n4xyg2xFdWnvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411140065

Fix typo in the following kvm function names from:

kmvhv_counters_tracepoint_regfunc -> kvmhv_counters_tracepoint_regfunc
kmvhv_counters_tracepoint_unregfunc -> kvmhv_counters_tracepoint_unregfunc

Fixes: e1f288d2f9c6 ("KVM: PPC: Book3S HV nestedv2: Add support for reading VPA counters for pseries guests")
Reported-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
Changelog:

v1 -> v2
- Added Reviewed-by tag from Ritesh and Amit.

 arch/powerpc/include/asm/kvm_book3s_64.h | 4 ++--
 arch/powerpc/kvm/book3s_hv.c             | 4 ++--
 arch/powerpc/kvm/trace_hv.h              | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 2ef9a5f4e5d1..11065313d4c1 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -684,8 +684,8 @@ int kvmhv_nestedv2_set_ptbl_entry(unsigned long lpid, u64 dw0, u64 dw1);
 int kvmhv_nestedv2_parse_output(struct kvm_vcpu *vcpu);
 int kvmhv_nestedv2_set_vpa(struct kvm_vcpu *vcpu, unsigned long vpa);
 
-int kmvhv_counters_tracepoint_regfunc(void);
-void kmvhv_counters_tracepoint_unregfunc(void);
+int kvmhv_counters_tracepoint_regfunc(void);
+void kvmhv_counters_tracepoint_unregfunc(void);
 int kvmhv_get_l2_counters_status(void);
 void kvmhv_set_l2_counters_status(int cpu, bool status);
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ba0492f9de65..c36d036d7155 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4154,7 +4154,7 @@ void kvmhv_set_l2_counters_status(int cpu, bool status)
 		lppaca_of(cpu).l2_counters_enable = 0;
 }
 
-int kmvhv_counters_tracepoint_regfunc(void)
+int kvmhv_counters_tracepoint_regfunc(void)
 {
 	int cpu;
 
@@ -4164,7 +4164,7 @@ int kmvhv_counters_tracepoint_regfunc(void)
 	return 0;
 }
 
-void kmvhv_counters_tracepoint_unregfunc(void)
+void kvmhv_counters_tracepoint_unregfunc(void)
 {
 	int cpu;
 
diff --git a/arch/powerpc/kvm/trace_hv.h b/arch/powerpc/kvm/trace_hv.h
index 77ebc724e6cd..35fccaa575cc 100644
--- a/arch/powerpc/kvm/trace_hv.h
+++ b/arch/powerpc/kvm/trace_hv.h
@@ -538,7 +538,7 @@ TRACE_EVENT_FN_COND(kvmppc_vcpu_stats,
 	TP_printk("VCPU %d: l1_to_l2_cs_time=%llu ns l2_to_l1_cs_time=%llu ns l2_runtime=%llu ns",
 		__entry->vcpu_id,  __entry->l1_to_l2_cs,
 		__entry->l2_to_l1_cs, __entry->l2_runtime),
-	kmvhv_counters_tracepoint_regfunc, kmvhv_counters_tracepoint_unregfunc
+	kvmhv_counters_tracepoint_regfunc, kvmhv_counters_tracepoint_unregfunc
 );
 #endif
 #endif /* _TRACE_KVM_HV_H */
-- 
2.43.5


