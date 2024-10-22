Return-Path: <linux-kernel+bounces-375547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA549A9730
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C4FB21359
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DFF13A416;
	Tue, 22 Oct 2024 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJv6GDh6"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB113A3FF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568392; cv=none; b=fdHqs2LU1pxIjL5UMLSv+dFW2N7S6mYBKzqxRoKhQkePEidhLLNO+Udp9WMsL2cwRHl4iGNKRwkGLMQ5WvbZ9mJesvOP8pMPUIxy5BWny2LlWw9z9FfCwYjZ/Vx4HnLSmv6fSNDKNNmfNaoniPRW/+96OfUgbaIV1CgwAybR3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568392; c=relaxed/simple;
	bh=2ERHprLwGxIqjvO17eC+C7LY+jRucomUgMrLzTfvUgw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Tzoyo8f0GH8eujkTV3lK/fPEIOhXfnXfgGeB5zZxmAjTapRDofdM3ducF2k32xFa23CHPo62/JuSEHQaO3ONcKPpDeZ/IREaiZGywxqoQiwa131BtzKbJhhiDfB1bA5/ovKVxfIAx2flv17EA9cr2RRwUmrY88bItftwKY7Kt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJv6GDh6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso3922066a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729568390; x=1730173190; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=spsaMZsKCVaR6klXBbr2ISPdVYP/2QLSe1/E8O7xM2w=;
        b=VJv6GDh6Lo80vJwRJTaiO/v2kYYqm2PPWTwcpRcve0KS2BY0uhgrcByLkVuRaqnvRQ
         QEmSs9m5A5x/XiT0dBPVmmx6SLYWvHAvDrgGnX2ZsAXu3vFmhZj4um85IeqAC+UDG2dR
         J5Rt/IeJJh02kaanPWU9EqQWKlsO9hGT218Gs9iAgthnHRNRD5Q3UA0Kbz6C5k6je+Z3
         F2EzpJ90LJ9J4kB3keTvvVUiAViK3Of96G01hqex342BB2h0645b1El+kuC33BTDqrlp
         UVJ+aAgalfC6VZQauyrc4zXAPbp16OHaw/z312J8GUD2kIqBggnyK691mB4/OFWDqCfv
         hRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729568390; x=1730173190;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spsaMZsKCVaR6klXBbr2ISPdVYP/2QLSe1/E8O7xM2w=;
        b=W1qnagZp0y195dpE668HkQDQDqSVw5RrcAQQi6T2/7+UhnJjoRRWcPaGaxdPQDZmZX
         0mVo6K6oBsFQ0r+67t0ZVRl36U3FpX/S94d9djXtpwUaOEENLz1NYhkVL3H3clKvHVTW
         uGYzTAddXBhgjggCPaOLeNQiTCXFtE9qfTWlR8sZZZU5VtUANqv6cZitybrz54WswTn1
         NHgGu9Vlu+pkqofYDpuSP8WNtuvq9t+ZYX0MfkQrFoWg0KW4Q6M/noQwgMoVO0Z1LS4N
         kb1X/DWFYJEL4a2lxHalZ9G3VjJZN5Tes91JYjZOhkRDIm6G68qtwZs1yMGVfPmFFJrN
         09bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9YG5L+5xV1tfC5yj/GAKSMc5I4ZhajuZUYwb8g7nTafrPGy2yRQiHXQ6nJLLbc7DT3tx8IalJXiWY2e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRGGqG4r43nHTL98f1MVbkA0oIGf8FFnt1gT/WJd/HeLww5ZH
	P5oHOOkecdZAkfYmB8shVLw+ExS07RRy5RtVgLk9X5MAVQsP9VD/
X-Google-Smtp-Source: AGHT+IGddUf1mPCsPCWffBNPDtLWSUehvxpbptM8hcCGx+md9aZqciN7QKYEXR3bow3OQyfazrO4aw==
X-Received: by 2002:a17:90a:ac1:b0:2e5:e43a:1413 with SMTP id 98e67ed59e1d1-2e5e43a16dcmr348166a91.9.1729568390362;
        Mon, 21 Oct 2024 20:39:50 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad25cb7asm4873339a91.9.2024.10.21.20.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 20:39:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, Heiko
 Carstens <hca@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Hari Bathini <hbathini@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, Pavithra Prakash <pavrampu@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH v3 01/12] powerpc: mm/fault: Fix kfence page fault reporting
In-Reply-To: <87plnsoo2y.fsf@mail.lhotse>
Date: Tue, 22 Oct 2024 08:39:05 +0530
Message-ID: <87o73cygtq.fsf@gmail.com>
References: <cover.1729271995.git.ritesh.list@gmail.com> <a411788081d50e3b136c6270471e35aba3dfafa3.1729271995.git.ritesh.list@gmail.com> <87plnsoo2y.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Hi Ritesh,
>
> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
>> copy_from_kernel_nofault() can be called when doing read of /proc/kcore.
>> /proc/kcore can have some unmapped kfence objects which when read via
>> copy_from_kernel_nofault() can cause page faults. Since *_nofault()
>> functions define their own fixup table for handling fault, use that
>> instead of asking kfence to handle such faults.
>>
>> Hence we search the exception tables for the nip which generated the
>> fault. If there is an entry then we let the fixup table handler handle the
>> page fault by returning an error from within ___do_page_fault().
>>
>> This can be easily triggered if someone tries to do dd from /proc/kcore.
>> dd if=/proc/kcore of=/dev/null bs=1M
>>
>> <some example false negatives>
>> ===============================
>> BUG: KFENCE: invalid read in copy_from_kernel_nofault+0xb0/0x1c8
>> Invalid read at 0x000000004f749d2e:
>>  copy_from_kernel_nofault+0xb0/0x1c8
>>  0xc0000000057f7950
>>  read_kcore_iter+0x41c/0x9ac
>>  proc_reg_read_iter+0xe4/0x16c
>>  vfs_read+0x2e4/0x3b0
>>  ksys_read+0x88/0x154
>>  system_call_exception+0x124/0x340
>>  system_call_common+0x160/0x2c4
>
> I haven't been able to reproduce this. Can you give some more details on
> the exact machine/kernel-config/setup where you saw this?

w/o this patch I am able to hit this on book3s64 with both Radix and
Hash. I believe these configs should do the job. We should be able to
reproduce it on qemu and/or LPAR or baremetal.

root-> cat .out-ppc/.config |grep -i KFENCE
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
# CONFIG_KFENCE_DEFERRABLE is not set
# CONFIG_KFENCE_STATIC_KEYS is not set
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
CONFIG_KFENCE_KUNIT_TEST=y

root-> cat .out-ppc/.config |grep -i KCORE
CONFIG_PROC_KCORE=y

root-> cat .out-ppc/.config |grep -i KUNIT
CONFIG_KFENCE_KUNIT_TEST=y
CONFIG_KUNIT=y
CONFIG_KUNIT_DEFAULT_ENABLED=y


Then doing running dd like below can hit the issue. Maybe let it run for
few mins and see?

~ # dd if=/proc/kcore of=/dev/null bs=1M

Otherwise running this kfence kunit test also can reproduce the same
bug [1]. Above configs have kfence kunit config shown as well which will
run during boot time itself.

[1]: https://lore.kernel.org/linuxppc-dev/210e561f7845697a32de44b643393890f180069f.1729272697.git.ritesh.list@gmail.com/

Note: This was originally reported internally in which the tester was
doing - perf test 'Object code reading'  [2]
[2]: https://github.com/torvalds/linux/blob/master/tools/perf/tests/code-reading.c#L737

Thanks for looking into this. Let me know if this helped.

-ritesh

