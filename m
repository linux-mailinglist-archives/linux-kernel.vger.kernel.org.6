Return-Path: <linux-kernel+bounces-548238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EDA5421B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9016D3AFAA9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F18319F462;
	Thu,  6 Mar 2025 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WhKxB/ph"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660A019F117
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239076; cv=none; b=NkUbATgKLSBeWOEwbBe0JpGeYC7/Lf/Zk6LETYZ8kY93LUuhWBDtPhblhJD7UZJoIkGHu8wew4Ta2OznHd4Gmtpy813y6vpIC9ukFkRNVdfDxJaSPliU9TWUa4HDZRBK+V9+fWkNof0tBRWGsyeBFauvJMfU1b+lWRdD4TF1fe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239076; c=relaxed/simple;
	bh=3ynaxBvRrdJj90117CE+hIRHzTxIazodLzckrte7LmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpaBf4/g5bLCplJ8pisHAy1P8UjwziON0UXJmPR1ZZztPmJZgTcJnf1jmrMvZE7pCFjFnuN2GrIBTuQ0Yg5wFnX/nJA3TH9Nx9fEZPALRJeceIBWw6nY+sM4uNHan0cGH6SebfGyFU0BUA8Lx6FeE4jgrW7hmdCNFj5JBbSD/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WhKxB/ph; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525L6I6o032496;
	Thu, 6 Mar 2025 05:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MdCiEWpidK+Puu5Z1ji4ZAwqRJKQjKx2tz4w5ziMj
	yw=; b=WhKxB/phQKjdDyLY/kV7OfqDnPn2txX7gx4UaBRf9pV3zQCQLGQkPreVi
	Qc54KJhWk7I62cb7E/vgvg/4NzlEEv13ulzOdAvPD1BbcgBAK10Yo3zy6xUKOc9u
	jf0RlcEUFlIcvHE51sh1PAf1BcrcJ+kvl3I42TmYPzbAwPSS9FENakVXe7XzvIou
	/WEQU2d0pl0z9s/PFlPsjqtvjPIVQKfTGiMQsCQI4uWRmje9yhhmB6xb5LfB1O5L
	v3v00/hU9AG7OgJ1fb6x4PgqQu98ar8kKMv6nxTnUf+X56uAaMaGdwVz4Y4ubRZY
	lxV6N34k9YWnU9xWgCg6Vp/7r1Vwg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456pnavcj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 05:30:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5265OH07025479;
	Thu, 6 Mar 2025 05:30:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456pnavcj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 05:30:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52625QGe013720;
	Thu, 6 Mar 2025 05:30:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kxun3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 05:30:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5265UAfN56361414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 05:30:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF3B020049;
	Thu,  6 Mar 2025 05:30:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67CA620040;
	Thu,  6 Mar 2025 05:30:08 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.in.ibm.com (unknown [9.109.215.252])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 05:30:08 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: juri.lelli@redhat.com, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, mingo@kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, hbathini@linux.ibm.com, joelagnelf@nvidia.com
Subject: [PATCH 0/2] sched: issues with sched_rt_runtime_us
Date: Thu,  6 Mar 2025 10:59:52 +0530
Message-ID: <20250306052954.452005-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PvhSCKz2Iij-PW_a8eNd2limQhuRhSkI
X-Proofpoint-GUID: -H2MLXdsjrZFQl5WjNBqln_LoxghWUE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_02,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=980
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060038

ftrace selftest reported below failure in one of the systems.
[5] Test tracefs GID mount option       [FAIL]

On inspection this happens since writing -1 to sched_rt_runtime_us 
fails. This happened because the possible cpus were more than the 
active cpus. 

Fix this issue by considering only the online CPUs for validating the 
deadline entities. This is minimal impact compared to changing the 
dl_bw_cpus use possible mask. If that is better, we can follow that
approach. 

There is also another issue that is observed when working on it. Writing
any value less than 5% of period results in -EBUSY. This happens since 
fair_server dl_server allocates 5% of the bandwidth and that is part of
the bandwidth of the root domain. Lets document that behaviour since
the file allows writing -1 as the minimum. 

Shrikanth Hegde (2):
  sched/deadline: use online cpus for validating runtime
  sched/rt: update limit of sched_rt sysctl in documentation

 Documentation/scheduler/sched-rt-group.rst | 3 +++
 kernel/sched/deadline.c                    | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.39.3


