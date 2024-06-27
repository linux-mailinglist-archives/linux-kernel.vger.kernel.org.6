Return-Path: <linux-kernel+bounces-232756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB93591AE00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85FE7B2A55B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814C219AD40;
	Thu, 27 Jun 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QWqvsO51"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7810D19A290
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509012; cv=none; b=jQ02loTrRcAKpp1nhPlLM4aHSCzQ9XIc7TrG4OQETHma8yCIm/TqOzPmCUrK2WT45y/NbwrciX6J/z++S3FuEDIdSwtUPb1FevRwcL8i7bq6pQ0iGlY7TjvGP2dG8/CV2LfFWtO5EgeeyAp9zV621Rlva4WSvI4phPY7xdlFKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509012; c=relaxed/simple;
	bh=r7UfoIzY8BAbE7vUGuPPMRYp6KdZoPPBbzFRHuaRcPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WwKc6bvC6GCsqEtv03eBLeT4eo7Nc+CQef9bYe1mD9NyhAHTPiKFKCOqSMeLeTbflpsMgw9cUDYSrtBxgp1FkW6Y/rOWlSrrQAk/FExR5Ofl4czsY/4DN6L6AR3QtUkmPBFdzWbGp0kxWpBSFzrltTov1uw0srbLBs86zvrKonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QWqvsO51; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nTK5E
	0I6NLEq0mbLTR3a9kQkQ1Ce0LvGK73T6gDMlEk=; b=QWqvsO51CuhdlUXt8jXwV
	KTS9gsoMQdHKXafZpwvzDW7tnEuDRWi/2XVQBslgV614fT9ozQNwKMa7vFs4Jx3x
	svaYbVXTE/YrEBU02X0lZ78ogJ6lN81OBaOsF8chrjrx7deA5JfAu2XHQkIyMt3n
	Lpm96WVTrxOazngSKXJOHM=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wD3vyS9n31mpIzdAg--.57568S2;
	Fri, 28 Jun 2024 01:22:05 +0800 (CST)
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
	Xavier <xavier_qy@163.com>
Subject: [PATCH-RT sched v1 0/2] Optimize the RT group scheduling
Date: Fri, 28 Jun 2024 01:21:54 +0800
Message-Id: <20240627172156.235421-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vyS9n31mpIzdAg--.57568S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr4xXF18tr1rurWDtr43Jrb_yoW8XFWUp3
	yvga45tr1kJFW7tryfAw109rWruw1SvanxXrs3K347Xrs5G3WSqryfKr4aqFyxWFykArya
	vw129r1xu3WUt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziNzV8UUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYwkLEGV4I-nEcwAAsB

Hi all,

The first patch optimizes the enqueue and dequeue of rt_se, the strategy
employs a bottom-up removal approach.
The second patch provides validation for the efficiency improvements made
by patch 1. The test case count the number of infinite loop executions for
all threads.

		origion          optimized

	   10242794134		10659512784
	   13650210798		13555924695
	   12953159254		13733609646
	   11888973428		11742656925
	   12791797633		13447598015
	   11451270205		11704847480
	   13335320346		13858155642
	   10682907328		10513565749
	   10173249704		10254224697
	   8309259793		8893668653

avg    11547894262      11836376429

Run two QEMU emulators simultaneously, one running the original kernel and the
other running the optimized kernel, and compare the average of the results over
10 runs. After optimizing, the number of iterations in the infinite loop increased
by approximately 2.5%.

Kindly review.

Xavier (2):
  RT SCHED: Optimize the enqueue and dequeue operations for rt_se
  RT test: Adding test cases for RT group scheduling

 MAINTAINERS                                   |   7 +
 kernel/sched/debug.c                          |  50 ++++
 kernel/sched/rt.c                             | 277 +++++++++++++++---
 kernel/sched/sched.h                          |   1 +
 tools/testing/selftests/sched/Makefile        |   4 +-
 tools/testing/selftests/sched/deadloop.c      | 192 ++++++++++++
 .../selftests/sched/rt_group_sched_test.sh    | 119 ++++++++
 7 files changed, 606 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/sched/deadloop.c
 create mode 100755 tools/testing/selftests/sched/rt_group_sched_test.sh

-- 
2.45.2


