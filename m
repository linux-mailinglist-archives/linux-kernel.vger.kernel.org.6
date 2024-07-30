Return-Path: <linux-kernel+bounces-266693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496EB940564
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D731F21137
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0181A3A27E;
	Tue, 30 Jul 2024 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FlGnuy+W"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA501CD25
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722307299; cv=none; b=J6x/l3U03pwOd2GC7f9Too+UBSOCE+GVUnJVo4d+7apskNZNJiJBH5ZQWlhadh82Bb7JRKeD4ghLTY8l9LUr94pKd8+8KP+wh1IdHNTZSbU6fWeCFqPbxWMtCjEqcHB+ulB3Vk9IissZ1qczhhG08V3nE8QYqouiXyTh0MCEsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722307299; c=relaxed/simple;
	bh=QupL3Qy5mJ9MW5eVVMCzVCtBU9HllfgV8WFwBaqaIPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjDDqa/V6cyepqEVGO+i20osn3znWF4qIJO8NurQHBKZ25qEfZljPuKyPmEYRkwkCnx/WAQnd7vu+u+vDzuAhTV+L4/KErknyueU3Qkl0swPHJQh+QN89nCDhFrlS8BRp3wTNx1mMf2h30JI8VVYsSo1Fo4mPsPwZFw2NcVTAQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FlGnuy+W; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso1803578276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722307296; x=1722912096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swmyOjkfUmU3Nh1PVR3m2FvlDULsiDyeC7HJRNJVo7E=;
        b=FlGnuy+W8BijOOsrcJg3Nm6AqWulKMprDApWYUjmHrIyvmUGrCx4LXTQZH+36Mpy4b
         ObL5NaVM9JzWxv0XxHXerzLIpB7UP8QG67WkOHQp1qDjBgGIJ9ANVNuggvNqGKSq09f4
         E6nfTC1NzqzyfiqvxKh3oEN53K/cKcRdOTmNx0eWei80qEuXj2A++WBSh+eh/DsWPkrp
         TTxzr0+pguOSa188qMlosGsYsGY2ZtcoCmci4r0L+Nw88MknvWYT/P0MNoVThMScVHVt
         P403sL4K2xjbgiLMmSAb0zw35BOs6Dp7MVmP3hHd+J6AsK1/uMoxXGQ2K3XWwTvd3DMt
         7kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722307296; x=1722912096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swmyOjkfUmU3Nh1PVR3m2FvlDULsiDyeC7HJRNJVo7E=;
        b=EqI9B4b4Mny4BVkAP7sqKR5ys3bIjkFEH7hAog50k7tH1TG96fTgB2gRXh9HKtfi2E
         Pqwcf2YLZzZ4/6UBUb4GuOHYjW2gOl8mHbDTnjgZ0IYiGbw/v1voNjoX8IusIqouW9sR
         r1VAeAJFg/cVbnEMMNWy4/em7pS/BHpTHHyU7XbP1SuTGaEBYbLqJIVX6mMChKlY1xLQ
         BS5T3ChlNiyEEfyumPujHDAW55Xdc8JcDA+RWqr1dcn39tLjWDTU4ntCd3nceRQ98kJ2
         pqColbC3MwjjXwCvEsA7dpmPxdbo9Mub/xl/ugwMVbFxwvP/M8RHU003hm7lawDPv3Yp
         qBGQ==
X-Gm-Message-State: AOJu0YyBu396oQ95LOkM3nRMrfRQjgwYcdDPhjiFhQH5TIX6/X5fUD3t
	oPfuHjomoOgMDBP7D/MgguwqrAj7wJmd+qYQlCJXaUtWxnxXV0Qhtef9tb0WCEeSUOOOQ6xbmfr
	2u9PNBHrWJqMMfUEXI9BhdMA9G+Rly7pN0HF6
X-Google-Smtp-Source: AGHT+IFFVL5pHMLYfNHIKgIyx7wsZcS7yYj2rz5k0QKGk5SrFoNMj1ioYU3aLkIpYOrJSxAlWbXVSVvaeftYuc6SLSU=
X-Received: by 2002:a05:6902:1449:b0:e03:5f4e:3265 with SMTP id
 3f1490d57ef6-e0b545e5eb2mr11871895276.51.1722307296316; Mon, 29 Jul 2024
 19:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69e5485b-9ce8-4dd5-b84c-0b36d96841b0.bugreport@valiantsec.com>
In-Reply-To: <69e5485b-9ce8-4dd5-b84c-0b36d96841b0.bugreport@valiantsec.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jul 2024 22:41:24 -0400
Message-ID: <CAHC9VhQN5NOU+d15N2M0soaabG-po7bHVtHK2LDpmXh6ydOVJw@mail.gmail.com>
Subject: Re: WARNING: zero-size vmalloc in sel_write_load
To: Ubisectech Sirius <bugreport@valiantsec.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jmorris <jmorris@namei.org>, 
	serge <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 11:15=E2=80=AFPM Ubisectech Sirius
<bugreport@valiantsec.com> wrote:
>
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec.=
 Recently, our team has discovered a issue in Linux kernel 6.8. Attached to=
 the email were a PoC file of the issue.
>
> Stack dump:
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 13730 at mm/vmalloc.c:3247 __vmalloc_node_range+0x10=
a4/0x1490 mm/vmalloc.c:3247
> Modules linked in:
> CPU: 1 PID: 13730 Comm: syz.2.627 Not tainted 6.8.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:__vmalloc_node_range+0x10a4/0x1490 mm/vmalloc.c:3247
> Code: 25 28 00 00 00 0f 85 9f 02 00 00 48 81 c4 70 01 00 00 4c 89 e0 5b 5=
d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 ad e2 b4 ff 90 <0f> 0b 90 45 31=
 e4 eb 9d e8 9f e2 b4 ff 48 8b 4c 24 40 31 f6 45 31
> RSP: 0018:ffffc90001847978 EFLAGS: 00010212
> RAX: 00000000000018a9 RBX: dffffc0000000000 RCX: ffffc9000bb89000
> RDX: 0000000000040000 RSI: ffffffff81d5ca03 RDI: 0000000000000007
> RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff888000deeb48
> R13: dffffc0000000000 R14: 0000000000000000 R15: 1ffff92000308faf
> FS:  00007f7457ffb640(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000001ef56000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  __vmalloc_node mm/vmalloc.c:3385 [inline]
>  vmalloc+0x6b/0x90 mm/vmalloc.c:3418
>  sel_write_load+0x286/0x1b60 security/selinux/selinuxfs.c:592
>  vfs_write+0x2b2/0x1090 fs/read_write.c:588
>  ksys_write+0x122/0x250 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f74571958cd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7457ffafa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f7457333f60 RCX: 00007f74571958cd
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 00007f745721bb06 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f7457333f60 R15: 00007f7457fdb000
>  </TASK>
>
> Thank you for taking the time to read this email and we look forward to w=
orking with you further.

Similar to your other report, this warning/panic appears to be the
result of attempting to load a bogus SELinux policy with panic_on_warn
enabled, and similar to the other report I would expect the system to
gracefully fail to load the bogus/empty policy in those cases where
panic_on_warn is disabled.  Have you noticed any unexpected behavior
with panic_on_warn disabled?

--=20
paul-moore.com

