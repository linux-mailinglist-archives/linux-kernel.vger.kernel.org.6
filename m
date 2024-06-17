Return-Path: <linux-kernel+bounces-218095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C386C90B939
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47274285AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CB417839B;
	Mon, 17 Jun 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aJTjXudC"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725D16EB68
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647940; cv=none; b=oYf5VSgZ7d+Rj+tUyKVfPDGIUN8cRdgHs6yhIP86EPPIX4rMoooHLsuIDsug1hAADqb06MFVGMSYbtvUN+F/12nfNsjpqu8wxzGXxr+HTb8TpAfZwwa1KLMZ9eEXBtBYdH0RwQb9RUtblpV+g7Syed7MxCSCtbb45t+ZOCmzIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647940; c=relaxed/simple;
	bh=85mzD/rXPumjZYGVDHMmhtm3+FReSyOvrXdVouQnc5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj5TtKQjMzOeZRvOh3Silln/BRKrKxfd7S/C/rRPasKH/AHjI4jBruUFZH2KMxXZ8egqcRLzpATHPrDrP5wJ6RJvI1UihBsAJWkq1oIswl7b3x+xiR7RDaIfGrQRyuP+vo3zf9dM1jFAchPL0TXw+QZvvzAOhWZ4xJgTM5kndPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aJTjXudC; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yuzhao@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718647932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyPGVUBymB+/dAn/SDVvysy+ZYXiJ+churruGuGt89w=;
	b=aJTjXudCImxKiLB8FD+NmjoJnnfFghCAgJu+35izCvXsQzxLtmKnOG85hHMCmUXdY4HCkb
	6B1QD4R4It4nCCx1dThpdNLqulhb4IQ6/Qd1q8KbKWaJfMURr56fqwjWW5J7d2JFkNvogZ
	1CZWObta0v7hdTA7H+kVlFG78Bn7Jm4=
X-Envelope-To: syzbot+12f0383f30f497b7f266@syzkaller.appspotmail.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Mon, 17 Jun 2024 11:12:06 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yu Zhao <yuzhao@google.com>
Cc: syzbot <syzbot+12f0383f30f497b7f266@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in
 folio_evictable (2)
Message-ID: <jm44auneoeak3bwnqupyspmzc3u4kqbomrlzkdoetjt45ivogj@bcvh2633zioi>
References: <000000000000c89573061af04607@google.com>
 <CAOUHufa=0MW2Esc3eW8BnDF84GPh5T3A75ngJKMbvacSiv_5tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufa=0MW2Esc3eW8BnDF84GPh5T3A75ngJKMbvacSiv_5tw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 16, 2024 at 08:19:59PM GMT, Yu Zhao wrote:
> On Sat, Jun 15, 2024 at 11:42 AM syzbot
> <syzbot+12f0383f30f497b7f266@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    2ef5971ff345 Merge tag 'vfs-6.10-rc4.fixes' of git://git.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12873d96980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39
> > dashboard link: https://syzkaller.appspot.com/bug?extid=12f0383f30f497b7f266
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > userspace arch: i386
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ef5971f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/85722ebc781d/vmlinux-2ef5971f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/27fd8bd02a1e/bzImage-2ef5971f.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+12f0383f30f497b7f266@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> > BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> > BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:259 [inline]
> > BUG: KASAN: slab-use-after-free in folio_evictable+0x7b/0x270 mm/internal.h:353
> > Read of size 8 at addr ffff88804b68ab18 by task kswapd0/111
> >
> > CPU: 3 PID: 111 Comm: kswapd0 Not tainted 6.10.0-rc3-syzkaller-00021-g2ef5971ff345 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0xc3/0x620 mm/kasan/report.c:488
> >  kasan_report+0xd9/0x110 mm/kasan/report.c:601
> >  check_region_inline mm/kasan/generic.c:183 [inline]
> >  kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
> >  instrument_atomic_read include/linux/instrumented.h:68 [inline]
> >  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
> >  mapping_unevictable include/linux/pagemap.h:259 [inline]
> 
> The memory folio->mapping pointed to was RCU freed and
> mapping_unevictable() was under the RCU read lock.
> 
> So probably the owner of that folio forgot to clear the mapping?
> 

This seems like duplicate of another syzbot report at
https://lore.kernel.org/all/0000000000008874480617ff1bad@google.com/T/
and https://lore.kernel.org/all/20240614131856.754-1-hdanton@sina.com/T/

#syz dup: [syzbot] [mm?] KASAN: slab-use-after-free Read in lru_add_fn

