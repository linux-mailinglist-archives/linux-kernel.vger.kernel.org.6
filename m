Return-Path: <linux-kernel+bounces-174484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B018C8C0F68
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478F31F23105
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180D314B946;
	Thu,  9 May 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GP9L7GMI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TGYbKxUa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8C14AD1A;
	Thu,  9 May 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256866; cv=none; b=sxbwpRSPTNzNSbw2kfPtE8uGK0PmWwkHrv7Eddx6BCKVL6jtqnd2N5aR07S1/hJQ1XW4bTou9tD+aYRyAQ75YmeWfyQvwbnjAbbJQiTbIKTYRD6fLBR4xypn9BV02pQOpyJAAu4b+YVdg76Ssf7WQXxuUSp5Vks9aFwWMmjCAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256866; c=relaxed/simple;
	bh=N03P0gKUkMuybGCZFaql5yZdjIx87gfJbseTAmZcAxA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=JZvW638T6nP7Q1jZL90zJEUdaCtNqWGew4glJbotOPzdqZqZb6+kiBK/v/obmEFu9xojkaBbK+/AoQu58BRgpK26rkosw+TXB/Ol69j25yFP4I+vvMdmjQUKp7TXccm2AGWr6UPpLKQTGR5f5A92R4FZSBlg077lZQCX5o2x6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GP9L7GMI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TGYbKxUa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715256856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=s/L8Sw+C9CH9AHoAkPMdotLn7sOxVFfEx4oTON5PdOU=;
	b=GP9L7GMIRTXDY7VhR2x/RfuFQl194lccTl1bO6dLzJqQmwJZNlojEw5TsoyqYGLH7cw1dU
	mO20II4WZx0pQS76jsG1KQOkQMueml2xTrvPkZFvw5DSzvtsCEOCIu5dl4pYHXdzZChd+P
	A/CdVloEGFiVkvCIYxOab7yl1C6mqGfqTNrg830HegWXqci8WyS6WHZNp8fXexsh2cR3qh
	pwtRfDFaLWY+/aVu4fZ5w6GiuU+fDNLrUdi8vw9+Tb0tpgGk8hpZsoabO0++NVSeQVrIF/
	ShHxg66dPvTTsA9VUKRazZ86jpDEmUI3xmfuhW9MO74P8AisoqmCheXiX2uXoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715256856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=s/L8Sw+C9CH9AHoAkPMdotLn7sOxVFfEx4oTON5PdOU=;
	b=TGYbKxUaRYNlD6biJCoAwiR6babweEwIMvKiTSrMNVLxhFjBAVjfv1RQn64tbqLdKOPhi7
	407TJi0ICQhXBCCA==
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
In-Reply-To: <Zigj-lY5lnBSKuib@boqun-archlinux>
Date: Thu, 09 May 2024 14:14:16 +0200
Message-ID: <87cypvnpwn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 23 2024 at 14:11, Boqun Feng wrote:
> On Thu, Apr 11, 2024 at 04:08:01PM -0700, Boqun Feng wrote:
>> Currently since Rust code is compiled with "-Coverflow-checks=y", so a
>> normal substraction may be compiled as an overflow checking and panic
>> if overflow happens:
>> 
>>         subq    %rsi, %rdi
>>         jo      .LBB0_2
>>         movq    %rdi, %rax
>>         retq
>> .LBB0_2:
>>         pushq   %rax
>>         leaq    str.0(%rip), %rdi
>>         leaq    .L__unnamed_1(%rip), %rdx
>>         movl    $33, %esi
>>         callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(%rip)
>> 
>> although overflow detection is nice to have, however this makes
>> `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
>> clear that the overflow checking is helpful, since for example, the
>> current binder usage[1] doesn't have the checking.
>
> Ping. Thomas, John and Stepthen. Could you take a look at this, and the
> discussion between Miguel and me? The key question is the behavior when
> ktime_sub() hits a overflow, I think. Thanks!

In principle ktime_sub() should not overflow for regular use cases.

If the binder example overflows the substraction, then something is
seriously wrong. Though in that case as it's only for debug purposes
panicing would be totally counter productive. A warning might be
appropriate though.

Thanks,

        tglx



