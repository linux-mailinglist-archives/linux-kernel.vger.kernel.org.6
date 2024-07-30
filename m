Return-Path: <linux-kernel+bounces-267784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C11941568
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65DCB25418
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C2B1A38C4;
	Tue, 30 Jul 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNdZ2l+Q"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D529A2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353094; cv=none; b=PQ7zJ+8hMD0C6gp3qPTp6ZkGmEwsrw2BKuB/IeC69Ptix8/bH+HoGp6u4CTuEoF1oF6Xtv0eKwWcmcfycVSIusSG2mBCX0iARpe+tSd2HYXslzsznytpYYsL7nAmYv2m0UeVcUTaCx1EaOes0swqWuFvMpQ/QV5SO8MfVlVxbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353094; c=relaxed/simple;
	bh=E8nY+pHNFj9D8pwHCFKbu/ijSROQst+YbZBSOdpMZyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auughNQS+NIiD2zE6Bih8Ty6/M9Aie+fjKQRTBJV9OJwwrtj2/wbEkRxEFmLlq0k2qN7K2pUVz6GvMDWlMcmM7CCvsXrXF+8fUR4nEfqtPS16jEAXMytxd9UvhTZEB7Qhd9u4z0z5dEYVYW1oltbCEJnS4QttintXALMHocoli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MNdZ2l+Q; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-49299323d71so1181274137.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722353092; x=1722957892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8nY+pHNFj9D8pwHCFKbu/ijSROQst+YbZBSOdpMZyM=;
        b=MNdZ2l+Q4AdUSxfF9OoIvo0ieqPRa/q4SrfZFQ17cwaEckVKWbeJZuEKUnGcyv9S22
         qqXtf3llOHuNy26LoFFvEJVSaButALFs1LkyO636fGqVsAdLoTDpWaMwDdRXTnvGyzZj
         VSd/GggKrtf6tZ1yFXe1JBHsmIPOBa2NLVXuIjSIz+OTvFwi9W0C1zjRoYywjNDx2dlr
         dR6qCTyMH0v/Tycp6UFSEL5lePh2w0kDR8KUe3e+FHfu6l3/X7Sq2e8WeWDGD3CNgV4o
         sCcmFq1IsGfPEccOUYsrhSFDppO6OUy869WS3Ckc8ogUmzckpvTGexW4F4A3sPnslfKv
         deig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722353092; x=1722957892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8nY+pHNFj9D8pwHCFKbu/ijSROQst+YbZBSOdpMZyM=;
        b=WItIJS0HnvSyUe5gyyfDk/BIV2vu0jDAyXgGyRtVXBQBTxm9MxJTRP/ZJfOBxnToS4
         H/KwqJJNn6yOKT5YnGtbicjBA1cnzhrNfpxMY9pr3l2/ECCpMhfLDHFSuviIQ11/vknE
         G6/EC/FWZwcBru0GQiWcxJeog1Zrj7t+p0HhKFMRWHV5SeoJA/7wMtQpuYowc5+3rAz6
         ovgCgnyR7qXVOxLpgBzL95ohPLcFZ1eao6wO8npzyajR8mXO5zekAjhxqbGO/RAOsHTh
         L0G16FmDyob0vDTymsv+NQxngkbSDBiwpgmYH8hVwpLEMxNNUb0TjRh2koqXRZa0awQH
         P82A==
X-Forwarded-Encrypted: i=1; AJvYcCVDrTPK0MOhnWbN80p63h2l65MybLSn4OVcpPI4mQtlrYWerPY5oIWcoZBQNY9vWF2TPEQU2CZG+OVk8ZEli/4cUZtDLtdJt98XnhGX
X-Gm-Message-State: AOJu0YzBdwaXJDwciPYL/aNhfhu4SBdLlwJEmILEvHIBUpT5XBr83rTT
	cEk4z4CMFn05yGMMKGgpis7AdOtpZPJkghv831EM4kbQGhf43Z+ZbmBsDKlJFY6X5Vy1uCAbi1l
	nNvwrwCF3Kd2Y2JHP9k5IplWC2q3PqgmQNmLt
X-Google-Smtp-Source: AGHT+IGWZrBHsTNI4EkRkhI8Ci3ZbFoE87iB5xIfey9XkQ8XzTovCnYBXiW5sf7so5OIxkQsEATE0jbmLUe1vkF0BQc=
X-Received: by 2002:a05:6102:c8c:b0:493:d3c6:a59c with SMTP id
 ada2fe7eead31-493fa437516mr15063344137.23.1722353091682; Tue, 30 Jul 2024
 08:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kcfi-v1-0-bbb948752a30@google.com> <20240730-kcfi-v1-2-bbb948752a30@google.com>
 <20240730103236.GK33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240730103236.GK33588@noisy.programming.kicks-ass.net>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 30 Jul 2024 08:24:15 -0700
Message-ID: <CABCJKuf+=bxrZphtFZ+N_t2whCS0gx2GVHybTzcNmY6TX6c7cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: cfi: add support for CFI_CLANG with Rust
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Kees Cook <kees@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Maurer <mmaurer@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 3:32=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Jul 30, 2024 at 09:40:12AM +0000, Alice Ryhl wrote:
> > From: Matthew Maurer <mmaurer@google.com>
> >
> > Make it possible to use the Control Flow Integrity (CFI) sanitizer when
> > Rust is enabled. Enabling CFI with Rust requires that CFI is configured
> > to normalize integer types so that all integer types of the same size
> > and signedness are compatible under CFI.
>
> I am assuming -- because I have to, because you're not actually saying
> anyting -- that this is fully compatible with the C version and all the
> fun and games we play with rewriting the function prologue for FineIBT
> and the like also work?

Rust uses the same LLVM backend for the actual code generation, so it
should be fully compatible.

Sami

