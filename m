Return-Path: <linux-kernel+bounces-201255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C1D8FBBE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC42B2632A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3A14A4CC;
	Tue,  4 Jun 2024 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hg/2FuEQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AE2VjrNe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF34A11
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527070; cv=none; b=cPUsUYpL7cwk3CwBKmnqqEwCvuFGv48sy5lAB7FV1qtymcATT2k0ywtuwX8FIRg4NwXBL4R1sDj5GDxCscnKp+AqfrFFKzp0YjAtiPL6K2/yIz2nH6cVjjxWjJ7WhNSm2BNTByqcHSihb/kcfbxHnyhDyFz25MMtm+COgMS5KHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527070; c=relaxed/simple;
	bh=5VeXengSZeM+UAXHhPFpc5ktDmMspwy2C37spZviMN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ik9DQZsI58RB0P8eOGZLNY0ATj1R54MekZ/zXDKZ4zdr2pCdt8NI+7tW3v64Wi4lxomjUVcRMM/6rlfHH3Xw5h0Km+1RC1qhj0+aPgwIuWM6c/mxqNcBWqD998QRaKluudg9caWHbyyW+lfwX3ZnEdj3DzULYhqchXZ5Buyo6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hg/2FuEQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AE2VjrNe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717527067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAhm0Ey841jUH4UQhrQFf67p0ofqwc+3nGUlsBTWj8Y=;
	b=hg/2FuEQu92Uft/JGl95bRGLjUmiSm05GdL6lOImxx2UjtUePL5cVepZbgpWcNNcSlH5pJ
	i4x2nFKU4hBRlBM2xiJWLZvr52jbDUE8W4GaWoyMJ6eyAYppg6o9BJIC+obYVrqNPbCDsI
	ikFmCrOTYir52zfn00S2gcaGAbSpzs9azcm9QppfZpCE3oyl+9qZkgofr9L0HJI+IO61H3
	V16v18VgItN2D0CnSwqKQWh2iBjt2UqQLv6zb/1u2mna8VZ7Eh5tmP7TQbOqZMWpjkeYdA
	UrH87d2TimR4zvnjSPH6BYO6+JQD2ht6CnUy/in/K7OiFHXrB5Th8l0944YqSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717527067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAhm0Ey841jUH4UQhrQFf67p0ofqwc+3nGUlsBTWj8Y=;
	b=AE2VjrNecXKSy70inwKmAB5JLlKoXWV8p4Dr0oVFF4bxZIK3LZcxb4vLe4VCniaSJfR3j1
	sg01t8F6syn0DxDQ==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] linux/interrupt.h: allow "guard" notation to disable
 and reenable IRQ
In-Reply-To: <ZljAV6HjkPSEhWSw@google.com>
References: <ZljAV6HjkPSEhWSw@google.com>
Date: Tue, 04 Jun 2024 20:51:06 +0200
Message-ID: <87ed9c5yp1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 30 2024 at 11:07, Dmitry Torokhov wrote:
> Drivers often need to first disable an interrupt, carry out some
> action, and then reenable the interrupt. Introduce support for the
> "guard" notation for this so that the following is possible:
>
> 	...
>
> 	scoped_cond_guard(mutex_intr, return -EINTR, &data->sysfs_mutex) {
> 		guard(disable_irq)(&client->irq);
>
> 		error = elan_acquire_baseline(data);
> 		if (error)
> 			return error;
> 	}
>
> 	...
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I assume you want to carry this through the input tree, so you can
modify the drivers.

If so:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


