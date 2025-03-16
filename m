Return-Path: <linux-kernel+bounces-563193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8274DA6380B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AFA16D95E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655BC1A2C25;
	Sun, 16 Mar 2025 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyRkwIou"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117ED1F941;
	Sun, 16 Mar 2025 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742167683; cv=none; b=fQTDFMCscmKxNgmllw6wzQPMhlVe7/sbnEyxB4/jLqtgVvO6CaJ90sRSR8cGbwgpL3jQU+Vz6Mx2gxMy1+Qps8TLpMISo/J2V0aRaoguYhcqrtkMIugV1VTBrW13VCsHuePxYonQLCFUZSdxHX308op9Q+ZE16RY6PKUpy16ZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742167683; c=relaxed/simple;
	bh=hQ6ZueSygeSYFOUEiCeWBj2MzriOozC3UZ3KkEAhhiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIPDz7IBoy78g+O9wh8NnbBCIsJA74aOOJMcGfXfnCRdnghoH0wYOTsp5kyszMs9w2OLEmxpOAcGQX8hjRB3yvyvKbG4QvDYXqtEDGVPKSGaTyAJIB/Ql4bnScgzaIxx+HvIaEiHcVKdlY9hiLcsa2AJRTcsJMz0YlG02msEDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyRkwIou; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso42904701fa.0;
        Sun, 16 Mar 2025 16:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742167680; x=1742772480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiWamAro7DkL0T4cGc9VViJtzfEX0e7mdq0/aZ6aI3Y=;
        b=iyRkwIouMUp7jYYqavrFEB6Iwtf1gIQjjtQZiBhr5rbhByq6oc/xQp460XVYn0yeh6
         A1EwCzdTXsOSglY4dGnnh52hNvpuq8NRoAJbxH67u67c7VRjNW/SYE32RQGeVBkWNVUI
         lWFPqaxowzi0yu9MVSF9uPl/SaCMs/VHDEyobMKq3UWzt3ARq9o1aGn8sevF5Ox7P1Ks
         iuE5p/e33IaGYgota0S4u8I6YGCJpPisy/da+iDLLjOzNmY+DpDWIUz6HAwldBhTAKuM
         nZM6SPoziDJSaKWDdyVJv8Avip8mklN5fh3LrlDNoLzAdTTpyjgW/9ckN57H561QaEqr
         GVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742167680; x=1742772480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiWamAro7DkL0T4cGc9VViJtzfEX0e7mdq0/aZ6aI3Y=;
        b=BXNLbGFOrWtRNlWehcg9UNsF+hRf+mSbuQ/3+bg3O55zo+lBg6+v0G7V/5Jr81Khtm
         7IeoO1m5b+cxdRIjpCuEpekY6juhsdgWxzw+kVeBsVOKKdEXeHugA4a48mfMQ638MJEx
         e65CEaf3WRzHBi1aOCx302zV/FXAnWuwpLfQSiz9uFt5ymukLqOxENy/rvC9BT7+ckJG
         bUYbhhxmhFUMuwS9jmlVsJIBwJ1BlF4cYmm7A7odPJJOHt/4tcB3F3ZfDW1+I+Wy6Vy6
         ybP0Li5i2t3/cgGkvxtKuf7650LV7U9Y7MreS0ScN69oy8DBORWvrDnbSrzAeh0Gywo1
         udmw==
X-Forwarded-Encrypted: i=1; AJvYcCWgUypYslkcofIaihSlJ8hn4NB9LafJXi+lTjn47QfIlYLWHwbHWU2HW7QYo39eRKsy06FXesUGUZ287qw=@vger.kernel.org, AJvYcCWzTVJ7UM+Kp4TsSEKXs/rIOmld577JPIBvS0pnUZgHbp7NML+AR/TqC8oqiumcxrXkq+E2mPEMZ15kiW90qWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmn85sIAaVT9980IClJ0eyvd687ClkJB02hMMnwqlZhotJnEcX
	utj42F6PgCliW1MkG+V2sCcdjm7fuUhrtLWjLI41KIekOrvFxIy+oOyhU4MyPH1sa6xHaVEcIdV
	mUloDzE7AA2ynucsKm1NLLDWC68g=
X-Gm-Gg: ASbGncuK9cMc/nMWjlI2OvY763JPAV+x6DlPtnSOEzM99XSlrLxDxtAsv/TVyZGHOFU
	MASAwiDfpwa3ufTcsGTGqhNR5OuqpGwba5V6TlpzuboU7FI6+HK0KG07PJDGWw0VNqN/lAXmBeX
	gSWchIvRhHnpUhFDqw0j+VSIY8cLvlDCL9pVZoVSPLr+x+DCwC8I9bjhNrodcH
X-Google-Smtp-Source: AGHT+IGdB9DGUs0KAoceRzF3tq5y1Pilff1t5p87YdS8di6TfQkkSVT+94vlyceugTj7szsGhazdW/Dq31wvENIKMCY=
X-Received: by 2002:a2e:b8cf:0:b0:30b:d40c:7eb4 with SMTP id
 38308e7fff4ca-30c4a7546b6mr57750061fa.7.1742167679814; Sun, 16 Mar 2025
 16:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <Z9dTspva0aJRWG3Y@pollux>
 <CAJ-ks9mwuLaULKW0cwD73yb3yH-p9KS3ZFoJJ3OxhvUOpXo3KA@mail.gmail.com> <Z9dYnSC13ruc-VC5@pollux>
In-Reply-To: <Z9dYnSC13ruc-VC5@pollux>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Mar 2025 19:27:22 -0400
X-Gm-Features: AQ5f1JpR1LC5oh2kTQQW7qaLOG5J5UvzxYG3MO52Dt4N0YhGI3uQeEL7MShGI3s
Message-ID: <CAJ-ks9mJYyJK7iQz+qS2TnwNgTqp3rRWGTv6hiPhJ3v6aWsLng@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andrew Ballance <andrewjballance@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 7:02=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun, Mar 16, 2025 at 06:47:42PM -0400, Tamir Duberstein wrote:
> > On Sun, Mar 16, 2025 at 6:42=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > On Sun, Mar 16, 2025 at 06:32:01PM -0400, Tamir Duberstein wrote:
> > > > Add `Vec::dec_len` that reduces the length of the receiver. This me=
thod
> > > > is intended to be used from methods that remove elements from `Vec`=
 such
> > > > as `truncate`, `pop`, `remove`, and others. This method is intentio=
nally
> > > > not `pub`.
> > > >
> > > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > > ---
> > > >  rust/kernel/alloc/kvec.rs | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > > > index d43a1d609434..5d604e04b9a5 100644
> > > > --- a/rust/kernel/alloc/kvec.rs
> > > > +++ b/rust/kernel/alloc/kvec.rs
> > > > @@ -195,6 +195,21 @@ pub unsafe fn inc_len(&mut self, additional: u=
size) {
> > > >          self.len +=3D additional;
> > > >      }
> > > >
> > > > +    /// Decreases `self.len` by `count`.
> > > > +    ///
> > > > +    /// Returns a mutable reference to the removed elements.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// - `count` must be less than or equal to `self.len`.
> > >
> > > Why? We can catch this, no?
> > >
> > > We can keep the debug_assert!(), but use self.len.saturating_sub(coun=
t) instead.
> >
> > This is why I didn't want to write this until we had an actual caller :=
)
>
> That just defers this question, the methods you mention in your commit me=
ssage
> will be added, hence I think it's better to do it right away.
>
> > We can, but it's not clear why that's better. What does it mean if the
> > caller asked to decrement by more than self.len?
>
> It tells us that the caller is buggy, but that's what the debug_assert!()=
 is
> for.
>
> But to me both is fine, it's also good when the caller has to justify.

Ok! I've left this as-is.

> Forgot to mention, for dec_len(), please add the corresponding invariant =
comment
> when adjusting self.len.

Does this suit?

>         // INVARIANT: By the safety requirements of this method `self.len=
 - count` represents the
>         // exact number of elements stored within `self`.

