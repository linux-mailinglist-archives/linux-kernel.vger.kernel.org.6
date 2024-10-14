Return-Path: <linux-kernel+bounces-364718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF60199D852
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E92E282F41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CDD1D0E3E;
	Mon, 14 Oct 2024 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJzXr075"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A8142E77
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938213; cv=none; b=SOq42fZVon9TM0zkcbxrt0DfxHRr9QWKxZHd23tA9DSLVZJD9sYS5+/59Zu/8sjwlgVxU9Tm2w10qovSgnvxII0tIjPsRsa9959hsngpGBZGpfaVJfdm/uSpaKu5c1XJKCYsS3OaMOnpuQQBTOlAAKy6yOMqFt2tmyuH3OuehHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938213; c=relaxed/simple;
	bh=xJ/v4s7s3xrJf+yfwz41O5wWjkT4j0ZpikrCmhZpXG4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LvMBsi7XD4DL0gCFywARwyj3FrxlcYA2coiKlzSML/t5rz7OxDu0OyHnA2SNmb9g4fiP/kMmgHfbSpRcckTbKzf887qjxWh+E6i3RFf+pbh40ZBXyhKsa2R+xuiwM+QU9UZ2cUKg9/3ONT2mhXFksilVGb9ZumlpG4CUH7DlMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJzXr075; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2605ce4276so8170584276.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728938210; x=1729543010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4U5CVtkJEYe6S9rzoTpLNep+Y3sHiaJ7kUZVFdWaC+c=;
        b=WJzXr075w9nlzZkSFLVeG9ZIejkXi+JZ7XhZUlY614mCaH0zs3s2IeJrBE4IaVYUQo
         0khLk0GYUv67/en3mCAKvSMw0Dv1Qz95KK9WvNSNZ3aJ0tDyclO396C3ypMcX3c5JW9b
         jrjCafkxDs892dOx0rDHzdkea7mo5m9eldGpnvj0nrt+f8J/4nA+s2GMsbBsadsS9ymF
         IqfoXnZWiPCoEYq/K4WmZcpYErOTeIKOcmlB95RlIDX+/FxymNKCMjxqKioHuajj9L0V
         9q/OeDiRytzQoReyTeR1TFg430ETYGz7Ud2Yo8XTiQEfq8i5EhxkI8xbfxNRmyHRBBBh
         j/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938210; x=1729543010;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4U5CVtkJEYe6S9rzoTpLNep+Y3sHiaJ7kUZVFdWaC+c=;
        b=Hz9K/hzCLUD18MRelKndAs3R9OiXx+aOktf1T0bi1srhs8uoq7L+0RJnOfGCkUGwcf
         w/gZITCGFm07Q0487RdObbrwnuOdcK5G1X8rKZ8dAERReW/Nnx7CiGPwmRfi7fA62axt
         E4v2WtTRAEHJfewLZZIZFhYMCLERRfVkvphlEMc6LQIIqlek+SEdLqA4panV1k0V9HP4
         pvtWisGL74vutQHGBC4dTQx7duMiYfWNlq3vBPWbKL0yx8ZHJfJ+if2gy2ZZE635M5G9
         weiK4VvTQiDtUpg/i7XD/T29s8x05Pw+7hR9ALQYjAqoiIAsNun+CiUhZEHV23pmmWC+
         WzXA==
X-Forwarded-Encrypted: i=1; AJvYcCWIYAoSeULQ/IGqUNmfjySDdixvAhmisg9O7/3+voSK/wqwqt00YQtw4rNGNqG49q5iuzh1/YVinuOqRmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8pT+k5HK2Urqk81NzsGmkGnHCyWk7MDYSZz65PdpE1oBupLQz
	bo7Fce0bQa/F359ZnbAFNXsLG+4WvbAYeVdu3tsLuRYxxzTCofeuIQ15+ApvK+F4Cv97qYUHK/r
	CEw==
X-Google-Smtp-Source: AGHT+IH6bves0lxiwLGhNCCSLFxMFIA4Y1dq4YMuUh/nUpGxr/Xuzy4ZC8csJ8diCdDybxEmCtvJmFEe0+k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:915:bdd7:e08a:7997])
 (user=surenb job=sendgmr) by 2002:a25:c593:0:b0:e28:ede2:d060 with SMTP id
 3f1490d57ef6-e2919dd2c51mr8678276.4.1728938210069; Mon, 14 Oct 2024 13:36:50
 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:36:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014203646.1952505-1-surenb@google.com>
Subject: [PATCH v3 0/5] page allocation tag compression
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

This patchset implements several improvements:
1. Gracefully handles module unloading while there are used allocations
allocated from that module;
2. Provides an option to store page allocation tag references in the
page flags, removing dependency on page extensions and eliminating the
memory overhead from storing page allocation references (~0.2% of total
system memory). This also improves page allocation performance when
CONFIG_MEM_ALLOC_PROFILING is enabled by eliminating page extension
lookup. Page allocation performance overhead is reduced from 41% to 5.5%.

Patch #1 introduces mas_for_each_rev() helper function.

Patch #2 copies module tags into virtually contiguous memory which
serves two purposes:
- Lets us deal with the situation when module is unloaded while there
are still live allocations from that module. Since we are using a copy
version of the tags we can safely unload the module. Space and gaps in
this contiguous memory are managed using a maple tree.
- Enables simple indexing of the tags in the later patches.

Patch #3 changes the way we allocate virtually contiguous memory for
module tags to reserve only vitrual area and populate physical pages
only as needed at module load time.

Patch #4 abstracts page allocation tag reference to simplify later
changes.

Patch #5 adds a config to store page allocation tag references inside
page flags if they fit. If the number of available page flag bits is
insufficient to address all kernel allocations, profiling falls back
to using page extensions with an appropriate warning.

Patchset applies to mm-unstable.

Changes since v2 [1]:
- removed extra configs, leaving only CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
yes/no option, per Andrew Morton
- populate physical memory for module tags only as needed,
per Pasha Tatashin

[1] https://lore.kernel.org/all/20240902044128.664075-1-surenb@google.com/

Suren Baghdasaryan (5):
  maple_tree: add mas_for_each_rev() helper
  alloc_tag: load module tags into separate contiguous memory
  alloc_tag: populate memory for module tags as needed
  alloc_tag: introduce pgalloc_tag_ref to abstract page tag references
  alloc_tag: config to store page allocation tag refs in page flags

 include/asm-generic/codetag.lds.h |  19 ++
 include/linux/alloc_tag.h         |  21 +-
 include/linux/codetag.h           |  40 ++-
 include/linux/execmem.h           |  11 +
 include/linux/maple_tree.h        |  14 ++
 include/linux/mm.h                |  25 +-
 include/linux/page-flags-layout.h |   7 +
 include/linux/pgalloc_tag.h       | 278 ++++++++++++++++++---
 include/linux/vmalloc.h           |   9 +
 kernel/module/main.c              |  74 ++++--
 lib/Kconfig.debug                 |  19 ++
 lib/alloc_tag.c                   | 394 ++++++++++++++++++++++++++++--
 lib/codetag.c                     | 104 +++++++-
 mm/execmem.c                      |  16 ++
 mm/mm_init.c                      |   5 +-
 mm/vmalloc.c                      |   4 +-
 scripts/module.lds.S              |   5 +-
 17 files changed, 931 insertions(+), 114 deletions(-)


base-commit: 828d7267c42c2aab3877c08b4bb00b1e56769557
-- 
2.47.0.rc1.288.g06298d1525-goog


