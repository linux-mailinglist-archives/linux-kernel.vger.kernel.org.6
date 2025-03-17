Return-Path: <linux-kernel+bounces-564585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC53A657D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4746165313
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D2719E97B;
	Mon, 17 Mar 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbeWShtc"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1819C553;
	Mon, 17 Mar 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228515; cv=none; b=qrrr2GuIGaWHuI8mJAerG2ZeXu+ClLWf4pnRQyxcFR0/faHCuT2+/R8tYP5gaE4iZPgJTF6L4YLaHc8VcHBYNrjdPWUosQqLmJ9gJ9QazBR6BEoNQ1I5+Sjv8NFKAZC0nYllQRL+K7yAYLfTn78yMqGzSIUsMqZFPFnDFi1pNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228515; c=relaxed/simple;
	bh=y6rXyBZpTYw/V59DY1m+Z9P/ey7jnM+RJLnozY7gQRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/mfmZanb5OLqxHhH3aI0caAh0vifoswf7VheHG0Ll4ZZTVgED//sPvTbiweEfZRuq1SeS7hQwWSPz76hBoDZKHPKA5LigT6pd4fGWhCGqrHd1hSYDPR48bHXjh7hHNLe0+3CT+FwE3zaO77wRCR8auZyebiD63vMvEOC/ZvUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbeWShtc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30c091b54aaso43093281fa.3;
        Mon, 17 Mar 2025 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742228511; x=1742833311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6rXyBZpTYw/V59DY1m+Z9P/ey7jnM+RJLnozY7gQRU=;
        b=RbeWShtcqkxolCZSKXygErmY2lznk0pxY3r6ZxNLUdto40Zns19kDruJinLtk04IBF
         AARisJKE320hjDoSU1VBbRIPo+GWSBCrw3NPQEFwtNeqmmTYXzgttBuohMvcRPojAcOg
         PmNX8++RummYjqwNA2m35YHqwt3spJPpISNdcItyFUfutgsCbP36GbqV0KmUiq9JfvOT
         6XUyGKZPXqOfyggzepSGIj+Op5ZYrB9vEZwVT7VC0yGQlgwekNAUKJJg40ES9no6sAx6
         jXkpXwx7GRLN0Cppc4OM+1phoPICG0zrePExrtP09EtkycPZPtVHJKihdpUmysbEyQhi
         okbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742228511; x=1742833311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6rXyBZpTYw/V59DY1m+Z9P/ey7jnM+RJLnozY7gQRU=;
        b=JkgzU1/GAWy/zfYt01ENg2G0h3mTZKqYRVan0zeFSCQHKls0nZ9IggSbn7dxER84Ip
         pVl5XIZzaY1mcyt5mJw4KQMjg8kizJmmzsMzd8/4PdlI5ctlo09EnoIgnhbGPwRIOPUI
         ukAzOjrouGM67OECo+m3Hmt6XvAMaBBtrTokTwHziZH+JJQv6HKeBfQen7dmi4mXVmdO
         39j5Q+MsiYJ5R/oXwqjNlhhZd6k32mUCUdPLuhXpamih+T2KUfqpX6vX7CX4YroekuTr
         2YfWb+qyCD/0iL7FFb3BR/nRU5KAf83ZHRfHiCgjekWNySkkQ/0eN2uowp3bjYIx8JHS
         4xnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/IP6vDCt9wKkP9Y+YbHakNf36zIEmsZ7trI+s+gZcpszIZ3nPNyGMbtFBCxHcuMKK5uu6Daev8bOpvRc=@vger.kernel.org, AJvYcCXYKEN8Xw3skuQXENlbYCsL1GU81hYpaGU4aXpeTLhyriJKFRjCLkpvQaLNTqDTjW9bjkOj0AV3vwCjEV5CYT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHuORXsAg11hs/8zqLKCCwesNV0NcYbPgsnhwDEe8ee7QEXGk
	MtjFaPMmUS2S6NWVW5POlkneZO8QiCwBG8eEc72DGZYCYVqcX216M8Ctc1JWeAdM1Vod1m/sRI5
	B3w2/2Ie8WVnBUjUHMamCAwOY9h8=
X-Gm-Gg: ASbGncvNo64EM0y7AgDmCh6lO31OW1jRctvZ56tYFDk5W2eulkjQRhj9LgcrGZPUiXa
	N4NiPZwpipL7W2spFHuJOPJ6a4M0QmpLzojEZ7JT/gqvtqeJUjOsbkwI9iQEbXur8cuqRB6FsPb
	tDjwATO6GDB6IxY+Lzs8i6QES2invb03xudsQs+cdxMhaRODXU3EPqRtWT0ie6
X-Google-Smtp-Source: AGHT+IGRHSRCKy7ZR7YHYJz067aJJshY9TappEWxANnP3DG7yaBZ8B0L/so5I6SeiO529cfzgNgP4UG9WCinBIcnlTA=
X-Received: by 2002:a05:651c:2119:b0:30b:d022:2fd4 with SMTP id
 38308e7fff4ca-30c9a928256mr5043841fa.30.1742228511221; Mon, 17 Mar 2025
 09:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <Z9gL5hQWvCNy5XNH@google.com> <Z9gcqHihXLg6kcZb@google.com>
 <D8IMCFZJ2G7C.28DHUZGDB596P@proton.me> <CAJ-ks9kEpC=7jK9CLNKBWYpoOyAo_Wr8eyvaYf0ZSiC8m-VREQ@mail.gmail.com>
 <Z9hK9_zFqnH5XQC-@cassiopeiae>
In-Reply-To: <Z9hK9_zFqnH5XQC-@cassiopeiae>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 12:21:13 -0400
X-Gm-Features: AQ5f1JqCtYAQtudRI4cztt0TrhycoBIi86N1H5WggNQT1nghkHgYX-MoDRuLz_w
Message-ID: <CAJ-ks9kXySdc2OdZ3uxwvRGYKSyBUNtg=bxovxGrOmLyZ=Rt8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 12:17=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Mon, Mar 17, 2025 at 10:44:25AM -0400, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 10:42=E2=80=AFAM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
> > >
> > > On Mon Mar 17, 2025 at 1:59 PM CET, Alice Ryhl wrote:
> > > > On Mon, Mar 17, 2025 at 11:47:50AM +0000, Alice Ryhl wrote:
> > > >> On Mon, Mar 17, 2025 at 07:34:44AM -0400, Tamir Duberstein wrote:
> > > >> > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.loss=
in@proton.me> wrote:
> > > >> > >
> > > >> > > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > > >> > > > Add `Vec::dec_len` that reduces the length of the receiver. =
This method
> > > >> > > > is intended to be used from methods that remove elements fro=
m `Vec` such
> > > >> > > > as `truncate`, `pop`, `remove`, and others. This method is i=
ntentionally
> > > >> > > > not `pub`.
> > > >> > >
> > > >> > > I think it should be `pub`. Otherwise we're loosing functional=
ity
> > > >> > > compared to now. If one decides to give the raw pointer to som=
e C API
> > > >> > > that takes ownership of the pointer, then I want them to be ab=
le to call
> > > >> > > `dec_len` manually.
> > > >> >
> > > >> > This is premature. It is trivial to make this function pub when =
the need arises.
> > > >>
> > > >> Normally I'd agree with Benno, but in this case I think having it
> > > >> private is preferable. The function is safe, so it's too easy for
> > > >> end-users to confuse it with truncate.
> > > >
> > > > Thinking more about this ... I think we should have `set_len` and
> > > > `inc_len` instead. That way, both methods are unsafe so people will=
 not
> > > > accidentally use `set_len` when they meant to use `truncate`.
> > >
> > > I agree for this on the public API. The way I usually saw `set_len`
> > > being used for decrementing was truncation without dropping the old
> > > values. And that is going to be `vec.dec_len(vec.len())` with the
> > > current design. `vec.set_len(0);` is much clearer in that respect.
> > >
> > > But for the internals, I'd say that `dec_len` is nicer, so for `pop` =
one
> > > would then use `self.dec_len(1)`.
> > >
> > > How about we keep `set_len` and make `dec_len` a private, safe helper=
?
> >
> > This discussion is _way_ too speculative for my taste. If you'd like
> > to do this kind of thing, I'm happy to drop this patch or the series.
> > I'm not comfortable adding API whose usage I haven't seen and don't
> > understand.
>
> Seems like setting the length of a vector is a hard thing to do. :)
>
> I advocate for a middle ground.
>
> (1) Let's keep dec_len() a private and safe helper, it clearly improves t=
he
> internals.

I don't agree with making it safe by using saturating_sub. I prefer
that the caller must justify that they aren't calling it with count >
self.len().

>
> (2) Introduce set_len() as a public API and defer the question on how to =
support
> dec_len() in a public API once the need arises.

Do we have line of sight on a public caller?

