Return-Path: <linux-kernel+bounces-538501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B2A49971
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861083B7703
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2057826B970;
	Fri, 28 Feb 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BhH+2Oww"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1926B2A9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746169; cv=none; b=ZEPdmOyDBu37R+sXSncMTfIxWDt6CWkwNX4lvT+KyfIt3DcbS5JMySRwoTQuN7I0kcoL26QLe8T/loDsVi5PSZNdTNCoAZUHpEURcyoLe0Ek/3TEYAL3Z6R21IfRkMRX+YCxaRQLwbDevMyRbEXawZRrqxRdkPwyOVpUhtnKZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746169; c=relaxed/simple;
	bh=wqfpViftRXFo0yIzjPKdTRnmgFn+vPNeSi1IWa2AEO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9MXH83H4b/vgQtaeVxx2d4vK2x/BSvKrVIx8UBCXjhtgBpGnxzifJLNa88y/NTc82QKvos8UO8ie0kndgEh3MXPuvarTimLY8ODQt8KpXmTFrM9ayOJwWcoMDbgZ/yk8jxeViECb2oAwxKgFC2gYSgAfH6/AtuXSsEnWHX+uqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BhH+2Oww; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso3655761a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740746165; x=1741350965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4BRVcVlmrp47N8mDLSs1UXLB3XHPD0CyzYo4hVKAt8=;
        b=BhH+2Owwp2+EQUOiMWqj67gZaUXp8zBWBVuPvfF3UEXZG6W263ZT/z0ZfACQ7ekcr/
         nIy+bfyd0cRqm5I7czr5LKk1Snc76u0yLMjLeC5LUFCwKPLFLqkwj6HfO5bSyl4nad/d
         8QM6PKU9vwFGrDU6c5S4Amhe2zxTe+SLvy+Ssk99OFb5YBw/lLuU4l7QBHVy6a4qp0hC
         pZgX8rcxiINI8VukYL3DcngC+8RdNqXX24V7uZsz6WHRSy19szBoXqFmuE4gx4eeinAH
         GTyfl3NC90gry41HVeaKN9Yf6leJLGCWzNWWRRsXJvGuZYNEpaaFIlS88heB525P+VYq
         vWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746165; x=1741350965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4BRVcVlmrp47N8mDLSs1UXLB3XHPD0CyzYo4hVKAt8=;
        b=dMgcDg3uBdbvq/GokHbJIG6r4KuM9DJwL3IynIViQVRNUnvgGJ9cXgrRW8er6/wB1d
         MFUAnj3gYImIoXEo80iV4Jf/Ud2YeC4zRZ63FH7GGPkPNa8K72qK9XE/aV4EIabCN5Gi
         is7GFkvOejkc2erM/G/243y+rEQd1xpRYKLm2oYTqn9QZe7dQx+N1A2T1HIKPKbuPeJg
         Tlt4EmC9KXSfCLQdCdaGAN3mgZ9UcN8/gCYSK7MITitBr0zyu0jXCE/O4XQiE8t3ItOz
         nBdzOk1ws36wixsLvan8UQGyqDYcPVBBFk86YgD3I+mjJavBA5e7FDaePXXpeNGgst1D
         Suaw==
X-Forwarded-Encrypted: i=1; AJvYcCVd14CUjxO5VLIF2haG1po5mHNsGK2XsRIchQmJaGv2xb9SAtSxxoraU6TtQ6dAKP1FykuITZTTfKrdlb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8D28Vr1t/VgK/6CINt9vetmFLxAfnXyjwL0gIgHI+YAZTbJee
	i70j17MSnqAb1i3v6qm4iYk51AxDOjcgIHZNJUGvyuP0OAuhVJLBNwYjwMMVwBY=
X-Gm-Gg: ASbGncs8H6vFvshbYcS1owFDAqdDPd1vJCk8JhyzW83xEPx+yZmyZGiDvo0nlowXvW1
	smjdTb/ZhdTa/ELUzJKJ4Lvlov8m5edS3YgzXPcjNdG6CvYiN2kL3TkdGDbeoJsmAXZiVfrOQnn
	zX19eQxtFAqmmb3kUrzVyzB4vyxilNUS0jnHSk6IcDFxGhHL+WpmycrhoJd5Jq82GOQl1c9AiIB
	JyGeANepyJcBIRqAMVb/L6OSsyAPFEuXcfeYPYN+2Ey70W5JG2op02oBlKpwjdNJuPnC1GBdoBJ
	/xMQymMxQLSfSp0prbgMP6ro0MheCjWDlALz4pnVD55f2HrT0sXzzBM51lI0d1IQxXbyQSQqWYP
	Jx7S4I+WiKWhcs5YlBhdw6CNrfQ==
X-Google-Smtp-Source: AGHT+IE2GiFAgvvybx/Z0OJcY5FetkfNI3YyL4jA3FpXCLa3pK64kiuKgDkLUvKt5glk5Ln5cfEWcA==
X-Received: by 2002:a17:906:c104:b0:abe:f686:8189 with SMTP id a640c23a62f3a-abf25f900c9mr345104666b.11.1740746164792;
        Fri, 28 Feb 2025 04:36:04 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f191800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f19:1800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6cfdcsm2457279a12.29.2025.02.28.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:36:04 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/netfs/write_collect: call `invalidate_cache` only if implemented
Date: Fri, 28 Feb 2025 13:36:02 +0100
Message-ID: <20250228123602.2140459-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many filesystems such as NFS and Ceph do not implement the
`invalidate_cache` method.  On those filesystems, if writing to the
cache (`NETFS_WRITE_TO_CACHE`) fails for some reason, the kernel
crashes like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor instruction fetch in kernel mode
 #PF: error_code(0x0010) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0010 [#1] SMP PTI
 CPU: 9 UID: 0 PID: 3380 Comm: kworker/u193:11 Not tainted 6.13.3-cm4all1-hp #437
 Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/17/2018
 Workqueue: events_unbound netfs_write_collection_worker
 RIP: 0010:0x0
 Code: Unable to access opcode bytes at 0xffffffffffffffd6.
 RSP: 0018:ffff9b86e2ca7dc0 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 7fffffffffffffff
 RDX: 0000000000000001 RSI: ffff89259d576a18 RDI: ffff89259d576900
 RBP: ffff89259d5769b0 R08: ffff9b86e2ca7d28 R09: 0000000000000002
 R10: ffff89258ceaca80 R11: 0000000000000001 R12: 0000000000000020
 R13: ffff893d158b9338 R14: ffff89259d576900 R15: ffff89259d5769b0
 FS:  0000000000000000(0000) GS:ffff893c9fa40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffffffffd6 CR3: 000000054442e003 CR4: 00000000001706f0
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x15c/0x460
  ? try_to_wake_up+0x2d2/0x530
  ? exc_page_fault+0x5e/0x100
  ? asm_exc_page_fault+0x22/0x30
  netfs_write_collection_worker+0xe9f/0x12b0
  ? xs_poll_check_readable+0x3f/0x80
  ? xs_stream_data_receive_workfn+0x8d/0x110
  process_one_work+0x134/0x2d0
  worker_thread+0x299/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xba/0xe0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x30/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in:
 CR2: 0000000000000000

This patch adds the missing `NULL` check.

Fixes: 0e0f2dfe880f ("netfs: Dispatch write requests to process a writeback slice")
Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/write_collect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 294f67795f79..3fca59e6475d 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -400,7 +400,8 @@ void netfs_write_collection_worker(struct work_struct *work)
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
 	if (wreq->io_streams[1].active &&
-	    wreq->io_streams[1].failed) {
+	    wreq->io_streams[1].failed &&
+	    ictx->ops->invalidate_cache) {
 		/* Cache write failure doesn't prevent writeback completion
 		 * unless we're in disconnected mode.
 		 */
-- 
2.47.2


