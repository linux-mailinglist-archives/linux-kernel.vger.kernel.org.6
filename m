Return-Path: <linux-kernel+bounces-564838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F9AA65BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B30017652C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5161B21A7;
	Mon, 17 Mar 2025 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdTzysS4"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF41CA81;
	Mon, 17 Mar 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234158; cv=none; b=Vbj47g2sDeVMJYNLJ2CFsAH6G+aff5ajkzmmfTi+V6uAYxK74ciUynpiQM1Ha1Gz/kP0EKqfefoJX8SjoyZtY6uqJveAZDzFne/lD3jdus0y5hXQX9XxkMPkzSGycdA+hddyY1unlSGFbaXINGA++8t6CjqFreqzPWZ7nhgFERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234158; c=relaxed/simple;
	bh=odJtQofV1AZHLRfa4P5rRm51SHEXswsQ8eWRp93gFsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOGpJfFAsmmgSwZuUntNYNXMouJzY4qKjQlBK4LZzmVGqltimJZEIrSBeauUtIjcSMbk3SWS+d9DW3Oyfy47tbWnWQYEcr0gHBlWBdKb8hR0nh4Ajqsq64dEPk/7c/kQHs9au+tUOFiVyawKp7cqOXAGi0/+9LxipACQJcQRDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdTzysS4; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30c05fd126cso45229771fa.3;
        Mon, 17 Mar 2025 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742234155; x=1742838955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OAusYntyp6gDYkffujc8F9VaURwt1VLDqhe4L7vrH8=;
        b=DdTzysS4pXPWYkfKL4DjzrY/Q1JXyOegrIrayqFqu1vyCLmFbdTTw4yDs+cfV5sePW
         h3irzL1dDb+V7nrl6iWxaj0q86Y9QAKipPb2g7TJxlFQn0vkwG1VV0k3wHR/vK/EIy9e
         crtaCJtKhVaYO3Z8k15Xmr+Xv/5yVXqaL+V7h13QyWxGsNiain0aeJS3yOOJjd1s1Hgd
         QuyWswkVllKB2fbQAjuhWj3tnhC8zVL42WWa8tLFPALob0BxrUgCjJEuwAdkVs9MXON6
         JFQb2SyIIU44satSZKZbE+BtjwgIvr488rsmjiGmLYcO0FtIl8SpNiJjtLE5c1/nxj+X
         NJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742234155; x=1742838955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OAusYntyp6gDYkffujc8F9VaURwt1VLDqhe4L7vrH8=;
        b=Y8JBRmCrSRNPwr9ZBL5iuhuKsJPhKfU/9TUUXUtpDlERk0WcM0qtUCY8tz9f49gzTi
         b9lNEb2vlwUOzAJkvtMSx/lkDBZRUOelgIWrgMRILpHHwrGxm1HwU3OPVEy+bxBlF8Dl
         3XjsGCyLLB/qBtuN64BkDj7DBtkZa6G5wJdNeK3U2E1r9mBfZgtNxTuPoP2zeaGG511q
         n23Lp/rFinQqkc+TrBibbmcyedgkih9tkBOG8l57Y2oMhtn1+okRMnBULhceXRUt8J2b
         fZlajtg8i24toIdYkPL8JZ7eO2MhJ5hgF25kzdSBYeJELgsfTiKg8HycGpEg9Au3bwS9
         0BGw==
X-Forwarded-Encrypted: i=1; AJvYcCUFUay77u+xGdLCxHSKXDNMIFD4ZtjtMThKM8gN4E+atl51+H9iUc8e0zzB96QE/v+dKWO/lbAFphXZigw=@vger.kernel.org, AJvYcCUf2v4Tzxr+TWOB7civPIGTSPyAoP4lSp3AKBexkZokDJ8ajFBOPYf+CDgdHNXyeYu3sGf1UsWZNcapWeVC2XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASxoIPuRo9Bft7zALdGnQbMo5gyuTH3VM8+ORSsikRS/1omof
	axHrBtIWpyCHVUO8S93tg+LLap683kxvdi5qwvOp6h45stvAX2oesBRgrZkkaFlXCzxK5OkJq/t
	heG5JDlaOvXvAhZeBKMZ8FmJPLEA=
X-Gm-Gg: ASbGnct8A/Ku5kzCn4ZQL5BdR1NUeUU0l+J/XyKFbmUDsSttjHHBxCa84DghLopFcVU
	ELk7BsmmoOG2UOOVsbbWTqSMkFWKgUHOIJzQxTT3008zWHzzL+t2nYELg18VI2jt3x8r5ppekuB
	lTRLZ/SVrDdMY6G4TqBkiifjnFddn3A3G0CLDMITojVRS6nh4qluH5hdpSUOQGmtLa5DcADDI=
X-Google-Smtp-Source: AGHT+IHjiO8TcUXiHgA20o5N+AtK1Qj+Gy62ZTyhfAn6VbIfvnYUlUvEO6DX7i6hI4Oe9EfhlUNwkDslOnbyuatT8O4=
X-Received: by 2002:a2e:9818:0:b0:30c:111d:d7b8 with SMTP id
 38308e7fff4ca-30c4a8601ebmr66116811fa.10.1742234154842; Mon, 17 Mar 2025
 10:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com>
 <D8IM66U67XBD.28KWYO1XSF8ZQ@proton.me> <CAJ-ks9kq1cQ2-ZNzG9P4SBvk-AjXxT+na-89K33imB4fsCvu4A@mail.gmail.com>
 <Z9hXMcFVdF8MMusU@cassiopeiae> <D8IPQUN25M12.2CIZR4QHJ201N@proton.me>
 <Z9hcT4KPwgtHmiTT@cassiopeiae> <D8IQ5BDTLCLZ.1UBNYUXLK12X0@proton.me>
In-Reply-To: <D8IQ5BDTLCLZ.1UBNYUXLK12X0@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 13:55:18 -0400
X-Gm-Features: AQ5f1JrFZ2MdVZ2cTCig10DakcJD0IHRvR63HDOKHIDkDYVWx2MYSgz4WM56Xbo
Message-ID: <CAJ-ks9=xLLXovsaduKFBfxvkfzYgTaSPhhW_oRN5y1QOuKJFkQ@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: use `spare_capacity_mut` to reduce unsafe
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 1:41=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Mon Mar 17, 2025 at 6:30 PM CET, Danilo Krummrich wrote:
> > On Mon, Mar 17, 2025 at 05:22:15PM +0000, Benno Lossin wrote:
> >> On Mon Mar 17, 2025 at 6:09 PM CET, Danilo Krummrich wrote:
> >> > On Mon, Mar 17, 2025 at 10:39:05AM -0400, Tamir Duberstein wrote:
> >> >> On Mon, Mar 17, 2025 at 10:34=E2=80=AFAM Benno Lossin <benno.lossin=
@proton.me> wrote:
> >> >> > On Mon Mar 17, 2025 at 12:42 PM CET, Tamir Duberstein wrote:
> >> >> > > Use `spare_capacity_mut` in the implementation of `push` to red=
uce the
> >> >> > > use of `unsafe`. Both methods were added in commit 2aac4cd7dae3=
 ("rust:
> >> >> > > alloc: implement kernel `Vec` type").
> >> >> > >
> >> >> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >> >> > > ---
> >> >> > >  rust/kernel/alloc/kvec.rs | 11 ++---------
> >> >> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> >> >> > >
> >> >> > > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec=
.rs
> >> >> > > index ae9d072741ce..d2bc3d02179e 100644
> >> >> > > --- a/rust/kernel/alloc/kvec.rs
> >> >> > > +++ b/rust/kernel/alloc/kvec.rs
> >> >> > > @@ -285,15 +285,8 @@ pub fn spare_capacity_mut(&mut self) -> &m=
ut [MaybeUninit<T>] {
> >> >> > >      pub fn push(&mut self, v: T, flags: Flags) -> Result<(), A=
llocError> {
> >> >> > >          self.reserve(1, flags)?;
> >> >> > >
> >> >> > > -        // SAFETY:
> >> >> > > -        // - `self.len` is smaller than `self.capacity` and he=
nce, the resulting pointer is
> >> >> > > -        //   guaranteed to be part of the same allocated objec=
t.
> >> >> > > -        // - `self.len` can not overflow `isize`.
> >> >> > > -        let ptr =3D unsafe { self.as_mut_ptr().add(self.len) }=
;
> >> >> > > -
> >> >> > > -        // SAFETY:
> >> >> > > -        // - `ptr` is properly aligned and valid for writes.
> >> >> > > -        unsafe { core::ptr::write(ptr, v) };
> >> >> > > +        // The call to `reserve` was successful so the spare c=
apacity is at least 1.
> >> >> > > +        self.spare_capacity_mut()[0].write(v);
> >> >> >
> >> >> > I think the code uses unsafe to avoid a bounds check, but I'm not=
 100%
> >> >> > sure. Danilo might remember more info.
> >> >
> >> > Yes, that was the justification to use unsafe calls instead.
> >> >
> >> > (This may also justify keeping dec_len() unsafe, since otherwise it =
would
> >> > introduce an additional boundary check for pop().)
> >>
> >> If we use saturating_sub then we don't need a bounds check (at least o=
n
> >> non-debug builds), right?
> >
> >       fn dec_len(&mut self, count: usize) -> &mut [T] {
> >           self.len =3D self.len.saturating_sub(count);
> >
> >           // Potentially broken, since maybe `count > self.len`, hence =
need an
> >           // additional check.
> >           unsafe { slice::from_raw_parts_mut(self.as_mut_ptr().add(self=
.len), count) }
> >       }
>
> Ah sorry, in my mental model the function returned `()`. Do we need the
> return value?

The return value is the whole genesis of `dec_len`, we want to return
something to let the caller know they need to drop or copy the memory.

