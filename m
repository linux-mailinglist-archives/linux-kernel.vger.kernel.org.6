Return-Path: <linux-kernel+bounces-334276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ED797D4E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49EC1C21B34
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABFA14389F;
	Fri, 20 Sep 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g+DPdPah"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A9024B4A
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726832317; cv=none; b=M1pIP0b2VZuNpw1jhrV1LzQp2P7QwAQ5F0/OW0lJ9Yxe4zeUv0x939oj73AQbcEG1xoLmTGERNtFOwRgRiduF4YwDPQVDxwcG6kGBkzPksTOlNKU9ynGcULfXN0yJHNpPRQX2BCSofSkLd8oVjI//IAelUUt8ItRdlZVUgDZA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726832317; c=relaxed/simple;
	bh=eGIoaG+vXr0/VNEKa91XtQbIJi0wGpAI90EbthzMyDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5nLMLaeOhUHvqFVedA8+/kCps1kXFj4sTiOElHhYlGUkyw6DCHmnw+czU2qE99l97vCsCgRPlClFSBOuZ4Wy52my5z32ML05f2smu5OyVPwH/Gns1WNTnaBeq6Lls/nAaqmu4cvMi7ybSvFtKOT1b0ChweNZ5syWz6xJ22WJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g+DPdPah; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JNIFe9006840;
	Fri, 20 Sep 2024 11:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=jTQ1/fgycFakBw9xilUSDQoHju
	ZqzEMXpkxSoYEwSj4=; b=g+DPdPahrevWQN/BaP3INWC5KhZMVFx1AdHS3pfqin
	2JZD2Y4f7mgYy/RpocZXkuc9pnLceierqpoDWiDU2a5M+U4yaSr+2TFn37/mMonJ
	h3bdgOAPmhT65A5MbF7PqOJ2cIzAcTuGBYdGd0heXIS6PGtsQAvxEeRD+VKjZ57h
	S5+l06wlgYBcj4ocvHwiFp30P6YRfi/Q/rNL5tpO1tu+gVpaUqMnypblIqtdgFNf
	xFP8ELlEoVwe1isLdSDnAfTgJyR5xYgZxKyqQY52zZhesr2In+Dtgj1r2HD8QGwT
	hGysUCtnMuyZNBavglnilrPBDHj+SPHhPjnWYrsOsjBg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uds4cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 11:38:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48K8cUUh030649;
	Fri, 20 Sep 2024 11:38:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41npanpwe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 11:38:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48KBcINt42074616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 11:38:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B553B20040;
	Fri, 20 Sep 2024 11:38:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 654A720043;
	Fri, 20 Sep 2024 11:38:16 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.0.34])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Sep 2024 11:38:16 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com,
        disgoel@linux.ibm.com, hbathini@linux.ibm.com, adubey@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: kjain@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kvm: Fix typo in the kvm functions
Date: Fri, 20 Sep 2024 17:08:01 +0530
Message-ID: <20240920113801.424651-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZeY0fT3LsnyUQFaMhxpAuSygAkRvTfxu
X-Proofpoint-ORIG-GUID: ZeY0fT3LsnyUQFaMhxpAuSygAkRvTfxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_05,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=955
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409200081

Fix typo in the following kvm function names from:

kmvhv_counters_tracepoint_regfunc -> kvmhv_counters_tracepoint_regfunc
kmvhv_counters_tracepoint_unregfunc -> kvmhv_counters_tracepoint_unregfunc

Fixes: e1f288d2f9c6 ("KVM: PPC: Book3S HV nestedv2: Add support for reading VPA counters for pseries guests")
Reported-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
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


