Return-Path: <linux-kernel+bounces-512832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A446A33E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74AF1884757
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025FC20B1E0;
	Thu, 13 Feb 2025 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y7JnLtuq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pyXptmk6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECC202C31
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446766; cv=none; b=FWXkYscEDDoVczphRBDDJe7fPj1hEIUzjzhtovewY94Xp04WTyiso9SpjUsE3gllvUs0MR8jZPwB2TOO+OK4w3Gf9Mel5p3LlDjucEVNKbsHK06lp475XCb1Db/ILS8pBU9BTVcEC5vJ5rFyVLL5SoqNRVI7ZxghnS5PAujJaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446766; c=relaxed/simple;
	bh=r1J1nOJJQ1qOEV+oJT4ix+/3dEqlM6GkfZDwqwwLiR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eoMrwK0BgaD6zHghjVPErWFSfCe7n6sFwDt6XCaSNHsEKuOxBQcp3tdfP883+3oWSHoVwub4mzUHzFO7ZquTacp7QtCzfYMWqxvMYGtjCSjj8dzhz4BuZ5BkiN8kgXlK8sPv7xjxuLwVKPmV6uiMbsKQ0BiWgUa7c0jK3TfaPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y7JnLtuq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pyXptmk6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739446761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BA4Rrz13yIvgpUnDYRiUiQn6eNCsiZnBZO/XX9ez/vw=;
	b=Y7JnLtuqeGi0rmpxv/vPGQORRne7WWYG8Nl9lt0zUfE0AtlFVTrlYLco4+gwrSa4T/udny
	sdVjF3BoP51h3fU+3huj2IGTdvA7fUI4AB+Ubve+pXXudLG2O+Uu/OD7LENer5x2XsPhuo
	X7qf9gFnCvRtDBJXCVj3KZY9fTJnpdvSZO5k7hIgyMDXAlBTI2h/KMrjx2Cy32AO7a+nR+
	n/MlV/ID0vKF92mrKH+D7UiYJ07Wu3x3zTTtlxfLNZFhr/c4+nBxTArOiZKQwem4BX31BW
	k4Yy3J1kqpfIhhAyv5vW5xn/2b/rUct9zPfS5x6w7KkZaAUuPGVWIsNBWaLWyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739446761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BA4Rrz13yIvgpUnDYRiUiQn6eNCsiZnBZO/XX9ez/vw=;
	b=pyXptmk6f4o5MyrZck6ChWgS+VS+YZIexkO70mru2gCXgb+M0EOct+hRlwQoOGWGl6zsf4
	zWHi8vQeC42cOXCg==
To: Bo Ye <bo.ye@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dicken.ding@mediatek.com, hanks.chen@mediatek.com,
 xiujuan.tan@mediatek.co, Bosser Ye <bo.ye@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] genirq: clear IRQS_PENDING in irq descriptor
In-Reply-To: <20250211023040.180330-1-bo.ye@mediatek.com>
References: <20250211023040.180330-1-bo.ye@mediatek.com>
Date: Thu, 13 Feb 2025 12:39:21 +0100
Message-ID: <871pw2kr9y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 11 2025 at 10:30, Bo Ye wrote:
> In the kernel-6.6 IRQ subsystem, there is a case of IRQ retrigger:

How is kernel 6.6 relevant here?

> Due to the possibility of electrical signal glitches causing false
> interrupts for edge-triggered type IRQs, it is necessary to clear any
> potential false interrupts or re-triggered interrupt signals from the
> interrupt source between disabling and enabling the edge-triggered
> IRQ.

This claim is just wrong.

A disable_irq(); enable_irq(); sequence must preserve the pending bit so
that interrupts do not get lost. The lazy disabling mechanism is there
to guarantee that.

> When the module using this IRQ may disable the IRQ as needed and then
> If the disabled IRQ is triggered, the IRQ subsystem will set the
> istate of the corresponding IRQ descriptor to pending.

Rightfully so.

> After the module using this IRQ completes other tasks, it clears the
> pending state on the GIC using irq_set_irqchip_state().

So this is a problem related to a specific out of tree driver and the
GIC, right? 

> However, the pending state in the IRQ descriptor's istate is not
> cleared, which leads to the module receiving the IRQ again after
> enabling it, even though the interrupt source has not triggered,
> because the IRQ subsystem retriggers the interrupt based on the
> pending state in the IRQ descriptor.

What's the actual problem here? A driver has to be able to handle
spurious interrupts at any given time.

> Solution: the corresponding upstream patch modifies the
> irq_set_irqchip_state(...) in the IRQ subsystem.

Which corresponding upstream patch?

> The purpose is to clear the pending state in the IRQ descriptor's
> istate when successfully clearing the corresponding IRQ on the GIC.

Sure that's the purpose, but you fail to explain the actual problem and
the interaction with irq_set_irqchip_state().

Thanks,

        tglx

