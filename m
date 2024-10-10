Return-Path: <linux-kernel+bounces-359887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B49991F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE3A282F21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B419EED0;
	Thu, 10 Oct 2024 19:12:43 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A419ABAC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587562; cv=none; b=h4hzyuMGEOqJWBescZIf2OWcydLjwO8iiKtvq3rYYqRp6TVHpB0an9qI9pi7arUJr2EWOvwBI/gtp2T9zV3HHjQ6cimQOgfegY4qHPjn6Wy4l4+vsLrxCbkiHHbioMDyIXGSDPdKmsTgnBoY8FCO5CCQbvcytCis1wDm9n8/IVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587562; c=relaxed/simple;
	bh=TRnJfwBxX9CPt9LQVeoAzMmeovCb2pefCKc4hga2OIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPyoSQFHA0F0mjCL/m5V69svq2MeLH0CAIINHWGw6uCK+IHmcWGbp0P9nJjm/1NEVaMyIKY0L35UMU2fhfezLxEJlnXjGslomayZcyQhHgbwJ+dTqKIvQ8mmvsUZewj7kmMtoHu0zFCWHhTu8wle/IFJdncOw6mASMj8CTlKgxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e2e4244413so15807977b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587560; x=1729192360;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkluLMkpuB65WcVDkGfSHa+U/crpY2pSHoKinjeOugo=;
        b=Lxxqs2tNQHI9wup4XkRLkE05TkjAE3BdUkK11BFOJZN9x1Yy+VfhKVB5uirEjZYcrU
         U4nQmxrbXx7NeAuNWXNxRhuqR3CiwEaRitm+D5so9MnVIfv2cTwG78+hwb/kabTeoi6S
         5mN9Cc+zrrjSazMAqae2ehqJILQmSMa0bld2zzNLAXLsuuTAdR4vkS1q4yF78s0EfFcd
         R7ZyDGpfCwa3wL4o+b5GIZw1wxBqIkO0sNhz/Szf74krxIiqtY4+LJOsa7flLeRxnFWz
         k2m1lmcLuPWyRxiyJAGPw2jM3UtN9JPZfAblu6H5xyc9XN3pd2zcaeIBiZewUbJ7ga9g
         QFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR+B7DnWUOz924emfsJ5Mg/x1wgxwRfrnelyVZRsXKf3gTKlUgXvuYKNbQy758jsKL64+J322GD06MqNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZibuxpnApqILaWJewzL/OpbbrUXhd903LudUDlpxBZJzH5mP2
	LKKT4M+cLsckCcuP+qX4G68p4T0tZEae5XmNOpXjqUuwNWLuTbhQ7D9lAg==
X-Google-Smtp-Source: AGHT+IFvyu4UYNRSqdsTrPLsO3N6TB1g6v7ZDwYGR1OBYGS9RzNZk846fmI7GvzaK0XWMhO6X1NzHw==
X-Received: by 2002:a05:690c:6a08:b0:6e2:547:5e7b with SMTP id 00721157ae682-6e32219f138mr75771937b3.43.1728587559813;
        Thu, 10 Oct 2024 12:12:39 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332c2db31sm3078437b3.100.2024.10.10.12.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:12:39 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:12:37 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 6/6] sched_ext: Don't hold scx_tasks_lock for too long
Message-ID: <20241010191237.GF28209@maniforge>
References: <20241009214411.681233-1-tj@kernel.org>
 <20241009214411.681233-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sWvUIGCJt1PzkI4G"
Content-Disposition: inline
In-Reply-To: <20241009214411.681233-7-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--sWvUIGCJt1PzkI4G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 11:41:02AM -1000, Tejun Heo wrote:
> While enabling and disabling a BPF scheduler, every task is iterated a
> couple times by walking scx_tasks. Except for one, all iterations keep
> holding scx_tasks_lock. On multi-socket systems under heavy rq lock
> contention and high number of threads, this can can lead to RCU and other
> stalls.
>=20
> The following is triggered on a 2 x AMD EPYC 7642 system (192 logical CPU=
s)
> running `stress-ng --workload 150 --workload-threads 10` with >400k idle
> threads and RCU stall period reduced to 5s:
>=20
>   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>   rcu:     91-...!: (10 ticks this GP) idle=3D0754/1/0x4000000000000000 s=
oftirq=3D18204/18206 fqs=3D17
>   rcu:     186-...!: (17 ticks this GP) idle=3Dec54/1/0x4000000000000000 =
softirq=3D25863/25866 fqs=3D17
>   rcu:     (detected by 80, t=3D10042 jiffies, g=3D89305, q=3D33 ncpus=3D=
192)
>   Sending NMI from CPU 80 to CPUs 91:
>   NMI backtrace for cpu 91
>   CPU: 91 UID: 0 PID: 284038 Comm: sched_ext_ops_h Kdump: loaded Not tain=
ted 6.12.0-rc2-work-g6bf5681f7ee2-dirty #471
>   Hardware name: Supermicro Super Server/H11DSi, BIOS 2.8 12/14/2023
>   Sched_ext: simple (disabling+all)
>   RIP: 0010:queued_spin_lock_slowpath+0x17b/0x2f0
>   Code: 02 c0 10 03 00 83 79 08 00 75 08 f3 90 83 79 08 00 74 f8 48 8b 11=
 48 85 d2 74 09 0f 0d 0a eb 0a 31 d2 eb 06 31 d2 eb 02 f3 90 <8b> 07 66 85 =
c0 75 f7 39 d8 75 0d be 01 00 00 00 89 d8 f0 0f b1 37
>   RSP: 0018:ffffc9000fadfcb8 EFLAGS: 00000002
>   RAX: 0000000001700001 RBX: 0000000001700000 RCX: ffff88bfcaaf10c0
>   RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffff88bfca8f0080
>   RBP: 0000000001700000 R08: 0000000000000090 R09: ffffffffffffffff
>   R10: ffff88a74761b268 R11: 0000000000000000 R12: ffff88a6b6765460
>   R13: ffffc9000fadfd60 R14: ffff88bfca8f0080 R15: ffff88bfcaac0000
>   FS:  0000000000000000(0000) GS:ffff88bfcaac0000(0000) knlGS:00000000000=
00000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f5c55f526a0 CR3: 0000000afd474000 CR4: 0000000000350eb0
>   Call Trace:
>    <NMI>
>    </NMI>
>    <TASK>
>    do_raw_spin_lock+0x9c/0xb0
>    task_rq_lock+0x50/0x190
>    scx_task_iter_next_locked+0x157/0x170
>    scx_ops_disable_workfn+0x2c2/0xbf0
>    kthread_worker_fn+0x108/0x2a0
>    kthread+0xeb/0x110
>    ret_from_fork+0x36/0x40
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   Sending NMI from CPU 80 to CPUs 186:
>   NMI backtrace for cpu 186
>   CPU: 186 UID: 0 PID: 51248 Comm: fish Kdump: loaded Not tainted 6.12.0-=
rc2-work-g6bf5681f7ee2-dirty #471
>=20
> scx_task_iter can safely drop locks while iterating. Make
> scx_task_iter_next() drop scx_tasks_lock every 32 iterations to avoid
> stalls.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

LG, just had one question below.

Acked-by: David Vernet <void@manifault.com>

> ---
>  kernel/sched/ext.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index d53c7a365fec..b44946198ea5 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -18,6 +18,12 @@ enum scx_consts {
>  	SCX_EXIT_DUMP_DFL_LEN		=3D 32768,
> =20
>  	SCX_CPUPERF_ONE			=3D SCHED_CAPACITY_SCALE,
> +
> +	/*
> +	 * Iterating all tasks may take a while. Periodically drop
> +	 * scx_tasks_lock to avoid causing e.g. CSD and RCU stalls.
> +	 */
> +	SCX_OPS_TASK_ITER_BATCH		=3D 32,
>  };
> =20
>  enum scx_exit_kind {
> @@ -1273,6 +1279,7 @@ struct scx_task_iter {
>  	struct task_struct		*locked;
>  	struct rq			*rq;
>  	struct rq_flags			rf;
> +	u32				cnt;
>  };
> =20
>  /**
> @@ -1301,6 +1308,7 @@ static void scx_task_iter_start(struct scx_task_ite=
r *iter)
>  	iter->cursor =3D (struct sched_ext_entity){ .flags =3D SCX_TASK_CURSOR =
};
>  	list_add(&iter->cursor.tasks_node, &scx_tasks);
>  	iter->locked =3D NULL;
> +	iter->cnt =3D 0;
>  }
> =20
>  static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
> @@ -1355,14 +1363,21 @@ static void scx_task_iter_stop(struct scx_task_it=
er *iter)
>   * scx_task_iter_next - Next task
>   * @iter: iterator to walk
>   *
> - * Visit the next task. See scx_task_iter_start() for details.
> + * Visit the next task. See scx_task_iter_start() for details. Locks are=
 dropped
> + * and re-acquired every %SCX_OPS_TASK_ITER_BATCH iterations to avoid ca=
using
> + * stalls by holding scx_tasks_lock for too long.
>   */
>  static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
>  {
>  	struct list_head *cursor =3D &iter->cursor.tasks_node;
>  	struct sched_ext_entity *pos;
> =20
> -	lockdep_assert_held(&scx_tasks_lock);
> +	if (!(++iter->cnt % SCX_OPS_TASK_ITER_BATCH)) {
> +		scx_task_iter_unlock(iter);
> +		cpu_relax();

Could you explain why we need this cpu_relax()? I thought it was only
necessary for busy-wait loops.

> +		cond_resched();
> +		scx_task_iter_relock(iter);
> +	}
> =20
>  	list_for_each_entry(pos, cursor, tasks_node) {
>  		if (&pos->tasks_node =3D=3D &scx_tasks)
> --=20
> 2.46.2
>=20

--sWvUIGCJt1PzkI4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZwgnJQAKCRBZ5LhpZcTz
ZNjCAQDyqlhRfpjX4s9rNmM8ZvkS3iuag+NmxqbmKDV6KG9pMQD/cv5OABkvcBVN
yu4R5MewUYp0Lf2mlO5Nj4ZT2z/lygc=
=mOaN
-----END PGP SIGNATURE-----

--sWvUIGCJt1PzkI4G--

