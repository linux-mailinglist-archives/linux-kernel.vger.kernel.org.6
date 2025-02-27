Return-Path: <linux-kernel+bounces-535645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6CDA4757A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3304B188EBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62752192E7;
	Thu, 27 Feb 2025 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xiuwq82l"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB221578F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635555; cv=none; b=jVpsi7g1AaWreKeAkvaSfbKsbyDEVdR9hf/Og19LrPQU2gqBZ5Idl3Qy7kKHMxePdvULpBaHHOwjPt0IhwFV/dfFD7qc/RQjha/ol/fzhYwrPgkKeAAYmu8Ef6GTpLtvlJGq0pZGCGqBntv/XIlQxpzHKT17MY1xauDPQgX+q+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635555; c=relaxed/simple;
	bh=9BL4zTaSs8TFLGt8qDCuYMxE7mnal2Tr/3pr4sM0MIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwnH2HhQOGI4fdOu5LR81VSCBWNf2REhnIsFvzI4o/E4LwIuHvAAQnNaoOZojOfldgYDOg6qmzpW76lz+D1ffad815CYIgjivAWB5ludf95lnLocu2OJKfcFdhPav+mzZDTrM0OM0R8p6xfYjOakrH432CK8ItQ93XRyS8RfLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xiuwq82l; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abee50621ecso69525066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740635551; x=1741240351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yz1jEtAoGS03tODgTdGrnTdX9a769lSb4ISg5vXSoA0=;
        b=Xiuwq82lpd8d/2T8nVrNW2O+m+KXpXBTm8/8zX2ezwKjzpD1vDppPEBJ4uOpx6OyHQ
         NZyJNi4oNpQr74WSaQzHrML9OQYCWrWDrSn3cPccLlv7mWHFncQDuJHlBE8gvV4aagcJ
         PkLT0KbeixTX4gwe9V7o9OIzml03sJ9sNb9fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740635551; x=1741240351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yz1jEtAoGS03tODgTdGrnTdX9a769lSb4ISg5vXSoA0=;
        b=a7LewEeoGcmUVJKdnJuPbStxXAfWHXgb+5HQDT1bF7Iu8cp6y0Aw+AzOQQ9ZKNm1f4
         41aeXKy89M6RP/N3W2HnhEQU43NthrPRJ6ui3lCcNrXsGptz7bzDZ/C/2c0oEBWBoXvX
         o4N8SPU0bGf/l3q5tok6+kFRSxCnMypIS2aqYrWVwLJMEaljSTiLTr9JsOxDIruFsAXZ
         j1jZWaprt86oUSgh5KIfjPtEWHM8rs2jgZTKBrXJ1hj4e6JylaWU+b68OeQ/Fgv1Em3I
         SLZIUQNF3vQssmNeRnBf7tj8pjFHu5BRbn3jsHlmIBT2AfZEfAJ58xm028GiS24mBKr/
         PY7g==
X-Forwarded-Encrypted: i=1; AJvYcCV1ozKum4xu38+k/3Ay9xDdTcm2xHGz0Y8pQQ/dXfexes4zb2Tn1y3wJpopaZUPtzAskkGBxptUz8TyTNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0XfWvJD94Maj4cTvm2D886iDgE+povQo2Qj9q7ttbfT8e2rf
	eRAGJ/rvSSRn6TCIMW65NcXVZQbSQ6ocrL+/t/veIAH6BPGqT8DUPwXLVEPIeNgddH+CmujFxPx
	ZecA6ag==
X-Gm-Gg: ASbGncu3G4tbtvY2PuYqvavMLZf8NQkZgeFE7A6i+cDYtjy2ZNAHm1Smxv3axhvaiWC
	Jko2PZx4YZr6F5EQL11kaux0Dn/9oBs0jt/hICUY8kFEq69aXGZ65NTpo/nu/NBgeXYjPlOLdSM
	/7XTgMq0iSNUZjCEgsEqcuBWWgAtZA/LylLrKWpxcpdas0C/Rxw5gsnxTBGQfWSg1AiYvbeDOGo
	gmVeo1m3q3AdGqEw/YQ5VbTnBKEKWKaNWfzWa0tC/Gu9EUX1YlV61L8KznG72TqxUB78YzWA4cd
	6mT9Mp8fOtYiFWdnr2FVmKa+06XVoWk57hKkJ7iaR+81uR5U8qkE1+i7eMUsb5JL1CbYyJzk+TP
	l
X-Google-Smtp-Source: AGHT+IG70ubOhG8/9CNcbbcVr2tLWvqIRm3WWveE2pYwYJtVtq07ooULVuWrmhPbMOmdglwu4svPVQ==
X-Received: by 2002:a17:907:72d6:b0:abe:c45a:a1b3 with SMTP id a640c23a62f3a-abeeef65af7mr814220066b.37.1740635551104;
        Wed, 26 Feb 2025 21:52:31 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c7c07d3sm63790666b.180.2025.02.26.21.52.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 21:52:30 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abee54ae370so74033466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:52:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuUQtaZ7Add+w3nIgBPMuBb4nDIUkRK038z5ek7eZ/rwTpWERy5EtfQlttOKZdWjIxtCd9p/D+FipNQcE=@vger.kernel.org
X-Received: by 2002:a17:907:a42:b0:abe:cecc:727 with SMTP id
 a640c23a62f3a-abeeefc9108mr925171166b.53.1740635549770; Wed, 26 Feb 2025
 21:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com> <09e282a9c02fb07ba4fc248f14c0173d9b19179a.camel@tugraz.at>
In-Reply-To: <09e282a9c02fb07ba4fc248f14c0173d9b19179a.camel@tugraz.at>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 21:52:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jp_NrFySgQyMF9RUCoV9O6uCZpLaodGvsiFnQE8IzSzYGK1vSJBzFxb9cE
Message-ID: <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Martin Uecker <uecker@tugraz.at>
Cc: Ralf Jung <post@ralfj.de>, "Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 20:18, Martin Uecker <uecker@tugraz.at> wrote:
>
> This is not really related to "observable" but to visibility
> of stores to other threads.

Yes? What's the difference?

Threading is a fundamental thing. It didn't *use* to be fundamental,
and yes, languages and CPU architectures were designed without taking
it into account.

But a language that was designed this century, wouldn't you agree that
threading is not something unusual or odd or should be an
after-thought, and something as basic as "observable" should take it
into account?

Also note that "visibility of stores to other threads" also does mean
that the loads in those other threads matter.

That's why rematerializing loads is wrong - the value in memory may
simply not be the same value any more, so a load that is
rematerialized is a bug.

> It sounds you want to see the semantics strengthened in case
> of a data race from there being UB to having either the old
> or new value being visible to another thread, where at some
> point this could change but needs to be consistent for a
> single access as expressed in the source code.

Absolutely.

And notice that in the non-UB case - ie when you can rely on locking
or other uniqueness guarantees - you can generate better code.

So "safe rust" should generally not be impacted, and you can make the
very true argument that safe rust can be optimized more aggressively
and migth be faster than unsafe rust.

And I think that should be seen as a feature, and as a basic tenet of
safe vs unsafe. A compiler *should* be able to do better when it
understands the code fully.

> There would certainly be opposition if this fundamentally
> diverges from C++ because no compiler framework will seriously
> consider implementing a completely different memory model
> for C (or for Rust) than for C++.

Well, if the C++ peoiple end up working on some "safe C" model, I bet
they'll face the same issues.

> I could also imagine that the problem here is that it is
> actually very difficult for compilers to give the guarantess
> you want, because they evolved from compilers
> doing optimization for single threads and and one would
> have to fix a lot of issues in the optimizers.  So the
> actually problem here might be that nobody wants to pay
> for fixing the compilers.

I actually suspect that most of the work has already been done in practice.

As mentioned, some time ago I checked the whole issue of
rematerializing loads, and at least gcc doesn't rematerialize loads
(and I just double-checked: bad_for_rematerialization_p() returns true
for mem-ops)

I have this memory that people told me that clang similarly

And the C standards committee already made widening stores invalid due
to threading issues.

Are there other issues? Sure. But remat of memory loads is at least
one issue, and it's one that has been painful for the kernel - not
because compilers do it, but because we *fear* compilers doing it so
much.

           Linus

