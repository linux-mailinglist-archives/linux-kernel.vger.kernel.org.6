Return-Path: <linux-kernel+bounces-259007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A09938FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE4C1C20FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E916CD33;
	Mon, 22 Jul 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvDffQtu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E32AEFD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655025; cv=none; b=nXvkQ6HT8Bl6yRE+aoccKc4XBf0go1fnwk+lHJ7DRGGNNXP20FD+EEhHRS8nCcWjQtZuev6jLMb6LOgaS4GBsXQZsaxQXo/NKgHlaTkIzW4brMm3YfH78lYoYdMOdUovLFS3YZ9bVxsF5ksJCypB6jsw0hUuH9eT6C92xf/yMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655025; c=relaxed/simple;
	bh=mQNfnhfThOVoe3uPXqr+gUNoMEu/4Zdj0LLhEMpYpcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8QcogjgfgwVfqJ6mmI1AkR5tTvSh1D2PsNwHkNn5S/61NYGX2MKnXV93PnsZGE8yAgqFYcgwJ9mJx4Im+tQMMysSk7G6sldJnIxSe5mxIVKcNlu989lXqG3yqg8mpZO8j+mV38BPXeRgww2Cy1ZAfNviV+PyhV9eplTi9mTpIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvDffQtu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721655022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5gfVl6q4EqBvXwW86VrNEjEoOiLvT8GOE7YXI4ywKjU=;
	b=ZvDffQtuKxDyZqoUYiy5oK4pAYDRrwbNsGp3ftEuV7HWPl+PhoG/mYEu6/ciK80xmwRAJD
	bbqIuV1bCz0lr7+Tpz4h6hO7OuJYmAumYm2TTY07iLQpa09z3l9rUwFttRkoSi1Hdp8EFm
	MHBGC7RFOiJyHRzh1HICDinFJ6CM39g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-jPMA1SapOCuW5GebQLhoUg-1; Mon,
 22 Jul 2024 09:30:18 -0400
X-MC-Unique: jPMA1SapOCuW5GebQLhoUg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D01A19541B9;
	Mon, 22 Jul 2024 13:30:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.96.134.70])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AB251955D44;
	Mon, 22 Jul 2024 13:30:05 +0000 (UTC)
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
Subject: [PATCH 0/3] sched/deadline: fixes and improvements
Date: Mon, 22 Jul 2024 10:29:24 -0300
Message-ID: <20240722132935.14426-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello,

This patch series addresses specific issues and improvements within
the scheduler's deadline (DL) class. The patches aim to fix warnings,
remove redundant checks, and consolidate timer cancellation logic for
better consistency and code quality.

Patch 1: Fix warning in migrate_enable for boosted tasks

Fix a warning caused by unnecessary calls to setup_new_dl_entity for
boosted tasks during CPU migate_enable calls.

Patch 2: sched/deadline: avoid redundant check for boosted task

Remove redundant WARN_ON check in enqueue_dl_entity, as boosted tasks
do not require setup_new_dl_entity.

Patch 3: sched/deadline: Consolidate Timer Cancellation

Consolidate timer cancellation logic into dedicated functions,
ensuring consistent behavior and reducing code duplication.

Wander Lairson Costa (3):
  sched/deadline: Fix warning in migrate_enable for boosted tasks
  sched/deadline: avoid redundant check for boosted task
  sched/deadline: Consolidate Timer Cancellation

 kernel/sched/deadline.c | 56 +++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 19 deletions(-)

-- 
2.45.2


