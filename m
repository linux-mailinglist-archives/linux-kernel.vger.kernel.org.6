Return-Path: <linux-kernel+bounces-561028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C03BA60CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3AE3A90E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211661DD877;
	Fri, 14 Mar 2025 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m7Ok8/Zs"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101D1A2C06
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943054; cv=none; b=WoI2hbjxgxHZySD00E4bgGJNQ2ZGupCMFeAP/mK8y+23HZn0Px2pteZVgkROz++yCXhvQhAXoXZs4Qi9MG+JALvodZt6szuwmxOwxnLHTkR7QFZ9NNvGuUXYHPnnrJqZjTJ8VrP6sgN15bCnPOj98KtUkwLvTWdF9dz7MQD93/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943054; c=relaxed/simple;
	bh=KKMWbVYyFWu7ZUXpQokMSScMpsc3NzLjId8s4PaNsxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIIYmZSBX6MFQrPF8DAcEUVxREcLYFqR5YtpsMeQ3CV8B3QUGy+/XhBgN3XfPfT3apEvfxKzHZV2OXrNHqzvwxnO2pVqLLYj1o0PqIyzeFAT/wjwjjp0rLuvi6D/drPvykADKadp5Al+POECnsaM3n3DKqP1zudE/y09ATl13aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m7Ok8/Zs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h4ZI+8mmk43LoBz/MUUTTtjwLu4Cz6gytp4/uNJFbhQ=; b=m7Ok8/Zs6czLmcw/idlsz+MW9Z
	DRabhkKiAij/zJuq2ocv0si5iVz7TcNrgNmP1fq/2WcH+k/GDi4yoQU/XjZfoWQ1oKd2W+cyy1azf
	z+Le2A1TFbEO2+OgV0yCsxWvxC9MxU7TWVCOwtja8fd50X+qrxxcETPbSPrUpwPFe2NT5Wh4WpTRH
	ce5LqB8ep9PPTgqe7TRKAfgSBd0MdU/+0cj34or70icyj8TBhlU8PUeeKhqTkFJPwBNI7GmHWn+3n
	AkTnuXj0RHLhl/gr5zYCoD2kTnymRoLtQ7qwFY3fvnimftTJYkFSROKAM1XTiMAO5kzTn+/7Ks6wn
	wkEzIm9A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt0xe-00000002rqW-2toP;
	Fri, 14 Mar 2025 09:04:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A4C5E300599; Fri, 14 Mar 2025 10:04:09 +0100 (CET)
Date: Fri, 14 Mar 2025 10:04:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [patch 00/46] genirq: Cleanups and conversion to lock guards
Message-ID: <20250314090409.GV5880@noisy.programming.kicks-ass.net>
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313154615.860723120@linutronix.de>

On Thu, Mar 13, 2025 at 04:59:41PM +0100, Thomas Gleixner wrote:
> The generic interrupt core code has accumulated quite some inconsistencies
> over time and a common pattern in various API functions is:
> 
>     unsigned long flags;
>     struct irq_desc *desc = irq_get_desc_[bus]lock(irq, &flags, mode);
> 
>     if (!desc)
>        return -EINVAL;
>     ....
>     irq_put_desc_[bus]unlock(desc, flags);
> 
> That's awkward and requires gotos in failure paths.
> 
> This series provides conditional lock guards and converts the core code
> over to use those guards. Along with that it converts the other open coded
> lock/unlock pairs and fixes up coding and kernel doc formatting.  The
> conversions were partially done with Coccinelle where possible.

I see you've chosen for the scoped_guard() variant here, as opposed to
the scoped_cond_guard() one :-)

Anyway, cursory reading of the patches show no obvious weirdness.

>  include/linux/irq.h     |    2 
>  kernel/irq/autoprobe.c  |   26 -
>  kernel/irq/chip.c       |  640 ++++++++++----------------
>  kernel/irq/cpuhotplug.c |   10 
>  kernel/irq/debugfs.c    |    3 
>  kernel/irq/internals.h  |   47 -
>  kernel/irq/irqdesc.c    |  136 +----
>  kernel/irq/manage.c     | 1154 ++++++++++++++++++++----------------------------
>  kernel/irq/pm.c         |   38 -
>  kernel/irq/proc.c       |   65 --
>  kernel/irq/resend.c     |   50 --
>  kernel/irq/spurious.c   |  104 +---
>  12 files changed, 920 insertions(+), 1355 deletions(-)

Nice!

