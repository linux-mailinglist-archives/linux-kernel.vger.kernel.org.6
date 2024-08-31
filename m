Return-Path: <linux-kernel+bounces-309690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7613966F50
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D097B22095
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 04:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3B0139CFE;
	Sat, 31 Aug 2024 04:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JE9jIcxT"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279A193
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725078712; cv=none; b=I96q4WEqbZqwnRPAncCypctf4UYRqsr7yHJCoRE4pZ+PSFpHbA2uNEw1OEXH3tOzZAGm+0IEXpdtFM6EZxybT5iLkZ+HFY65MZnKrBUkuodWnNYrfHgC2tLZIPhgrDDOKWCaoEp9rLWuZYO7pHSfzUxGsPPYvGdO9i9qs13mAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725078712; c=relaxed/simple;
	bh=8GBs99s2ipPdDYyn7Cp9pfYjyv56y3V4qn3Ysb2DMbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ngPyY1CSlG4mtoDmDn6Jh9PvDHNM1zKZbSCOCI2qwBEmYD6wyXY+eRFCJ74SLhL3ekIL89jbitiZOFausphz3iGpIkk4MmDN8uo3qsDYdnuoFklPPorMmXv4DoEAzWzvL2qyDhp5oGABNvM6uDC3K6JpSGFZQGi0Vcs7vOse5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JE9jIcxT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so2134916b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 21:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725078708; x=1725683508; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AqHseBOIrzbXPNScCBf/4rC10NMVAn6bCAlgVTHbNrA=;
        b=JE9jIcxTZNZUp8bLJ+dYTdih8LaY4U+cPxkwZzMdZhOrWQ+lJMittwGgnoUxBAm37d
         ReGh0jUWZSXcw5rgQg2LW9r8iG8ZnpwjLZqs/CQfFDmedywH5IqPLQHvuOaLD9WYs7b2
         +VHhLl898m8KN37dS9NflJBvp4mniv65Bef+SyxBwBh5ikKXhFH1GLVON30g8eSbxr8D
         DO6+4ss3I2cQEXdaSr47NKb/fbf2HX57Z97GEFoHOb5mzEhk98YAxtLK/xWFkWR6vInI
         uWoFNi6SOlTmjUxXqy5bFy1P3aXNxXzUevUrzng6ymkjDHVmgQY5FCP0X9J2D/jCY8JY
         EELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725078708; x=1725683508;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqHseBOIrzbXPNScCBf/4rC10NMVAn6bCAlgVTHbNrA=;
        b=B9QcNOL4J9OBaDFl7DMRlbllwcLEzXN1kumNNJJW2xr56D37FemWfpkkwMKO/nPGkR
         i2K9AmWgU364TkItskkOTX1Y0VBiBGGYTRSQx2+LSJLE/F9Dy3U0TElsN6OdYB8dOAT+
         F+LcIVMxq+Gt+mqyTv3TQXiV+BZci3EXeIAEMv7O3Usx005tmIT2asm+fGkwmtTBqkL2
         xGikIIWCI4rbwESP0SSWCfSf8EgQv8M3smP1c8yU7Gc95OCqyb6UpNLxYjON6HKNCn3Q
         6je/uO+gx9Xly/N+zQg43JKULHdmShhk8fLobNBTMjMXDXs2K8jI0U3VPH4MK0a5Kr27
         +LYg==
X-Forwarded-Encrypted: i=1; AJvYcCUbXXik47llFkBxUftiMZS0lejeWtTRNfaQ0K76xIhUuI44bG1F6ZPOXbhOVRepNrt58ZhL9LEe3zAfhkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQ63U9U6Ue0D/k/GKFppKvEClU64LrV1qZB+xNzlG2I6oeJPE
	qDUSLH1FFXTEdvDGzw/w9braFZOtmuxnuxp+J0Wx9+R3fk05UfrF5Q+fwXiHf48=
X-Google-Smtp-Source: AGHT+IEVfVxTh9O/Prc9cqZKqT7+Ms4R+Qe/6R5MqTusHWzC77xL8vi5tuVksIYgreLjKfHXmdGvfg==
X-Received: by 2002:a05:6a00:4f93:b0:70d:11d9:8a3c with SMTP id d2e1a72fcca58-7173c5c237emr1446912b3a.26.1725078708306;
        Fri, 30 Aug 2024 21:31:48 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55771fesm3499773b3a.23.2024.08.30.21.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 21:31:47 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 30 Aug 2024 21:30:50 -0700
Subject: [PATCH] perf syscalltbl: Add syscalltbl__id_at_idx() with no
 syscall table support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-perf_syscalltbl_fix-v1-1-e2ff61ee5e8e@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAHmc0mYC/x2MWwqAIBAArxL7nWCmva4SET3WWpAKN6KQ7p70O
 QMzARg9IUOTBPB4EdO+RcjSBKZ12BYUNEcGJZWWVS7Fgd72/PA0OHeOrrd0C21NVSiVlbVBiOX
 hMer/2nbv+wF4IT/dZQAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Howard Chu <howardchu95@gmail.com>, 
 David Abdurachmanov <davidlt@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=8GBs99s2ipPdDYyn7Cp9pfYjyv56y3V4qn3Ysb2DMbE=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9qlOctkYh0Znr6aWvI29F6U4mHlKgM9q29fumd7HJn77
 t43zz7TjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACaSHcrIMHGKn92tI1wdidmn
 Jk1P7sj5X/zXNfdBvfqcRXoncpf7mzP8d+O2CH2zvvvERUXZ6Y43qnpO+r6dpDv5w7t4ryp96XB
 lfgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

When HAVE_SYSCALL_TABLE_SUPPORT is not defined, neither is
syscalltbl__id_at_idx(). However, this function is expected to be
defined when HAVE_BPF_SKEL is defined.

Return -1 from syscalltbl__id_at_idx() to match the other functions when
HAVE_SYSCALL_TABLE_SUPPORT is not defined.

Without this, compiling perf on riscv when libtraceevents, libelf, and
clang are available will cause the functions trying to call
syscalltbl__id_at_idx() to be compiled. This results in the following
error:

/usr/bin/ld: perf-in.o: in function `.L0 ':
builtin-trace.c:(.text+0x60b14): undefined reference to `syscalltbl__id_at_idx'
/usr/bin/ld: builtin-trace.c:(.text+0x60c6c): undefined reference to `syscalltbl__id_at_idx'
/usr/bin/ld: perf-in.o: in function `.L2564':
builtin-trace.c:(.text+0x60cb6): undefined reference to `syscalltbl__id_at_idx'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:793: perf] Error 1
make[1]: *** [Makefile.perf:290: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/src/linux-6.11-rc5/tools/perf'

This patch resolves this issue for all architectures which do not define
HAVE_SYSCALL_TABLE_SUPPORT.

$ ./perf trace -e syscalls:sys_enter_mmap --max-events=1 ls
0.000 ls/287 syscalls:sys_enter_mmap(__syscall_nr: 222, len: 9939, prot: READ, flags: PRIVATE, fd: 3)

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reported-by: David Abdurachmanov <davidlt@rivosinc.com>
Suggested-by: David Abdurachmanov <davidlt@rivosinc.com>
Fixes: 7a2fb5619cc1 ("perf trace: Fix iteration of syscall ids in syscalltbl->entries")
---
 tools/perf/util/syscalltbl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 0dd26b991b3f..12654460428f 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -188,4 +188,9 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
 {
 	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
 }
+
+int syscalltbl__id_at_idx(struct syscalltbl *tbl __always_unused, int idx __always_unused)
+{
+	return -1;
+}
 #endif /* HAVE_SYSCALL_TABLE_SUPPORT */

---
base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
change-id: 20240830-perf_syscalltbl_fix-4f586221795e
-- 
- Charlie


