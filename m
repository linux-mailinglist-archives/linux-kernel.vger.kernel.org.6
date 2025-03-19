Return-Path: <linux-kernel+bounces-567314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D6A68474
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6806619C799D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DCB2512D4;
	Wed, 19 Mar 2025 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nP7ak2op"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D907250BF3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360887; cv=none; b=snpCKVgaL+HJq0yOQsuldH3EYAorlHKSfoPpImmuZWZfINBXa+CwU8qRQ4+vJmptMIoZzFotTzKxiYdn1DsHT18N8UpZTgXsV1yiW0buSZt1kT13plJLqM4p6MBm8T+e/8aFJ+FWa+6V1A6y2I0ZjpixPR+sNOSkU7iAi88fzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360887; c=relaxed/simple;
	bh=qA+1rn0lTZtkVVRz5dknjvMwBYG3fjJF4hzraRMd7UE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Z5995HK5TkahS3WCjFa3gfvGyUY3fZz0NAoQOUHe8ZcRxVqnNjLkRa4OglEXYJXSV8RXi2IdG0G+po9K6e378diA9u6nTB1KINxnnzu1IgDp9Wn1v2gjRW0Sw7OMntFf+Z8rlalneJAWrahlKPi9bNWFbxq/Qt/1QfKxADLMkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nP7ak2op; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fee461837cso90901947b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742360884; x=1742965684; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZEvb9rP0/Ou5uZ1kbtDkT305lhnhit7GPgOKo0wTf8=;
        b=nP7ak2opSR/uLfDv3WZR8xnsN18SPU8zt2vVSRtjf4eKFxokjbEiCkith3VG/6cyC1
         CPCIs81EwkQDcYiS9tPeNtqu9ee9YHs/LxnI8szdvD6IW10FYRn7Sdii+9ICwKpY5WTw
         IiZjKTf+aMW2SyNDcJ5UHYC8X0FRjiRyTWJ7drEqigeHO9t5fqKPxyxVogkgT5Vr3+QA
         RfPXSyK9hmg6ElD7/CiBQtyWg46r6X5TAY2wcJCmHjWRabYFtVhZuXiHa0grvf4VeW4i
         5Qx5Tpas0xDgqZTfT55A1aAq8zVYrU4d4ho/Gp8dnNiYKZTS/isOU8JOvCbGh64D6dMC
         GJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360884; x=1742965684;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZEvb9rP0/Ou5uZ1kbtDkT305lhnhit7GPgOKo0wTf8=;
        b=aQa+d5pjbbO4bOyChGfy2JKbFln/iVYLQxWTOwsKukNei2mddLgImWkfY0n3XjplZ3
         8cNYgXq1EEEZzu6WRTsN6oWiLKrLc4bMHgljrkckOMKaUw4Ch1b9Bzr1Ldd3n/S4B6zC
         /jfiHDPpmYg3chtrNNArjb5ps9H4beuqBdikUOjNBURqCwXQsGzHlCnbG7XWAk90wUDK
         Bro5FL0IXOD6OI8bSjVSgxU0iO/XjNUBAQsKguDbBxibswiGvd0Wj3O0WXkQDvecvFfj
         iWts8O/RztKNOhnaqpVnaApHBDRhkLdcNmOJPL12qslnQ2q0ms3VcmmXskTAXCMG62jA
         ML+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjR9SOBIBMvL8LFX8RMC5VD3KF4FeoPjwVRBB+cG2bipVHaLLyNfCSbg7bcR/yhH4PHwSWLZYGYTkHY7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxms//CEnGCGQeCqnRDKWB6qICC4y2MD2CRw+AiH2n7fNzShnZU
	b2auxFiLxKrmjsqPIw/Bz9Gq1uDP2WTp+/zmHtWFl4heP1GJ9vX4tqXSZIM1y4rCSQAR6FDdvDd
	59RTXLQ==
X-Google-Smtp-Source: AGHT+IGc44u77yeoblmfKZi4hDIZy66Uo8gfvsW5pGD8d9f86tnE8cBwkN363tZeQaj9WwaYrjUTVN2252xA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8a11:10b5:af90:6031])
 (user=irogers job=sendgmr) by 2002:a0d:c985:0:b0:6fd:41f6:62cb with SMTP id
 00721157ae682-7009c027877mr5907b3.4.1742360884046; Tue, 18 Mar 2025 22:08:04
 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:07:35 -0700
In-Reply-To: <20250319050741.269828-1-irogers@google.com>
Message-Id: <20250319050741.269828-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319050741.269828-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v7 08/14] perf trace beauty: Add syscalltbl.sh generating all
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
2.49.0.rc1.451.g8f38331e32-goog


