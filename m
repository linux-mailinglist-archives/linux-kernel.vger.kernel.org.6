Return-Path: <linux-kernel+bounces-269621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB43B9434FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A600828BE24
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A051BD002;
	Wed, 31 Jul 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rWdtNCrl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LSK1MSB0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D31BDC8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446768; cv=none; b=FJra9doVHmQ40z/s2nSc8UkosBPZ6YBT621KI0POvJ05isu8933nFIOlM/az/gZKTjXqjQlrDm6mknjm1nDAvRhzbqmcwhaYDSe6Z8Q4Mj6FSsq+Wms6yBB8RJMpJYJnZm6oriUCwAcqkSlMk7cLIoWTevu/CSVMIiCSBWdy8OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446768; c=relaxed/simple;
	bh=dJutQ2kNW/h6uGjN606RHw3YEpSq1axEg1gboc4jVqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iRUjjJ+jfm1emb6vnVneXfHulIyKF0qC9+l8TnkLWWE5mvMWeQdHRVWwgZb/lo+IPx+3TwGLcY3MHxxnCcsaSKpSvkic9nSrDjvYNzgOCUWVoUIT+OrSngOeGC4FdfGIrGdK1suzQCCvAgmLk7wEuVGK2psTi6ncHYCbGRdTUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rWdtNCrl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LSK1MSB0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722446764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJutQ2kNW/h6uGjN606RHw3YEpSq1axEg1gboc4jVqw=;
	b=rWdtNCrlGo2+D+W2cnub2fQb/IpNNG1AfEnpLZqKyu59nCFoHP/oJsrvQbN0QTks73Ywz+
	GsFYy/k/yizlTM8LoFk4Dqgxjj+AVG2q36IFMNubjfntcb9G86VQO68VctlZ3AXnhgs8Ln
	z0Rk+JOzG8N3cciYvJMyKsAbtEDlaaegfj9/sN9Y3Q170k9geNMfYpRx8HQb6ds4CHiKin
	wFHrkGNp8KMREx1ymr65PtF23Co197KWFWPHkADgsmoF8kaRdAvMtFwFVGGMDRcPYkWBN7
	b3Zp4YUzftAdYTHLSKCh+MeHkb5JcIu54JiDvslaN1O9gSubtoBKTuLOyggX7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722446764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJutQ2kNW/h6uGjN606RHw3YEpSq1axEg1gboc4jVqw=;
	b=LSK1MSB05F/QSaA9VMz02YuMq8Ek/iGZzchL4pszoOv8j/iETcRZ0zjvWse8GJiBHTXa52
	FMeO4CIuHKeBmzAw==
To: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>, Andy
 Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Anvin
 <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
In-Reply-To: <20240731165108.GH33588@noisy.programming.kicks-ass.net>
References: <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
 <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <20240731163105.GG33588@noisy.programming.kicks-ass.net>
 <20240731165108.GH33588@noisy.programming.kicks-ass.net>
Date: Wed, 31 Jul 2024 19:26:04 +0200
Message-ID: <87bk2d5v83.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31 2024 at 18:51, Peter Zijlstra wrote:
> On Wed, Jul 31, 2024 at 06:31:05PM +0200, Peter Zijlstra wrote:
> Thomas, this all still relies on the full text section being PMD mapped,
> and since we don't have ALIGN_ENTRY_TEXT_END and _etext has PAGE_SIZE
> alignment, can't have a PAGE mapped tail which then doesn't get cloned?
>
> Do we want to make pto_clone_entry_text() use PTI_LEVEL_KERNEL_IMAGE
> such that it will clone whatever it has?

Yes, I think so.

