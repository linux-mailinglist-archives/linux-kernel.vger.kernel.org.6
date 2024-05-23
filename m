Return-Path: <linux-kernel+bounces-187960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD368CDB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A2A1C2130C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9405C84D1F;
	Thu, 23 May 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UdjsGFh0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YjLzd07d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D042823A6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716495532; cv=none; b=oIsvlUwKmUjjBCngWnTTx5PRj1Ixv7Yi6TjFUDilxrpRxXvH0txeUOMZ/Tfs8GXzl1y+dqiJNAYdMN5PtmqG1zwpwgpQNHMNa3FddlJPYGACuyLydo8tKZPkUHDxoXkYCqOQpo6DF25gVPGg8weRAsObSr4LT004ASdwjXW8/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716495532; c=relaxed/simple;
	bh=pFrk/e9ZenCkRGxBC5gy7aNXEiMaxXfw/iJ+zRd/V6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCChKmxwX6491AqPAFq0DDxmz6eSwKNAxJWvQnu/HrXBgD/nKdi0QLy5fo6TLsmUgIrVQGSXtgQVWvgvsHnodpjk1gR5j3+pWegyX5+5+rVAD9oT/EDkKrlTdt9CGc3Jo4No3jWrkHVYv4K3gBcx9don9nYN/RyEbs6eeokV3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UdjsGFh0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YjLzd07d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716495529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn0mBBuJ+t7z7OPDYUBM+zHO5zskNhmia64sN0syVIk=;
	b=UdjsGFh0WvjjAqbwMzZj5ZSmau2LzhFkQQWcjDjOQluRaZLbnfrimeEz0bNqiPyyBDgrqC
	JmDtek6NfJgfKPRg5W6D17MY+vikK+smn9cLVWd4ugXUBk9Z5AaLgyG/qytYzCtpOGmEMW
	8rFwOEPZxGsylimh/Yulo+29wB0iX/JKS900m/s24CwG9ZzAX+G0pzRa3X96WD9jiOAZlF
	NoGdolw1nLF5fYPn+lVqOpMyYU/+MTmOQSxAabBrzwc6F62Lp5qjy76qziOkd221G6hEaR
	CLf/1T5pSRfx6MZG8PgmvNHyEmQ/V4cTSkk51xbL1t817LzeX4c7zudvQzJHqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716495529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn0mBBuJ+t7z7OPDYUBM+zHO5zskNhmia64sN0syVIk=;
	b=YjLzd07d57EutgWQ1I3NC/drnwrHpZ26unJ31+HhLmjlupowo/vXDVtFk0QnApXJH7A+o3
	zz/gYcQJGDuI0CDw==
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/chip: Fix the warn for non-SMP system
In-Reply-To: <1715887825-1031-1-git-send-email-quic_mojha@quicinc.com>
References: <1715887825-1031-1-git-send-email-quic_mojha@quicinc.com>
Date: Thu, 23 May 2024 22:18:49 +0200
Message-ID: <877cfkffiu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 17 2024 at 01:00, Mukesh Ojha wrote:

We don't fix warnings. We fix the underlying problem.

> __irq_startup_managed() for !SMP system returns IRQ_STARTUP_NORMAL
> which may result in a WARNING during enablement of an irq i.e.,
> starting a irq while it is not activated.
>
> Fix this by appropriately returning IRQ_STARTUP_MANAGED.

What does that fix?

Absolutely nothing because both cases at the call site invoke
__irq_startup() which warns if the interrupt has not been activated yet.

It's not magically activated when __irq_startup_managed() returns
IRQ_STARTUP_MANAGED.

Also if you look at the SMP variant of that function then you might
notice that IRQ_STARTUP_MANAGED is not returned unconditionally. That
function can return IRQ_STARTUP_NORMAL too.

Just for the record. There are no managed interrupts on SMP=n. The code
which can initialize them is not even compiled in.

So I have no idea why you think that this has anything to do with
managed interrupts.

What's worse is that this does not even build on UP because
irq_do_set_affinity() does not exists for SMP=n. It builds today because
the IRQ_STARTUP_MANAGED case is optimized out by the compiler.

Sigh,

        tglx

