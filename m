Return-Path: <linux-kernel+bounces-186016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980478CBEBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97541C2176A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5481AA2;
	Wed, 22 May 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FZj2R2su";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z/6PVAQR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1E81723
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371886; cv=none; b=Qm3eCNmRqnxW390WmV+6JXhDht74cR8To8X8iS3UD2cqtIXSXjJHN9iuVWhg93tMahx3eTe4GxJUf5CDPZJFad/WsingVTX8isBWi7Ji4O8JB2yCdKz2jCSlZe0czZzvkF6R6CunToI0gk4SYtmrk9ZVxRbNgppzhk5NhFq5rtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371886; c=relaxed/simple;
	bh=ai3Po91eHrHWSqQYU9MF/oxQql3OSFBpm9cVkudZZl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ir4bSoUmqrshBLRZBVeoQSeyzqQrbhPddAzkNpQC33unbHnNpinPP+A29QH5Rrn4bJSGz8yH3VA25ukBu2Lm7+vHwW3fZ8K51fA/4zgjCh/1INfvG3DG6gxdCkiFIqzbfXorsoV0QL4IucqW+bOdSS++OGNbV9kgOdt4tSYrnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FZj2R2su; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z/6PVAQR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716371882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYcRdQHtgu6q/Fcsceek8ZJ4kHucWNk9eR+lcvD6/aQ=;
	b=FZj2R2suUUtPyM0B99TxvrVdlo7cQRAGGWO94+CRzGrLjE908T/MsEZW+TuqxWGYYDVH4h
	cmn026cytUjKHWh8KH0oK1a2TVbgqAIwgRUDaLmA9NHB36SI8fUuopBiqhB3bnn56WH+Xl
	kIyCDK0NI2hV+5lMx1Zd33v4WiRKi4+PCPUpwIulO+gMkrHUmfW050royKQ3IOZ0+hweLq
	c8ewMuHzj/GxQTDKnWlH5Mg6476l1Xa9S68KAgSiYCMSqz1XL2MmszDnughuQObNitYuXZ
	/Jm+2UdNcyqFbErmcB5FDdIT2YyIQccXGXNfXJsYbtWq119m0BadUA/hrGh2CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716371882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYcRdQHtgu6q/Fcsceek8ZJ4kHucWNk9eR+lcvD6/aQ=;
	b=z/6PVAQRrIkLG++OVztMfV6dDelOY+v19rQl7GAOiupWX02TMje8txJyUrRPzOHXCWe1qr
	9KnAsw4MrJpXNUBA==
To: Wei Yang <richard.weiyang@gmail.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Wei Yang
 <richard.weiyang@gmail.com>, Vivek Goyal <vgoyal@in.ibm.com>, "Kirill A .
 Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar
 <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov
 <bp@suse.de>
Subject: Re: [PATCH] x86/head/64: level2_kernel_pgt's kernel area is built
 with _PAGE_PRESENT set
In-Reply-To: <20240323232621.10400-1-richard.weiyang@gmail.com>
References: <20240323232621.10400-1-richard.weiyang@gmail.com>
Date: Wed, 22 May 2024 11:58:01 +0200
Message-ID: <87jzjmgod2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 23 2024 at 23:26, Wei Yang wrote:
> The code is first introduced in 'commit 1ab60e0f72f7 ("[PATCH] x86-64:
> Relocatable Kernel Support")'.  Then 'commit c88d71508e36b
> ("x86/boot/64: Rewrite startup_64() in C")', convert it to c. And
> 'commit 2aa85f246c181 ("x86/boot/64: Make level2_kernel_pgt pages
> invalid outside kernel area")' limit the range from _text to _end.
>
> Originally, it does the check because the loop iterate the whole
> level2_kernel_pgt, while currently it just fixup the kernel area. This
> area is built with _PAGE_PRESENT set.

What's the actual problem you are trying to solve?

>  	/* fixup pages that are part of the kernel image */
>  	for (; i <= pmd_index((unsigned long)_end); i++)
> -		if (pmd[i] & _PAGE_PRESENT)
> -			pmd[i] += load_delta;
> +		pmd[i] += load_delta;

Fixing up non-present PMDs is a pointless exercise.

Thanks,

        tglx

