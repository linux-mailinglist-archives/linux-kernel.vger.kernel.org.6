Return-Path: <linux-kernel+bounces-180443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A900E8C6EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B8B1F2359A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369D415CD64;
	Wed, 15 May 2024 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVFw0aQ6"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0AD15B984
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811990; cv=none; b=jL7/vrkhORd04w0T0BE7vqxeQunsl4zFGbr0g34O/PQwiXC7DyfVRKEIDQBKSZn4mqtMc7GLy46vC7zqvRl7HhZxYU+WqdF8lIJeLPzn0oQyh9eATNgqd0klzlrgYxzglCycjBIrsapWXr407On47T5WqhvEkabs9iUT+S5YEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811990; c=relaxed/simple;
	bh=TP/SI1Z3IMQeBYzt1FZgt6R/EbEEezNqne0V5r8B8kY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A8/1sjxGJAdnZL+IOHYk9nF9YCs0gvMSJ017ZNq/20iAOEI2zoWGXqLH5RdodYNQDaYSRu0m76kb59Vn5r8cABQKkL4TZTaIkFA0TdY44FXjmXhRY60fL+e4gGJICJCZahjOfwEUqaV5AGSVWfiU/h+efuaPKtMnCpxwgBBCgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVFw0aQ6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f4603237e0so5212143b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715811988; x=1716416788; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SEXyadok7oYz3M0F8f+ttHUWcZRgCNOPQWqJevF7qJo=;
        b=VVFw0aQ6j3+KCUFaH1Pt6tV/7RC5Sp+nUitatBAjDTsOXIkZy7mgPlJw/ppgqrREqJ
         lb7KVzYqmjOu65EoQ5gjdu7mjgq46Oc0AAYFjn4fwCavhzM16WnmY0PB7NIcBT+GxdJq
         KHaPuza0/SPfWJSPl8NYXj62h5BeYT0s689Kz4xnSRJk9+jz71cxBLdaWMhycOdc+7tK
         g35wPV3bkCGkUWFd+my8TXWwhQQTPV4dTwpwZ5ni9s1vZguKEVzGNiXP7H5tS4Y6mMB9
         NJpkMDgKnVrQnduHpuYPysbrr+N9qRrMTymDkNVdKavPi/OcxTlZw2llPsySxplcm0HU
         uslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715811988; x=1716416788;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEXyadok7oYz3M0F8f+ttHUWcZRgCNOPQWqJevF7qJo=;
        b=sqpvsoQ05Ao5F9QLhL2BPQoG8vzEjEgBu0u7QnR32habdusDZO6QlN0gAk82rWGPdi
         olxT55vg19lK76UGyk+5eELyxO6jQLQOFfRn/8qH+rZGAK7lB8Tz+ED2OliVy3mHaDSq
         46etc/I1/LQotJYDVylSH/eJpQ5Q5gDYlmkiHG5POyvOK7zkd3DOWEHLJgA82Lc9p5Ua
         ZG6ngbXPoy/PgdVhxafirIlIR6gq836CKxxZk+nK+brjAMurKHgj6MG70vjNTDMuiMQw
         HRyBXEYhQ6dhO2QLkveqwYPdFCS0gHdcDxgSjRzsd0C5xWCF0gSI1voeU2uADAuKEeQ4
         M0+Q==
X-Gm-Message-State: AOJu0Yyb2n8qTMKdysSphE2Rq2AzWcgGcxXUWPNi4Wq/r/x44L/XU+xW
	/n0iOlkchYud4xxzmQlh1d5Yf3Q2aM5J1CzCi+Yo9tzwbwmkp4jA
X-Google-Smtp-Source: AGHT+IH0ZOtMkrZ2HBmba30S/5ACVkKhrgZ08lFf2UfWDDGPnEqahiJ+KJE80Q3YLbnwSgAwi5P7zQ==
X-Received: by 2002:a05:6a00:3d49:b0:6f3:e9bc:cc3d with SMTP id d2e1a72fcca58-6f4c90905a1mr30173539b3a.3.1715811988055;
        Wed, 15 May 2024 15:26:28 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f676522744sm1894911b3a.118.2024.05.15.15.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 15:26:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 May 2024 12:26:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Changes for v6.10
Message-ID: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8c06da67d0bd3139a97f301b4aa9c482b9d4f29e:

  Merge tag 'livepatching-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching (2024-05-15 13:07:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10

for you to fetch changes up to a2a58909cfb5fd5e9f7bb7d954eec0a32fee3f1f:

  Merge branch 'for-6.10' into test-merge-for-6.10 (2024-05-15 11:40:33 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.10

- Work items can now be disabled and enabled, and cancel_work_sync() and
  disable_work() can be called form atomic contexts for BH work items. This
  closes feature gap with tasklet and should allow converting all existing
  tasklet users to BH workqueues.

- Improve pool sharing for unbound workqueues with strict affinity.

- Misc changes including doc updates, improved debug annotations and
  cleanups.

----------------------------------------------------------------
Allen Pais (1):
      workqueue: Introduce enable_and_queue_work() convenience function

Dan Williams (1):
      workqueue: Cleanup subsys attribute registration

Kassey Li (1):
      workqueue: add function in event of workqueue_activate_work

Kemeng Shi (1):
      workqueue: remove unnecessary import and function in wq_monitor.py

Lai Jiangshan (3):
      workqueue: Use INIT_WORK_ONSTACK in workqueue_softirq_dead()
      workqueue: Move attrs->cpumask out of worker_pool's properties when attrs->affn_strict
      workqueue: Use list_last_entry() to get the last idle worker

Tejun Heo (7):
      workqueue: Preserve OFFQ bits in cancel[_sync] paths
      workqueue: Implement disable/enable for (delayed) work items
      workqueue: Remove WORK_OFFQ_CANCELING
      workqueue: Remember whether a work item was on a BH workqueue
      workqueue: Allow cancel_work_sync() and disable_work() from atomic contexts on BH work items
      workqueue: Use "@..." in function comment to describe variable length argument
      Merge branch 'for-6.10' into test-merge-for-6.10

Zqiang (1):
      workqueue: Add destroy_work_on_stack() in workqueue_softirq_dead()

 include/linux/workqueue.h        |  54 ++++-
 include/trace/events/workqueue.h |   4 +-
 kernel/workqueue.c               | 453 ++++++++++++++++++++++++---------------
 tools/workqueue/wq_monitor.py    |   9 +-
 4 files changed, 327 insertions(+), 193 deletions(-)

-- 
tejun

