Return-Path: <linux-kernel+bounces-548560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E38AA5466F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F463B0FD5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D90F209F4D;
	Thu,  6 Mar 2025 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZ6hLYq6"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2720968E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253759; cv=none; b=Ke9JDSLdSo2Ot4uA19PoCIpj0ARgEyjMAMSy3Q8sj4mnao4wpm8xmetN1+r08jTXEn8jqG6VrxRKhECqFf/eBc5zJVhlm/6hQNaRd1LYAcmhqfiSp3GIuJKlGLV+rpiHzIyYMnTc+ySimfztHLYv2r+gLqSWTOAqa8MlV+H4SeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253759; c=relaxed/simple;
	bh=zAfupfnmXgAPKBf7N+VUINqI3bvcjO+DlUy81THOReY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mx+UC+Mvl4G1ejRd3Qdd7McOMLyJ6MAaGzWkDb+b88r2ymJY/YdfSpXxHyW4JRx0rV6ikyZbpQCioKnL4vhwpEQiyQlyQdNwIUSd/yh+a6BOfdCdcjHBQvchsNGApVCh3RY92Njs/EWB8K3a8QH2wJz4iU0MfxlLLS6tqhezmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZ6hLYq6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c489babso1883165e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741253756; x=1741858556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80/MuYHXzFOlY04/5DfNbTTbOenEqnxQ83fIcfIWstI=;
        b=RZ6hLYq6FQnB3CTlZ+3pQYLBpPUkVcwBgmSmq8fiMCuyxHif/0+sGbcS+ZamZIyryQ
         xtzQwckV1kD8BVGwH4P3UuMQdb/Ik3Y6buuEaYmkSIrPAasHPBdv+1MW8U0+6pQrFust
         rmdNYQJBXiU2nn/EWFPSg0YrGAZUOuenLkJfYKEIQ3GbCt6rnEYtagR2UGA7Vwy3NMbf
         5j3EYrIGa2FkJi+epdyRFi0ZMyMWmHnIzoXpUE1LNIrF5hyo0PsgcYqCU3ouqAWgeNiW
         PIP5YUjd9BuZ4uPqphQV1RgC4/xOxH9301u0epVjnxqKjNDHSzTfxeD/e9Az3+5Z6eGg
         AbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253756; x=1741858556;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=80/MuYHXzFOlY04/5DfNbTTbOenEqnxQ83fIcfIWstI=;
        b=A6+mr3e2htX/k7zNRk0snvU5z83yLEaAcCi3vHdZns1QXYqlMtEpI1+RTO3pGrjPvc
         opIN6VnlDno/R22lqrYHkiOEY1ULVcLACZKnpZOYpi/jTZu1PpXMNEE47bC1DSAJskBO
         douD4xCRsHYPUkufjjdgCjZK+xwWM1yagK7nvyAs+a+Oa5qSC1pl/W0dDStd33KN+OhD
         FoSehd1OQNZCwDwCwpDHcVzAggNGsvM3T8lKP7FDkNWZXYt3KW+DTNBJSsJQ73uQQPgK
         deaCo/UTBHsITogXDkUi0do6vq4dMS+CYuCbCCNzGUOaQ+KddtUeHLeZ3Rcf5P5GpnGT
         28Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUFF0g+w4lEpVr+XWl49rCA25/eBcwrfSiwmc9GI3NNg/lkFmH4L4SZFa2O1e21ca5n6Fov5wNqfnIPTZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtlimyZ8LekrPxBbr7jAMhoul1FnQS8XDQ8MZdwm1z9MP2folx
	X24PV7qJ/kFETsyVMGddNAhPsnrRKNryihlyIbgvdZairjbQzohDKxpzUKMOOY2lQDwrZoSGn2T
	0eSzlv1N6A3jLdg==
X-Google-Smtp-Source: AGHT+IFxl8xciWrl2CQHn8RoJKN3DeV4Zim2lKi3GQnZzsbzv7UugqHqo9gKtYFc9LBV4rU4WNoxZYH203ol5XE=
X-Received: from wmbek10.prod.google.com ([2002:a05:600c:3eca:b0:43b:c450:ea70])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ed2:b0:439:a5e6:73ff with SMTP id 5b1f17b1804b1-43bd29d8441mr46790355e9.17.1741253756313;
 Thu, 06 Mar 2025 01:35:56 -0800 (PST)
Date: Thu, 6 Mar 2025 09:35:54 +0000
In-Reply-To: <875xkn8k5z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me> <Z8hUIPtE_9P60fAf@google.com>
 <Z8hmCkeZGPwc5MuU@mango> <mE_To6ll96gFJQD9YKkT-mwa2KCHFCgOaZFxxczeDVJd0hr1rZCKFHD-vHQfm6deCjlUJIu4U-reNMtrwfyT7w==@protonmail.internalid>
 <CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
 <87ldtj8p2m.fsf@kernel.org> <JPqvzrz3Zy0HgwNoHh2psup7imFItiN_j_VmmjVPBfwJzf040DTvZAwUDjNv1FQiLXFiSAANIxc2IegeKGCJvA==@protonmail.internalid>
 <CAH5fLgirYTV6K2QoH9LLwhHxJzz=h1R0jB4G2kpKQ_pBtBgePg@mail.gmail.com> <875xkn8k5z.fsf@kernel.org>
Message-ID: <Z8lsetLbHvn-6cai@google.com>
Subject: Re: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 06:24:56PM +0100, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
>=20
> > On Wed, Mar 5, 2025 at 4:39=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> >>
> >> "Alice Ryhl" <aliceryhl@google.com> writes:
> >>
> >> > On Wed, Mar 5, 2025 at 3:56=E2=80=AFPM Oliver Mangold <oliver.mangol=
d@pm.me> wrote:
> >> >>
> >> >> Hi Alice,
> >> >>
> >> >> On 250305 1339, Alice Ryhl wrote:
> >> >> > On Wed, Mar 05, 2025 at 11:31:44AM +0000, Oliver Mangold wrote:
> >> >> >
> >> >> > > +impl<T: UniqueRefCounted> Deref for UniqueRef<T> {
> >> >> > > +    type Target =3D T;
> >> >> > > +
> >> >> > > +    fn deref(&self) -> &Self::Target {
> >> >> > > +        // SAFETY: The type invariants guarantee that the obje=
ct is valid.
> >> >> > > +        unsafe { self.ptr.as_ref() }
> >> >> > > +    }
> >> >> > > +}
> >> >> >
> >> >> > What stops people from doing this?
> >> >> >
> >> >> > let my_unique: UniqueRef<T> =3D ...;
> >> >> > let my_ref: &T =3D &*my_unique;
> >> >> > let my_shared: ARef<T> =3D ARef::from(my_ref);
> >> >> >
> >> >> > Now it is no longer unique.
> >> >> >
> >> >> Oh, indeed. That's a serious problem. I see 2 options to deal with =
that:
> >> >>
> >> >> 1. remove ARef::From<&T>
> >> >>
> >> >> I checked the users of this, and it looks to me like there is rathe=
r
> >> >> a limited number and they are easy to fix by replacing the &T with =
ARef<T>.
> >> >> But I assume that wouldn't be welcome as it is intrusive nonetheles=
s
> >> >> and of course there is ergonomic value in having the function aroun=
d.
> >> >
> >> > Definitely not an option. There are many users of this function that
> >> > are in the process of being upstreamed. The ability to go &T ->
> >> > ARef<T> is pretty fundamental for ARef.
> >>
> >> Not having `impl From<&T> for UniqueArc` seems to work out fine.
> >>
> >> It would be unfortunate if `impl From<&T> for ARef<T>` would prevent u=
s
> >> from having a unique version of `ARef`. I would say that is a valid
> >> reason to consider removing that impl.
> >
> > I think the impl is really important. It's required to do things such a=
s:
> >
> > let mm =3D ARef::from(&*current!().mm());
> >
> > Without the impl (or something equivalent), it's not possible to
> > increment the refcount of the &Mm returned by `current!().mm()`. There
> > are many other examples of this.
>=20
> Right. Let's see what we can figure out of other solutions then.

Ultimately, if a struct implements AlwaysRefcounted, then you can always
increments its refcount. If you want a version of the struct where that
is not the case, then you need a different struct that does *not*
implement AlwaysRefcounted.

I do things like that in the mm_struct series. The VmaNew struct is an
example of that.

Alice

