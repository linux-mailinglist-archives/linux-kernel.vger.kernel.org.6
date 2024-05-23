Return-Path: <linux-kernel+bounces-187941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94938CDB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EEF1C21DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6484A3F;
	Thu, 23 May 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BP4BAo/B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KIpZqn5t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5E156E4
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493600; cv=none; b=pWO468GjaizW4Jf4EZLL3SSPfKhoDdFvRf6P+2XL95dakHJiKNKRh6C8FichpxQKl1aKWNuFgsQXTRvVxX4tz8GPlFqI39s0MOAN3lvYu8Msm21ha3l0jreBGBN/NyvQYC8xr78W6vuKQqlqTHfEiU+ofrKbk4x3U0mnd5x8YNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493600; c=relaxed/simple;
	bh=5zKe1tosn+En0xcnx35KM6LvuL/99qWEMzzDoUejKVM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=PaBqDW8SzNiHKG+S9FcDEqh6J3Y/MsPCTS+DIVT34fs1+ftwvb9qCensOnvw3qul5Ufvbm57jpmu9PyWanFckd50eyENU2uSlyKKGWAPtiEavy5mPe6yk0UNlv51ixGInWFX4USVeJs6O1bdaFXLUx4lRrd0mwqYFw5qFe+bzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BP4BAo/B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KIpZqn5t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716493597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=uosf8zJX/OrVrpzgWdisB0fvzDFsKDb8UYB9Oox95ds=;
	b=BP4BAo/B69jc8ERVWFG98sNHLN1mENEzNZNBioaIc8i+Z2nQvyDhWBpGZ7Q8bSagQvkp0r
	Qkoi9ly8VwbHcND/epo5p1JbpdIcYEl8tlsHT3u4xHypR3RHOL7tG0w8bz2Hs1dJWWmU4f
	9xsJRC4V8XwLgNg3s+4rrrW0j57j58gUKlsP0mm4TFoC4IEnh+vHVVLtKkBKChvC4BS5PP
	x3QInGMT3WmYjyr3TGr2x/BzBXD64Poz1/wfVeDDy//JS+wnJmjvWB0xYZfjR1BtJyVed4
	Cr4QI2aVIO72pN618+SVkrXSP15TSfdaEaa+FZckgMIw022PRgqfwsae1NffWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716493597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=uosf8zJX/OrVrpzgWdisB0fvzDFsKDb8UYB9Oox95ds=;
	b=KIpZqn5taXmZz3LONsNtK4wwCWpj93R/8rFGP6l7jO5arnhLumMZWFiopXw87IZFZtKX1z
	eYmvNXSkHlMUZVDA==
To: "dicken.ding" <dicken.ding@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Cc: wsd_upstream@mediatek.com, hanks.chen@mediatek.com,
 ivan.tseng@mediatek.com, cheng-jui.wang@mediatek.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, "dicken.ding"
 <dicken.ding@mediatek.com>
Subject: Re: [PATCH 1/1] irq: Fix uaf issue in irq_find_at_or_after
In-Reply-To: <20240523113949.10444-1-dicken.ding@mediatek.com>
Date: Thu, 23 May 2024 21:46:36 +0200
Message-ID: <87cypcfh0j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 23 2024 at 19:39, dicken.ding wrote:
> The function "irq_find_at_or_after" is at the risk of use-after-free
> due to the race condition between the functions "delayer_free_desc"
> and "irq_desc_get_irq". The function "delayer_free_desc" could be
> called between "mt_find" and "irq_desc_get_irq" due to the absence
> of any locks to ensure atomic operations on the "irq_desc" structure.
>
> In this patch, we introduce a pair of locks, namely "rcu_read_lock"
> and "rcu_read_unlock" to prevent the occurrence of use-after-free in
> "irq_find_at_or_after".

Please read Documentation/process/maintainers-tip.rst and the general
documentation how changelogs should be written.

Something like this:

  irq_find_at_or_after() dereferences the interrupt descriptor which is
  returned by mt_find() while neither holding sparse_irq_lock nor RCU
  read lock, which means the descriptor can be freed between mt_find()
  and the dereference.

  Guard the access with a RCU read lock section.

Hmm?

> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -160,9 +160,15 @@ static int irq_find_free_area(unsigned int from, unsigned int cnt)
>  static unsigned int irq_find_at_or_after(unsigned int offset)
>  {
>  	unsigned long index = offset;
> +	unsigned int irq = nr_irqs;
> +
> +	rcu_read_lock();
>  	struct irq_desc *desc = mt_find(&sparse_irqs, &index, nr_irqs);
> +	if (desc)
> +		irq = irq_desc_get_irq(desc);
> +	rcu_read_unlock();
>  
> -	return desc ? irq_desc_get_irq(desc) : nr_irqs;
> +	return irq;

I wrote guard above because that's what should be used for this:

  	unsigned long index = offset;
  	struct irq_desc *desc;

        guard(rcu)();
        desc = mt_find(&sparse_irqs, &index, nr_irqs);
	return desc ? irq_desc_get_irq(desc) : nr_irqs;

Thanks,

        tglx

