Return-Path: <linux-kernel+bounces-174942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFF48C17C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9618A2818D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA137FBA3;
	Thu,  9 May 2024 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Py+iH2ZK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24B37F7F5
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287412; cv=none; b=d7tnApLqtkhXkojH3M9l/wlekcARwxeQaYLBt9MEXNmIEq3FY9NRG0W5hSQW7zRLVUArQCf0xQh+8onZY6wMBBf3As4uScDCguPF6UdCKiimGVWAa5QIx6SODmp4MQ8/XIb8WaNf+7tS/B+E8Q2Du5EVlSR40PuEm75EjjaJMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287412; c=relaxed/simple;
	bh=beCdEFrDjDbqNzt6CjgtMqoWvg/CjED3y7rA+iD94Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=AQUk51nRURDlGzS73EBXw3/l+vPHTOf3puBGzZrzI7j7Cyn4Hs+2siwb2jPeNU04ENAveNugJY021kQ4+8Iskh4RFMCsKMuaX5HBydPYoXNpr6fG+4+Dqptk6P2L8fToDo/vGi6lPw5a+PZIpK2Fwu9SmVnQa6hTUI6TXr0aPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Py+iH2ZK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715287409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCRiRvE1CgiNzou2dDo1DdiD9MqS9nj8dSi6q8kd19E=;
	b=Py+iH2ZK9XwCjI/cU1tO8S6Dp3cpotUUhid09anchfu7I9WovnRVdfTb5w5z4OVXcdKMnC
	1jkoxFgzJZdxI5wkqLQIQqWZrHKHyj+R8CdVjwCZfcOwBmvs6TfPT1KDDJ8BTsa9vVe8E3
	lpkB+v4vdFCG2ntrDY53+Alil3GnyPs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-duN84RJdNTKgb3GElsR1Gg-1; Thu,
 09 May 2024 16:43:28 -0400
X-MC-Unique: duN84RJdNTKgb3GElsR1Gg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 732C029AA389;
	Thu,  9 May 2024 20:43:27 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B560D1C4DB56;
	Thu,  9 May 2024 20:43:26 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	aviv.coro@ibm.com
Subject: [PATCH v3 0/3] block,nvme: latency-based I/O scheduler
Date: Thu,  9 May 2024 16:43:21 -0400
Message-Id: <20240509204324.832846-1-jmeneghi@redhat.com>
In-Reply-To: <20240403141756.88233-1-hare@kernel.org>
References: <20240403141756.88233-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

I'm re-issuing Hannes's latency patches in preparation for LSFMM

Changes since V2:

I've done quite a bit of work cleaning up these patches. There were a
number of checkpatch.pl problems as well as some compile time errors
when config BLK_NODE_LATENCY was turned off. After the clean up I
rebased these patches onto Ewan's "nvme: queue-depth multipath iopolicy"
patches. This allowed me to test both iopolicy changes together. 

All of my test results, together with the scripts I used to generate these
graphs, are available at:

  https://github.com/johnmeneghini/iopolicy

Please use the scripts in this repository to do your own testing.

Changes since V1:

Hi all,

there had been several attempts to implement a latency-based I/O
scheduler for native nvme multipath, all of which had its issues.

So time to start afresh, this time using the QoS framework
already present in the block layer.
It consists of two parts:
- a new 'blk-nlatency' QoS module, which is just a simple per-node
  latency tracker
- a 'latency' nvme I/O policy

Using the 'tiobench' fio script with 512 byte blocksize I'm getting
the following latencies (in usecs) as a baseline:
- seq write: avg 186 stddev 331
- rand write: avg 4598 stddev 7903
- seq read: avg 149 stddev 65
- rand read: avg 150 stddev 68

Enabling the 'latency' iopolicy:
- seq write: avg 178 stddev 113
- rand write: avg 3427 stddev 6703
- seq read: avg 140 stddev 59
- rand read: avg 141 stddev 58

Setting the 'decay' parameter to 10:
- seq write: avg 182 stddev 65
- rand write: avg 2619 stddev 5894
- seq read: avg 142 stddev 57
- rand read: avg 140 stddev 57  

That's on a 32G FC testbed running against a brd target,
fio running with 48 threads. So promises are met: latency
goes down, and we're even able to control the standard
deviation via the 'decay' parameter.

As usual, comments and reviews are welcome.

Changes to the original version:
- split the rqos debugfs entries
- Modify commit message to indicate latency
- rename to blk-nlatency

Hannes Reinecke (2):
  block: track per-node I/O latency
  nvme: add 'latency' iopolicy

John Meneghini (1):
  nvme: multipath: pr_notice when iopolicy changes

 MAINTAINERS                   |   1 +
 block/Kconfig                 |   9 +
 block/Makefile                |   1 +
 block/blk-mq-debugfs.c        |   2 +
 block/blk-nlatency.c          | 389 ++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h            |   6 +
 drivers/nvme/host/multipath.c |  73 ++++++-
 drivers/nvme/host/nvme.h      |   1 +
 include/linux/blk-mq.h        |  11 +
 9 files changed, 484 insertions(+), 9 deletions(-)
 create mode 100644 block/blk-nlatency.c

-- 
2.39.3


