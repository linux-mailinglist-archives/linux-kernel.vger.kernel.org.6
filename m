Return-Path: <linux-kernel+bounces-412662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB399D0C97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2079328257A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601B192B6F;
	Mon, 18 Nov 2024 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHQPUMY/"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25580191F74
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923477; cv=none; b=Zkn0Lt+AccAaOmS7QzYV0kr+9xj5epF7zr11NfZ+ZRbUXaCADUJja6syTGsi+XgO4yuDof2o+nRqO0veVeVlvkrzxSqxkh8F9s5eLhzDyEG6xrtK2xtEzIpK0ERT78xw5gQ7Z0OeVv1LnRTiB+4V5jYdnJ50E+zap6lVa9BxY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923477; c=relaxed/simple;
	bh=fs4ypAPmfdq2UW6IC9ptzKTs3zVBZiwuFcsDZgF7kSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyfvDU+9SEYRL3gEps5NXgIeNAP8N0okh3NjJ2Wm9eLhcL1p4h53zSG8jlhVhJiiJjgzFl+xccu8oVZr7GIzJP0mN7a9CCiyzihxxDgzE1mAYoPYSWYp86ZojPwC5q99ZrD/dmeir0pEy4F6x04Fr6rR+/ti7q4YG+p9xdidXjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHQPUMY/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3823e45339bso990604f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731923474; x=1732528274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1w3/EKU4DDNibR7p4Pm58BLCBS93+Vc73KiDAGwas4=;
        b=fHQPUMY/Oz3cBQi4wu1BnFC4bW4uKwyqMmmOiKWhIm+zvd8febxAbeddvP13bdrwem
         W8Mhg26/QwVfPFN4JoQE66/ZxKAEQ3JDhG7cu/ANxpJBgO8iAFg8K3pZ/clEnUEbBa82
         zXEQZQpqs3a4SH6eWhY525g2XdEzv/0nNm8tW+ceRjwVc546Ktmi3qJVFVBtREj+EHD6
         zoPdC6hA6R0lJ82+No9Cg45sE7WDhUYYckCJt4dXTCv314sEJmwsC4NjgWZNHQrk4O90
         /BljKEv8Ih7Xjpy/dnjGPN9KAkgLpKlSe7tKZ4tFY5CUYlfezI0iRv1zuGcx9swJvRZZ
         HwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731923474; x=1732528274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1w3/EKU4DDNibR7p4Pm58BLCBS93+Vc73KiDAGwas4=;
        b=FJddxYi0uutT0r3JWWePBUdAj4rIWorUGtKsrCz98HdyloBXUEv9A1PYKVId5xrWyu
         MNlHe0KxGOmnjUdDmfG4gG/UpZEfZpo/4foWVlAZbMEWWbmFWqOaL4xyZQAEqFUKTQbw
         1xtGdvzfRG4nHVm/fsBIktXa4JTEyHrGhfnAHV9nkaRZThgvVz8Q+k4+yOz0YciKAqQw
         jLoGbmE05cx3DUDyEJUSIylkMmbtqjva6R4h4byptrzRD3ynI7lhSc056fyb35tKxwGQ
         /Kb9iPLHLHKMgWZEVHDkztNdcxDOx/OkMvrlyaHNr7QK3eyFODdkiZWYVf2DKGeXwMXX
         kQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCXExhk9p4cJi32gSyzkJpd+yPo+OZjNuuJ0guFsExS6AWKIt3XtLdgS1JF2+PA2vR7tsIXFZYDtKDmGEVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhq3C2T5FVlKiX5tY6J6EdVXSOzTW/K75WjtjN+StdEkRSbRR
	Qw9QKjKsf27wvZSltqdiTwKFd7dtlCf5X3pbHnHWuWFf2Nntrisc/WmWGeK9Po2QuK+QQ3mga1o
	h6eX+CEkZS3C21sJ55HWDZh+YTQ9IvhGZD1ZO
X-Google-Smtp-Source: AGHT+IF/HxwlIp/P2WNiK3LFSeQ/hhPkxBPup/QUg6YJO/2lD9/YHMs8mef1h80THaOZxVMjUMY8PZOdqonMoI53F9w=
X-Received: by 2002:a05:6000:402c:b0:37d:50e1:b3d3 with SMTP id
 ffacd0b85a97d-38225905999mr8490191f8f.20.1731923474385; Mon, 18 Nov 2024
 01:51:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116181538.369355-1-ojeda@kernel.org>
In-Reply-To: <20241116181538.369355-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 18 Nov 2024 10:51:02 +0100
Message-ID: <CAH5fLgjU3BUU4nu6LscYKHTtZ8WSChXvf391v5v=xNK_2w7nrw@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `clippy::needless_lifetimes`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 7:16=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> In beta Clippy (i.e. Rust 1.83.0), the `needless_lifetimes` lint has
> been extended [1] to suggest eliding `impl` lifetimes, e.g.
>
>     error: the following explicit lifetimes could be elided: 'a
>     --> rust/kernel/list.rs:647:6
>         |
>     647 | impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator=
 for Iter<'a, T, ID> {}
>         |      ^^                                                        =
          ^^
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#needless_lifetimes
>         =3D note: `-D clippy::needless-lifetimes` implied by `-D warnings=
`
>         =3D help: to override `-D warnings` add `#[allow(clippy::needless=
_lifetimes)]`
>     help: elide the lifetimes
>         |
>     647 - impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator=
 for Iter<'a, T, ID> {}
>     647 + impl<T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator for=
 Iter<'_, T, ID> {}
>
> A possibility would have been to clean them -- the RFC patch [2] did
> this, while asking if we wanted these cleanups. There is an open issue
> [3] in Clippy about being able to differentiate some of the new cases,
> e.g. those that do not involve introducing `'_`. Thus it seems others
> feel similarly.
>
> Thus, for the time being, we decided to `allow` the lint.
>
> Link: https://github.com/rust-lang/rust-clippy/pull/13286 [1]
> Link: https://lore.kernel.org/rust-for-linux/20241012231300.397010-1-ojed=
a@kernel.org/ [2]
> Link: https://github.com/rust-lang/rust-clippy/issues/13514 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Does this need any backports to keep old kernels warning-free on new compil=
ers?

