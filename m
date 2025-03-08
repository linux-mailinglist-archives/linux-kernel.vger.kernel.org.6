Return-Path: <linux-kernel+bounces-552205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DD8A576EB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8141889586
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68F815442C;
	Sat,  8 Mar 2025 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yRYsntJv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D77F1494A3
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741393953; cv=none; b=CXn4WFtBGOlAQeDZ6ckChPbs72v+GGkWUwCCbAsejwKtWQwo3z1KI6HaAYglxm+3CCGnasN6MylAME5cZAyl4K5MveFJ8QkGOxXC2d6gGCV0tk0BEQLH4UV9HVX/3UpsyHDlscRqEthJC0HTMPwKsE9BMHaSsMXUD7NEZEyv1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741393953; c=relaxed/simple;
	bh=uG8R7BvGqk9Vhp7zhRA/OxtARIz2pOPtth17cmzcr4Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ELbkXGZp+GFnYEyOX1MrQF/h24yLvumJnJhpBR8yqNNJ994J9pgtoEF7eX9S0Q0cV9V3tnR8L/eFA2bJNwHFNs08XzQmB3aAxUULFPLCJeih/1ox5VmJC2rK6i1qJ3qsRKD32IQDjLA4FPu1+pslKA0dSkwaCaqChRPLK6Y6SCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yRYsntJv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e60c24d9fe8so3515881276.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 16:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741393951; x=1741998751; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlFNebLAKQij87xZRU0DCWeRHfkQPLeMoGP6veDBAZ4=;
        b=yRYsntJv7P/shTlidxEaWhSCF4nYeTCBC9XLqIpnovo9HCYoq9Nr2YXFi9vSSoA1QS
         e5GEtFFonVG2L4xCd/E9cmx0snUxUOgHNHSr1vyjO6MVGgVcma2hiOvT2foybkPpHm8h
         wH6a5sAJ8VZ3WRcpvwUIVZgBkVzrYA9Ocqk2cRxpGT6Va+3cESAmXegqJp5CKWlUICTd
         LHCThYUB//93C2QzvZ0vQomO/vr8zYaaSOJz/AXAWtuuYYEI9ZaWhyJRCirHOezfq6fz
         9D93a92LrPU3J42ZjOVRehlHXE11iM16Tni9JXidmHX924owiU12jLRWkzr0I/n4idbx
         lqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741393951; x=1741998751;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlFNebLAKQij87xZRU0DCWeRHfkQPLeMoGP6veDBAZ4=;
        b=CCPxYGatI554lGnvy1zdy9JaesE8y5eMOvieFyoGnllKO7TVywHAHzocB/S1NsdClB
         30VgR3ucBeLrOoDFs6WRIZCY0FTG1xByUvu3BdIdQf3ND9IyUWrIc70Zxtf0RcJTxxc0
         JQZ/tH6Nmjuxy2Fiaka7cwEL4L0iWOkIkY+j1jv+0u672GuUDoLrpXk62X7ZIPMT5QRW
         OKWnPSAIkOd/vBmRyHsHQ1Y2ONcFiLR///YNN485e8JGfBaoZZKCjYSLe76ynGURUtec
         s5qwzN68ZYoQQ4LpbfmEbtT/ONAKqZ062iS0AcxYxFUDdd49pBN3OWodibf0WzaHP3B2
         PlTw==
X-Forwarded-Encrypted: i=1; AJvYcCUVkJejFIIVEdSML/j191GLei4b4NP6Ub4us0/lXCXxuxWzwiTrrp8GdhxcKNGx0JKZfFYWpveFsOZOMK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPyvxWEBMQBo/g58waLCCEmZekcOK420KwDCILkLRHLk+Oq7R
	oXgrUz2QTjeZBvWwwp70YE5k5eNDbWhiaQbf9AGh7WFbmJniZuHpzYQlZKwgkPkHlaqAHOfgzj4
	+19scUw==
X-Google-Smtp-Source: AGHT+IHB3W/KXCJ++szfS/DeXeYW9m1CyGOsczkykOR5iqkmjGU1F7EbbOZWJrjep+YhntQrISyp3G+pnOEo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:1541:e490:aa80:5766])
 (user=irogers job=sendgmr) by 2002:a25:ce94:0:b0:e57:3500:2294 with SMTP id
 3f1490d57ef6-e635c16822cmr44477276.3.1741393950820; Fri, 07 Mar 2025 16:32:30
 -0800 (PST)
Date: Fri,  7 Mar 2025 16:32:06 -0800
In-Reply-To: <20250308003209.234114-1-irogers@google.com>
Message-Id: <20250308003209.234114-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308003209.234114-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v5 08/11] perf trace beauty: Add syscalltbl.sh generating all
 system call tables
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

Rather than generating individual syscall header files generate a
single trace/beauty/generated/syscalltbl.c. In a syscalltbls array
have references to each architectures tables along with the
corresponding e_machine. When the 32-bit or 64-bit table is ambiguous,
match the perf binary's type. For ARM32 don't use the arm64 32-bit
table which is smaller. EM_NONE is present for is no machine matches.

Conditionally compile the tables, only having the appropriate 32 and
64-bit table. If ALL_SYSCALLTBL is defined all tables can be
compiled.

Add comment for noreturn column suggested by Arnd Bergmann:
https://lore.kernel.org/lkml/d47c35dd-9c52-48e7-a00d-135572f11fbb@app.fastmail.com/
and added in commit 9142be9e6443 ("x86/syscall: Mark exit[_group]
syscall handlers __noreturn").

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.perf              |   9 +
 tools/perf/trace/beauty/syscalltbl.sh | 274 ++++++++++++++++++++++++++
 2 files changed, 283 insertions(+)
 create mode 100755 tools/perf/trace/beauty/syscalltbl.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d0b50ccc9d7b..f949ec72f3d2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -559,6 +559,14 @@ beauty_ioctl_outdir := $(beauty_outdir)/ioctl
 # Create output directory if not already present
 $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outdir)')
 
+syscall_array := $(beauty_outdir)/syscalltbl.c
+syscall_tbl := $(srctree)/tools/perf/trace/beauty/syscalltbl.sh
+syscall_tbl_data := $(srctree)/tools/scripts/syscall.tbl \
+	$(wildcard $(srctree)/tools/perf/arch/*/entry/syscalls/syscall*.tbl)
+
+$(syscall_array): $(syscall_tbl) $(syscall_tbl_data)
+	$(Q)$(SHELL) '$(syscall_tbl)' $(srctree)/tools $@
+
 fs_at_flags_array := $(beauty_outdir)/fs_at_flags_array.c
 fs_at_flags_tbl := $(srctree)/tools/perf/trace/beauty/fs_at_flags.sh
 
@@ -878,6 +886,7 @@ build-dir   = $(or $(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders \
 	arm64-sysreg-defs \
+	$(syscall_array) \
 	$(fs_at_flags_array) \
 	$(clone_flags_array) \
 	$(drm_ioctl_array) \
diff --git a/tools/perf/trace/beauty/syscalltbl.sh b/tools/perf/trace/beauty/syscalltbl.sh
new file mode 100755
index 000000000000..1199618dc178
--- /dev/null
+++ b/tools/perf/trace/beauty/syscalltbl.sh
@@ -0,0 +1,274 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate all syscall tables.
+#
+# Each line of the syscall table should have the following format:
+#
+# NR ABI NAME [NATIVE] [COMPAT [noreturn]]
+#
+# NR       syscall number
+# ABI      ABI name
+# NAME     syscall name
+# NATIVE   native entry point (optional)
+# COMPAT   compat entry point (optional)
+# noreturn system call doesn't return (optional)
+set -e
+
+usage() {
+       cat >&2 <<EOF
+usage: $0 <TOOLS DIRECTORY> <OUTFILE>
+
+  <TOOLS DIRECTORY>    path to kernel tools directory
+  <OUTFILE>            output header file
+EOF
+       exit 1
+}
+
+if [ $# -ne 2 ]; then
+       usage
+fi
+tools_dir=$1
+outfile=$2
+
+build_tables() {
+	infile="$1"
+	outfile="$2"
+	abis=$(echo "($3)" | tr ',' '|')
+	e_machine="$4"
+
+	if [ ! -f "$infile" ]
+	then
+		echo "Missing file $infile"
+		exit 1
+	fi
+	sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
+	grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | sort -n > "$sorted_table"
+
+	echo "static const char *const syscall_num_to_name_${e_machine}[] = {" >> "$outfile"
+	# the params are: nr abi name entry compat
+	# use _ for intentionally unused variables according to SC2034
+	while read -r nr _ name _ _; do
+		echo "	[$nr] = \"$name\"," >> "$outfile"
+	done < "$sorted_table"
+	echo "};" >> "$outfile"
+
+	echo "static const uint16_t syscall_sorted_names_${e_machine}[] = {" >> "$outfile"
+
+	# When sorting by name, add a suffix of 0s upto 20 characters so that
+	# system calls that differ with a numerical suffix don't sort before
+	# those without. This default behavior of sort differs from that of
+	# strcmp used at runtime. Use sed to strip the trailing 0s suffix
+	# afterwards.
+	grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | awk '{printf $3; for (i = length($3); i < 20; i++) { printf "0"; }; print " " $1}'| sort | sed 's/\([a-zA-Z1-9]\+\)0\+ \([0-9]\+\)/\1 \2/' > "$sorted_table"
+	while read -r name nr; do
+		echo "	$nr,	/* $name */" >> "$outfile"
+	done < "$sorted_table"
+	echo "};" >> "$outfile"
+
+	rm -f "$sorted_table"
+}
+
+rm -f "$outfile"
+cat >> "$outfile" <<EOF
+#include <elf.h>
+#include <stdint.h>
+#include <asm/bitsperlong.h>
+#include <linux/kernel.h>
+
+struct syscalltbl {
+       const char *const *num_to_name;
+       const uint16_t *sorted_names;
+       uint16_t e_machine;
+       uint16_t num_to_name_len;
+       uint16_t sorted_names_len;
+};
+
+#if defined(ALL_SYSCALLTBL) || defined(__alpha__)
+EOF
+build_tables "$tools_dir/perf/arch/alpha/entry/syscalls/syscall.tbl" "$outfile" common,64 EM_ALPHA
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__alpha__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__arm__) || defined(__aarch64__)
+EOF
+build_tables "$tools_dir/perf/arch/arm/entry/syscalls/syscall.tbl" "$outfile" common,32,oabi EM_ARM
+build_tables "$tools_dir/perf/arch/arm64/entry/syscalls/syscall_64.tbl" "$outfile" common,64,renameat,rlimit,memfd_secret EM_AARCH64
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__arm__) || defined(__aarch64__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__csky__)
+EOF
+build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32,csky,time32,stat64,rlimit EM_CSKY
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__csky__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__mips__)
+EOF
+build_tables "$tools_dir/perf/arch/mips/entry/syscalls/syscall_n64.tbl" "$outfile" common,64,n64 EM_MIPS
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__mips__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__hppa__)
+#if __BITS_PER_LONG != 64
+EOF
+build_tables "$tools_dir/perf/arch/parisc/entry/syscalls/syscall.tbl" "$outfile" common,32 EM_PARISC
+echo "#else" >> "$outfile"
+build_tables "$tools_dir/perf/arch/parisc/entry/syscalls/syscall.tbl" "$outfile" common,64 EM_PARISC
+cat >> "$outfile" <<EOF
+#endif //__BITS_PER_LONG != 64
+#endif // defined(ALL_SYSCALLTBL) || defined(__hppa__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__powerpc__) || defined(__powerpc64__)
+EOF
+build_tables "$tools_dir/perf/arch/powerpc/entry/syscalls/syscall.tbl" "$outfile" common,32,nospu EM_PPC
+build_tables "$tools_dir/perf/arch/powerpc/entry/syscalls/syscall.tbl" "$outfile" common,64,nospu EM_PPC64
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__powerpc__) || defined(__powerpc64__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__riscv)
+#if __BITS_PER_LONG != 64
+EOF
+build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32,riscv,memfd_secret EM_RISCV
+echo "#else" >> "$outfile"
+build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,64,riscv,rlimit,memfd_secret EM_RISCV
+cat >> "$outfile" <<EOF
+#endif //__BITS_PER_LONG != 64
+#endif // defined(ALL_SYSCALLTBL) || defined(__riscv)
+#if defined(ALL_SYSCALLTBL) || defined(__s390x__)
+EOF
+build_tables "$tools_dir/perf/arch/s390/entry/syscalls/syscall.tbl" "$outfile" common,64,renameat,rlimit,memfd_secret EM_S390
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__s390x__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__sh__)
+EOF
+build_tables "$tools_dir/perf/arch/sh/entry/syscalls/syscall.tbl" "$outfile" common,32 EM_SH
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__sh__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__sparc64__) || defined(__sparc__)
+#if __BITS_PER_LONG != 64
+EOF
+build_tables "$tools_dir/perf/arch/sparc/entry/syscalls/syscall.tbl" "$outfile" common,32 EM_SPARC
+echo "#else" >> "$outfile"
+build_tables "$tools_dir/perf/arch/sparc/entry/syscalls/syscall.tbl" "$outfile" common,64 EM_SPARC
+cat >> "$outfile" <<EOF
+#endif //__BITS_PER_LONG != 64
+#endif // defined(ALL_SYSCALLTBL) || defined(__sparc64__) || defined(__sparc__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__i386__) || defined(__x86_64__)
+EOF
+build_tables "$tools_dir/perf/arch/x86/entry/syscalls/syscall_32.tbl" "$outfile" common,32,i386 EM_386
+build_tables "$tools_dir/perf/arch/x86/entry/syscalls/syscall_64.tbl" "$outfile" common,64 EM_X86_64
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__i386__) || defined(__x86_64__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__xtensa__)
+EOF
+build_tables "$tools_dir/perf/arch/xtensa/entry/syscalls/syscall.tbl" "$outfile" common,32 EM_XTENSA
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__xtensa__)
+
+#if __BITS_PER_LONG != 64
+EOF
+build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32 EM_NONE
+echo "#else" >> "$outfile"
+build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,64 EM_NONE
+echo "#endif //__BITS_PER_LONG != 64" >> "$outfile"
+
+build_outer_table() {
+       e_machine=$1
+       outfile="$2"
+       cat >> "$outfile" <<EOF
+       {
+	      .num_to_name = syscall_num_to_name_$e_machine,
+	      .sorted_names = syscall_sorted_names_$e_machine,
+	      .e_machine = $e_machine,
+	      .num_to_name_len = ARRAY_SIZE(syscall_num_to_name_$e_machine),
+	      .sorted_names_len = ARRAY_SIZE(syscall_sorted_names_$e_machine),
+       },
+EOF
+}
+
+cat >> "$outfile" <<EOF
+static const struct syscalltbl syscalltbls[] = {
+#if defined(ALL_SYSCALLTBL) || defined(__alpha__)
+EOF
+build_outer_table EM_ALPHA "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__alpha__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__arm__) || defined(__aarch64__)
+EOF
+build_outer_table EM_ARM "$outfile"
+build_outer_table EM_AARCH64 "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__arm__) || defined(__aarch64__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__csky__)
+EOF
+build_outer_table EM_CSKY "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__csky__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__mips__)
+EOF
+build_outer_table EM_MIPS "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__mips__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__hppa__)
+EOF
+build_outer_table EM_PARISC "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__hppa__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__powerpc__) || defined(__powerpc64__)
+EOF
+build_outer_table EM_PPC "$outfile"
+build_outer_table EM_PPC64 "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__powerpc__) || defined(__powerpc64__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__riscv)
+EOF
+build_outer_table EM_RISCV "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__riscv)
+
+#if defined(ALL_SYSCALLTBL) || defined(__s390x__)
+EOF
+build_outer_table EM_S390 "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__s390x__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__sh__)
+EOF
+build_outer_table EM_SH "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__sh__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__sparc64__) || defined(__sparc__)
+EOF
+build_outer_table EM_SPARC "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__sparc64__) || defined(__sparc__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__i386__) || defined(__x86_64__)
+EOF
+build_outer_table EM_386 "$outfile"
+build_outer_table EM_X86_64 "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__i386__) || defined(__x86_64__)
+
+#if defined(ALL_SYSCALLTBL) || defined(__xtensa__)
+EOF
+build_outer_table EM_XTENSA "$outfile"
+cat >> "$outfile" <<EOF
+#endif // defined(ALL_SYSCALLTBL) || defined(__xtensa__)
+EOF
+build_outer_table EM_NONE "$outfile"
+cat >> "$outfile" <<EOF
+};
+EOF
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


