Return-Path: <linux-kernel+bounces-544885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B38EA4E67E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF3F188E5C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F527BF82;
	Tue,  4 Mar 2025 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="BDG0HXMC"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969C27BF74
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104560; cv=none; b=QTHfDKRQvodHyxcHxZ/KqaOWWZE8UQ2oUGxNvE3yDy2/DUA0IYq3QybR+XrgO5e/au+uAwabkbDjwM8giBvJ8J3pvbeLk2nTTxh67ONy19Mp6yfOwdnOC8s6a9p57eejyRbpok0Y5p8prZC5/A5+ViSsXBs658dbM6UmDXHm+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104560; c=relaxed/simple;
	bh=qilxMa1c8LMQ+CsSP2mdhKVq44LOUVqgAhpfDRMXJZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qng3Fb1aG3fi2Ri6cLpKxowdxMfm/6hnuBUhEPdnUv/NXbDZr12iL4qaJzdJX1EOiMuK9C1qsFbhb/BozXz7ASHMqEFkeHeKgji9gX1fQJvgcsuUzHLptXiSTQp26fv9C0BrMadz9UrAI3o5zRbsYqJaUs1ql01ensyllRPGis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=BDG0HXMC; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524G2f8T029728;
	Tue, 4 Mar 2025 16:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=Oh9bKXB8ziO3B1kcZOrnrQEwTj9xc9xxJdGKO
	VnSk34=; b=BDG0HXMCrqlxKPBNeHeyNrG+niJxgf0WluPVdWH2hODhBw9+duhRp
	Z0z3hDAFIf0DAR6oOKeUHZrWGLusKApoCLCjriIZHTmnvT+AoOJlW1PvAyLz7SlK
	eFPmKFapPFAnpyvWVzcHLCVh99TtWxbG3QaK88U/RXmGm/3vZqREF8rewQimNXPt
	VulUIG+3tdYjN1KDyr5C8l+vnr66XwtN2gt9AB8/OInSDMmfkheEZ5fawKtz8/bP
	J32GrCbIlfYU8n9kCc+8v0uNoYF+CgbZo/raHdj9Q47Ctj83tmjwI2lB7lkPu64J
	Rd8cf/px9KhwUifCeCZ9dEgt8ZBmYts5Q==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 45626w9p8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 16:08:47 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 01C7F36CD0;
	Tue,  4 Mar 2025 16:08:45 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id CBF54800469;
	Tue,  4 Mar 2025 16:08:44 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 3F1CB300069F3; Tue,  4 Mar 2025 10:08:44 -0600 (CST)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>, samir <samir@linux.ibm.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        srivatsa@csail.mit.edu, Michael Kelley <mhklinux@outlook.com>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: [PATCH v4 0/2] Improving topology_span_sane
Date: Tue,  4 Mar 2025 10:08:42 -0600
Message-Id: <20250304160844.75373-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YqTQkkgqXQkt0Z6mNFIbyLQZ7vTnHgNC
X-Proofpoint-GUID: YqTQkkgqXQkt0Z6mNFIbyLQZ7vTnHgNC
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=545 clxscore=1015 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040130

toplogy_span_sane() has an O(N^2) algorithm that takes an inordinate
amount of time on systems with a large number of cpus.

The first patch in this series replaces the algorithm used with a O(N)
method that should exactly duplicate the previous code's results.

The second patch simplifies the first, taking a similar amount of time
to run, but potentially has different results than previous code under
situations believed to not truly exist, like a CPU not being included
in its own span.

Version 1:
  * Original patch

Version 2:

  * Adopted simplifications from K Prateek Nayak,and fixed use of
    num_possible_cpus().

Version 3:

  * Undid the simplifications from version 2 when noticed that results
    could differ from original code; kept num_possible_cpus() fix.

Version 4:

  * Turned the patch into a series of 2, the second re-introduces the
    simplifications, and includes further simplification suggested by
    Valentin Schneider in the discussion for Version 2.

Steve Wahl (2):
  sched/topology: improve topology_span_sane speed
  sched/topology: Refinement to topology_span_sane speedup

 kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 25 deletions(-)

-- 
2.26.2


