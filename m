Return-Path: <linux-kernel+bounces-169727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499BB8BCCB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0491D2810F9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED458142E82;
	Mon,  6 May 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nrDnYFrZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DC142E83
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994230; cv=none; b=c3iGYs27T9TiovOpfBwVn1zHLYtO8RcgRYi+PG/hFJtWfjfz9Kx4FI6a4YlrpNKLSxYgivGKv3NY9/78qcXHI6N8rZGtHBwAzxV+EeYlJb7ld0n4tOzgNfg+Nj1DHz6KQs5zpAIBOGMRNpsA7ZjppIiugkKl+8VRhhXMbZ04E9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994230; c=relaxed/simple;
	bh=++z2NbzTIixySsiVPEkTcPvB6aItK09m6efRMISA6Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EoJk5VyLySyLheppaPpZdpmzaIF+7dShVHZ9EdR9Ustxo9L5KPopPkZjwMkSOHKzaHeZHbpYN3Mtiu3tDb7Ork5u4HBHPRa8b8Xkm3vreeaPsaEGhO3z7D65gOMoLBCY7QKpj7R7sK9UV4LXXrF/EhAKxUOthSHLr/SI+DO6RJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nrDnYFrZ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446Apced018813;
	Mon, 6 May 2024 11:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=GT1Q/e4o1Ss5+HcoNPzPmxFoE8Gzoe7YWC2mD81BlaQ=;
 b=nrDnYFrZR9hUzpjn/0Nxty0saOZN8MSxeQtFvIn/4fxKtiUYjqRXEjwfIlwnKSO2Iu8z
 nIpMaTMnRpPu5AivOfBVbyoFUuffz7Yo9z7PqGcWbx55Df1AwvyATA1uB1JRDpQEoU4d
 uep9hSEPFqRQxCrGSicLBiKr644f6/oGBP67ePLfyfI5lFfx1Bq49Q5mzWdyyxmH+TzI
 bEK5JEOrJL4JqN7qnudhbpa9d8YEhLUWFLlvmRNxxx5iAbK11pDishVtgJJ3OZesJTby
 2fe7rNVX53wEjyPnVq3mzQNAc34PxEIAviUQr9a6Gi8ERXtopJ4BmVXZIqLFn+CMWO4D OQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5jck2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 11:16:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446A1aV4029292;
	Mon, 6 May 2024 11:16:40 GMT
Received: from localhost.localdomain (dhcp-10-191-129-88.vpn.oracle.com [10.191.129.88])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xwbfbqepc-1;
	Mon, 06 May 2024 11:16:40 +0000
From: Imran Khan <imran.f.khan@oracle.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/irq: use lapic_vector_set_in_irr to check for pending vectors in fixup_irqs.
Date: Mon,  6 May 2024 21:16:34 +1000
Message-Id: <20240506111634.121460-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_07,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060077
X-Proofpoint-GUID: KLD0FEYB_oIAQP1u4gagja4nKfHJufRJ
X-Proofpoint-ORIG-GUID: KLD0FEYB_oIAQP1u4gagja4nKfHJufRJ

No functional change, just using readily available helper which
uses the same logic, that has been used here.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 arch/x86/kernel/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 35fde0107901d..71432e42275c4 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -339,7 +339,7 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi)
 /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
 void fixup_irqs(void)
 {
-	unsigned int irr, vector;
+	unsigned int vector;
 	struct irq_desc *desc;
 	struct irq_data *data;
 	struct irq_chip *chip;
@@ -366,8 +366,7 @@ void fixup_irqs(void)
 		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
 			continue;
 
-		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
-		if (irr  & (1 << (vector % 32))) {
+		if (lapic_vector_set_in_irr(vector)) {
 			desc = __this_cpu_read(vector_irq[vector]);
 
 			raw_spin_lock(&desc->lock);
-- 
2.34.1


