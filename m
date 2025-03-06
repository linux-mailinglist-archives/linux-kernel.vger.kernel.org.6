Return-Path: <linux-kernel+bounces-548055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA5A53F48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A280F18934B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1CC1AAC9;
	Thu,  6 Mar 2025 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oVLOjvKU"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28317C68
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221848; cv=none; b=pwg7fryY1YS9wz+Bq6R/WeKTUnZEDcc68Vz5s2rZ6fSjitRiQ+oxOrtagYpjc7li9fCl9v6K4NkovAe5iBt0AX3Imsb/3czjb1Cfw1xy1gWrIr5jYbUjNqZCaeRlLd4FFTAEmfkj0ZSh3t/gDnEVsMipd3oxbQ7r9dVVTpRWnvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221848; c=relaxed/simple;
	bh=/XPBPYPK+Ts2ontme00hSLTZRIeMbEhmEiIPzB22szs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kSeg0pEsEnNWp7zhTGkaJZ8vJSAy/YJcfRQRZa5TkE+1Z7zhy42glsw4p9Vu3WgXsjFLvJ5YqzLLBcv5yWsVoxx7Bkw5GlPrdyBrooUZ5Hg9k6VFTWVhvjSAjUv6cdsWpamGpOgye5IOwn1+OVTBsL+MCNZjwSkoM0YtKx0LnIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oVLOjvKU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223594b3c6dso761925ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 16:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741221845; x=1741826645; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl5pQMvwhs9KXlNz+24dCzwkEL5L1AwJPXBGp3tpzqo=;
        b=oVLOjvKUV8ITmqzw2n8O7x22uK5gA4WHqVjzuCajVfJ2zUFg5SCa1b4zDv7RryNhmK
         N1/IlLoHz5lOWNJguMv7spiRxuwJkY+9S85C0UdWKjxTH83R4xk96Ks7icnKgoDyIvz/
         GXRYixWJyri3Jy9zGq5uaXOh1z2ISMAIcG3O/JTn5IWCiU8T2RuEZ0re/l+jiQflA5Ws
         DNIe/8JjpPocp3kDX2QOsJ2lPUtdm7igOYBm1NKTDbAyiflQ2JKL5zsex12NoC7OMKjj
         VBpYEETL19dxz/ggkdql01kWwzjDqQFm/FP0bUXY9ovtCg8zqjJ7GWswTn9YAgSaELbx
         7E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741221845; x=1741826645;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yl5pQMvwhs9KXlNz+24dCzwkEL5L1AwJPXBGp3tpzqo=;
        b=b0Uj981owQpCNDc9c9CAxV0Mf3zQzHXUmtNhmLyIUfD/CRX8MuJ5I2g7uISeN26VMx
         kifXDoGq/NSi2q0h/uXTkue3y5E+SQudheEhakzfsCO9c9vD3kOhHb5i7Skcp/q+s1Jr
         MTugm2T5epM/dIwklp4eDCBU+S6ZWwulCx+GWDc31woitdLuYW/DyJuHcJOgfmonwD/C
         30CuMQWsHL8oEHxb/GKx1RsdMuP+S6bAoxAcKWso9qYUDp8SHAbaoe1sDslFu3pMjDPe
         o/yMrtGsb9spXGyP3esBnI9OKy9PZVLwmUi64zeHAKtjOXkXrxh6yZup4CxTPrT8cyyC
         YXmg==
X-Forwarded-Encrypted: i=1; AJvYcCULKGAU3GsCYFmGE0xzUeaigwDAab+25cjMgIWyT3dowdgGBHl5pohxv/AFS+GqwpMAkamEU08p9TswR6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2Ex5zcRj0IaLc5cbotl//UuD88U2QW//cX5xa/gYOutgSjIX
	md2h1XbQF/zf2PGlUkwq27d3ES4vQTr+jBupf2/lynHUY9Jc8QC6RAOPz0TQq14=
X-Gm-Gg: ASbGncu9zBD1FQlyWWo4EYaFL6UHNRcb0Zb0EPq53TBl9QV7qustJS3WM/vYXWao6xe
	J9QNOZ7EYWbiqdKHq48+hnbn90jjxut6pkx/yml1o7i2kdbW9IcGVqbAx5arYrBphqMccKFkw5r
	OdqBD3R4UcIqdwpESoySe2BuxX7CR46EmG1OjiWDUoGl2HiNp+2GQ4tPf8/Jd+JAYH3CPwUAjk1
	1hnuJ3S1UvYTZQXocEaQLH8RoniV0yVmfYH3eHCU4J83kTxQ6XKdko9nef5eDBmqAE7b8KyeQ1p
	8eYdXj876DrDepNe5UmG8F315cgi8+fV4Jd4IwSVJ9BKiAa0i5fJ7Zvji8ov
X-Google-Smtp-Source: AGHT+IHI2rP2Hyd2lOR7EMEDGvOEHYUYseZqcPAUg2IT9Fva6WUyScEehXV53qnCOoMF9yh/zzST8w==
X-Received: by 2002:a17:902:f710:b0:21f:2ded:76ea with SMTP id d9443c01a7336-223f1d6ccddmr92798435ad.36.1741221845509;
        Wed, 05 Mar 2025 16:44:05 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f7efsm347085ad.132.2025.03.05.16.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:44:04 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v5 0/4] entry: Move ret_from_fork() to C and inline
 syscall_exit_to_user_mode()
Date: Wed, 05 Mar 2025 16:43:43 -0800
Message-Id: <20250305-riscv_optimize_entry-v5-0-6507b5dff3ce@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/vyGcC/3XNwW7CMAzG8VdBOS8odWya7LT3QBMaqTt8oEFJF
 cFQ331pTxWix/8n+eenypyEs/rcPVXiIlniUIM+dipcfoZf1tLVVmAADRrQSXIop3gb5Sp/fOJ
 hTA9Nzjq0CMYCqXp6S9zLfWGP37UvkseYHsuX0szrDJJpYAMsjTYamT0R+dB35itJiVmGsA/xq
 mazwNqxGw5Upw1AHj10ZNwbx64d3HBsddzB9/Zw9oz2/MbBtdNuOLg4LvRta6AL/sWZpukfmPs
 pi5MBAAA=
X-Change-ID: 20240402-riscv_optimize_entry-583843420325
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=/XPBPYPK+Ts2ontme00hSLTZRIeMbEhmEiIPzB22szs=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qJ92c6erj6L4quN/7dqcybGPVlekXdFbf23JKd89sNn
 093enajo5SFQYyLQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgIlcfsTIcOXwk9z4c12MHic+
 SL44N4X38GztPo8bhyp5i4s+sRisWsrwP7XpyOZn0m+5BC8/XdKZ9zfBw/v5w+91ZyS1G972H52
 Rxw4A
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


