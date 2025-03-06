Return-Path: <linux-kernel+bounces-548235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EE4A54216
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626F0188C563
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032119F116;
	Thu,  6 Mar 2025 05:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sk2zuA3d"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431619E98D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239046; cv=none; b=cl9hyo+3k77JLvt0QW81pbohVYSGtbtO2ItFMPTPmIo06d3EMssROFeCNKUBYSzp7bP3DZdH72NCkV3Ce4NYhFwmJwz/H4KKHMm/J/z1deEZWo8CgH7pEgPF5VKRj299gpriKhJgNyCIVBJWXM709rFX6PT/CkyimEVQiRL25ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239046; c=relaxed/simple;
	bh=V+qZrTq3XKqDR+h+jX0jXtqdThW85XNK/pxkTOR434Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJvnY5f4g+JNW4VpaqPwJaOMRavaWCx5OPyhN9t9VAw0NsevVoQmliEi8UaaJS4dfuuF11c/PzeMPQSDNmTakYH7UKH0f2i0HY2192NXoGIypbS6px6Lai1YhhmVCKhw00k1xRqnQ78+skRAd3HhQysCMiyAFrSbxI8owsrJojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sk2zuA3d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525MNhEk000401;
	Thu, 6 Mar 2025 05:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=diTIjZ+5K2ZYnlDKE
	Z5q9v0N3zMw6ZPLbDxVEAmlZWI=; b=Sk2zuA3dn0GZcChpr1c9/npM2UPJhkU8u
	nSVe+0GMdPC8J30MrpVKMRc2pGjimbv0oa5OdmGrbS1On77CULA9URgc4rMamnvd
	7ewzS+ajq6Zxdvz26f7i9sg4JpXAjFqc9WcVpO0z4FiAVowUP4Qm1reslTp4VJxZ
	Xz6tS8WurxCgBYe5o20zL3BlJ2dcp7nfnlLkuic9nB9eMj7XGY3BlsKD6nrSfy8p
	Ek/NWbgVVVwoLCdTzCWX/xTSeB8AYzkecKbYGk+/WO78vV7KrLlYARpr4KrT7SMC
	54JhFQ9qQmLEqSll5/uMfz1Ri/+STTVcofedtGWWnNF1tSgPIO9lA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456pnavcjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 05:30:23 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5265NN0B022526;
	Thu, 6 Mar 2025 05:30:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456pnavcjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 05:30:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5265Ce4q020845;
	Thu, 6 Mar 2025 05:30:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnpxhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 05:30:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5265UHUo50594236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 05:30:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B073020049;
	Thu,  6 Mar 2025 05:30:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7312B20040;
	Thu,  6 Mar 2025 05:30:15 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.in.ibm.com (unknown [9.109.215.252])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 05:30:15 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: juri.lelli@redhat.com, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, mingo@kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, hbathini@linux.ibm.com, joelagnelf@nvidia.com
Subject: [PATCH 2/2] sched/rt: update limit of sched_rt sysctl in documentation
Date: Thu,  6 Mar 2025 10:59:54 +0530
Message-ID: <20250306052954.452005-3-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: R_dZG9f8LwN3Z9LG-d8ZrJZmQ8Clbmav
X-Proofpoint-GUID: -no_t_MgLe0aMN-TiBa5_o_yNG9T442l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_02,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=867
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060038

By default fair_server dl_server allocates 5% of the bandwidth to the root
domain. Due to this writing any value less than 5% fails due to -EBUSY.

cat /proc/sys/kernel/sched_rt_period_us
1000000
$ echo 49999 > /proc/sys/kernel/sched_rt_runtime_us
-bash: echo: write error: Device or resource busy
$ echo 50000 > /proc/sys/kernel/sched_rt_runtime_us
$

Since the sched_rt_runtime_us allows -1 as the minimum, put this
restriction in the documentation.

One should check average of runtime/period in 
/sys/kernel/debug/sched/fair_server/cpuX/* for exact value.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/scheduler/sched-rt-group.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index 80b05a3009ea..ab464335d320 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -102,6 +102,9 @@ The system wide settings are configured under the /proc virtual file system:
   * sched_rt_period_us takes values from 1 to INT_MAX.
   * sched_rt_runtime_us takes values from -1 to sched_rt_period_us.
   * A run time of -1 specifies runtime == period, ie. no limit.
+  * sched_rt_runtime_us/sched_rt_period_us > 0.05 inorder to preserve
+    bandwidth for fair dl_server. For accurate value check average of
+    runtime/period in /sys/kernel/debug/sched/fair_server/cpuX/
 
 
 2.2 Default behaviour
-- 
2.39.3


