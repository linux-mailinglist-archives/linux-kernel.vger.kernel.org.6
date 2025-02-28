Return-Path: <linux-kernel+bounces-538988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A378A49F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA68A176058
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA411F0999;
	Fri, 28 Feb 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ0dTKgB"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E42B1F0998;
	Fri, 28 Feb 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761749; cv=none; b=A3z4j80zP0zTUz+QgURT2Jc7W7cKZG+VMEyoZZfW3FQ6bJvhvcpu1SWKj+Ncj10xEuFSJfkbHWGZ5A/+T7T2arVDgp/4li3Z082Vt1LqykX8nhM8jkAMK2a8wfVB4QRuXTn9GqKwAjBTIFBtoZBVCmF1VSiiUQesMI09/vN46u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761749; c=relaxed/simple;
	bh=l7KZuIe+/PpHGK1hr6UrivshbMWc8k7QytvCDj/OM0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaL9t19prAXb7vQas+zqhWBH3YLwlvz927EeLOOjHzWQT5cIN//OplkhjtSQN649kRr9fQfozX0HPB/fS22RpqzH5OS+o0GKkaVUlKD5UZWQT10GSryviZ+t2EMj/5t1pY0aWW6zc27sPGJoVtGNQknZlFnRDaTmcPAlZm+UJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ0dTKgB; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2bcca6aae0bso1585814fac.1;
        Fri, 28 Feb 2025 08:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740761747; x=1741366547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEW04ehe3qfLrS+uB2nI+HT5OespyuID5SMO2AaGFxs=;
        b=HZ0dTKgB6Y09WSdvUDGosMhQvVsUrUu2LRaSFaZLcMiONaVbIXEho8CnnSJ8+vBYqF
         aNXC/7SD/vqKR+kL8kA20Cbs3IgD9WtZaR0/zOmezRbrvoKPHOOotbRhqMnqvTJYZtV8
         j1GLlw4I5GaEfokctFvgqlcbKPENq2ZDfxjUQMtOZhf67aOmT9ApV6yTP/m2MUeCgyaQ
         O08KNPMNdo268Flv8ZX0j+YD2XwtzkbkskVAc9oQwFbrglDp/Zveg89bhidlvgcP3d5G
         M1Xk+lv++VpcrRt6S7tXs0kB0JWEPvW+QdrTi1ozpcfE0QnrZBexq2htZMzZ24vskx5Q
         tr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761747; x=1741366547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEW04ehe3qfLrS+uB2nI+HT5OespyuID5SMO2AaGFxs=;
        b=bpWxvZTrmTTwXPLIgq3wrmpq7rgPWCz3VPPlnP+yJBbvT9P5CL9phBoWeO1Yc6YMUq
         xevYFp04I+gHHdV/P/WhzBjC7KIOJvbfuHa9Z6MMatoT80iuGxTb/k0jsQ4OxU6Z3dG6
         Y1nUvyhw8zBQ+UzXSZsBCdT9WEj8zkcMKeyIL9yN2jy6i8a/yKbQzqJtIGq1qp3SdDGT
         cSO+OVTSeqUWCHObhg376wfcUJU7ySBblkZLUDTZc/yPnNwn5xmBNRsZM5ErO6s9pDuS
         idL5GAdAI+2StRgPR+NFPzaosWMLOTnAxM6/VIDn2xye2bRcWjYeTz+F/Tzj2RoOYtHG
         RIKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY8yr+VPAY/tYz80fxyPGTwLDT1Cb7dCItLvttSHQvU45VZ955Df0evSGKJct8AJ3tmPrcqdJWTUy78jc3iuw=@vger.kernel.org, AJvYcCXwqC6kQNsVgLCWeBxs5tsk0H1b4qMl2YXzPXYw1PykUpXlkx8UymJ5PHDi/JeJlT/xUUvL41uErSzsO7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ocb2bDWodKF62Ydv/MSVu7oaU3YhDnjPCYlaeNQXSzX70JQv
	hFGKGCu8L9J9H+88G5blKN/onKEvE3n/X4I2VOX2ozS+nuf10EcAmBerB/edMBkBvUFOpa+sKpG
	FwQi6ZRPND9IEUxRT6Wp17ZoJLxufI3dK1aA=
X-Gm-Gg: ASbGncsWiBhTEyN26hUYMFahUsmzz0dsfyOVngiRfFF8cRy1yeRSchX2Yj+S6fnnxSu
	XXMDSyJcEjAuy9H1osodS1l0wwmqDj+FMomo6w8vkTti9oecHn3ngeEqcD/gfdeI6v2MO6Ow0rZ
	r+Qj4y8Ec=
X-Google-Smtp-Source: AGHT+IHD4ihvG21m3iZVkr5wRrpw1riQryGYd2M1eN6+ZIwjs1g3PVl9FY3VmGlOwC8zrr8bHf9VDcXZ7P80N0hAhOU=
X-Received: by 2002:a05:6871:d10d:b0:296:a1fc:91b5 with SMTP id
 586e51a60fabf-2c178341172mr2590380fac.8.1740761747285; Fri, 28 Feb 2025
 08:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228132928.880683-1-guillaume1.gomez@gmail.com>
 <CANiq72mENfqG6iNjgXpq4LVEceZ4174yGhg-RB0MsMxLVed-1A@mail.gmail.com>
 <CAAOQCfSEUnp8U3+6amWCd6+yPrAmPy6gsjJnQdrqmpER5md3kA@mail.gmail.com> <CANiq72=UrE5fv1Ymt-2NRzzKo2xk=tXLwvLaC4fo+vhJC0edNw@mail.gmail.com>
In-Reply-To: <CANiq72=UrE5fv1Ymt-2NRzzKo2xk=tXLwvLaC4fo+vhJC0edNw@mail.gmail.com>
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
Date: Fri, 28 Feb 2025 17:55:36 +0100
X-Gm-Features: AQ5f1Jpxy4oWYP_PxFMaOJFRlEV0Xrm6sDVxNzXJGf-pe8EGj-XfHX5FIB2Tvmg
Message-ID: <CAAOQCfSZ=HGWjeN-3fotNJpW35iqzm0A_3rxs=BdpULmLyrs2w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use new `--output-format=doctest` rustdoc command
 line flag to improve doctest handling.
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> That would still force us to have all the "hardcoded knowledge" about
> the `rustdoc` output (apart from the JSON schema), right?

That reduces it, but doesn't solve the problem completely. The second part
is more tricky.

> i.e. my idea was to try to see if we could avoid matching on "strings"
> as much as possible, and trying to have enough metadata (properly
> encoded in the JSON somehow), so that we need to avoid searching for
> e.g. `main()` etc.; and instead generate everything else needed on our
> side, customized for the kernel case.

I think in this case, the only issue is that we're calling `_inner().unwrap=
()`
right? So we could go around this issue by not generating this code
directly in the doctest output and instead add a new field:

* return_result_fn_name: Contains the name of the wrapping function
  returning the `Result` type. If this field is present, it means that the
  doctest is returning a `Result` and that we need to add in the code:
  `assert!({return_result_fn_name}.is_ok())`.

But even that is tricky because it's part of another block (`{}`) so the us=
ers
would need to add an extra `}` after the call. Anyway, I think it'll need t=
o
be discussed more in details in another discussion on how to best
implement it for both sides.

Le ven. 28 f=C3=A9vr. 2025 =C3=A0 17:48, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> a =C3=A9crit :
>
> On Fri, Feb 28, 2025 at 5:32=E2=80=AFPM Guillaume Gomez
> <guillaume1.gomez@gmail.com> wrote:
> >
> > I'll definitely need some help here. I'm not sure current stable alread=
y
> > has this change so until then, we'll need a beta/nightly version to run
> > these tests.
>
> Yeah, we will need to wait until the "final" version of the flag is in
> a stable version (the flag would not need to be "stable" itself, nor
> the compiler released, but yeah, we need to know the version).
>
> > I opened https://github.com/rust-lang/rust/pull/137807 to resolve
> > this problem.
>
> Thanks!
>
> That would still force us to have all the "hardcoded knowledge" about
> the `rustdoc` output (apart from the JSON schema), right?
>
> i.e. my idea was to try to see if we could avoid matching on "strings"
> as much as possible, and trying to have enough metadata (properly
> encoded in the JSON somehow), so that we need to avoid searching for
> e.g. `main()` etc.; and instead generate everything else needed on our
> side, customized for the kernel case.
>
> > I don't think `expect` would work in any of the cases in this file. Wha=
t I suggest
> > is to add methods on `JsonValue` in a future patch which would allow to=
 reduce
> > code in this file (and call `expect` too).
>
> Yeah, sorry, when I saw the `Some(...) ... else panic!` I replied too
> quickly -- in this case, I don't think it matters to have a custom
> error for the "wrong JSON type" case as we discussed offline since
> nobody should be seeing the error to begin with, so it is fine.
>
> Cheers,
> Miguel

