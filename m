Return-Path: <linux-kernel+bounces-222591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142591043C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED1D1F21EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D141AC780;
	Thu, 20 Jun 2024 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Chl5D/i5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855F1A8C03;
	Thu, 20 Jun 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886680; cv=none; b=mAzEjOf0YOZW3jHBGQ1vuUvWPANqFvFk7GAz+TkI+ad3OTbTnEegpwoJ0z0NCJmU/FBv59qOv6GyovXQWDDKTqckRfr8S2NAr1+23sJ+bclmfHYqZoCPpiWHrgqdI6BNnEmHzsIY0LrESGl4Bt3GtHqiMv+33f03xsnED4RffSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886680; c=relaxed/simple;
	bh=CzLQPFPgm5W33TEwVXj/lQd3pJ5PvjIpvQTILdCthP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alOYaf6AysbOHLyOe7n9JnKaVV0UmbgGl8nEUDnV8pN/rwiqUGlQ6NM7eOdRR0+LGE8nxgStSVUplDT6vsEee06jBhmQQnQL3FdP20vDS6LdBEHT0ra7i/W4afRwx51ee3MkeSj9KbEbwWXsR5ltywiHGuIpM7rxHFmUOXBvXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Chl5D/i5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB4FC2BD10;
	Thu, 20 Jun 2024 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718886680;
	bh=CzLQPFPgm5W33TEwVXj/lQd3pJ5PvjIpvQTILdCthP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Chl5D/i5kxk7B9DFzveHJFZUtaQ0hXGlMDiAe6W8G80LhngfPiJjaNjSMY2MXTB4n
	 /KA9OZEHZ7cD33jAHcnUmLoLnoCOKZAsbdOnj89z6in29pE85pfGKY+NXkgDWzlF+Q
	 YuoB97YpkiICLUkmQiMZ7jYond+OywKpahxFflZU=
Date: Thu, 20 Jun 2024 14:31:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Hillf Danton <hdanton@sina.com>,
	syzbot <syzbot+973d01eb49b060b12e63@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in wdm_release
Message-ID: <2024062045-improve-tidbit-ed0d@gregkh>
References: <20240620103847.1724-1-hdanton@sina.com>
 <0044d7b1-ae7d-4d36-b730-38b06186c8bf@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0044d7b1-ae7d-4d36-b730-38b06186c8bf@I-love.SAKURA.ne.jp>

On Thu, Jun 20, 2024 at 08:47:03PM +0900, Tetsuo Handa wrote:
> On 2024/06/20 19:38, Hillf Danton wrote:
> > On Thu, 20 Jun 2024 02:08:21 -0700
> >> Showing all locks held in the system:
> >> 3 locks held by kworker/u8:0/11:
> >>  #0: ffff8880b953e7d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
> >>  #1: ffff8880b9528948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
> >>  #2: ffff8880754f0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5966 [inline]
> >>  #2: ffff8880754f0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: cfg80211_wiphy_work+0x35/0x260 net/wireless/core.c:424
> > 
> > The info looks bogus given acquiring mutex with runqueue lock held.
> 
> Nothing wrong. Printing the backtrace and/or locks held is not atomic.
> That is, locks held by a non current thread can change at any moment.
> 
> For example, the former block starting with
> "INFO: task syz-executor320:7035 blocked for more than 142 seconds."
> says that pid 7035 is blocked at "mutex_lock(&wdm_mutex)", but the latter
> block starting with "Showing all locks held in the system:" says that
> pid 7035 was holding (or trying to hold) no lock.
> 
> Threads were making progress slowly. Though, printk() flooding by
> 
>   cdc_wdm 5-1:1.0: nonzero urb status received: -71
>   cdc_wdm 5-1:1.0: wdm_int_callback - 0 bytes
> 
> should be avoided. We need to persuade Greg to let these noisy messages reduced.

Please see:
	22f008128625 ("USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages")
it should have fixed this already.

