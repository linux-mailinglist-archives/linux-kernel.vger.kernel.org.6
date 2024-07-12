Return-Path: <linux-kernel+bounces-250354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0F92F6D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3070F1F22D34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A65013FD66;
	Fri, 12 Jul 2024 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TVLWO2AG"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B713D509
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720772556; cv=none; b=qO58fGatIGYXrGsQhvFxo/4L/uLGWrvpXhlxbUau/5Azm9DS2b3qAKlN/w62xHZyZot4M6WsD06Tagrgh1YL2QY/kX+coY8HS/LYeE0XLP2ggoxJY1OeGU7Q74450BqeqivEPaME6oWLIoyX/sIdu/iRHKQJytVQC59nDXX+IC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720772556; c=relaxed/simple;
	bh=iMnorGO72QICnti2YoP49R8/GBqXtA9IWU2cYiQtb5c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FZnr43y+lsxHFvyFCzESogYK8PX+/uQUjgGxJRkkNoAlUG18ArR1aRbD/YOkdpx2f0NZOvvleLTMpYyHTVcwuzPi6p9FX4ZaIG8w/q5apfHo4qfT4qSFFPfKKRDXDAu98TVr//6qyGQsX0ndA3CS6PiDOhZxMe0VG4GGyQCRRzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TVLWO2AG; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linmiaohe@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720772550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzTXdHzElp5Yr7kf1PhShgacfLoOVeYbSJNOrDB+vjM=;
	b=TVLWO2AGYeV/Av6lfzTR5DAfTdhcQByPrdBE+F4gf7ZaPhR4PbRJu/EtYQHeoCLEqSKnzW
	tyEpYrH+JG5LJ8LW+ioKd4jCRzpcd/u0JywJGbvRw36qARxm/WfDbUo3C14Tmalrd7mKFE
	1Uw1/ik+T5vYLfrQyUOBw96KCv6vKlo=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2] mm/hugetlb: fix possible recursive locking detected
 warning
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240712031314.2570452-1-linmiaohe@huawei.com>
Date: Fri, 12 Jul 2024 16:21:52 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9D19BD4-9857-4D1C-9E0A-44EA95F7BCFE@linux.dev>
References: <20240712031314.2570452-1-linmiaohe@huawei.com>
To: Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 12, 2024, at 11:13, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> When tries to demote 1G hugetlb folios, a lockdep warning is observed:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> 6.10.0-rc6-00452-ga4d0275fa660-dirty #79 Not tainted
> --------------------------------------------
> bash/710 is trying to acquire lock:
> ffffffff8f0a7850 (&h->resize_lock){+.+.}-{3:3}, at: =
demote_store+0x244/0x460
>=20
> but task is already holding lock:
> ffffffff8f0a6f48 (&h->resize_lock){+.+.}-{3:3}, at: =
demote_store+0xae/0x460
>=20
> other info that might help us debug this:
> Possible unsafe locking scenario:
>=20
>       CPU0
>       ----
>  lock(&h->resize_lock);
>  lock(&h->resize_lock);
>=20
> *** DEADLOCK ***
>=20
> May be due to missing lock nesting notation
>=20
> 4 locks held by bash/710:
> #0: ffff8f118439c3f0 (sb_writers#5){.+.+}-{0:0}, at: =
ksys_write+0x64/0xe0
> #1: ffff8f11893b9e88 (&of->mutex#2){+.+.}-{3:3}, at: =
kernfs_fop_write_iter+0xf8/0x1d0
> #2: ffff8f1183dc4428 (kn->active#98){.+.+}-{0:0}, at: =
kernfs_fop_write_iter+0x100/0x1d0
> #3: ffffffff8f0a6f48 (&h->resize_lock){+.+.}-{3:3}, at: =
demote_store+0xae/0x460
>=20
> stack backtrace:
> CPU: 3 PID: 710 Comm: bash Not tainted =
6.10.0-rc6-00452-ga4d0275fa660-dirty #79
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> Call Trace:
> <TASK>
> dump_stack_lvl+0x68/0xa0
> __lock_acquire+0x10f2/0x1ca0
> lock_acquire+0xbe/0x2d0
> __mutex_lock+0x6d/0x400
> demote_store+0x244/0x460
> kernfs_fop_write_iter+0x12c/0x1d0
> vfs_write+0x380/0x540
> ksys_write+0x64/0xe0
> do_syscall_64+0xb9/0x1d0
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa61db14887
> RSP: 002b:00007ffc56c48358 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa61db14887
> RDX: 0000000000000002 RSI: 000055a030050220 RDI: 0000000000000001
> RBP: 000055a030050220 R08: 00007fa61dbd1460 R09: 000000007fffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
> R13: 00007fa61dc1b780 R14: 00007fa61dc17600 R15: 00007fa61dc16a00
> </TASK>
>=20
> Lockdep considers this an AA deadlock because the different =
resize_lock
> mutexes reside in the same lockdep class, but this is a false =
positive.
> Place them in distinct classes to avoid these warnings.
>=20
> Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


