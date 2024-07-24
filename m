Return-Path: <linux-kernel+bounces-261074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F1693B29B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DF11C237AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D146515A4AF;
	Wed, 24 Jul 2024 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va13J95q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E815921B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831005; cv=none; b=L6lYd+Ym0xp8hH4tTWwNgEeKl/fWAxyQE7ln4n+XtZ9pCaljeXXdzb76RYS9m5nSGTbwWV6A1aJz9WHfhXXXtyxZZpqVxkazVMvWUBV2Wl9vTflV2TcjFjdMBJVJhoTSpaXLEe2GA8WmHfa5HdHJDsTydyzkmLXWR+PthIr4+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831005; c=relaxed/simple;
	bh=mCUQ70F6/j+vRuvIX6UPDQb6P8vG0rsEwCkPOuUOwl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RL8iD4D6kbppx3OWhO6ekZHA+37sHqYfjhNUNXJkpgmnsp2rOduRwIGqen5/EHv0D1G0G634XJtOs+Bx2hkpMEuqDtnfLIs6FSjTnfvNZ3yWw5F9ypcObOWaYdmlZ8A7oXa4lIWyigcWt5QWOdbLJfzNV6CzCZdmD6ec1pZZrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va13J95q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721831002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=clA/h9i6o34vlWpGIqqnq4ZVlehnOc8AxMNiN27Bf3M=;
	b=Va13J95qsyt9aDkVEMvYwhnhXijXuec6wAKJsEH0q2DfKKxXYmeA4iBvj5L8jNMDF/DNFU
	dB9Z1bftA3t4wLgSRE3AiEk7r59TE0w5W6jIiFG60E/T2B0ax+ugjfrGa/vB++d8/4Ogsq
	6kgqqDW1EPjX2bJR3o2VZw6Xv9RKCb0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-YacFiaWrNmW5v_Ndm9a6cw-1; Wed,
 24 Jul 2024 10:23:08 -0400
X-MC-Unique: YacFiaWrNmW5v_Ndm9a6cw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA3D21955F65;
	Wed, 24 Jul 2024 14:23:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.96.134.38])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 221E719560AE;
	Wed, 24 Jul 2024 14:23:00 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v2 0/2] sched/deadline: fixes and improvements
Date: Wed, 24 Jul 2024 11:22:46 -0300
Message-ID: <20240724142253.27145-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello,

This patch series addresses specific issues and improvements within
the scheduler's deadline (DL) class. The patches aim to fix warnings,
remove redundant checks, and consolidate timer cancellation logic for
better consistency and code quality.

Patch 1: Fix warning in migrate_enable for boosted tasks

Fix a warning caused by unnecessary calls to setup_new_dl_entity for
boosted tasks during CPU migate_enable calls.

Patch 2: sched/deadline: Consolidate Timer Cancellation

Consolidate timer cancellation logic into dedicated functions,
ensuring consistent behavior and reducing code duplication.

Changelog
---------

v2:
* Drop patch to remove the redundant WARN_ON call.
* Change the "Fixes" tag in the patch 1.
* Change function names in the patch 2.

Wander Lairson Costa (2):
  sched/deadline: Fix warning in migrate_enable for boosted tasks
  sched/deadline: Consolidate Timer Cancellation

 kernel/sched/deadline.c | 45 ++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)

-- 
2.45.2


