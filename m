Return-Path: <linux-kernel+bounces-392645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355359B96A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584DA1C2174E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365611CC8AE;
	Fri,  1 Nov 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rd0RxzFz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22284E1C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482655; cv=none; b=JmZGvLYJwEbau0p+HbB9sVllb8UtiJFlwTS7XgBnb1RD8b0ckXbjDOTmBJt6W94gSlRD6ZyKfCC8INA8BP+rCRY21JE1FXOv2UQb7C+Rk6hU21p/oqHLG8yv1tKnlMbPszXY9nNIuUU/x34OUoQ0VqQCMfxZGiOd8Xw2JOknjzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482655; c=relaxed/simple;
	bh=7OGUhqH2NxmyFbldn34K3qDOHjHTk4ndl6SAGsqInyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2adMa8NqWU4+/DA65vsyuKQoJceOEx9wSkxOV81sHgPXBZh4xSFHwYg1THHJ0/d0T1wdtVrfaKdRYLz7/lD3oVtCGFiX2p26F2NkHf5gZ97DZxSL3GUlsyUuho/DGzx1U22ZOeJQJT1ATyA9G2fS8ZG8jF1fIn6rD7P0kQaMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rd0RxzFz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730482653; x=1762018653;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7OGUhqH2NxmyFbldn34K3qDOHjHTk4ndl6SAGsqInyw=;
  b=Rd0RxzFzxpI2af/wLyiW35StcAID28dHGhstLn+9Xbm2sJHGZyPrItfY
   U4JbcMw+AneNSRO8x4oXn6mivi/ogXK8wgE05HgBK5vS44s0ue9gD0eqT
   ttIIZD6OLVS2tHTVlge8BHGw6Bi4Mt/EF8vJOiHmNhDncu+3UmmvztqUs
   LLCw1T4KhXAxPVlfQlxiJjTim06RwlKlNyunMlwdVVpbsbc7KWJtCGJSo
   rBDBaTmkZz4RqiZ0nw6JKvkPkSKJvEq4E4Q6B3LZvZHozlW1hKobmdJOm
   DGh4H8x5ciXk6Pu/PX5JWKIzkj6mukhBIuLxTv5YivuFZ+VW7H6/tS8+P
   Q==;
X-CSE-ConnectionGUID: +IeQ4aMoRNy9TKtwxAr+Tw==
X-CSE-MsgGUID: 6bEdOpBMTRqaSWCh/8iLDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="29672956"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="29672956"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 10:37:32 -0700
X-CSE-ConnectionGUID: qMd61qUERiSdNHOyLrljxg==
X-CSE-MsgGUID: MTIHjbBLR/+5dJdbOETpMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87813067"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.68]) ([10.125.109.68])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 10:37:32 -0700
Message-ID: <7dd5932c91a3f9a8250f38b817be2a9d1fa77884.camel@linux.intel.com>
Subject: Re: BUG: Stall on adding/removing wokers into workqueue pool
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org, 
 Thomas Gleixner <tglx@linutronix.de>, Doug Nelson <doug.nelson@intel.com>,
 bp@alien8.de,  dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com,  syzkaller-bugs@googlegroups.com, x86@kernel.org
Date: Fri, 01 Nov 2024 10:37:31 -0700
In-Reply-To: <ZyLEYMZP2SiVGeSD@slm.duckdns.org>
References: <1cf7b0dbfa4190eeaf0b3401bf7a991b8db59a59.camel@linux.intel.com>
	 <ZyLEYMZP2SiVGeSD@slm.duckdns.org>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-30 at 13:42 -1000, Tejun Heo wrote:
> Hello, Tim.
>=20
> On Tue, Oct 29, 2024 at 03:03:33PM -0700, Tim Chen wrote:
> > Hi Tejun,
> >=20
> > Forwarding this task hung seen by my colleague Doug Nelson. He tested
> > the 6.12-rc4 kernel with an OLTP workload running on a 2 socket with
> > Granite Rapids CPU that has 86 cores per socket. The traces=C2=A0
> > seem to indicate that the acquisition=C2=A0
> > of wq_pool_attach_mutex stalled in idle_cull_fn() when removing worker =
from
> > the pool. Doug hit this problem occasionally in his tests.
> >=20
> > Searching through the bug reports, there's a similar report by szybot o=
n the
> > 6.12-rc2 kernel. Szybot reported similar task hung when attaching worke=
rs to
> > the pool: https://lore.kernel.org/all/6706c4ba.050a0220.1139e6.0008.GAE=
@google.com/T/
> > So we suspect that the problem is not GNR CPU specific.
> >=20
> > Wonder if this problem is a known one?
>=20
> First time I see it. The trace doesn't show who's holding the mutex. Ther=
e
> doesn't seem to be any place where that mutex should leak at least on a
> glance, so hopefully it shouldn't be too difficult to find who's holding =
it.
> Can you trigger sysrq-d and sysrq-t and post the output?
>=20

I'll ask Doug to see if he can get that info when he see that hang again.  =
But
Syzbot does have that info in their log of the bug (https://syzkaller.appsp=
ot.com/bug?extid=3D8b08b50984ccfdd38ce2).=C2=A0
Clipping out the relevant info below.

Tim

Log from Syzbot:
Showing all locks held in the system:
---showing only wq_pool_attach_mutex---
1 lock held by kworker/0:0/8:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-mm_pe/13:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock includ=
e/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks=
+0x55/0x2a0 kernel/locking/lockdep.c:6720
4 locks held by kworker/u8:7/1307:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_w=
ork kernel/workqueue.c:3204 [inline]
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_sched=
uled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000466fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work =
kernel/workqueue.c:3205 [inline]
 #1: ffffc9000466fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled=
_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc6350 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a=
/0xcc0 net/core/net_namespace.c:580
 #3: ffff88807e155428 (&wg->device_update_lock){+.+.}-{3:3}, at: wg_destruc=
t+0x110/0x2e0 drivers/net/wireguard/device.c:249
1 lock held by kworker/R-dm_bu/2373:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
2 locks held by getty/4989:
 #0: ffff88814bfbe0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait=
+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_rea=
d+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
4 locks held by kworker/0:7/5348:
3 locks held by kworker/u8:10/6933:
1 lock held by kworker/R-wg-cr/9157:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/9159:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/9428:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/9429:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/9471:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/9472:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/9912:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/9913:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/9914:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/10385:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/10386:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/10387:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/10446:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/10447:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/10578:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/10580:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/10581:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/10673:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/10675:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/11051:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/11054:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach=
_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/11055:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach=
_to_pool+0x31/0x390 kernel/workqueue.c:2669
7 locks held by syz-executor/11585:
 #0: ffff888032260420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write incl=
ude/linux/fs.h:2931 [inline]
 #0: ffff888032260420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90=
 fs/read_write.c:679
 #1: ffff888065546888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0=
x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff888144f145a8 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_ite=
r+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f570e28 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_=
store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff8880609060e8 (&dev->mutex){....}-{3:3}, at: device_lock include/li=
nux/device.h:1014 [inline]
 #4: ffff8880609060e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock d=
rivers/base/dd.c:1095 [inline]
 #4: ffff8880609060e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_=
internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff88802fbdb250 (&devlink->lock_key#28){+.+.}-{3:3}, at: nsim_drv_rem=
ove+0x50/0x160 drivers/net/netdevsim/dev.c:1675
 #6: ffffffff8e93d3b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_loc=
k kernel/rcu/tree_exp.h:329 [inline]
 #6: ffffffff8e93d3b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rc=
u_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
1 lock held by kworker/R-bond0/11593:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-bond0/11595:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-bond0/11600:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-bond0/11605:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-bond0/11608:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11616:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11617:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11619:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11620:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11621:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11622:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11623:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11624:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11625:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11626:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11627:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11628:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11629:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11630:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11631:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-bond0/11706:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-bond0/11707:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-bond0/11708:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-bond0/11711:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11724:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11725:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11726:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11727:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11728:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11729:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11730:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11731:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11732:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11735:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11736:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by kworker/R-wg-cr/11738:
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker=
 kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23e8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_threa=
d+0xd0/0x10a0 kernel/workqueue.c:3443
1 lock held by syz-executor/11786:
 #0: ffffffff8fcc6350 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328=
/0x570 net/core/net_namespace.c:490
1 lock held by syz-executor/11798:
 #0: ffffffff8fcc6350 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328=
/0x570 net/core/net_namespace.c:490
1 lock held by syz-executor/11800:
 #0: ffffffff8fcc6350 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328=
/0x570 net/core/net_namespace.c:490
1 lock held by syz-executor/11803:
 #0: ffffffff8fcc6350 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328=
/0x570 net/core/net_namespace.c:490
1 lock held by syz-executor/11804:
 #0: ffffffff8fcc6350 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328=
/0x570 net/core/net_namespace.c:490
2 locks held by dhcpcd/11850:
 #0: ffff888069c52258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock includ=
e/net/sock.h:1611 [inline]
 #0: ffff888069c52258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0=
x32/0xcb0 net/packet/af_packet.c:3266
 #1: ffffffff8e93d3b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_loc=
k kernel/rcu/tree_exp.h:329 [inline]
 #1: ffffffff8e93d3b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rc=
u_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
1 lock held by dhcpcd/11851:
 #0: ffff88807ed0a258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock includ=
e/net/sock.h:1611 [inline]
 #0: ffff88807ed0a258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0=
x32/0xcb0 net/packet/af_packet.c:3266
1 lock held by dhcpcd/11852:
 #0: ffff88802925e258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock includ=
e/net/sock.h:1611 [inline]
 #0: ffff88802925e258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0=
x32/0xcb0 net/packet/af_packet.c:3266
1 lock held by dhcpcd/11853:
 #0: ffff88802925c258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock includ=
e/net/sock.h:1611 [inline]
 #0: ffff88802925c258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0=
x32/0xcb0 net/packet/af_packet.c:3266
1 lock held by dhcpcd/11854:
 #0: ffff8880455b6258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock includ=
e/net/sock.h:1611 [inline]
 #0: ffff8880455b6258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0=
x32/0xcb0 net/packet/af_packet.c:3266
1 lock held by dhcpcd/11855:
 #0: ffff8880286b2258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock includ=
e/net/sock.h:1611 [inline]
 #0: ffff8880286b2258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0=
x32/0xcb0 net/packet/af_packet.c:3266

