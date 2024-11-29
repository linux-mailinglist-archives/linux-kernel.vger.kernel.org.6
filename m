Return-Path: <linux-kernel+bounces-425974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E786B9DED2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC96F28219D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDAF189B85;
	Fri, 29 Nov 2024 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKK9BsQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71554279
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732918551; cv=none; b=jgVF8L1Lcjr8DB6o5F/6gJVU1ncKUmLIEKp+JZTOv2g5KSd+WrfxWPmBk9eDwiw3xUPGlqX45gNhbvTnzroBKDmytm/yRcUv4YYtgwbfenggq+jjVLN1rnpmHAnQyAlJLGQPGyFBL5NvX0+aI1QTUnuCW1zOmKJCu9pn6qBTKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732918551; c=relaxed/simple;
	bh=fYKA4y04j9xOPozuCtk7+0H25ug7zQT9GSsyygf5xFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfyxu4IkMSVNiZskvB7lpgkJGfhJ1mKC4gi5/6+uZMKsCHyROxh1MWZYKpLjHw8qdJOKgAYpc5McAa93EYBk9DQuFy/ZngKZe6NVfZaNymrlJX4knNfczzmsViCfOeWM56KXvHIZ6QDlrtPt2VEtmNavIlTbyLjzAGfDc8Nr7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKK9BsQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D59C4CECF;
	Fri, 29 Nov 2024 22:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732918551;
	bh=fYKA4y04j9xOPozuCtk7+0H25ug7zQT9GSsyygf5xFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKK9BsQCpy3FQSPynNZw8q7mdkyNnkT0RRYWHnUwxXk/OU4RtrB0vPmrMvcpTkraJ
	 3Rc/et6SU415J1gE6NGye4a14qHv97LVhoYRvfHPuqOQwltkStU5twZ0MmxCMIuB9R
	 hhmV8Tgq5TFrebPYJsUxxM+8UEFSEvT2MJIbVysKnc39RZw8ApVE4RbSfCkS/ho7wi
	 Ha4mAT1r7eFkielz/EwDzpoVjLyiy+FsupK/G35ZvxegE8xyL1EaRFd61FUdStOth7
	 LHHQq9Gvai/ILWRMTzdmOKAg8DnLR5GFH1zyP2JmcQV5HH/+Wfp4Im9ftbH6fuT6Kv
	 RdTFwNpnCdPiA==
Date: Fri, 29 Nov 2024 23:15:48 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 11/21] arm64: Keep first mismatched 32bits el0 capable
 CPU online through its callbacks
Message-ID: <Z0o9FMFZ9Y8HkvzJ@pavilion.home>
References: <20241112142248.20503-1-frederic@kernel.org>
 <20241112142248.20503-12-frederic@kernel.org>
 <20241128162618.GA3653@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241128162618.GA3653@willie-the-truck>

Le Thu, Nov 28, 2024 at 04:26:19PM +0000, Will Deacon a écrit :
> Hi Frederic,
> 
> On Tue, Nov 12, 2024 at 03:22:35PM +0100, Frederic Weisbecker wrote:
> > +static int mismatched_32bit_el0_offline(unsigned int cpu)
> > +{
> > +	return cpu == cpu_32bit_unofflineable ? -EBUSY : 0;
> > +}
> 
> I think this is far too late. The reason we prevent hot-unplug of the
> last 32-bit CPU is because 32-bit tasks need somewhere to run. By the
> time our offline notifier runs, those tasks have already been migrated.
> 
> On my setup, this explodes because that migration fails (as expected):

Duh!

> 
> 
> [  125.954586] ------------[ cut here ]------------
> [  125.955661] kernel BUG at kernel/sched/core.c:3501!
> [  125.957585] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> [  125.959371] Modules linked in:
> [  125.961850] CPU: 2 UID: 0 PID: 27 Comm: migration/2 Not tainted 6.12.0-00001-ge7689036c862-dirty #10
> [  125.963711] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> [  125.964859] Stopper: __balance_push_cpu_stop+0x0/0x134 <- balance_push+0x118/0x1ac
> [  125.968507] pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [  125.969648] pc : select_fallback_rq+0x2f4/0x2f8
> [  125.970477] lr : select_fallback_rq+0x198/0x2f8
> [  125.971273] sp : ffff800080153d20
> [  125.971897] x29: ffff800080153d30 x28: 0000000000000002 x27: ffffddbd31d79d30
> [  125.973416] x26: 0000000000000001 x25: ffffddbd31d79c70 x24: 0000000000000008
> [  125.974436] x23: ffffddbd31d79000 x22: ffffddbd31a77190 x21: 0000000000000004
> [  125.975452] x20: ffff0000c506a280 x19: 0000000000000000 x18: ffffddbd30fb1df0
> [  125.976467] x17: 0000000000000000 x16: 0000000000000001 x15: 000000000018132d
> [  125.977490] x14: 00000000ffffffe0 x13: 0000040000000000 x12: 00000c0000000000
> [  125.978499] x11: 000000002ae00002 x10: 000000000000000c x9 : 0000000000000040
> [  125.979507] x8 : 0000000000000000 x7 : 000000000000000c x6 : 000000000000000c
> [  125.980501] x5 : ffff0000c506a578 x4 : ffffddbd2fe53eb0 x3 : 0000000000000010
> [  125.981508] x2 : 0000000000000004 x1 : 0000000000000004 x0 : 0000000000000004
> [  125.982671] Call trace:
> [  125.983065]  select_fallback_rq+0x2f4/0x2f8
> [  125.983550]  __balance_push_cpu_stop+0x94/0x134
> [  125.983983]  cpu_stopper_thread+0xbc/0x174
> [  125.984352]  smpboot_thread_fn+0x1e4/0x24c
> [  125.984732]  kthread+0xfc/0x184
> [  125.985065]  ret_from_fork+0x10/0x20
> [  125.985741] Code: 9000d9c0 91306000 9441667a 17ffffef (d4210000) 
> [  125.986445] ---[ end trace 0000000000000000 ]---
> 
> 
> As I mentioned before, I think we need to turn this the other way around
> so that the non-unpluggable 32-bit core is forced to be a housekeeping]
> CPU. You said it was hard to revert CPUs from being treated as nohz_full,
> but I'm wondering whether we can prevent it from being added in the first
> place. The arch code has fingers in all the early boot pies.

So the mismatch is detected (and the unpluggableability forced) late on boot,
during secondary boot up. OTOH housekeeping is set up much earlier, on kernel
parameters parsing. Would it be possible to detect at this stage if a
possible yet non-booted CPU doesn't support 32bits el0?


> Yet another option (which I'm not hugely fond of, but may be ok) would
> be to treat 32-bit-capable nohz_full CPUs as being 64-bit-only when
> 'allow_mismatched_32bit_el0' is enabled (and documenting this as a
> limitation).

There is that too indeed.

Thanks.

> 
> Will

