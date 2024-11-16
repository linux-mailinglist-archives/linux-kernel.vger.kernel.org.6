Return-Path: <linux-kernel+bounces-411876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 577059D00AB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 20:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168D92876C9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EC11AAE33;
	Sat, 16 Nov 2024 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pQpo47wX"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB8191F7A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785099; cv=none; b=QoGD1w2kfioJYintH9mVTFbMpsEp2AkMCfoeunyz5oJrp4QfOiZu8jeY2MdBNCW7N+vmAozHWuqazHN5qiJ2m2qmdd+hv4yWqXKmRZEJ00mIkwRDa6XzO499Q8UcRVMYp6b24uIW7Xdjn0p+EAos4awur9Z63xCtFJIrUv5+nQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785099; c=relaxed/simple;
	bh=XajJ7P8F2bVIM3HEVhGPIKHiQNp5ggNKVqY/VX2leIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA87O3s52NuYVtkcclBT3ApkD02ZoJi21YLFeqmAOFsuAzPXbx0u60MYg34jAqEeAZLpVqOceSTJIN5AzUsmwgyJHD+vuw7v5QXuuKocMLSBkce7N6DAGSr1uHgjuiI9bs2zMjvcq6xUbC3GxAwcPeLMobKX/Iv8ZQ7YaaYc82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pQpo47wX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGHTUjs023793;
	Sat, 16 Nov 2024 19:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VrXm4CcyPZMofJB5r
	tl6eM3KG+92o/0fEeQSzM6etFs=; b=pQpo47wXALyEOOOKSd7JCZodJRCH1EJKB
	Pozagr59R9uczuih6FsJg3w/GGg38Y3YSY4TSgHseUlDsynzPMnBhUKwBaHqFnYA
	N4OWbLgHJN19aS90WVBDDb+KgnhRCPK2OZAA48oDFeP5NIzKqeGEFPfZjkByZl+R
	UVWsxSc/HlcMYwmF7ErNBo2zBQG9smUxPxM/9UluvvFqD4GvngfV/5UaYI8dgbZk
	BLpp6MUz16H/Ord4ajOEi+aTj2U4g3B/9oqLQ/cGJtWWYq/1F/ifNBbCqNKwfSWj
	TNP9PUxtLcD3ee64RaPw+o87QArPGRO5PODSeDuJFo+dQ7OxesrDg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu18ag9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 19:24:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AGJK7ZL032457;
	Sat, 16 Nov 2024 19:24:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu18ag7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 19:24:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGHwjVa008392;
	Sat, 16 Nov 2024 19:24:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjf0y5hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 19:24:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AGJOTmb53412138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Nov 2024 19:24:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03D3520043;
	Sat, 16 Nov 2024 19:24:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAC4120040;
	Sat, 16 Nov 2024 19:24:26 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.220.93])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 Nov 2024 19:24:26 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        maddy@linux.ibm.com, bigeasy@linutronix.de, ankur.a.arora@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc: Large user copy aware of full:rt:lazy preemption
Date: Sun, 17 Nov 2024 00:53:06 +0530
Message-ID: <20241116192306.88217-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241116192306.88217-1-sshegde@linux.ibm.com>
References: <20241116192306.88217-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EdNCyaoVO74elOKg6CZ6IappUiebcywk
X-Proofpoint-ORIG-GUID: -mJAzlN_T8nOW_D2ZgQuWCuNhBTMAScI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160165

Large user copy_to/from (more than 16 bytes) uses vmx instructions to 
speed things up. Once the copy is done, it makes sense to try schedule 
as soon as possible for preemptible kernels. So do this for 
preempt=full/lazy and rt kernel. 

Not checking for lazy bit here, since it could lead to unnecessary 
context switches.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/lib/vmx-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index d491da8d1838..58ed6bd613a6 100644
--- a/arch/powerpc/lib/vmx-helper.c
+++ b/arch/powerpc/lib/vmx-helper.c
@@ -45,7 +45,7 @@ int exit_vmx_usercopy(void)
 	 * set and we are preemptible. The hack here is to schedule a
 	 * decrementer to fire here and reschedule for us if necessary.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT) && need_resched())
+	if (IS_ENABLED(CONFIG_PREEMPTION) && need_resched())
 		set_dec(1);
 	return 0;
 }
-- 
2.43.5


