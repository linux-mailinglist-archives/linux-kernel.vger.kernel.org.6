Return-Path: <linux-kernel+bounces-530859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08017A43964
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CD016A008
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4026137B;
	Tue, 25 Feb 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5XcvCDH"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFB4260A51
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475478; cv=none; b=VoxTF06oVa/YQHZqkHiAEMTEfPVeUOGOaF/iPfOMyOXroZpeOQIbuf55rUdtURMm+1OyQ3y0dl2j9Li1BqRMHf1ssIWOCxz15wY1wrTfvQsVC1D6IH8ACPlq/zM0J9ZfgnT7NB0fWfpv4ATJQPMQJ/vrVH7thYdcVJDjGvbl7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475478; c=relaxed/simple;
	bh=ZxiIxSccYcexTMgoVMyRSTYmi6kCr66px7UtyhRM/0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrNgq+7571XjYui+M+IdZKwcUNnt4SkJ390XCcFN0MKjT4M1H4pMsCaWVyTvx4F+rE6I1WkwByXK+k4M29hKS8yQFb1KHcn21BLx8TuAFrXJ2gpKrtrNWeeiFoKZWj0sdvX0kpzRuUBNi306G2Lv75plLNtfqVi7KyDnN8xmYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5XcvCDH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f325ddbc2so3878723f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740475475; x=1741080275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxiIxSccYcexTMgoVMyRSTYmi6kCr66px7UtyhRM/0E=;
        b=Y5XcvCDHhUN6wP/Or88y8pLdm+Ovk5Pw6CLGC1Qyd39u77j01hU/lacZJUHL71kkw2
         K7LIrXkoe7uIIZ2JhvwvqJNs66BpNGL2RD2u29VgBibJPsY/+FuIsK1k7wmwMZE2zKFQ
         HYyUkEt9Ms81hATP57YpXRw8NS3lTYur9ZlAVCIWN72eJP4yh1R3C1g5x6PuntPWEq0H
         7EgCDy5ofNCDp3eKUdJ1hQoCaEFCe7oA1aQm2DrbRtmZ6jl7auAMhmbZMwRpEmbmL1ab
         Z0+9Muxvj9ryygzGNltP7gaCgPxrjDBcsmvgplBBtakUZNvsb21+sqoovw7zE0+gcmXU
         72nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475475; x=1741080275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxiIxSccYcexTMgoVMyRSTYmi6kCr66px7UtyhRM/0E=;
        b=LFaOrDliNMH496ADBP6gGHfgAjhXEVIS/We9hCg07BoUOHHiPnq3ShcVSty3QdILVX
         p4NWRRe1zH6onQmC2UuEKOU8JeraGaDbVvEqjXd3yJSqPwYPgAG+tyvG1Wv7z7f0ASas
         QlcuhDtNQZNZJ0z2gBxNx53FAn3S/MMaBI9Hvm8A4bT38rsHBoIdnBXN1FEiEYBYgYR+
         tgiSKTIl3FcuzgRkAULDWIUUK0NqCEktO2zVnmbJnY16u308xbT7uQICCDPn7AZycVGI
         LiE7EcIxT50LWy68KhvyqF4TUhQyrc3QTmzfXKb+PGn6um22pnblDzsuYFD6QzfnJKuw
         5kuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUep1Qh3k1oOOvIqwA/affEYinq9RyABq1wu6qo/fa/5WZZIYL6Xb0eRWKONdJaiDdWiqSN3J0nbekFpOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Vgx0TuV1Vdi8DxwX+V1F3CB3GDwmVAM70CVaVagoXWacXq23
	qc1TAGTCKDC4OIqyhVc0YMFzVIatJZQtANsyY4Un63hwGb2L+4E0UVuWy1d2ApdB+FCLD/1dIgS
	ugt/aY1UeblSJFV1p+cd2QnicnoF0cN5yAtLb
X-Gm-Gg: ASbGncsdwpipmFU6WrDd0I3W39T9cAaWe9bm0LJ9/GiibV+/5ax2pUxIa65xR05bOlZ
	8H/UtwfUMunZ2Gc+O2Qve0uMgYQVGBmADZOc6HEGNoINwqdRiAKGZP2+2zcOEx48RBplrwn6VH6
	jw9gXSRoBmbwDTbhuzbOpPO0MGSuDySQp0AkzKYw==
X-Google-Smtp-Source: AGHT+IGQHSzoQSkPlTwNA0fxypnA/os2iIyhXnWMnuOEfnVFkcbcWJzo4J+RgQk5Yx7RRkNXXrVU9KuiyHJ1mGA4DK4=
X-Received: by 2002:a05:6000:1844:b0:386:3835:9fec with SMTP id
 ffacd0b85a97d-38f70826ea0mr15050496f8f.44.1740475475410; Tue, 25 Feb 2025
 01:24:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224233938.3158-1-yury.norov@gmail.com> <20250224233938.3158-2-yury.norov@gmail.com>
In-Reply-To: <20250224233938.3158-2-yury.norov@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 10:24:23 +0100
X-Gm-Features: AQ5f1Jommy2ub_3vQwqnVtD39tTTKNsZezOyKXgy7B1RbabnHE7_Zcs3Cv7hZ9A
Message-ID: <CAH5fLggk9tus1KmEw-Ox0buFLLhN0VajKCXYdxiFncjnbLGatg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add cpumask helpers
To: Yury Norov <yury.norov@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
	Erik Schilling <erik.schilling@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Jason Gunthorpe <jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:39=E2=80=AFAM Yury Norov <yury.norov@gmail.com> =
wrote:
>
> From: Viresh Kumar <viresh.kumar@linaro.org>
>
> In order to prepare for adding Rust abstractions for cpumask, add
> the required helpers for inline cpumask functions that cannot be
> called by rust code directly.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

