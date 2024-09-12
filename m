Return-Path: <linux-kernel+bounces-326416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1763D976816
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2E31F21D19
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7844919FA65;
	Thu, 12 Sep 2024 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMrVYY8x"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739D5589B;
	Thu, 12 Sep 2024 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141649; cv=none; b=RyD1lUlZJAIcIsuyJOD0F5b87o3e7oPDuestj10Rf/lh3AN+wRRhzFyuaiVrveM9rRJgsAu+IMErxIkHSURiAWhN1eKllKYrzqqllLfZnEhAtx12+EKeIh3hQbzwcu29Vf9nxk+aBm1gi+MPTTd0e0crlJCkJxt2sVtQq7HY2Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141649; c=relaxed/simple;
	bh=DoPU9J5Jl5AYQp0OVJkzTzPyYXQCxIaOFOrJsaSLxtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SByZ7RYqLmfRNW7OZxqwAmvbCZb2cczD4ArqGxnVqZRix0yfgz71cceCZZXS6luzKTSt/1ulJWQ9+8ULiJX+/64dvyHsImll+puXme5BXvllTj0Lx2XcWXWzPMwpc3nU5dBKoqX8Vqq/jgXBpbPB8LD73zo4ys/MGG/U0+QD7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMrVYY8x; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso559525b3a.3;
        Thu, 12 Sep 2024 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726141648; x=1726746448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlGX1wQ+EPavb5qKxM+JtmklDJ3AfV2aL+ZU8Eb5Qvk=;
        b=KMrVYY8x+OF0rrdmu+6WJXCXrAF+Fu4Xx49Yn6wrMDdFzVtUBoilGx5oNU2EDLNzVR
         ChJRQE9y0vUvoS72pys9XRhayksz8bUBZ5/qjuUBJb0fOwGWQiqMd4KvO5LAs7gJgMQQ
         8UJW6+T/LqSTcAUFA4icMVD0mLstyGRYhAJL1tBC86xPoPj56u6NjA1ohwdj4sibIPil
         TDML4XdEL24lX+tAyUeQZJxBKsX43fpa/HSDsHs3tO6Gz2Uul9NdGUOupIBxWLbJJcIf
         1MhuUHMKwGnf2eauvnr5RUotZw2PuM+nM7Afu+H3YPHhdQXZdvr/94p5TYBRodnOTC/S
         QrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726141648; x=1726746448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlGX1wQ+EPavb5qKxM+JtmklDJ3AfV2aL+ZU8Eb5Qvk=;
        b=gUX+Qxgz3DPtKWzGb/1zaQkMhFv2RNB6wN1o7tNI5ZLPKPhQ7DRYbG+2yhV1DCIRNm
         97D6+IxPv71nb8kqv0Si3UBDSmNDw2zFKJEzSD0NgDdXRF4eIJwqReHIYt2VsTLkCKvM
         luNtWA2y3qN1Da/NQmkwX2d9rY6WN1HSm04grek3Do/AToyVgWdrb3SkVAEcXYLHNd2t
         mE2CYGHUdDOXBXm35gBbLDmN016IWQhGXRfyjrHKzxyzgLHjLVYThkgzfMaw6MyYqJOs
         RZURHJHj2v7qleY9xhUPuj/SlnVKxd6KK7hzum/nrKUd8XffyQK4f169+BMvM/09vw2W
         ayBg==
X-Forwarded-Encrypted: i=1; AJvYcCXNwcJzzlNXRKQkjRSE7WKbB2bgRbyhaIGp45oS2XQ5dBP3ovn3m3QWSQ8Z/I0eZl8YkmZ3awnr1rjDP/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9rlNina+tz+9ISdZEowqb8J9LJSGbsSwazmcvkM5RgfCsRcdg
	80EoFSwyCgWIHPIsxzfnDTPqJY3d5pXiZisPvusj8Z2cYw108NcscRb6wbwQAYWbt6glb/O0L4U
	0CKnI0mDlWsVmpz8LgPOSLd5dlgg=
X-Google-Smtp-Source: AGHT+IHKClBCArdGUjX9Uzw/fHyKbDpXf50yAmXUxDURrj0MEnzOG4M/0atwkPeTiQk4LhpkiVXAKcfGfLgJEwtaEY0=
X-Received: by 2002:a05:6a21:3986:b0:1c1:61a9:de4a with SMTP id
 adf61e73a8af0-1cf75f0eb3dmr2852735637.24.1726141647861; Thu, 12 Sep 2024
 04:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
 <2024091253-bling-syndrome-da28@gregkh>
In-Reply-To: <2024091253-bling-syndrome-da28@gregkh>
From: Hridesh MG <hridesh699@gmail.com>
Date: Thu, 12 Sep 2024 17:16:50 +0530
Message-ID: <CALiyAon2Xx5CqOxL3L2TeiF3Xr6T12aMQ8L7ucJ=yABWF16phA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: kernel: clean up empty `///` lines
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Matt Gilbride <mattgilbride@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:43=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Sep 11, 2024 at 11:14:34PM +0530, Hridesh MG wrote:
> > From: hridesh <hridesh699@gmail.com>
> >
> > Remove unnecessary empty `///` lines in the rust docs.
> >
>
> This name needs to match your "From:" line, sorry.  Can you fix that up
> and send a v3 series?

Sorry, that was an oversight on my side. I'll wait a few days before
sending v3 in case there is more feedback.

--
Best Regards,
Hridesh

