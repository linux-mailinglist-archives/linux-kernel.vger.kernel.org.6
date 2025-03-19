Return-Path: <linux-kernel+bounces-567306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ADDA68464
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03030883188
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81B24E4DA;
	Wed, 19 Mar 2025 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UupmbRXr"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE787210184
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360867; cv=none; b=iusqUy3qz2+YW4oE8oecVL+LsBlSEbQXvqOFzE66Fy26w9sxH67PxdIXVgKn7AZd9OYB4eWKIaQSlTeTSioWWZ7e3HwaCWp4ySwEfGJ02qMUE2wO0BzEtHYq1jfZwhDAPYmD0jW1oDASTT3kJXLjugjt5DQDH2VSjgICqO7gH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360867; c=relaxed/simple;
	bh=LVrkZCk8PeAM02oA7w5ePjw3QNnDFsD/h2JODIu0B1E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Tx0Qm/M3ReFEP1ACRy95pu5GxDFwuSjiymcruEjnoOvRHBzdsdXTwHuiSMBBvt6yJPFBb76R43bziMshfPGadBU3CZhKh0nq48e19NAtdabtbMKHNphGmqj9b9b849Y9T9R0V5pM0f7HmYOcDPgi0QSB9dL/P9CLUrCB7xdKEes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UupmbRXr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5789a8458eso8668143276.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742360865; x=1742965665; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eNtYmofX3K48v9+AGNAWv8ZUFVTmB3LX6qkU47Fxf4Y=;
        b=UupmbRXrEeVOq0qSy3FtqjA6lv4DqVjVjimv6bbbUvaiw2P/2dwEaupqdPF4AV6kWV
         RSlZcUECssK5bPHRUY+FXGrTq27KNOHdzb93GX4z8S0NY0vWQ91OdLWDP6fEm3ZzaIra
         vYMtpbkLvisjrOhHKov5SlesWgQgP3opgYI27ID5PmfzkntWmD62fo4klT5tVaep8z4d
         kStMmOQPtEFI5xKArJybHUHoUGQd6irmc+xsPtbX9gMFmuaIFkqZXycag9dJGwfVldUX
         qLuvG+7kT/HWyEFQOy5A8xmPIOpxOvtxHU2WE5aCVUHrlJUPJTEyqbiev/KaL0BqdyTH
         5/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360865; x=1742965665;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNtYmofX3K48v9+AGNAWv8ZUFVTmB3LX6qkU47Fxf4Y=;
        b=QEecMyav3F9c66t3cIa4mSMt62OwRaFSnPVbas4Om434N1+MnqL6P5Kth++6ksNmYF
         C0GNfbKk3BgW52zgPqmW1NF6G7rfq2ARfBgnWp+U8O2cHkkgDGI2b5BDkE03Cxre13rX
         WPUiMcC7TNp7wEtwiyREpIz6ymhVUF9r9668wAwG6RQkYfllWPT8wopigU45e+TcuHX8
         fIlDuNisf0CYNzdogacQk/0dvzcQttBZe2r7EnBKoMZc6CN5opzbf1OXzRMEQJ+PocEC
         gdNqJ9zh4Pw3kvkayXo2HpEm0DsXRft5pBHEyhhu3++fsOqlTQSRIojqFBaEJBKh3vak
         4PMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUwJN6LseeZ8Up0+NqczMxKlQAJlBW1wGW6ht73HQr6DmCM9UXm30+SfLKSjhmxqdscmMvTIqKK4s823U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZORmOQiWb7rsjRk49qVj9+upKw4NF2U3mA/TMvpSzb7JUQ+nd
	xtOERcEO0I/ccXB9O1C/exYOHYBdXEqQAqSoJtdVW2cKar3FzVHaXZ24ft1/bEYnUkrn7428DXe
	fSDUJNQ==
X-Google-Smtp-Source: AGHT+IGtpPuFltr/p+kdPTp/+U20Cs8VXoC5JAcFj/P4uwgj6DWWoUWkCHY+B2XS9Ko2a3d4z9Cm3Vt2RGN7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8a11:10b5:af90:6031])
 (user=irogers job=sendgmr) by 2002:a25:6b0e:0:b0:e5d:bd8b:4223 with SMTP id
 3f1490d57ef6-e667b3a1d44mr965276.1.1742360864085; Tue, 18 Mar 2025 22:07:44
 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:07:27 -0700
Message-Id: <20250319050741.269828-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v7 00/14] perf: Support multiple system call tables in the build
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

This work builds on the clean up of system call tables and removal of
libaudit by Charlie Jenkins <charlie@rivosinc.com>.

The system call table in perf trace is used to map system call numbers
to names and vice versa. Prior to these changes, a single table
matching the perf binary's build was present. The table would be
incorrect if tracing say a 32-bit binary from a 64-bit version of
perf, the names and numbers wouldn't match.

Change the build so that a single system call file is built and the
potentially multiple tables are identifiable from the ELF machine type
of the process being examined. To determine the ELF machine type, the
executable's maps are searched and the associated DSOs ELF headers are
read. When this fails and when live, /proc/pid/exe's ELF header is
read. Fallback to using the perf's binary type when unknown.

Remove some runtime types used by the system call tables and make
equivalents generated at build time.

v7: Rebase for dso data locking changes. Don't NULL check before
    btf__free (Arnaldo). Add patch to clean up perf trace's evlist to
    make leak sanitizer happier.

v6: Incorporate Namhyung's fixes:
    https://lore.kernel.org/lkml/Z9PCjQ8PhOadVGQ8@google.com/
    https://lore.kernel.org/lkml/Z9YHCzINiu4uBQ8B@google.com/
    Which highlighted an issue with syscall pointers becoming
    stale. Add a patch 12 to make the syscall table a table of
    pointers that don't move so that struct syscalls don't move. Add a
    patch 13 fixing a BTF memory leak.

v5: Add byte swap to dso__e_machine and fix comment as suggested by
    Namhyung.

v4: Add reading the e_machine from the thread's maps dsos, only read
    from /proc/pid/exe on failure and when live as requested by
    Namhyung. Add patches to add dso comments and remove unused
    dso_data variables that are unused without libunwind.

v3: Add Charlie's reviewed-by tags. Incorporate feedback from Arnd
    Bergmann <arnd@arndb.de> on additional optional column and MIPS
    system call numbering. Rebase past Namhyung's global system call
    statistics and add comments that they don't yet support an
    e_machine other than EM_HOST.

v2: Change the 1 element cache for the last table as suggested by
    Howard Chu, add Howard's reviewed-by tags.
    Add a comment and apology to Charlie for not doing better in
    guiding:
    https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5b304e408e11@rivosinc.com/
    After discussion on v1 and he agreed this patch series would be
    the better direction.

Ian Rogers (14):
  perf dso: Move libunwind dso_data variables into ifdef
  perf dso: kernel-doc for enum dso_binary_type
  perf syscalltbl: Remove syscall_table.h
  perf trace: Reorganize syscalls
  perf syscalltbl: Remove struct syscalltbl
  perf dso: Add support for reading the e_machine type for a dso
  perf thread: Add support for reading the e_machine type for a thread
  perf trace beauty: Add syscalltbl.sh generating all system call tables
  perf syscalltbl: Use lookup table containing multiple architectures
  perf build: Remove Makefile.syscalls
  perf syscalltbl: Mask off ABI type for MIPS system calls
  perf trace: Make syscall table stable
  perf trace: Fix BTF memory leak
  perf trace: Fix evlist memory leak

 tools/perf/Makefile.perf                      |  10 +-
 tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
 .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
 tools/perf/arch/alpha/include/syscall_table.h |   2 -
 tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
 .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
 tools/perf/arch/arc/include/syscall_table.h   |   2 -
 tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
 .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
 tools/perf/arch/arm/include/syscall_table.h   |   2 -
 tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
 .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
 tools/perf/arch/arm64/include/syscall_table.h |   8 -
 tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
 .../csky/entry/syscalls/Makefile.syscalls     |   3 -
 tools/perf/arch/csky/include/syscall_table.h  |   2 -
 .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
 .../entry/syscalls/Makefile.syscalls          |   3 -
 .../arch/loongarch/include/syscall_table.h    |   2 -
 tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
 .../mips/entry/syscalls/Makefile.syscalls     |   5 -
 tools/perf/arch/mips/include/syscall_table.h  |   2 -
 tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
 .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
 .../perf/arch/parisc/include/syscall_table.h  |   8 -
 tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
 .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
 .../perf/arch/powerpc/include/syscall_table.h |   8 -
 tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
 .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
 tools/perf/arch/riscv/include/syscall_table.h |   8 -
 tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
 .../s390/entry/syscalls/Makefile.syscalls     |   5 -
 tools/perf/arch/s390/include/syscall_table.h  |   2 -
 tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
 .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
 tools/perf/arch/sh/include/syscall_table.h    |   2 -
 tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
 .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
 tools/perf/arch/sparc/include/syscall_table.h |   8 -
 tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
 .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
 tools/perf/arch/x86/include/syscall_table.h   |   8 -
 tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
 .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
 .../perf/arch/xtensa/include/syscall_table.h  |   2 -
 tools/perf/builtin-trace.c                    | 339 ++++++++++++------
 tools/perf/scripts/Makefile.syscalls          |  61 ----
 tools/perf/scripts/syscalltbl.sh              |  86 -----
 tools/perf/trace/beauty/syscalltbl.sh         | 274 ++++++++++++++
 tools/perf/util/dso.c                         |  89 +++++
 tools/perf/util/dso.h                         |  62 ++++
 tools/perf/util/symbol-elf.c                  |  27 --
 tools/perf/util/syscalltbl.c                  | 148 ++++----
 tools/perf/util/syscalltbl.h                  |  22 +-
 tools/perf/util/thread.c                      |  80 +++++
 tools/perf/util/thread.h                      |  14 +-
 57 files changed, 839 insertions(+), 543 deletions(-)
 delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
 delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
 delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
 delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
 delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
 delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
 delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
 delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
 delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
 delete mode 100644 tools/perf/scripts/Makefile.syscalls
 delete mode 100755 tools/perf/scripts/syscalltbl.sh
 create mode 100755 tools/perf/trace/beauty/syscalltbl.sh

-- 
2.49.0.rc1.451.g8f38331e32-goog


