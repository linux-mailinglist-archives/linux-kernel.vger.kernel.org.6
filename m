Return-Path: <linux-kernel+bounces-402996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796FC9C2F61
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB407B21718
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC7A19FA92;
	Sat,  9 Nov 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smoR2klc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B81E4BE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181737; cv=none; b=pNJs4M/GRZ9CXkggeyM1vD+3ZnvC48eV3coZa5/Ybq8O3DCrfD1YDCtFBt1F6HfzLoFRt4QNhuZ//gZdUJVvtd85pwAcUukdVYRnRsGdlhnJxU7ASgXj7PdAcMnfFgtbnqIyEck0tsyNb6M8fMGkdzqig99pFHT1mvagqnJaiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181737; c=relaxed/simple;
	bh=3vOgG1sTL0IL/ZMrJ8Zj3VCNp8VLU9sV2t1fp0BvTuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8anxIKbeyvfj9kuzvKXXPyYDCWb0UhyqP1shgm0pSEIi2kc5ol0EYySPyL2a9sykHUh23eTYsz67PmIiBe++RM17EL2iOu6A/d7T8oaYS266Ch/9rq99UQuX9jnITrk70HR+g23lxb+0UGi+pLWcUcq9GdqK9vgv2IztQns4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smoR2klc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB5DC4CECE;
	Sat,  9 Nov 2024 19:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731181736;
	bh=3vOgG1sTL0IL/ZMrJ8Zj3VCNp8VLU9sV2t1fp0BvTuU=;
	h=From:To:Cc:Subject:Date:From;
	b=smoR2klcWyVjw3Yw8ggjOQl0+AagShBmPPK1ywNvWQq3Dzqn+AG02lxX8oXbSelnW
	 N9xRNhNV7GwiT3RRJxhO8yLFEcOt/v+fn5CQTx977yM830gY27cJir/yhf0iK2CNKE
	 iNpQRyj11l4BFI4Nb11S6jSRTD92P7JaTB92L1zDqm+Y3o3w6C1hLIhyBQ5oePy4KS
	 9e0RJIpkvvEAx5GNeR7/f+cY7qRO102i0f/BJL+/XWEhxmCQre66WAIkBLQk11eJpN
	 +Epux9QAEEQac3H9Rv/Utime2LBiFEPbT9MW3zVwdZaVsO75WY0mLRJrTPXk8Nc1BN
	 mVo8rWuwAMTkQ==
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
Date: Sat,  9 Nov 2024 09:48:29 -1000
Message-ID: <20241109194853.580310-1-tj@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-api-rename-dispatch

diffstat follows. Thanks.

 kernel/sched/ext.c                       |  238 +++++++++++++++++++++++++++++++++--------------------
 tools/sched_ext/include/scx/common.bpf.h |   18 ++--
 tools/sched_ext/include/scx/compat.bpf.h |  117 +++++++++++++++++++++++---
 tools/sched_ext/scx_central.bpf.c        |   14 +--
 tools/sched_ext/scx_flatcg.bpf.c         |   20 ++--
 tools/sched_ext/scx_qmap.bpf.c           |   36 ++++----
 tools/sched_ext/scx_simple.bpf.c         |   16 +--
 7 files changed, 308 insertions(+), 151 deletions(-)

--
tejun

