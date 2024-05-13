Return-Path: <linux-kernel+bounces-178066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367148C4821
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE84B28602A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C97E586;
	Mon, 13 May 2024 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlL0hg1k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098D39FD8
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631790; cv=none; b=CFPeTpQF94Uk7ePZXQL8EVkLz6MBGv0VZxzrIO2zxt5nzz47Yny4KXxdSuG2QcXwID4X83zmK24TG7P5fyk1ADzdx7APzV0NooA4lUW9wZXZdjffB/yfXybGpIKNWQb96+GFgQPc6rcNFJnZ8uK7QPSQNKLlljKGDt1o4zsdiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631790; c=relaxed/simple;
	bh=tBSYnu5biyde4hqLVYn3ls3kd9uKB5Ztz4K0820Afa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hJ/fxDDM5+tF1k61G0TJXmbIWit9TtAYlSEAKL2AyC4vsd9uYz+IIDrKR/S+Ue/Xm4bS5EVLTOtpD9WtVE0omMYwgbf9Yku0+ICHDUJDRowe6fPl37ZykIC843b0y/z1DhERa2ZRCG51vcYQs06Yu6sk9D9lGX+kxtaTPGznWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlL0hg1k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715631787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=zazRLk250icH6gao5umBljLSGbvI08NgBOyVu2Bgi7M=;
	b=XlL0hg1kwNV+znwr6LPVeEDVOLP/VxBLeiLfpr9VxVki6PC76UR4XglYIjRIy8cAsQQqX1
	ZgH0UVFKV8tPWdf703BjQhVCkY0exG2gkkxrUe1r6fHbvanvVKDUqaixmjNDgeiJ9ccoGP
	aB+ayd5HbWPH/yOWczOKhLhLqM+VnBg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-eCfgjyoWMsWAI1KVm28ZjQ-1; Mon,
 13 May 2024 16:17:04 -0400
X-MC-Unique: eCfgjyoWMsWAI1KVm28ZjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A53213C025D3;
	Mon, 13 May 2024 20:17:03 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.125])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 62AD5C15BB9;
	Mon, 13 May 2024 20:17:03 +0000 (UTC)
Date: Mon, 13 May 2024 15:17:01 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.10
Message-ID: <ZkJ1PTW7V25ePbLF@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.10

This set includes some small fixes, and some big internal changes:

- Fix a long standing race between the unlock callback for the last lkb
struct, and removing the rsb that became unused after the final unlock.
This could lead different nodes to inconsistent info about the rsb master
node.

- Remove unnecessary refcounting on callback structs, returning to the way
things were done in the past.

- Do message processing in softirq context.  This allows dlm messages to
be cleared more quickly and efficiently, reducing long lists of incomplete
requests.  A future change to run callbacks directly from this context
will make this more effective.

- The softirq message processing involved a number of patches changing
mutexes to spinlocks and rwlocks, and a fair amount of code re-org in
preparation.

- Use an rhashtable for rsb structs, rather than our old internal hash
table implementation.  This also required some re-org of lists and locks
preparation for the change.

- Drop the dlm_scand kthread, and use timers to clear unused rsb structs.
Scanning all rsb's periodically was a lot of wasted work.

- Fix recent regression in logic for copying LVB data in user space lock
requests.

Thanks,
Dave


Alexander Aring (32):
      dlm: fix user space lock decision to copy lvb
      dlm: remove lkb from callback tracepoints
      dlm: remove callback queue debugfs functionality
      dlm: save callback debug info earlier
      dlm: combine switch case fail and default statements
      dlm: fix race between final callback and remove
      dlm: remove callback reference counting
      dlm: remove allocation parameter in msg allocation
      dlm: switch to GFP_ATOMIC in dlm allocations
      dlm: move root_list functionality to recover.c
      dlm: use a new list for recovery of master rsb names
      dlm: move rsb root_list to ls_recover() stack
      dlm: add new struct to save position in dlm_copy_master_names
      dlm: drop mutex use in waiters recovery
      dlm: convert ls_waiters_mutex to spinlock
      dlm: convert res_lock to spinlock
      dlm: avoid blocking receive at the end of recovery
      dlm: convert ls_recv_active from rw_semaphore to rwlock
      dlm: remove schedule in receive path
      dlm: use spin_lock_bh for message processing
      dlm: do message processing in softirq context
      dlm: increment ls_count for dlm_scand
      dlm: change to single hashtable lock
      dlm: merge toss and keep hash table lists into one list
      dlm: add rsb lists for iteration
      dlm: switch to use rhashtable for rsbs
      dlm: do not use ref counts for rsb in the toss state
      dlm: drop dlm_scand kthread and use timers
      dlm: use rwlock for rsb hash table
      dlm: use rwlock for lkbidr
      dlm: fix sleep in atomic context
      dlm: return -ENOMEM if ls_recover_buf fails

Kunwu Chan (2):
      dlm: Simplify the allocation of slab caches in dlm_midcomms_cache_create
      dlm: Simplify the allocation of slab caches in dlm_lowcomms_msg_cache_create


 fs/dlm/ast.c               |  216 ++++-----
 fs/dlm/ast.h               |   13 +-
 fs/dlm/config.c            |    8 +
 fs/dlm/config.h            |    2 +
 fs/dlm/debug_fs.c          |  323 +++-----------
 fs/dlm/dir.c               |  157 +++++--
 fs/dlm/dir.h               |    3 +-
 fs/dlm/dlm_internal.h      |  129 +++---
 fs/dlm/lock.c              | 1068 +++++++++++++++++++++++++-------------------
 fs/dlm/lock.h              |   12 +-
 fs/dlm/lockspace.c         |  212 +++------
 fs/dlm/lowcomms.c          |   62 +--
 fs/dlm/lowcomms.h          |    5 +-
 fs/dlm/member.c            |   25 +-
 fs/dlm/memory.c            |   18 +-
 fs/dlm/memory.h            |    4 +-
 fs/dlm/midcomms.c          |   67 ++-
 fs/dlm/midcomms.h          |    3 +-
 fs/dlm/rcom.c              |   33 +-
 fs/dlm/recover.c           |  149 ++----
 fs/dlm/recover.h           |   10 +-
 fs/dlm/recoverd.c          |  142 ++++--
 fs/dlm/requestqueue.c      |   43 +-
 fs/dlm/user.c              |  135 ++----
 include/trace/events/dlm.h |   46 +-
 25 files changed, 1379 insertions(+), 1506 deletions(-)


