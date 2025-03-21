Return-Path: <linux-kernel+bounces-570853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD8AA6B544
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26560188F5FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB31EE7DF;
	Fri, 21 Mar 2025 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIGI0wFR"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE082AF1B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543053; cv=none; b=OgAj92I5w0+4p3BiogR9rqwQmMuwwjMYkCuHbA1cce7xhqc+vmurpf89rE0CLhoff/U30WpBrRR3oYWpAkT9rpK4lY2zxadnFJ+D20pMq6xdweMsZL/mvnis55dcVC65vAug+jcYEK8Gs8rNnVNrBe9j9uas5+a/leEtZhmUJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543053; c=relaxed/simple;
	bh=BbW5J7bJ0F/6xzUhLBXbzsRHMWimzxpvWyckCSBAybc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=frMGhfNqH5vsaCyPr4Du2C3UIDKMyQO7v8hha3BGzf1ExxAodP1GIz6gKaWCwgLOi3+Xpk9znaA8L5GzEhb9gHlQWLviNFdSosicDKY3X2HKbg3sf/LYXxP9wklY9S7iM9yexR0d5YQWFSUSdfi7SJ0WpMlA15OH8BXE8UDSXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jIGI0wFR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso17630405e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742543050; x=1743147850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmkFRH9GaUbe55qgjxHC/Rqmku15Hvr0oI20CNeu9iU=;
        b=jIGI0wFRsZ4+E2Bx11Q4eidwSbuQO5QWMRDDNxhRTfbNCdbnFGJ+A0aVS9ayUM677N
         +Zk0EAhfqcf+3dnECR7/EIJxrWcNiXcriYBDrRfqPZ7MGNUyyruOF/GfVhlVEkBJFvde
         ucCLrjj/+GiKvkEBgp7pp3nvINoSnSB+f0BkD+VdG46Z6xfsC8ey/8DcYwwrXq6EWRs7
         Y/v5iV+c4GxFtcF+I+nGgNeBK+6CRbUrRDzCOxmaKPAm/d2h6umVNfTNCqJetTrC6V6i
         7m3cV5N/4cnPQOcd25FG06NgSv6Yzc/w6ecTFMi/WbqbiW9lJi0rLTSn7xmnHutg0+3Y
         0Jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742543050; x=1743147850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmkFRH9GaUbe55qgjxHC/Rqmku15Hvr0oI20CNeu9iU=;
        b=jfQVqjWFKk4yizl9ja6iYAk1aDIrnt1hBPyvFjAj/0F9O3MihJqm9c9ca9CwZhJY8c
         TOXsNe0G6MKFKHeferIL/GrbXy3OCRKhjfBPTWJ3wjeWPZQ/Mn6yrZDiCHhQhqtRkZq6
         n4Zngoy5p3URyZnx69Xx5aWYhYIVRtYFckNdYxDYuHZz3j4QHqWrHR99Or2tbeUMujsk
         xH7GSuYb8y53lZjuO2eOqO7IPDVaDcyY4wxD9VR+Dd+OnisMsxDgDmtJh00WlgmymOBb
         gQHERKvleIkjiuZZ32V8L0Cy82N0aef5cGoFx6qZlbkM50a/f3U8aqM3LZLqZ96+3qFv
         ODcA==
X-Forwarded-Encrypted: i=1; AJvYcCVlh30bWRqaejbdEdQW468MwPkItCTWWb/RRLxlFZEfTzEEDZM4rV/3RzpoA1qHbeqYrdtoqtN2I5MEZ6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkplt7ffR/yjlRXoNJpL5r7tMMbxKTuTMRcJVPMhu6Q33LCkSs
	OMcuUXdkGbhyqx9R85t5yixpFhkmyw/iDMc0BsvW1DfnKYL2fWDd0oUjqzzPmNxAMQBU8JdrSjF
	bWl6rHUlwnRVK7Q==
X-Google-Smtp-Source: AGHT+IHusjLFbM5ugVtWBOs5d/FRmaSn72gmCX4kY3Tdaw8+WjbGKM+n4bBd7V+17bKoax+DIVEKZdNpfjdZGdw=
X-Received: from wmbgx13.prod.google.com ([2002:a05:600c:858d:b0:43d:8f:dd29])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4693:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-43d50a5237fmr14181765e9.31.1742543050715;
 Fri, 21 Mar 2025 00:44:10 -0700 (PDT)
Date: Fri, 21 Mar 2025 07:44:08 +0000
In-Reply-To: <D8LFRQ5IX33R.35U012LFZ06W0@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <D8LFRQ5IX33R.35U012LFZ06W0@proton.me>
Message-ID: <Z90YyLPhil2vBTc_@google.com>
Subject: Re: [PATCH 2/5] rust: alloc: add Vec::pop
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Mar 20, 2025 at 10:11:09PM +0000, Benno Lossin wrote:
> On Thu Mar 20, 2025 at 2:52 PM CET, Alice Ryhl wrote:
> > This introduces a basic method that our custom Vec is missing. I expect
> > that it will be used in many places, but at the time of writing, Rust
> > Binder has six calls to Vec::pop.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/alloc/kvec.rs | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index 95e752ed27395fce72d372976b74fb1b0e957194..9943358c70aa63f5ad7ed9782cb8879d7a80a8fb 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -302,6 +302,37 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> >          Ok(())
> >      }
> >  
> > +    /// Removes the last element from a vector and returns it, or `None` if it is empty.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v = KVec::new();
> > +    /// v.push(1, GFP_KERNEL)?;
> > +    /// v.push(2, GFP_KERNEL)?;
> > +    /// assert_eq!(&v, &[1, 2]);
> > +    ///
> > +    /// assert_eq!(v.pop(), Some(2));
> > +    /// assert_eq!(v.pop(), Some(1));
> > +    /// assert_eq!(v.pop(), None);
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn pop(&mut self) -> Option<T> {
> > +        let Some(len_sub_1) = self.len.checked_sub(1) else {
> > +            return None;
> > +        };
> 
> Isn't it possible to do:?
>     
>     let len_sub_1 = self.len.checked_sub(1)?;

Yes, good catch.

> > +
> > +        // INVARIANT: If the first `len` elements are valid, then the first `len-1` elements are
> 
> Please add spaces around `-`.

I can do that, but does it really read better?

> > +        // valid.
> > +        self.len = len_sub_1;
> > +
> > +        // INVARIANT: This invalidates a value in this vector's allocation, but the Vec invariants
> > +        // do not require it to be valid because `self.len <= len_sub_1`.
> 
> I don't think this should be an `INVARIANT` comment. Maybe we don't even
> need it.

I can drop the INVARIANT: prefix.

Alice

