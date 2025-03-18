Return-Path: <linux-kernel+bounces-566349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A0DA676B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495E41773A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6593920E033;
	Tue, 18 Mar 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXdCj7n1"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE01C5F32
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309063; cv=none; b=h1KNa9hA2FwPG0RDxS1pBoPgJ8w1/o51W9YnBB+3MPaNKdD0xU+vXhAUo1RyRCAxUGgyfSwJFMSp9/LvRPvozgrhUEcY5SrhX1k/KYfy3h0sIUbZOTXAwdbsKjUqE+6rjC2S9sXaV6/WhrKedgfm5mE4whjbE5/+wzsAON+5XH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309063; c=relaxed/simple;
	bh=fLIyFC84cNuRIkl6BuqtHem66qsH5HFpSzxSSvlHDek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gJJi+1MESIsOCkbePsW25f94HDYF8FlyBKOZNu1SiaGypLbVCDji2oLwNpd1RnLc06VLy3PKvrjRXOpTa0DqEWoOE2JyqPo+ZciWGCJ+beADrMKUezDJh+awob7AbQTs936Ymj/uJkXQK6D0sL5MteBFXmB8Z/cf5Xf13ZyfGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXdCj7n1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43935e09897so22167975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742309056; x=1742913856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfhIGoNUej7lluGTETydFlNEk1+KiJXUugkQI5WYNmw=;
        b=cXdCj7n1Obfsd7c5JsDvcUIg2PFdMdRoUM6MwjAdKzr4V5XBpG3KpxiZDoU/BbNLEk
         ttAdlR3bygWM3yEmQ1P+Nx+df3pZdDR+e73CDDUmOLYMpl6LsXio/fV6IhoC/n9KwCPn
         v1UukA3HzNUUuuxNLVOWC4gaE4RbAj64SFPb/vTVVOvizteFIE9NlK6XMAprtPDdBE8S
         vLcwIMpZOzWyp2PlF6fR1+9T4ecG6vS1YRugad33ZEOjepe9ndnRBNQKPWKErPNtSPF0
         CK2PFW7xk8dVyFO1yLZsyyJi0nUGXXf8FXkUCGVV/8q+DSdXwPkw0idroGaP6LKrlyBb
         U+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309056; x=1742913856;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VfhIGoNUej7lluGTETydFlNEk1+KiJXUugkQI5WYNmw=;
        b=ZZV0MpXdnfqjr1SHAknherMClgs4tJSjqV38+BtPABwBmvFkauq4PpEwNdyfJ8ydv1
         hhTwwAD7osD9Z25Z0umzP+xWtKmHPHCddq7e1KN+KoP4LwDi0wyYuPvueq7dT3nJE4XB
         CO1jR0hHXJQF3FmV4lkKb7blASsN8WqRoLuCx9wlRRAE21aTfa3Q/DlyxkK02kuATyDG
         Pg+Z13NnrK2DAArLgl5EduNAVinle548p7ruqp/VDQ+h/WKaXWLPh7SPiZ5S9kg2DDpm
         CM8JlkI2KhG1hXESX+tSBVWmR/3CHUSmaGvfut4Wpxsf886HfSJHtctg4uuVjtL2V9gt
         jEHA==
X-Forwarded-Encrypted: i=1; AJvYcCWVk/muPm+vkbLshabWDMX1ZuRoxzO6FxRIBoR8jKkhSLLM7oNO5McMe7nwPj6C5ZwfUVMs5w8Pi8U5TVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySbtC5ER67nwUySxR9ethQ1ajAb6hV7iW2R5wZa8IoQUZQmWbv
	i+Lztw8x+PH0KMaxz/j7BejdLm1toNEUxFFHXObbgTEhBh38wPCXnzsNqaaNTXyjnv3gv9lpP7g
	gjI68W4wueTZCXw==
X-Google-Smtp-Source: AGHT+IFNwcYMuZzCzcsU2UV1EOAK+v46c6jOpysGPV/S/nwnOcf365ojUr1p2lUcWGDAiU0cfSh+OfVPYWtWb74=
X-Received: from wmbgx14.prod.google.com ([2002:a05:600c:858e:b0:43c:eaf6:525e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3d85:b0:43c:f6b0:e807 with SMTP id 5b1f17b1804b1-43d3ba30defmr29194635e9.31.1742309056796;
 Tue, 18 Mar 2025 07:44:16 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:44:15 +0000
In-Reply-To: <CAJ-ks9kcNvGqGrU1nKjYs_4XPbdxo2cW8Tj9JOGJesGO4StdAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <Z9gL5hQWvCNy5XNH@google.com> <Z9gcqHihXLg6kcZb@google.com>
 <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com>
 <Z9k9I6mp11Z358vz@google.com> <CAJ-ks9kcNvGqGrU1nKjYs_4XPbdxo2cW8Tj9JOGJesGO4StdAw@mail.gmail.com>
Message-ID: <Z9mGv6ir4c96Of0Q@google.com>
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

On Tue, Mar 18, 2025 at 10:12:28AM -0400, Tamir Duberstein wrote:
> On Tue, Mar 18, 2025 at 5:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Mon, Mar 17, 2025 at 09:53:04AM -0400, Tamir Duberstein wrote:
> > > On Mon, Mar 17, 2025 at 8:59=E2=80=AFAM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > >
> > > > On Mon, Mar 17, 2025 at 11:47:50AM +0000, Alice Ryhl wrote:
> > > > > On Mon, Mar 17, 2025 at 07:34:44AM -0400, Tamir Duberstein wrote:
> > > > > > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.los=
sin@proton.me> wrote:
> > > > > > >
> > > > > > > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > > > > > > > Add `Vec::dec_len` that reduces the length of the receiver.=
 This method
> > > > > > > > is intended to be used from methods that remove elements fr=
om `Vec` such
> > > > > > > > as `truncate`, `pop`, `remove`, and others. This method is =
intentionally
> > > > > > > > not `pub`.
> > > > > > >
> > > > > > > I think it should be `pub`. Otherwise we're loosing functiona=
lity
> > > > > > > compared to now. If one decides to give the raw pointer to so=
me C API
> > > > > > > that takes ownership of the pointer, then I want them to be a=
ble to call
> > > > > > > `dec_len` manually.
> > > > > >
> > > > > > This is premature. It is trivial to make this function pub when=
 the need arises.
> > > > >
> > > > > Normally I'd agree with Benno, but in this case I think having it
> > > > > private is preferable. The function is safe, so it's too easy for
> > > > > end-users to confuse it with truncate.
> > > >
> > > > Thinking more about this ... I think we should have `set_len` and
> > > > `inc_len` instead. That way, both methods are unsafe so people will=
 not
> > > > accidentally use `set_len` when they meant to use `truncate`.
> > > >
> > > > Alice
> > >
> > > Isn't it fine to keep this function unsafe given that it can break
> > > invariants in its current form? As expressed earlier, I would prefer
> > > not to make it safe by using saturating_sub.
> >
> > I guess that's okay. But I would think that with the exception of
> > `Vec::pop`, the interface you want for Vec methods that decrease the
> > length is set_len, not dec_len. That is the case for clear, truncate,
> > and drain.
> >
> > Even for the Vec methods that actually use
> >
> >         set_len(original_len - removed_cnt)
> >
> > they make this call after having previously called set_len(0).
>=20
> The methods you're describing are all on Vec, right? In other words,
> their usage calls for a private `dec_len` or `set_len`. As I've said
> repeatedly in the course of this discussion: I would prefer not to
> introduce `dec_len` at all here. It (or `set_len`) can be introduced
> in the series that adds truncate or your patch that adds clear, where
> its signature can be properly scrutinized in the context of an actual
> caller.

Oh I did not see that you said that. Dropping patch 2 is fine with me.

Alice

