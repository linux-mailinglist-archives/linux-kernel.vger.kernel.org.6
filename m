Return-Path: <linux-kernel+bounces-435318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2E9E760C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F741887BEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDA82135A6;
	Fri,  6 Dec 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Wyp3xk9L"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1415203D4C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502672; cv=none; b=qp6BkEZ8IjSd0AH7GtCVOpCb/B/Hgyv+p88nf0h3TCgYzJXKw6+m0gaM20JEOAA8PRTttI6Fjew1GWBVom25EHq1FIaf/EUwP5SUWGydhfB/x6GqxePuJr33MTUW1lamrkr2GDcGz9C03AQrG0LqAFAqo9eNWPVchc99vKsuecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502672; c=relaxed/simple;
	bh=8Hbd8A1vmlYhL3kkw/ojPvu32B+yen85c3Vfh0DNDGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BhxMPW2XUUWqb29mgMtrO3Ii9Y7LjeZnzXz5qW7vM6/qSsCE/5L1kOIKyGIS4Pq81cyPzYyTIBqO85bd/GndGGUlQmsM7POARBja7fpqLFn2DAvJAZMvd52F+Rkwyr3L9fRrU/8YiPZZ7UjLVoWutC8WKEWpAZrfF3RZju9iy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Wyp3xk9L; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385de59c1a0so1519956f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733502668; x=1734107468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=40IeoncDegwdvePviQ9Ac1q99emn7vMhde6cXPhiSAU=;
        b=Wyp3xk9LNWHVO87xWvP12uOrwM7DKJgafUT7pX0R1latxoX6WuZOAX99SP373VuCmN
         7xdYwoimGLpgEhDY6l2zHUxHIk7Xr/p50qFMdxXaq1EUQSLVPriooIz8sDVtc5YNwtzc
         Lb7jJOC5yiPdolkh4QpWI84visWyoci8IPAF09kB9xBFsdj3DeOr9e5ekVZL5hFFdf0C
         +OT1Ttqjd9qGHGd4/3Wjb0OK+x0y0aHechVie0LMgJm+BRHtLtt11ephL87QCylEefFs
         wzIaH9qClF+i5w3f5Zyt1hBPlw1Zhx6F/Jpl+oW5lbzN4TKi6CZtkPioIGIXybcezbY0
         z9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502668; x=1734107468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40IeoncDegwdvePviQ9Ac1q99emn7vMhde6cXPhiSAU=;
        b=lD5s/KZNspUKdPnIQVz1a96MfxUavsUoHElWM4vHZNrcwl8vPYWD44joNCgMIpZCPE
         spztU07bA82dhft36SAU82/3gj57bOStXJ27ur56CiDXqNg1W+VY7ovYOwN7jD+718kT
         aoL+7qHC9ijYpPTlRxP49I7nkw261QW7BWbq2gkjtz4uwhOrKK+IJR8Mwh1I2o6ktOxf
         9+qHHAZOllTCGJVo+PSS9lhuVIKhVMK4vM9yfoQyOI3RaOjCStYBoeNHKobJCydrFgGM
         yaBfXHVQddjqnYbXz9qe18sB9KQI63lWuEnT8NCDAFqwRhxA1pdbeHts8tsQwIkG1Pcs
         7RqA==
X-Forwarded-Encrypted: i=1; AJvYcCVv7S0hif/2ik6xk+BP9Z9/Ngeh5onKnyFbGReaBtuQBWrbphVkIdGVf1F5wJgqJE9oriIeIHYtlRM9HoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZJW3myKX5zfug/OzDc95t9dk2pB9Dd+ts5YjiwO8JhWLs0Dj
	IhfPBeKij/HUA4qRD9MmEGPavGh715MpYNyx0/ThKkng6TkW9j+nG7g/7AT9qRo=
X-Gm-Gg: ASbGncuebWt42++2RXumtG0uKEFRvy3LmiF7uI1M/8gMPHYpMS5Vxx9wqyOnINf8hNn
	3j3TN+N8rPbE6Cv7BSEiPlN4KoYg+NSkBriUx3m5/VAkLZxierJcCykDkeOYBerXoz3KYrPfrXJ
	WSxQwibd3d+hpfbK+aLBO2Z88m578GBPyJkhJWg+SFjyPP4qKyjIVBZs828Jzr/xfyFs51w8A/R
	64Kd4koIhK1DtbFBNmwSWRh7Z7pYX0NAx2QwuNsN4UcHfFJDNY=
X-Google-Smtp-Source: AGHT+IHAkbc/dcGz/MjNU6vQq8UGceABhupZgIW1uIKLdzsf3QUJS33oSh5p4cBX6H9+RneNbzUK4A==
X-Received: by 2002:a5d:59a3:0:b0:385:dffb:4d66 with SMTP id ffacd0b85a97d-3862b36a491mr2894353f8f.17.1733502668076;
        Fri, 06 Dec 2024 08:31:08 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862f02f5c3sm1151942f8f.65.2024.12.06.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:31:07 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>,
	Atish Patra <atishp@atishpatra.org>
Subject: [PATCH v3 0/4] riscv: add support for SBI Supervisor Software Events
Date: Fri,  6 Dec 2024 17:30:56 +0100
Message-ID: <20241206163102.843505-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The SBI Supervisor Software Events (SSE) extensions provides a mechanism
to inject software events from an SBI implementation to supervisor
software such that it preempts all other supervisor level traps and
interrupts. This specification is introduced by the SBI v3.0
specification[1].

Various events are defined and can be send asynchronously to supervisor
software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
as platform specific events. Events can be either local (per-hart) or
global. Events can be nested on top of each other based on priority and
can interrupt the kernel at any time.

First patch adds the SSE definitions. Second one adds support for SSE
at arch level (entry code and stack allocations) and third one at driver
level. Finally, the last patch add support for SSE events in the SBI PMU
driver. Additional testing for that part is highly welcomed since there
are a lot of possible path that needs to be exercised.

Amongst the specific points that needs to be handle is the interruption
at any point of the kernel execution and more specifically at the
beggining of exception handling. Due to the fact that the exception entry
implementation uses the SCRATCH CSR as both the current task struct and
as the temporary register to switch the stack and save register, it is
difficult to reliably get the current task struct if we get interrupted
at this specific moment (ie, it might contain 0, the task pointer or tp).
A fixup-like mechanism is not possible due to the nested nature of SSE
which makes it really hard to obtain the original interruption site. In
order to retrieve the task in a reliable maneer, add an additional
__sse_entry_task per_cpu array which stores the current task. Ideally,
we would need to modify the way we retrieve/store the current task in
exception handling so that it does not depend on the place where it's
interrupted.

Contrary to pseudo NMI [2], SSE does not modifies the way interrupts are
handled and does not adds any overhead to existing code. Moreover, it
provides "true" NMI-like interrupts which can interrupt the kernel at
any time (even in exception handling). This is particularly crucial for
RAS errors which needs to be handled as fast as possible to avoid any
fault propagation.

OpenSBI SSE support is already upstream.

Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/vv3.0-rc2/riscv-sbi.pdf [1]

---

Changes in v3:
 - Split arch/driver support
 - Fix potential register failure reporting
 - Set a few pr_err as pr_debug
 - Allow CONFIG_RISCV_SSE to be disabled
 - Fix build without CONFIG_RISCV_SSE
 - Remove fixup-like mechanism and use a per-cpu array
 - Fixed SSCRATCH being corrupted when interrupting the kernel in early
   exception path.
 - Split SSE assembly from entry.S
 - Add Himanchu SSE mask/unmask and runtime PM support.
 - Disable user memory access/floating point/vector in SSE handler
 - Rebased on master

v2: https://lore.kernel.org/linux-riscv/20240112111720.2975069-1-cleger@rivosinc.com/

Changes in v2:
 - Implemented specification v2
 - Fix various error handling cases
 - Added shadow stack support

v1: https://lore.kernel.org/linux-riscv/20231026143122.279437-1-cleger@rivosinc.com/

Clément Léger (4):
  riscv: add SBI SSE extension definitions
  riscv: add support for SBI Supervisor Software Events extension
  drivers: firmware: add riscv SSE support
  perf: RISC-V: add support for SSE event

 MAINTAINERS                          |  14 +
 arch/riscv/include/asm/asm.h         |  14 +-
 arch/riscv/include/asm/sbi.h         |  62 +++
 arch/riscv/include/asm/scs.h         |   7 +
 arch/riscv/include/asm/sse.h         |  38 ++
 arch/riscv/include/asm/switch_to.h   |  14 +
 arch/riscv/include/asm/thread_info.h |   1 +
 arch/riscv/kernel/Makefile           |   1 +
 arch/riscv/kernel/asm-offsets.c      |  12 +
 arch/riscv/kernel/sse.c              | 134 ++++++
 arch/riscv/kernel/sse_entry.S        | 171 +++++++
 drivers/firmware/Kconfig             |   1 +
 drivers/firmware/Makefile            |   1 +
 drivers/firmware/riscv/Kconfig       |  15 +
 drivers/firmware/riscv/Makefile      |   3 +
 drivers/firmware/riscv/riscv_sse.c   | 691 +++++++++++++++++++++++++++
 drivers/perf/riscv_pmu_sbi.c         |  51 +-
 include/linux/riscv_sse.h            |  56 +++
 18 files changed, 1273 insertions(+), 13 deletions(-)
 create mode 100644 arch/riscv/include/asm/sse.h
 create mode 100644 arch/riscv/kernel/sse.c
 create mode 100644 arch/riscv/kernel/sse_entry.S
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv_sse.c
 create mode 100644 include/linux/riscv_sse.h

-- 
2.45.2


