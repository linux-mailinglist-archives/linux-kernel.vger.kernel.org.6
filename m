Return-Path: <linux-kernel+bounces-314474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845896B3D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC1E1C21689
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD2E17BEB6;
	Wed,  4 Sep 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5vwlHa1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D336B17A59D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437008; cv=none; b=Bzhf7VYsMAZXGtFlqRyTUeO/XzgCQP/vluN3DytRBtn3h7H/kCV0fOD38qQerGjIjFuxqV9La7OJuyL5tc2TizuPHaf7jKtbgNwoA8BYqicQ7aAi+rHZoCqp5n+P8L3I6PYjvoVkbEro6wTHk6/kqbaRPwBgOc9YQZmsGLsLOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437008; c=relaxed/simple;
	bh=zoG4gwZKxa9IcTIDQ2bRGpQGdu2Rp/LcfLYrYz79lRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODySyUHAJ92DMdUUvz0U2Ch1P6oZY3Q2dzPVmzcGGbtBVI79BoA+vQHQ8+ywkQjZReb9JpGcEzzGHqd+7cfPraMs1HvkaPmHuXIIYuIk6ie8pV7XKBBfRlDuAegA+7b0eBSNLWQlQkH6cmVQ4e3k6Djb7L+nhwguZKoiZVkX2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5vwlHa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB0CC4CEC2;
	Wed,  4 Sep 2024 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725437008;
	bh=zoG4gwZKxa9IcTIDQ2bRGpQGdu2Rp/LcfLYrYz79lRY=;
	h=From:To:Cc:Subject:Date:From;
	b=b5vwlHa1IH8GMQornzrpyviBtWeteWkzkBi6u1QznZHuW8GJeXHU/fnvnfOvOxcPY
	 YMv4jqsGWWZtQfVL1koKRlMM8W3fQCpcInuEQfnc+ldKUeo8T/JSlwjCH3BA/YlQ2U
	 rfM/KRB0FyPr03QVb/GJhDfyPLNW18KTffHH+UJbrcgUfbkWD8/qPhuVWApJpzJ9Uq
	 AQjQybivlsUVK3VnL57O0LPzKFTG5gBs89ubZw+th0LfZ7WGnpf5jtbpMsgMFd2mcz
	 1LhHZKnM8+Vy4VWKPRH9AvLblE/Chp/Ot+E68r24gDWcMuXTEgSuQfHX+aruA5I4DM
	 7OLyl+Tuiz/KQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org
Subject: [PATCHSET sched_ext/for-6.12] sched_ext: Apply pick_next_task() updates and remove switch_class()
Date: Tue,  3 Sep 2024 22:03:02 -1000
Message-ID: <20240904080326.1132275-1-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

d7b01aef9dbd ("Merge branch 'tip/sched/core' into for-6.12") received sched
core udpates around pick_next_task() and put_prev_task(). While the merge
commit added a minimal workaround to keep sched_ext building and mostly
functioning, sched_ext is currently out of step with other sched classes.

This patchset brings sched_ext upto the code by replacing
pick_next_task_scx() with pick_task_scx() which doesn't require the current
task to be queued and can detemrine between the current task and the top of
the local DSQ statelessly. This allows unifying regular and core-sched pick
task paths. After the updates, sched_class->switch_class() is no longer used
and dropped.

This change causes two subtle API changes for the BPF schedulers. Both are
desirable and all the existing schedulers should be okay with them.

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-pick_task

and contains the following patches:

 0001-sched_ext-Don-t-call-put_prev_task_scx-before-pickin.patch
 0002-sched_ext-Replace-SCX_TASK_BAL_KEEP-with-SCX_RQ_BAL_.patch
 0003-sched_ext-Unify-regular-and-core-sched-pick-task-pat.patch
 0004-sched_ext-Relocate-functions-in-kernel-sched-ext.c.patch
 0005-sched_ext-Remove-switch_class_scx.patch
 0006-sched_ext-Remove-sched_class-switch_class.patch

diffstat follows. Thanks.

 include/linux/sched/ext.h      |    1
 kernel/sched/core.c            |   12 --
 kernel/sched/ext.c             |  359 +++++++++++++++++++++++++--------------------------------------
 kernel/sched/sched.h           |    3
 tools/sched_ext/scx_qmap.bpf.c |   22 +++
 5 files changed, 167 insertions(+), 230 deletions(-)
 

