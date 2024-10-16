Return-Path: <linux-kernel+bounces-367100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF399FE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455181C20E97
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC82413B2A9;
	Wed, 16 Oct 2024 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nvw1MOwE"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF82AD05
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044063; cv=none; b=YAHZpf+nfsmV0IWN1e7YfA+y7gVdT9gCnXL7RQnfQ+gx53YQ0C/fYSvDWCL34A+JLMxm80WBmCMlYLsWOGZ54iRXv8BVi4vDCjJxf4osVExF5c45+G6nqvAnjWRxeZjBKU/6IkPubrcB5AeIcsm4G9096M0uprbm37hjUn7trsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044063; c=relaxed/simple;
	bh=+tTQoSMZJbUIDWsdXj5qaLiAn1eaws/NSN0sxTLk5sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVjIf2Qt5D4il+VZ9bEs2OPDdFGK53xPyAl9VCbj5nnOmFYtXzkcBwvar5aCssnWHQzaq42Oj39GtbfafnzLjj00bR6w4OndnQlrSocTcTfeh3Eilyu46idZt3LuNL+8BfqJn1GgOQGMc2JImJpTzB19E074ENtQhu69n3FYF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nvw1MOwE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so2866372a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729044061; x=1729648861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjdF83VlrbVADYYFqH056kVZqXqXUHSQcUuwvGhhM/s=;
        b=Nvw1MOwEIF9+nQ23WB28R/lhfnuRF60NtClwZbncPD1plojrXmj0znkTHJiSytBIHY
         GbubeIp6a8cHb7GoKSlW+qcHAcJLuFcAljKcjcCPHtWsbZsQK58ByGLf/hM89bDiZc7Y
         v+KwAMSlgvHIf4XEQg3irjoTwXxvs3tYzH621a9/hEm0JXvi0LZi/xppZONFPA4ilKH5
         DQqaElRXKa7sMtMKLvP+aatQLi8iA3rdC24wxltlWpZFKOECKHJI3Jc4+DyP+LX/hPDp
         nQZW1ogDKi20GVYJjFvJFDAH8Nzp4W5xVPHySfQkX70NZLsz62d7YKbHwxmcS7zlA66H
         0dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729044061; x=1729648861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjdF83VlrbVADYYFqH056kVZqXqXUHSQcUuwvGhhM/s=;
        b=MKSqOUypyUc6uG6zXAh2nCmk175fqVXc8wRlue1W1TTvLkPvFUNbE0LIvxIkIu4Mil
         UEzCLaut6M1JfE7X3NeVwPLROxIQWesFmFSwK9ax/E4wAztCrNe3s9rElLGWAB/OR0RP
         u0lFOgyS3ILFMMQXIB7NToa51BvvJTujYmMb07DbP8wBDa71QNOXO77rVB+F4pyeoxo0
         hy4FBrsUTYvqchdJu/XYLWkWe96ouYQ/0pk/AO0YLyX9bu3psnf9Elwq7RHVzVNdGajh
         1YqzOLm+voCLo30k6FLClYV5opSfIfYpYrRed/5hWpcLMcVq+1XXBDTT2ZNhmJ1/OPmz
         XQ4w==
X-Gm-Message-State: AOJu0Yy1+XAduc6gWAhK6fPfawLd1e676Uth5+wBPnbho9HC/FxYk359
	h2R/EroncD/d5sqMX1XkOREjuIY9yO719TPhIIlf0ZesabcT+4DXeD8wXg==
X-Google-Smtp-Source: AGHT+IGTo5vwqIGen0iuQ3I83a8w2na+LjvUJxDE1CmWV1EC8EIKbfPu4l2PT5AfP/GP1mvyUOoXjA==
X-Received: by 2002:a17:90b:4a0c:b0:2e2:abab:c45b with SMTP id 98e67ed59e1d1-2e2f0b02013mr19703099a91.21.1729044060717;
        Tue, 15 Oct 2024 19:01:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805a180sm18828865ad.242.2024.10.15.19.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 19:00:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 15 Oct 2024 19:00:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.12-rc3
Message-ID: <714fbeca-bbdb-4993-9581-eac145288ee7@roeck-us.net>
References: <CAHk-=wg061j_0+a0wen8E-wxSzKx_TGCkKw-r1tvsp5fLeT0pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg061j_0+a0wen8E-wxSzKx_TGCkKw-r1tvsp5fLeT0pA@mail.gmail.com>

On Sun, Oct 13, 2024 at 02:46:23PM -0700, Linus Torvalds wrote:
> So the diffstat looks a bit odd, because one of the fixes here caused
> the UTF tables to be regenerated, and an effective one-liner change
> turned into 6703 lines of diff.
> 
> But if you ignore that effect, everything looks normal. We've got all
> the usual driver updates (gpu and networking dominating as usual, but
> there's some minor updates in USB, fbdev, mmc, thermal...), some
> filesystem fixes (xfs, smb client, and ntfs3), some core networking,
> and some tooling (selftests and some perf trace include file refresh).
> 
> And the usual random noise elsewhere (io_uring, scheduler, some MM noise)
> 
> Shortlog appended for people who want to quickly scroll through the
> details. It may not be exciting, but it's better than doomscrolling

Looks (almost) good here.

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 556 pass: 556 fail: 0
Unit test results:
	pass: 467226 fail: 0

Somthing I think I didn't report earlier:

There is an LSM related warning seen when booting some ppc emulations with SMP
enabled. I have not been able to bisect this. It is new in v6.12; it was first
seen with v6.11-2574-ga430d95c5efa2. The log is below. Maybe someone has an idea
what might cause it.

Guenter

---
...
LSM: initializing lsm=lockdown,capability,landlock,yama,loadpin,safesetid,ipe
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/smp.c:807 smp_call_function_many_cond+0x4f4/0x9d0
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc3-00013-geca631b8fe80 #1
Hardware name: MPC8544DS e500v2 0x80210030 MPC8544 DS
NIP:  c017c984 LR: c017ceac CTR: 00000000
REGS: c267dd40 TRAP: 0700   Not tainted  (6.12.0-rc3-00013-geca631b8fe80)
MSR:  00021000 <CE,ME>  CR: 24004288  XER: 20000000
GPR00: c00225a4 c267de30 c254c5c0 c26924c4 00000000 00000000 00000001 c2690000
GPR08: 00000000 00000003 c2690000 00000000 84004288 020a6fb8 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 c0000000 00000001 00000000 cfffd140
GPR24: c017ceac c26924c4 c0022544 00000000 00000000 00029000 4bffd2e0 00000000
NIP [c017c984] smp_call_function_many_cond+0x4f4/0x9d0
LR [c017ceac] smp_call_function+0x3c/0x58
Call Trace:
[c267de90] [84000282] 0x84000282
[c267dea0] [c00225a4] flush_tlb_kernel_range+0x2c/0x50
[c267deb0] [c0023bb4] patch_mem.constprop.0+0x108/0x1b0
[c267ded0] [c00188ac] arch_static_call_transform+0x10c/0x150
[c267def0] [c2035fa8] security_add_hooks+0x138/0x24c
[c267df20] [c2034dac] capability_init+0x24/0x38
[c267df30] [c20352bc] initialize_lsm+0x48/0x90
[c267df50] [c2035b9c] security_init+0x2e0/0x5b4
[c267dfa0] [c2001154] start_kernel+0x5d4/0x81c
[c267dff0] [c0000478] set_ivor+0x150/0x18c
...

