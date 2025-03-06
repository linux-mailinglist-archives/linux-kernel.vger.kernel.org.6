Return-Path: <linux-kernel+bounces-548237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71ADA5421A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603CA17050C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F269A19D09C;
	Thu,  6 Mar 2025 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P/wKzUG/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C119E992
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239075; cv=none; b=VN2XsbUepHaNCNkjexj41oZn6fVMxxX8rPIxdmxd/wip3jAkWwWxvNSq9hgKJNVyMAU/zVfmuYtvJqKeEFSMCbp3k0I8fWbSBcH+nu89l7XGW0pUdAY5Ap0BhWbZ4qalOvUE0fB4vnz68JY3wq4y+1TRraHNe4NZ8lzE4Ev8/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239075; c=relaxed/simple;
	bh=Ux6XPkiSd9LmsIFG4lAikiWwTmewyPORLgKMMIU8+kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZCOhVI3XdpLFChvVsrvbsMKXfTZDRn30Ai4sKaNhyoUT80lnw/fFNRICMjhNss6s85/tNX4PzWPdXJmKV8JrYBXKEKqN49tIdXE4U5ywdd6xz1bz81EoCNt0KDU2v13EjHqAIiE3z2klsKsVogPJZBqW9gWWJeIE6R1HwDEokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P/wKzUG/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525Kct2O028614;
	Thu, 6 Mar 2025 05:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dSxuRWzlY0rKG+DCw
	odJHCr5eVahssaJaGkjKtrf8Dw=; b=P/wKzUG/NxlKQD4tlL70c81RDajVF4f6Y
	XsZ0rUH2vOpMaCrBfs41NsqSrMVi5jMcgos0c7eCB3yDQUEwZQOzwx2NTeNKKmJf
	LG80hRj0SgyOy4efaHoTRK9ClBGsdtewqIRTOxQJpuPXWmOY1EGn9tvZm6vP6G3p
	4ashdrwlDx3/BkFgRnzeEpdj4QALqSuGH8Mqv3IbxtWkUvu43nAYVwdk/atB75TB
	OiVNMyimcKAvgmKN6426Zs1qRpIpXEcUmR6Gkv4IFhg4P3ObKSaRFIn0Kt2+Yl9K
	ttQwMrwGQL24FMWAV8yD3FXsJ/ITMRxO+oqB1neBeCwSmJEJTqQjQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu01uxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 05:30:19 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5265UIfj004827;
	Thu, 6 Mar 2025 05:30:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu01ux7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 05:30:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5264jnnv009015;
	Thu, 6 Mar 2025 05:30:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyq2b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 05:30:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5265UE3Q56230224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 05:30:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D26C20049;
	Thu,  6 Mar 2025 05:30:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0722720040;
	Thu,  6 Mar 2025 05:30:12 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.in.ibm.com (unknown [9.109.215.252])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 05:30:11 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: juri.lelli@redhat.com, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, mingo@kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, hbathini@linux.ibm.com, joelagnelf@nvidia.com
Subject: [PATCH 1/2] sched/deadline: use online cpus for validating runtime
Date: Thu,  6 Mar 2025 10:59:53 +0530
Message-ID: <20250306052954.452005-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250306052954.452005-1-sshegde@linux.ibm.com>
References: <20250306052954.452005-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QVAUM5Op6aG5qmHiysJsO5E0-zkDT0Nz
X-Proofpoint-ORIG-GUID: CiGkXSAqmODroZBFBmVJh_wJKW0iZrdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_02,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060034

ftrace selftest reported failure since writing -1 to sched_rt_runtime_us
return -EBUSY. This happens when the possible CPUs is different than
the active CPUS.

Active CPUs are part of one root domain, while remaining CPUs are part
of def_root_domain. Since active cpumask is being used, this results in
cpus=0 when a non active CPUs is used in the loop.

Fix it by looping over the online CPUs instead for validation the
bandwidth calculations.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2d0f571f95e9..7ea9c040c72f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3187,7 +3187,7 @@ int sched_dl_global_validate(void)
 	 * value smaller than the currently allocated bandwidth in
 	 * any of the root_domains.
 	 */
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		rcu_read_lock_sched();
 
 		if (dl_bw_visited(cpu, gen))
-- 
2.39.3


