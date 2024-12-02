Return-Path: <linux-kernel+bounces-426813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B299DF8E7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A8D162852
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D61F957;
	Mon,  2 Dec 2024 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGEz8QOU"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA7134A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733106618; cv=none; b=B6IG1AzTqQxo4XjvnJzRYOqvXDauZ5RUI5kc3YrM84Eh2ZLwbRsjCmYX00oz4ZhOTTCvNAkZ+VQBjj+fGlYi2/ZivxBFIoOHP/zOaqv8XfVZPwmn13hAfVXM/g0wYaZLfiecZ6YBliKKTCeiPd/hCWpv/ifP+fxMKa5nY9hHnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733106618; c=relaxed/simple;
	bh=UasHOhXWqK2VHEpjgyR7+gZk3zibFWvyGHpLvZQ1AS4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Jgmf1Ye/2QsINyOXMKsi3tqY2rKuO2ugrgnDY794Ymbi76ULOF9zTKWp9HAAaJazlgUpp+xPqV5CwPkY3XIfShLGO4Pa4ltMYp3KRkIN1DkuuzA1U8OKaeFRx9uHiSltlFW3CZ+Py0X+JhKTscLKv05x2qB+7y01j1qHC0Ekhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGEz8QOU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5b0d8bd41so416922466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 18:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733106614; x=1733711414; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UasHOhXWqK2VHEpjgyR7+gZk3zibFWvyGHpLvZQ1AS4=;
        b=MGEz8QOUR+fktu1aMuFC0RkKQUXqmDyEi4dwits6+wzhtyBOVvvyvB5UgReAWCx1Qk
         8IicwX1qgEwOjxG7mv17XsqnBLeY7F8VQQpMq4VYacQ8uIldeP2Ly7iFRNII5yPAneGs
         dCsjUWVsUDm8VX3FiQfQ8lrM7XflzU8C7mOLPiMl/tsg7bxqUJTl3RULAn7+rKU22uPF
         12ciZUzMIIj69DG76+pw5jtwDiqVIl4SbxKL5lswql0h0VqE3UHg6/GRsqSdYqe2zYBD
         OKNmfIuRK65lGgq905IEBi7TSAChIrHt/1b48eho7I2IrtCmfzUEUjndq8pzzXpjUXHu
         Nsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733106614; x=1733711414;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UasHOhXWqK2VHEpjgyR7+gZk3zibFWvyGHpLvZQ1AS4=;
        b=RqBPy4s/u3VfLkTxf86GeGazyogBRetC2JkDP/UBPaE62dWEQ6zUcuSvf/p/WFeC0B
         War/ko6QRS6I2rPgcaoHQI6G6fF9yZZYxXnV6aNO356o7kngmoi8srzRyOaNgJBt1SRi
         ef2KLxl2v6yY+0Hjeu3rf/tH6ZXBMIUU3UlYLqJpWeZNNv9tQjT6/UqQS7o8nuo9d+B/
         MPiPZrlza0E2GqDf4AMfGioHZYCaLc1rJbdaYAev268BWLLwq41FxLNTyqQWk9qI+rn/
         zY4kCUOGV/nsG6CPWY//HnZ4bxWeX2fevo1jTF5G/gCs/3ogPavopXZmThXJx72yiGmf
         0hhQ==
X-Gm-Message-State: AOJu0Yzs2h+UrCN+C5InRCh9O5xOU8mHZ/ySdu5oqTWKolPCUOFoPVAn
	BxLupUocPo3bfN8ks++8VB1fVwPeyrbCLwruqgGgLMPUEW6eUOSowvuwrb5LrSUL8zevhvB7WWf
	zZLMHSg7AVJJmEHTiWoOODFsvYRG+sXFDLAs=
X-Gm-Gg: ASbGncvwi23WJWfLVuAwgNyQfSQQMn1Z/8xsSaaskzCeuz2CHlJh4gEZGScitmW4WXQ
	w+kf+6M261lR6tPmaKUDMQOVfKEKxB1Iy
X-Google-Smtp-Source: AGHT+IFJ6oH+axaldNgl27KN/5n53acNhGWmm5fAxqQZSBw0/3BxWquwKkMkTbz0Ct7h0VcSC+mfQFdn37Ev1EAcZes=
X-Received: by 2002:a17:906:3152:b0:aa5:2232:c8e4 with SMTP id
 a640c23a62f3a-aa580ee8d1cmr1817194966b.11.1733106614289; Sun, 01 Dec 2024
 18:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Mon, 2 Dec 2024 10:30:02 +0800
Message-ID: <CAKHoSAuAirmoVE6oS6a7FVfJe9u9wsjfxxhNagvsfZVzZpg06A@mail.gmail.com>
Subject: "BUG: unable to handle kernel paging request in do_wait" in Linux
 kernel Version(2.6.32)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 2.6.32, specifically on the PowerPC architecture.
This issue was discovered using our custom vulnerability discovery
tool.

Affected File:

File: kernel/exit.c

Function: do_wait

Detailed Call Stack:

Unable to handle kernel paging request for data at address 0xffffffb4
Oops: Kernel access of bad area, sig: 11 [#1]
Modules linked in:
REGS: c05cbc60 TRAP: 0300 Not tainted (2.6.32)
DEAR: ffffffb4, ESR: 00000000
GPR00: 00000004 c05cbd10 c0591330 c05cbd48 00000001 c0591328 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
NIP [c004ab64] do_wait_thread root/linux-2.6.32/kernel/exit.c:1544 [inline]
NIP [c004ab64] do_wait+0x94/0x1d0 root/linux-2.6.32/kernel/exit.c:1619
Call Trace:
[c05cbd40] [c004ad28] sys_wait4+0x88/0xe0 root/linux-2.6.32/kernel/exit.c:1749
[c05cbdd0] [c000524c] fuzz_start_one+0xc94/0xd04
root/linux-2.6.32/init/executor.c:676
[c05cbfc0] [c0555e38] start_kernel+0x324/0x338 root/linux-2.6.32/init/main.c:682
Instruction dump:
60000000 60000000 60000000 7f7ddb78 <853d0110> 3be9fee8 60000000 813f0118
Kernel panic - not syncing: Attempted to kill the idle task!


Root Cause:

Based on the stack trace and the information from the kernel, the
error occurs when do_wait tries to access an invalid memory address
(0xffffffb4). This address seems to be related to a pointer
dereferencing issue in the function, possibly caused by a race
condition or an invalid pointer being passed to do_wait during the
execution of a wait system call. It is likely that the code does not
properly handle certain edge cases, such as when child processes are
already terminated or improperly cleaned up.

We would appreciate it if the kernel maintainers could investigate
this issue further. If additional details or steps to reproduce are
needed, please let us know. We are happy to assist in any way we can.

Thank you for your time and attention.

Best regards

Wall

