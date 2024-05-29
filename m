Return-Path: <linux-kernel+bounces-193703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BAF8D30DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EC41F28D21
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F31B1836EC;
	Wed, 29 May 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKhHXVPz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p1hC7uKZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD731836CE
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970228; cv=none; b=mLGlmZBOmi9QPs7jgkdqbZzuLT79CaB/IpM5DqBNA97M16zdlQ9lx27gmG1xOHEdjODAITVHyMHlKoiFKYXHRnc/KMxFfIasiy9FmA2zBVM1QrOSz6nru6SoYJO4rh48CZ4tSxl0pj6Ygv7dpGX6etDBzkg/11Ynz6giIY/OiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970228; c=relaxed/simple;
	bh=ORwKTPj0UPvqpGh8tbpEI6Lrq77JupDAdqOdWps9Ctc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQonhf11rsN1UxQTAPn271AyIhAU9FJmZPHtGXesxbJ3ALK67A68HoR4FKIE//fmEClzbPiL5RWpNGoOlwrPGWCLjhufVQINIpIqA49jTQbFxBAMdAa7bjz1HQwSpOg1cAMCNJR5VqXCElC/yf2Adyxv4sYS+aZhtddaVeI3UTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKhHXVPz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p1hC7uKZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716970225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdrjeB8beYO9Wxg/8OYQKTmAoUwzpnO3hiZ79lAM5DQ=;
	b=ZKhHXVPzZG+UUfR54X+wnYa/b1rs5IXquutJvjwduFQecP7NfexftkGtIEw4qInTnAXSuV
	Xq1EfWyLi1dUmLGWitjvb2sBDF56jH1dJkAhQmix2tPZ10Btd5++2uWN5BNanaOmW36BQZ
	+7nAvd4tBwaEbUP60DQGuR/5QThnZcmxwi8YR5LCTAwbmNjjYUCHkeu6Kb+n4phmvOo/m9
	4ayaYI+yrsb/GGSIwAxbViO9hgu7Fwbje9KGTUXZirbz/RhD4o1uX8wLuidNUmpnzIitr5
	eiAyqH18ZBEqUwgQCFb9DVLf3on3myEkKPlOIm0WbOKu/tHSj2S0vNjuRVrAfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716970225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdrjeB8beYO9Wxg/8OYQKTmAoUwzpnO3hiZ79lAM5DQ=;
	b=p1hC7uKZtz9ziXLmLwZU1uwgeqFCvGJJ68rVPy/htD7MQd5WP73/G0wY0O+1+qIf2VtD3b
	8wL2rqD2SdtsZVBw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH] genirq/debugfs: Print irqdomain flags as human-readable
 strings
In-Reply-To: <20240528090917.3624463-1-ruanjinjie@huawei.com>
References: <20240528090917.3624463-1-ruanjinjie@huawei.com>
Date: Wed, 29 May 2024 10:10:25 +0200
Message-ID: <875xux9gy6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 28 2024 at 09:09, Jinjie Ruan wrote:
> This patch improves the readability of irqdomain debugging information in

git grep 'This patch' Documentation/process/

> debugfs by printing the flags field of domain files as human-readable
> strings instead of a raw bitmask, which aligned with the existing style
> used for irqchip flags in the irq debug files.
>  
> +struct irq_bit_descr {
> +	unsigned int	mask;
> +	char		*name;
> +};
> +
> +#define BIT_MASK_DESCR(m)	{ .mask = m, .name = #m }
> +
> +static inline void irq_debug_show_bits(struct seq_file *m, int ind,
> +				       unsigned int state,
> +				       const struct irq_bit_descr *sd, int size)
> +{
> +	int i;
> +
> +	for (i = 0; i < size; i++, sd++) {
> +		if (state & sd->mask)
> +			seq_printf(m, "%*s%s\n", ind + 12, "", sd->name);
> +	}
> +}

There is no point to inline this. Just keep it in debugfs.c and remove
the static.

Thanks,

        tglx

