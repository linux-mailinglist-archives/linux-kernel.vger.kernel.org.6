Return-Path: <linux-kernel+bounces-178561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9838C5034
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8458E284C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3A13A260;
	Tue, 14 May 2024 10:38:05 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533A4205D
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683084; cv=none; b=eYck2xl1kETQblzwBgUuUzKdSv0zCHsGCksX5HYIEUPfaxVMX13t5Rtp6iTNFM1QblA0C1KcH1rxmao8LTOT+h/Qvw9iZ1pfevyUtfgfvFPbxBHFyGDZiqT3CDWr4fShN2XGybQbko6nSZg1Gkb96yzyOa12ypnOw9eXRegSn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683084; c=relaxed/simple;
	bh=ttL8nhYSj14rqc6rPfMgzrqper9I6jzQqcP61trWcYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9qPxeQiL6bb8RFfnF2oMwIb+TlXE5IsMGr3zYy8DcWOM5QEXfyCNhepcBaQqasQUPWlVPFlTJQX+g2ue+Eyrhg0zizh88dBcicJTU+chIwO+M97JZRlwZXhzk8262tdHIXOJMkMj7G/N16A+PuGuEDa68NpDnc+tEQGiFLS2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.104])
	by sina.com (172.16.235.24) with ESMTP
	id 66433F00000078FB; Tue, 14 May 2024 18:37:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 22684945089256
X-SMAIL-UIID: A76544F3C5E1431A937ADE10C72885BC-20240514-183755-1
From: Hillf Danton <hdanton@sina.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
Date: Tue, 14 May 2024 18:37:42 +0800
Message-Id: <20240514103742.3137-1-hdanton@sina.com>
In-Reply-To: <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 14 May 2024 10:05:21 +0800 Sam Sun <samsun1006219@gmail.com>
> On Tue, May 14, 2024 at 6:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > On Mon, 13 May 2024 20:57:44 +0800 Sam Sun <samsun1006219@gmail.com>
> > >
> > > I applied this patch and tried using the C repro, but it still crashed
> > > with the same task hang kernel dump log.
> >
> > Oh low-hanging pear is sour, and try again seeing if there is missing
> > wakeup due to wake batch.
> >
> > --- x/lib/sbitmap.c
> > +++ y/lib/sbitmap.c
> > @@ -579,6 +579,8 @@ void sbitmap_queue_wake_up(struct sbitma
> >         unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
> >         unsigned int wakeups;
> >
> > +       __sbitmap_queue_wake_up(sbq, nr);
> > +
> >         if (!atomic_read(&sbq->ws_active))
> >                 return;
> >
> > --
> 
> I applied this patch together with the last patch. Unfortunately it
> still crashed.

After two rounds of test, what is clear now so far is -- it is IOs
in flight that caused the task hung reported, though without spotting
why they failed to complete within 120 seconds.
> 
> Pointed out by Tetsuo, this kernel panic might be caused by sending
> NMI between cpus. As dump log shows:
> ```
> [  429.046960][   T32] NMI backtrace for cpu 0
> [  429.047499][   T32] CPU: 0 PID: 32 Comm: khungtaskd Not tainted 6.9.0-dirty #6
> [  429.048417][   T32] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> [  429.049873][   T32] Call Trace:
> [  429.050299][   T32]  <TASK>
> [  429.050672][   T32]  dump_stack_lvl+0x201/0x300
> ...
> [  429.063133][   T32]  ret_from_fork_asm+0x11/0x20
> [  429.063735][   T32]  </TASK>
> [  429.064168][   T32] Sending NMI from CPU 0 to CPUs 1:
> [  429.064833][   T32] BUG: unable to handle page fault for address:
> ffffffff813d4cf1

Given many syzbot reports without gpf like this one, I have difficulty
understanding it. If it is printed after task hung detected, it should
be a seperate issue.

> [  429.065765][   T32] #PF: supervisor write access in kernel mode
> [  429.066502][   T32] #PF: error_code(0x0003) - permissions violation
> [  429.067274][   T32] PGD db38067 P4D db38067 PUD db39063 PMD 12001a1
> [  429.068068][   T32] Oops: 0003 [#1] PREEMPT SMP KASAN NOPTI
> [  429.068767][   T32] CPU: 0 PID: 32 Comm: khungtaskd Not tainted
> 6.9.0-dirty #6
> [  429.069666][   T32] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> [  429.071142][   T32] RIP: 0010:__send_ipi_mask+0x541/0x690

