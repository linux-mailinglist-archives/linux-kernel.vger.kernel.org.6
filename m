Return-Path: <linux-kernel+bounces-398604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766219BF374
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1877DB214BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC012205AC9;
	Wed,  6 Nov 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqR9hPc3"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878DF20408D;
	Wed,  6 Nov 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911302; cv=none; b=FR/PCPfajAArc0ykx608TArjd2QSLfknSCjhAHj25150N7uve4HTnF1vsA0+61itPnHimV9oMLs8ZJCpykXA8/eOA2U43ROLfWgspiG9oUo50w3uaFQ4wRMgRX+VkJ2QM93FmXKvL4BIjhUbSEhczg0x/S9vqBI6wZLtcOQ5xbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911302; c=relaxed/simple;
	bh=pD3h2eaW0xBNeo9X0e9oTJWWVd8xj2zkd3mcL0qyKNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtCKpZ7yFtaij0cpDR6AH6/9lUwG6ZmfKpPgxWKOAWvs4FRE1MT1DzZ/Oo1eWPcWpWwD0sPAgGWikMMxUeYG7fQYmPpEo+hRorKfe2RpeMDuU+ONHv3c8EmaRvxD8XPzKt6nHjnTD63tJj9A0JWJQWnZ7EIMcACYVeqCKFrRv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqR9hPc3; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so67060321fa.3;
        Wed, 06 Nov 2024 08:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730911299; x=1731516099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD3h2eaW0xBNeo9X0e9oTJWWVd8xj2zkd3mcL0qyKNM=;
        b=fqR9hPc3I94jhna8DK+40lllZPqAwCN+wIPAad7VClbsLyd/3sdcCq48+GIZQMl0Gw
         BfFcPGolF/59L+n9rw4R6YeOHCzfRwTq2V0Npgm2Wrf9JgjB3u4g1x9caej0cO6TVgzr
         ZWqmw9VoGsqCBwkJpKmWKCb5UvguIvdVFiZ3MpYbBPYLReMhwff2xotCZLWcwgkM5aJZ
         ynJg7vqsbEAAyaumhd3HwGx4wRyhfoE37zdQSLPlZjtMub19UncARdRpwJ9To/5DKzIt
         Op0oX078kflz4oqO6+yJE7P6Kkbs87K1Wv87cB2ptIaJguS/ileobhVBans9kqMGWOhh
         h7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730911299; x=1731516099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pD3h2eaW0xBNeo9X0e9oTJWWVd8xj2zkd3mcL0qyKNM=;
        b=XhDu6+Aia0mkvXIJMaXYaO8ug5z5+KwhL51wcKqgOAxfQTWCuStjfu1laHAVH5deYI
         wN1LafVz1JbHiPMKkuR9+1113w0HTupUsh598tm4K9p3C2oO1nobBet0nagUAa9LjVYE
         baGTUtglIwDxtaa61EGJgU/bhBxSx+3MBZ1GV7dYHaDKQIJnUQGaVIGDw8Pl2mh72/y8
         R26wARslOHGsdkunw6y+9E8xNRAW4wLdR4QUMlGeqxqrvh8FcsDMlKt8gNcc9HNpvv+G
         3OIrzAM59zL+CKpPY8Jq5yWUmjPjwItgntEQIMP3dAxm9m0Qm9kt4o9muJOQ7KOKQ8ZA
         zBWw==
X-Forwarded-Encrypted: i=1; AJvYcCVzmp58Izl2T/Fl59g4ThDXvyY4+YP0C424dvRSCxR5utlCAf7wxwy09v9T8xRdtQ6cptv/ILAuxKlmHvU=@vger.kernel.org, AJvYcCWHKKLNjGxu6BoD7DNl0pu7KACgqPlI6ir4zu6OOraWDW7oHCJAXBHEDsAGybhZn4SQ8MIGoMmMIDYRB31691o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaspO97/3qW0keOcqOBmjAZT3G4/3HrggLYUkjP6pe99Mme1Y4
	hvCRnpwgRtMkEYhRr0I4QGtSCgph81QZW/jf4DFxxg/qpyPcSBtB8JVSMaCGVvOxMu9KYjerS1k
	0lbqrVqtyqYW9C4agML0GR3pr7pI=
X-Google-Smtp-Source: AGHT+IHISoz+3ofL5FyNcwpODV9rnBMdZBI+OTjgtM9TjmddRcG+4FmkaWJGIZuxglEbX9t86P5dITkQCYoD8DjyMzI=
X-Received: by 2002:a2e:bd87:0:b0:2fa:d7bf:6f43 with SMTP id
 38308e7fff4ca-2fedb7d8b7amr97368011fa.27.1730911298379; Wed, 06 Nov 2024
 08:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
 <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com>
 <CAH5fLgjXXE32k2VuC9yGrNG7ib5vo7V+fsvRxWG0ijopK7MDCQ@mail.gmail.com>
 <CAJ-ks9=b=UEp9KCZ5_dE5yDKWZ1BEfnTkAtS4LiNQ4wzMgdT4A@mail.gmail.com> <CANiq72=MmpyquVfi=796v0BAmx6=yuy_gvzeRgUVPhpq8E4rrw@mail.gmail.com>
In-Reply-To: <CANiq72=MmpyquVfi=796v0BAmx6=yuy_gvzeRgUVPhpq8E4rrw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 6 Nov 2024 12:41:02 -0400
Message-ID: <CAJ-ks9muM0RRtawt-C=vwT7b29rhsHbh1FjpX7LbJ=a05tLuPQ@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 11:39=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Nov 6, 2024 at 2:45=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > In that case, should we reconsider this patch?
>
> Either that [*] or we could at least add a comment explaining it is
> not required for drop check purposes but that we have it anyway for
> clarity.
>
> Starting to use `may_dangle` is a third option, but I agree we should
> avoid it unless we got at least an indication from upstream Rust that
> they want to stabilize it soon in that form (and probably only if we
> feel an actual need for it, since it is yet another `unsafe` use).
>
> [*] Well, not this patch exactly -- the commit message should be fixed
> to explain things properly (and likely the "Fixes" tag removed) and it
> should also mention it double-checked the effect on variance and auto
> traits.

The upstream changes to dropck predate the PR I linked up-thread which
landed in 2017. Since this Arc code was written in 2022, it never had
any effect. Isn't it proper to keep the "Fixes" tag?

