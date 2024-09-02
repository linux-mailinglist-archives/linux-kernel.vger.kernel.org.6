Return-Path: <linux-kernel+bounces-310725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E37EE96806E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F70C28155D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF38718660C;
	Mon,  2 Sep 2024 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NtJ/UEJ9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAVsmqnw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B65179654
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261556; cv=none; b=ssVfBe6br4xqoMibKwbernY3qaHljnVjLgi33jF/izcA3bCa8rINqHVmhlw05sdWmU4OWAw02J8iMai+kFHWWi5496TiQOP4LskJcI17YY8Mn6J1XYIJ18eBfQzIsXPtVXNwJap4Nez/N9Mz0UY7VDUOyXKJLpJppXX6aJ56nec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261556; c=relaxed/simple;
	bh=j72MwwKW7Fu2HpWQeZx307isBVjn1/l9C4J9YwN7xsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EgdqR2Ce1CWUpz8CU+cBYlHfuMq6TTXHpb4cZ8CojaBeVvF/+gDPNW0ZRMiaK74pFGgAUjUHTBiZbeAjotbo9mOfhpPx67rRp2vIFMWVYiZKLG9BXA8snb17zDLzSEzIP6Dym6i5L3luXWtDcfKPnWu//3jBdGu0+IgMgPicvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NtJ/UEJ9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAVsmqnw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725261550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMAwfdt+vm7ukxZbYgNH1CBhPOypcjLwM2SxBPAq2D4=;
	b=NtJ/UEJ9y19HW+fQWLliqQUtuqF3baCe/nOudxifZOAtKru+KRxzFNf6pyx8gXNWQUJGwg
	BFKzjP1PIAXOwW50VfkNd9ExW1NASb2b8fLmRdRT2QBXFnPqHfc1OymberGV9HX6JEPa3K
	ArdfcevclFnjEP8nm82mvM9jmxfO3CsZJ44hGiXt/7AgfXMkT6N4kapREpgkNpYhfaKM+N
	tf3sQM82vLSSPLYkSF/l7SlhiLHILO9hIUMQj5S9rhMaV7SAA/vjYDYJJWN60Y8CZdQACM
	Z+8XDO/IxOGpn2tl0fE5M9mIrtK9ybP0o7UXcRaXVP3rJ5YXhvEbXogoWzMVmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725261550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMAwfdt+vm7ukxZbYgNH1CBhPOypcjLwM2SxBPAq2D4=;
	b=sAVsmqnwup5tswjqbtRqR4+Tgtu8OxVgqTYtls9xgkJi8QEEXtQT/qm+kf/YoKf1dpet4p
	7HqR0hPOuHzVcyDw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH] genirq: Fix IRQ_MOVE_PENDING try set when
 CONFIG_GENERIC_PENDING_IRQ not set
In-Reply-To: <20240830100923.3818817-1-ruanjinjie@huawei.com>
References: <20240830100923.3818817-1-ruanjinjie@huawei.com>
Date: Mon, 02 Sep 2024 09:19:10 +0200
Message-ID: <87ttey7cb5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 30 2024 at 18:09, Jinjie Ruan wrote:
> The irqd_set_move_pending() and irq_copy_pending() appear in pairs, but
> irq_copy_pending() is empty when CONFIG_GENERIC_PENDING_IRQ is not set,
> irqd_set_move_pending always set IRQD_SETAFFINITY_PENDING flag.

Which will never happen if CONFIG_GENERIC_PENDING_IRQ is not set.

> And before commit 1fa46f1f0709 ("genirq: Simplify affinity related code"),
> if the config not set, IRQ_MOVE_PENDING will not try set and

# git grep IRQ_MOVE_PENDING
# 

> desc->pending_mask will not be copied no matter what. Fix it by combining
> them to align with them, and define empty for both if the config
> is not enabled.
>
> Fixes: 1fa46f1f0709 ("genirq: Simplify affinity related code")

What does this actually fix?

You fail to explain what the actual consequence and failure is. If your
change is not fixing anything then there is no reason for a fixes tag.

>  static inline void
> -irq_copy_pending(struct irq_desc *desc, const struct cpumask *mask)
> +irq_set_copy_pending(struct irq_data *data, const struct cpumask *mask)
>  {
> +	struct irq_desc *desc = irq_data_to_desc(data);
> +
> +	irqd_set_move_pending(data);
>  	cpumask_copy(desc->pending_mask, mask);
>  }

How is that different from the existing irq_set_affinity_pending() ?

> -#ifdef CONFIG_GENERIC_PENDING_IRQ
>  static inline int irq_set_affinity_pending(struct irq_data *data,
>  					   const struct cpumask *dest)
>  {
> -	struct irq_desc *desc = irq_data_to_desc(data);
> -
> -	irqd_set_move_pending(data);
> -	irq_copy_pending(desc, dest);
> +	irq_set_copy_pending(data, dest);
> +#ifdef CONFIG_GENERIC_PENDING_IRQ

No. We don't put the ifdefs into the function. That's horrible to read.

Thanks,

        tglx

