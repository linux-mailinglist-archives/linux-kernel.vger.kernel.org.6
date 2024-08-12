Return-Path: <linux-kernel+bounces-283797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9E694F8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75641F21BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D918A6B0;
	Mon, 12 Aug 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wc/yb39E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4eHEfl5t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E348167DA8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497238; cv=none; b=DmqdzdJH5xQC7/tY8dH4RjHbYZw53TgYFPNdyFUkOsz0H9axbMJvJs+3l/Kx9ilvv7O0E7xMNAmfAfqHxv+CM560iDNk1Z6A5swtEtlheLW3xuskp4RoifbhsTcp7RttGN1jG1pXTajwlYaLztJ86qj272U9Hhjqn5R2Z3io/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497238; c=relaxed/simple;
	bh=ilSdkkQUZ3Dl9nQNkCZ7PGFUTCsom9slKzNUUqWSpXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7sJt1Ys37/zQEyAXdMkk12Z4CtCRbe/uZmLVvjxeZQDu7Q7iYcsgjB3dZPOdBL+UL7YHpYCHszoSvUIW8PcHnQfDhvqLMju5hI0Bq8lZT33nEpw4KWnaXOSoCp/HULC6dzGHLGxhfdE5HQ5FudJydLLZxLB08b0lRZZeNf6z3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wc/yb39E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4eHEfl5t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723497235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NeuZC/AEcA8D8HhnUkFw3ytoFkvPiPSOmUvzwUzhsTE=;
	b=wc/yb39EmWGMR1ZB4+Z0tZNe/N1pZ6X6IvYLKxL/bigvdlsKIwYH6fJNbDpZlN0ns49E3r
	WZKb1TBBAAc6eYEaBu/a5YA1ob4s5i/fqPfypjfC3/KRDxYGAD6yVgiYOg/lyvdPkIKi1F
	jauvhY6tLVXG2LcDIOLnntfM4IuZFD0tkuSh51RXzFCxWq+Gp06gyWPzM5dB4EenXOq/M8
	aUJ9FNGsHPJS07dpe0jBCODgyRV9eIfvATHHj2KkSE4nPv847pFFYL+Ay4ESoYWJ8pERcf
	wxEzTUoCquZ7DruFyYYHRg8GiFMaJXI1oBpxeyzZkaDwe+dV0yCizHJTWnicBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723497235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NeuZC/AEcA8D8HhnUkFw3ytoFkvPiPSOmUvzwUzhsTE=;
	b=4eHEfl5tvOJVNTxtqGe8Ml/b49ud21KXTfzh+r2BchKHsvvV8dMKHmsQNT6Q1XQJUUATmL
	d7teWs9bIfxE5hCw==
To: Max Ramanouski <max8rr8@gmail.com>, x86@kernel.org,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 linux-kernel@vger.kernel.org, jniethe@nvidia.com, jhubbard@nvidia.com,
 linux-mm@kvack.org
Cc: Max Ramanouski <max8rr8@gmail.com>
Subject: Re: [PATCH v2] x86/ioremap: Use is_ioremap_addr() in iounmap()
In-Reply-To: <20240812203538.82548-1-max8rr8@gmail.com>
References: <20240812203538.82548-1-max8rr8@gmail.com>
Date: Mon, 12 Aug 2024 23:13:54 +0200
Message-ID: <87y151qwa5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 12 2024 at 23:35, Max Ramanouski wrote:
> On systems that use HMM (most notably amdgpu driver) high_memory
> can jump over VMALLOC_START due to pages at the end of physical
> space being added with add_pages(), while gap for new pages left
> by KASLR is as small as 10TB. This results in early exit from
> iounmap() leading to leaking, and additional problems with rebinding
> devices to vfio_pci from other drivers with error of conflicting
> memtypes, as memtypes aren't freed in iounmap().
>
> Replace comparison against high_memory with is_ioremap_addr() to
> fix the issue and make x86 iounmap() implementation more similar
> to generic one, it also uses is_ioremap_addr() to validate pointer.
>
> Fixes: 41e94a851304 ("add devm_memremap_pages")

This fixes absolutely nothing as we discussed already. The underlying
problem is that high_memory can spill over into the VMALLOC area.

Seriously?

Thanks,

        tglx

