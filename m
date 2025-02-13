Return-Path: <linux-kernel+bounces-513951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78560A35091
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3753A4C68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59E266B56;
	Thu, 13 Feb 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+PYSzfA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jarwlFB8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CC1487FA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482747; cv=none; b=R/oq4JCnY1CP44sF4UJ9blIcNLAPaAF84I6ChvYHzWgF1pGAoCKLmiUe0v/EgKTU98+OMK0S7EV8p9f5CAsF50gxS4gaPblRTVgCoFkwcTFdVirkd6yPJ2cJ2j60ToF8rxJG1tTo3uK8mlr3IbcZRfyW0J+5m4/e8JbM28ztDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482747; c=relaxed/simple;
	bh=h8gsnHUDTaalUikdwyXK5AuEjpJ4CdIAKQApKatXWz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVEDsxu7arAwNLaKwRJaj/an8mXtnueuCT3dyyTsF7UYd52r0ngiPNqnwZFt7Xlt/cSgErNxJHY0WNNL0ARjyDwNi0pOK/JikWOdUfkh26nJ9XuSU1kdmfhjK6osMcEg8mx0BNWEIfqrbGPZuie13uw7jUa6u9H3SqTfQNw8yYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+PYSzfA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jarwlFB8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739482743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yo4eFArIgov3x4sA3IQBHUqmHimcug5HUp2DC9+LcEU=;
	b=f+PYSzfAXLKiarsgf2HCEvEJmHsgaTbYC9m3hZgu6puYZm3so4GooOX0VFsH2ZjvVQuXQJ
	xyvjIeuxT/H9lBPPnc2+VLyG9eJrGX+aV4zvvXm8XPtVeZz3wCGYlK3hhO95bMVo9ctVxv
	GSMVlg/BveVbevmhEjYKYPaDwe/KbBNKu0hsWcIkkx+ox1Q47YCsvIeoPn8m3nLb8lHBWz
	JrpKQ6zXUxwDGJqozz5DoB0xCEKPGNLnCbRzsIRm3fKwHUIHc4A104ts94j5MGyRkHHLsy
	ZoVJzV1jVISHD9xpyZBx3Q4oNiNwFWhuA3EGxmXZvxoyRt3tVeP2EbAL2tfFMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739482743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yo4eFArIgov3x4sA3IQBHUqmHimcug5HUp2DC9+LcEU=;
	b=jarwlFB8K06T/bSG3WaGfZ2lQYxzwEbrwCTYsfu1KtaWITaU8sAXRLoeWO35AtL5n1KMZR
	n+QyFcLxmaINV2Bw==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [rfc, PATCH v1 1/1] hrtimers: Refactor
 hrtimer_clock_to_base_table initialisation
In-Reply-To: <20250210082907.4059064-1-andriy.shevchenko@linux.intel.com>
References: <20250210082907.4059064-1-andriy.shevchenko@linux.intel.com>
Date: Thu, 13 Feb 2025 22:39:03 +0100
Message-ID: <87pljljzig.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 10 2025 at 10:26, Andy Shevchenko wrote:
> Clang complains about overlapped initialisers in the
> hrtimer_clock_to_base_table definition. With `make W=1` and
> CONFIG_WERROR=y (which is default nowadays) this breaks
> the build:
>
>   CC      kernel/time/hrtimer.o
> kernel/time/hrtimer.c:124:21: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
>   124 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
>
> kernel/time/hrtimer.c:122:27: note: previous initialization is here
>   122 |         [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
>
> (and similar for CLOCK_MONOTONIC, CLOCK_BOOTTIME, and CLOCK_TAI).
>
> Refactor hrtimer_clock_to_base_table initialisation to make
> the compiler happy.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> TBH, I don't like much this solution as it diminishes the point of that
> override to be there in the first place. I haven't found better alternatives
> as they may be too intrusive. Another one might be to remove this table,
> but in such case the replacement might add latency to some cases (although
> I haven't checked the generated code for, for example, switch-case approach).

The only place this table is used is in __hrtimer_init(), which is not a
hot-path. The four resulting comparisons are probably not even noticable.

Thanks,

        tglx

