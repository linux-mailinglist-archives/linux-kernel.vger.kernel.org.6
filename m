Return-Path: <linux-kernel+bounces-434057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0969C9E6104
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56D7284A09
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F81CD210;
	Thu,  5 Dec 2024 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnGk+L0Z"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCF2391A4;
	Thu,  5 Dec 2024 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733439873; cv=none; b=Jvp0uyKQOqlcE6CREqM0LgEEBeb57miWGRpHLkyFrN67FKXh4ZCNhDmOD5aMvvEIuoh7SXGAQzBiKEPxGyBM4aKi02PuBFHCOUV1OseTvpYVCHHLfYd2trYxBLkdbcebeKmvxlAF+kwrp1AA2n5QPBPNevigHT271w8YkvghELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733439873; c=relaxed/simple;
	bh=NqRfQnJ8NseIxJih8xjqHZE2EWRV0oCFy++m6vdIF54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klvjWBKDEKO+D9isfL0cI0MriYcgMz6lqfZ2fMeQggaKn6k1kk5/P4l5+C1N5cKY2iaPQjvNUThm4EqgKAMF8y5wUtcvLjb4iqLxYbd4d8BtWO7W+m5uVBM22DMq5GDkVqv80h8GwsUzppFQ29vNJiy1kZ1xBjGGz1LmVSg4VHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnGk+L0Z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215810fff52so16432195ad.1;
        Thu, 05 Dec 2024 15:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733439871; x=1734044671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfnnK6FXYg/qy9mIs+KMEtQ8Bd6tbHFrPnoD1wsO8h8=;
        b=AnGk+L0Zzk86zpxuE0rTFH5zNbGfN+Mm3PdAucZPo+/6NVOWTTAFzf79XR2qLVZ7r2
         iNjHCqC4kZ0Dm0+56St4f9j73TpIzNWmq5F6ObSLbEfO3Lpt2rJenYXymwtCbKeFU9Yk
         87a2TaeQ1lXcDCCxSvvzLSRfdm2Pufx1yANjCSZr2r/xKa6RKECKi7rDvTus6eepne5v
         1NpeUNlakwKJkqNKufhLtV+f4qKExRboTpDjXOZYanoaAtjXc5c3TvCWLeJRJi1r5m0E
         HtwAQ85k1HHr1m2UQe8RJ6ogOvYW/izrMEiJlSPh3DsHKSdPeKGm6C3wGXgRDhc0gnPZ
         Jpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733439871; x=1734044671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfnnK6FXYg/qy9mIs+KMEtQ8Bd6tbHFrPnoD1wsO8h8=;
        b=Ad1nMrhV9zE4R28jJm3dzearczPhIurp2tBhdcjhQAFdLYelM1Jd3muVJtgPQG2KKE
         bbrYXeULWkWm63VFzckz9GoXpSed1DrhfAZigGoZrFnp7AiTx4g9tq4JFXm5yY+Bg/iP
         4L6XUpPLuQYe1jzLaHn2W9WEvGzxSJpdPLtCzs2Pv57EziBBtvQ4wC1SvauepoyxCJdX
         W/BciqnRixhykO72mMwnbDEYmdRbTTsCCt/Dmmlb2M7qx80R/dSYuNfwvSBJNk3CtT+x
         V59k53rAAk8w3f4uCz1/fDm9UG8xIkYFVq3Ahi8qrInFmHHw+01VI1fiCBjRhTelHkUX
         zFmw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2i8Ny56DF2Th8biKuaRlaXYb4yxfZ3/uSxIv4h0j6t6GMEOPJiBCPnwJDNkQ4yYGFJnOgHeHFXgPWVw=@vger.kernel.org, AJvYcCV782MnW04fVN8lkZ4angoABqjDjwCzNxM8XQ88/oXoixTepAK2/Cc6R4ypboIZLBH6MUAUK2BJLoQoDQuixSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRbuJcFjwdFEfsgZK04sNQRtz/Z8YiL2TzY/Glnjfy7tV35W9W
	HHAFCVZz0wHw+OpnInPSsmk6IUswh0hbrZXOXYkbW7niRhdwDM4F
X-Gm-Gg: ASbGncsyQLpJ4RPsaUweBP+QkSJADYANyZIzYvPCtfE5Cpoek9LfWiy+Zl760zqDcPO
	SG+yROY/zFtRRJ+KbmhtqFRWbCYJ3GqeqKCrItIknfTMhEmkzqW5yusPDdU8SfzIv1E19pimpTN
	gGWHnD7HDhziyaJpujLVRVmghTJrfm4kUPD7wm49IEHLk0ORAA4FIo8wlvBhbXPM6Y0IRqPqdls
	NO1XPfzEQ6MD1/J7Hf3yin1VeQK1BDAglyg3CK2bYHDTX657vYhEEYzk95ai4vpvM4qEgQGja/+
	tZoLP+InjKyANiipgF2Oo4FSeEWz
X-Google-Smtp-Source: AGHT+IEsakUw0ubSv2TrZXEbyQKDtDptyZcJZmSD7shDlQS0bnFN0B3KAUfBHZhotYpYkFfXy2h+eg==
X-Received: by 2002:a17:902:e552:b0:215:6e01:ad19 with SMTP id d9443c01a7336-21614d54c1fmr10416885ad.29.1733439871124;
        Thu, 05 Dec 2024 15:04:31 -0800 (PST)
Received: from lordgoatius.clients.willamette.edu ([158.104.202.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a8f474sm1756224b3a.97.2024.12.05.15.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:04:30 -0800 (PST)
From: Jimmy Ostler <jtostler1@gmail.com>
To: dakr@kernel.org
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	felipe_life@live.com,
	gary@garyguo.net,
	jtostler1@gmail.com,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v2] rust: alloc: Add doctest for `ArrayLayout`
Date: Thu,  5 Dec 2024 15:04:28 -0800
Message-ID: <20241205230429.1067406-1-jtostler1@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <Z1GP-QPDFDjS6qLo@cassiopeiae>
References: <Z1GP-QPDFDjS6qLo@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Dec 5, 2024 at 3:35 AM Danilo Krummrich <dakr@kernel.org> wrote:

> Hi Jimmy,
>
> Thanks for the patch!
>
> On Thu, Dec 05, 2024 at 02:56:27AM -0800, Jimmy Ostler wrote:
> > Add a rustdoc example and Kunit test to the `ArrayLayout` struct's
> > `ArrayLayout::new()` function.
> >
> > Add an implementation of `From<LayoutError> for Error` for the
> > `kernel::alloc::LayoutError`. This is necessary for the new test to
> > compile.
>
> Please split this into a separate patch.

Got it, the next version will be split into separate patches.

> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index 52c502432447..ac8526140d7a 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -4,9 +4,10 @@
> >  //!
> >  //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
> > 
> > -use crate::{alloc::AllocError, str::CStr};
> > -
> > -use core::alloc::LayoutError;
> > +use crate::{
> > +    alloc::{layout::LayoutError, AllocError},
> > +    str::CStr,
> > +};
>
> I think this part of the change would be enough, since we don't make use of the
> `From` implementation of `core::alloc::LayoutError` anywhere.
>
> I think we can add it (again), once it's needed.

Okay, that makes sense. It is still used in the documentation for the
macro `stack_try_pin_init`, and it is hidden and not used as a test, but
it would probably be prudent to change that for consistency, as
`Box::new` no longer returns `core::alloc::AllocError`.
I can add that into the v3 patchset, unless there's some reason we
should leave it.

> > 
> >  use core::fmt;
> >  use core::num::NonZeroI32;
> > @@ -223,6 +224,12 @@ fn from(_: LayoutError) -> Error {
> >      }
> >  }
> > 
> > +impl From<core::alloc::LayoutError> for Error {
> > +    fn from(_: core::alloc::LayoutError) -> Error {
> > +        code::ENOMEM
> > +    }
> > +}
> > +
> >  impl From<core::fmt::Error> for Error {
> >      fn from(_: core::fmt::Error) -> Error {
> >          code::EINVAL
> >
> > base-commit: 1dc707e647bc919834eff9636c8d00b78c782545
> > --
> > 2.47.1
> >

Thanks!

Jimmy Ostler

