Return-Path: <linux-kernel+bounces-242773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D3F928CFF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA3BB20765
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701016D9A4;
	Fri,  5 Jul 2024 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="U5vDbHkE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBA145B10
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199796; cv=none; b=uaX4mlQSRr551NCRyemOmHI0zw7u2aplQtwnD/kbEh4H4J2Gyuxoo2JFc5XP7x/3+UUDcka3bGjs0l5PmW/NJfM9c/51uZ22E10RVMmeq2iqiQxZ8/jGYYI8K478Oz/IOiEssQU2x41Ku7jT7GbJZyWqMSd7cE825/M5+kjS4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199796; c=relaxed/simple;
	bh=WLqzSHMkCJXQQkmwdalJfco9pPxwz6kJETfVla9fejY=;
	h=Date:Subject:CC:From:To:Message-ID; b=drY1rLjdGP6DtvR7lPtEMC7atPZ2hyC4azvl4jWievRxq+t0vgxwZPfpupz+j0k/vNb39usmN1NoW8fuJhbS2SB5sNeHlU5Yg9Afw6zSmDo3rfOq8iklwNajMGnV6Ow61gMh+NEH6Rkz+/pQD7W0y4DM/UPV3ID5XOa0WxKVXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=U5vDbHkE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa9f540f45so11999705ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720199793; x=1720804593; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=in/LzK8J9JA83I2h0HE4VR8w3YECSYGz8kwTmF46sLA=;
        b=U5vDbHkEujOHpLMFnwhS6VsLqoC5vG6JkB9Vbiy3NFiVuvuYCCn2k2RmvGR931uJuf
         oCWFSje+1MAHURaxZIz1+cIyU3NBYKx87NBv92CD2Ewmiu2f69TBAkhYoFQRKx4lHwrw
         rfwPEQxMt4+Pheym0auhEd0f4CXjfDdradC5DTchheGZR6ct8xim67gwfOEp38ckiCBu
         IYfRwrajlfa9AGmZM/zzbBWGhvWiaGo5rSS5dTrBLhcopeWNc2I+9YN5doebp4RtXBfN
         Xs4qmyyK52r5zFp4j3XZ0hAMTwPVq/KjhF/K/UpW3m7NhBI/ssDp7OPU6FRpfcerFHbr
         b8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720199793; x=1720804593;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=in/LzK8J9JA83I2h0HE4VR8w3YECSYGz8kwTmF46sLA=;
        b=VsH+z+YjhSxx1EIzI59MkiW+y4mooPtDknqAGMk7XVKcu93pwT2IG2NgMqBYxNDqnw
         GeaB5LGQI4qyB9Bm+sH1W+2Q9J1qyLoJB1lCsr3liL4VFrixMVseRlEXRc2OO5tvMrs8
         yOjT5AzN5eE7ChRxXpdaIdMxU71qdC1FVZHqoz5XW8BCVnuD42zV6mnq6FhBosIJ6uIh
         9C1CuZWWM5HBFyvU4u6fY95bE16mstAOsBdfqZwCUPzCgBiqub3Q2mTiC/BIi+T8el0D
         dWehg6ejU2eMjzKhjPZbBoV3E54kLmUzFBCMM1V+kQtATVfJ4tkLkCgarF+NU27YnIvB
         CMWw==
X-Forwarded-Encrypted: i=1; AJvYcCVqOTSCzFBaar8i+skMClp9okCO/tu1sBgxVq2sOH3ri4oKDkxi/ERORHWn7l+xQt7DGlBsGTvmDJQnkrh/zjqxaBVihHE3hubOQs40
X-Gm-Message-State: AOJu0YwrGPJBExEki90J/MxtV8UQisPCoX4I5+CuA99FH1WYLrmzhZbz
	y+vew+rKgSeuQYOCpbL4NXiOvCDAdW7GPLSn5PfRs6ns4N0/yM1Yf+xjOs3gfvuppVNEyPf+U64
	q
X-Google-Smtp-Source: AGHT+IFNDYa52WmZ4834HkFwpR9ug9L4dA+Zn5lnn4mA6g/te+8GNddBhZT6WVVzJ8roKd9SC1D8Rg==
X-Received: by 2002:a17:902:c951:b0:1fb:29f3:c7d4 with SMTP id d9443c01a7336-1fb33ee5d27mr36230245ad.51.1720199792856;
        Fri, 05 Jul 2024 10:16:32 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb5962888csm6993355ad.61.2024.07.05.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 10:16:32 -0700 (PDT)
Date: Fri, 05 Jul 2024 10:16:32 -0700 (PDT)
X-Google-Original-Date: Fri, 05 Jul 2024 10:16:16 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.10-rc7
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-c0537cb4-d700-4259-889e-c87f011e931b@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc7

for you to fetch changes up to c562ba719df570c986caf0941fea2449150bcbc4:

  riscv: kexec: Avoid deadlock in kexec crash path (2024-07-03 13:11:30 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.10-rc7

* A fix for the CMODX example in therecently added icache flushing
  prctl().
* A fix to the perf driver to avoid corrupting event data on counter
  overflows when external overflow handlers are in use.
* A fix to clear all hardware performance monitor events on boot, to
  avoid dangling events firmware or previously booted kernels from
  triggering spuriously.
* A fix to the perf event probing logic to avoid erroneously reporting
  the presence of unimplemented counters.  This also prevents some
  implemented counters from being reported.
* A build fix for the vector sigreturn selftest on clang.
* A fix to ftrace, which now requires the previously optional index
  argument to ftrace_graph_ret_addr().
* A fix to avoid deadlocking if kexec crash handling triggers in an
  interrupt context.

----------------------------------------------------------------
Atish Patra (1):
      drivers/perf: riscv: Do not update the event data if uptodate

Charlie Jenkins (2):
      documentation: Fix riscv cmodx example
      riscv: selftests: Fix vsetivli args for clang

Palmer Dabbelt (1):
      Merge patch series "Assorted fixes in RISC-V PMU driver"

Puranjay Mohan (1):
      riscv: stacktrace: fix usage of ftrace_graph_ret_addr()

Samuel Holland (2):
      drivers/perf: riscv: Reset the counter to hpmevent mapping while starting cpus
      perf: RISC-V: Check standard event availability

Song Shuai (1):
      riscv: kexec: Avoid deadlock in kexec crash path

 Documentation/arch/riscv/cmodx.rst                 |  4 +-
 arch/riscv/kernel/machine_kexec.c                  | 10 +----
 arch/riscv/kernel/stacktrace.c                     |  3 +-
 arch/riscv/kvm/vcpu_pmu.c                          |  2 +-
 drivers/perf/riscv_pmu.c                           |  2 +-
 drivers/perf/riscv_pmu_sbi.c                       | 44 ++++++++++++++++++++--
 .../testing/selftests/riscv/sigreturn/sigreturn.c  |  2 +-
 7 files changed, 49 insertions(+), 18 deletions(-)

