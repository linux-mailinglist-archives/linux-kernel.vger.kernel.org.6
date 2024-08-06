Return-Path: <linux-kernel+bounces-276678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E0A9496EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4AC1F243A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FF6481B7;
	Tue,  6 Aug 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pvhv4wmv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P6epufFH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D904D9FE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965617; cv=none; b=lix7LuwKCpy8tN2In4YJl4IUUsevVyMAUlZlh4HytcL8NzmwNzFiP92qBWGoVuBnTwVbK22PKCC8fr6VWf4L9GCla3t2CdvJgkYv7NmZFeXMw6FLxUXBkiy5GBomAkIpndArTwxo1vmd0N1bXCJWSRi9iWxo8t6xBPoep1ZqzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965617; c=relaxed/simple;
	bh=9HOedu96Ils0IfNfg1nt5Ydc94UdDMQD7wUIn+Jkpdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GHyWVBFNtPKdB/Mc9qMq1dbDp30VKJ0ie7/4kFhRf7CYHGFU/S1sC7wQLC41PdjyRemgocRQ47cwxg268HzC7iz1E3BPNxjXpts6u31vIcq0Xc4o3sIuN1SDmJFC6kgzr3/UVvTRwDEOQjSl59NEiIjf5ra69y2dt0ni4mUlN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pvhv4wmv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P6epufFH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722965614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lW3oZDM/W2dmHd7S9JZ3PSe6gHz+R+5ylzsov77+p/4=;
	b=pvhv4wmv94VM56UvsCebp/kuT37AUhDmwNpCPjpw1t5BWGJoU30bPphbZE9RbmLU6yVQyW
	N0UrTx/uBFyDtg9nsXcx2jVrKiQg+UtzzsaroNSaPWCi4M2m8h6WXe5iQ5/LtHH9bsL5HL
	6UZNIgdbMo0G6N1oFM/lYsK4OwFeOUEgjWYN88PCM7W2NDOZ9Ck5CDCZMCZ+9/DRyMn/iz
	EWkL/f/P9l77HLTdmsSeogl3HJBPjL3OCrkToL5+J700fT7axVk/CssdQ3UC9JfqYOX3Gf
	SQEH35kLiZlhFsNQZeJUb7J12k84X0rLx7NxCKzmrxxiLW2JA9y8+lIyaJyuuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722965614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lW3oZDM/W2dmHd7S9JZ3PSe6gHz+R+5ylzsov77+p/4=;
	b=P6epufFH3NyZMxPwej0/sQTU1kLGxA4FlbL3F20x4CC5fCtTaWJXgZKjEoadaAplZazUw4
	/Uyi5ZXx5BudxlCQ==
To: Vlastimil Babka <vbabka@suse.cz>, Linus Torvalds
 <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
In-Reply-To: <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>
Date: Tue, 06 Aug 2024 19:33:33 +0200
Message-ID: <87le194kuq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06 2024 at 13:02, Vlastimil Babka wrote:
> On 8/6/24 04:40, Linus Torvalds wrote:
> It looks like maxobj calculation is bogus, would be useful to see what values it
> calculates from. I'm attaching a diff, but maybe it will also hide the issue...

It does hide it :(

> If someone has a /proc/slabinfo from a working boot with otherwise same config
> it might be also enough to guess what values should be expected there,
> at least the s-size.
>
> objects=21 vs 25 also seem odd though
>
> used=5 with used=6 in the first two also suggests we already passed this code
> successfully for creating a number of kmalloc caches and only then it started
> failing, that's also weird.

I added a printk() to check_slab() and on the non-failing boot this
looks like:

[    0.000000] c 000000004017b0f8 c 0000000041ed0000 objects 21 max 21 order 0 size 192, inuse 2
[    0.000000] c 000000004017b1c8 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 1
[    0.000000] c 0000000043402010 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 2
[    0.000000] c 0000000043402010 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 3
[    0.000000] c 0000000043402150 c 0000000041ed0000 objects 21 max 21 order 0 size 192, inuse 3
[    0.000000] c 0000000043402010 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 4
[    0.000000] c 0000000043402150 c 0000000041ed0000 objects 21 max 21 order 0 size 192, inuse 4
[    0.000000] c 0000000043402010 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 5
[    0.000000] c 0000000043402150 c 0000000041ed0000 objects 21 max 21 order 0 size 192, inuse 5
[    0.000000] c 0000000043402010 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 6
[    0.000000] c 0000000043402150 c 0000000041ed0000 objects 21 max 21 order 0 size 192, inuse 6

I did some more experiments to figure out why adding or removing text
cures it. The minimal change which makes it boot again is:

 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
+	current->flags &= ~PF_MEMALLOC;
 	handle_softirqs(false);
 }

That results in the following System.map delta:

--- ../upstream.txt	2024-08-06 16:52:49.746528992 +0200
+++ ../build-misc/System.map	2024-08-06 19:02:32.652201977 +0200
@@ -47600,15 +47600,15 @@
 0000000041218c30 T __do_softirq
 0000000041218c30 T __irqentry_text_end
 0000000041218c30 T __softirqentry_text_start
-0000000041218c70 T $$divoI
-0000000041218c70 T __softirqentry_text_end
-00000000412190d0 T $$divI_2
-00000000412190d0 T $$divide_by_constant
-00000000412190e0 T $$divI_4
-00000000412190f0 T $$divI_8
-0000000041219100 T $$divI_16
-00000000412192d8 T $$divI_17
-000000004121930c T $$divU_17
+0000000041218c80 T $$divoI
+0000000041218c80 T __softirqentry_text_end
+00000000412190e0 T $$divI_2
+00000000412190e0 T $$divide_by_constant
+00000000412190f0 T $$divI_4
+0000000041219100 T $$divI_8
+0000000041219110 T $$divI_16
+00000000412192e8 T $$divI_17
+000000004121931c T $$divU_17
 000000004121a000 D __start_opd
 000000004121a000 D _etext
 000000004121a000 D _sdata

So this change adds 16 bytes to __softirq() which moves the division
functions up by 16 bytes. That's all it takes to make the stupid go
away....

I wonder whether this is some qemu stupid.

Thanks,

        tglx

