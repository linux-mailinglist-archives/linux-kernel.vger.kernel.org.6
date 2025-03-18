Return-Path: <linux-kernel+bounces-565825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5019A66FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A311B19A09F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022161FECAD;
	Tue, 18 Mar 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9ucunDw"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B91F7076
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290220; cv=none; b=efjlCymvNnJ+Ap4jjY5Z9ZS9YWz7VquLRdWVgWB6DHmsthNSOANDrenhGt87Eoz91uatvz2tl4/LuBUTzUttMQmqdczQn5cyqLDEWh1P9EdD8Hsi/ItFPeXmbK8ggI7QpopoStG41DjDlQbaWETc0Fc4bIGT/8X4V05piu0FgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290220; c=relaxed/simple;
	bh=+Dg1EAj0dtRjm7uIHA1PL7XW26km8fRdpIdIwNrMhdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PY367Pbd0d6K63zC4ShkWOkHPgfw+vNpX+H9ssX8fBSVvYhhSq74tou3DF7N4ObEmroZQUeKjE18vu//LXMgtkkY1UWzYitC0fxSWgT0fNQkPM0cQFjorsRtZhDli0k971muUNUjDMOd8YgFoNPT1cTUvYEhkFVtjWXUwl/n4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9ucunDw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43947979ce8so15216225e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742290213; x=1742895013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9pMgbuADkYvSTjA9D0DoZiQqhBJ0qLaH0cKrr7a8vE=;
        b=l9ucunDw0bDAYz+gns81h/Xs7Xsu9Ca8TIRhs4DbUAlHcffetYK3D8Cxj1X5gf8/v/
         ICzk67lGTMWuSVT695Amzmr/KnaoRUIcIuns1QQOXba2IFEh7lsBqesqGmLFfL5Xfr2A
         duwn94YPRp6P5JpETbW7Trj7Bqem9U8Vs+q0JD308gIrRuOkZLxJczeuCB5Vx/2jKaNf
         Mqc1kz3+AC9XQgsN10GPmmRu4A3s0wy6sN6Mdg0cu2+5uUHiSZx/T72LmcBaxtKsQ/ZB
         IvgtEdnLGiXSNMYvjx2wIg64UznRZcK69dOfzfC6XCz6ydxOblGHZsryeogN77AP9Q4P
         rqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742290213; x=1742895013;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D9pMgbuADkYvSTjA9D0DoZiQqhBJ0qLaH0cKrr7a8vE=;
        b=BT62mfoaEARtU4xvmBTYgcjy9qT1GROGdPtbE6U7PZQH0owUmnsm6NSYyGYZysNF1Q
         Y8eeV2lc3xD+ANuY0j+7Awm5wfQSOEMaF4Nwzk1bPIEjQeTRj98evd6oTGRREAR9yFzs
         +vwymQlMylSflzmyWk7L6E79lQliUUfRfNtRG+u/ESXDQ4wXdG1FJPSZWQOdDyD/IdhW
         OsNghRDlWtlqZF+QdwnKW6zRZHnr/j4CNJRqqrcNjZlQy8z5je/1K5rAuh3hINx1kfnn
         9Jja704ZF12rgRv348pafo2GZXFui7a7v5btuWSX9j8QNElMuQC4O9LAEfUAEotIXlan
         uBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3DqXiMkOb8qsF7FECH7XzcctCppR+B5fExY3QILW6grU3JHMPHSe1ibPX7C2lPiVK97WoE/BPC2cAMuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/emSj/ywUIAj3d64r0A521QjwiZrB/qbZjLa0cBfvL4THN/L
	gaLq7bTJaXLpJ7jWrvG/DZ6M5Sep4IKAOxI8/DaXuyhZzKrbgjSHh0THtk7VbngBJtB+l7QcfgM
	LGLiJ9FjcW0hT+Q==
X-Google-Smtp-Source: AGHT+IHRpT/F0fuf7KRi8AMtM6BDsg3x1nSEd4qVhzuMZ4Qq7GeJZ6gYQ3ywT3qsCApX9rtET662lzVdPbFboTo=
X-Received: from wmbfl8.prod.google.com ([2002:a05:600c:b88:b0:43d:2038:224c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1548:b0:43c:e9f7:d6a3 with SMTP id 5b1f17b1804b1-43d3b98df91mr11964935e9.13.1742290213401;
 Tue, 18 Mar 2025 02:30:13 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:30:11 +0000
In-Reply-To: <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <Z9gL5hQWvCNy5XNH@google.com> <Z9gcqHihXLg6kcZb@google.com> <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com>
Message-ID: <Z9k9I6mp11Z358vz@google.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 09:53:04AM -0400, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 8:59=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Mon, Mar 17, 2025 at 11:47:50AM +0000, Alice Ryhl wrote:
> > > On Mon, Mar 17, 2025 at 07:34:44AM -0400, Tamir Duberstein wrote:
> > > > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@=
proton.me> wrote:
> > > > >
> > > > > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > > > > > Add `Vec::dec_len` that reduces the length of the receiver. Thi=
s method
> > > > > > is intended to be used from methods that remove elements from `=
Vec` such
> > > > > > as `truncate`, `pop`, `remove`, and others. This method is inte=
ntionally
> > > > > > not `pub`.
> > > > >
> > > > > I think it should be `pub`. Otherwise we're loosing functionality
> > > > > compared to now. If one decides to give the raw pointer to some C=
 API
> > > > > that takes ownership of the pointer, then I want them to be able =
to call
> > > > > `dec_len` manually.
> > > >
> > > > This is premature. It is trivial to make this function pub when the=
 need arises.
> > >
> > > Normally I'd agree with Benno, but in this case I think having it
> > > private is preferable. The function is safe, so it's too easy for
> > > end-users to confuse it with truncate.
> >
> > Thinking more about this ... I think we should have `set_len` and
> > `inc_len` instead. That way, both methods are unsafe so people will not
> > accidentally use `set_len` when they meant to use `truncate`.
> >
> > Alice
>=20
> Isn't it fine to keep this function unsafe given that it can break
> invariants in its current form? As expressed earlier, I would prefer
> not to make it safe by using saturating_sub.

I guess that's okay. But I would think that with the exception of
`Vec::pop`, the interface you want for Vec methods that decrease the
length is set_len, not dec_len. That is the case for clear, truncate,
and drain.

Even for the Vec methods that actually use

	set_len(original_len - removed_cnt)

they make this call after having previously called set_len(0).

Alice

