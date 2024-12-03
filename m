Return-Path: <linux-kernel+bounces-429310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1E9E1C25
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A16EB2B779
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11661E376C;
	Tue,  3 Dec 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GPh9J544";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ug89W9+H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE91E04BB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223874; cv=none; b=UwOncP85S4Lo4aYYgfer2TS6tu0nK+5LQhY3fDLrsy0u/BBJqpJ3yrAZ43MnHZvDA7sNXm6KajHc0g0hKqMTyZsylJdGXCt32XsdXP9lykVaQaqaI/7vcdA2kOSA0J9Hj8n54RLt9EtgZ73FBDBBYDJU3HmA0VUkgNziCbsH+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223874; c=relaxed/simple;
	bh=yqAH9+b+eG1f1jUcSYfScj7x7FqgR3nco6bVYgj7mkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mwWiZKe5c0dpJhR5u2qa1TSV6c1zxlEpbVcDOjcbdTf3zL8JnYnaZDaVKyvJDmjsf3oZRjiP1p96H+6K06ZwGQ1yBpcOdkn4gpZE4Durf7mE4jCliT+hCB8YzzbQLaA2LbMxXzARfKH+WSz0GLQ1qnVrEnUTKZdXPC5Iwvd+v8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GPh9J544; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ug89W9+H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733223871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4yYjvF6qVvKzBxYttP8yiTPmOTcqD+VbUaWnU4lSefY=;
	b=GPh9J544GLpTTHxYmRPEOJGjgakTV87tvrpcFyzmjVfjTgmMlFaRBphYMzd68uKaM8UHBT
	/8y3ljPi3RMyCAjmib5czRfFtbslBOfcQND2YjCJ8guUjde0/0fHf5JU0GcGoDvWKmVKos
	HiPzu22BALCLVBnaXHNu8cUp4DGwd7LIi9olPiCZrjtyqBFwzlv3TOFKdEgE0vPjIgrxeW
	ZMzcUJGih0YwQZOopROfUFc48azjD7w7ql/w92e2WkbH/K3DxcmBxvGHWgWwsBmzo6u3Vk
	DP0ZtECGev+ymNGFFRj6jQyH2c2+D9uAlTvm0tEGHpf861Nip5oHzES5aNejpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733223871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4yYjvF6qVvKzBxYttP8yiTPmOTcqD+VbUaWnU4lSefY=;
	b=Ug89W9+H4bPUfmR6EL/qwLR3mPtemvy0s7sj/ASkjTx+PzWZ1v4vgS42y6KLbbJDWnoOWj
	Q/JVO9P0HhGoXGBg==
To: Eliav Farber <farbere@amazon.com>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, akpm@linux-foundation.org, bhe@redhat.com,
 farbere@amazon.com, hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
 adityag@linux.ibm.com, songshuaishuai@tinylab.org, takakura@valinux.co.jp,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Cc: jonnyc@amazon.com
Subject: Re: [PATCH v5 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
In-Reply-To: <20241130201143.48808-2-farbere@amazon.com>
References: <20241130201143.48808-1-farbere@amazon.com>
 <20241130201143.48808-2-farbere@amazon.com>
Date: Tue, 03 Dec 2024 12:04:30 +0100
Message-ID: <87wmght4ch.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 30 2024 at 20:11, Eliav Farber wrote:
> +
> +config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
> +	bool "Clear forwarded VM interrupts during kexec"

This should not be user selectable. Just keep it as:

config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
	bool

which defaults to 'n'. Just add a comment what this is about like it's
done with the other options in that file which are only selectable.

Thanks,

        tglx

