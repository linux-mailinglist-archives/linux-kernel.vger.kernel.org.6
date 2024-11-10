Return-Path: <linux-kernel+bounces-403350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4219C347F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DFFBB20E61
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6413D62B;
	Sun, 10 Nov 2024 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkVl+qbn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688D4D8D1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731268991; cv=none; b=booyO8Of4Xn+kTQmuPDoo2Q38La8aP+qXo8r3U5p1qLP8YeX+Z3luK6Kvqp6LGvJ6aKPjzM9JK0jDQJ4HECGV1vZ5zHPv0ykLXL3dea4NbmlFyfXMgUqUc2idj0jizHMHxg5VioGVqoMmoOnKd21BEhtWbaJWfGVURP24dJi2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731268991; c=relaxed/simple;
	bh=JAFCgV+vvL28xIrdStFZGIrVMc23/ZkPo06cE4EtZuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vem2hz1HyUe7NGstZ7jmsV++bL+QZ7NS5NsaSyHlP3CicOwIjvbN+vXZRNTNdsY4dSYfQb14GIoJ3GjF038HdlSKNOE/L5CrTsQfpr2OMizlnCrULupp13Kvy16XP1UM11UKdzvPE/D4WY1LNd2UmmsHdkcJ9qAjC+qXU5HsxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkVl+qbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A439BC4CED2;
	Sun, 10 Nov 2024 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731268990;
	bh=JAFCgV+vvL28xIrdStFZGIrVMc23/ZkPo06cE4EtZuc=;
	h=From:To:Cc:Subject:Date:From;
	b=rkVl+qbnMQ0RCh4/WkOWkOW/T/SwHbfce3Zzs2i6Ly5lk4Uv5tYSHhDyGvC3tCs0K
	 TH34NrrDKiAQiB7r5Y2gO8ao1t4xjAaIhWpBRH/VqZL4ujgFbaSlzpbdG0UeLleuPi
	 WC4L5Xfqj9uvvzt5Xd1LwkpgbC670qZHN3a2pxpifHXZmUT2+1CCdpNoFlqAmOMZ6B
	 Wi1de//kziNUHTQ8x97YblocG+OZ4dAg7lsHFlGyKFNYshAImSU3Ega0JyDv9Ax+F1
	 lIuG8OPvtIFVRvPwMQ7TiT7tx2wQVe8cNYsDBDe327ikH5iKMnDXZL7t9MwxRnLg00
	 j+ASpvS//NB3Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	sched-ext@meta.com,
	arighi@nvidia.com,
	multics69@gmail.com,
	me@mostlynerdless.de,
	ggherdovich@suse.com,
	dschatzberg@meta.com,
	yougmark94@gmail.com
Subject: [PATCHSET sched_ext/for-6.13] sched_ext: Rename dispatch and consume kfuncs
Date: Sun, 10 Nov 2024 10:02:50 -1000
Message-ID: <20241110200308.103681-1-tj@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

[v1] -> v2: Comment and documentation updates.

In sched_ext API, a repeatedly reported pain point is the overuse of the
verb "dispatch" and confusion around "consume":

- ops.dispatch()
- scx_bpf_dispatch[_vtime]()
- scx_bpf_consume()
- scx_bpf_dispatch[_vtime]_from_dsq*()

This overloading of the term is historical. Originally, there were only
built-in DSQs and moving a task into a DSQ always dispatched it for
execution. Using the verb "dispatch" for the kfuncs to move tasks into these
DSQs made sense.

Later, user DSQs were added and scx_bpf_dispatch[_vtime]() updated to be
able to insert tasks into any DSQ. The only allowed DSQ to DSQ transfer was
from a non-local DSQ to a local DSQ and this operation was named "consume".
This was already confusing as a task could be dispatched to a user DSQ from
ops.enqueue() and then the DSQ would have to be consumed in ops.dispatch().
Later addition of scx_bpf_dispatch_from_dsq*() made the confusion even worse
as "dispatch" in this context meant moving a task to an arbitrary DSQ from a
user DSQ.

Clean up the API with the following renames:

1. scx_bpf_dispatch[_vtime]()		-> scx_bpf_dsq_insert[_vtime]()
2. scx_bpf_consume()			-> scx_bpf_dsq_move_to_local()
3. scx_bpf_dispatch[_vtime]_from_dsq*()	-> scx_bpf_dsq_move[_vtime]*()

This patchset is on top of sched_ext/for-6.13 72b85bf6a7f6 ("sched_ext:
scx_bpf_dispatch_from_dsq_set_*() are allowed from unlocked context") and
contains the following patches:

 0001-sched_ext-Rename-scx_bpf_dispatch-_vtime-to-scx_bpf_.patch
 0002-sched_ext-Rename-scx_bpf_consume-to-scx_bpf_dsq_move.patch
 0003-sched_ext-Rename-scx_bpf_dispatch-_vtime-_from_dsq-s.patch

and is always available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-api-rename-dispatch-v2

diffstat follows. Thanks.

 Documentation/scheduler/sched-ext.rst    |   71 ++++++-------
 kernel/sched/ext.c                       |  243 +++++++++++++++++++++++++++++-----------------
 tools/sched_ext/include/scx/common.bpf.h |   18 +--
 tools/sched_ext/include/scx/compat.bpf.h |  117 +++++++++++++++++++---
 tools/sched_ext/scx_central.bpf.c        |   14 +-
 tools/sched_ext/scx_flatcg.bpf.c         |   20 ++-
 tools/sched_ext/scx_qmap.bpf.c           |   36 +++---
 tools/sched_ext/scx_simple.bpf.c         |   16 +--
 8 files changed, 348 insertions(+), 187 deletions(-)

--
tejun

[v2] http://lkml.kernel.org/r/20241109194853.580310-1-tj@kernel.org

