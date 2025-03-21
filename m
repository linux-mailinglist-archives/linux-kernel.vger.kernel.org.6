Return-Path: <linux-kernel+bounces-570864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1507A6B58C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41142481EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0145E1EDA35;
	Fri, 21 Mar 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJLLqnCF"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111F15820C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543691; cv=none; b=fJVhKP8o8Zn7m7HEp1bcJNKSZC2csjlas1Hf5yWQ9XSOKyQcLUU3ogk+T4iBWBu7REQdhfWuxszwTVv9ASzlJu23ilw02Js7D0J5D5ulwHd83VV9HC2K/DLqq9Xnisy7htPiaeznslTl/CcVRqeTSBrkLZzSNLF4ZuwV2JGb4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543691; c=relaxed/simple;
	bh=IfxtfZC/DSyx9qgxArTfZTkcfTHSCvHiZx5BHh8a9Gg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jis1x0l04ZPECWhuXCVSjYTZewbjPjYZOZbi4kuFi84GclIWanSDd01tliy/ovKQQhUwl/TgXEl+O5dRVvfyKxaIauvhjjOxiILYPxs+UuzrOYY8y9Ly6OqCZ/zEqOyUAVolk9bxNBhyapWWM2dnyNYEsq5LsNmdU76HrPONeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJLLqnCF; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39131f2bbe5so736298f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742543688; x=1743148488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+KRRdQFV3JbNEfysN8wjnaqcelmmd73dgVDwOPrsCM=;
        b=hJLLqnCFQ0T7iYYfJIesJMqlJqLI5CPluZy+xO+SEdCUx2/dV6W693ZQ50gS22zNav
         XnszD93N2sjZq+2WwCYzXCS3bkzfDEp+3V2Fb02+ne7iVkMWtbsfvunpACSUhSFwpDs8
         +5RWA51uUKVthSIsI0Vf8bv7g9WokQSApyQpTnSssbVoKpJSMQyyVM54TJFVUJh3idby
         SrSw7U/qxwvNYxJ8cO3HgxnOovIxoClz5bXz2MN+zaG6s5J40DkCNIoV0Sd2tvjMoTXo
         gNBQncTvG+h1KzCIqziwdp+NKnJPo9e/FBLFIHhFyCVStHtsXBz8l3M75I0yPdkXD+r6
         fzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742543688; x=1743148488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+KRRdQFV3JbNEfysN8wjnaqcelmmd73dgVDwOPrsCM=;
        b=IXlnIPw7ZpWmJ6pNQZDNb7/rktyEKFiflzY9fHcoPlYQ4GyoUHObKnlHs9OpnECyEC
         U9y4Q4Ap7zpa3ZLGI7Fy8avIUma8JlOcN0rezlf6OqBkUHq6ZXvaIG3qZRVsHA2HNV3V
         qWCieykiJUjpDcVDAPLKSy0O1u+LAd99vcsPpoIwzKuM3rbsPBBSD76oioBolCXRbyTF
         RpiO6O/ns8EsKH6t4w+V0m2tzx8dJSQ6s/SmW7D5ewfK6z5mjjGTVaAhOki3erN8+XyB
         VXWz5iL22C8w9rTLthG43tx6HeLhHf6jpoiv7Fcz8yvAkqwtGhg/t7w0mSubA/vBJc6n
         Ivbw==
X-Forwarded-Encrypted: i=1; AJvYcCWTwuZQZ8+1BpTTMZt5khfVIciiimv9e05s5rV/IqSjeYVgY8R6DBm883HParzkrmn0g2psXWy7nWseiAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjznfwA0VpuZ4jdBRiWWNldxcG0ky+RVtGg3qVYoeilbaq3Mx3
	slgdyXjrXNis5qWNvE6FeImCjig5D+Wv6Q7ukPrVk+eeVbReJOllyaOrh0U6lsNvH6FdEaQYmUC
	qmenX3mX1xD0+Pg==
X-Google-Smtp-Source: AGHT+IF/QwGTIDerBJ0F5n+udFZJ9M7eyBqfA3cx4U4QzPC2ePLBun9xUCeB/wsQ1CbCiUSMBc51JPPdWHb4Lfc=
X-Received: from wmbbd27.prod.google.com ([2002:a05:600c:1f1b:b0:43d:4055:98e3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64ab:0:b0:391:487f:27e4 with SMTP id ffacd0b85a97d-3997f90d377mr2419066f8f.27.1742543688246;
 Fri, 21 Mar 2025 00:54:48 -0700 (PDT)
Date: Fri, 21 Mar 2025 07:54:46 +0000
In-Reply-To: <D8LFO0LQOPQJ.30AC77E0BOH3@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <D8LFO0LQOPQJ.30AC77E0BOH3@proton.me>
Message-ID: <Z90bRpdK7qZio80g@google.com>
Subject: Re: [PATCH 4/5] rust: alloc: add Vec::drain_all
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Mar 20, 2025 at 10:06:18PM +0000, Benno Lossin wrote:
> On Thu Mar 20, 2025 at 2:52 PM CET, Alice Ryhl wrote:
> > This is like the stdlib method drain, except that it's hard-coded to use
> > the entire vector's range. Rust Binder uses it in the range allocator to
> > take ownership of everything in a vector in a case where reusing the
> > vector is desirable.
> 
> Is the reason for not implementing `drain` complexity?

Yes.

> > Implementing `DrainAll` in terms of `slice::IterMut` lets us reuse some
> > nice optimizations in core for the case where T is a ZST.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> The code is good, but I'd like to know the answer to the above question
> before giving my RB.
> 
> > ---
> >  rust/kernel/alloc/kvec.rs | 57 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index df930ff0d0b85b8b03c9b7932a2b31dfb62612ed..303198509885f5e24b74da5a92382b518de3e1c0 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -564,6 +564,30 @@ pub fn truncate(&mut self, len: usize) {
> >          //   len, therefore we have exclusive access to [`new_len`, `old_len`)
> >          unsafe { ptr::drop_in_place(ptr) };
> >      }
> > +
> > +    /// Takes ownership of all items in this vector without consuming the allocation.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v = kernel::kvec![0, 1, 2, 3]?;
> > +    ///
> > +    /// for (i, j) in v.drain_all().enumerate() {
> > +    ///     assert_eq!(i, j);
> > +    /// }
> > +    ///
> > +    /// assert!(v.capacity() >= 4);
> > +    /// ```
> > +    pub fn drain_all(&mut self) -> DrainAll<'_, T> {
> > +        let len = self.len();
> > +        // INVARIANT: The first 0 elements are valid.
> > +        self.len = 0;
> 
> Why not `set_len`?

I can use set_len.

Alice

