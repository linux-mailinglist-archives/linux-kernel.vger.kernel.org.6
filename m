Return-Path: <linux-kernel+bounces-554618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B715A59A88
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7196161FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8C322F392;
	Mon, 10 Mar 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ph2ws8m+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C322FDFF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622270; cv=none; b=YWy6PHyZoHFA/kE8GyUMgeX5IAV2Uw0DVuaCdVUfpisnYYOXZU1Q5bDwzilbrkUltXe+OBznosIBf6YjXA4+RFpX4c31I13eB+DxL4/CjcNmkBOsfYGGm4qxYwmm88MaROyzhXxUrSxHyJdc3UvPypqFfz2qxm6E5KeavEHhQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622270; c=relaxed/simple;
	bh=Hk7v68TTqyirNYChluVcrz+uWtVpA4knyrH4vJdLGl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQduB9+ekgBzg4kNUL3qFxMqxy6gA6GNg4DEkuOUGHYdnwgMxPrnMgwMZKhK32+EFqWOERiY0dPrndngLXqg48NlEzdjkx6piZeuVGPXVDglSC5cKAJ0xi1eePvFCzGoOHdPG5d8gVeR4NFZC+Tt+lri+Np9qfz3cJY2BmZaDtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ph2ws8m+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SqHo59XzDIpVuxGbXgfioutIlx7pzM5Dqoc/EIKtcAo=; b=Ph2ws8m+fPmsAbZx2b4TTMyfMo
	QYisSQ/gjqYi/Dy2lgoJI/n6/hvNm0cizy1No/4r6TR2XLSawyJFc/5uRO4Y4zQVU0OA1Pa1NloT0
	S3t+C3oYPnrHC6/QxkGW9TYWsgx8gBHHE0WcDdhdXI2yIH3yYgMBDwJzbBbXtTejU8QJSwa2T1pHr
	uWCcIJvCCDE/g/e3jg9KkFVxmsa36tsYaU5Tjg47xvMwSC6uMumNFV2xNHJ6SkM8H2rQ7DR1Hc1O/
	WniNJtMovtgeld/UZlTkMJOGeOgTVmSgW/EIWVTP/xUIs+aWG5cjXNjKrI0bQ2kHZ9XghiGyV5bzI
	rKTmIKYQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trfVe-00000001uDL-2w8T;
	Mon, 10 Mar 2025 15:57:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 069BB300599; Mon, 10 Mar 2025 16:57:42 +0100 (CET)
Date: Mon, 10 Mar 2025 16:57:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v9 00/11] futex: Add support task local hash maps.
Message-ID: <20250310155741.GF19344@noisy.programming.kicks-ass.net>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250303105416.GY11590@noisy.programming.kicks-ass.net>
 <20250303141753.tF-FoCm1@linutronix.de>
 <20250303164015.HHfy1Ibj@linutronix.de>
 <20250304145837.a8g07J-k@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304145837.a8g07J-k@linutronix.de>

On Tue, Mar 04, 2025 at 03:58:37PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-03 17:40:16 [+0100], To Peter Zijlstra wrote:
> …
> > You avoided the two states by dropping refcount only there is no !new
> > pointer. That should work.
> …
> > My first few tests succeeded. And I have a few RCU annotations, which I
> > post once I complete them and finish my requeue-pi tests.
> 
> get_futex_key() has this:
> |…
> |         if (!fshared) {
> |…
> |                 if (IS_ENABLED(CONFIG_MMU))
> |                         key->private.mm = mm;
> |                 else
> |                         key->private.mm = NULL;
> |
> |                 key->private.address = address;
> |
> 
> and now __futex_hash_private() has this:
> | {
> |         if (!futex_key_is_private(key))
> |                 return NULL;
> |
> |         if (!fph)
> |                 fph = rcu_dereference(key->private.mm->futex_phash);
> 
> Dereferencing mm won't work on !CONFIG_MMU. We could limit private hash
> to !CONFIG_BASE_SMALL && CONFIG_MMU.

Humph, yeah, not sure we should care about !MMU.

> Ignoring this, I managed to crash the box on top of 49fd6b8f5d59
> ("futex: Implement FUTEX2_MPOL"). I had one commit on top to make the
> prctl not blocking (make futex_hash_allocate(, false)). This is simulate
> the fork resize. The backtrace:
> | [   T8658] BUG: unable to handle page fault for address: fffffffffffffff0
> | [   T8658] #PF: supervisor read access in kernel mode
> | [   T8658] #PF: error_code(0x0000) - not-present page
> | [   T8658] PGD 2c5a067 P4D 2c5a067 PUD 2c5c067 PMD 0
> | [   T8658] Oops: Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
> | [   T8658] CPU: 6 UID: 1001 PID: 8658 Comm: thread-create-l Not tainted 6.14.0-rc4+ #188 676565269ee73396c27dead3a66b3f774bd9af57
> | [   T8658] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.02.03.0003.041920141333 04/19/2014
> | [   T8658] RIP: 0010:plist_check_list+0xb/0xa0
> | [   T8658] Code: cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 54 49 89 fc 55 53 48 83 ec 10 <48> 8b 1f 48 8b 43 08 48 39 c7  74 27 48 8b 4f 08 50 49 89 f8 48 89
> | [   T8658] RSP: 0018:ffffc90022e27c90 EFLAGS: 00010286
> | [   T8658] RAX: 0000000000000000 RBX: ffffc90022e27e00 RCX: 0000000000000000
> | [   T8658] RDX: ffff888558da02a8 RSI: ffff888558da02a8 RDI: fffffffffffffff0
> | [   T8658] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8885680dc980
> | [   T8658] R10: 0000031e8e1a7200 R11: ffff888574990028 R12: fffffffffffffff0
> | [   T8658] R13: ffff888558da02a8 R14: ffffc90022e27e48 R15: ffffc90022e27d38
> | [   T8658] FS:  00007f741af9e6c0(0000) GS:ffff8885a7c2b000(0000) knlGS:0000000000000000
> | [   T8658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> | [   T8658] CR2: fffffffffffffff0 CR3: 00000006d7aca005 CR4: 00000000000626f0
> | [   T8658] Call Trace:
> | [   T8658]  <TASK>
> | [   T8658]  plist_del+0x28/0x100
> | [   T8658]  __futex_unqueue+0x29/0x40
> | [   T8658]  futex_unqueue_pi+0x1f/0x40
> | [   T8658]  futex_lock_pi+0x24d/0x420
> | [   T8658]  do_futex+0x57/0x190
> | [   T8658]  __x64_sys_futex+0xfe/0x1a0
> 
> It takes about 1h+ to reproduce. And only on one particular stubborn
> box. This originates from futex_unqueue_pi() after
> futex_q_lockptr_lock(). I have another crash within
> futex_q_lockptr_lock() (in spin_lock()).
> 
> This looks like the locking task was not enqueued in the hash bucket
> during the resize. This means there was a timeout and the unlocking task
> removed it while looking for the next owner. But the unlocking part
> acquired an additional reference to avoid a resize in that case. So,
> confused I am.

Yeah, weird that.

> I reverted to 50ca0ec83226 ("futex: Resize local futex hash table based
> on number of threads."), have the another "always resize hack" and so
> far it looks good.
> Looking at __futex_pivot_hash() there is this:
> |         if (fph) {
> |                 if (rcuref_read(&fph->users) != 0) {
> |                         mm->futex_phash_new = new;
> |                         return false;
> |                 }
> |
> |                 futex_rehash_private(fph, new);
> |         }
> 
> So we stash the new pointer as long as rcuref_read() does not return 0.
> How stable is rcuref_read()'s 0 return actually? The code says:
> 
> | static inline unsigned int rcuref_read(rcuref_t *ref)
> | {
> |         unsigned int c = atomic_read(&ref->refcnt);
> |
> |         /* Return 0 if within the DEAD zone. */
> |         return c >= RCUREF_RELEASED ? 0 : c + 1;
> | }
> 
> so if it got negative on its final put, the c becomes -1/ 0xff…ff. This
> +1 will be 0 and we do a resize. But it is negative and did not reach
> RCUREF_DEAD yet so it can be bumbed back to positive. It will not be
> deconstructed because the cmpxchg in rcuref_put_slowpath() fails. So it
> will remains active. But we do a resize here and end up with to private
> hash. That is why I had the `released' member.

I am not quite sure I follow. If rcuref_put_slowpath() returns true;
then the value has been set to DEAD (high nibble E), any concurrent
inc/dec will move it away from that a little, but it will always be set
back to DEAD (IOW, you need 1<<29 concurrent modifications into the same
direction to push it out of the DEAD range).

As long as it is within those 29 bits of DEAD, rcuref_read() should
return 0.


