Return-Path: <linux-kernel+bounces-530489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB2A4341A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D2C3A76B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77A3186E54;
	Tue, 25 Feb 2025 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="l0wDhVEW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28899154439
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740457645; cv=none; b=byr0BneDBbKqLspHcztehabj4OJ/I8Z2rmtsDl+IAMbMIW8LSvimppwCrv0EWHfkEVTFv56lyOuLu7mKmzzdFH18Ky1uYt2WAuBiy1waDIHR4sH0dd7uNhF7AMC9h2znqirTnSJ78V69FOMfsKz2OTUbDLX7X+KzZG0CJe40QNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740457645; c=relaxed/simple;
	bh=QjPv24yDsjUsI3Lky6i2FsPYQkvhwvbazTW3e8yl9T0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UzeaJonrg5ulghTG3fJWFcJZXPjOxYPFl1PVaQh60MPuWe2EXmwkwG2I9/8eB2yuFjQnCt4VzGou7Mx14/l4Dm+tOgkVD9VPTBOANUh+vBs6k0LztJR+y9hLRvWU6k3jiTL+gMhLauVPA8fWJNaJPWH4xzZTdVz+R/Hsl2S5ocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=l0wDhVEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A51CC4CEDD;
	Tue, 25 Feb 2025 04:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740457644;
	bh=QjPv24yDsjUsI3Lky6i2FsPYQkvhwvbazTW3e8yl9T0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l0wDhVEW2z00zJfQqJ6wdZeYj5ISAtvw3ardHaicaPBXk00sU/e/9Tc2/Dm+TceN8
	 hQ7+7NCc/Shegn2bfw7OB0EtS7UTevM4h3sBJ7LbvlAcPzVnSfj1dtlloMUZ7wTuvb
	 7JyiN7jcO1H7Xlq3g8qQT/qYhN/nJ1/1xcBs3QKg=
Date: Mon, 24 Feb 2025 20:27:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com, "Paul E. McKenney"
 <paulmck@kernel.org>
Subject: Re: [PATCH 1/1] radix-tree: Prevent NULL pointer dereference in
 radix_tree_node_rcu_free
Message-Id: <20250224202723.aa20e103b6b3bc3de65ca7e4@linux-foundation.org>
In-Reply-To: <20250223200603.38895-1-ayaanmirzabaig85@gmail.com>
References: <20250223200603.38895-1-ayaanmirzabaig85@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 01:31:08 +0530 Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com> wrote:

> syzkaller reported a kernel NULL pointer dereference:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: Oops: 0010 [#1] PREEMPT SMP KASAN NOPTI
> 
> Call Trace:
>  <IRQ>
>  rcu_do_batch kernel/rcu/tree.c:2546 [inline]
>  rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2802
>  handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
>  __do_softirq kernel/softirq.c:595 [inline]
>  invoke_softirq kernel/softirq.c:435 [inline]
>  __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
> 
> Reported-by: syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com
> 
> Link: https://syzkaller.appspot.com/bug?extid=80e5d6f453f14a53383a
> Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> ---
>  lib/radix-tree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> index 976b9bd02a1b..5cefbfd7677e 100644
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -292,6 +292,9 @@ void radix_tree_node_rcu_free(struct rcu_head *head)
>  	struct radix_tree_node *node =
>  			container_of(head, struct radix_tree_node, rcu_head);
>  
> +	if (unlikely(!node))
> +		return; //Prevent NULL deref
> +
>  	/*
>  	 * Must only free zeroed nodes into the slab.  We can be left with
>  	 * non-NULL entries by radix_tree_free_nodes, so clear the entries

Well, we should work out why this happened.  Cc Paul ;)

