Return-Path: <linux-kernel+bounces-513809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64065A34EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E733ABE83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F6E24A04C;
	Thu, 13 Feb 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kil9nCyi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA3E28A2CF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476967; cv=none; b=swh2uz1Hrqg3TuRXEnx6VYDgLKlfQUd6HmJUmSZct+y//fYBR2ZEvKjfeGRbZetLY/Z0n5jQW+3Jx1sI4cYIh61Z6BFJoKVIsEvzz71B/MS68UbGCS7WFkQbctj1hwnTjBV2xPfMcRT8y57Cls1dgn4VriGpCOou4sVaxirRfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476967; c=relaxed/simple;
	bh=A+ih5m/Peky6swazciVfmxJpolWiWfF0hfS+XSSF0uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdLtx7a9x0y/SD4h/G5skyRKfXMRx0HQ515Ob4Gnsr4/NQnA5719lTAgaumIjHw7TWMyZzuYSSemP5Cvrh/2FDhdbYHLR2VeXQp8Mkgj9TeNBwBusq/spGi3G6pzlNBpwV1GOaM5+6Sybo9FQNEVznv35/0Q/FerQD/kmRzUNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kil9nCyi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739476965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hlf6x/2m+ZIY8uOQVOMDgFdeACA4Rc/2FVHmDJRTfuE=;
	b=Kil9nCyieBXSUCa5FXuwd8LMEzhBCUYQHABloSB3u5EeuhX+4JrbVpBF2TtzHR9T11iY9w
	3wQ6ZNsDRLEIpuj9aUya7l440xTJue3O0+FLaRGhoVHLz96xl6Hg4MY0gyo8D3LPO0qUZo
	33qT8kinpJzG3cXmy3q7o3ziCfYVs8k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-7NPXp59oPO-5ALDO5t9JgA-1; Thu,
 13 Feb 2025 15:02:41 -0500
X-MC-Unique: 7NPXp59oPO-5ALDO5t9JgA-1
X-Mimecast-MFC-AGG-ID: 7NPXp59oPO-5ALDO5t9JgA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 095201800876;
	Thu, 13 Feb 2025 20:02:39 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.174])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17C4C1800872;
	Thu, 13 Feb 2025 20:02:35 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/4] locking/lockdep: Disable KASAN instrumentation of lockdep.c
Date: Thu, 13 Feb 2025 15:02:24 -0500
Message-ID: <20250213200228.1993588-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

 v3: 
  - Add another patch to insert lock events into lockdep.c.
  - Rerun all the tests with the simpler defconfig kernel build and do
    further analysis of the of the performance difference between the
    the RT and non-RT debug kernels.

 v4:
  - Update test results in patch 3 after incorporating CONFIG_KASAN_INLINE
    into the test matrix.
  - Add patch 4 to call kasan_check_byte() in lock_acquire.

It is found that disabling KASAN instrumentation when compiling
lockdep.c can significantly improve the performance of RT debug kernel
while the performance benefit of non-RT debug kernel is relatively
modest.

This series also include patches to add locking events to the rtmutex
slow paths and the lockdep code for better analysis of the different
performance behavior between RT and non-RT debug kernels.

Waiman Long (4):
  locking/lock_events: Add locking events for rtmutex slow paths
  locking/lock_events: Add locking events for lockdep
  locking/lockdep: Disable KASAN instrumentation of lockdep.c
  locking/lockdep: Add kasan_check_byte() check in lock_acquire()

 kernel/locking/Makefile           |  3 ++-
 kernel/locking/lock_events_list.h | 29 +++++++++++++++++++++++++++++
 kernel/locking/lockdep.c          | 22 +++++++++++++++++++++-
 kernel/locking/rtmutex.c          | 29 ++++++++++++++++++++++++-----
 4 files changed, 76 insertions(+), 7 deletions(-)

-- 
2.48.1


