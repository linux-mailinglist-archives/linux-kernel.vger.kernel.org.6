Return-Path: <linux-kernel+bounces-424563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254CF9DB5E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8550B2779F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2CE191F8E;
	Thu, 28 Nov 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4tOZDNQY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uR2GKpLq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C32152E0C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790604; cv=none; b=rmRgcd+7P0ZHlgAgCAjRaqTz1VesPi6EdEgKW12EAeXfrQsuGGW0OEwzUTNtxY5k3GFhhpc8dm4nYtU5FB1FNiAVd7qB+/O2PA71AputzFrufbq9+0ibn0BoJdE+WUroYAHc6LktelrBDYu1w9aTUzdw/0i5fuW8twmZuSim25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790604; c=relaxed/simple;
	bh=qjcHevnBsyvpSIkwPOO9YYHISNmClvc8uPjmaxIktE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B0fMWoBgGoiJ4Vv4v2euIceZ84EpDqWO7ObtThjtoGNZD9pCSShC3i3y6h1ejk6Xubqhrh5pzhm78czQEoQz48FHuW7TAFyCbI52HZAKNMgGfY4Z2YhsueUw32XqurctourENTlh3axFG1+H/O9Mr5o2jmacmyS94yXq7HIpWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4tOZDNQY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uR2GKpLq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732790601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCmQQl38KHm7OVYLjhjrypJsn1uxlFszVOYpGELlk8w=;
	b=4tOZDNQYKL0+NvxpccStVP+xZdeNpJQWALcz+eLwBE8q/HKPqmfO1vItUcZEVjsS3b7FnC
	SezSM2iPWaHhkAK3MH6I/rX++qP9Q9bg37VDOOvnf2iHEm5mQmnKgX8iJ4xoowq2s3HGhw
	G2OlulGMOon2xHAYp0m0GcP6s+6bCtic/XZ1iL/RdyNmfo0KKg4S04gWzp19ijGzATxX1Z
	gxKSrCqfMrO6lL/1hCNFDPF7uhjSNCZAQJJ0T+N1xxz/whh2eJw8+or0CNTrwoszVUWGyB
	AAvRxgEQemBuntahOZl9sB7QB3GmD+T8/G7LpAobv5P89d4/rG0jVQT6BQBaCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732790601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCmQQl38KHm7OVYLjhjrypJsn1uxlFszVOYpGELlk8w=;
	b=uR2GKpLqs0Qu7dVUcL5x5mdbnU24CUpxi/okbTdaQYsFjY/Eci0NPixDGyI35r4CFXBbty
	GSlxQ5S9OBoqqxBQ==
To: Eliav Farber <farbere@amazon.com>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, akpm@linux-foundation.org, bhe@redhat.com,
 farbere@amazon.com, hbathini@linux.ibm.com, adityag@linux.ibm.com,
 songshuaishuai@tinylab.org, takakura@valinux.co.jp,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Cc: jonnyc@amazon.com
Subject: Re: [PATCH v2] arm64: kexec: Check if IRQ is already masked before
 masking
In-Reply-To: <20241127152236.26122-1-farbere@amazon.com>
References: <20241127152236.26122-1-farbere@amazon.com>
Date: Thu, 28 Nov 2024 11:43:20 +0100
Message-ID: <87ldx3y6yf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 27 2024 at 15:22, Eliav Farber wrote:

As a related note. The subject line is not really matching what the
patch does. It want's to be split into a core change and one patch per
architecture.

> This patch replaces the direct invocation of the irq_mask() and

git grep 'This patch' Documentation/process/

> irq_disable() hooks with simplified code that leverages the
> irq_disable() kernel infrastructure. This higher-level function checks
> the interrupt's state to prevent redundant operations. Additionally, the
> IRQ_DISABLE_UNLAZY status flag is set to ensure that, for interrupt
> chips lacking an irq_disable callback, the disable operation is handled
> using the lazy approach.

Not that it matters much anymore, but the last sentence does not make
sense:

  Set the UNLAZY flag so disable is handled using the LAZY approach ...

Thanks,

        tglx

