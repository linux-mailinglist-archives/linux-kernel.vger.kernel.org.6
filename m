Return-Path: <linux-kernel+bounces-544796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65EA4E545
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E487617EF52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF17929B23B;
	Tue,  4 Mar 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQWJldIB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675929B233
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103339; cv=none; b=SB0bgYmnuZczbpU/iLkTE0uB3GzqQGb3NAd8/DaAPWH3Tddq8GzJXJ+eGXPUcbWFl7wkT6KIt9kJGUufT/BheGzY28saCT3K48qldkzGvx39UplPBrs5ZtS9FR4Jsom6jS1f6bLDGGTLnHG3Lh97wLRw57kCvWqoMr6cgh5mrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103339; c=relaxed/simple;
	bh=dw8sEl2iAUusAQx2/EQ2Dr12Ywx9+wtrOTt5qTJottQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSjDphUZYB+EIxBdqB8Yf7KP3INefdaWratD4IpOyyH1TnPSdwGVQQ6i/iMQHqxz1/Igr4TysZNgaWzaDqVfDumy3SNNFKcyT877v9qOuvMDfL7it+TJu1avmpQh9jSJC5fBrI1pz0ilEIu0b4pXihtj5zu4rVtPBWOcALTAsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQWJldIB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p2Pxjq3EDch+A/Cg612+l2rXRgJSHzOfWsjrEl5gKfw=;
	b=iQWJldIBRpUaaz9+JXD+CJ+42TjfDgt57y+Bm3JWI6aa/iO1Qiv77bXrhkyYIOn82jBWdr
	lBsJmBfYbcVfEgMFIvycz2L7Oc65VzZqD2wc1SZZ56b1KeGvnHKRp5lq8KLRQyKhYwjdCT
	Oxipxwtf5aIQ+342s4egrNoxRY6PIZY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-6VANsIEtNkqd8HnY9DYa3g-1; Tue, 04 Mar 2025 10:48:50 -0500
X-MC-Unique: 6VANsIEtNkqd8HnY9DYa3g-1
X-Mimecast-MFC-AGG-ID: 6VANsIEtNkqd8HnY9DYa3g_1741103329
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43942e82719so42452945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103329; x=1741708129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2Pxjq3EDch+A/Cg612+l2rXRgJSHzOfWsjrEl5gKfw=;
        b=Gp7GvXtGziRS+JvLhkCfWyg/g4HCHRNX4TGlMMe9kgijnnZvE4MQtfD5BcDEzDBFBK
         NZakKchsfHYKPS+Y6sGvEgJiIuXVOL4N3xSfKlJNJKdxFva0QM46alnRjE2lJKRvH0Mz
         b4/EoVQ8U/2RKw91rS5pO2jIrAS5lwoUoVLpkQ/Mp9AYsTKEIiyMg+Sk+3QBWqCAsrxZ
         eVPPhN0z12juSGvefpI6whV303O217b3ryf9pMLJ5NGV1lKr8WcmKblw+C3MTQw5PSv3
         GdkOw6em/zxgSgV6uLLyGwSzPkFJP7tLlVGnKp6/C6uUpNyA4CEqIYbxRbKIzJI5DiOi
         jmIQ==
X-Gm-Message-State: AOJu0YyfTFfXE/563eQ9L8ATt2A8bbfJ+O4S+u+arcl8SLxczfjpJHLN
	vcBl0qhvstPv4WONuvLpQySo32DNzlpFWi9EvrsUUa7lNF8TxD9U3MuCegKFq+Y+5Wd5T1xIPCF
	fbi5lontoKMg0i5Xdlh6H5ZPgrUaE9UoZReQz7GQVyXVfLjOhfpaA+EoQV77FINueevQ3wjqyOd
	vGwl+1uV3fq667BgFMGL+6BB9clqa66rlBbpMwNrCvO4Hm
X-Gm-Gg: ASbGncuaPth97nEK0vbtXVaVTENekcWjRRSm8gY24B7uIBKLy0Iaehs3Ct6DzB4B6Cl
	cE5trjNjhr9O49WmlLi63r0Vh8kDYCzCsbPhE5vb7wp6FvRAoF8fRppjZwIyA/oE7jsZLZJbTF2
	k7fd8RxvvEUqBYH+UFfakgqbLthzexAs+NBYPGcDK0eQidM1oQdiby76YPkQ2pDPBIeV//YbdpL
	0mCIZaAGRP1knSXM1i3OD4v4VBtH1tTkpG0S0kkfNGaFpK0CxB6d7X+ay/B8hoboL2pneBA9R8+
	rcOXwBunREtcf+8PE8mz2/uLSZ0p3ZZpH6byrlfCtCW1gPtbb4YRnI+k9JOlYHvhDLUYUGllcow
	2
X-Received: by 2002:a05:600c:1ca3:b0:439:985b:17d6 with SMTP id 5b1f17b1804b1-43ba6a84156mr139615255e9.27.1741103329064;
        Tue, 04 Mar 2025 07:48:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjd2+i+XCDKVaF6WffRx7pSoxLHgB+maZpDEGPGTkxHNk1T3itxVJ3f3AFoBMJYSPfmfvO7g==
X-Received: by 2002:a05:600c:1ca3:b0:439:985b:17d6 with SMTP id 5b1f17b1804b1-43ba6a84156mr139614845e9.27.1741103328593;
        Tue, 04 Mar 2025 07:48:48 -0800 (PST)
Received: from localhost (p200300cbc73610009e302a8acd3d419c.dip0.t-ipconnect.de. [2003:cb:c736:1000:9e30:2a8a:cd3d:419c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47a7868sm17932287f8f.24.2025.03.04.07.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:48:48 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v1 0/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
Date: Tue,  4 Mar 2025 16:48:43 +0100
Message-ID: <20250304154846.1937958-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on -next, because a related fix [1] is not in mm.git. This is
the follow-up to [2] (later than I wanted to send it out), now that
Willy also stumbled over this [3].

Since the RFC, I rewrote it once again, now using a folio_walk instead of
our old pagewalk infrastructure.


Currently, uprobe_write_opcode() implements COW-breaking manually, which is
really far from ideal. Further, there is interest in supporting uprobes on
hugetlb pages [1], and leaving at least the COW-breaking to the core will
make this much easier.

Also, I think the current code doesn't really handle some things
properly (see patch #3) when replacing/zapping pages.

Let's rewrite it, to leave COW-breaking to the fault handler, and handle
registration/unregistration by temporarily unmapping the anonymous page,
modifying it, and mapping it again. We still have to implement
zapping of anonymous pages ourselves, unfortunately.

We could look into not performing the temporary unmapping if we can
perform the write atomically, which would likely also make adding hugetlb
support a lot easier. But, limited (e.g., only PMD/PUD) hugetlb support
could be added on top of this with some tweaking.

Note that we now won't have to allocate another anonymous folio when
unregistering (which will be beneficial for hugetlb as well), we can simply
modify the already-mapped one from the registration (if any). When
registering a uprobe, we'll first trigger a ptrace-like write fault to
break COW, to then modify the already-mapped page.

Briefly sanity tested with perf:
  [root@localhost ~]# perf probe -x /usr/bin/bash -a main
  ...
  [root@localhost ~]# perf record -e probe_bash:main -aR sleep 10 &
  [1] 2196
  [root@localhost ~]# bash
  [root@localhost ~]# exit
  exit
  [root@localhost ~]# bash
  [root@localhost ~]# exit
  exit
  [root@localhost ~]# [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.287 MB perf.data (8 samples) ]
  ...
  [root@localhost ~]# perf report --stdio
  # To display the perf.data header info, please use --header/--header-only optio>
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 8  of event 'probe_bash:main'
  # Event count (approx.): 8
  #
  # Overhead  Command      Shared Object  Symbol
  # ........  ...........  .............  ........
  #
      75.00%  grepconf.sh  bash           [.] main
      25.00%  bash         bash           [.] main
  ...

Are there any uprobe tests / benchmarks that are worth running?

RFC -> v1:
* Use folio_walk and simplify the logic

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>

[1] https://lkml.kernel.org/r/20250224031149.1598949-1-tongtiangen@huawei.com
[2] https://lore.kernel.org/linux-mm/20240604122548.359952-2-david@redhat.com/T/
[3] https://lore.kernel.org/all/d7971673-19ed-448a-9e54-8ffbde5059dc@redhat.com/T/
[4] https://lkml.kernel.org/r/ZiK50qob9yl5e0Xz@bender.morinfr.org

David Hildenbrand (3):
  kernel/events/uprobes: pass VMA instead of MM to remove_breakpoint()
  kernel/events/uprobes: pass VMA to set_swbp(), set_orig_insn() and
    uprobe_write_opcode()
  kernel/events/uprobes: uprobe_write_opcode() rewrite

 arch/arm/probes/uprobes/core.c |   4 +-
 include/linux/uprobes.h        |   6 +-
 kernel/events/uprobes.c        | 363 +++++++++++++++++----------------
 3 files changed, 190 insertions(+), 183 deletions(-)


base-commit: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
-- 
2.48.1


