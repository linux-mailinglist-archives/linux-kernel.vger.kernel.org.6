Return-Path: <linux-kernel+bounces-315620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F068C96C50D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447C7282B05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0D01E009C;
	Wed,  4 Sep 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJrYyEb9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A961674
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470112; cv=none; b=i8BYRRz0YXLzbTRPLG274n28Z5F35WWeCr0n2upq2oNgKyrPBbLiatXok+jeeja6KZOhQdt0Bmc53PkR3X6Hv19ObcxJGuRmrdYy2VTHNAqlwwdD0TeeS8DJNYi50Z8qboZ2tjpLtk5RJ7oUwUm8pQwvQCOqESazYv6msfZQQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470112; c=relaxed/simple;
	bh=hg4WKOtL/yUR6eLvjGPRpTnt/+LJxjv6JmP/vcZ4Sgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DW6OXJ7btshRWDo6QgwnHjtnzak5OiT5PvMQbXIJ1Ee9QsDKuezs4Z2ba/GO6K5oM7LYHVCceB73S18uBaU8eUVNjmsPG4wf/nWCzzV+8Ai69Sfqc05P4UNbtScjyeotIq/0SEzF7rdLm2JJXzQ0W0oRSYSKqSKGHiRhOGHJcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJrYyEb9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725470110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mpkJZp2FlvmL/w6LEeXX5r7FJDEVPYKnqjuKGzSiRSg=;
	b=dJrYyEb9JgnTkad9vE/n0tb4YgE+2WeInGTnwavPb4GAyTY51lFR2st4wyrGHmlnhbA/9P
	tX/4TifpIq9d6Y5i3Ma5jZshds2d4vSY18CQEyAZBcnR6Dh/LImh8ZbGLtnfg0E0MmKWND
	akz36I/j7e6jTG/R445DrkXDc1fvck8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-Pa8T7CJfOVKdII_8WDAM6A-1; Wed,
 04 Sep 2024 13:15:05 -0400
X-MC-Unique: Pa8T7CJfOVKdII_8WDAM6A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52B6C1954B16;
	Wed,  4 Sep 2024 17:15:03 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.172])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5395B1955F45;
	Wed,  4 Sep 2024 17:15:00 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] sched: Miscellaneous isolation related cleanups
Date: Wed,  4 Sep 2024 13:14:39 -0400
Message-ID: <20240904171441.1048072-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

 v2:
  - Remove HK_TYPE_SCHED and related dead code
  - Change consolidated name from HK_TYPE_NOHZ_FULL to
    HK_TYPE_KERNEL_NOSISE as suggested by Frederic and update
    isolation.c as well.

This series contains a number of miscellaneous sched/isolation related
cleanups.

[v1] https://lore.kernel.org/lkml/20240818234520.90186-1-longman@redhat.com/

Waiman Long (2):
  sched/core: Remove HK_TYPE_SCHED
  sched/isolation: Consolidate housekeeping cpumasks that are always
    identical

 include/linux/sched/isolation.h | 19 ++++++++++++-------
 kernel/sched/fair.c             | 14 --------------
 kernel/sched/isolation.c        | 10 ++--------
 3 files changed, 14 insertions(+), 29 deletions(-)

-- 
2.43.5


