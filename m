Return-Path: <linux-kernel+bounces-183274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699E58C96B8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 23:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E60B20A2A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA7F6E61E;
	Sun, 19 May 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MoZtzqpf"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E515491
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716153395; cv=none; b=MWVq/w+ULoAcS+0LON8TffYBeQ2jDAbsr/TpqbuQP1TcN0HG4Z8VXo3j5S0nivszXJPraC8kVyWCVz0CFOc7HiIyHPioAJSYw9xULPkg4JXFusoHZMwoOM9AcsMN7SosVZUkQYrHvpG8aWV498xRWnOJDW8Ozk/JAvuaV/rq3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716153395; c=relaxed/simple;
	bh=aepYcjZoe1VltFPIAkhmsPx3W+z0i3qcRSlTsZdDdn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1WRdLiF8La0IwZbiK9E+Pe8Q+x1ZlRnce0sx+Wxlmj7u6XeIT3tAIk4s7/64/tU0jaRrBl4hjhA6Xj+Aikas3uK26Av7xwA1Ejj/CdeAeePnOPzXKyz8zztV97ofXPKRUeESNcGXV6u6wbv2bof5a35A90Tve7jNmGpBBYMAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MoZtzqpf; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de8b66d1726so1321326276.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716153392; x=1716758192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aepYcjZoe1VltFPIAkhmsPx3W+z0i3qcRSlTsZdDdn8=;
        b=MoZtzqpfixF+7cdaaXVyiaK7tJUR1oO/CzN4Vv1V4Gbr2/3g/s9akEo1Y/uXyh1/Ir
         1PXijxtlI54UevJFw6jZy99ZevEPSMzMkXWEOpmWtfbhXSIfz1jYmipHZ07CdgYKEx+J
         non5EQ+Yla0qIabmfSML6LLa6ew8W3XL33F5X4atQvILoqfTEmYpYAHzxYFu8I3w4s0k
         O0pRiOf17gNKDhbdTBoOsJ+apjkxL/T+INGka1rWC17AWTzZ8WJXIAy1MVAq5CZsuezo
         gsm4RNIKMDp8djpN/kfrMVJW8Z24jPvqIjYeA4VD80ZA3VtydCit9SL9supAHn7yZtZ6
         XmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716153392; x=1716758192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aepYcjZoe1VltFPIAkhmsPx3W+z0i3qcRSlTsZdDdn8=;
        b=hh6bksi91DuPSlMuY3ZlotWXqoka5EaKm7EM2nsjHCXrQ4osnqXAN5irN4OvJ0ZPYG
         0O8qptjk5pKYVqQUY+Y95+hH+nolnY0I7m8lKbC4a6ZhDUwbYsNRs4fy80o9+s50lo0i
         r43639+2YO2lmQbdYiLPa89nkdJqDpmJU/K3yLgW0kKDxSLtaTJu0dXFosTHyXxm2i+u
         7YVVU9t4RCVwRiO+wg9QbmdQXFqnn/inubLQ1G+dM+L1pYCLDauAQ1R/n1DXoef5Vn9k
         VTG9hnTaAi9O/S8WEwtCok54sn93G5R21PyF6u14bLbVxGZ7XTTN12pVlcWK18UgoYU9
         I+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWD/fRkD5hOeTLVbW5D4MhF/YahS7JaaXAPI0+Mrr/5FkFyjp1Qcv4HXn/q7/qiQsKnJXfFBFrqFbdBj692BJtEsqTVxCJ0xiMAdd8x
X-Gm-Message-State: AOJu0YxWMQr8G0QZTmKudbjhgjOJy/4Aeg5Fyqag+c0rh1DJgZuAlHmV
	Y+94Q522Jc9q7crsEVzmx4Dac23XWIpacjOxdUmbUiK0J+fTcYI5YRfv6cT4NKVrGwojnM9GP8Z
	1X5j+UO9a4ZTqXKDzCS8/h0LwdHJk3va7V0Ju
X-Google-Smtp-Source: AGHT+IE69gHLeUIav2qwSBHMXCXDWEAkZ0MCjYZT0jU6CvB7u6z5f78gziAFXfnbpZDqnwxL4OABn3LeV4aQD7rNGBg=
X-Received: by 2002:a25:5103:0:b0:dd1:6cad:8fd3 with SMTP id
 3f1490d57ef6-df49062935bmr3300167276.27.1716153392254; Sun, 19 May 2024
 14:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517192239.9285edd85f8ef893bb508a61@linux-foundation.org>
 <CAHk-=whEAquncw0wb59-XVAHmVh4CWSfwuWh4bTJjJzvx0=PzQ@mail.gmail.com>
 <CAHk-=whSiUg7dggHaBLULuF6_GB6NORLDByog0p=Qo+0ewmZSA@mail.gmail.com> <5qcafqbnrox7r5m4kghgykahtp2pusmhwfxqzrmhgvavxxsdux@ao2tce7nppey>
In-Reply-To: <5qcafqbnrox7r5m4kghgykahtp2pusmhwfxqzrmhgvavxxsdux@ao2tce7nppey>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 19 May 2024 14:16:21 -0700
Message-ID: <CAJuCfpHA1TA0DqO31yVW18uPVh8zXMHyvxxokyBV4vFqt4-q1Q@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.10-rc1
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 11:02=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Sun, May 19, 2024 at 09:48:49AM -0700, Linus Torvalds wrote:
> > On Sun, 19 May 2024 at 08:32, Linus Torvalds
> > <torvalds@linuxfoundation.org> wrote:
> > >
> > > I'm going to take this pull and fix up the cases I find, but I'm not
> > > happy with this kind of trivial C preprocessor misuse.
> >
> > I did some other maco handling cleanup too and tried to regularize
> > some of this all, and it seems to work for me. But somebody should
> > double-check, and it's possible these patterns should all be
> > regularized further with a few helper macros for the whole "add
> > __GFP_ZERO to argument list" or similar.
>
> I just double checked slab.h, gfp.h and percpu.h, and scanned through
> the diff vs. 6.9 for include/linux/ - looks like you got everything.

Sorry about that. Yeah, I could not find any other place that was not
fixed. Thanks for noticing and fixing them!

>
> I think we can slim down the API surface of slab.h some more too, we're
> now exposing three different ways of saying "trace/track this allocation
> here": _trace, _track_caller and _noprof vs. normal; I think after a
> cycle we can see if the old variants are still needed or can be
> consolidated somehow.
>

