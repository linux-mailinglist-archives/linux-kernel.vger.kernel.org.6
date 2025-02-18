Return-Path: <linux-kernel+bounces-519700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E1FA3A0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5271892BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6A26B2A9;
	Tue, 18 Feb 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0SyCJUD"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23134269AF4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891466; cv=none; b=oPQbwjENIY74GM9Jx5zeab2eXP5iW4je+haY4SFth/+o1pBUQzrRji0siegedrA2CkC/TX2aJM83rczYvZzYqGw20/BbPzWt+3WOAldBhF3KXihPxidpPjk00Oya7u1S+0f1kLQxIHQbtJr4VX6y36VO1BnoVCPKqqi39kHXNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891466; c=relaxed/simple;
	bh=88FsyI5JnCmURjrJRtmdJlv7tK97eylnGJVKIrbdaHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsHpjorwc2kJRmG5MxdPyTaSD7Hz+wrADhjzGBtz7AznAtzi3za/ImSYWtpYkM500ieHu23mtajFC9HC3TeUtRw+okWFOjGwnekVQWMG/S0pSgH+ThMBfRsOXz9HJkOxwH5Pa3/fVTEQpVX2Sm0kedldQ0FCDwm80oImc62GFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0SyCJUD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a59so58688011fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739891463; x=1740496263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yaF1e+ZDI4o7HUbfg08d49EhpMbXTxxHxUMXWJw0jGU=;
        b=s0SyCJUDwW6aqjMuDNa6E99yRHYgfEypf8nR/5fyp/YvrqzV5k5uPCSBK6B6o5ur9V
         pK8bhB7avlx0a8M4v7CJcJ0W2ZhJSLKMxFgygUIUCoa4Tx3hptNQ04s2fufo5yd9sQWU
         n46QT8pIYqB+YmJQzxwEeYP5phe8chmYFpojy4wXQXCgN5tpMw9bwPSc5aztHECuY7at
         IS88SzTUcjHDXxN+HALUgktN8o+FxKn+aYD5GW6psVTuqgIxVXJhcmh65LLCy2DYGJBN
         NQlIK1+fGp1n1I/s9KDRD1fBlBdPgEdCeklGzcGwWD+eOe4+QOZPcfjzJBaaxvA1MNHh
         L+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739891463; x=1740496263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaF1e+ZDI4o7HUbfg08d49EhpMbXTxxHxUMXWJw0jGU=;
        b=Xv6D79SJRctSOQWKohNBIli24c1ETnBSwmQRstWZyzZiYobo9fEfgvTuRkZArp34WX
         QERNGfChpXQr14+cFPFchW94KnhIGELa96HR8isESrket/IlAT90CsB0f7jOn/Ne+2x+
         /WVqcWm5y7qtkbyr6yIUm9Rwd0AXgUhW2M1KsSs+2YIKcmXicy6SkA5zekkrf71EJnyw
         qenl2tD6Qq60P49ubNjr6w/ApbvyR7rCYaR1uSC3sVY5F6/C8Q8QTWXcz2RhS+t8l1W6
         B4sKIk0HNKkEov+wSxiU9t5dhZPZ6qIYmEhdWBHLu0til2XVnhV5Qt60lyLwMz81f43y
         k6fA==
X-Forwarded-Encrypted: i=1; AJvYcCUpEgWs9ALKndeeukVr6ZD1O5jNrbXvu6KxjU0/opLHAwNmQAVxzPRSWP9wo5O7OEKQm1KQGY0Rruu2rG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcYP9KlBe/M3BzQEnlVPDM6Sgpxmh94TyTFfMLP0q/O6hO4rR1
	LK3eVmgEaJ5flaZIqQ+byRoBIEcvUcEgIKU8NkJv/O7vlKbYhBji36EsEpLfhVcuG+7dp/4oi0L
	o/F1ADibDtW3mvO7APAKz64YTgAzjX1R5rcz2
X-Gm-Gg: ASbGncvqC0zi8hXtXqpspSFlw3xms6ALo3ZYkxWh3ell0aQUSv/gbViXHyzXA87SpDV
	PEg7hKDdprZFQhikaeTSH+BQ9ciD86a7EPycrbQrSKhdvhOtrKhRZDN7BeIl01ad647BFDPHWzE
	MN/GHkxVsKeHW5y9n6geTt4i8mfA==
X-Google-Smtp-Source: AGHT+IHpjq/htlflcz+BOGXILOgtcgl1rT56T/ncJcPogbP2nYGjXfTEcTyL3S2eReOnwyD1UPZlIzWdSUt/GcLkmrs=
X-Received: by 2002:a2e:8657:0:b0:308:fedf:8c12 with SMTP id
 38308e7fff4ca-30927a2ce8cmr42700271fa.5.1739891463042; Tue, 18 Feb 2025
 07:11:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <f68741e0-0cc8-4faa-8144-e1786b9591f1@efficios.com> <CACT4Y+Ym7=9mLS8b=Rq6cyHMgyboMqh15nqkRfgru-qFVTx_0A@mail.gmail.com>
 <cf7af2a8-c004-481b-ad2e-6aa991aacb67@efficios.com>
In-Reply-To: <cf7af2a8-c004-481b-ad2e-6aa991aacb67@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 18 Feb 2025 16:10:51 +0100
X-Gm-Features: AWEUYZkhtgINqZrVndnQoWNfcUuweH7pVGdghkWfoeMeJsTqvByZCWbWc9wbXTk
Message-ID: <CACT4Y+Z3PCBWDdR5PifXoMBSYJ-cdUmzLRdgbjTUG+A2S8Qq1g@mail.gmail.com>
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 15:57, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-02-18 02:55, Dmitry Vyukov wrote:
> > On Mon, 17 Feb 2025 at 21:21, Mathieu Desnoyers
> [...]
> >>
> >>    we still let this function read the rseq_cs.
> >>> +      * It's unclear what benefits the resticted code gets by doing this
> >>
> >> restricted
> >>
> >>> +      * (it probably already hijacked control flow at this point), and
> >>> +      * presumably any sane sandbox should prohibit restricted code
> >>> +      * from accessing struct rseq, and this is still better than
> >>> +      * terminating the app unconditionally (it always has a choice
> >>> +      * of not using rseq and pkeys together).
> >>
> >> Note that because userspace can complete an rseq critical section
> >> without clearing the rseq_cs pointer, this could happen simply because
> >> the kernel is preempting the task after it has:
> >>
> >> 1) completed an rseq critical section, without clearing rseq_cs,
> >> 2) changed pkey.
> >>
> >> So allowing this is important, and I would remove the comment about
> >> hijacked control flow and such. This can happen with normal use of the
> >> ABI.
> >
> > Thanks for the review!
> >
> > I've addressed all comments in the series in v2.
> >
> > I've reworded this paragraph to simplify sentences, but I still kept
> > the note aboud malicious rseq_cs.
> >
> > If we would not be circumventing normal protection, then, yes, these
> > cases would be the same. But since we are circumventing protection
> > that otherwise exists, I think it's important to think about
> > potentially malicious cases. In this context inaccessible rseq_cs
> > values that resulted from normal execution are very different from
> > malicious onces. Normal ones will point to a fixed set of real
> > well-formed rseq_cs objects, while malicious ones may point to
> > god-knows-where in an attempt of an attacker to do things we can't
> > even imagine right now (e.g. rseq_cs overlapping with protected crypto
> > keys).
> >
> > It's as if a particular instance of copy_to_user would allow
> > user-space to write arbitrary kernel memory, and memory of other
> > processes circumventing all normal protections. In that context we
> > would need to be very careful regarding what we actually allow.
>
> I'm considering that we should clear the rseq_cs pointer whenever
> userspace issues pkey_mprotect.
>
> This would ensure that no legitimate scenario can trigger a load
> from a rseq_cs area which has the wrong pkey, and therefore we
> could accept read/write from/to a struct rseq which has the wrong
> pkey, but kill the process if trying to read/write from a
> struct rseq_cs with the wrong key. This would prevent userspace
> from making the kernel read/write from/to memory with the wrong
> pkey through a pointer it controls (rseq_cs pointer).
>
> Thoughts ?

I am not following.

There are pkey_mprotect calls, then independently installs on rseq_cs
pointers that happen concurrently and after pkey_mprotect, and
independent set of pkey_set calls that happens concurrently and after
the previous 2.
I don't see how doing something at the pkey_mprotect call for the
single thread avoids any scenarios.
Moreover, pkey 0 is preinstalled for all pages, but access to it can
be revoked in future.

