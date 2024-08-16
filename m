Return-Path: <linux-kernel+bounces-289924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D0F954D60
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9E4B2177B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523E11BD034;
	Fri, 16 Aug 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zDbroRxF"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E992817
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821117; cv=none; b=d3yn0cm5zgFq5utXK3yEPZt4mJ/9+AT6csXy0o3XfwmKPWcr2I2jo62G2jYmpsj2gKv/AG30gcHRhzhRHJNvi9yUeJFEBqVMA2jSLrzHNtFc6xwlqNQsEw6Gvtk6uhIOPnTMk/QeEwOaryAsthQ+vYZYkZ+Vq8spS9H4joXnNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821117; c=relaxed/simple;
	bh=i/gie7XLHA+VfpxfRdy5Seq89aVjFlrrX0L1jgd+j3g=;
	h=Date:Subject:CC:From:To:Message-ID; b=f8ig7a4PJS0EOPVmnUkOmg3lnz3RihwCNxF7jwk20MSJVJVkHrwNS2uZ+HFSvgjfr+7FP3XOMKDtB7Ep8mvMybdp0tkRxXKu0lYXZuwjEkQponSc72KpVrc9l6GrJ5RMWT+4dxI/TUSVqqS9OH252TEmglkNYO8p9PudQTRgyoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zDbroRxF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso1763431b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723821114; x=1724425914; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U51afq1GcqS7tRTdX3ZRrcbEDTDfhIP6UB/LI3wW288=;
        b=zDbroRxFytU9TTbOBuHFJRBuWGTZgOTiup80t+yfTjo8ZGfchMH5Z89roUOREz6P2F
         f/S9NeMutqFy8qMc+WT/Gtf0hf1QVE+cxTV/QusjTMM7Snd87cn1HTQLahGEYrXsUPjB
         sd8V0T2Iq95ydQJVBpYK3DCwM2Mb3E9OApzDXDiGN9CqSkFJLfn2lDUCFdrYEGycupAp
         fG8WQS5EgWG5a2SNDd1OaW6R8ABSz47sqPxaaGD+LLzY0ku2x5epuuHqrMavIF/xDIaP
         UDlK2wxVnFlxs/0Z2AbL6VIjKpH78UAIi0pItSZTLsBMvBFhC6cV/vzJN9xhGxCZO3WP
         T/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723821114; x=1724425914;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U51afq1GcqS7tRTdX3ZRrcbEDTDfhIP6UB/LI3wW288=;
        b=l+siwQWnQ9Io9o/BtAAmFyGxaVKqkim5TefHZlAAdlVk4CddbSFYiJ6rruKlX75aW3
         60GxDqb2FOuEMYwcgjUsRaiATSaTutBk2wRFB22wsGOz2gV39bOXYv6t3LFN4UFtf0ww
         q6uvIWwrBM6CJwNIzdznyhBFZ1HPwM2F34H9fbmJERcTXnsC9FiIATrS0nkayx8bXAlf
         92t9g4o5Iofl9urfSMN0e513pmo23hrkVVnYj4fazNaS07ecTjVbPBrzJes04/hcqIZz
         fmqKrromB86sE6W0vAjPii5Nrdc01q3YhTqTAAlxL42vtL3XtLhPcVtGoHzp6Qi+OkOy
         wt6g==
X-Forwarded-Encrypted: i=1; AJvYcCWbhz2HeMjkWttZdVvlU2YfnHPiz00hm0WkdDuzVei8z7fp29+D+hJXA5imcegUsSrKoi+kC0sbF6SmRG6yvKbNyUuD/Dst2/fCK1Iu
X-Gm-Message-State: AOJu0YzqIQvMoUrfNtl9OgNtgGNQu2SukR6pGL7ERT+saBP2mgTjZ5oz
	Ctfy3EU5n3AH16iJuuCPil/g772uc+v1btMMUFMk0sqhV6Ul2Bt984J9ilP9JVdxisze5clCo/6
	N6W8=
X-Google-Smtp-Source: AGHT+IEy5yhZVIs6cM7owrtaBFt5rLmWtQZjJHxSSdpXthgYQ3WZ3aHXHDT3905Vpuvu9zWimg0ghA==
X-Received: by 2002:a05:6a20:9d91:b0:1c0:f2d9:a44a with SMTP id adf61e73a8af0-1c904f91ce9mr4384814637.22.1723821113945;
        Fri, 16 Aug 2024 08:11:53 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6e46sm2823512b3a.17.2024.08.16.08.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:11:53 -0700 (PDT)
Date: Fri, 16 Aug 2024 08:11:53 -0700 (PDT)
X-Google-Original-Date: Fri, 16 Aug 2024 08:11:48 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.11-rc4
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-24597fb0-2ef5-4a27-ac81-cd0aa42fdd56@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc4

for you to fetch changes up to 32d5f7add080a936e28ab4142bfeea6b06999789:

  Merge patch series "RISC-V: hwprobe: Misaligned scalar perf fix and rename" (2024-08-15 13:12:21 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.11-rc4

* The text patching global icache flush has been reintroduced.
* A fix for the syscall entry code to correctly initialize a0, which
  manifests as a bug in strace.
* XIP kernels now map the entire kernel, which fixes boot under at least
  DEBUG_VIRTUAL=y.
* The acpi_early_node_map initializer now initializes all nodes.
* A fix for a OOB access in the Andes vendor extension probing code.
* A new key for scalar misaligned access performance in hwprobe, which
  correctly treat the values as an enum (as opposed to a bitmap).

----------------------------------------------------------------
That last patch set (for hwprobe) is sort of feature-smelling, but I think it's
sane to call it a fix -- it's kind of a grey area as to whether we even need a
new key, but we're playing it safe as hwprobe is such a compatibility-focused
interface.

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: Re-introduce global icache flush in patch_text_XXX()
      riscv: Fix out-of-bounds when accessing Andes per hart vendor extension array

Celeste Liu (1):
      riscv: entry: always initialize regs->a0 to -ENOSYS

Evan Green (2):
      RISC-V: hwprobe: Add MISALIGNED_PERF key
      RISC-V: hwprobe: Add SCALAR to misaligned perf defines

Haibo Xu (1):
      RISC-V: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE

Nam Cao (1):
      riscv: change XIP's kernel_map.size to be size of the entire kernel

Palmer Dabbelt (1):
      Merge patch series "RISC-V: hwprobe: Misaligned scalar perf fix and rename"

 Documentation/arch/riscv/hwprobe.rst       | 36 ++++++++++++++++++------------
 arch/riscv/include/asm/hwprobe.h           |  2 +-
 arch/riscv/include/uapi/asm/hwprobe.h      |  6 +++++
 arch/riscv/kernel/acpi_numa.c              |  2 +-
 arch/riscv/kernel/patch.c                  |  4 ++++
 arch/riscv/kernel/sys_hwprobe.c            | 11 ++++-----
 arch/riscv/kernel/traps.c                  |  4 ++--
 arch/riscv/kernel/traps_misaligned.c       |  6 ++---
 arch/riscv/kernel/unaligned_access_speed.c | 12 +++++-----
 arch/riscv/kernel/vendor_extensions.c      |  2 +-
 arch/riscv/mm/init.c                       |  4 ++--
 11 files changed, 54 insertions(+), 35 deletions(-)

