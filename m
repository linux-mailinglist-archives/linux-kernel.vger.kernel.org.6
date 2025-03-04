Return-Path: <linux-kernel+bounces-543206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDCBA4D2C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0290C18934B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC04B1F4CA2;
	Tue,  4 Mar 2025 05:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2vKsbtf"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E891F4735
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064686; cv=none; b=UHCP4sMYktUP5TDbh9s78yetsSObdtnt/LYePekYGtkvjnl8tCUZ8BT5wKVFTqegY/aBmsRlnKBL1LfkfwSBIuz/ukMl5wH5uucIIDKhLn6zm5B4/4ls6vABc+kdwTSw9X4a348TzS5KODJi8TO/ACUdpp+uaXHNwObHQrS4Fow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064686; c=relaxed/simple;
	bh=8etfIw6PKvCiWaWxHY61qgwHyVVXRZ70EeeYpv4Nq0o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NQ3zGM1yCO4UxQ6VdZqr6dbbn+OKGLgVD6IUv4coycC2mrIrytuhV4R1KFCXkiwiB8xY46J3EoL0mFyXymuGHXvbQ9etCaqPQ7aIFTWxhbTkhiLVMZh4tGw+VFpKwVFFmXA8DkFNj3eeqZUtzeFXa/2NXIXKgyyiuuNvwaf7vjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2vKsbtf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e582bfcada6so8898268276.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064683; x=1741669483; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOLo3ff4tsSmGxvkqov67GLLuAc6G77T9V0c5aNAOI0=;
        b=a2vKsbtfpXM+dOgcnRbR4pfOQi/97AsQ9rnfF6B6lwwG2elwpwGMxUTva3J7kNA+Ru
         6NAnlxlKW0/mA/u3v5zXABTD0rKlAjxt7lf2c1zRd41fV29dzC91bx1isTXRiHUptKxi
         nmXjrdluHG70ANmRjM0WqaXxdE6e3PV1u0pxbX1RRz/jTHTl5SAs9IldH7no2yOAumsn
         UcUaNsfTgpj/LVUVrJW0Ox05/b1sU4NJwi6pPQIlZOX6YEvdY5oYeQ8SQivV5OhHywG5
         QHVKT7tzulzE7L7x/u/5Z0hVog4S4xOxi7Z90PFzC4jBddHjPoCoPoJ106jVuM+ScxP4
         pGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064683; x=1741669483;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zOLo3ff4tsSmGxvkqov67GLLuAc6G77T9V0c5aNAOI0=;
        b=Ig0gAiri1GaLcyfxGpRt1Wy84ZyW5WSW6F4Oa5FA6wNBlM8/LnIIRP6QqbHOwQ5kHA
         H+uMkGWMnXP8Okhuntxrf3YH2DWYNPVKs1/ir0D7hF6dom7Af8E+DRrNEzzSDC3B5+1H
         E419O9t7NquaH+oT5WVLk9HGVh4f0QPbidgIciQnM1OUUJFt2EEYeQlFGNlDeQPlbBJj
         3Oi+vF0QnEt0Y7/GYLDLr9Dg64BsyA8BfQcEN4DY+7J0zzzW5TYWvyRD8plxyl8azgbL
         luHEG2Xo+/NnazU9XRUlih/M/eFRD0HDWDUbuzaaWF79Fx32n0LE3wpmCYP8XGLE8cye
         JqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJwGrgDnITxGF3+K9y2JtJBdFrlBZQMqJ/4tqbI72wzkXsjhjwZ98/Z9Vvi7p2aj8vk46uuESwK7Z6oIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmtTXVmsJjI9mibnFdrAOcFuKqR4gDV9/7j+WbqHsc36xfLia
	WuGD23tyEMYmAnraRdjtI+Yno4Qe86nfbNVHCUDpK0jEkJ2Je5uqhRuRmuEMwP/7/sDGx8T9ops
	wiMd0Ag==
X-Google-Smtp-Source: AGHT+IHDpQzFmEeksdtLyg6Z1FH7mwoupzV8v5kd9qFbwdPXjK/L//92Jc4K6SpsjhnXX9GqOGYKZRpXl0at
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a25:b20e:0:b0:e5b:423e:4757 with SMTP id
 3f1490d57ef6-e60b2f37f2bmr1979128276.4.1741064682500; Mon, 03 Mar 2025
 21:04:42 -0800 (PST)
Date: Mon,  3 Mar 2025 21:03:03 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 09/11] perf syscalltbl: Use lookup table containing
 multiple architectures
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
Content-Transfer-Encoding: quoted-printable

Switch to use the lookup table containing all architectures rather
than tables matching the perf binary.

This fixes perf trace when executed on a 32-bit i386 binary on an
x86-64 machine. Note in the following the system call names of the
32-bit i386 binary as seen by an x86-64 perf.

Before:
```
         ? (         ): a.out/447296  ... [continued]: munmap())           =
                                =3D 0
     0.024 ( 0.001 ms): a.out/447296 recvfrom(ubuf: 0x2, size: 4160585708, =
flags: DONTROUTE|CTRUNC|TRUNC|DONTWAIT|EOR|WAITALL|FIN|SYN|CONFIRM|RST|ERRQ=
UEUE|NOSIGNAL|WAITFORONE|BATCH|SOCK_DEVMEM|ZEROCOPY|FASTOPEN|CMSG_CLOEXEC|0=
x91f80000, addr: 0xe30, addr_len: 0xffce438c) =3D 1475198976
     0.042 ( 0.003 ms): a.out/447296 lgetxattr(name: "", value: 0x3, size: =
34)                             =3D 4160344064
     0.054 ( 0.003 ms): a.out/447296 dup2(oldfd: -134422744, newfd: 4)     =
                                =3D -1 ENOENT (No such file or directory)
     0.060 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: (struct io=
vec){.iov_base =3D (void *)0x2e646c2f6374652f,.iov_len =3D (__kernel_size_t=
)7307199665335594867,}, vlen: 557056, pos_h: 4160585708) =3D 3
     0.074 ( 0.004 ms): a.out/447296 lgetxattr(name: "", value: 0x1, size: =
2)                              =3D 4160237568
     0.080 ( 0.001 ms): a.out/447296 lstat(filename: "", statbuf: 0x193f6) =
                                =3D 0
     0.089 ( 0.007 ms): a.out/447296 preadv(fd: 4294967196, vec: (struct io=
vec){.iov_base =3D (void *)0x3833692f62696c2f,.iov_len =3D (__kernel_size_t=
)3276497845987585334,}, vlen: 557056, pos_h: 4160585708) =3D 3
     0.097 ( 0.002 ms): a.out/447296 close(fd: 3</proc/447296/status>)     =
                                =3D 512
     0.103 ( 0.002 ms): a.out/447296 lgetxattr(name: "", value: 0x1, size: =
2050)                           =3D 4157935616
     0.107 ( 0.007 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x5, size: 2066)             =3D 4158078976
     0.116 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x1, size: 2066)             =3D 4159639552
     0.121 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x3, size: 2066)             =3D 4160184320
     0.129 ( 0.002 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x3, size: 50)               =3D 4160196608
     0.138 ( 0.001 ms): a.out/447296 lstat(filename: "")                   =
                                =3D 0
     0.145 ( 0.002 ms): a.out/447296 mq_timedreceive(mqdes: 4291706800, u_m=
sg_ptr: 0xf7f9ea48, msg_len: 134616640, u_msg_prio: 0xf7fd7fec, u_abs_timeo=
ut: (struct __kernel_timespec){.tv_sec =3D (__kernel_time64_t)-578174027777=
317696,.tv_nsec =3D (long long int)4160349376,}) =3D 0
     0.148 ( 0.001 ms): a.out/447296 mkdirat(dfd: -134617816, pathname: " =
=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=EF=BF=BD=EF=BF=BD", mode: IFREG|ISUID|=
IRUSR|IWGRP|0xf7fd0000) =3D 447296
     0.150 ( 0.001 ms): a.out/447296 process_vm_writev(pid: -134617812, lve=
c: (struct iovec){.iov_base =3D (void *)0xf7f9e9c8f7f9e4c0,.iov_len =3D (__=
kernel_size_t)4160349376,}, liovcnt: 4160588048, rvec: (struct iovec){}, ri=
ovcnt: 4160585708, flags: 4291707352) =3D 0
     0.197 ( 0.004 ms): a.out/447296 capget(header: 4160184320, dataptr: 81=
92)                             =3D 0
     0.202 ( 0.002 ms): a.out/447296 capget(header: 1448669184, dataptr: 40=
96)                             =3D 0
     0.208 ( 0.002 ms): a.out/447296 capget(header: 4160577536, dataptr: 81=
92)                             =3D 0
     0.220 ( 0.001 ms): a.out/447296 getxattr(pathname: "", name: "c=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD", value: 0xf7f77e34, size:=
 1)  =3D 0
     0.228 ( 0.005 ms): a.out/447296 fchmod(fd: -134729728, mode: IRUGO|IWU=
GO|IFREG|IFIFO|ISVTX|IXUSR|0x10000) =3D 0
     0.240 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: 0x5658e008=
, pos_h: 4160192052)            =3D 3
     0.250 ( 0.008 ms): a.out/447296 close(fd: 3</proc/447296/status>)     =
                                =3D 1436
     0.260 ( 0.018 ms): a.out/447296 stat(filename: "", statbuf: 0xffce32ac=
)                               =3D 1436
     0.288 (1000.213 ms): a.out/447296 readlinkat(buf: 0xffce31d4, bufsiz: =
4291703244)                       =3D 0
```

After:
```
         ? (         ): a.out/442930  ... [continued]: execve())           =
                                =3D 0
     0.023 ( 0.002 ms): a.out/442930 brk()                                 =
                                =3D 0x57760000
     0.052 ( 0.003 ms): a.out/442930 access(filename: 0xf7f5af28, mode: R) =
                                =3D -1 ENOENT (No such file or directory)
     0.059 ( 0.009 ms): a.out/442930 openat(dfd: CWD, filename: "/etc/ld.so=
.cache", flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
     0.078 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>)     =
                                =3D 0
     0.087 ( 0.007 ms): a.out/442930 openat(dfd: CWD, filename: "/lib/i386-=
linux-", flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
     0.095 ( 0.002 ms): a.out/442930 read(fd: 3</proc/442930/status>, buf: =
0xffbdbb70, count: 512)         =3D 512
     0.135 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>)     =
                                =3D 0
     0.148 ( 0.001 ms): a.out/442930 set_tid_address(tidptr: 0xf7f2b528)   =
                                =3D 442930 (a.out)
     0.150 ( 0.001 ms): a.out/442930 set_robust_list(head: 0xf7f2b52c, len:=
 12)                            =3D
     0.196 ( 0.004 ms): a.out/442930 mprotect(start: 0xf7f03000, len: 8192,=
 prot: READ)                    =3D 0
     0.202 ( 0.002 ms): a.out/442930 mprotect(start: 0x5658e000, len: 4096,=
 prot: READ)                    =3D 0
     0.207 ( 0.002 ms): a.out/442930 mprotect(start: 0xf7f63000, len: 8192,=
 prot: READ)                    =3D 0
     0.230 ( 0.005 ms): a.out/442930 munmap(addr: 0xf7f10000, len: 103414) =
                                =3D 0
     0.244 ( 0.010 ms): a.out/442930 openat(dfd: CWD, filename: 0x5658d008)=
                                =3D 3
     0.255 ( 0.007 ms): a.out/442930 read(fd: 3</proc/442930/status>, buf: =
0xffbdb67c, count: 4096)        =3D 1436
     0.264 ( 0.018 ms): a.out/442930 write(fd: 1</dev/pts/4>, buf: , count:=
 1436)                          =3D 1436
     0.292 (1000.173 ms): a.out/442930 clock_nanosleep(rqtp: { .tv_sec: 178=
66546940376776704, .tv_nsec: 4159878336 }, rmtp: 0xffbdb59c) =3D 0
  1000.478 (         ): a.out/442930 exit_group()                          =
                                =3D ?
```

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/util/syscalltbl.c | 89 ++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 760ac4d0869f..db0d2b81aed1 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -15,16 +15,39 @@
 #include <string.h>
 #include "string2.h"
=20
-#if __BITS_PER_LONG =3D=3D 64
-  #include <asm/syscalls_64.h>
-#else
-  #include <asm/syscalls_32.h>
-#endif
+#include "trace/beauty/generated/syscalltbl.c"
=20
-const char *syscalltbl__name(int e_machine __maybe_unused, int id)
+static const struct syscalltbl *find_table(int e_machine)
 {
-	if (id >=3D 0 && id <=3D (int)ARRAY_SIZE(syscall_num_to_name))
-		return syscall_num_to_name[id];
+	static const struct syscalltbl *last_table;
+	static int last_table_machine =3D EM_NONE;
+
+	/* Tables only exist for EM_SPARC. */
+	if (e_machine =3D=3D EM_SPARCV9)
+		e_machine =3D EM_SPARC;
+
+	if (last_table_machine =3D=3D e_machine && last_table !=3D NULL)
+		return last_table;
+
+	for (size_t i =3D 0; i < ARRAY_SIZE(syscalltbls); i++) {
+		const struct syscalltbl *entry =3D &syscalltbls[i];
+
+		if (entry->e_machine !=3D e_machine && entry->e_machine !=3D EM_NONE)
+			continue;
+
+		last_table =3D entry;
+		last_table_machine =3D e_machine;
+		return entry;
+	}
+	return NULL;
+}
+
+const char *syscalltbl__name(int e_machine, int id)
+{
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	if (table && id >=3D 0 && id < table->num_to_name_len)
+		return table->num_to_name[id];
 	return NULL;
 }
=20
@@ -41,38 +64,54 @@ static int syscallcmpname(const void *vkey, const void =
*ventry)
 	return strcmp(key->name, key->tbl[*entry]);
 }
=20
-int syscalltbl__id(int e_machine __maybe_unused, const char *name)
+int syscalltbl__id(int e_machine, const char *name)
 {
-	struct syscall_cmp_key key =3D {
-		.name =3D name,
-		.tbl =3D syscall_num_to_name,
-	};
-	const int *id =3D bsearch(&key, syscall_sorted_names,
-				ARRAY_SIZE(syscall_sorted_names),
-				sizeof(syscall_sorted_names[0]),
-				syscallcmpname);
+	const struct syscalltbl *table =3D find_table(e_machine);
+	struct syscall_cmp_key key;
+	const int *id;
+
+	if (!table)
+		return -1;
+
+	key.name =3D name;
+	key.tbl =3D table->num_to_name;
+	id =3D bsearch(&key, table->sorted_names, table->sorted_names_len,
+		     sizeof(table->sorted_names[0]), syscallcmpname);
=20
 	return id ? *id : -1;
 }
=20
-int syscalltbl__num_idx(int e_machine __maybe_unused)
+int syscalltbl__num_idx(int e_machine)
 {
-	return ARRAY_SIZE(syscall_sorted_names);
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	if (!table)
+		return 0;
+
+	return table->sorted_names_len;
 }
=20
-int syscalltbl__id_at_idx(int e_machine __maybe_unused, int idx)
+int syscalltbl__id_at_idx(int e_machine, int idx)
 {
-	return syscall_sorted_names[idx];
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	if (!table)
+		return -1;
+
+	assert(idx >=3D 0 && idx < table->sorted_names_len);
+	return table->sorted_names[idx];
 }
=20
-int syscalltbl__strglobmatch_next(int e_machine __maybe_unused, const char=
 *syscall_glob, int *idx)
+int syscalltbl__strglobmatch_next(int e_machine, const char *syscall_glob,=
 int *idx)
 {
-	for (int i =3D *idx + 1; i < (int)ARRAY_SIZE(syscall_sorted_names); ++i) =
{
-		const char *name =3D syscall_num_to_name[syscall_sorted_names[i]];
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	for (int i =3D *idx + 1; table && i < table->sorted_names_len; ++i) {
+		const char *name =3D table->num_to_name[table->sorted_names[i]];
=20
 		if (strglobmatch(name, syscall_glob)) {
 			*idx =3D i;
-			return syscall_sorted_names[i];
+			return table->sorted_names[i];
 		}
 	}
=20
--=20
2.48.1.711.g2feabab25a-goog


