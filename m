Return-Path: <linux-kernel+bounces-248808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D077492E241
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CEAB26928
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB79155CBA;
	Thu, 11 Jul 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bPTvYvQU"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199815251C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686515; cv=none; b=BazTV37UWBOq3DEWZ3cZhDJo08vaIoYIW/DTxpl9VWUp1vDH8ry1yqyKSgXZDuTasziIc59qg4QPvxoyV04U7pmhHk8hZXa4Qh9BWI1/Tc2YdEXNACfA5C0y4//W5BecIeGH9iHqmEoLtkbvjAoV2x5AuJovvXSsjxeof0UeVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686515; c=relaxed/simple;
	bh=sMJALD6QpLleiF+/o/3n5vpgPF6CBDyh8l43ManS1jQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E5hBC97QF7EVFJDxW7e6MALIE41aQoilHw5mrOxdvcEfs1/t+XA6ipTfTixRnReJ+yrZvrAMSpI/bad/wYVkRko9Nq7yzTW1pJ7mzjfpfngJ6LE17X0qsdajgtjMURIAeCoVAdgbMGH8yIXdOR6HKk/VZmjybRTDLE1Qvrhby/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bPTvYvQU; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linmiaohe@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720686511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mH7YvbDfbr9uzZLaQHK+MYUTko+iJS+stQEW+FWvG0=;
	b=bPTvYvQUfg5Kil01e6fYYu1kOB5sPmKedoYRIrqoebLi2qLbF9fUqparmf8DwyW8gk1P33
	KUlBF7j3g17UKF7Iz/kEIdOMbdtbtHDDp8UPXp4jXcRkc+SqCKRoRYR+8I9t0+r9QzObxS
	Ltw9rJFBk6woiFW1ipoPAf4R1xhTuKY=
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
Subject: Re: [PATCH] mm/hugetlb: fix possible recursive locking detected
 warning
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240711071001.3475337-1-linmiaohe@huawei.com>
Date: Thu, 11 Jul 2024 16:27:46 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A12CD33-A3C4-4328-ACB5-CF08C8202DC9@linux.dev>
References: <20240711071001.3475337-1-linmiaohe@huawei.com>
To: Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 11, 2024, at 15:10, Miaohe Lin <linmiaohe@huawei.com> wrote:
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
> ---
> mm/hugetlb.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 45fd3bc75332..2004e6d3f7ca 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4659,6 +4659,8 @@ bool __init __attribute((weak)) =
arch_hugetlb_valid_size(unsigned long size)
> return size =3D=3D HPAGE_SIZE;
> }
>=20
> +static struct lock_class_key hugetlb_resize_keys[HUGE_MAX_HSTATE];

It's better to let this into "struct hstate".

> +
> void __init hugetlb_add_hstate(unsigned int order)
> {
> 	struct hstate *h;
> @@ -4671,6 +4673,7 @@ void __init hugetlb_add_hstate(unsigned int =
order)
> 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
> 	h =3D &hstates[hugetlb_max_hstate++];
> 	mutex_init(&h->resize_lock);

mutex_init() already declares a lock_class_key structure by itself, in
order to avoid this, you should use __mutex_init().

Thanks.

> + 	lockdep_set_class(&h->resize_lock, =
&hugetlb_resize_keys[hstate_index(h)]);
> 	h->order =3D order;
> 	h->mask =3D ~(huge_page_size(h) - 1);
> 	for (i =3D 0; i < MAX_NUMNODES; ++i)
> --=20
> 2.33.0
>=20


