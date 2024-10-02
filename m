Return-Path: <linux-kernel+bounces-348248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB62F98E49C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B051F23414
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4169C217313;
	Wed,  2 Oct 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="js1oqBaq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18CF1D1E60
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903305; cv=none; b=HUO8MU9gQjyt0XvMIPGXcO4X1fqzwT42ADCyQLDQr/F1E1ag9dSjnySzfj9Fj+kmCKmSKmcBVuBT6skP9w9XUs3Du0etoYOlxBM+2e4l2DQMF4xXm8hhmitM0Sy2g3HuVDN43DK4Lhs+LTiZoDKEGn3uHzLUoAk7/a+r24r+h20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903305; c=relaxed/simple;
	bh=JY8iHEM3V4b5AtWB8ZdD25cCzC7BU/zTyXKmXkLPm7Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lb9gGsPRjs3ymwNwiTTsvu9BH205Ho5R03br2FCvWKCGInIkbe1KGCv5eW1XHz59tE0ZqkUvVRTVamx+DIdq0UcPeIGlQby9MUTSGf1VKW7KmVfDAmm4e6P5KOz8jtNSoNpEkazV4LyjJDRkhfzjMaGma4zRN7sljI1WeJB/Xlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=js1oqBaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA250C4CEC2;
	Wed,  2 Oct 2024 21:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727903305;
	bh=JY8iHEM3V4b5AtWB8ZdD25cCzC7BU/zTyXKmXkLPm7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=js1oqBaqg6DU7npcFJ3U5jCYwo2mJyVK7jg+wI4IecHTjIZYAcIc+ydgBvZGveb9j
	 JJ01kBBqMiZU6U/mVCdJArbzBBupx9e1DCTIsu21csclkki6OzTADJ34hfNzEGishU
	 qdsSJyr0z6l6U91QPt8AFjTambn5tWIU7kRSVe98=
Date: Wed, 2 Oct 2024 14:08:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Hillf Danton <hdanton@sina.com>, Tejun Heo
 <tj@kernel.org>, syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Subject: Re: [PATCH] kthread: Unpark only parked kthread
Message-Id: <20241002140824.0a3ccc8695f16958f28c6d6c@linux-foundation.org>
In-Reply-To: <Zv1VadXrQVwqDWE9@localhost.localdomain>
References: <20240913214634.12557-1-frederic@kernel.org>
	<20240926132130.b1d1f6943d225368d3062d5e@linux-foundation.org>
	<Zv1VadXrQVwqDWE9@localhost.localdomain>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Oct 2024 16:15:05 +0200 Frederic Weisbecker <frederic@kernel.org>=
 wrote:

> Le Thu, Sep 26, 2024 at 01:21:30PM -0700, Andrew Morton a =E9crit :
> > On Fri, 13 Sep 2024 23:46:34 +0200 Frederic Weisbecker <frederic@kernel=
.org> wrote:
> >=20
> > > Calling into kthread unparking unconditionally is mostly harmless when
> > > the kthread is already unparked. The wake up is then simply ignored
> > > because the target is not in TASK_PARKED state.
> > >=20
> > > However if the kthread is per CPU, the wake up is preceded by a call
> > > to kthread_bind() which expects the task to be inactive and in
> > > TASK_PARKED state, which obviously isn't the case if it is unparked.
> > >=20
> > > As a result, calling kthread_stop() on an unparked per-cpu kthread
> > > triggers such a warning:
> > >=20
> > > 	WARNING: CPU: 0 PID: 11 at kernel/kthread.c:525 __kthread_bind_mask =
kernel/kthread.c:525
> > > 	 <TASK>
> > > 	 kthread_stop+0x17a/0x630 kernel/kthread.c:707
> > > 	 destroy_workqueue+0x136/0xc40 kernel/workqueue.c:5810
> > > 	 wg_destruct+0x1e2/0x2e0 drivers/net/wireguard/device.c:257
> > > 	 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10693
> > > 	 default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11769
> > > 	 ops_exit_list net/core/net_namespace.c:178 [inline]
> > > 	 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
> > > 	 process_one_work kernel/workqueue.c:3231 [inline]
> > > 	 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
> > > 	 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
> > > 	 kthread+0x2f0/0x390 kernel/kthread.c:389
> > > 	 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > > 	 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > > 	 </TASK>
> > >=20
> > > Fix this with skipping unecessary unparking while stopping a kthread.
> >=20
> > How does userspace trigger this?  Is it an issue in current mainline?
>=20
> I guess it takes some module unload performing a destroy workqueue to
> trigger this. And it's an issue in current mainline.

Cool.

> >=20
> > Should we backport the fix into -stable kernels (depends on the answers
> > to the above questions).
> >=20
> > It looks like the issue is old, so a Fixes: probably isn't needed.  But
> > as the issue is old, why did it come to light now?
>=20
> It's hard to tell. The core of the issue is there for a long while but
> the conditions for it to really happen in practice is probably since:
>=20
>     5c25b5ff89f0 (workqueue: Tag bound workers with KTHREAD_IS_PER_CPU)
>=20
> So it might deserve a Fixes: actually.

OK, thsnks I added

Fixes: 5c25b5ff89f0 ("workqueue: Tag bound workers with KTHREAD_IS_PER_CPU")
Cc: <stable@vger.kernel.org>

and it's queued for a 6.12-rcX merge.

