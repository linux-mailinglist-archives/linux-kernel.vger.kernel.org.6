Return-Path: <linux-kernel+bounces-287937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D0D952E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05101F22998
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3CB19D8B4;
	Thu, 15 Aug 2024 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGYOVNMG"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4E1714DA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725307; cv=none; b=d2uOSTXDMz0XrYo0MqgNFN3y6KNnlxx/63KR0z3GoKD2+xdXEb8b1KdQYvPG47Oo97YzX/Yju8TPT2QX5USWZAGr2qIMxURBbqx26CL/eDLWQ3r94OZr31Vl08U+Xr+M7yDU1Y1S1miO9pVEJu8FZyEsVra0BDeTgAASVo+cC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725307; c=relaxed/simple;
	bh=uQvYqrPJzwS/8Ptp/F8xSXd4QSBGsixV4sGa9RP+nyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0uNfn2Ps1f8wQwzwZOoXbkCSHzjB/ExK2Hakx7X/dbIWZc/0uImOs3rw+wvlL1FbUftO0ijaA0jdUXe1k9xUI40I3EJ8CfsmMg60EU4TYx+JML70P9jwdXbOS4ytRx216+vzyKNtFC2gbvxuerumclTK2ZmwXmMu9MsqqNmtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGYOVNMG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3687f91af40so528072f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723725304; x=1724330104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGIDF+aYZNgQXSDZe/HjaDy7QWphoJnZtou4CagSDHc=;
        b=EGYOVNMGbuC0HyVWzFOEj69xK5PxmGix30HC+L94d+TBuEgNyadOf+nAzqGq0aCrkz
         sbWPJkYcof5WAwbDu6+dguRNTuohLrmC9cjthe4x8iZ4P4DkV5/6n20O9u3kWnxANp4L
         zFdIx4gc+4+oaqzUY5tfCWnsGUzdupWJ85tTBExrWx14wh7Vwt17d63bosALs9HoMNnC
         jvp4Hh9DW4ekRUkQSe6laNc2WK4w8enyIzifnes+PQfH/Cd5x5MCoMQF68WO5qaRCPgY
         0gMJsUVTsbj5zFpqPU/pq+s/Bjk9/yhMrpd9oTEVTRcrlXCv63WBC9JY/l/cD0RqmANk
         CxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725304; x=1724330104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGIDF+aYZNgQXSDZe/HjaDy7QWphoJnZtou4CagSDHc=;
        b=MdAaCSzF8druAc9KH5GPugeCwTBj8DClslGNy/R5a5d1LJfC1Wl0kAVSXYbEyAduf4
         at+TVxPeK9mHuT6NvnpdxZuRopImC5iIoheegmnqbjPagXNrQlJ6WL4EEyyI/4D8senb
         CjaLMHc84i5ZEWEn0CNWSic5IFAPFmuFH7gCjQ6z5KimX9GqQpe4i0MkAdwF6nVgHTw8
         XKL/s6JHFvScmflb+QPtle+UQhq6Um+oKn4bSOhkC5hrFyRqEa6L9oRxgydaHparPQ6T
         u8JwBMuuhI8UUbXTMziqkhq05L6+k+7TCj2XK67KSZox4nyuhMtwddV4U2rBrf+nq7mk
         n4mg==
X-Forwarded-Encrypted: i=1; AJvYcCV3AzYt6kIYc37EPDNnYOQ2f7Z9woCcXVUVtK6l3w5e63TrahT3iH7QEDg0R+TM44XtHEjJQqK+idaKucR+YUKCxVrVj1nyRjn/99QP
X-Gm-Message-State: AOJu0YygYc7pFl2pfwQqjjG3M3Fpxu8p34mlp4ACR531Dgl4ljZGx4tt
	NDMa7fwi+LpQLD4MbfD5rpKPmxkfZTam+cQajETDvOPyyopo4juH7E1E57cFYYQsptJTfJ+yWH2
	pO2vkZXku+arkOUOsKym5+sohhV4hlUCh53Zi
X-Google-Smtp-Source: AGHT+IEAwSQtJNHUdRPQigq7uRt4SoNYYsQGSkn4XDCbOAfrLnsv+ih0U8e7xn81tFFxQq6aOGcjZ+3/+n3gowswxD8=
X-Received: by 2002:a5d:5d84:0:b0:371:7e73:eb43 with SMTP id
 ffacd0b85a97d-3717e73ec6emr2109262f8f.42.1723725304072; Thu, 15 Aug 2024
 05:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <Zr0GP0OXliPRqx4C@boqun-archlinux>
 <Zr1teqjuOHeeFO4Z@cassiopeiae> <CAH5fLgjvuE5uU00u4y+HyHTkQU_OBYvHe6NS5ohAhrLntTX1zQ@mail.gmail.com>
 <Zr31jqnA2b3qHK5l@cassiopeiae>
In-Reply-To: <Zr31jqnA2b3qHK5l@cassiopeiae>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 15 Aug 2024 14:34:50 +0200
Message-ID: <CAH5fLgjzNpeVVurPqVS=tMkKQOhXz08EsXRO4s9wYsNBuT6eVw@mail.gmail.com>
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
To: Danilo Krummrich <dakr@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 2:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Thu, Aug 15, 2024 at 11:20:32AM +0200, Alice Ryhl wrote:
> > On Thu, Aug 15, 2024 at 4:52=E2=80=AFAM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > On Wed, Aug 14, 2024 at 12:32:15PM -0700, Boqun Feng wrote:
> > > > Hi Danilo,
> > > >
> > > > I'm trying to put your series on rust-dev, but I hit a few conflict=
s due
> > > > to the conflict with `Box::drop_contents`, which has been in rust-d=
ev
> > > > for a while. And the conflict is not that trivial for me to resolve=
.
> > > > So just a head-up, that's a requirement for me to put it on rust-de=
v for
> > > > more tests from my end ;-)
> > >
> > > I rebased everything and you can fetch them from [1].
> > >
> > > I resolved the following conflicts:
> > >
> > >   - for `Box`, implement
> > >     - `drop_contents`
> > >     - `manually_drop_contents` [2]
> >
> > Not sure I like this name. It sounds like something that runs the
> > destructor, but it does the exact opposite.
>
> I thought it kinda makes sense, since it's analogous to `ManuallyDrop::ne=
w`.
>
> What about `Box::forget_contents` instead?

One option is `into_manually_drop`. This uses the convention of using
the `into_*` prefix for conversions that take ownership of the
original value.

Alice

