Return-Path: <linux-kernel+bounces-571742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0954EA6C1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91763AEFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817322DF90;
	Fri, 21 Mar 2025 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xBn1hl9c"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7E7494
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578653; cv=none; b=gnjJ/hEeBnSYyMBpbGrXcq2cboQZQ1Nujzg5W6TV1P6yBHS7V695gM64Sq5UTUfo7lqn3PkCpqTlyztaQ+/oo7R34ZHCaHoVrkNPDyB3VN6+fYQ2O4G9ZNMbMLEofgLqylRpZl1h+Vh2czkUnbmooKt3JscnMgjUO2N5cS4XZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578653; c=relaxed/simple;
	bh=lcSRLiTsitbJi6eNHXm3j6P+jlrrIyAKVa6gID04U4o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=FxUyS32b0qQHgULj+slm7hqqE6KxD17qMwl//BBLvcE/yHzAndiqgSAERPA1A1m7tra1a9Pyf9/1hNrZY2seCPqW3nxxCURdH868xkYpW0aNU6gCnpw4EjErWth8NRnYupd/jpkULwBhgtzmjc5E6xEmkenB5NSvFamgrkZP37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xBn1hl9c; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso5196848a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742578651; x=1743183451; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=new5S1nMzv3MFC9Lhvlf36S7TQeIlfuvNpqYoNp8gjU=;
        b=xBn1hl9cqLLG3MgYqETxE80BIaKAltQr6UbvZFPn1wQtEAp2JkmePB2iQyzO3mDxeH
         bwreJ4Go9bsuFIqiDZ1tDZJaJ8SFu00m9q+yw27s3kBCWY/mW65SQf56ygYBuClinhUk
         HmAD64ewIaSh0y5GReNgMUHaG8xHRRSBArAl+GT9YVEdh8yapjEngUzDFdwsWtuhy6RN
         w3s4ML5fvtZ3e8DtZbavZtLZygVD3vvRzNEe/+GPhDg7lpLDt72pk7mCP6CwHjKGjTmP
         Ojqw58eyro8Mr7+T3/TovLiCWUPt0IeNHpTcK4Ew1wqDECmwpuRG2WqARYlTPGEaGlSv
         tjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742578651; x=1743183451;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=new5S1nMzv3MFC9Lhvlf36S7TQeIlfuvNpqYoNp8gjU=;
        b=BTE63F6INimN8oTs1nAI8oS/ZPSHmwy8ZS2UrvhNleV8FVe7v+DIn4P6vOD5FJIpIW
         1G7HxTCVci0kEngxRlx+lG9s8wbCi8CY9K+YnTwRKKYF0uUReM9qUbwG0B5o3+sc7Zow
         lUUDm1TUIhuzoBsNYsmV8cMXiWInqPmr+2baZuxaG9wHS3mG49nBU8eMJMx9B1e2pfqY
         Gy4/10QsNmwrQCaXVxwcnnUBskaBxWeRr4Q3g/RKLXUTmU9hem0TwRysgg4i8a65BfJF
         ZhouNcy8Hnp3WiFROVYc27+PQA//EDegQHeUMxMQ6CRYKduDfOOgVX2HjcuPUhT4Uk1R
         o2QA==
X-Forwarded-Encrypted: i=1; AJvYcCW/C/lTXzVRpnejGEViqiiSTtaRCuxAR6okgRggGxNP0H/krPFzvFfWi08nmvswO1Oei+oAsc73M7KM4q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKqoQrBAA1kocLjh+qDdCn52+B4G1fp/2Ofgnwz8XJOIAYo1d
	ym24naulCgWfNbynt5jwliF6erUlZsrRkMk5OwX4CCxm0yMhEEOheExZuzE1VHIBdqKJiIdgHdh
	YVcvFSldNcA9YTzCD3uQBmw==
X-Google-Smtp-Source: AGHT+IGHhtTojGv8YFf90lw5A7F5CexmsTodNJrY0VjEC/J1ZIUyYROFOXLfY8osVyXkaDsh2QYRjh6elkmiFvPr+Q==
X-Received: from pjbpw8.prod.google.com ([2002:a17:90b:2788:b0:2fa:15aa:4d2b])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2743:b0:2ff:4a8d:74f8 with SMTP id 98e67ed59e1d1-3030fe721dfmr5757256a91.6.1742578650927;
 Fri, 21 Mar 2025 10:37:30 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:37:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321173729.3175898-1-souravpanda@google.com>
Subject: [RFC PATCH 0/6] Selective KSM: Synchronous and Partitioned Merging
From: Sourav Panda <souravpanda@google.com>
To: mathieu.desnoyers@efficios.com, willy@infradead.org, david@redhat.com, 
	pasha.tatashin@soleen.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, weixugc@google.com, 
	gthelen@google.com, souravpanda@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

The purpose of this RFC is to supplement our discussion in LSF/MM-25.

This is sent as a proof of concept. It applies on top of v6.14-rc7.

With the goal of increasing security and improving CPU efficiency,
we would like to propose making KSM synchronous and partitioned.

The synchronous aspect eliminates the need of ksmd running in the
background. Instead, userspace can trigger merging on the specified
memory region synchronously. Contrary to SKSM [1], which uses
MADV_MERGE, we also propose sysfs and syscall based alternatives.

The partitioned aspect divides the merge space into security domains.
Merging of pages only takes place within a partition, improving security.
Furthermore, trees in each partitioning becomes smaller, improving CPU
efficiency.

Proposal 1: SYSFS Interface

  KSM_SYSFS=/sys/kernel/mm/ksm

  echo "part_1" >  ${KSM_SYSFS}/ksm/control/add_partition

  ls ${KSM_SYSFS}/part_1/
	  pages_scanned       pages_to_scan   sleep_millisecs  ...

  echo "pid start_addr end_addr" > ${KSM_SYSFS}/part_1/trigger_merge

Proposal 2: SYSCALL Interface

  Partition can be created or opened using:

    int ksm_fd = ksm_open(ksm_name, flag);
      name specifies the ksm partition to be created or opened.
      flags:
        O_CREAT
          Create the ksm partition object if it does not exist.
        O_EXCL
          If O_CREAT was also specified, and a shared memory object
          with the given name already exists, return an error.

  Trigger the merge using:
    ksm_merge(ksm_fd, pid, start_addr, size);

[1] https://lore.kernel.org/linux-mm/20250228023043.83726-1-mathieu.desnoyers@efficios.com/

Sourav Panda (6):
  mm: introduce SELECTIVE_KSM KConfig
  mm: make Selective KSM synchronous
  mm: make Selective KSM partitioned
  mm: create dedicated trees for SELECTIVE KSM partitions
  mm: trigger unmerge and remove SELECTIVE KSM partition
  mm: syscall alternative for SELECTIVE_KSM

 arch/x86/entry/syscalls/syscall_64.tbl |   3 +-
 include/linux/ksm.h                    |   4 +
 mm/Kconfig                             |  11 +
 mm/ksm.c                               | 823 ++++++++++++++++++++++---
 4 files changed, 751 insertions(+), 90 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


