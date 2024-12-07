Return-Path: <linux-kernel+bounces-435833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634F9E7DBF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DB916D26A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16CB125D5;
	Sat,  7 Dec 2024 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI8U9Hx8"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0882CAB;
	Sat,  7 Dec 2024 01:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733535465; cv=none; b=YEm17We6ocW/ak/xpLvmrPrwmqBvMgRj8WmvuEdPxg9WbvWffrFbbuhJRbWx1FnriEySyq7VJdlFZtN2CtIViKc8a3mJ2HQJu1C08z8wOrhFTSA35i0u5l8HQuc/M9uWvY6yKisPylz/Mp1VP4yUi1jRTpn/LUpcOJVNf8fvMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733535465; c=relaxed/simple;
	bh=/0t6h5qZGBxEMwWnlGqKXSqLaAajCkGzTcCexy7o/9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGsMOuzBKqkkDp1Mu/9HG/sv2sUXi8ZwuzThwAyXxaUQqGd9rTG/Ejo5ROgGpbF6mpLEFhSwk2U9Xk4qiX5cSNU7Dgii9vu+ss2CPDuFIvCdcUq0GLiDntBy8aoIGcSBQnH+YmRC3I9+7wrVBPHF29JuDG04UWrIzfNbbhAqrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MI8U9Hx8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so2206288a12.0;
        Fri, 06 Dec 2024 17:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733535463; x=1734140263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imJSuHRPRBE6YfDMYMKrQ6pZ3Ojs7qrzBdRNSgqW+Uo=;
        b=MI8U9Hx8j0ao1qPPHlfKxH9GCm1YFCeRPGn70DCjsqmIRmJp66uTiX0Ic8EIB3a7BT
         B42Bs6ykN4I8qnLpvY0iHZ4KR3vCodQDlLOcCovyLndrHJs3vHHUvZ3zjsG1TxUQ9lXC
         AeBrGI8PXQNIPKPV3mhwztRjCRGhA7lKNNJYGDxPNANzVB7rwVKKLW1LwPPu/0lGL9N3
         XOnQKrWVOAIEJj7usJiuy/D+4iIgiga0VDmbNb51uTN4r66lTuATvkfPaFU2FF3yLFFn
         TBKnt1eWNlYYJXtBBcJF29MlSW4/pcMwoouVbMGmlVckBN3LQ/h/3fgVcsHcQ/ulecyf
         TE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733535463; x=1734140263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imJSuHRPRBE6YfDMYMKrQ6pZ3Ojs7qrzBdRNSgqW+Uo=;
        b=eqFC3s87M84g9PEyl/0ned0by7V+uQ0T5akxP12ERwHry06LmFT1hCrFQRY9r1DGnR
         PAK+xWgV9vzeEsTpjxNc1ISiBSeq1RgrlwHRrkFZZ04s8Ly0vZSoFR5L/p7puvK7vRe5
         PhRhAwTTxNYSPMnuaC3FwWl+ift+eB/tUThkWQ8VJlUTQVd4BoDChSNc8jg1iZf3jzRf
         BVs/4sYV70Jgo3zN8ivWGOfhf9VY0w4pY9f086PsxtnwIc0XEdjxs0zfjvJU9t1yw40J
         QZnJzxFLXyq8Q8LBddAa1bI8A4/hnGM5opHGhaT5k6UYX+ZCa3kLoOQc1pKDqfP+5ZJ9
         3nCw==
X-Forwarded-Encrypted: i=1; AJvYcCVrsCP3X4aeQp+BBk4+ZgZSbv2AuIC5qVAHoCtKQ591aOV0pTFuRk8YL27HNHIJWMZ/nVpoUI9K4KQ/f3RSXOQ=@vger.kernel.org, AJvYcCXgSs3sfR71IqCcTearlNCHbY1LscJpaAp8lCkFIFPXO6t6b9XWiXEmivAO7KbrQfPDZZ1fQTWQ7gw6Knc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFvMBWPW2RiWtd1Xtp0jzeZ773XeluXSQMYrUGNNnozfLxyB6
	awFzFTSqJzth8f98lvOXDwFpcal+doyKmWfzfqX94OLOrLK8aGpbhX+Dk0G3
X-Gm-Gg: ASbGncs4yIKbF3meDDz3BDAh3hL4ZN/OmvjorMqpmUKhVpFCuHWvLRU71iV0CHouEWt
	sIm3TQOAP3l4lVhExRgo60G1C6lGhYpK2l828w4YkYuDduZJm2akHmKYvvEWghKbb7RMMl0Ww3c
	W/SVDwnpVpE0nn6II0pSF1Dr0raeEHFa6cphV5GzfNl4n0BfnvIPn+RJLzVvEqCbXtEBNVDF2ky
	5y0me1C5n0MJRGG90GRuNfHKoABosPZk/hAHl6gXxSwOe6Xm5/MkhE3HhCVSCKmLo8661DIh+WO
	XYuxEYxOGx18oqP0UCyIheZ9s0Va
X-Google-Smtp-Source: AGHT+IG7baZNA4xPcAkDMuxW5yrTyC0HKpWTfswaF6d4+BjwR69ntaEyFjfdn2T9mHWiPOz4suawqw==
X-Received: by 2002:a05:6a21:1349:b0:1db:f0af:2277 with SMTP id adf61e73a8af0-1e187141ac3mr7275533637.38.1733535462606;
        Fri, 06 Dec 2024 17:37:42 -0800 (PST)
Received: from lordgoatius.clients.willamette.edu ([158.104.202.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ceb7c02dsm254032b3a.136.2024.12.06.17.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 17:37:42 -0800 (PST)
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
Date: Fri,  6 Dec 2024 17:37:38 -0800
Message-ID: <20241207013741.351172-1-jtostler1@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <Z1LYjiwaE8iDPj3H@pollux>
References: <Z1LYjiwaE8iDPj3H@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Dec 6, 2024 at 2:57 AM Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Thu, Dec 05, 2024 at 03:04:28PM -0800, Jimmy Ostler wrote:
> > On Thu, Dec 5, 2024 at 3:35 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > > Hi Jimmy,
> > >
> > > Thanks for the patch!
> > >
> > > On Thu, Dec 05, 2024 at 02:56:27AM -0800, Jimmy Ostler wrote:
> > > > Add a rustdoc example and Kunit test to the `ArrayLayout` struct's
> > > > `ArrayLayout::new()` function.
> > > >
> > > > Add an implementation of `From<LayoutError> for Error` for the
> > > > `kernel::alloc::LayoutError`. This is necessary for the new test to
> > > > compile.
> > >
> > > Please split this into a separate patch.
> >
> > Got it, the next version will be split into separate patches.
> >
> > > > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > > > index 52c502432447..ac8526140d7a 100644
> > > > --- a/rust/kernel/error.rs
> > > > +++ b/rust/kernel/error.rs
> > > > @@ -4,9 +4,10 @@
> > > >  //!
> > > >  //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
> > > >
> > > > -use crate::{alloc::AllocError, str::CStr};
> > > > -
> > > > -use core::alloc::LayoutError;
> > > > +use crate::{
> > > > +    alloc::{layout::LayoutError, AllocError},
> > > > +    str::CStr,
> > > > +};
> > >
> > > I think this part of the change would be enough, since we don't make use of the
> > > `From` implementation of `core::alloc::LayoutError` anywhere.
> > >
> > > I think we can add it (again), once it's needed.
> >
> > Okay, that makes sense. It is still used in the documentation for the
> > macro `stack_try_pin_init`, and it is hidden and not used as a test, but
> > it would probably be prudent to change that for consistency, as
> > `Box::new` no longer returns `core::alloc::AllocError`.
>
> It seems you're confusing `LayoutError` and `AllocError` here.
>
> This is about the former. But you're right that `AllocError` can be fixed up in
> a few places too.

Oops, you're totally right, I noticed it when grepping through error 
types in documentation, and mixed them up.

> Do you plan to send a patch for this as well?

Yes, I've already got a fix for that locally.

> > I can add that into the v3 patchset, unless there's some reason we
> > should leave it.
> >
> > > >
> > > >  use core::fmt;
> > > >  use core::num::NonZeroI32;
> > > > @@ -223,6 +224,12 @@ fn from(_: LayoutError) -> Error {
> > > >      }
> > > >  }
> > > >
> > > > +impl From<core::alloc::LayoutError> for Error {
> > > > +    fn from(_: core::alloc::LayoutError) -> Error {
> > > > +        code::ENOMEM
> > > > +    }
> > > > +}
> > > > +
> > > >  impl From<core::fmt::Error> for Error {
> > > >      fn from(_: core::fmt::Error) -> Error {
> > > >          code::EINVAL
> > > >
> > > > base-commit: 1dc707e647bc919834eff9636c8d00b78c782545
> > > > --
> > > > 2.47.1
> > > >
> >
> > Thanks!
> >
> > Jimmy Ostler

