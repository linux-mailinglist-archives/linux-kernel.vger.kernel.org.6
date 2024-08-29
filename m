Return-Path: <linux-kernel+bounces-305965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB31B963735
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5951C21C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463D21AACB;
	Thu, 29 Aug 2024 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mCKQK86a"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40017BA4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893317; cv=none; b=WPwlu9xxmDlg0xt4/ZVgfJQ+0uGbn5gzLRenoxVqndsw7ZWaAmPgtAFg8DoClt/OLuZrWzTo/UPY+Al6EIlW/1n5I9oRAjvCLS4klHsa6rR2JtqufKRRPWsOEPl5UNCaoP/t934HvtVT2o2+jbP6XRCVbElAtSWMjnIansn8HiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893317; c=relaxed/simple;
	bh=9/F9ZLcju33/CdfmehmZ0sHcgzGfSOEKTGpc0MJaR6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BtzbkSCU5skbCyG2l7v5zGs1+umlfjukimr6kOAtD/rblF5uzYpqbzhrZMk6u9sedutV8i6uDN3kNpvib6DGFpA3bm70L2cddOV2V/POca67HPQZ5TJa3uCCjwheRJd7AB0g5sBg0E0Hq46jgfJoanAaH+bDtdImIDS+1htq8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mCKQK86a; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7141d7b270dso109517b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724893314; x=1725498114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QwsbhYPJkRIIKdEOQBCTBjh/yHwiNO4KwyjIKyWe5c=;
        b=mCKQK86aaNMuFu1wlhSQlsbtt2lZEJ8KWKe3xJuCefMIWGhYKXlTTcd+krHITOkIXX
         srwcEEYiaB0Ywo10mRZDQAGbZxAv19licysGhROg9nvdx9EpVnTq8t7Ly4jZ75r1CpnG
         pO/bNo1KanoOLlCNmSz1f+aJVUo3RoH83qDIerbccEqmV1gZb+FmPHEcUyILN74xW8M+
         qKz/4vQvGM4ljVP0iy7R2zkY4mGpAC49nGtZY2u1R7a3JTTH9QNqr315jAocRaCz6XMo
         mTIi0JflalEIAjNA3edFMOrXQNl2e+DdVxSbUs4BYaNvr90CqFAnuvQfRdgbDRsVlUme
         EUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893314; x=1725498114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QwsbhYPJkRIIKdEOQBCTBjh/yHwiNO4KwyjIKyWe5c=;
        b=E7OBU0luASDK4/gsEixBak6zA59gQl8j2Wp8NVtN4rvu51oow5i/zIQbOKeqo6b/PW
         qTVy9rynHMc15yWnJTcXZY31I/IRle4puaE37/8ziGa/4KxXPwlJInp7x2GA+Cy2oPWv
         1XrHVvtdRbAis7oi4ran1TcUTGaHh3bokPcwKVw5QwNVKqn8DkTLjeig/iAVWaxd3KPi
         pJIyAt9OzMbiDKQHKJZRMuCRtFf85AIeEtckTj4upysDCVDszu/6Lab2vhiWHzEoLl3T
         FbbkrqKU4rodHFHgAveTSrJ4dJ4jFaoJGRjsK6CWjXNnpOMI671LFJPYr0Mrt675rWEc
         DJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCVj2Wr0v5GP8AZr8mwk/XlNFwLLiHY4CoQN7zVQ+8jiO6Dkw6qISfxV3E0jxSefjonJbbBCYK0+FmR5boI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/f0aFNOCEI9FMod5IWQr9eLoIyfKeM4hYkpbflLc+aZACaqbm
	nTY4FdSipb0hCYgI8o2At9Et/7yi4KBCjVSUP3hggryyVkuRRMB5Ol5k2+t19PM=
X-Google-Smtp-Source: AGHT+IG1GSeRH5Ks0VS3MWIlvyXPXQ98om2zedyIsxVmsBu+8+cd1nlfukxYqhWeYJz+YalTi4s/bQ==
X-Received: by 2002:a05:6a00:17a8:b0:70a:fb91:66d7 with SMTP id d2e1a72fcca58-715dfca3b68mr1609341b3a.20.1724893313850;
        Wed, 28 Aug 2024 18:01:53 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm89670b3a.17.2024.08.28.18.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:01:53 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 00/10] riscv: Userspace pointer masking and tagged address ABI
Date: Wed, 28 Aug 2024 18:01:22 -0700
Message-ID: <20240829010151.2813377-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V defines three extensions for pointer masking[1]:
 - Smmpm: configured in M-mode, affects M-mode
 - Smnpm: configured in M-mode, affects the next lower mode (S or U-mode)
 - Ssnpm: configured in S-mode, affects the next lower mode (VS, VU, or U-mode)

This series adds support for configuring Smnpm or Ssnpm (depending on
which privilege mode the kernel is running in) to allow pointer masking
in userspace (VU or U-mode), extending the PR_SET_TAGGED_ADDR_CTRL API
from arm64. Unlike arm64 TBI, userspace pointer masking is not enabled
by default on RISC-V. Additionally, the tag width (referred to as PMLEN)
is variable, so userspace needs to ask the kernel for a specific tag
width, which is interpreted as a lower bound on the number of tag bits.

This series also adds support for a tagged address ABI similar to arm64
and x86. Since accesses from the kernel to user memory use the kernel's
pointer masking configuration, not the user's, the kernel must untag
user pointers in software before dereferencing them. And since the tag
width is variable, as with LAM on x86, it must be kept the same across
all threads in a process so untagged_addr_remote() can work.

This series depends on my per-thread envcfg series[3].

This series can be tested in QEMU by applying a patch set[2].

KASAN support will be added in a separate patch series.

[1]: https://github.com/riscv/riscv-j-extension/releases/download/pointer-masking-v1.0.0-rc2/pointer-masking-v1.0.0-rc2.pdf
[2]: https://lore.kernel.org/qemu-devel/20240511101053.1875596-1-me@deliversmonkey.space/
[3]: https://lore.kernel.org/linux-riscv/20240814081126.956287-1-samuel.holland@sifive.com/

Changes in v4:
 - Switch IS_ENABLED back to #ifdef to fix riscv32 build
 - Combine __untagged_addr() and __untagged_addr_remote()

Changes in v3:
 - Note in the commit message that the ISA extension spec is frozen
 - Rebase on riscv/for-next (ISA extension list conflicts)
 - Remove RISCV_ISA_EXT_SxPM, which was not used anywhere
 - Use shifts instead of large numbers in ENVCFG_PMM* macro definitions
 - Rename CONFIG_RISCV_ISA_POINTER_MASKING to CONFIG_RISCV_ISA_SUPM,
   since it only controls the userspace part of pointer masking
 - Use IS_ENABLED instead of #ifdef when possible
 - Use an enum for the supported PMLEN values
 - Simplify the logic in set_tagged_addr_ctrl()
 - Use IS_ENABLED instead of #ifdef when possible
 - Implement mm_untag_mask()
 - Remove pmlen from struct thread_info (now only in mm_context_t)

Changes in v2:
 - Drop patch 4 ("riscv: Define is_compat_thread()"), as an equivalent
   patch was already applied
 - Move patch 5 ("riscv: Split per-CPU and per-thread envcfg bits") to a
   different series[3]
 - Update pointer masking specification version reference
 - Provide macros for the extension affecting the kernel and userspace
 - Use the correct name for the hstatus.HUPMM field
 - Rebase on riscv/linux.git for-next
 - Add and use the envcfg_update_bits() helper function
 - Inline flush_tagged_addr_state()
 - Implement untagged_addr_remote()
 - Restrict PMLEN changes once a process is multithreaded
 - Rename "tags" directory to "pm" to avoid .gitignore rules
 - Add .gitignore file to ignore the compiled selftest binary
 - Write to a pipe to force dereferencing the user pointer
 - Handle SIGSEGV in the child process to reduce dmesg noise
 - Export Supm via hwprobe
 - Export Smnpm and Ssnpm to KVM guests

Samuel Holland (10):
  dt-bindings: riscv: Add pointer masking ISA extensions
  riscv: Add ISA extension parsing for pointer masking
  riscv: Add CSR definitions for pointer masking
  riscv: Add support for userspace pointer masking
  riscv: Add support for the tagged address ABI
  riscv: Allow ptrace control of the tagged address ABI
  selftests: riscv: Add a pointer masking test
  riscv: hwprobe: Export the Supm ISA extension
  RISC-V: KVM: Allow Smnpm and Ssnpm extensions for guests
  KVM: riscv: selftests: Add Smnpm and Ssnpm to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst          |   3 +
 .../devicetree/bindings/riscv/extensions.yaml |  18 +
 arch/riscv/Kconfig                            |  11 +
 arch/riscv/include/asm/csr.h                  |  16 +
 arch/riscv/include/asm/hwcap.h                |   5 +
 arch/riscv/include/asm/mmu.h                  |   7 +
 arch/riscv/include/asm/mmu_context.h          |  13 +
 arch/riscv/include/asm/processor.h            |   8 +
 arch/riscv/include/asm/switch_to.h            |  11 +
 arch/riscv/include/asm/uaccess.h              |  43 ++-
 arch/riscv/include/uapi/asm/hwprobe.h         |   1 +
 arch/riscv/include/uapi/asm/kvm.h             |   2 +
 arch/riscv/kernel/cpufeature.c                |   3 +
 arch/riscv/kernel/process.c                   | 154 ++++++++
 arch/riscv/kernel/ptrace.c                    |  42 +++
 arch/riscv/kernel/sys_hwprobe.c               |   3 +
 arch/riscv/kvm/vcpu_onereg.c                  |   3 +
 include/uapi/linux/elf.h                      |   1 +
 include/uapi/linux/prctl.h                    |   3 +
 .../selftests/kvm/riscv/get-reg-list.c        |   8 +
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/pm/.gitignore   |   1 +
 tools/testing/selftests/riscv/pm/Makefile     |  10 +
 .../selftests/riscv/pm/pointer_masking.c      | 330 ++++++++++++++++++
 24 files changed, 692 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/pm/.gitignore
 create mode 100644 tools/testing/selftests/riscv/pm/Makefile
 create mode 100644 tools/testing/selftests/riscv/pm/pointer_masking.c

-- 
2.45.1


