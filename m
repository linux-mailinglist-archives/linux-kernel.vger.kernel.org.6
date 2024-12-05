Return-Path: <linux-kernel+bounces-434047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0359E60AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BECC161A61
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFB21CD213;
	Thu,  5 Dec 2024 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3a/vp+u"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2D82C60
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733438097; cv=none; b=ZrLYIRkiwxbCluUtYLIVI8WXZ+cu57DD0b01H1de8bqpHcGPaxEj+w4Bo2u875AyjSKeP3y4DnAfIouXJCF0bbR07xuTO9rpqGg1DQHfOJqKMrbP6e6CEW6FolODnKiUbrZ6ewg5Vf3kzEtQaC3lNLvE/fsaL0x278NaVw5+Fm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733438097; c=relaxed/simple;
	bh=FnQaNkcu7dDxH+zvtXWyoCPp/aNTj9xdEOfQHlWj7Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClgbsUfc+s8/tTQBPt3IumLTCRsbPR2Qdb9gwg5BidxQeBUYSPq2qkWrh6AVVfWZb6a7QTszpBlZWjyKYdivMVSqNNvXxaF4+pw/05YW/vCfQKoU+9YSQsKr6qriKlIlnKrH+hcVnAV/yvePtbveLwmln9h9E9JaNEm8N7o2glY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3a/vp+u; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-85b88a685e6so657254241.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 14:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733438094; x=1734042894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLx0UrhMjsM+bsbSPe2mE/rBZDFhSYSE+W0KTlYQMoU=;
        b=Q3a/vp+uo2QcuBQdzf129uM0CaVArHIAu1E196LEOM5gS8IMWmJ8EjPGJA5Iea4ik8
         YH1UK1Wyr/xSa7XaFjivvk6bXhVfqvSqsb6cwtdMjRVe0b8CZOa74+g4EAJDpvIuz0Zv
         m2eDI2mGO1O1jYjhvs0T1nB/2D1ErulSUvKnrJ0S1tBuPM8VPtwS978kbwr2ktEbNsH8
         nF2qfhTohYt8kiI6vrxKIGKSjq7NMHOlrVn/vX19748r40CqXh7gHc/rjoyCPBLEa7t5
         Kjv/lXj1qtmIYv+HyFi8QQSe7/X3J86lIv1gT5SrHx82CJnZlGNroeiOUh0vLgjkPbL6
         91Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733438094; x=1734042894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLx0UrhMjsM+bsbSPe2mE/rBZDFhSYSE+W0KTlYQMoU=;
        b=AhdV77xb/cgvdu7fTBCLLvIcF80y9XhH6qquD9IQWSFrvREByZZkOv3jClNNVw7JvN
         9Gi60j6h64Q+rmFZ/RaaYdZww/MD606Nvx2uOL0CT3kSvrEPkzH5k0vK8755IHZpBDUa
         FVS9RvBzBHCBsA+Yi2OF+Kq9vwzDLWFI3OcjpD5qnzRysMniPhfRtjVHdBUNNXuVNXIh
         NvJAlsNfW2dhyT9O7UdWVpOfD0O4fGrXVG07VqeWMajqxV4qv2+lmBHxVGRseFettmP7
         F22WY3iXNrFN+fybDLn/nv5T3oinrYnbW2sQr+YF5NB0jeek84QXYoA+IbP70N7F72Ff
         AGQw==
X-Gm-Message-State: AOJu0YzWvPCmBuXdrdKEGlKHbeQQrWV9rLAyJDR1YkzQ49dSqOaAMaDw
	xn6+mMuXlTTnQfgPmLrciI+T94sCnRSbefojoLqNE0hDHrZ3Qu7Z6MppP0i0qetz6IWwOWs09K7
	VV5VbPGp8zS6zaABpmrbutVym1IRruI5HIhBT
X-Gm-Gg: ASbGnctNseWhTi/EFQymKK8kbphA8l2PszRkwE7i/rYuuCT46EI4jzhTGZPcjGuN24T
	6TugtaZy2hMg/mK7vS3ASNHxkmarp52aF2Ph+OWA0YUNjPGYPy38ez+qaaIkYCrS1
X-Google-Smtp-Source: AGHT+IGdlSzVsxN2i3IUqTbhLairIN+DaWZozKb0+YQo6tNQdU7eZRUZIA5Ng27UkaLzWpj9aPfuNXN0OApz6OKdGVQ=
X-Received: by 2002:a05:6102:3583:b0:4af:597b:ef with SMTP id
 ada2fe7eead31-4afcaa1b3f4mr1474027137.8.1733438094317; Thu, 05 Dec 2024
 14:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67294349.050a0220.701a.0010.GAE@google.com>
In-Reply-To: <67294349.050a0220.701a.0010.GAE@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 5 Dec 2024 15:34:16 -0700
Message-ID: <CAOUHufbF5wFv1LrOm6L+kZC1oOegqSaX94cgHP__RXEUc__2Rw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in folio_update_gen
To: syzbot <syzbot+e5a74963d40b07387bdf@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:25=E2=80=AFAM syzbot
<syzbot+e5a74963d40b07387bdf@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1263458798000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D704b6be2ac2f2=
05f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De5a74963d40b073=
87bdf
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/760a8c88d0c3/dis=
k-c88416ba.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/46e4b0a851a2/vmlinu=
x-c88416ba.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/428e2c784b75/b=
zImage-c88416ba.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e5a74963d40b07387bdf@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 85 at mm/vmscan.c:3140 folio_update_gen+0x23d/0x250 =
mm/vmscan.c:3140
> Modules linked in:
> CPU: 0 UID: 0 PID: 85 Comm: kswapd0 Not tainted 6.12.0-rc5-next-20241101-=
syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> RIP: 0010:folio_update_gen+0x23d/0x250 mm/vmscan.c:3140
> Code: 00 48 3b 4c 24 60 75 2a 48 c1 e8 29 83 e0 07 ff c8 48 8d 65 d8 5b 4=
1 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 74 c0 bf ff 90 <0f> 0b 90 e9 91=
 fe ff ff e8 46 9f ee 09 66 0f 1f 44 00 00 90 90 90
> RSP: 0018:ffffc900020deb40 EFLAGS: 00010293
> RAX: ffffffff81d5fd8c RBX: 0000000000000000 RCX: ffff88801cbb8000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc900020dec00 R08: ffffffff81d5fc19 R09: 1ffff1100d562d00
> R10: dffffc0000000000 R11: ffffed100d562d01 R12: 0000000000000003
> R13: 1ffff9200041bd70 R14: ffffc900020deb80 R15: ffffea0001308000
> FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7fecc34866 CR3: 00000000223a2000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  walk_pmd_range_locked+0x92b/0xf90 mm/vmscan.c:3514
>  walk_pmd_range mm/vmscan.c:3594 [inline]
>  walk_pud_range+0x1f16/0x2310 mm/vmscan.c:3621
>  walk_p4d_range mm/pagewalk.c:259 [inline]
>  walk_pgd_range+0x4a9/0x17e0 mm/pagewalk.c:305
>  __walk_page_range+0x15f/0x700 mm/pagewalk.c:412
>  walk_page_range_mm+0x58f/0x7c0 mm/pagewalk.c:505
>  walk_mm mm/vmscan.c:3665 [inline]
>  try_to_inc_max_seq+0xdd9/0x13b0 mm/vmscan.c:3902
>  get_nr_to_scan mm/vmscan.c:4740 [inline]
>  try_to_shrink_lruvec+0xb30/0xc70 mm/vmscan.c:4783
>  shrink_one+0x3b9/0x850 mm/vmscan.c:4832
>  shrink_many mm/vmscan.c:4895 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4973 [inline]
>  shrink_node+0x37cd/0x3e60 mm/vmscan.c:5954
>  kswapd_shrink_node mm/vmscan.c:6783 [inline]
>  balance_pgdat mm/vmscan.c:6975 [inline]
>  kswapd+0x1ca9/0x3700 mm/vmscan.c:7244
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>

This is caused by "mm/mglru: rework workingset protection" in
mm-unstable. Will post v2 today to fix this.

