Return-Path: <linux-kernel+bounces-406178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3269D9C5D16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8524B80D94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B0A200C87;
	Tue, 12 Nov 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vorgj+su"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F61FF7D9;
	Tue, 12 Nov 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424881; cv=none; b=oNPIdjYpNIf5CMCn0xGoYjNOvTtnG9MKXGpQb0hggfSBaYPMjfvyT9o4HGitKpvPYF270mImqDbSSv2RFzKxxNL+1Kp7lN4WSncfVOs1n9Sd6IzOqlEIfKnfbptB/BCMhWv5xRliLHaXh9HHYMk8iYcVn8Oby7GwuoCIQqar47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424881; c=relaxed/simple;
	bh=Sp0oAAAqk3tyI2xcRCvwcFIQE9jnwX0MCOfRu+Zz60Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHcQEoLsLSPyKOSvvJXoDn3zFQUGCHRAZz6QQuwJbs75rLhJiY2DIF0VF7Y+639dAt8/VXS6AcTHO2OxKrwE2Zx2F0OE2jL4hWS7p/mAw+HsTy5KiYrnFuiRfOTtReiThDaRHsxa9RGsgdo/iVDxnCIYCFl4MNgAQlONybR87Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vorgj+su; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5743074bso46480551fa.1;
        Tue, 12 Nov 2024 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731424878; x=1732029678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp0oAAAqk3tyI2xcRCvwcFIQE9jnwX0MCOfRu+Zz60Q=;
        b=Vorgj+su9XTyeOMKJ3YaXFdloW0S4iK5pHLsXRWGhZa6JTWEJUIC+oFT47mMH/HC0M
         VW0hAuUhKpEnpMD0kHIZUjGJaHrGYf/ydRLTbpwmopSjW1TxPfej04NDZxqqGazwHULi
         iYwxfoZPinJr04BrpV1mjNqP2zSR1OgHdZamhziXIXwin6YSr/KqK5bY/ipYJlezRmFQ
         1NXrCs74n51poehaR1uoNgraEIYv0/bCB0FULbUj/246VrDY5bI+M4LrAAz+6DzGw0PD
         ezAX/wO/AQlcArNtA+CWfiQBco9rXnf9vGeDWH9nY6sub42BTgGv77Sqd6grRLEJPuau
         9vRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731424878; x=1732029678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp0oAAAqk3tyI2xcRCvwcFIQE9jnwX0MCOfRu+Zz60Q=;
        b=rWOWjP9FWv87yu1hsRwg01R6niQSkmoxuDsTiXn3Q+IeKsHYZRKW93AiGEQfE1NZrJ
         yhr0zvo1ZYWT5r2ASlAkJt19xNpo8Sfr6i5rhOOupgDv05JGoeSg2Dd2T6Eka1nUiIqJ
         LWplmsXyzvLXIbsS5fkitiGh5zyyOPkCGwDVdgnk/0gOeJqmokCvK1BBWD+MMMRP6kIy
         DV6YXR1m/m2/jW8KfhlmjfPZL3wbPXHyOMhpfNvygeZ8b2PHe/tpOk21y47NduzjcUI0
         D5HMG/zcSEQ8YwZFLLBVNi+sG7S/z3qvuTME7LHmKvEwPIe16by58T5aASSRJRhX0/qV
         955g==
X-Forwarded-Encrypted: i=1; AJvYcCWdCrk4kbCNc9a1MmE+tGdQyw6FiYCJN5qlm98DMVVu8zlspb/P/3vHgXjB4dXXcGZL294IAMhUwE7wRX/wsko=@vger.kernel.org, AJvYcCX7e+2vu1iaKKhtYVDgQFp8wjsa4W/pBS+PbXjn4E3kaSaD4VT+jjhsLIIN27+hWjOaUt/mMA0owo8VsV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzhhw8xNk+1aAhe5qPFakUwhylGxs1SmJc89p3sPqYmiwQcDO
	6PtvSkaL+/28+2r/AwdU6wxFVLUeA9cpAPWsd9FGy83g8VfivaUhneMBJtyfiD3lfjrnL6QH5wK
	ICPqxiyUy6RiUFwIfDBgs1sS7m94=
X-Google-Smtp-Source: AGHT+IHvIuzni4eEURZ020MOAXAYZ8bNhOb86gigwKnlf/JfJT8tEqyZ4lRRo0h9QzPkEGkeWAIFxzZaXbgqld1cQyw=
X-Received: by 2002:a05:651c:515:b0:2fb:3881:35be with SMTP id
 38308e7fff4ca-2ff2096433bmr59503131fa.9.1731424877451; Tue, 12 Nov 2024
 07:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
 <20241110-borrow-mut-v4-6-053976068215@gmail.com> <CAJ-ks9mSu0Wivnsn605ZTFHiYqK4VEhURO-7rj5jFAwSxJsABg@mail.gmail.com>
 <CAH5fLghAJFbCaOF8YPKJaKow3RdPXAqRvkJ7Ua5Mo5LcFo2WbA@mail.gmail.com>
 <CAJ-ks9mnGvcsCZUjyjkYUSNSAv3004rtFcczBA-Wo58w-L+-vA@mail.gmail.com> <CANiq72mVe+geqsXAwrR+OdJ=H9DTb2Oxm5r+JWrawYz5O=fV=Q@mail.gmail.com>
In-Reply-To: <CANiq72mVe+geqsXAwrR+OdJ=H9DTb2Oxm5r+JWrawYz5O=fV=Q@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 12 Nov 2024 10:20:41 -0500
Message-ID: <CAJ-ks9k7rLo-QkTdQwrQ743-VAVfjzNKMhoCqmDjUHr=cOB+UQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: add improved version of `ForeignOwnable::borrow_mut`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:02=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Nov 11, 2024 at 5:22=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > My reading of that discussion is that the new `crate::ffi` module
> > isn't going anywhere, it's just the later patches that diverge the
> > types that might be dropped for now and taken later.
>
> Yeah, that was my plan, and I ended up with that.
>
> However, we still need to see how it actually goes -- we will see tomorro=
w.
>
> > In my case though I have a hard conflict as the patch introducing
> > `crate::ffi` and this series touch the same lines so I think a rebase
> > is unavoidable.
>
> If there are conflicts, then a new version is usually welcome, unless
> the conflict is small or trivial (i.e. sometimes maintainers may do
> the rebase for you and other adjustments -- a new version may not be
> worth it, and it depends on the maintainer).

The conflict is trivial here, but I've already done the rebase =F0=9F=A4=B7=
=F0=9F=8F=BC=E2=80=8D=E2=99=82=EF=B8=8F.

> In this case, please wait a few days to see if you get more feedback,
> and meanwhile the linux-next issue will be resolved one way or
> another, so you can use whatever is in rust-next by then.

Will do! Thanks Miguel.

