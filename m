Return-Path: <linux-kernel+bounces-269898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB4943839
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23A01F21704
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A824116C68D;
	Wed, 31 Jul 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UISq3fvJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gSGJ2/MJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0915FD15
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462458; cv=none; b=F9S6/2VlgJK0yi4w3QcuTRM9oiaObyapIYXdR922yur/XrOWlFpYw5i8Sn+URd/KOccWIlwbzF2kjckkflG7mbQDvZcqA0DZVLHEfNuf3lRDgo7jCuMnL2uPwVGTywkalSCecqbolKr0Awh6UOQnCEasVJfV1v4DhnjgVmoonYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462458; c=relaxed/simple;
	bh=WTfJDyIHdjpdh/1FJdf11JhrNG82ktnY3L640+HLdbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4YvQ642aeA3jfishtLj872fc4V9Xk/sZ2Un3oYpMqZZ4IKYs273Q025dkGfg+cYPccQyv1dphN+DXU6BuWBOKK+pxiKA3/a99OqEogCfSCy8EFrkJEatYPxXy2fDDENp+rXCl4sjtqTeFAjpEYVayCAPPrZWuvKaqpzz/HzDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UISq3fvJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gSGJ2/MJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722462454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Kx/dDVdE7n0xHVF6NmMI/MDLy57D1/3ZpnGl3/UrP0=;
	b=UISq3fvJElYAX502Wf/Yhbkec2MgGbuxLllPFAHVPzuht2qO/7b4nKwPEWfyEe4zeBw2Al
	0syU1u66zeU5Reqod1iN4HkGtkZ/6Zao25CPApTKTqyTdklkBJB5GsQjf1xjEqk+23hXoa
	q0wNB79oZZ0INwKUNLRXgQTSBmp1llpO/jvS0rAe8NEatBtrs4qKGlzUQYH0XDkV/G5UVF
	XhdhD0DzqH0ZOdq4+h7qle7GG1sPygHUpjHQ028oUtiJr/zSdhAYQ2aRGiu1FPZUPuG5ir
	uzFzOc0vAQshvC71RtdrxVC/Iah+tQJJIAHyfsSNYcC0Bu1kKx8juw/X4TlFlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722462454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Kx/dDVdE7n0xHVF6NmMI/MDLy57D1/3ZpnGl3/UrP0=;
	b=gSGJ2/MJajEPDHtTL2a8N8RG/inRWEGVVv2duSae2Jm8YvAtxCSkCUOq3h0PHbpOlm9/hJ
	zv3xVngF04zr71Aw==
To: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>, Andy
 Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Anvin
 <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
In-Reply-To: <CAHk-=whB1Y6xpfuJ4oT3==Z=gxLirrXxZcSX4HLOfiozi_BmDw@mail.gmail.com>
References: <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
 <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <20240731163105.GG33588@noisy.programming.kicks-ass.net>
 <20240731165108.GH33588@noisy.programming.kicks-ass.net>
 <87bk2d5v83.ffs@tglx>
 <20240731212007.GW26599@noisy.programming.kicks-ass.net>
 <CAHk-=wjSs62k3p7sS3uR7TSTsZg1q8-=Vm0douhodk2R0FqP=Q@mail.gmail.com>
 <20240731212624.GZ40213@noisy.programming.kicks-ass.net>
 <CAHk-=whB1Y6xpfuJ4oT3==Z=gxLirrXxZcSX4HLOfiozi_BmDw@mail.gmail.com>
Date: Wed, 31 Jul 2024 23:47:34 +0200
Message-ID: <87mslx44jt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31 2024 at 14:41, Linus Torvalds wrote:
> On Wed, 31 Jul 2024 at 14:26, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> x86_64 has everything PMD aligned. It *should* never encounter a PTE.
>
> Ahh. I thought it only aligned the beginning, but yeah, I see that
> ALIGN_ENTRY_TEXT_END is also PMD_SIZE aligned.
>
> That smells of wasted memory, but I guess the TLB advantage is worth it.

It definitely is.

Thanks,

        tglx

