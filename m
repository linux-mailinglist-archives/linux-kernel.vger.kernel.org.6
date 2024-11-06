Return-Path: <linux-kernel+bounces-398787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D662A9BF614
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6470A28337E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45823208231;
	Wed,  6 Nov 2024 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5QaWgJS"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B3201106;
	Wed,  6 Nov 2024 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920178; cv=none; b=M0lkDCsb+zSlXRIwaB8PBbXRz8ShSOsn6skWuF+7o173dASbfP1n17VTGIRxuVUaVxKFn9kwhO6c/6spShOzIKo3KKSu0zAt2T9MOEijk7LSzX5r6a1W7rjE5INUoZqQb/5TdJ/4Op2dn+dBNoxpEzcXnOAMrXyyMn3YhfKX69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920178; c=relaxed/simple;
	bh=e7p68YBbZMXRvFAfDeh/8xkKP3Je1m9pDyDdbE5+MDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taT/LOOWQa1oiE9Nxp3+7arVznXAu/xZYuRTnv8YFOmoYT7zSBfkchq+ah7EOMnbIqaxn78Gg2MFdhrf8kZJ2Cj4/pvf2f/r/wYKaYevtTkvpyYhm3kfsGnDEm4/2yPX0cvxW4bJR0DC+2BgowAnzgh2sTF0aMwnxHHnGNZoWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5QaWgJS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso1959861fa.3;
        Wed, 06 Nov 2024 11:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730920175; x=1731524975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7p68YBbZMXRvFAfDeh/8xkKP3Je1m9pDyDdbE5+MDI=;
        b=G5QaWgJSQST2ttmKkcCsI3j2oHR34vLyBFTKvYqyCAoMvx3mBsAVSnkULzEt/g0elk
         dMLlGc4vrhualdlxDvfkvca52dayUUZLU3wxBtIBhJJWV34VemTwnXhIhqarTjIug2jw
         NDfM192HEUtjNgFs9/1F67BjLVI7x7HheDe3LNwJQonUGlABv/i04QtH4u+LjE53dUNQ
         A+6odUseE4tuBF1sWNMpQAxpXhqD1aCHX2W9q+RNMrmaKI19rJ0jKBOn8d/Q28fblV3L
         YVlE23Vb0IbSP2vQTI4yK17ZmwPrV+gxFWHkQwKNc7rS38UNdYM98aCWjKit/aj3I2At
         DNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730920175; x=1731524975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7p68YBbZMXRvFAfDeh/8xkKP3Je1m9pDyDdbE5+MDI=;
        b=WrX6LdQM8ETCw2H98veHDaaZhE1n80Lc0hNNIKaGFogykkpSU6bgejsapJocB4yJYo
         9e9wyAEIqIbcNUeYtjZY5/qA1FLtoB04ULscsqMMBiIFyD291BShVN1hVEpqyV7cxSht
         dtD9V8RyVOi0mD5hiBeuFqV8D8IKN8hqBABXya1lg8FsT4LvHwjzHpu/chwH2to9kMXi
         ma9PQjGW8Br1e7FAbNDP2flskg4ARtBph8fxhWuNvcVyN2bIQ6weHIAlj8Izi59WLO+K
         +otYHQow5rgEag++lBFZLXFM24S6dqXxHqsLbB70ei1Kol7CaxSr+48l80JEv7DJMoN0
         Nw8A==
X-Forwarded-Encrypted: i=1; AJvYcCVyjz4CYVcB7ZpOJ26uCMFF3gKtUxWP9NMkC8F/OhipD4Ss9+wmuoWWl8ObqYVDw687Uhbcc03pg5TBB66ShyM=@vger.kernel.org, AJvYcCWEscS2DO2ekJz6fYHy5E4Oh4VjOSV9JN2Ah+E+HIUCfi0VGtmSS9s/hAXaK+ZMGL4AUmKWc6A+bLS4wlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvmrr4o/XTMyNixuLUW3e/Bpw66/lmpf9yO6n+mchbnhb9G1+
	gJXciVDGKOB3nNsLhBiGvWvJjiizcZS2lgGZ80TDGqVfUrCwRDcx5rYmVEzpjYDSPRpYM5YquPu
	hbVWHbFnFpp7VrlrF+jh1hmy1Rk8=
X-Google-Smtp-Source: AGHT+IHgF6RWu96nevnfTcoUiInCMl4EtY7bI0XtjfAgxlvJ/rHrmbsvM6PbQJbxEuq714EZ/9RNSM1L0dOWAHmc2iw=
X-Received: by 2002:a05:651c:b20:b0:2fb:63b5:c0bc with SMTP id
 38308e7fff4ca-2fedb793caamr171684141fa.3.1730920175010; Wed, 06 Nov 2024
 11:09:35 -0800 (PST)
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
 <CAJ-ks9=b=UEp9KCZ5_dE5yDKWZ1BEfnTkAtS4LiNQ4wzMgdT4A@mail.gmail.com>
 <CANiq72=MmpyquVfi=796v0BAmx6=yuy_gvzeRgUVPhpq8E4rrw@mail.gmail.com>
 <CAJ-ks9muM0RRtawt-C=vwT7b29rhsHbh1FjpX7LbJ=a05tLuPQ@mail.gmail.com> <CANiq72kBo4x7D92Xe7Wkvu=Jj+YmMH+-ARiovG+SHt9BYECbvg@mail.gmail.com>
In-Reply-To: <CANiq72kBo4x7D92Xe7Wkvu=Jj+YmMH+-ARiovG+SHt9BYECbvg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 6 Nov 2024 15:08:56 -0400
Message-ID: <CAJ-ks9kWuQEaj7DUqHm50jAS3ageYZktsiaJvJmava=76mJP5w@mail.gmail.com>
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

On Wed, Nov 6, 2024 at 2:30=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Nov 6, 2024 at 5:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > The upstream changes to dropck predate the PR I linked up-thread which
> > landed in 2017. Since this Arc code was written in 2022, it never had
> > any effect. Isn't it proper to keep the "Fixes" tag?
>
> If there is a bug, definitely yes, but I don't think that applies is
> -- this is more of a cleanup, no?
>
> Sometimes things are marked as "fixes" that are perhaps a stretch
> (e.g. a typo in a comment). It depends a bit on the maintainer and how
> we define "bug" (e.g. does it count in docs, or just actual end
> users). But here it just seems something is superfluous, at worst, and
> it does not need to be backported either. Even if we kept the tag for
> some reason, I think this belongs in `rust-next`.

Thanks, I forgot that "Fixes" changes are backported. This makes sense!

> But if I am missing something, and this does indeed fix something that
> we should prioritize, please let me know!
>
> What looks more important, to me, is to clarify/document why (or why
> not) we have it, regardless of whether we keep it or not, i.e. having
> thought about it, I think it wouldn't hurt having a line/comment even
> if we remove it.

Will do.

> Thanks!
>
> Cheers,
> Miguel

