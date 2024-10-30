Return-Path: <linux-kernel+bounces-389545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14379B6E40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A952828FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4AB21314B;
	Wed, 30 Oct 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhD3jsq7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FB19CC24
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321922; cv=none; b=r8VGr8BMRC3EziuuLXLq+erbFt1AmmhZyo+x41z05ynvizoGGQrQKk6YM32gnaC2BrJxGBs6Wa7J5cpHAdXYSP57VEG3eWoYnjZcBX4vadS90aKIWrbWUYTRvQhhdFXb05T+Ba1W710iY7kQbv6H4m8X860h15rm167oT5bNULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321922; c=relaxed/simple;
	bh=CkjduKV+/l8e5kvzUBlWYXUILayMOlwRDnDSJb/GnCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+bt9BxfreogC59Y82QwVQKA3pkMbz1ah/aFhBr3QnYIap9dfJ21XnHmmikBA1QAuuRWE2HZaU8ic1VvEPmfvlspVOtTP+vhsRue3+bARbn6aMC+DKhDeGpICZZgvnYUL1dhKzASHrX1uVLUI9yUmcJ9sCLBPjSamBnijGPFmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhD3jsq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305BCC4CECE;
	Wed, 30 Oct 2024 20:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730321921;
	bh=CkjduKV+/l8e5kvzUBlWYXUILayMOlwRDnDSJb/GnCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhD3jsq747xk8WoT5ADiNv5GENJdoyFULSQqjiCdcvL1z+uXHMZp+EGgFRW6yLcwy
	 MPzs3XtaMUia6H/6siTcJOZIMiPTmY+QlN7qRgAQr6fcBvC+rGKZFcq96Qp2NtAkUA
	 3WObNuC2liXU58Bez0KnNRH0jpRKrkWavfmQDE+e2Rxr99vx9xI00BObkHdLR2IVW2
	 8kCPY+r1Oi1f3f39Tq+cQ9YB7EjFInbJ7XRDWHTgO9OgBipprkSXVSTaTlm89VkAkQ
	 /AUokbepss3OtaYqTa3dEqQkGjkLGYtEyojTpb0uSIN/QAXMGfXHx8BOpWcep7k5Dx
	 ZV/ynL+tGwkLQ==
Date: Wed, 30 Oct 2024 10:58:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/6] sched: Employ sched_change guards
Message-ID: <ZyKeAGgnuZiz3a4A@slm.duckdns.org>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.488737132@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030152142.488737132@infradead.org>

On Wed, Oct 30, 2024 at 04:12:57PM +0100, Peter Zijlstra wrote:
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
...
> @@ -5206,18 +5202,15 @@ static int scx_ops_enable(struct sched_e
>  		const struct sched_class *old_class = p->sched_class;
>  		const struct sched_class *new_class =
>  			__setscheduler_class(p->policy, p->prio);
> -		struct sched_enq_and_set_ctx ctx;
>  
>  		if (old_class != new_class && p->se.sched_delayed)
> -			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEE_DELAYED);
> -
> -		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
> -
> -		p->scx.slice = SCX_SLICE_DFL;
> -		p->sched_class = new_class;
> -		check_class_changing(task_rq(p), p, old_class);
> +			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>  
> -		sched_enq_and_set_task(&ctx);
> +		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
> +			p->scx.slice = SCX_SLICE_DFL;
> +			p->sched_class = new_class;
> +			check_class_changing(task_rq(p), p, old_class);
> +		}
>  
>  		check_class_changed(task_rq(p), p, old_class, p->prio);
>  	}

I get the following from missing update_rq_lock():

  rq->clock_update_flags < RQCF_ACT_SKIP
  WARNING: CPU: 2 PID: 1692 at kernel/sched/sched.h:1647 update_load_avg+0x7c3/0x8c0
  Modules linked in:
  CPU: 2 UID: 0 PID: 1692 Comm: runner Not tainted 6.12.0-rc5-work-00336-g9bfae8f5ca65-dirty #515
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 2/2/2022
  Sched_ext: maximal (enabling+all)
  RIP: 0010:update_load_avg+0x7c3/0x8c0
  Code: 00 4c 2b bb c8 01 00 00 40 f6 c5 02 0f 84 e7 f8 ff ff e9 fa f8 ff ff c6 05 28 1f 81 02 01 48 c7 c7 f9 c5 dd 82 e8 1d 04 fb ff <0f> 0b e9 aa f8 ff ff 0f 0b 41 83 be f0 0c 00 00 01 0f 86 8d f8 ff
  RSP: 0018:ffffc900003c7c60 EFLAGS: 00010086
  RAX: 0000000000000026 RBX: ffff88810163d400 RCX: 0000000000000027
  RDX: 0000000000000002 RSI: 00000000ffffdfff RDI: ffff888237c9b448
  RBP: 0000000000000000 R08: 0000000000001fff R09: ffffffff8368dff0
  R10: 0000000000005ffd R11: 0000000000000004 R12: ffffffff82edb890
  R13: ffff888100398080 R14: ffff888237c30180 R15: ffff888100398000
  FS:  00007f850b4006c0(0000) GS:ffff888237c80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f84fc000020 CR3: 0000000103bfa000 CR4: 0000000000750eb0
  PKRU: 55555554
  Call Trace:
   <TASK>
   detach_task_cfs_rq+0x31/0xf0
   check_class_changed+0x29/0x70
   bpf_scx_reg+0xa72/0xc30
   bpf_struct_ops_link_create+0xf8/0x140
   __sys_bpf+0x348/0x510
   __x64_sys_bpf+0x18/0x20
   do_syscall_64+0x7b/0x140
   ? exc_page_fault+0x6b/0xb0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f850c0551fd
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 fa 0c 00 f7 d8 64 89 01 48
  RSP: 002b:00007f850b3ffba8 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f850c0551fd
  RDX: 0000000000000040 RSI: 00007f850b3ffdc0 RDI: 000000000000001c
  RBP: 00007f850b3ffbd0 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000001 R11: 0000000000000202 R12: 00007f850b4006c0
  R13: ffffffffffffff80 R14: 000000000000005f R15: 00007ffdf6c8de30
   </TASK>

The following patch fixes it. Thanks.

---
 kernel/sched/ext.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4496,6 +4496,8 @@ static void scx_ops_disable_workfn(struc
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
 
+		update_rq_clock(task_rq(p));
+
 		if (old_class != new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 
@@ -5208,6 +5210,8 @@ static int scx_ops_enable(struct sched_e
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
 
+		update_rq_clock(task_rq(p));
+
 		if (old_class != new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);

