Return-Path: <linux-kernel+bounces-263500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB66593D6EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96522285D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90167144D0A;
	Fri, 26 Jul 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZm32btj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJOUNoAX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83094749C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011617; cv=none; b=a8hPVXzNxdPVDsDcloViuLnWKzKIES4sP7LC2V6AKX9zifPPwW5xf80H2qk9d5xuhTPP9DATywieSFspJ6kd1yd5s3TJfH9egdM2WBxd+0KoD+EziJYQqUZOkA/mnmkQkyUN8AvbdmXgOdmLZTYNFHHDKCdUjOt2TAttdvKoD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011617; c=relaxed/simple;
	bh=+l3vuAO+ko1nkR2CrpCXvrt+Xq+AVs1iznlLFcXUG9M=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cHn1up0yLm8YUjBfO8LRNOC4CPKmIWVO6hpDakMjYD7hAgyd24xhikefKm7wjKl4x8bGykSBfH9w1cdRkdRxTUJPyszlcAQ0S9sz9MV/M//vizI7QGaiQqkXFRlt2fmUrfaqZHpsT5YdBKmG5NUwfQfr79TvfR7xONfb6KpGZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zZm32btj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJOUNoAX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722011614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPcNP7zdaYU/U2/42w9x/gmPcV+CnVcJGQwm+XAMMoQ=;
	b=zZm32btjLQCGBAdJ2YiMQrFaCCg61IqaaHPuXSoJZUEkgEHw0vL567ljyMokKoQ/LH9ugE
	JF3yfCR7av0blEkIo/Oz1YgJCCcoLIQgqcIbbIcbYEm0DJMdiPiWROKoBek/0mlEtO32J1
	f6fjb1T050ppA/ZUQt3wdXbK9uLcaAHQnC3fdqv044iegairhl7T0aRM+KfvYekZRwvraq
	r5pWsDC2GjsqZSeY+7C4/XbkQ3Y/ATaNzWn+WWA2ElB63kfhtRSwJGkoryGiGUH/kBXUQW
	VJBHUJTm1iZRMcuh2bTCcNMYu0tYuPT+1oeO/dlzSkF1xnxoMQCPr+iHxWBtLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722011614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPcNP7zdaYU/U2/42w9x/gmPcV+CnVcJGQwm+XAMMoQ=;
	b=rJOUNoAXklk5Axf6Uj6kOFPx0WY1ObbfYYLAeTpFZpbiJ8sG4ry07zOD3v/lemFn0bPAGe
	cHIymrZypomYdfDw==
To: ChengChaoChun <abc21531050@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/interrupt.h: fix struct irqaction comment order
 inconsistency
In-Reply-To: <20240708160651.54239-1-abc21531050@gmail.com>
References: <20240708160651.54239-1-abc21531050@gmail.com>
Date: Fri, 26 Jul 2024 18:33:34 +0200
Message-ID: <87ikwsun8h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 09 2024 at 00:06, ChengChaoChun wrote:
>  /**
>   * struct irqaction - per interrupt action descriptor
> - * @handler:	interrupt handler function
> - * @name:	name of the device
> - * @dev_id:	cookie to identify the device
> - * @percpu_dev_id:	cookie to identify the device
> - * @next:	pointer to the next irqaction for shared interrupts
> - * @irq:	interrupt number
> - * @flags:	flags (see IRQF_* above)
> - * @thread_fn:	interrupt handler function for threaded interrupts
> - * @thread:	thread pointer for threaded interrupts
> - * @secondary:	pointer to secondary irqaction (force threading)
> - * @thread_flags:	flags related to @thread
> - * @thread_mask:	bitmask for keeping track of @thread activity
> - * @dir:	pointer to the proc/irq/NN/name entry
> + * @handler:    interrupt handler function

This changes tabs to spaces ....

> + * @dev_id:     cookie to identify the device
> + * @percpu_dev_id:      cookie to identify the device
> + * @next:       pointer to the next irqaction for shared interrupts
> + * @thread_fn:  interrupt handler function for threaded interrupts
> + * @thread:     thread pointer for threaded interrupts
> + * @secondary:  pointer to secondary irqaction (force threading)
> + * @irq:        interrupt number
> + * @flags:      flags (see IRQF_* above)
> + * @thread_flags:       flags related to @thread
> + * @thread_mask:        bitmask for keeping track of @thread activity

And while at it, please align all members in a tabular fashion.

Thanks,

        tglx

