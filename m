Return-Path: <linux-kernel+bounces-534089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60009A4629D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F01E1891AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568E22A7F7;
	Wed, 26 Feb 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2WXZHeDm"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9DF221732
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579819; cv=none; b=cIA8DqoAyxHgY0kA+tTEvMgHJu6LETNyOl2s/yu/B4Sh89AD5c7G9YNtTdopZ/rsuv00k1QNA/0UMrAIG9/eT3zx/hWfqO+H16kI/ShQKtKqqkGDJbVA4VVjJu4iYiL0EuOqDpW6HSXr2f/Fo6+fFc2vA7uNf/tmLmBvELa0ybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579819; c=relaxed/simple;
	bh=oESKRxk7S/SAj+JzXbT8tJchADNljAklyGCeLl3hM0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FS/mpRXvrULDYC0imBtRNkA6tp8mz/Df2tWWI29TTxKwerJEushGPN1BFbzryHG3X5zdB8hi2vMr4hzYLOhc75Pn+8CIhCmpV6Gb7ymXEI7kw+AUsKJ3S34ncRIs/QTXDddMveN0qroDmzxMhgNEJKNmUmn+e607L6whdSqsstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2WXZHeDm; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-855fc51bdfcso31006639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740579816; x=1741184616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lLnbkzYFUFW6XfzIit24LipM1R/Z0yOhTI6EbT/o+g=;
        b=2WXZHeDmVrlHnboRPAA9QI6Smp2eBDLYOufLBWyiEGt/MskC000iqzPD1tYdiALD/+
         Ase5Yzyqgf8SufII8dn+EKz1cFfLZvi8a4Nadk41upoU3ZJ3VDRt6jzncraK80YivA3d
         KaRn9pfKU+vEiRXoBd1aJdU6eoupR7clRvjXfZof7YcbXripeLns0jgqP612AwDb3MzS
         4eETYPUgDt7h/FRgKXCzMOUTzZdT3yiuypjHM8y06WlbZaXhWjFn0P0McfN+r+W1MmJV
         uCEd0NfFHHErNflGjMZX+FPD7sWYVERgQibR8vIXPY+UnXUcKudUVB1qlhXyC7q8ittr
         jRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579816; x=1741184616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lLnbkzYFUFW6XfzIit24LipM1R/Z0yOhTI6EbT/o+g=;
        b=Rm2HZjranO0CMEnHP170QBoNECW8LuInYpzS3LzDH5OwFDJTrO04p6sKnbHhnlPcF2
         MRibhBHnY5DVVQWhS/k02zM794+ur8Grv1JZFnqCUzDqVR0LCqmOZfynQrdtf+tmVllU
         tIFg5XXhqsnbXy2VZEDBi3uzRYWvHtd8QdVK6BtxAu73uGVG1uo/gpe3EgRJ12aBdq6D
         NHCtMp2ynvJ4pgrM3GP+jwi6hO10wRQhIGZ0UuAKEQ59F71Vzn4Ckts1vLox/YmT7+jW
         mfJz57zjF5UwNHjWNPsyQuDXgSsRsHeQsqdDOY1JT/c7lf67o7bmx7UE+YGjqzGxDXhd
         jkzg==
X-Forwarded-Encrypted: i=1; AJvYcCVgc9bJ/62BzS8BTudZA/F1DdsUFj8Uh6YG99I2WmOa1pvORfmyi9YchRoZseXd28ta5EoQctCZ7oJaQi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLTWCvj3cgGcwFf1JBrLKIiRsGrseSEUCMkv6lBthBUO1g5wm
	eHTdPMlYocXQKEQvlwVQNCLNHrqXelwYch/KAlOkjbBa1EEaMSRj7k8iU9WZytY=
X-Gm-Gg: ASbGncvrW7Cv1Ah7wkCmBNsa1NZS8WzCPMug4FKuvJPL9DAfGe1b63GhEQURJFEqKzV
	ax7UCdEG3d0XQJj/UQ3FyDKp5VgPPGmcejnm0yhqGCmyEl27RuQmT7EvoHZLORM/xoiW4rNSmh8
	oV7deykmbwVmrJ4KwSOjrCpxE22ZqrsaBKKWOvk1flpUNb5oxK5e5DrC7gfF/ACE33lxunMMEWC
	ZvB2npisc6IV+YV2uDS0JvbsnvzkRa/DvV6R9qVPwZv0Adfqmn4LwT3hFNRUAHsdn72h8aB2EOZ
	hmQ1otceH+2z//UeNPoowg==
X-Google-Smtp-Source: AGHT+IHCTcB7uZZBwrrVwoyg1sY7x7wAOYntHYhSFAGNdVEQ0bIslcm3vAPpwn7DmMLgCW3Yu+nGVw==
X-Received: by 2002:a05:6e02:1686:b0:3cf:fd62:e39c with SMTP id e9e14a558f8ab-3d2cacde097mr187503355ab.5.1740579815860;
        Wed, 26 Feb 2025 06:23:35 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d36165339esm8144515ab.19.2025.02.26.06.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 06:23:35 -0800 (PST)
Message-ID: <aace30fd-6cdc-4608-8ca8-0cef74dd1c66@kernel.dk>
Date: Wed, 26 Feb 2025 07:23:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] general protection fault in
 native_tss_update_io_bitmap
To: syzbot <syzbot+e2b1803445d236442e54@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
 x86@kernel.org
References: <67bead04.050a0220.38b081.0002.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67bead04.050a0220.38b081.0002.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 10:56 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e5d3fd687aac Add linux-next specific files for 20250218
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13fcd7f8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e2b1803445d236442e54
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149427a4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ed06e4580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ef079ccd2725/disk-e5d3fd68.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/99f2123d6831/vmlinux-e5d3fd68.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eadfc9520358/bzImage-e5d3fd68.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e2b1803445d236442e54@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 5891 Comm: iou-sqp-5889 Not tainted 6.14.0-rc3-next-20250218-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:native_tss_update_io_bitmap+0x1f5/0x640 arch/x86/kernel/process.c:471

This doesn't look io_uring related at all, it looks more like something missing
for error injection and early failure handling in the fork path for the x86 io
bitmap handling. Possibly related to PF_IO_WORKER, didn't poke deep enough to
see if it's specific to that or not. Presumably a change slated for 6.15? It's
testing an older linux-next, so also quite possible that this is known and
already fixed, it's a week old.

#syz set subsystems: kernel

-- 
Jens Axboe


