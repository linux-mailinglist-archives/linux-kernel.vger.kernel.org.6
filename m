Return-Path: <linux-kernel+bounces-446172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 868709F20A1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 20:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B10B7A12FE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 19:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991DD1ADFEB;
	Sat, 14 Dec 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNMdTfuS"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115361A8F79
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734205421; cv=none; b=r9lcrY3s5CceaMo8XMy3x1Xx6L051qlkH342cVxrI8VGfHk/spGOZ0ZCyJSud4tKrG3eZfq9E3x+5Tfw0V8zcyiZHUYhxNR/4w0PIbb/EJRg2Pu3uFFFJOhnG2TpUOlOQEHWyeLxc38Nl4qlT7/wqlp6nMoc0QRlFqDLsI3GEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734205421; c=relaxed/simple;
	bh=kNTzKLgGrao7cCQvkASx5rN0agcwT+Hi5XnHhDrTTmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAsZ+iY8N1GzeOHaGq7MAGQEr/zk95nTeiioFu4W7KXSK38Z0Mqs/c1VYGTNiO5IB+5DwlRNS7ucrPxReXSLLp42zCVPaBW7Av7wijDFx1M3aH8CEbp9RXXnpMXqnswRN/Hyk2B0uhtwvdkPnE/nOaA0QZf6u5Tm6kzzL3Pg4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNMdTfuS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30167f4c1deso24676191fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 11:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734205418; x=1734810218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ja0iHQq4x8YYrPwua2vK6bgvK8Ftnd8EXGgl2zucixM=;
        b=bNMdTfuSMPbvSkFjYfilN7zLoiRrElt0FLCybK+lRx2YhfPKaXeu31kkCJsKWxwmKW
         cOeOuIznCR60tp553rPZ3aUWPe00VIO90+ZJZquIRGtH2cb7/zymzefWaLUHmLI6snrJ
         g+2QMDFx4DLHxgHrbAUo0VoNZHsFytFsSu6PWWs2GiL3uFza+9TU7ysOQgQteDY24w1R
         ZpKepjaG+GonmfVjK4PwkQuq1f1yg0Bh1uSoxAE9tB1nkWyNw7L0hQmKXwpqtKjvIDhQ
         BJBtNW9za9ZTRlahybzZYq8OBWIaqUkm/Ym2dHU5I2QOtR/0nJ/R7OHGCBYdgTGp5+Ac
         31DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734205418; x=1734810218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ja0iHQq4x8YYrPwua2vK6bgvK8Ftnd8EXGgl2zucixM=;
        b=hr4L0QCSlTWm1hiCFwvjDcnVapTAQyNsvZrsDC+R0RnJRV5k6GqhDq2uSaP9+qnBKA
         Ft/UJG63rxI1pirEa7Sj/vc71p6oHw8ipLPV1YL7PcNrLwilc3WqomTKSfdL7rmVnKjW
         wxZCdn5niGNaV+oH8n6FTH1d+b5OduvGLj/tGkO5QaxX8NBHOUO5SQm/9Kv9+zKJnhzT
         5GQFM7QQmcswCry4jUHAofaxHjE9hftMz6Ckw4Y1zc2ZY8DwAnd6xjiMn54HjzMUo87f
         xoq5+jsIlTyeOODDCMbZ1+4kZdCXUrf6gYMQ+8L62KC3lGFR3knDjT31WTg1DFyqYV5g
         9tUA==
X-Forwarded-Encrypted: i=1; AJvYcCWtiy2Lq676FYB8WqlwufT1Tj9D/uTAvFAwdbNlilf20/UYF8ad92oUqGSg1dGFzGAbnWomQ/zEAF3J3QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7nqXGDBaNKs9UyeyHbxvchj+mv54WPB8B0+JYOPQZvzZi3U6o
	1cV+RDl6bv3Tu7S4wB56+BkEZ5qtTDZHOXVLAWctLLJRO5Rhx0GPD/ZFWegIOmE5ZOgL/a4bL4q
	jVQ+AdFsg/VCpNgPhcaq0oGNTNNs=
X-Gm-Gg: ASbGncuXAJtZq2e4AIoWh4zXBv4Ql0kc+GifpVEYWE5YEQ5D5ta51aLAxubLIxETKaX
	9SSF8aWhY2KKd2PAF7naEVH2ZqbE+8kWvY1Wnbg==
X-Google-Smtp-Source: AGHT+IHvkdVjNXVm2If40s6Ce3AhrSKz3rZaHoNknyHsTGxXZFzuIka28+JyOehwjs0+jgrJ44TJCiytBItrbC91+AM=
X-Received: by 2002:a05:651c:2116:b0:2ff:a89b:4210 with SMTP id
 38308e7fff4ca-302544264d6mr25787961fa.8.1734205417785; Sat, 14 Dec 2024
 11:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675d01e9.050a0220.37aaf.00be.GAE@google.com> <CAOUHufZ+UDx5pXD7b1pBC8P0Ubu1p2Z5r6Qx+ruT5g78q02Cxw@mail.gmail.com>
In-Reply-To: <CAOUHufZ+UDx5pXD7b1pBC8P0Ubu1p2Z5r6Qx+ruT5g78q02Cxw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 15 Dec 2024 03:43:21 +0800
Message-ID: <CAMgjq7BpdyJ=Q4OW4gEeCxP9PU5u=4Mp_Bd=uqr5iaosrQJMZg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in lock_list_lru_of_memcg
To: Yu Zhao <yuzhao@google.com>
Cc: syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 2:06=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Dec 13, 2024 at 8:56=E2=80=AFPM syzbot
> <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7cb1b4663150 Merge tag 'locking_urgent_for_v6.13_rc3' o=
f g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16e96b30580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfee25f93665=
c89ac
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D38a0cbd267eff=
2d286ff
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7feb34a89c2a/non_bootable_disk-7cb1b466.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/13e083329dab/vmli=
nux-7cb1b466.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/fe3847d08513=
/bzImage-7cb1b466.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 80 at mm/list_lru.c:97 lock_list_lru_of_memcg+0x39=
5/0x4e0 mm/list_lru.c:97
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 80 Comm: kswapd0 Not tainted 6.13.0-rc2-syzkaller-00=
018-g7cb1b4663150 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> > RIP: 0010:lock_list_lru_of_memcg+0x395/0x4e0 mm/list_lru.c:97
> > Code: e9 22 fe ff ff e8 9b cc b6 ff 4c 8b 7c 24 10 45 84 f6 0f 84 40 ff=
 ff ff e9 37 01 00 00 e8 83 cc b6 ff eb 05 e8 7c cc b6 ff 90 <0f> 0b 90 eb =
97 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 7a fd ff ff 48
> > RSP: 0018:ffffc9000105e798 EFLAGS: 00010093
> > RAX: ffffffff81e891c4 RBX: 0000000000000000 RCX: ffff88801f53a440
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffff888042e70054 R08: ffffffff81e89156 R09: 1ffffffff2032cae
> > R10: dffffc0000000000 R11: fffffbfff2032caf R12: ffffffff81e88e5e
> > R13: ffffffff9a3feb20 R14: 0000000000000000 R15: ffff888042e70000
> > FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020161000 CR3: 0000000032d12000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  list_lru_add+0x59/0x270 mm/list_lru.c:164
> >  list_lru_add_obj+0x17b/0x250 mm/list_lru.c:187
> >  workingset_update_node+0x1af/0x230 mm/workingset.c:634
> >  xas_update lib/xarray.c:355 [inline]
> >  update_node lib/xarray.c:758 [inline]
> >  xas_store+0xb8f/0x1890 lib/xarray.c:845
> >  page_cache_delete mm/filemap.c:149 [inline]
> >  __filemap_remove_folio+0x4e9/0x670 mm/filemap.c:232
> >  __remove_mapping+0x86f/0xad0 mm/vmscan.c:791
> >  shrink_folio_list+0x30a6/0x5ca0 mm/vmscan.c:1467
> >  evict_folios+0x3c86/0x5800 mm/vmscan.c:4593
> >  try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
> >  shrink_one+0x3b9/0x850 mm/vmscan.c:4834
> >  shrink_many mm/vmscan.c:4897 [inline]
> >  lru_gen_shrink_node mm/vmscan.c:4975 [inline]
> >  shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
> >  kswapd_shrink_node mm/vmscan.c:6785 [inline]
> >  balance_pgdat mm/vmscan.c:6977 [inline]
> >  kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
>
> This one seems to be related to "mm/list_lru: split the lock to
> per-cgroup scope".
>
> Kairui, can you please take a look? Thanks.

Thanks for pinging, yes that's a new sanity check added by me.

Which is supposed to mean, a list_lru is being reparented while the
memcg it belongs to isn't dying.

More concretely, list_lru is marked dead by memcg_offline_kmem ->
memcg_reparent_list_lrus, if the function is called for one memcg, but
now the memcg is not dying, this WARN triggers. I'm not sure how this
is caused. One possibility is if alloc_shrinker_info() in
mem_cgroup_css_online failed, then memcg_offline_kmem is called early?
Doesn't seem to fit this case though.. Or maybe just sync issues with
the memcg dying flag so the user saw the list_lru dying before seeing
memcg dying? The object might be leaked to the parent cgroup, seems
not too terrible though.

I'm not sure how to reproduce this. I will keep looking.

