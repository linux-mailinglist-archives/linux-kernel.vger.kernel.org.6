Return-Path: <linux-kernel+bounces-549622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C387CA554C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42E53A46AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685825D219;
	Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65319CC0C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285104; cv=none; b=WvB5AR0YULBnO43aFT//zTApJvoBnRN+qqJ+WD74htegWjG4P8mZ8UH3qdbCqWaPR7h64LiO52ObA/w0SGMLacZ9UUNUDfcmaGJ0UqGYcF47RYD4azcyPzrKcNouIO4Lmr9Ml4JEykOZXxHoJhDibkBzq8zla0oX9oiHoCnmdHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285104; c=relaxed/simple;
	bh=nNFn6ysJn3q+8vCl5adq6RiIIyrf9UAXVPeKmhesX4k=;
	h=Message-ID:Date:From:To:Cc:Subject; b=hRNGTpPBW6hndATuEiCv6ttX7poTRwXKV4I5xDlT2L5/K2cajmRxydDL8mY1vdedIPzeYZE693Df3clMZTVVGg52qejk/8CC8KPevNXbslm+7jLiokae9PESiCyzQpi3NazVglntLYnOTZhsog8igTaZN9939SPhxkl+CNVcGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B81C4CEE0;
	Thu,  6 Mar 2025 18:18:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqFnd-00000000PF9-26Y1;
	Thu, 06 Mar 2025 13:18:25 -0500
Message-ID: <20250306181801.485766945@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 13:18:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 00/10] tools/tracing: Updates for v6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: dc4d4e7c72d17e6f6bdd9ce0d7a72a085828987f


Costa Shulyupin (1):
      rtla: Refactor save_trace_to_file

Tomas Glozar (9):
      rtla/timerlat: Unify params struct
      tools/build: Add bpftool-skeletons feature test
      rtla: Add optional dependency on BPF tooling
      rtla/timerlat: Add BPF skeleton to collect samples
      rtla/timerlat_hist: Use BPF to collect samples
      rtla/timerlat_top: Move divisor to update
      rtla/timerlat_top: Use BPF to collect samples
      rtla/timerlat: Test BPF mode
      tools/rv: Keep user LDFLAGS in build

----
 tools/build/Makefile.feature           |   3 +-
 tools/build/feature/Makefile           |   3 +
 tools/scripts/Makefile.include         |   3 +
 tools/tracing/rtla/.gitignore          |   1 +
 tools/tracing/rtla/Makefile            |  20 +-
 tools/tracing/rtla/Makefile.config     |  42 ++++
 tools/tracing/rtla/src/Build           |   1 +
 tools/tracing/rtla/src/osnoise.h       |   2 +
 tools/tracing/rtla/src/osnoise_hist.c  |   5 +-
 tools/tracing/rtla/src/osnoise_top.c   |   5 +-
 tools/tracing/rtla/src/timerlat.bpf.c  | 149 +++++++++++++
 tools/tracing/rtla/src/timerlat.h      |  54 +++++
 tools/tracing/rtla/src/timerlat_aa.c   |   2 -
 tools/tracing/rtla/src/timerlat_bpf.c  | 166 +++++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h  |  59 ++++++
 tools/tracing/rtla/src/timerlat_hist.c | 234 ++++++++++++++-------
 tools/tracing/rtla/src/timerlat_top.c  | 371 ++++++++++++++++++++++-----------
 tools/tracing/rtla/src/trace.c         |   4 +
 tools/tracing/rtla/tests/timerlat.t    |  14 ++
 tools/verification/rv/Makefile.rv      |   2 +-
 20 files changed, 932 insertions(+), 208 deletions(-)
 create mode 100644 tools/tracing/rtla/src/timerlat.bpf.c
 create mode 100644 tools/tracing/rtla/src/timerlat_bpf.c
 create mode 100644 tools/tracing/rtla/src/timerlat_bpf.h

