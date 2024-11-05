Return-Path: <linux-kernel+bounces-396722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1514A9BD13D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6FE1C2245A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DDC14A4DC;
	Tue,  5 Nov 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhSlWear"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34E14A0B8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822297; cv=none; b=a1AfySBQgneCn/v2t/mmuC3T3TaIA1TV/MukaWzURTwNeroC7lmW+zCIDLcwkLAkP547QfLzticjIrJj9cbR/tEHOgHxp8/xXFuBhN6dyS6g6lm1LKeDrewfsKkjzloLymUwYBStICqaqE++VB69NHG1U0LwaKvcheErIXv7tts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822297; c=relaxed/simple;
	bh=+QNlM2gJUGR5E+GaodKNqSiwoUISyQyhaIVTWAVgVbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkXlptwb+ed98PsQHrJfyxxpHF4p9iyFvjkd5rxnS+Q9YTBR8ghOOvrkd3T0YhPFn5BzU8XwFsfa8qW8IQZJTCFBQNl78ldBcLsVb6DQY6ZjhjTwdIGr8qhJToCMcaMVMiGoLMOyZuJCfZReV/wCADzohVJ9xNttUhAR4afElJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhSlWear; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ec1ee25504so2140713eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822294; x=1731427094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Llp/0vB41RULMS9wDAxk5MCSo/RyfVNGYYdqtFNEPgk=;
        b=GhSlWeara526lFJOcR+y5EB2BtF82qOk06Q8VjbfuAP7wlYT9N3VE2EkUEqyGWjzow
         zbVmgOOYugMTgaxqQ6fySdl+70ARhrJwXy1rXpoU/eA/v6DY4MikC7ZJenUHKw3H36oo
         RAiinMoFPJmzCv82973Xbr0b5v/Ks4Q2QQh2ZubLy24gW9XTDTZ0E/HdgVNv0X5wlUVK
         vLbhTG83PHHZYV2LuZbRjDjiSnrUTw2zLrX0NEr6ULUC/n3mHqSEkKhtsQ5+VwSMd4SG
         oNq5QRziCB+XPuBvvHW/IsFCoxmBAu2RUrSlG7W4108vC8v9o+IOIeYlK8sma4X0uKG9
         7wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822294; x=1731427094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Llp/0vB41RULMS9wDAxk5MCSo/RyfVNGYYdqtFNEPgk=;
        b=w2eFrU/5SJ0CZS0pHrcBlvF3iEYeWAhMIjJPkRQSoCRMXC3P9M3DCi2gM0UcyE2pAO
         Y7gLRJiDQxpfPzX9Mzco0uiM2a9wRGsoPAQ1hMYXdcguYxHZ9j/mEr1TJZFjbxLaAnza
         5aerQuryo1DgQM01Rkgf6xliZg2W32cSTdk0rEBJ7qkYxC8p43pUcdNVBQcJmJJL8G8J
         gKnhchbZ0O00Yxb/3PbENhF4qPMdyvmwrv950Bjb2Nl1GIVmwhhlwmqfF26KVlKsx9gF
         LwR7xKJ8Py/HxT0dq6YeEEd2WkAR/u459wDI/BKmYA1+ETFI+yS8RQevDCminK3cg48l
         xoig==
X-Gm-Message-State: AOJu0YwA400dMmZlggQDo58kJlEPhxSGh6cYCRd5rIL82Sv5I2HYHBAq
	agxTv+TzMbcYlY3lcvUuWNylUT2Ng+Ux32b0IoRYBDBE/bB+oHw8wP32
X-Google-Smtp-Source: AGHT+IG45n3dU/PC+iHZz173WcxoDnTiAV8UDLuOxxUeC0h1OpMxpxBGbb6SZLyNhZuDhCtGS/ZUPg==
X-Received: by 2002:a05:6358:e49f:b0:1c3:7a2e:a474 with SMTP id e5c5f4694b2df-1c5ee92cfc6mr852797555d.6.1730822294499;
        Tue, 05 Nov 2024 07:58:14 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:14 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 00/16] x86-64: Stack protector and percpu improvements
Date: Tue,  5 Nov 2024 10:57:45 -0500
Message-ID: <20241105155801.1779119-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, x86-64 uses an unusual percpu layout, where the percpu section
is linked at absolute address 0.  The reason behind this is that older GCC
versions placed the stack protector (if enabled) at a fixed offset from the
GS segment base.  Since the GS segement is also used for percpu variables,
this forced the current layout.

GCC since version 8.1 supports a configurable location for the stack
protector value, which allows removal of the restriction on how the percpu
section is linked.  This allows the percpu section to be linked normally,
like other architectures.  In turn, this allows removal of code that was
needed to support the zero-based percpu section.

v5:
- Added two patches from Ard Biesheuvel to make stack protector work
  properly when compiling with clang.
- Raise minimum GCC version to 8.1 for x86.
- Drop objtool conversion code.

Ard Biesheuvel (2):
  x86/stackprotector: Work around strict Clang TLS symbol requirements
  x86/module: Deal with GOT based stack cookie load on Clang < 17

Brian Gerst (14):
  x86: Raise minimum GCC version to 8.1
  x86/stackprotector: Remove stack protector test scripts
  x86/boot: Disable stack protector for early boot code
  x86/pvh: Use fixed_percpu_data for early boot GSBASE
  x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
  x86/stackprotector/64: Convert to normal percpu variable
  x86/percpu/64: Use relative percpu offsets
  x86/percpu/64: Remove fixed_percpu_data
  x86/boot/64: Remove inverse relocations
  x86/percpu/64: Remove INIT_PER_CPU macros
  percpu: Remove PER_CPU_FIRST_SECTION
  percpu: Remove PERCPU_VADDR()
  percpu: Remove __per_cpu_load
  kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU

 arch/x86/Kconfig                          |  11 +-
 arch/x86/Makefile                         |  19 +--
 arch/x86/boot/compressed/misc.c           |  14 +--
 arch/x86/entry/entry.S                    |  14 +++
 arch/x86/entry/entry_64.S                 |   2 +-
 arch/x86/include/asm/asm-prototypes.h     |   3 +
 arch/x86/include/asm/desc.h               |   1 -
 arch/x86/include/asm/elf.h                |   3 +-
 arch/x86/include/asm/percpu.h             |  22 ----
 arch/x86/include/asm/processor.h          |  28 +----
 arch/x86/include/asm/stackprotector.h     |  36 +-----
 arch/x86/kernel/Makefile                  |   2 +
 arch/x86/kernel/asm-offsets_64.c          |   6 -
 arch/x86/kernel/cpu/common.c              |  11 +-
 arch/x86/kernel/head64.c                  |   2 +-
 arch/x86/kernel/head_64.S                 |  20 ++-
 arch/x86/kernel/irq_64.c                  |   1 -
 arch/x86/kernel/module.c                  |  15 +++
 arch/x86/kernel/setup_percpu.c            |  12 +-
 arch/x86/kernel/vmlinux.lds.S             |  38 +-----
 arch/x86/platform/pvh/head.S              |  14 ++-
 arch/x86/tools/relocs.c                   | 147 ++--------------------
 arch/x86/xen/xen-head.S                   |  10 +-
 include/asm-generic/sections.h            |   2 +-
 include/asm-generic/vmlinux.lds.h         |  38 +-----
 include/linux/percpu-defs.h               |  12 --
 init/Kconfig                              |   5 -
 kernel/kallsyms.c                         |  12 +-
 mm/percpu.c                               |   4 +-
 scripts/gcc-x86_32-has-stack-protector.sh |   8 --
 scripts/gcc-x86_64-has-stack-protector.sh |   4 -
 scripts/kallsyms.c                        |  72 ++---------
 scripts/link-vmlinux.sh                   |   4 -
 scripts/min-tool-version.sh               |   2 +
 34 files changed, 122 insertions(+), 472 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh


base-commit: 4b9984799820b5b32b0ae1f3d8074886895a44e1
-- 
2.47.0


