Return-Path: <linux-kernel+bounces-410691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ACD9CDFD9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81486283F09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF2C1B218E;
	Fri, 15 Nov 2024 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Guq2qqqG"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0CA1B6D06
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677122; cv=none; b=XOUf7M0gjLmMOsTpdjUsI/eTyIcwSj/Yb1ZeUncRddcL4MtMQ+qagkJS2azxgOgnK2+RukYZV4+IdUeudAfe2lbhYK6mCrOT3qt7oXncVDMQpyaWtxq+k5+y5HFD3vk/3BVysCIMfEL8NVTsPbYGV+DgFlPTbOm2WrdjI+gHMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677122; c=relaxed/simple;
	bh=aVtH8GKvNB4hotlvO9ZD/QPTN/0jxawpj33QBA46sQc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gfw8viiQPVSj28AC/mx2Y7PZFCp/vHu4c13emBdabcMLFAut0iwG01q5KAjHXCVXR7cibYUJkg7/RTFrbd5U8YngukZpWiZrKK02HfblipXjv6IDAKiKWzVMy7X5lWi9qNtQVCu8KJZPRx2dbiPZTC97FM4VSHXUM+HkkvUzeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Guq2qqqG; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-856ed9e5413so62334241.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731677119; x=1732281919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OXYAb6PLHFnX5ddiFPzuGuSWsu4V6JIF0+6sI4IJYrc=;
        b=Guq2qqqGCUv9HdR5AhDAc6Q8DU4pJvMpC68WoJo8V4EvyePum7hjYM9s02CPQmfJ4A
         M4pUT7/muAMDNpB3RR5aYwNu3mwh/nLCBbrOO5hYVKusQ6tnGeP/gA3i6bb36ZsI9kdQ
         dSN8DIFjXGZvVkedbKgg1inmv9PoB/CtsAqwJWrqGBXkUckgO4z4QxIQj/2jm3eOTovG
         Py6Sbln78grSIU4rHcj2FTDdc95OwRP01verkIEqM+iYv4Bl9wuKg0SS1Uq/1i8Ez1o7
         30CUlCTdESXaQU6hHoVnHnYPVP6kZFDDEy7cCONMTN8qP99w8nHIP84xcJoGj6KCCMIN
         7VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731677119; x=1732281919;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXYAb6PLHFnX5ddiFPzuGuSWsu4V6JIF0+6sI4IJYrc=;
        b=cUSDipewnYpQhcYAsNu4nE3VrPpKxd5WVbeADBIrnZS2Uy5QwrcWohVflX3s1g8hzf
         S3sw1EXtsM9FdYUVKb17hON/QhkdMBCl0B8rxLpoyGQE6MPNjgpFlF3b18dy+MRzwUlF
         r3cuD0wSvOfTn1hShy27WqgBzW3Dp7/Q4RV5eDi6CYelcHHXRHaY4Nwmz+yKJgxOC2kN
         Zv3+DLCK4GQBR0klCQSXC6+tLHzeUvWwrnlXQa9nluUQNVWtv5A5uZ69rTFFwcI7mIhp
         dfInK/OjktREPfPu3HFuK8/d1N+huQBKPsG9eBs14QSEaKjK3Kza8dsx2MjIUzL0q/+X
         pHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIOT2AQN011s7p7WimkI4dYmggSSqePYr7fT6Yk4YKWFILKRKJqK5Yq4a0VuP2S8z64d3gk9os6wklXMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJEDjhxsZMHLZlFOrhwK6S/s3XfmxBQTsrXzwf+sa4QnHR1se
	d1Y3W00nA4njdfD0wH58j8qhw5o3HRsQSEFdwtkYLxiRqcD5aGwBLRpgG0XecFDIN5eS8pxai4H
	vt26qhE8vmjJ+pU07Q07BdYbhx592Z7qHfrZzNj+CcFwWfscoGyc=
X-Google-Smtp-Source: AGHT+IHP9qntYDPkv8gz3RyGGvJS5CGBuoRgWcRvYQNEWDKJ0JaS2OYT0qdnUSe+4HP41XhcqjGcI8JG9uxcwd0IfNU=
X-Received: by 2002:a05:6122:1787:b0:50d:85d7:d94b with SMTP id
 71dfb90a1353d-514786d3b56mr2773887e0c.11.1731677119052; Fri, 15 Nov 2024
 05:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 15 Nov 2024 18:55:08 +0530
Message-ID: <CA+G9fYv=qPeZKkF+ntWxUXbAKjz4gXnBM8y60C4F=YHv+jgZZw@mail.gmail.com>
Subject: riscv: include/linux/perf_event.h:1679:84: error: macro
 "perf_misc_flags" passed 2 arguments, but takes just 1
To: linux-perf-users@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	coltonlewis@google.com
Content-Type: text/plain; charset="UTF-8"

The following builds failed with clang-19 and gcc-13 on the
 Linux next-20241115 tags on riscv architecture.

First seen on Linux next-20241115 tag.
  Good: next-20241114
  Bad:  next-20241115

build:
  * clang-13-lkftconfig
  * clang-19-lkftconfig
  * clang-nightly-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
In file included from include/linux/perf/riscv_pmu.h:12,
                 from arch/riscv/include/asm/kvm_vcpu_pmu.h:12,
                 from arch/riscv/include/asm/kvm_host.h:23,
                 from arch/riscv/kernel/asm-offsets.c:12:
include/linux/perf_event.h:1679:84: error: macro "perf_misc_flags"
passed 2 arguments, but takes just 1
 1679 | extern unsigned long perf_misc_flags(struct perf_event *event,
struct pt_regs *regs);
      |
                    ^
In file included from include/linux/perf_event.h:25:
arch/riscv/include/asm/perf_event.h:15: note: macro "perf_misc_flags"
defined here
   15 | #define perf_misc_flags(regs) perf_misc_flags(regs)
      |
include/linux/perf_event.h:1679:22: error: 'perf_misc_flags'
redeclared as different kind of symbol
 1679 | extern unsigned long perf_misc_flags(struct perf_event *event,
struct pt_regs *regs);
      |                      ^~~~~~~~~~~~~~~
arch/riscv/include/asm/perf_event.h:14:22: note: previous declaration
of 'perf_misc_flags' with type 'long unsigned int(struct pt_regs *)'
   14 | extern unsigned long perf_misc_flags(struct pt_regs *regs);
      |                      ^~~~~~~~~~~~~~~
include/linux/perf_event.h:1680:22: error: conflicting types for
'perf_instruction_pointer'; have 'long unsigned int(struct perf_event
*, struct pt_regs *)'
 1680 | extern unsigned long perf_instruction_pointer(struct perf_event *event,
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~
arch/riscv/include/asm/perf_event.h:13:22: note: previous declaration
of 'perf_instruction_pointer' with type 'long unsigned int(struct
pt_regs *)'
   13 | extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:102:
arch/riscv/kernel/asm-offsets.s] Error 1


Build image:
-----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241115/testrun/25823358/suite/build/test/gcc-13-defconfig/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241115/testrun/25823358/suite/build/test/gcc-13-defconfig/log
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2osJj2d60yO8ruYvm0gjhi4YHS5/

Steps to reproduce:
------------
- tuxmake --runtime podman --target-arch riscv --toolchain gcc-13
--kconfig defconfig

metadata:
----
  git describe: next-20241115
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2osJj2d60yO8ruYvm0gjhi4YHS5/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2osJj2d60yO8ruYvm0gjhi4YHS5/
  toolchain: clang-19 and gcc-13
  config: lkftconfig
  arch: riscv

--
Linaro LKFT
https://lkft.linaro.org

