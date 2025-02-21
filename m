Return-Path: <linux-kernel+bounces-526539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D957FA3FFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072B419E117C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946B205AC7;
	Fri, 21 Feb 2025 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4yHutMz"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7571FBEBE;
	Fri, 21 Feb 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167207; cv=none; b=uiRLcekPnouaYNasPbMhioRanoshpcpCnJiLJzfT6u6Sm/JEHkcfEYiB8i9v2fkxuDdlER+QUNLVtZbczqbo7We5EK+8ShFPzM9toe6reOc1zIXbWcNRhp389gw6ImbKh5d8ZbcaGNg+BeDvzKN5cU+MqZIk/jkWFghz0azPbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167207; c=relaxed/simple;
	bh=EvNaOjdpYA/Meze32ov+VQ+P3oHG1oAT5LZpWYvWbUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyDXtFPno/OdSqqD1gUfbIKfHbs7AziZD2hWDlGfsAH0F11+K9bboDgXsGpopSdZll25excsheyOkGS/xEcArQnTR4oAN1jxyzNMUyzJ1EO0nxAxcJtm6X11xd1Sf1uitJioOKqxu+jwXBx7Zs/JWrl9IA8lXAVAl6+Vv3DUawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4yHutMz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3091fecb637so19945981fa.1;
        Fri, 21 Feb 2025 11:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740167203; x=1740772003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bYx7lKloKyg+UYaN5Q/XJxk/HLY0nsNiep4bhpWcTA=;
        b=S4yHutMzLA3T0OlDFElJ6aGu3hBjoXuaMF0ulXF9Z9jPi84bCMqGenpwoblIsEJnp5
         8GHcwQXvmQikEKrn0d3X/MtGY53ozhGVA1hE4OdNh1HXBglQmUi8jrCt8rM8a/qw8buZ
         XXIEyOro8lQJ68b0qv7SfgIZvBYa8RtjaHTOYH8+yW35veSZCE9n90Dkvzpo7E76GEcz
         igiWA9N+fgzICPkEnnpzynxdaS4GEyDcl/jIQe3zmOOcbwWL7301OPMAS+oYHl1en0GG
         9YVimiqAowTSB2H6WV3CTJxvxGqw0ssESJSay7cx1cJycaP6EPlpjS08wYacdSxE14Ty
         ZviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167203; x=1740772003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bYx7lKloKyg+UYaN5Q/XJxk/HLY0nsNiep4bhpWcTA=;
        b=qtEE2EHp4xE543o/FOIvYw2MTO01KWgG3GtyMzGZg4RrqX+c7WqyJGPBYFNkuMFNeG
         nHWP95GIIBLkH0Yfo9Ven5O0XjFMZVmdH9/cauQa+SoDZPLjFZSLm9/9SUmglPwJ0/zB
         W3VczxROMNo4JlYxs7zj38armDX8hoZtcN2HJMl+h3JNuTEilPaZzmueA4SBSrEi0Skx
         Mxy48cyFewsWMlzPmPm4DdN5G+kA1vWZDUWPpz6xc9wyU+p2qIDfFymWk+0TOj6IBTxW
         Gk3fN2Avo465U0IGvCjGj62bMcLI27EsYWxWKAulLXBlwKn2RKwit9VxSXl9QudMAHtI
         cBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqUQOirxwZjLUPwZJqEFctl17Zyc5zgFrQOppkH9ZjwlRiiMAtL3Oa3y5vi2ROoXflZjgwpAdmA9xWV1A=@vger.kernel.org, AJvYcCXKIfiabukrxQ+luz6cAiDnqnJEjP82YKmINK4MUonPW5WPtiYuyaF0rQ6YFE2qrwwBlnqw7vkXTTOY53MFVXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRYD8jEOS4z3xzzY9bIcJm4mtCd8alhu7eZmwTPa8Mn6NzYWuJ
	W/LC7ZWhAVtdpTDW3QNhL31NUbh/uyC91YuuVn0l1beSHIdDMvbZokvn2XJT4Do4Ton/v4ryjYw
	3OQkR9PEtcWpIpEVbc0hNhwd/Rb0=
X-Gm-Gg: ASbGncsvSriK2D+XErfnaa9B0TR65qpU0GBSuCsSaZ5aG6XZhmZdY8sFg9C8LNTFeeC
	3GCCyccD8hiLmDvhl4deLO7RZZ1XkpCze/QQyZG9uwJ19WIBPpG82D8IRlli1EUORsgBPyZjCRV
	h3rshVagsrvlBZ9W3UMuDGdAjjEuDcCbr/R1EKssCfFg==
X-Google-Smtp-Source: AGHT+IEssYdLCQMaKWr9Fsmsz96kxOj8CVC+OVps927oFZ1uFTyt9hGj5b2TFamn7WpPzQEvImXyxlQ0/pqSzt5/0sA=
X-Received: by 2002:a2e:9b0e:0:b0:308:fedf:8c26 with SMTP id
 38308e7fff4ca-30a5985e000mr13638691fa.7.1740167203144; Fri, 21 Feb 2025
 11:46:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
 <KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
 <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
 <87wmdkgvr0.fsf@kernel.org> <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 <87ldtzhexi.fsf@kernel.org> <87cyfbe89x.fsf@kernel.org> <Z7iQcDa72XnJ5zGC@Mac.home>
 <CAJ-ks9kQccoa7znFNzWAgi6_G0TKvLUARWPZ_Dbed1C-d4Lr+Q@mail.gmail.com> <Z7iZevQkYVGDoeTa@Mac.home>
In-Reply-To: <Z7iZevQkYVGDoeTa@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 14:46:07 -0500
X-Gm-Features: AWEUYZkhuy5uUEVC6MbUc90Erat1K-bUPqslx53fLBY9rVvn-TXqcFsbGm6329I
Message-ID: <CAJ-ks9=f45WJKFwB4J0_a4j_Urf=yR_wukmfhRwRqtczDXfSPg@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:19=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Fri, Feb 21, 2025 at 09:46:08AM -0500, Tamir Duberstein wrote:
> > On Fri, Feb 21, 2025 at 9:40=E2=80=AFAM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > Hmm... if you mean:
> > >
> > > trait HasHrTimer {
> > >     unsafe fn start(&self, expires: Ktime) {
> > >         ...
> > >     }
> > > }
> > >
> > > Then it'll be problematic because the pointer derived from `&self`
> > > doesn't have write provenance, therefore in a timer callback, the
> > > pointer cannot be used for write, which means for example you cannot
> > > convert the pointer back into a `Pin<Box<HasTimer>>`.
> > >
> > > To answer Tamir's question, pointers are heavily used here because we
> > > need to preserve the provenance.
> >
> > Wouldn't the natural implication be that &mut self is needed? Maybe
>
> For an `Arc<HasTimer>`, you cannot get `&mut self`.
>
> > you can help me understand why pointers can express a contract that
> > references can't?
>
> I assume you already know what a pointer provenance is?
>
>         http://doc.rust-lang.org/std/ptr/index.html#provenance
>
> Passing a pointer (including offset operation on it) preserves the
> provenance (determined as derive time), however, deriving a pointer from
> a reference gives the pointer a provenance based on the reference type.
> For example, let's say we have an `Arc<i32>` and a clone:
>
>         let arc =3D Arc::new(42);
>         let clone =3D arc.clone();
>
> you can obviously do a into_raw() + from_raw() pair:
>
>         let ptr =3D Arc::into_raw(arc);
>         let arc =3D unsafe { Arc::from_raw(arc) };
>
> however, if you create a reference based on `Arc::into_raw()`, and then
> derive a pointer from that, you change the provenance, therefore the
> below code would generate UB:
>
>         // cannot mutably borrow because of clone.
>         let ptr =3D unsafe { &*Arc::into_raw(arc) } as *const i32;
>
>         let arc =3D unsafe { Arc::from_raw(ptr) };
>
>
> (playground code snippet for this example)
>
>         https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=
=3D2021&gist=3D15e051db46c3886b29ed02e579562278
>
> As you already know, the whole thing about pointers/references here is
> passing the value to the callback and the callback can "reconstruct" the
> data, in such a case, reborrowing in the middle of the chain into a
> reference is not necessary, and as the above shows, it can be
> problematic.
>
> Hope this could be helpful.
>
> Regards,
> Boqun

Thanks for the explanation. I think where I'm still confused is that
provenance is to pointers as the type system is to references. In
other words, it's not clear to me how using pointers solves the
problem of wanting to write through an Arc. Is the idea that the
pointer inside the Arc has write provenance, and that by doing pointer
offsets instead of going through references we get to break rules
about mutability?

