Return-Path: <linux-kernel+bounces-347085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F8C98CD9C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D805FB219CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C8D155735;
	Wed,  2 Oct 2024 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R1Z8NbU3"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6213D886
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727852907; cv=none; b=oOxy1/Y0oZZ5m17ciZfpcnsgyEdx2UTmVJ88aciHZIFoywfGOrQqbFFhupxDtAltW9Ntr2w3LRRcQJEITwu8avZklFwUQFhqKbBCnku38JN/S2pxxbI6yEianeHvhdT8+M8btX/qENuI/2VUMvwk4oGd8RoYA1pCu98iYXHMom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727852907; c=relaxed/simple;
	bh=Mjy4aXoVk3yDFGyj2vZf05lTjnDtsVSQWoXsrkIC6M4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=G5/P+5fU3awL2MX6qjHaW8phxS+rivhgTuE1rGsXHLlc29s3r2DbFEiJb0QvE+DNNKQ/lUxjjif2rqk5eKi+p8Bf6/ciPK8u94HP3G4LbtcvP8bXWHhV+O+DxTZ9xaXYh6Wwnh1+dq8YjYFyuGUwxrGTvfioqcFMpmrtPskeudI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R1Z8NbU3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4926LTEQ026512;
	Wed, 2 Oct 2024 07:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=P4rjUEsybosCNy/EToXD4t3dAK4zy8wqgzqJhgcTkaw=; b=R1Z8NbU3SdoC
	OJx+KrikqwplzFQ0Cz8aSOen0I6kCfNr20bzv7eFaX+5DqWmNzhu8t1HkaMuC/WY
	lJFACbkVYwazZjSCp/giWL9LSxvAHiKbVSxvVl2I+ziDT2CSZcFmKRP28m00KLIf
	Js9uISpFoQTxi5mHSUtnGCEWA54cY118uejMcSR1mfw5ujtysSNMGZtwlQths8jV
	CxUPec7KCkQWDBWQfDU0zUZX01E06DyvplWyOjhGsjU5dFdz1kEhHI4H/bD+zlw0
	niG71mva1Cly6DtjTnfqiocCkLvwTSCb9+qo0p6TzJOzlyrZVH477CHgvImhMt+1
	XqoDtgTyzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4210u0r659-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 07:08:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49278EE7023600;
	Wed, 2 Oct 2024 07:08:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4210u0r657-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 07:08:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4926LRDR008050;
	Wed, 2 Oct 2024 07:08:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgy0vfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 07:08:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49278Bvq26935942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 07:08:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9A2520043;
	Wed,  2 Oct 2024 07:08:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F23D20040;
	Wed,  2 Oct 2024 07:08:09 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.16.166])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  2 Oct 2024 07:08:09 +0000 (GMT)
Date: Wed, 2 Oct 2024 12:38:06 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>, Barret Rhoden <brho@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Add __weak markers to BPF helper function
 decalarations
Message-ID: <ZvzxONGQMnRpueRC@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: au9E0-P6HgxeCKkh6QUNlTYVsWNREvur
X-Proofpoint-ORIG-GUID: YV7zwQAowQ9aOTwuzSpV1-ytky5SRL7h
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_06,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=585
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020051

Fix build errors by adding __weak markers to BPF helper function
declarations in header files. This resolves static assertion failures
in scx_qmap.bpf.c and scx_flatcg.bpf.c where functions like
scx_bpf_dispatch_from_dsq_set_slice, scx_bpf_dispatch_from_dsq_set_vtime,
and scx_bpf_task_cgroup were missing the __weak attribute.

[1] https://lore.kernel.org/all/ZvvfUqRNM4-jYQzH@linux.ibm.com

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 225f61f9bfca..27749c51c3ec 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -41,8 +41,8 @@ void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vt
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
-void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym;
-void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym;
+void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
+void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_reenqueue_local(void) __ksym;
@@ -71,7 +71,7 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
-struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym;
+struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 
 /*
  * Use the following as @it__iter when calling
-- 
2.46.2


