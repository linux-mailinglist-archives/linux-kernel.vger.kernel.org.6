Return-Path: <linux-kernel+bounces-331270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49F97AA91
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AB41C2247C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99782364BE;
	Tue, 17 Sep 2024 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukv2yPrK"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAE288DB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726546164; cv=none; b=IGvPoLh38sWD5nf82vyPBNcWHLv47KbceKDWtg4Rb14J6oF1CdYN0qnAqgYYzoWky8oNkjJf8aixXkk41kfcq87x0pp5CcnbeMWwmJJ7tu7fhpCBjSqJ5XQo3EZ6DwvZ0PLW2YZj+LkqjuMkVQtftLrxkkD8cfBhvPUU2cSft/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726546164; c=relaxed/simple;
	bh=s41gIPNddDr5DruADSSRphIhBLtBdZiqSHRYbETjL/E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=KM/AeHuJRA4t+XvvVbflcSNImNWGahZldcQ1s6N5JnoP3yuTvErjVq98Y75UprEEn/m8wpPyZ4guvFTG4Kra1tLRu4AaseXiuM+DAFaffwx8Y3FCQSL5V8dqiQiskYypCOJUGYW8TljG/N7l5CgaE214Pnj2Ue6gEYz0OciHyyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukv2yPrK; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-207115e3056so46348965ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726546162; x=1727150962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLP3iy9E8YIRIod5VuQH5Q4jITgxku5jTl2OIlXsXvM=;
        b=Ukv2yPrKF7BWTYBAsHXH2AiKMqb9vY9JhqtRfNLqaJe8ivPLp8kK1If9sayooQqebz
         6xmzVek52P6TR7rXo+81WqYw6WZS+ncmX603GtODBxLvw0kDSFaJttOTeFmOC6Qa0F5p
         +WHtwILkTjmmbouEsP2v5coaYkNR+tfhsvjh1NlfwbhiLbkPltr58JUHVL3WRp3aVacI
         sQDrlnetg0pCbNwWJFIv6rX1ZMOo41Ma+uKEWbq/dtocTSgjt8MJQ4HqOxFB71jZNL9v
         XeKuqnIj6zEe3eG9/cMQSNic3d2JFQBQNLpB3YJJyZrrMnzVltvNHxRDJwozqk7TLJGW
         RbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726546162; x=1727150962;
        h=content-transfer-encoding:cc:to:subject:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLP3iy9E8YIRIod5VuQH5Q4jITgxku5jTl2OIlXsXvM=;
        b=gMalEvyuUt8Ul1U2g5VvLrz3ahADrMy15HV+TvBLyR2D7YonVJN/ghvpKbbB4bb9jv
         ySRkbwJkrG4X/0hwOR2EwodpqEbxcs9Lkqwo/LtnePBVezqAHp6Ikf8zL33WKlAt2ZcV
         ov9qwxerF11ExgZz2/2ylG+2PdU9SkNC17uZETAfrLDoE5+OzA89++d0DjYEtNOifRo5
         herA+8nLWaMOOYA/8hNTWZ5/MOVFtELLcsIdMuDZzOYHF1NhWewTob/eBMXkjfsvyxfR
         AITC8UJqqXOo/aRxC2GL5pxNZumKiLeU00i0bhCmchd9LHhP8ZlD3fNciF77W73IfscM
         Uy8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFztrrdY1uGxioOnzaGciYBjVSzaXyCwGOcGoNkbyjDq9P5jxlrBl67wOJTUZMyUXzbPi2llVMbLCDfZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKiJHlppsSYn01eXuWC+Y0BjAgLVOjq4vDzB3wICxCsJjE0vQ
	q+6YVZRg/J+AE/YNhhLRcxw11EiVWYQwUbjAKSXEm+x5Z+X+LP/V4IZc3mQ92Oo=
X-Google-Smtp-Source: AGHT+IGtte48VDWtp7voeGx5u8hIT4MMgsMcZHq0QKlHfI2T2hgNVfvxq/b4zP5WAhQtiBQNdQKPiA==
X-Received: by 2002:a17:902:db06:b0:206:fd9b:f4f1 with SMTP id d9443c01a7336-2076e4a6ee1mr266495285ad.56.1726546161434;
        Mon, 16 Sep 2024 21:09:21 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d169csm42928855ad.138.2024.09.16.21.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 21:09:20 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <59505464-c84a-403d-972f-d4b2055eeaac@gmail.com>
Date: Tue, 17 Sep 2024 12:09:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB-large
Subject: [RFC] riscv/entry: issue about a0/orig_a0 register and ENOSYS
To: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Oleg Nesterov <oleg@redhat.com>,
 "Dmitry V. Levin" <ldv@strace.io>
Cc: Andrea Bolognani <abologna@redhat.com>, WANG Xuerui <git@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Yangyu Chen <cyy@cyyself.name>,
 Han Gao <gaohan@iscas.ac.cn>, linux-kernel@vger.kernel.org,
 rsworktech@outlook.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Before PTRACE_GET_SYSCALL_INFO was implemented in v5.3, the only way to
get syscall arguments was to get user_regs_struct via PTRACE_GETREGSET.
On some architectures where a register is used as both the first
argument and the return value and thus will be changed at some stage of
the syscall process, something like orig_a0 is provided to save the
original argument register value. But RISC-V doesn't export orig_a0 in
user_regs_struct (This ABI was designed at e2c0cdfba7f6 ("RISC-V:
User-facing API").) so userspace application like strace will get the
right or wrong result depends on the operation order in do_trap_ecall_u()
function.

This requires we put the ENOSYS process after syscall_enter_from_user_mode()
or syscall_handler()[1]. Unfortunately, the generic entry API
syscall_enter_from_user_mode() requires we

*  process ENOSYS before syscall_enter_from_user_mode()
*  or only set a0 to ENOSYS when the return value of
   syscall_enter_from_user_mode() != -1

Again, if we choose the latter way to avoid conflict with the first
issue, we will meet the third problem: strace depends on that kernel
will return ENOSYS when syscall nr is -1 to implement their syscall
tampering feature[2].

Actually, we tried the both ways in 52449c17bdd1 ("riscv: entry: set
a0 = -ENOSYS only when syscall != -1") and 61119394631f ("riscv: entry:
always initialize regs->a0 to -ENOSYS") before.

Naturally, there is a solution:

1. Just add orig_a0 in user_regs_struct and let strace use it as
   loongarch does. So only two problems, which can be resolved without
   conflict, are left here.

The conflicts are the direct result of the limitation of generic entry
API, so we have another two solutions:

2. Give up the generic entry API, and switch back to the
   architecture-specific standardalone implementation.
3. Redesign the generic entry API: the problem was caused by
   syscall_enter_from_user_mode() using the value -1 (which is unused
   normally) of syscall nr to inform syscall was reject by seccomp/bpf.

In theory, the Solution 1 is best:

*  a0 was used for two purposes in ABI, so using two variables to store
   it is natural.
*  Userspace can implement features without depending on the internal
   behavior of the kernel.

Unfortunately, it's difficult to implement based on the current code.
The RISC-V defined struct pt_regs as below:

        struct pt_regs {
                unsigned long epc;
        ...
                unsigned long t6;
                /* Supervisor/Machine CSRs */
                unsigned long status;
                unsigned long badaddr;
                unsigned long cause;
                /* a0 value before the syscall */
                unsigned long orig_a0;
        };

And user_regs_struct needs to be a prefix of struct pt_regs, so if we
want to include orig_a0 in user_regs_struct, we will need to include
Supervisor/Machine CSRs as well. It's not a big problem. Since
struct pt_regs is the internal ABI of the kernel, we can reorder it.
Unfortunately, struct user_regs_struct is defined as below:

        struct user_regs_struct {
                unsigned long pc;
        ...
                unsigned long t6;
        };

It doesn't contain something like reserved[] as padding to leave the
space to add more registers from struct pt_regs!
The loongarch do the right thing as below:

        struct user_pt_regs {
                /* Main processor registers. */
                unsigned long regs[32];
        ...
                unsigned long reserved[10];
        } __attribute__((aligned(8)));

RISC-V can't include orig_a0 in user_regs_struct without breaking UABI.

Need a discussion to decide to use which solution, or is there any
other better solution?

[1]: https://github.com/strace/strace/issues/315
[2]: https://lore.kernel.org/linux-riscv/20240627071422.GA2626@altlinux.org/


