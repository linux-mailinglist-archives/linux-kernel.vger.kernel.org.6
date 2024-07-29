Return-Path: <linux-kernel+bounces-266075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A393FA61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7BA1C22202
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4897615A86D;
	Mon, 29 Jul 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aQlc+/k1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dxPfN5o0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506A15A87C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269618; cv=none; b=spolyHoE7GozUmP1ZdOBn54t2AkiEAeS62nEHAL191slaPMeOWgY7eZYeoSzosy4dOsRCk6WRA8M0rnbqP+cRAw1hArRuLAqoDNmwHDbGPXX5wrDsPAOtprxkP5WgQym4pfkj0H0LPVe5PsNX/v4ezieqLL3e8cBF5ZZGnSkydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269618; c=relaxed/simple;
	bh=tCTjUC5rhasvzq+Y8zZOFMdnMktPZA0m+vLnG8RMdio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rfu/sbcXmBQOgoImpQhx5euxofHpCezgdpR87wXewVkQknCahOGr31/6ljIx1Fw2OVzLXLOEZzQzbn9muKzDgyNIqD1/25Wu93vv383oKW6MA57Sw+QRU2YMM20NPgf8OjaRhenpUi5moVYfMfQRbYfXP6/koJkUaMkZkjd0LvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aQlc+/k1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dxPfN5o0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722269614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQOzc4A/CKoY+z2y3ldZhRJ/TMUH+5YA9+WuZA16SqA=;
	b=aQlc+/k1+6AkQ6RTyXnyjoPFdJPxcP2qhSD+EYHNEuiICxViyZ4jNba71xndgGah/KFJr3
	w1hDdAtznb1Fx6MlEq3XXhHDVvp9KTajKvAasOIAIgW85jeL27+2W/3RdkDZ0wXk1Qf03I
	eo+cSYy1Evftbc0Ii2Dia/nUuHqV9ngrqrWb9Zfjz8zy1FHXQbncNy3625c1nNYTTfT5Eq
	22u5m1yQFjWLm0QWiOBPYx7M9dAQQT0e1gprgs4ZVapfE2OiWQlfHJVMH/ldA7LmlgU94b
	tE3IQwQ1k3keq8F5q7ykZG+acmenhRN0KFdbo2DnbcEt8e9SXBmej1dJ9y1TGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722269614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQOzc4A/CKoY+z2y3ldZhRJ/TMUH+5YA9+WuZA16SqA=;
	b=dxPfN5o06ld5S5nWrf/AXQiWYGETq1VtMkhvZi4WKFfwYkkebU4O5g7m4XMatE02uq3XK6
	IbLqIOhAnR8NFXAw==
To: Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: leit@meta.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Wei Liu
 <wei.liu@kernel.org>, Marc Zyngier <maz@kernel.org>, Adrian Huang
 <ahuang12@lenovo.com>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/apic: Add retry mechanism to add_pin_to_irq_node()
In-Reply-To: <20240729140604.2814597-1-leitao@debian.org>
References: <20240729140604.2814597-1-leitao@debian.org>
Date: Mon, 29 Jul 2024 18:13:34 +0200
Message-ID: <874j8889ch.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 29 2024 at 07:06, Breno Leitao wrote:
> I've been running some experiments with failslab fault injector running
> to detect a different problem, and the machine always crash with the
> following stack:
>
> 	can not alloc irq_pin_list (-1,0,20)
> 	Kernel panic - not syncing: IO-APIC: failed to add irq-pin. Can not proceed
>
> 	Call Trace:
> 	 panic
> 	   _printk
> 	   panic_smp_self_stop
> 	   rcu_is_watching
> 	   intel_irq_remapping_free

This completely lacks context. When does this happen? What's the system
state? What has intel_irq_remapping_free() to do with the allocation path?

> This happens because add_pin_to_irq_node() function would panic if
> adding a pin to an IRQ failed due to -ENOMEM (which was injected by
> failslab fault injector).  I've been running with this patch in my test
> cases in order to be able to pick real bugs, and I thought it might be a
> good idea to have it upstream also, so, other people trying to find real
> bugs don't stumble upon this one. Also, this makes sense in a real
> world(?), when retrying a few times might be better than just
> panicking.

While it seems to make sense, the reality is that this is mostly early
boot code. If there is a real world memory allocation failure during
early boot then retries will not help at all.

> Introduce a retry mechanism that attempts to add the pin up to 3 times
> before giving up and panicking. This should improve the robustness of
> the IO-APIC code in the face of transient errors.

I'm absolutely not convinced by this loop heuristic. That's just a bad
hack.

Thanks,

        tglx

