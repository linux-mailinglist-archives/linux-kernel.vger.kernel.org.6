Return-Path: <linux-kernel+bounces-188076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9CB8CDCE2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA391C22DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A07126F27;
	Thu, 23 May 2024 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gq3kyfpz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0EJq6Q3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B78101E2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503569; cv=none; b=N5Uis7dQGV2J/TQAOwxMD8USKJueo5rkYI9XLL2K6qyYbAj6ozj8nvDzzTaVPswEEoBlVUIDi7eQbjaGhd2VKsf3zxF4qm7je+j12b896FhNMjQpbP0mkknEoKUttWx/nOACg2sxuPh1/GKBkLWH/TN8ogV9Kcm/zoBP3IJ7X8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503569; c=relaxed/simple;
	bh=w0yAmaXElVRuUzavPH0AzyMtrbdonziNp5Tcb9MGaHY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5cevW5jTQhl2ehtQBnggm3vF2h7HtAj4zQ5t6cmtvp9zJeIk3Hla1Kj5niUqC9EZAIYh1SV/WZNZQDQYMJQ1ixYD3uaOsS9mTPkf9W+r1aCAhW4wnluXH8vgW93/igwp1lM9dU3I0CeMp0rynVnYreS3UsqIMWIwfc6/GsLieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gq3kyfpz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0EJq6Q3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716503566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gcwhKwWiYkkvnly8C5LXaEQL7Q16QzdORDIjhnOhuyM=;
	b=gq3kyfpzkAMxNlWrSXHiO/lJ0kdC4Wi4ESKWucqD/5LEu5xs+wMsAZtX8mLDA9pfBJNGZy
	a2mRjuKBHte7t8StGqHF9Fk+kPTY7r8I3Cf0dFjcL/FUjRD9xjXqj6N0FDOIw3IFb4EsTt
	N2T26nbNuYx7iKRIDnGteZDvRkl2duANvHAVsoTTHRDkW4bl+adzkQwFEd0/+i2DA2swn9
	0o+V4UgstK2eMM2DDBYIutQeltqqS9keNW5DONP42RqIIIwhRzkJEt/Nvx1uKDp+MKhh3G
	n9Q11MNbx/rtJ0lEwzwkJy9HVmjTa20j62/586hAVX/qJ3Wn1wPxBm6emGokVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716503566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gcwhKwWiYkkvnly8C5LXaEQL7Q16QzdORDIjhnOhuyM=;
	b=m0EJq6Q3Bv+wtnC9MmrXKCodOcybz7kUd9Oz53glx+aoR1LP39QA2EAtMmnXBwuSIjXCtm
	AiCAbqN8xkwFAtAA==
To: Vlastimil Babka <vbabka@suse.cz>, syzbot
 <syzbot+50e25cfa4f917d41749f@syzkaller.appspotmail.com>, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, syzkaller-bugs@googlegroups.com, x86@kernel.org,
 linux-mm@kvack.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING in flush_cpu_slab
In-Reply-To: <2149ee23-5321-4422-808f-e6a9046662fc@suse.cz>
References: <0000000000008c9d27061915ca9c@google.com> <87v834g6hn.ffs@tglx>
 <2149ee23-5321-4422-808f-e6a9046662fc@suse.cz>
Date: Fri, 24 May 2024 00:32:45 +0200
Message-ID: <87r0dsdur6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 23 2024 at 23:03, Vlastimil Babka wrote:
> On 5/23/24 12:36 PM, Thomas Gleixner wrote:
>>> ------------[ cut here ]------------
>>> DEBUG_LOCKS_WARN_ON(l->owner)
>>> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
>>> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 flush_slab mm/slub.c:3088 [inline]
>>> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 flush_cpu_slab+0x37f/0x410 mm/slub.c:3146
>
> I'm puzzled by this. We use local_lock_irqsave() on !PREEMPT_RT everywhere.
> IIUC this warning says we did the irqsave() and then found out somebody else
> already set the owner? But that means they also did that irqsave() and set
> themselves as l->owner. Does that mey there would be a spurious irq enable
> that didn't go through local_unlock_irqrestore()?
>
> Also this particular stack is from the work, which is scheduled by
> queue_work_on() in flush_all_cpus_locked(), which also has a
> lockdep_assert_cpus_held() so it should fullfill the "the caller must ensure
> the cpu doesn't go away" property. But I think even if this ended up on the
> wrong cpu (for the full duration or migrated while processing the work item)
> somehow, it wouldn't be able to cause such warning, but rather corrupt
> something else

Indeed. There is another report which makes no sense either:

 https://lore.kernel.org/lkml/000000000000fa09d906191c3ee5@google.com

Both look like data corropution issues caused by whatever...

Thanks,

        tglx

