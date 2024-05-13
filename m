Return-Path: <linux-kernel+bounces-177258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9233D8C3C12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FCE281AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CF4146A89;
	Mon, 13 May 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd1GnwgK"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36263214
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585426; cv=none; b=IPhMBtX33ITuRfvVLWRKT3iV1DXjjq25AWd0ad0vCmL/x1ZVnk33MJRXS/ILEOtrfcMTy8GpYhdZ8bki7z1A6rSqpoNf3XFZmuVLS0V5A3yNUWAYpGYARyv8pqEwapg9mhgBN71frs/pcp7p/oMa5oKlF4UPg2CsTuCv2bJ7tZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585426; c=relaxed/simple;
	bh=tbIJ/6G/hAHF17FOE3UTLuF8ZGlr/OBLpMQDR/aB+A0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=baJVpDW7p83g7qV/BSgIaj5R2Pd0bkT9ukKlsJATdU5SqrDAkVxo7xzoG69uZf9DLwiJZlaSJnTm5hjIC8/qdN4Zh3IzkNPO7O/SIy+z13hX86OG0zYAcRUUc3s989WVGN5Mlty/iR9pcjKw0TrEs6Sg17Wosf7t/ruhz7G1AF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pd1GnwgK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59b58fe083so859502466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715585423; x=1716190223; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=o9PQUMcmF5US7fCsLj823TkMpdi3cNWhmj7hShrFTCo=;
        b=Pd1GnwgK4RVce8lOfOlcLEG1dtgrGs1Q8vvCoZDvTXfgOFOCmYxk4QSu3z800okKbQ
         n0Y07/0DDlp8nJjKo/xhz3Wx4GCG4MEDIV+9tK2Cel/fXXS9eArlYtJR2MtSOY0f++C+
         dz9SbQmtXBhmpO4NwJ+oAcztrNoXrm93vK92S4HC+J9D6CaZXk/0VDMrvBmmpbzlxhPl
         6n7EsqlbFM7ZFunAPoc4NKqGAtfE/zHHW7lvcM5tUywB4ry5IbhLLbJYg0sWo3YrM7Wd
         qUXyYjJau9MQrd3O5zjQOtjHRr5v2W7EqCCl4QEFQFfXIgJpj7OnjgLMlllx9Nx8Seqe
         S4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585423; x=1716190223;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9PQUMcmF5US7fCsLj823TkMpdi3cNWhmj7hShrFTCo=;
        b=vuBQ+Rfy88v6EVa0HJ03pNejGs8WiiTN9twYNeBHASNMMKRLUP3GiayKoJRpVb/WQ2
         4IdH1zug3ijhFMBmxIBKSnz9/sbKE7UAvdUeLaPI2jGm5BiOn2fipRxBFExk4MbJQoyZ
         TLAON0wqYcmQJsOJefRBHq6UzwMcM9JsV/0HWt2Jw6366iXyUgYqIelCDxDWxWRsgn2R
         fG7mzPKqEtGFWeilkL5yiMVm+HDMz9aBsJhODZSz9bqW6ceicvZZDeD/rOalBN44TPB3
         QWVoC1DszR0MzWIyViJyTXXiE+lc+TvLgooSHWERMGwDi/t6AZ7dhdBX7L4Elo/lipyA
         /Pyw==
X-Gm-Message-State: AOJu0YxkdUSRNEienHWarq/8IuZ2k/MReYjo7R9OPLf3gVGKdTnUmUZZ
	pba33+vTRSu+B90sq/P/600O1sDadzKgwVYHXTqtYtX+1r5OjdGg
X-Google-Smtp-Source: AGHT+IGQ+uvKb/Ffv005mmSE9hWwIYA79223JQ2ZsFIHMRf+iDUDfe/LU6tmtOHhSAmU/ZZWaB+SNw==
X-Received: by 2002:a17:906:eb18:b0:a59:c844:beea with SMTP id a640c23a62f3a-a5a2d676a37mr563154266b.73.1715585423031;
        Mon, 13 May 2024 00:30:23 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d553sm559143166b.43.2024.05.13.00.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:30:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 09:30:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/cpu changes for v6.10
Message-ID: <ZkHBjIwLlEkVD2Vu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/cpu Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2024-05-13

   # HEAD: 2eda374e883ad297bd9fe575a16c1dc850346075 x86/mm: Switch to new Intel CPU model defines

x86/cpu changes for v6.10:

 - Rework the x86 CPU vendor/family/model code: introduce the 'VFM'
   value that is an 8+8+8 bit concatenation of the vendor/family/model
   value, and add macros that work on VFM values. This simplifies the
   addition of new Intel models & families, and simplifies existing
   enumeration & quirk code.

 - Add support for the AMD 0x80000026 leaf, to better parse topology
   information.

 - Optimize the NUMA allocation layout of more per-CPU data structures

 - Improve the workaround for AMD erratum 1386

 - Clear TME from /proc/cpuinfo as well, when disabled by the firmware

 - Improve x86 self-tests

 - Extend the mce_record tracepoint with the ::ppin and ::microcode fields

 - Implement recovery for MCE errors in TDX/SEAM non-root mode

 - Misc cleanups and fixes

 Thanks,

	Ingo

------------------>
Avadhut Naik (2):
      tracing: Add the ::ppin field to the mce_record tracepoint
      tracing: Add the ::microcode field to the mce_record tracepoint

Bingsong Si (1):
      x86/cpu: Clear TME feature flag if TME is not enabled by BIOS

Borislav Petkov (AMD) (2):
      x86/cpu: Get rid of an unnecessary local variable in get_cpu_address_sizes()
      x86/CPU/AMD: Improve the erratum 1386 workaround

Ingo Molnar (2):
      x86/mce: Clean up TP_printk() output line of the 'mce_record' tracepoint
      x86/cpu: Improve readability of per-CPU cpumask initialization code

Li RongQing (2):
      x86/cpu: Take NUMA node into account when allocating per-CPU cpumasks
      x86/sev: Take NUMA node into account when allocating memory for per-CPU SEV data

Muhammad Usama Anjum (1):
      x86/selftests: Skip the tests if prerequisites aren't fulfilled

Rafael J. Wysocki (1):
      x86/cpu: Move leftover contents of topology.c to setup.c

Thomas Gleixner (1):
      x86/cpu/topology: Add support for the AMD 0x80000026 leaf

Tony Luck (22):
      x86/mce: Implement recovery for errors in TDX/SEAM non-root mode
      x86/cpu/vfm: Add/initialize x86_vfm field to struct cpuinfo_x86
      x86/cpu/vfm: Add new macros to work with (vendor/family/model) values
      x86/cpu/vfm: Update arch/x86/include/asm/intel-family.h
      x86/bugs: Switch to new Intel CPU model defines
      x86/bugs: Switch to new Intel CPU model defines
      perf/x86/intel/cstate: Switch to new Intel CPU model defines
      perf/x86/lbr: Switch to new Intel CPU model defines
      perf/x86/intel/pt: Switch to new Intel CPU model defines
      perf/x86/intel/uncore: Switch to new Intel CPU model defines
      perf/x86/msr: Switch to new Intel CPU model defines
      x86/apic: Switch to new Intel CPU model defines
      x86/aperfmperf: Switch to new Intel CPU model defines
      x86/cpu/intel_epb: Switch to new Intel CPU model defines
      x86/cpu: Switch to new Intel CPU model defines
      x86/mce: Switch to new Intel CPU model defines
      x86/microcode/intel: Switch to new Intel CPU model defines
      x86/resctrl: Switch to new Intel CPU model defines
      x86/cpu: Switch to new Intel CPU model defines
      x86/tsc: Switch to new Intel CPU model defines
      x86/tsc_msr: Switch to new Intel CPU model defines
      x86/mm: Switch to new Intel CPU model defines


 arch/x86/events/intel/cstate.c            | 116 ++++++++++----------
 arch/x86/events/intel/lbr.c               |   3 +-
 arch/x86/events/intel/pt.c                |  12 +--
 arch/x86/events/intel/uncore.c            | 100 ++++++++---------
 arch/x86/events/intel/uncore_nhmex.c      |   3 +-
 arch/x86/events/intel/uncore_snbep.c      |   5 +-
 arch/x86/events/msr.c                     | 116 ++++++++++----------
 arch/x86/include/asm/cpu_device_id.h      | 101 ++++++++++++++++++
 arch/x86/include/asm/intel-family.h       |  84 +++++++++++++++
 arch/x86/include/asm/mce.h                |   2 +
 arch/x86/include/asm/processor.h          |  20 +++-
 arch/x86/kernel/Makefile                  |   2 +-
 arch/x86/kernel/apic/apic.c               |  38 +++----
 arch/x86/kernel/apic/x2apic_cluster.c     |   7 +-
 arch/x86/kernel/cpu/amd.c                 |  12 +++
 arch/x86/kernel/cpu/aperfmperf.c          |  17 ++-
 arch/x86/kernel/cpu/bugs.c                |  30 +++---
 arch/x86/kernel/cpu/common.c              | 171 +++++++++++++++---------------
 arch/x86/kernel/cpu/intel.c               |   1 +
 arch/x86/kernel/cpu/intel_epb.c           |  12 +--
 arch/x86/kernel/cpu/match.c               |   5 +-
 arch/x86/kernel/cpu/mce/core.c            |  24 ++++-
 arch/x86/kernel/cpu/mce/intel.c           |  21 ++--
 arch/x86/kernel/cpu/mce/severity.c        |  26 +++--
 arch/x86/kernel/cpu/microcode/intel.c     |   5 +-
 arch/x86/kernel/cpu/resctrl/core.c        |  10 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  22 ++--
 arch/x86/kernel/cpu/topology_amd.c        |  19 ++--
 arch/x86/kernel/cpu/topology_ext.c        |  15 +++
 arch/x86/kernel/setup.c                   |   8 ++
 arch/x86/kernel/sev.c                     |   8 +-
 arch/x86/kernel/smpboot.c                 |  28 ++---
 arch/x86/kernel/topology.c                |  43 --------
 arch/x86/kernel/tsc.c                     |   6 +-
 arch/x86/kernel/tsc_msr.c                 |  14 +--
 arch/x86/mm/init.c                        |  16 ++-
 include/trace/events/mce.h                |  25 ++++-
 tools/testing/selftests/x86/amx.c         |  27 ++---
 tools/testing/selftests/x86/lam.c         |   2 +-
 39 files changed, 704 insertions(+), 472 deletions(-)
 delete mode 100644 arch/x86/kernel/topology.c

