Return-Path: <linux-kernel+bounces-271256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE4944BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98EDB22AD3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C721A00F7;
	Thu,  1 Aug 2024 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cn69r+ue"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58274170A31
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516548; cv=none; b=b/vcB8/XmDB1Kc00POOv6HhK2fCdTxP3GJuIT4eccYmtAvAtbWHQDbImEeechbFHlYVeoZXuWuu6wV3iv0wQNoUo5C6Ro26jJWV7f140dd+8clLBzWk3hlgtWtWjnHEGoQJzEbLB8BC9jteNNcfraENN2l/eBrZ34xi7xMJEWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516548; c=relaxed/simple;
	bh=yCTTXbRTR9vcCIO49PvqbkjFhy2jjGQvDbjsg/TiMys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sugNu34LoGQgPItUBqUsYUrdDOQ6aE8vsgdK2FWhvpGa1u9aK402yyzeKTSH7nG0ps2KHJYblcmesPPjcnQhztb+NorWgOP2A4hLrni1TGPo0RkPeH7S2zvf+UuvsXWOLxCXucxD5GH4h5t7MM0G0v+3pqqyPxXmKxvclYtRxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cn69r+ue; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428178fc07eso42484325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722516545; x=1723121345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivf0dedh/kNlaxhUOXBBVCs+HsDrPdQjzUTbZCof2Q8=;
        b=cn69r+ueC1vQz3yev2U+dIp4RaJZiE0HwKwPE7IMNQasVrHaRkV3bpwjrIa7pEl3bc
         zJeEKUeVbNRDUFPQ2l6reTMBD5uL+1/H/YE0rkeUG1eKwTwEGFBN2RJfbrHmueOsOKJW
         TPkxThJReGgMaFIaAD62BygBMb3TthkKbeqxOW53JuefmySesXRH643ZJ1ymOXv1cqib
         ftVbUcdYRrF4E+nkhu/6POfYpZVj06uDYl3U1hzsCW1mRMpco16t0z8yCtWyYEOmuQo6
         SHeDAuTsZlpHfr/0/eXpVDdL318enREGeMW4noFUVEEmAxOaO+P96sr+wztWyrEnyPlf
         ewmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722516545; x=1723121345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivf0dedh/kNlaxhUOXBBVCs+HsDrPdQjzUTbZCof2Q8=;
        b=u6dTURnEwETODYAtChvMg1+/SZNWc7T4BaHXcdYzWcr3Y315Ky9TCWJNfC6rKxSJ5V
         oRotLLyX4OVv/yQslIgo7N9kQhJqZBGn05BhNTgIaR8rq8+dQYlb1Gag7mn+jnH6rDhP
         JVAemQVvI/b4hLtmkKq3Kod/1qkP9CNIuH9L8OuVPiYrlogwxlUMRBiOz8+HxZPSRtSg
         wOEvsyDbRcvdtXmZksMuuwPff1L13iTBftwBKsGluX7KNYeGkzznA9c991YRPNLgBk2f
         TrMVGsiTKj5ZHTiqx2Qisy4r4D+P/MqMRhFYvGXJOQEWAOn+UrLjJWwWLYiH+BJAYBqm
         WMdw==
X-Forwarded-Encrypted: i=1; AJvYcCWnLvbyOoj1HOnh8DEWLBNu5LD78Bh9cp59OyYIWckcFeMh2CDutIRz1+9F7xplA+TxI8PjWpXe5ocvmmO7T9tI1bdrZRRHe8O3CPcK
X-Gm-Message-State: AOJu0Yywm+rcUUaaGsUXMh3sBb68ZA0A4iSr/Wp/HLvtUrj3Kb68++Lr
	LrsJuXipNncZwDBeGoO54NyihPAhbPTh5Zy+KjP2LKpZDu1Lbav0bZDIyEOR+RhBznaAUZhIf+6
	L9/24YE2U2UYbbYLm+oHldTeAcnKOuzFnvmWr
X-Google-Smtp-Source: AGHT+IH0DKRMGpWhTdEr+rzxMTKBlJSpQK2F/2LMQbeMHgE0zIl7LV+JvtbFFFJCC7Ib7AhMBAhLQOsWxxgbuG3YEis=
X-Received: by 2002:a5d:5f45:0:b0:368:3b1f:fe40 with SMTP id
 ffacd0b85a97d-36baacd2ef4mr2084012f8f.20.1722516544235; Thu, 01 Aug 2024
 05:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-10-dakr@kernel.org>
 <CAH5fLggjs8t2c1GVFdQu6gULjG_oYx7299m4NedQFS+hOgFfTw@mail.gmail.com> <ZquDcoPg2CzlPbpU@pollux>
In-Reply-To: <ZquDcoPg2CzlPbpU@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 14:48:52 +0200
Message-ID: <CAH5fLghhgrM_EyCkmHSZ=VpQZSvg3Co+HHYyAU9+gssMkKGNhA@mail.gmail.com>
Subject: Re: [PATCH v3 09/25] rust: alloc: implement kernel `Box`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:45=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Thu, Aug 01, 2024 at 10:55:51AM +0200, Alice Ryhl wrote:
> > On Thu, Aug 1, 2024 at 2:07=E2=80=AFAM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> > > +    /// Converts a `Box<T>` into a `Pin<Box<T>>`.
> > > +    #[inline]
> > > +    pub fn into_pin(b: Self) -> Pin<Self>
> > > +    where
> > > +        A: 'static,
> > > +    {
> > > +        // SAFETY: It's not possible to move or replace the insides =
of a `Pin<Box<T>>` when
> > > +        // `T: !Unpin`, so it's safe to pin it directly without any =
additional requirements.
> > > +        unsafe { Pin::new_unchecked(b) }
> > > +    }
> >
> > In the standard library, this functionality is provided using the From
> > trait rather than an inherent method. I think it makes sense to match
> > std here.
>
> I already provide `impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>` in this=
 patch,
> which just calls `Box::into_pin`.

Ah, ok, I might drop into_pin and only have From, but I'm ok either way.

> > > +impl<T: 'static, A> ForeignOwnable for crate::alloc::Box<T, A>
> > > +where
> > > +    A: Allocator,
> > > +{
> > > +    type Borrowed<'a> =3D &'a T;
> > > +
> > > +    fn into_foreign(self) -> *const core::ffi::c_void {
> > > +        crate::alloc::Box::into_raw(self) as _
> > > +    }
> > > +
> > > +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> > > +        // SAFETY: The safety requirements for this function ensure =
that the object is still alive,
> > > +        // so it is safe to dereference the raw pointer.
> > > +        // The safety requirements of `from_foreign` also ensure tha=
t the object remains alive for
> > > +        // the lifetime of the returned value.
> > > +        unsafe { &*ptr.cast() }
> > > +    }
> > > +
> > > +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> > > +        // SAFETY: The safety requirements of this function ensure t=
hat `ptr` comes from a previous
> > > +        // call to `Self::into_foreign`.
> > > +        unsafe { crate::alloc::Box::from_raw(ptr as _) }
> > > +    }
> > > +}
> >
> > You may want to also implement ForeignOwnable for Pin<Box<T>>. See:
> > https://lore.kernel.org/all/20240730-foreign-ownable-pin-box-v1-1-b1d70=
cdae541@google.com/
>
> Yeah, I think I've also seen another patch that it about to add a functio=
n to
> convert a `Box` back into uninit state.
>
> Depending how fast you need ForeignOwnable for Pin<Box<T>>, do you prefer=
 to
> contribute a corresponding patch to this series?

It's easiest for me if you just add it to this patch of your series. I
don't care about credit in this particular case.

Alice

