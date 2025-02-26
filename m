Return-Path: <linux-kernel+bounces-534961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807EA46D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B77916B6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA1A21ABB4;
	Wed, 26 Feb 2025 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K/IagHvo"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE62755F2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604848; cv=none; b=DJVcDeVpns3GfFM+gF4RU7xUHRmG4VbS2PQs9Bv/FuMujOlqXay3XCXilXZEEprx6DY2argreLtSfld9BFY1uSV/ulB7Fj+2c5wnlm9S1ueSvhKoaffbQUd4dQ4mHFhnOA/gtvSIuxwoKHaM3WNwgJTmTjqwC0UkcOr5f18BvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604848; c=relaxed/simple;
	bh=A5PaH4enkrbYDM7nXZ+Ass9AMQsZEd0mjSntP6Y0BCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2g8uOaEm1oKvHoh1wxLOpbRdqQaDwwwgjvmjRwVuIwleRU+Y5NLMkB+CFEeZUNmIA+pYh4RXcg0Yt30MCimzFHhn/seb8NaPZET7HSRWkQrdoLzWz9KrCzrKmDRc56jXaW+nNo0anV7tUDSwYT9xiJATCszP/NFrWTy3n0lMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K/IagHvo; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3098088c630so2646661fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740604843; x=1741209643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=plHH0IcN9eXsv1E/PqFvNYQwN4wb6pcqv5JKjVIOwQQ=;
        b=K/IagHvoQ2xkSGlhinLSYj667eVwheF0UThABDU68ZGixk4D5U5xVmH01kbRp1t4/h
         CGi6e18f4bWtt8rraZHZILKCEnm/CeGY7NYwK5gMfYqZUQtfY1GlCPNCKM8qCWdTAzyR
         poDHlQN0USZjT15Kg+Gygyu0jBNIYZJh/Ty5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604843; x=1741209643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plHH0IcN9eXsv1E/PqFvNYQwN4wb6pcqv5JKjVIOwQQ=;
        b=Im/CFVQa/4wlrrBeZtxETpfXZejA817jBOV1xIDLm83E1Zr20MW6voeppv2mJJeH8/
         Gp7fWNKbaJWT8Atm2jB61kTKOTtLq7eh1GRxfsBznJQ3vVqkKb8it744wwEetWg3+wN0
         Bs/lQt2FE61ZJ+PhBvBxgUiK4Z19TacB6abVnOHHp65WbmUrffP24iElz07dRNNHJLaq
         Lk0vIXBGZYLGwWAoKmXF6haQBjOPJrXJPffiYrfAFrhwXlnTn3vftmmWepLOuaeJtZWS
         mE5glS/qJa2Y4rlKnHu525jfqyQhHwcx6nIGgH6P29p9yWsK6qvA6JgHz4Z570dtpLjq
         OlxA==
X-Forwarded-Encrypted: i=1; AJvYcCWccb4lkNL+j00zmRoTJoYLCnI79DMVrJz9JJTD/g149l/HEgIIdFona2ZR6WT77AgE8iiU1gRMbQdX3No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72300GjSVC9VzSyjrm3kbmkWNvab8z5Win6aClWYbZsRuTTRt
	UF0pgjlDbCdN21zoqE3TPIbfzzK+xdQu8A86IYYyszA/7MYtIKdRvxJcfopxXccF0ZLAdvowEva
	q66DSDw==
X-Gm-Gg: ASbGnctGG7E6+AkBkbnr/yuU7bNOTevvBbJj5xqcTXQgmGrYbPD/IVDX6b7dNF+XAOW
	E0VOEwCzClSlGZqEAHENxxoOkFIkuq4FIWp8IgkaOPhXsw0V1azxg5kFd4eK1ydrVf4xNjWr619
	EG6yjNj55LK/OAbfbhBKbxJ6aYI1rIOkZ222cRwUqOzSDM57hjHogICGjPhxNutIXisPU6g901k
	2WJuNk3sxVlG3sGsC7E+w5aDvNrV8FIbEuPgjtpYaOrjnRQ9eOuPZMzfLvxJEYq9yRTbwYF5Xv9
	vl3lHTSh7W0bxNOUrvGgACko8csjwTfIE9d5LYRE0vO+rHRdhs2K9UpBIC8xVrYwaF+6Lf1VbCR
	K
X-Google-Smtp-Source: AGHT+IGRKc+TYkKPVtUJYAgB/mxrmnKeNjFoqLmL4QshoG5kTBjCWUQKRB1uziEPJjTLaaRo1jxvVQ==
X-Received: by 2002:a2e:3c16:0:b0:304:588a:99ce with SMTP id 38308e7fff4ca-30a80a17cedmr47566561fa.0.1740604843138;
        Wed, 26 Feb 2025 13:20:43 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ae808esm6947071fa.90.2025.02.26.13.20.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:20:42 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-548409cd2a8so198107e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:20:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIA4TvPTYn5LEKTqTL2DYfUo+DJVzY5H9wtNDOF/uMIM8xUqU6JhVv0tPjLfIzdRhOVB7MmQy2rpItHgM=@vger.kernel.org
X-Received: by 2002:a17:906:3150:b0:abe:c894:5986 with SMTP id
 a640c23a62f3a-abed100adb1mr883763566b.39.1740604487746; Wed, 26 Feb 2025
 13:14:47 -0800 (PST)
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
In-Reply-To: <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 13:14:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jq-snYj9HKjCJh9QYG9k368Ub3WE-vsH9QCuPSV36deSRojSaVqyhZUuTw
Message-ID: <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
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

On Wed, 26 Feb 2025 at 12:00, Martin Uecker <uecker@tugraz.at> wrote:
>
> The model is exactly the same as in C.  One defines "observable
> behavior" (to use C terminology) and compiler can do whatever it
> wants as long as it preserves this.

The problem really is that memory accesses (outside of volatile, which
is defined to be a side effect) aren't actually defined to be
observable.

Yes, yes, the standard _allows_ that behavior, and even hass language
to that effect ("The keyword volatile would then be redundant"), but
nobody ever does that (and honestly, treating all memory accesses as
volatile would be insane).

> As Ralf said, the difference is that Rust makes it much harder to
> accidentally trigger UB.

Yes, but "accidental" is easy - unless the compiler warns about it.

That's why I basically asked for "either warn about UB, or define the
UB do the 'naive' thing".

So this is literally the problem I'm trying to bring up: "aliasing" is
defined to be UD _and_ the memory accesses are not defined to be
observable in themselves, so a C compiler can take those two things
and then say "you get random output".

THAT is what I am asking you to consider.

Pointing to the C standard doesn't help. The C standard GOT THIS WRONG.

And yes, part of getting it wrong is that the standard was written at
a time when threading wasn't a prime thing. So it was somewhat
reasonable to claim that memory accesses weren't "observable".

But dammit, doing things like "read the same variable twice even
though the programmer only read it once" *IS* observable! It's
observable as an actual security issue when it causes TOCTOU behavior
that was introduced into the program by the compiler.

So I claimed above that treating all memory accesses as volatile would
be insane. But I do claim that all memory accesses should be treated
as "USE the value of a read or write AT MOST as many times as the
source code said".

IOW, doing CSE on reads - and combining writes - when there aren't any
aliasing issues (or when there aren't any memory ordering issues)
should absolutely be considered ok.

And doing speculative reads - even if you then don't use the value -
is also entirely fine. You didn't introduce any observable behavior
difference (we'll agree to dismiss cache footprint issues).

But if the source code has sa single write, implementing it as two
writes (overwriting the first one) IS A BUG. It damn well is visible
behavior, and even the C standards committee has agreed on that
eventually.

Similarly, if the source code has a single read, the compiler had
better not turn that into two reads (because of some register pressure
issue). That would *ALSO* be a bug, because of the whole TOCTOU issue
(ie the source code may have had one single access, done sanity
testing on the value before using it, and if the compiler turned it
all into "read+sanity test" and "read+use", the compiler is
introducing behavioral differences).

That "single read done as multiple reads" is sadly still accepted by
the C standard, as far as I can tell. Because the standard still
considers it "unobservable" unless I've missed some update.

Please do better than that.

              Linus

