Return-Path: <linux-kernel+bounces-563551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D1A64401
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3481678E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43921ADD3;
	Mon, 17 Mar 2025 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zlmta6fc"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7CF1D9A79
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197313; cv=none; b=eQ8SaHZKX2lucvwzJPi7eu3r2BpwWANOylINtTKqwW8qUHSD9K4ZaLhBPRZZimnlP4jzSuOKKWmncuIPOt3gGes99LHQhXnd551SQQkyjCir9Nm7myq5AeVt9KVxWsvUIRXSJZGN/Ocmz0yEK3sBluy+r3tvG4mSFac707NQogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197313; c=relaxed/simple;
	bh=RQFGRpmfHe1Gotmrdp301aRcZTQMMzE6gQFT+sG+UEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KFD2g4SFTuJvfphymPZP8xH8sU7mhzS3eny22ob4YC03ws5sn1sLmrLNea9cb8Mh+vv5hSXNgDiu9kIUXfonHPryK0owYDrklpY/82FIVxE/WtGQ+Kxe8w3uDUjgj14CLhJvXZK3iZ3/+jkwZSSVqICedQr2wpENI9+Li+YLAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zlmta6fc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235189adaeso66970075ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742197310; x=1742802110; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWPfpt8VAXB3af6uH6FGAR6gVvoFFmvCHpj+nN5EIrc=;
        b=zlmta6fcMHUePYSA45XaE6ZD9MqfUT8Z5a84Pou6NKWwZ7cZmwDYFqdC6czUT99q4Y
         BhyKluvXXBe5kWggqtzp3hrwUs784nR+Ms0scXRW3QAT9wSrV93XY2AXncEsZ+kFyY0t
         SgAAugVcoP6UGGGHCJnkwhpQVkGePwuRgjglXgAPpJ4iM7bsI9BsTts2f/h1CRBZbp2p
         J7FrMNiODH6TELuunF05YoqqW71PHQ7aGxCJmYo6kTWW3fkdUU3b4EAE3M9DMUf6ILUI
         44gWywqZfEY82p8XJXPlS/X40sZdOBKPHvXBx3HBnaSpCjfri2t94eEywD9LQEqoiCep
         8lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742197310; x=1742802110;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWPfpt8VAXB3af6uH6FGAR6gVvoFFmvCHpj+nN5EIrc=;
        b=lP0TRlyqKrw86ledJgJvu5uW8Meb68m5JWWMOJSwZmSXQIByT+rF8EQCquyrf0855N
         Xf6ziI9yYl3i9otgln4/Bjrwz8eWDuGAc2OJXgkcFxxqYqwY6jVVO/oc0A0Yi7wjIOLG
         oVIwdYUyqcU+/AGNcMJVQJ6RjxdQVSIO3w/h6bFPkE8SPKkAJsz+kb/F7N1t1t8UJfQT
         JhNTxg7X3FVP4AJsBVYbpG2Zsk8pqupqQB66y15144EOIjRibtt7KGqEJmSNVdMzMzYK
         mCRCcKfBIGi4qTKfjiBIhhavk7OyMqTfRlAkYQuDcu2J4Mwihkc7b+aM7d6iACkHhI+h
         Wzkw==
X-Forwarded-Encrypted: i=1; AJvYcCX1GPcMkigXSmb3OhSGUJysCDOH+ccEveO6Gm+WlaVPw630gu0eEbqwiIzCG3d00qWQfCVN6io9xlmq4UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzC7eUiVzkfWo0NzmfYCtcAnAnVME/QI9nEDq/nxA12OCWv1ws
	4oFm/Nnn/RoAhshebODlEXrm54hKRzLx26Rk9vKELwWtBj8QJvNwcXSamByv4lw=
X-Gm-Gg: ASbGnctcppqTwbIkKdf9T547MaXehO9bkVrzVqDC4vMAMbrsbEpchmQqg1PfukEOsS4
	5kvKFA6GO1DT7z9efecVVKOk0gERrVIq5iR8rna978dBPSxuicBh9l8/nXk1iYOr4/pLeCqw5fJ
	sVq8jIXmGBU+p2KLV7rXKhqAs+LoQ61Xmr+WYFcAZ92GLfmHC0uk9zqycm0t7sgp4SllN/Qly4g
	TkXQzCODvfBEkyU15FrHRsddEXtpe+sRb5crf57utYlWWitl2clHiUzR8b6zRom3k2omuiCgZRr
	PhBXn6RjeDbx0lPjmKeZmvDm91IPN7TqSjBmRTU2uvBOTcaB5dut3pJaUA==
X-Google-Smtp-Source: AGHT+IFs7Rf6sPUtecH+s3HQAFvCcmzDdiTgKOaVqa0qXb6f/a/R2HaloGPq4WHogQPMfmpEkOl+tA==
X-Received: by 2002:a17:902:d48b:b0:215:b1e3:c051 with SMTP id d9443c01a7336-225e16b0fa3mr112060465ad.11.1742197310458;
        Mon, 17 Mar 2025 00:41:50 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4dabsm68863435ad.233.2025.03.17.00.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 00:41:50 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 17 Mar 2025 00:41:44 -0700
Subject: [PATCH] RISC-V: KVM: Teardown riscv specific bits after kvm_exit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-kvm_exit_fix-v1-1-aa5240c5dbd2@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIADfS12cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Mz3eyy3PjUisyS+LTMCl1z8+QUAzNjoxRzEwMloJaColSgMNi46Nj
 aWgCyH6qWXgAAAA==
X-Change-ID: 20250316-kvm_exit_fix-77cd0632d740
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: Anup Patel <apatel@ventanamicro.com>, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

During a module removal, kvm_exit invokes arch specific disable
call which disables AIA. However, we invoke aia_exit before kvm_exit
resulting in the following warning. KVM kernel module can't be inserted
afterwards due to inconsistent state of IRQ.

[25469.031389] percpu IRQ 31 still enabled on CPU0!
[25469.031732] WARNING: CPU: 3 PID: 943 at kernel/irq/manage.c:2476 __free_percpu_irq+0xa2/0x150
[25469.031804] Modules linked in: kvm(-)
[25469.031848] CPU: 3 UID: 0 PID: 943 Comm: rmmod Not tainted 6.14.0-rc5-06947-g91c763118f47-dirty #2
[25469.031905] Hardware name: riscv-virtio,qemu (DT)
[25469.031928] epc : __free_percpu_irq+0xa2/0x150
[25469.031976]  ra : __free_percpu_irq+0xa2/0x150
[25469.032197] epc : ffffffff8007db1e ra : ffffffff8007db1e sp : ff2000000088bd50
[25469.032241]  gp : ffffffff8131cef8 tp : ff60000080b96400 t0 : ff2000000088baf8
[25469.032285]  t1 : fffffffffffffffc t2 : 5249207570637265 s0 : ff2000000088bd90
[25469.032329]  s1 : ff60000098b21080 a0 : 037d527a15eb4f00 a1 : 037d527a15eb4f00
[25469.032372]  a2 : 0000000000000023 a3 : 0000000000000001 a4 : ffffffff8122dbf8
[25469.032410]  a5 : 0000000000000fff a6 : 0000000000000000 a7 : ffffffff8122dc10
[25469.032448]  s2 : ff60000080c22eb0 s3 : 0000000200000022 s4 : 000000000000001f
[25469.032488]  s5 : ff60000080c22e00 s6 : ffffffff80c351c0 s7 : 0000000000000000
[25469.032582]  s8 : 0000000000000003 s9 : 000055556b7fb490 s10: 00007ffff0e12fa0
[25469.032621]  s11: 00007ffff0e13e9a t3 : ffffffff81354ac7 t4 : ffffffff81354ac7
[25469.032664]  t5 : ffffffff81354ac8 t6 : ffffffff81354ac7
[25469.032698] status: 0000000200000100 badaddr: ffffffff8007db1e cause: 0000000000000003
[25469.032738] [<ffffffff8007db1e>] __free_percpu_irq+0xa2/0x150
[25469.032797] [<ffffffff8007dbfc>] free_percpu_irq+0x30/0x5e
[25469.032856] [<ffffffff013a57dc>] kvm_riscv_aia_exit+0x40/0x42 [kvm]
[25469.033947] [<ffffffff013b4e82>] cleanup_module+0x10/0x32 [kvm]
[25469.035300] [<ffffffff8009b150>] __riscv_sys_delete_module+0x18e/0x1fc
[25469.035374] [<ffffffff8000c1ca>] syscall_handler+0x3a/0x46
[25469.035456] [<ffffffff809ec9a4>] do_trap_ecall_u+0x72/0x134
[25469.035536] [<ffffffff809f5e18>] handle_exception+0x148/0x156

Invoke aia_exit and other arch specific cleanup functions after kvm_exit
so that disable gets a chance to be called first before exit.

Fixes: 54e43320c2ba ("RISC-V: KVM: Initial skeletal support for AIA")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 1fa8be5ee509..4b24705dc63a 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -172,8 +172,8 @@ module_init(riscv_kvm_init);
 
 static void __exit riscv_kvm_exit(void)
 {
-	kvm_riscv_teardown();
-
 	kvm_exit();
+
+	kvm_riscv_teardown();
 }
 module_exit(riscv_kvm_exit);

---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250316-kvm_exit_fix-77cd0632d740
--
Regards,
Atish patra


