Return-Path: <linux-kernel+bounces-253359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42203932009
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3371C21ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FE11B947;
	Tue, 16 Jul 2024 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oYF9az2j"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F97179AE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107661; cv=none; b=cXfuu4VS8oWXEdSLiGq+qlQcdz5sAQpA/ZDqJfqdaelWlCxaemIJzz1niFaPOoRjAzk+rVOtvp3tNZqqTIhTrZCA4SP5zWRz1uVx2044DFRnFK61mOec+hym0w6OVIre6X/Rk3cOfV9wEaaFY+WUz1GNi9JowXbCvTzAuI0ecDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107661; c=relaxed/simple;
	bh=o/mVjkSUCowgwHrV7p66kcsQbQWbxcl7E8Cfocw3cgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qX9J1f/IyojpKMHH/HP74r2UHJ30ff+aj/boiKhIA73lr9lAhMAfcOWeX6zsvZqk7Z38wbEKB+Q5Ik3TSDSGtX88yMfiOoJwOGLiSGzJUpZNVQ7Br3qoTLnrnIB4Z1FztBEC1QMlC9BPSGJbvx9UI0jBxzjJDK4zKo5IKhzNCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oYF9az2j; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=an2bI
	e2Jcqri+mB6O+W8UzQa3g7Twu9iS3sZVny7bcs=; b=oYF9az2jof4XWkTnZLHwn
	xXovlAAh/gnQsZRwWbmyxcXRYBlP2SfvWPCXoXjIevyiZ5i02ZZo7+f3HEVlyyFc
	ySvH4LYivi7aid/OkvThT3GUN7/pv84STcVg2TNE/JoYlc2SsiGn1t5DhRMik4Oo
	mhEVneq3Qa/uX28Z7Wzoh0=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3fxhbBJZmPCgpDA--.31775S2;
	Tue, 16 Jul 2024 13:25:48 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-RT sched v3 0/2] Optimize the RT group scheduling
Date: Tue, 16 Jul 2024 13:25:41 +0800
Message-Id: <20240716052543.302383-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fxhbBJZmPCgpDA--.31775S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4kXr4ruFW5Gry7KF1rWFg_yoW3CrXEqw
	s8KryDArs5uF4DAFWxCrn5urWftayjgF1UGan8Xry5WrW8AFWDJF1kWF1DXa48XwsxJFZx
	JrnYqF4ftrsF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_bAw3UUUUU==
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYwAeEGV4JY6IZAAAs3

Hi all,

Patch 3 fixed the issue with handling tasks with prio set to 0 during
the execution of blktests.

Kindly review.

Best Regards,
Xavier

Xavier (2):
  RT SCHED: Optimize the enqueue and dequeue operations for rt_se
  RT test: Adding test cases for RT group scheduling

 MAINTAINERS                                   |   7 +
 kernel/sched/debug.c                          |  48 +++
 kernel/sched/rt.c                             | 287 +++++++++++++++---
 kernel/sched/sched.h                          |   1 +
 tools/testing/selftests/sched/Makefile        |   4 +-
 tools/testing/selftests/sched/deadloop.c      | 192 ++++++++++++
 .../selftests/sched/rt_group_sched_test.sh    | 119 ++++++++
 7 files changed, 618 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/sched/deadloop.c
 create mode 100755 tools/testing/selftests/sched/rt_group_sched_test.sh

-- 
2.45.2


