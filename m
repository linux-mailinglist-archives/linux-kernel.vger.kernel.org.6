Return-Path: <linux-kernel+bounces-576156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4844A70BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA76A7A5147
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C0266B52;
	Tue, 25 Mar 2025 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqMz+5VY"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C113633F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936093; cv=none; b=eBKwm23HdQTsEatKF/tjXaVdFRj3OZ1nZSHNHPYS2fDqtNNozKL83DtAQHSBVl1Oem3TmRfn75pq5iECMrg2T8mmVZCU2CHD2pecS43H2n5+JQO8rlVtUB0bx0PMFHG8QMN31ii3LNdjdaHEqubWZ+n7QATlqWY+fKVJclyP8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936093; c=relaxed/simple;
	bh=wDO5brfwuvU0njQCpCPI4An6cjU0coUF0Lw3Fy5eGoA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KS8m0rZ7koeCfw/9scTPmD7Yf88bhoqwUW+aLlNePqUZl+snqz6XcTPWkqbBXDThuYiw6/7FQeWaEgJaw2V0IGq6THiFAx+ReQk31RIUPOVHwaF0lg3eJwRiNnZPvM1JrfNVxptTFYYHk5+hXTfG/UAWGAOoWI9+C5lW0UG/X2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqMz+5VY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390f5f48eafso3399925f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742936090; x=1743540890; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyFOLkOK0PY2QuJaBv8RWrzwGhMN0UUodjjc59xWs7M=;
        b=LqMz+5VYsvMpbIBe+TfZNULdWmaqjb+PDnD/sbfRFCfnkgM2xcvFHAqD6Ro5DLjiNC
         rFA4+E7VI+ZJfglXqrEpoCF9MGfWsoJA2BmTXzLHkpJuPh6FQ1vVNf8gYfkr1gQuS4eF
         b3sC1f7h8Z+2e/IlhSGa8YayVUhsJ7r0A9OXn6RobGFNI8vkbPYTUiUYORixmydvPkYe
         3AAS6dpQNAUsdkIv8ABGI4R80Y+ASsWtQe9x1bePDpmSfdiyqRo+mDyfD4QZLkHXiWTy
         lKtimwskxVZDeO/px8rY/VHN6F5GmeLKMEVoCYPhidhGxEzhPuBPvs5QNEYxoxqNJYSW
         NoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742936090; x=1743540890;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyFOLkOK0PY2QuJaBv8RWrzwGhMN0UUodjjc59xWs7M=;
        b=n2BWJSlhc3tuM6/bzMBOULKYC7LU86jfbdJ4DOKnlW3qbNpJ4sKbVFW3YGKrgICqpa
         16iVOLWNgKFY2tfuA1bBHS7mUqAFBizhdQMk5PAYH/kBapNQgbB5CbNf0gc4hOuZ3cPp
         2QKddpTyVfVCptfssCS0e8IYmRmE/oINvyRLSw/a7YkV488KCGWxp+YYB58ROqJomlEO
         SmOiVZD9JwLo8TPj+04aNhMdMgxYLhh0w8S9qxv/dXw5SaHlNoAvSJOvlG1H1eypnFY+
         +yU/zta+R7jPhxV3ggwdkQb1H88CH44Uxzt4e8YVAFeFp8e/VDYzgl6gzjzEcxQqYGl9
         PEhA==
X-Gm-Message-State: AOJu0YyfTwTWPyhxhQ01zPXn9Q/CN6PcvEDe7mbj4GMhQC/UJvLnYBbR
	HWy6iXdS1dQwd2YgiN7CrxT093RQUOkClQwpLen5nunRba4mV9qZTkY3rw==
X-Gm-Gg: ASbGncuVK6TI9yp/QSrV+wHzDdxYZVqQNolAIG63rN/OLuGvVvdoU53cFpm6bTx7REW
	+exfc9qW5uHGRuQdORvyQHvufiOn2VqhnuQa0BJ0d7DkowGbIYgpLC14iy6xVZOD0GMmA4N3+7c
	CgPDy1hfUpdjBIiyLeQ14EapcNTMEW9qlOdBCcSZx6HdmdcptGMHK1VMSdqPXUobUxwnU58ujZC
	ZXiIjK8ttzXBwuRL+8q2ohUV5/GFIUp7ECtyv4j+Tw585FHd4LZIW8eG2qKQxg6jbOzcRVLhI+n
	9NpCjpXbl7JqQff4B9BBTy5HzaoYSJmdH89NV7IyaFz7qd0h6xkssRnp8hH8F9Fii5srTBOeWPH
	n0UuLjbhOJ0CV4cpbJCPQyhTEkL2AVRiuqTgSsgXnr+wkX/8lwmYoTNLZq5s7Ae9pagm+ytCKnR
	1Gih83ylW4kH1dvw8El2YXVDAg/VC+zvNMcJAx
X-Google-Smtp-Source: AGHT+IGFb80aE7jV3lDsJbASljgZFnN9Uv0dm5aC0DNq8j0wojX1CCyfp+YnUz+Noj38a8lLvvybKg==
X-Received: by 2002:a5d:648b:0:b0:391:4763:2a with SMTP id ffacd0b85a97d-3997f937afbmr17898055f8f.47.1742936089889;
        Tue, 25 Mar 2025 13:54:49 -0700 (PDT)
Received: from ?IPV6:2a02:3100:adcc:da00:51b6:a03e:5d6b:f4c7? (dynamic-2a02-3100-adcc-da00-51b6-a03e-5d6b-f4c7.310.pool.telefonica.de. [2a02:3100:adcc:da00:51b6:a03e:5d6b:f4c7])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d7413cf10sm15357625e9.37.2025.03.25.13.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:54:49 -0700 (PDT)
Message-ID: <ecc308bc-3520-4a65-9f17-2109c4f5d280@gmail.com>
Date: Tue, 25 Mar 2025 21:55:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Unpatched return thunk in use. This should not happen!
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I get the following with today's linux-next, did not occur on linux-next from March 12th.
System is a N100-based mini-pc.
Over the last days I see several changes to the x86/entry code, therefore think it might
be related. If more info should be needed, please let me know.

Unpatched return thunk in use. This should not happen!
WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:3107 __warn_thunk+0x26/0x30
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-next-20250325+ #2 PREEMPT(undef)
Hardware name: Default string Default string/Default string, BIOS ADLN.M6.SODIMM.ZB.CY.015 08/08/2023
RIP: 0010:__warn_thunk+0x26/0x30
Code: 90 90 90 90 55 48 89 e5 80 3d e3 18 3a 01 00 74 06 5d c3 cc cc cc cc 48 c7 c7 08 cd 56 ad c6 05 cd 18 3a 01 01 e8 4a e7 03 00 <0f>>
RSP: 0000:ffffb5e80006fe18 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffffacd76060 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000003 RDI: 00000000ffffffff
RBP: ffffb5e80006fe18 R08: 0000000000000000 R09: ffffffffad94ece8
R10: ffffffffad91eca8 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000044 R14: ffffffffadb7e794 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff924949d68000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff9248ffbff000 CR3: 0000000021050001 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? show_regs.part.0+0x1d/0x30
 ? show_regs.cold+0x8/0xd
 ? __warn_thunk+0x26/0x30
 ? __warn.cold+0xc2/0x15e
 ? __warn_thunk+0x26/0x30
 ? report_bug+0xe3/0x170
 ? console_unlock+0x7d/0x110
 ? __warn_thunk+0x26/0x30
 ? __warn_thunk+0x28/0x30
 ? handle_bug+0x116/0x170
 ? exc_invalid_op+0x18/0x70
 ? asm_exc_invalid_op+0x1b/0x20
 ? iommu_dma_ranges_sort+0x30/0x30
 ? __warn_thunk+0x26/0x30
 ? __warn_thunk+0x26/0x30
 warn_thunk_thunk+0x16/0x30
 ? __cpuhp_setup_state_cpuslocked+0x65/0x310
 do_one_initcall+0x54/0x390
 ? debug_smp_processor_id+0x17/0x20
 ? rcu_is_watching+0x11/0x50
 kernel_init_freeable+0x268/0x2b0
 ? __pfx_kernel_init+0x10/0x10
 kernel_init+0x15/0x120
 ret_from_fork+0x35/0x60
 ? __pfx_kernel_init+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
RIP: 1f0f:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_RAX: 1f0f2e6600000000
RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX: 2e66000000000084
RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI: 00841f0f2e660000
RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09: 000000841f0f2e66
R10: 0000000000841f0f R11: 2e66000000000084 R12: 000000841f0f2e66
R13: 0000000000841f0f R14: 2e66000000000084 R15: 1f0f2e6600000000
 </TASK>
irq event stamp: 5001
hardirqs last  enabled at (5009): [<ffffffffac76cdae>] __up_console_sem+0x5e/0x80
hardirqs last disabled at (5016): [<ffffffffac76cd93>] __up_console_sem+0x43/0x80
softirqs last  enabled at (4592): [<ffffffffac6d7f4c>] __irq_exit_rcu+0xbc/0x120
softirqs last disabled at (4587): [<ffffffffac6d7f4c>] __irq_exit_rcu+0xbc/0x120



