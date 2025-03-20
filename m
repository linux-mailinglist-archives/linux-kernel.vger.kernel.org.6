Return-Path: <linux-kernel+bounces-570094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A83AFA6ABFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA2B7A732A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F00224B1B;
	Thu, 20 Mar 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qtbuxOHI"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67B22155C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491776; cv=none; b=j4jSJvNO0zHx+mnldDOSxhtC5s+mtskZhjWU/5RksDBhobWDmc9r0dfwevHC39l6CrsQEA6b4wejSEEH3CCMDGujhaMI6P2F2Qw4JZo3V9oo/k+4UMD2z3eETMRr+Ewjdsvfg0cI4mMbP80cwIbkpo51JCU4UwoSRsG1o4Lh7rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491776; c=relaxed/simple;
	bh=a8buKjZuVTHhVCVaVyShn58mf2Nkd71JLIuuvN814fY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yd3IUfbMQT4eBASbDFuklqS4Xk6AiVQbDk9tPSny2ri0btsKgvFiXFZjSi2STYKi+zBa0H27Ylewej1kkviCOg8jNg3o3RuaYPtaNvetU4JQP828x/RZNSsngoB2ZEFxfG140hxSXFDjETWsHkPm6cmb2skD4bo/pHzpD+p1rU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qtbuxOHI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22622ddcc35so28134245ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742491774; x=1743096574; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOLJdCBk/78Wkkx/KXUXc/Jejf3oa/Cc0UGcw9XLKfM=;
        b=qtbuxOHIUPiIBhICVKZs8c+zsuFUW2oQRyP77n6A1vJsKUa6Uv0NspP/j3TotPei4J
         Yo283SPt9I+urXOwcmYUWqhueM6f5OBsIVUFDZbH8J5dczJQsV6Xh/wcru5x+IY3v5uf
         +REBcn6Sw7nuGXNYVd7xlbudeBajgqcgfeFRaIHcsrUBD2E038WMwZJxuvqF/FXJ0KCX
         zMj6Hv5RTzuxWZB6eNv7JXWFPnkdVZS31wVL1F0xxXyzmbFEDHZRdxoDlddpwQ7ZzVuO
         J+lgr12EVoQjbpfKFFoNryknTnkCaEO3h2170ncV/oxkm3VLMJEYuLLs5Q0WKaNjgQsD
         RkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742491774; x=1743096574;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOLJdCBk/78Wkkx/KXUXc/Jejf3oa/Cc0UGcw9XLKfM=;
        b=FRZMN/mihMAOK7mQZn2Ewos19sBOCNHYqV8KZTizG6VZBYFyt8xNUu9TleSZ0KqMcp
         2L9/9Qjk8NQhR6ropNZXuQf32jpYoDh0vWa/U/kPT5q8ObjbzHWJo2nh1IwtFwW4DgVy
         oUBOvf2yQ2wpaeoYN4EeFrwzgehAmJVv9CAdJvIaaYTt0H57Mu/RYHXPaI5wT1NHqSmF
         rcB9H+dI/B0bw718rNbjZiisxGG0ioqxqAsDTkQ4PfrM9M2XfAGRzKvV1+1ql6he8Ogi
         3BtGhzormF1xTX+0H45QVjYVoLo+RKNxVMB/VvIJi3ZK3+iC+dXHNfBUVYT/scoHNWqG
         4fqg==
X-Forwarded-Encrypted: i=1; AJvYcCXuOAfO50C0BhP8s4bDYoKDmD7JdOTPz04SYuQ7mYQ73qXISnU05VNoXE8KMgzdSrz6D5IvUqk6QkBZ3f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHX9X2vFFoOT2+9uDZ0rSGNOjjHCYMf2bXFvSbUUd2wepXedA
	FJCUD8Mkm00yHa2tvmteWQOvBtQyez9dFyNHQiKTq+eY0evqGO+3TZAt8SMFLDI=
X-Gm-Gg: ASbGnctXuF4Fiqgr26p0QEE3Kxjh+6XKfo5xODinl5ZZPdLUiv7eZroBgZTQJ3vsyJW
	QDmhF6nlw10lGRZj0KttLcMvfL5Ygp8HhLH9D7nJuDGl5GltdWqIGkw+m3XnFwq3DarQuQq1+B3
	gFY/Cg5xTsLdQlemBUmVf+48tzR77bFcTVrr6ifzpwuXL/xGQ6P7+BBqEKavE/ayQjPQpAd+RN+
	UcZPPw+FwdIPd1H3Rn/djYP+mnYCLSoHbfiMYnMdydme+qgRHsIOFm+acM+rLZfNd+2fRR8gTSD
	XSKfLLgXuVrGX7fFOglCIDZet+STBcD48KqSr7aATO10f8POCRFlJ2vuXFHj
X-Google-Smtp-Source: AGHT+IFXuSVtt/SbthfzSQ7d/yin99emZxJRiizVTSUOUe3m9+sM1X8UQDxWeADHE07ExVrAEJGYsQ==
X-Received: by 2002:a17:902:e5ce:b0:224:8bf:6d81 with SMTP id d9443c01a7336-22780e1968dmr3057635ad.46.1742491773712;
        Thu, 20 Mar 2025 10:29:33 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45994sm554075ad.81.2025.03.20.10.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:29:32 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v6 0/4] entry: Move ret_from_fork() to C and inline
 syscall_exit_to_user_mode()
Date: Thu, 20 Mar 2025 10:29:20 -0700
Message-Id: <20250320-riscv_optimize_entry-v6-0-63e187e26041@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHBQ3GcC/3XNwW6DMAzG8Vepch6TcWIgPe09pqkawVl9KKkSF
 K2rePcFLkMTHP+f5J+fKnEUTup8eqrIWZKEsUTzclLu+jl+cSVDaYWABgxgFSW5fAn3SW7ywxc
 ep/ioqNOd0QZBI6lyeo/s5Xtl3z9KXyVNIT7WL7le1gUkqPEAzHUFlWG2RGSdH+AtSg5JRvfqw
 k0tZsatow8cLE7rkKyxOBB0O47eOubA0cXpGut101s2ut9xzNZpDxyzOp3zbQs4OLvj0J+jgQ4
 cKk5D0PY0eK8d/3Pmef4Fp6eT/tsBAAA=
X-Change-ID: 20240402-riscv_optimize_entry-583843420325
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2797; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=a8buKjZuVTHhVCVaVyShn58mf2Nkd71JLIuuvN814fY=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qdgBKJN1WZ8kWL3/nEz5zO7lCjc+zutHMHZU2l6u0vG
 7RtqzfuKGVhEONikBVTZOG51sDceke/7Kho2QSYOaxMIEMYuDgFYCISixgZZq9pOhD26vCzr4fX
 7Xh18IZ18jWF6RcO7KtT52crW/8uKILhv48Sb/bb/DkPLzx66Fw1+/PuvBcdEu1ipRP14vr/m9y
 T4wYA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Similar to commit 221a164035fd ("entry: Move
syscall_enter_from_user_mode() to header file"), move
syscall_exit_to_user_mode() to the header file as well.

Testing was done with the byte-unixbench [1] syscall benchmark (which
calls getpid) and QEMU. On riscv I measured a 7.09246% improvement, on
x86 a 2.98843% improvement, on loongarch a 6.07954% improvement, and on
s390 a 11.1328% improvement.

The Intel bot also reported "kernel test robot noticed a 1.9%
improvement of stress-ng.seek.ops_per_sec" [2]

Since this is on QEMU, I know these numbers are not perfect, but they
show a trend of general improvement across all architectures that use
the generic entry code.

[1] https://github.com/kdlucas/byte-unixbench
[2] https://lore.kernel.org/linux-riscv/202502051555.85ae6844-lkp@intel.com/

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v6:
- Update commit message of patch 4 to contain performance numbers
- Link to v5: https://lore.kernel.org/r/20250305-riscv_optimize_entry-v5-0-6507b5dff3ce@rivosinc.com

Changes in v5:
- Rebase on 6.14-rc5
- Link to v4: https://lore.kernel.org/r/20250127-riscv_optimize_entry-v4-0-868cf7702dc9@rivosinc.com

Changes in v4:
- I had messed up warning for ct_state() on rebase, correct that issue
- Link to v3: https://lore.kernel.org/r/20250124-riscv_optimize_entry-v3-0-869f36b9e43b@rivosinc.com

Changes in v3:
- Fixup comment to properly reflect args (Alex)
- Fix prototypes for loongarch (Huacai)
- Link to v2: https://lore.kernel.org/r/20250123-riscv_optimize_entry-v2-0-7c259492d508@rivosinc.com

Changes in v2:
- Fixup compilation issues for loongarch
- Fixup compilation issues with CONFIG_CONTEXT_TRACKING_USER
- Link to v1: https://lore.kernel.org/r/20250122-riscv_optimize_entry-v1-0-4ee95559cfd0@rivosinc.com

---
Charlie Jenkins (4):
      riscv: entry: Convert ret_from_fork() to C
      riscv: entry: Split ret_from_fork() into user and kernel
      LoongArch: entry: Migrate ret_from_fork() to C
      entry: Inline syscall_exit_to_user_mode()

 arch/loongarch/include/asm/asm-prototypes.h |  8 +++++
 arch/loongarch/kernel/entry.S               | 22 ++++++-------
 arch/loongarch/kernel/process.c             | 33 +++++++++++++++----
 arch/riscv/include/asm/asm-prototypes.h     |  2 ++
 arch/riscv/kernel/entry.S                   | 20 +++++++-----
 arch/riscv/kernel/process.c                 | 21 +++++++++++--
 include/linux/entry-common.h                | 43 +++++++++++++++++++++++--
 kernel/entry/common.c                       | 49 +----------------------------
 8 files changed, 119 insertions(+), 79 deletions(-)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20240402-riscv_optimize_entry-583843420325
-- 
- Charlie


