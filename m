Return-Path: <linux-kernel+bounces-561346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3E9A61054
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964F788431B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895911FE466;
	Fri, 14 Mar 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BM+3PSS6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AEC1FDE27
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952754; cv=none; b=nyGu/wpC5foYSpltqKIwH/gZfErHSSX4dK+r6WmbvJaXODt6Y6Sc7H82b6wtufUYh368ye7KISyP/+UTVon13rRB2+9OHCPASAE2bxOKyRsN4VPhp0vVuKPFSOz0H9/Z2n5UdaZhmcfRi8e8DYVEZSWPiu/k8oNaOKfESGs+7S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952754; c=relaxed/simple;
	bh=Hu8sULZie0oMT9SIO4X87dt7d8AORtAxqgYZcICW698=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxhJBAJCFOYAXK5pbUtpTSK/4J/X4nkPZTYdw8jgOY8yJ4kR5b12zqDbGuhfYhAiEoh6a2qFi5v57VTH4MqGO9zO/FsrF6jUiZER6kfCstLm+U1/JcqwVfFWB15uS1h0qFtA/Finx3OI+J5XQ3S2H67+0JknpA2P6zwMEcGCxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BM+3PSS6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EB0m9O001939;
	Fri, 14 Mar 2025 11:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Des5ngxLQ5668Zie0
	APp79mBo5Tmu7ME/Ak7Q/J8mj8=; b=BM+3PSS664XtoE3jB/+HGfpW4UqBF6PeC
	fLr8R8ctsOPHpfZspnyyIzRrzTR1Q4WpuFqzphGc+FSNs+G+G8Nl0r7v1stURQW1
	592QObhVja+xezF2+b3Z94DbPUR6sh8OBCPiCpiw/Vh38ElZQrZg2c1lDDNc0DIu
	Nj+orYNMkUHbxfKFZhQq487zmPbmEvbqM4Y1Ag76HQERGpAcEhut9AtDs9dg0cp+
	wJsZ9jguULTL9b8fNaM2HTj9Ws1eV4Y6yVrxxBosVFH5lwlYlfYQgvsH4/fEtp40
	ExHIQxGCR3/6JJekQNhS+CL5vYxdEHhcTnUCs7KkMq+8Kc0GKOEQg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpudkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:36 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52EBiRqg016764;
	Fri, 14 Mar 2025 11:45:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpudkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E8WSE4015357;
	Fri, 14 Mar 2025 11:45:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atsppq7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52EBjVUA34865804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 11:45:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 410862004E;
	Fri, 14 Mar 2025 11:45:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC6722004B;
	Fri, 14 Mar 2025 11:45:27 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 11:45:27 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] powerpc: fadump: use lock guard for mutex
Date: Fri, 14 Mar 2025 17:14:59 +0530
Message-ID: <20250314114502.2083434-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250314114502.2083434-1-sshegde@linux.ibm.com>
References: <20250314114502.2083434-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jh4LPkSVlRClFZBVYA-cGyYUB2sB5r6N
X-Proofpoint-ORIG-GUID: SeRbKrqwDoY0QVWHWlC76RIQOVxC2jGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=711 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140091

use scoped_guard for scope based resource management of mutex.
This would make the code simpler and easier to maintain.

More details on lock guards can be found at
https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4b371c738213..fc6c5275811e 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1374,15 +1374,12 @@ static void fadump_free_elfcorehdr_buf(void)
 
 static void fadump_invalidate_release_mem(void)
 {
-	mutex_lock(&fadump_mutex);
-	if (!fw_dump.dump_active) {
-		mutex_unlock(&fadump_mutex);
-		return;
+	scoped_guard(mutex, &fadump_mutex) {
+		if (!fw_dump.dump_active)
+			return;
+		fadump_cleanup();
 	}
 
-	fadump_cleanup();
-	mutex_unlock(&fadump_mutex);
-
 	fadump_free_elfcorehdr_buf();
 	fadump_release_memory(fw_dump.boot_mem_top, memblock_end_of_DRAM());
 	fadump_free_cpu_notes_buf();
-- 
2.39.3


