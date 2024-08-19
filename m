Return-Path: <linux-kernel+bounces-292864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76EE957573
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602A91F211FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15BE17AE1D;
	Mon, 19 Aug 2024 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zR/bcqa1"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE415CD7D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098380; cv=none; b=e2PUfQ1dom8SyAI28ygZ0Kd1xZHpHDyEJXjuI30FSmtBXa4HDytnE83xQBnmIQcOkQjgidQEMgkDikbh17szjvVdci5uVHo4CUiZUz4P2x8Nc40hdRM3gQamVLKDy8sqEN5zPjIelTr0k9+h3JqMzZ2AmjohJJWsPS2m/8sX8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098380; c=relaxed/simple;
	bh=roH/K06p8VDG8XqsTJnYQU0HdnQaIqI6zkFkCUfKHtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/N83J8UVy9xsZ+RLysM7q+pMTToHDToeLaNB+4D5CYelRjzxv++lXIEu5Px+dtq5+e9TKXtcKEGmM6WHVur6mMubqZPmWgunyypVzVv+uqJcYfDXOyNV+1PgngXkI4V3g4pm0LP1y614JoHd3vWSB+h9w20d5iAIRaO6akVp7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zR/bcqa1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so658576966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724098377; x=1724703177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IHP3IXv9tkhttF23+h9A3PLRc1T04eMz8zhHjUswxs=;
        b=zR/bcqa1BbjmwqlrydYolh5MsqcSfmw4laz2qGRTDBjrPHWRbp1kfFCmfdczJ3UXun
         4q6joI7u56bcxd0RJxq3d3YrJJbT8tw6rZCaxVfgR9JbGLjwHbMFy92NGyGGVVeWOXdc
         XXOD6HRfTKrgTJX13P+z247/LvqtjEaQ8dW4iVksRo+a2mYqqetpmtQ2Q42ZC6e7b1rS
         Wp4Fnn2JbyZP96DuqWx8gJ7iI5DpQpp/i14/ykD/hKqb+Ic680o4vWANi51nKIuGFpUM
         OS/vnI9ZtrI2tSnJtyxGxQuaWV+8QhxiBBBCZKzuRGChZvCJix89mHHKKODX8ENggqxT
         81aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724098377; x=1724703177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IHP3IXv9tkhttF23+h9A3PLRc1T04eMz8zhHjUswxs=;
        b=W+3pK29l8cDTteXls1vrZbp/aZQMuO3B3sm2PmQpgwyCEe7O7hvznATA3msuw+rWs6
         j8NPs+Yfdf5HHeocjbHCEGs7T9o3Yd5gIjFDCfI9ePkUL8WeSbTwMOiySg0Y0iLsoS4k
         6R2PjauMhOyjIB3vxM212CyMz81B5xmqh0B6ZaQ+OFQpAKuMFiD86gxmCt3lOmaHq49m
         RS/q7UUTlWosN+qkU5S8JAzArhN+WIUiZCGxHnKYFCNmeDhezbNF7UJ3X5fvFekocvSv
         66XgjJPpWxLnOC8/WjqeLHNYcE7i6ZJd+98zwEiY/NtnV0DCXk3N5GT+R7nPUoYsGTit
         9PRw==
X-Forwarded-Encrypted: i=1; AJvYcCWKY5LfnsghH8jnACzWyOqjfSpbq1VdgZEAbCK9Gyd55BayhivEavg8YKQXITBUfIaT20A1k+0ExdCCysA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYvO5uV2q2Dk8cHPdEv5GLXbveIvEAn1gD03ZHyQ3L4gj/i26
	NLz7fxte8tlEzwWeholkix0iZKnDM8E1mP9e0WsJ+SZBUi9pE+bv8MZ+eWWOAtUUVarbvuwEanM
	97PE6fNAycwgCUL9Aehf8pPGgjQRJb499FClIKvMQOjlx+AyRQJoh
X-Google-Smtp-Source: AGHT+IHf1DbTRTSJbNXcbrsMYzihXZRxQQ4bhW6nKZ/ZwU3ONcT5I+asE9RUPOGClkIBZ2C0BJ7bOTfpy8Gw9iYxzqQ=
X-Received: by 2002:a17:907:c7e1:b0:a7a:aa35:408e with SMTP id
 a640c23a62f3a-a8392930f8amr894532566b.27.1724098376142; Mon, 19 Aug 2024
 13:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000060cf79061fd24ca8@google.com>
In-Reply-To: <00000000000060cf79061fd24ca8@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 19 Aug 2024 13:12:20 -0700
Message-ID: <CAJD7tkYWMkcFeXKA2S71PoZAubS+0R29G5qbhTSLLCcd7DfqkQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: syzbot <syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Ying <ying.huang@intel.com>, 
	Barry Song <21cnbao@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:52=E2=80=AFPM syzbot
<syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1248910598000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ba6f3b22ee5=
467
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dce6029250d7fd4d=
0476d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/dis=
k-367b5c3d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinu=
x-367b5c3d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1/b=
zImage-367b5c3d.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 11298 at mm/zswap.c:1700 zswap_swapoff+0x11b/0x2b0 m=
m/zswap.c:1700
> Modules linked in:
> CPU: 0 UID: 0 PID: 11298 Comm: swapoff Not tainted 6.11.0-rc3-next-202408=
16-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/27/2024
> RIP: 0010:zswap_swapoff+0x11b/0x2b0 mm/zswap.c:1700
> Code: 74 05 e8 78 73 07 00 4b 83 7c 35 00 00 75 15 e8 1b bd 9e ff 48 ff c=
5 49 83 c6 50 83 7c 24 0c 17 76 9b eb 24 e8 06 bd 9e ff 90 <0f> 0b 90 eb e5=
 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 7c 90 48 8b 3c
> RSP: 0018:ffffc9000302fa38 EFLAGS: 00010293
> RAX: ffffffff81f4d66a RBX: dffffc0000000000 RCX: ffff88802c19bc00
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff888015986248
> RBP: 0000000000000000 R08: ffffffff81f4d620 R09: 1ffffffff1d476ac
> R10: dffffc0000000000 R11: fffffbfff1d476ad R12: dffffc0000000000
> R13: ffff888015986200 R14: 0000000000000048 R15: 0000000000000002
> FS:  00007f9e628a5380(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30f15ff8 CR3: 000000006c5f0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __do_sys_swapoff mm/swapfile.c:2837 [inline]
>  __se_sys_swapoff+0x4653/0x4cf0 mm/swapfile.c:2706
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9e629feb37
> Code: 73 01 c3 48 8b 0d f1 52 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a8 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d c1 52 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007fff17734f68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a8
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9e629feb37
> RDX: 00007f9e62a9e7e8 RSI: 00007f9e62b9beed RDI: 0000563090942a20
> RBP: 0000563090942a20 R08: 0000000000000000 R09: 77872e07ed164f94
> R10: 000000000000001f R11: 0000000000000246 R12: 00007fff17735188
> R13: 00005630909422a0 R14: 0000563073724169 R15: 00007f9e62bdda80
>  </TASK>

I am hoping syzbot would find a reproducer and bisect this for us.
Meanwhile, from a high-level it looks to me like we are missing a
zswap_invalidate() call in some paths.

If I have to guess, I would say it's related to the latest mTHP swap
changes, but I am not following closely. Perhaps one of the following
things happened:

(1) We are not calling zswap_invalidate() in some invalidation paths.
It used to not be called for the cluster freeing path, so maybe we end
up with some order-0 swap entries in a cluster? or maybe there is an
entirely new invalidation path that does not go through
free_swap_slot() for order-0 entries?

(2) Some higher order swap entries (i.e. a cluster) end up in zswap
somehow. zswap_store() has a warning to cover that though. Maybe
somehow some swap entries are allocated as a cluster, but then pages
are swapped out one-by-one as order-0 (which can go to zswap), but
then we still free the swap entries as a cluster?

I am not closely following the latest changes so I am not sure. CCing
folks who have done work in that area recently.

I am starting to think maybe it would be more reliable to just call
zswap_invalidate() for all freed swap entries anyway. Would that be
too expensive? We used to do that before the zswap_invalidate() call
was moved by commit 0827a1fb143f ("mm/zswap: invalidate zswap entry
when swap entry free"), and that was before we started using the
xarray (so it was arguably worse than it would be now).

