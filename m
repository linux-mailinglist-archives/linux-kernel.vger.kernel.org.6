Return-Path: <linux-kernel+bounces-424605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328629DB6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799FDB20E50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00831990CF;
	Thu, 28 Nov 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="A+QJZyTL"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93D146D59
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794277; cv=none; b=jS8MIyya0wlCqdFcmAmtOXBSX2wIyUjxDUlpx1MBKhIzibqUWQ24z7stEUv3LQNcXbRFv+5P9IFKlcHLYLhaL+yjE/qpEvXrR5pEeP1K0DLX675/X3WyBw6jRFrGeGksJgVLuOzKYgpt/67BdWa9ueKIDE83Jayi439yYYdsYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794277; c=relaxed/simple;
	bh=qjKmMPtfy98oWo4nR0o+q7R+1F5bbmblW6k7A9OYa4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwoRnr44qHdLqjiWwotW/h/kyvdMHL8DRw9BvKGC6qNgEeWcgCB31adL8kWcefJYG8UW8cRwXKXTbQenaKhKa6kl6YLe0zk3T8esQNiUyD6ulwBOtTjxZw1K/DiAdIN3MH+1Qx0ocbCT6TWEbJZ788K6dN6q6tB8Ii6JxECg8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=A+QJZyTL; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=toqNLSPYxjCtvh/SqqRz1pZJrvDmLIEZxUJXkZin7bg=; b=A+QJZyTLq+grXnjJyqRhWtYBoW
	ngfsIvJgBOMuFSC9Fkt1sXVzHiv2Nj+kszNRUELqu73Lx1wF4qaEos9Rbz6n8lhOlkKQtbd+3EX1H
	Y97Da7V+gowyldMP+PLzw8ddLNdFTuMhT6uk12Vp5w95wQMtd8G2tzHRFQ9Ni3F+3g9aboOh1PlSh
	wSu2lT6TxZe7xHA2w8xDeqk+FPJdNB3lM/4KjUbAXXDL7YnzMI1lKVM01AD1CytZp00wjJWbSGF/t
	R6XV8Fe36I7dAqruuhcUBBzp0LNkgWfpLnke2oBTK4WnGwgBJfApTWbbH7sHx26/slMAswZw03f3S
	in8K0EMA==;
Received: from [167.98.27.226] (helo=[10.35.5.98])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tGbog-00CK8U-Gl; Thu, 28 Nov 2024 10:32:11 +0000
Message-ID: <16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>
Subject: [REGRESSION] Re: [PATCH 00/24] Complete EEVDF
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, 	rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, 	linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, 	tglx@linutronix.de, efault@gmx.de
Date: Thu, 28 Nov 2024 11:32:10 +0100
In-Reply-To: <20240727102732.960974693@infradead.org>
References: <20240727102732.960974693@infradead.org>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk

Hi all,

On Sat, 2024-07-27 at 12:27 +0200, Peter Zijlstra wrote:
> Hi all,
>=20
> So after much delay this is hopefully the final version of the EEVDF patc=
hes.
> They've been sitting in my git tree for ever it seems, and people have be=
en
> testing it and sending fixes.
>=20
> I've spend the last two days testing and fixing cfs-bandwidth, and as far
> as I know that was the very last issue holding it back.
>=20
> These patches apply on top of queue.git sched/dl-server, which I plan on =
merging
> in tip/sched/core once -rc1 drops.
>=20
> I'm hoping to then merge all this (+- the DVFS clock patch) right before =
-rc2.
>=20
>=20
> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
>=20
> =C2=A0- split up the huge delay-dequeue patch
> =C2=A0- tested/fixed cfs-bandwidth
> =C2=A0- PLACE_REL_DEADLINE -- preserve the relative deadline when migrati=
ng
> =C2=A0- SCHED_BATCH is equivalent to RESPECT_SLICE
> =C2=A0- propagate min_slice up cgroups
> =C2=A0- CLOCK_THREAD_DVFS_ID

We found the following 7 commits from this patch set to crash in enqueue_dl=
_entity():

54a58a787791 sched/fair: Implement DELAY_ZERO
152e11f6df29 sched/fair: Implement delayed dequeue
e1459a50ba31 sched: Teach dequeue_task() about special task states
a1c446611e31 sched,freezer: Mark TASK_FROZEN special
781773e3b680 sched/fair: Implement ENQUEUE_DELAYED
f12e148892ed sched/fair: Prepare pick_next_task() for delayed dequeue
2e0199df252a sched/fair: Prepare exit/cleanup paths for delayed_dequeue

Resulting in the following crash dump (this is running v6.12.1):

[   14.652856] sched: DL replenish lagged too much
[   16.572706] ------------[ cut here ]------------
[   16.573115] WARNING: CPU: 5 PID: 912 at kernel/sched/deadline.c:1995 enq=
ueue_dl_entity+0x46c/0x55c
[   16.573900] Modules linked in: overlay crct10dif_ce rk805_pwrkey snd_soc=
_es8316 pwm_fan
phy_rockchip_naneng_combphy rockchip_saradc rtc_hym8563 industrialio_trigg
ered_buffer kfifo_buf rockchip_thermal phy_rockchip_usbdp typec spi_rockchi=
p_sfc snd_soc_rockchip_i2s_tdm
hantro_vpu v4l2_vp9 v4l2_h264 v4l2_jpeg panthor v4l2_mem2me
m rockchipdrm drm_gpuvm drm_exec drm_shmem_helper analogix_dp gpu_sched dw_=
mipi_dsi dw_hdmi cec
drm_display_helper snd_soc_audio_graph_card snd_soc_simple_card_utils
 drm_dma_helper drm_kms_helper cfg80211 rfkill pci_endpoint_test drm backli=
ght dm_mod dax
[   16.578350] CPU: 5 UID: 0 PID: 912 Comm: job10 Not tainted 6.12.1-dirty =
#15
[   16.578956] Hardware name: radxa Radxa ROCK 5B/Radxa ROCK 5B, BIOS 2024.=
10-rc3 10/01/2024
[   16.579667] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   16.580273] pc : enqueue_dl_entity+0x46c/0x55c
[   16.580661] lr : dl_server_start+0x44/0x12c
[   16.581028] sp : ffff80008002bc00
[   16.581318] x29: ffff80008002bc00 x28: dead000000000122 x27: 00000000000=
00000
[   16.581941] x26: 0000000000000001 x25: 0000000000000000 x24: 00000000000=
00009
[   16.582563] x23: ffff33c976db0e40 x22: 0000000000000001 x21: 00000000002=
dc6c0
[   16.583186] x20: 0000000000000001 x19: ffff33c976db17a8 x18: 00000000000=
00000
[   16.583808] x17: ffff5dd9779ac000 x16: ffff800080028000 x15: 11c3485b851=
e0698
[   16.584430] x14: 11b4b257e4156000 x13: 0000000000000255 x12: 00000000000=
00000
[   16.585053] x11: ffff33c976db0ec0 x10: 0000000000000000 x9 : 00000000000=
00009
[   16.585674] x8 : 0000000000000005 x7 : ffff33c976db19a0 x6 : ffff33c7825=
8b440
[   16.586296] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000=
00000
[   16.586918] x2 : 0000000000000001 x1 : 0000000000000001 x0 : ffff33c798e=
112f0
[   16.587540] Call trace:
[   16.587754]  enqueue_dl_entity+0x46c/0x55c
[   16.588113]  dl_server_start+0x44/0x12c
[   16.588449]  enqueue_task_fair+0x124/0x49c
[   16.588807]  enqueue_task+0x3c/0xe0
[   16.589113]  ttwu_do_activate.isra.0+0x6c/0x208
[   16.589511]  try_to_wake_up+0x1d0/0x61c
[   16.589847]  wake_up_process+0x18/0x24
[   16.590175]  kick_pool+0x84/0x150
[   16.590467]  __queue_work+0x2f4/0x544
[   16.590788]  delayed_work_timer_fn+0x1c/0x28
[   16.591161]  call_timer_fn+0x34/0x1ac
[   16.591481]  __run_timer_base+0x20c/0x314
[   16.591832]  run_timer_softirq+0x3c/0x78
[   16.592176]  handle_softirqs+0x124/0x35c
[   16.592520]  __do_softirq+0x14/0x20
[   16.592827]  ____do_softirq+0x10/0x1c
[   16.593148]  call_on_irq_stack+0x24/0x4c
[   16.593490]  do_softirq_own_stack+0x1c/0x2c
[   16.593857]  irq_exit_rcu+0x8c/0xc0
[   16.594163]  el0_interrupt+0x48/0xbc
[   16.594477]  __el0_irq_handler_common+0x18/0x24
[   16.594874]  el0t_64_irq_handler+0x10/0x1c
[   16.595232]  el0t_64_irq+0x190/0x194
[   16.595545] ---[ end trace 0000000000000000 ]---
[   16.595950] ------------[ cut here ]------------

It looks like it is trying to enqueue an already queued deadline task. Full=
 serial console log available [1].

We are running the exact same scheduler stress test both on Intel NUCs as w=
ell as RADXA ROCK 5B board farms.
While so far we have not seen this on amd64 it crashes consistently/reprodu=
cible on aarch64.

We haven't had time to do a non-proprietary reproduction case as of yet but=
 I wanted to report our current
findings asking for any feedback/suggestions from the community.

Thanks!

Cheers

Marcel

[1] https://hastebin.skyra.pw/hoqesigaye.yaml

