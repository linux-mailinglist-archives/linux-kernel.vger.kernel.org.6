Return-Path: <linux-kernel+bounces-564054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27264A64CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D498A166CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECAC236426;
	Mon, 17 Mar 2025 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeqMN/z+"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007F1474DA;
	Mon, 17 Mar 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211325; cv=none; b=rbJitgU8St3o84mavF6RdlRWdsdKkAo1dlpBH8Pz/+Xi546XJ1Asr3H2doOlu3tnOU7zETvx2JjIIf2yJ6mRHNvD1vVezqpuSmZQm0+D3FQVlq/hI6Ce34Tu8KayNQLbHCWFZPxbj+U09HSrwU4YOWb6Wm9kHslQwgsW3wKNa+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211325; c=relaxed/simple;
	bh=Z+jU0yjVjlGpr86JvyDq0lWCy38NGvFMUZiUBy7qA4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpgD/UTiyZjjJQPcXmI+b62EHryfJ1M1mZUhbHxSKklv9+fgZzCvFc3S5UQ4A8WCt71Fj/iCX41pXseCf1GFnJ0J9R8oU5B6Xy8E0N54DcIkar1jKpiuqJhaLoXKhz7Itngoosm93FMMBsYiqwbZY7RHbdweE99rpSVyEkrNeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeqMN/z+; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso43947361fa.1;
        Mon, 17 Mar 2025 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742211322; x=1742816122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdqbJfJCjqHPAuiYDswWxzkHL5cem7Mfcc3PxZdr4j0=;
        b=CeqMN/z+vEvdZPMfi1+YnRr/zVpqhIM+2LF/lmXtZPKmU+lfro9qJkrhrlfdgrdBIH
         MF+16OGJ5VNVXHnucxuubFXuMxZoXEHkaK3Mnh9A8YfuKEz1lSE8Okxqu3t+zJ/fg2I8
         Um+oUXcfsImzUR3WxOwkW4poyG+5+HHEsgudeS2S5cf61wQ9GJmdG6Zk8XANokTdlU+b
         NNwGIpoBZeNGzXpzAch+qFAJYrcxj6LEdOU6l9nO5iThIST1N3zRXfPeIHoBNZm00+dY
         7KKiv3CTXwKQjkbL71wKE/SxodKIRkHOnTzVjUi2Y8CPR2fJ1UJFn4xAYZosF0qe+WO6
         g2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742211322; x=1742816122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdqbJfJCjqHPAuiYDswWxzkHL5cem7Mfcc3PxZdr4j0=;
        b=vlYALO7ILGfIDTgzJFUzjgmOYHkwOcTnbiJMyyo2GvIM9OxjDD9kWV1X/I87hiExv6
         LCsYx/WhcvWpVXBObropUfnUFLAHLx7BoTQS+2YUX6XwLt58smSM4FBENozp5ES1BnbI
         w8dvDkp9HtUoCWexuoBChZOLoQwsWqFOa/4eIKKczRkeL5POH8O5+miyamV83JGSRI6t
         R8bviL41R/hCzOWEKz9TLA2NGSeRg9vGcHr5uh05hK/cLjIv95np+SPDU1VMv3z3jE6E
         jQ6SXfEQtJh3C4dCzlQcmmUkpwNLU9bl1ej5ti3txEX51bpx/bjjXU4tCdqJHTVKpyd3
         hn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhUyh1dLqJAQ6g1SGJuAdDATCTzHWHdBjJlXbFelDca7KLSKNMa7qiJ9oQ0wBUcRuqdYXi8fdQFDKsW6w=@vger.kernel.org, AJvYcCXilr2XrAlKNOlp3tKIEeI71An+mvZkLdj2ZLYhvNYeym4PQijeCLKI94Cn7BzbeJrz4qBU9urdHDbRWno5Rt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFWvEZlqVa3ZxOLHHP5oHCsdYDiLk4OEZDe/J1egyVKLJLH6V
	SUtUH1aQfrDuhu3WUXnKUtAb0e6Q4cVci4ZjBCh6Pk+umuU55Kncj85+tXruIjDpLIAnmDpZddW
	4k7rzhxa1qvAehnOLSBKwmvitfiU=
X-Gm-Gg: ASbGncvzq02a5/nq/Oq4dagvChy03D6ZOR7w9g5aPMGWoeWjrkzfbBQVZXa0mFyjr7o
	VJi6pY+iymNgqAll97THROX/++Nafm+Z6ER7XlSEzRpa4BHpsp5ga8sFx3v3JYjJOdwmAZ5b9kz
	R2UOdvb/9rF7ofdLB8sB8filap4/t6d0ZlFHGAlYkeMO4oEOjVIyJ1kLlXstu0
X-Google-Smtp-Source: AGHT+IFI/uWCTLubFLAoAaI0TSL57GVHnEjdOx7T/HkQzF0DApRhmTmWnB7plfh+E+etgvSBauBkgmz1SarAO8n3inU=
X-Received: by 2002:a05:651c:1307:b0:30b:8f90:bdda with SMTP id
 38308e7fff4ca-30c4aaa1a16mr65049261fa.7.1742211321524; Mon, 17 Mar 2025
 04:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
In-Reply-To: <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 07:34:44 -0400
X-Gm-Features: AQ5f1JrNHM6KrXV2cdwfDKtwGLlK__r3IwisWS0nZq97rJwKKR_q_sLD4wbgGyU
Message-ID: <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > Add `Vec::dec_len` that reduces the length of the receiver. This method
> > is intended to be used from methods that remove elements from `Vec` suc=
h
> > as `truncate`, `pop`, `remove`, and others. This method is intentionall=
y
> > not `pub`.
>
> I think it should be `pub`. Otherwise we're loosing functionality
> compared to now. If one decides to give the raw pointer to some C API
> that takes ownership of the pointer, then I want them to be able to call
> `dec_len` manually.

This is premature. It is trivial to make this function pub when the need ar=
ises.

>
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/alloc/kvec.rs | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index d43a1d609434..5d604e04b9a5 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -195,6 +195,21 @@ pub unsafe fn inc_len(&mut self, additional: usize=
) {
> >          self.len +=3D additional;
> >      }
> >
> > +    /// Decreases `self.len` by `count`.
> > +    ///
> > +    /// Returns a mutable reference to the removed elements.
>
> s/reference/slice/
>
> I would also mention here that the elements won't be dropped when the
> user doesn't do that manually using the slice. So explain that this is a
> low-level operation and `clear` or `truncate` should be used instead
> where possible.

Neither function exists. I've added a description of the semantics of the s=
lice.

> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// - `count` must be less than or equal to `self.len`.
>
> I also think that we should use saturating_sub instead and then not have
> to worry about this. (It should still be documented in the function
> though). That way this can also be a safe function.

This doesn't seem better to me. I'd prefer to have more rather than
fewer guardrails on such low-level operations.

