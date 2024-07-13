Return-Path: <linux-kernel+bounces-251620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C5930720
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 21:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB17284C08
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAE51411F9;
	Sat, 13 Jul 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uv9FzDRY"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0934C8E
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720898081; cv=none; b=euJIly/4eFusu8thhfkF84EgTuYflOctwI8THqPqfZ+FnfUhlojlt4xHJImvSqV6o6sBh3rDrgruEAfeHzGSGAmzybD8azGyF+oRVfVghxHmuKN11wG6OlqhdzSzDIBORlCxopasKS66GfuAJE4WZ3tfBs3zJLTTE4QtrHt83bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720898081; c=relaxed/simple;
	bh=/DecuINImfSOHaLxjKiCXzgQVLAlCtPhPxlWZ6HKiVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CIHTthJnsVQU9aJhy6sKTWqgSPt4j+ZAI/bIb8yOtHkFJE8LjEN0SIz5HoDOiTfyK+x4+19WFJGjlDANouZAxkrr2QmgzLHYW2S8VlJZSlieUcwfn1xlORcS/hIHpFvXWliHZhJtY3QkV70T3MAof+QWKZOspDzsN+Lcx4yrCuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uv9FzDRY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DIko76024998;
	Sat, 13 Jul 2024 19:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:mime-version:content-type; s=pp1;
	 bh=3iaa6gYi64tlJbCrvUa77pK8nJ+yt/45eM5CgqGuYtI=; b=Uv9FzDRYbMY7
	F0+Cpbtge1c0wANbyN8NZ9m7S8ZjrMW6MGheIQ5WhMWwFn4ziAR6+xLZy8cUMjO+
	0FT+ALq99xy5/1JXE7rAHpD6QX9LVLuN1zYfM8ltUkTUrYgSJIBJf5fXXW/N0YBP
	5pnIqOKw/gdRtw9Q6x2HDui8KFa0mHx/yuWZwfHbGQA44UJzArGZ4/9/pMnzCwRJ
	v9lJByldbyytNEoqopOvj+GDQQ8r3DhCKno7yKAvhMYM7UdPw9KHkByzLqZgfyf0
	O2Ft3U6SjzIWbwFvUtG5zLnbu/MmUHobYJaioR+DzXfl0VxPxz9IjK5hWmqmMhJ0
	t9h5/kzBXQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40bw4mg6gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 19:14:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46DIxtrI013962;
	Sat, 13 Jul 2024 19:14:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407gn1d0sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 19:14:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46DJES4E46989638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 19:14:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2FED2004B;
	Sat, 13 Jul 2024 19:14:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8241020040;
	Sat, 13 Jul 2024 19:14:27 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.37.83])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 13 Jul 2024 19:14:27 +0000 (GMT)
Date: Sun, 14 Jul 2024 00:44:24 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, Vishal Chourasia <vishalc@linux.ibm.com>
Subject: sched_ext/for-6.11: cpu validity check in ops_cpu_valid
Message-ID: <ZpLSEHskvXXv4EoR@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yJ3CHIzji9mIZy7Rk2koJPzCyAR-PSgb
X-Proofpoint-ORIG-GUID: yJ3CHIzji9mIZy7Rk2koJPzCyAR-PSgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=603 adultscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407130143

Currently, the BPF scheduler can return a CPU that is marked as possible
in the system configurations, but this doesn't guarantee that the CPU is
actually present or online at the time. This behavior can lead to
scenarios where the scheduler attempts to assign tasks to CPUs that are
not available, causing the fallback mechanism to activate and
potentially leading to an uneven load distribution across the system.

By defalut, When a "not possible" CPU is returned, sched_ext gracefully
exits the bpf scheduler.

static bool ops_cpu_valid(s32 cpu, const char *where)
{
	if (likely(cpu >= 0 && cpu < nr_cpu_ids && cpu_possible(cpu))) {
		return true;
	} else {
		scx_ops_error("invalid CPU %d%s%s", cpu,
			      where ? " " : "", where ?: "");
		return false;
	}
}

On POWER, a system can have differences in cpu_present and cpu_possible
mask. Not present, but possible CPUs can be added later but once added
will also be marked set in the cpu present mask. 

Looks like cpu_present() is a better check.

# tail -n +1 /sys/devices/system/cpu/{possible,present,online,offline}
==> /sys/devices/system/cpu/possible <==
0-63

==> /sys/devices/system/cpu/present <==
0-31

==> /sys/devices/system/cpu/online <==
0-31

==> /sys/devices/system/cpu/offline <==
32-63


diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 03da2cecb547..ca36596176c5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1333,7 +1333,7 @@ static void wait_ops_state(struct task_struct *p, unsigned long opss)
  */
 static bool ops_cpu_valid(s32 cpu, const char *where)
 {
-       if (likely(cpu >= 0 && cpu < nr_cpu_ids && cpu_possible(cpu))) {
+       if (likely(cpu >= 0 && cpu < nr_cpu_ids && cpu_present(cpu))) {
                return true;
        } else {
                scx_ops_error("invalid CPU %d%s%s", cpu,

Note: With this, when the BPF scheduler erroneously assigns a task to an
offline CPU, it doesn't stop. Instead, the core scheduler compensates by
allocating a fallback CPU from the same node as the task's previous CPU.
This can sometimes lead to overloading of some CPUs.

Will cpu_online(cpu) check be a better alternative?

