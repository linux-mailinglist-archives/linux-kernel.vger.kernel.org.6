Return-Path: <linux-kernel+bounces-568365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110EA69483
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BA819C0FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B2B1DE3AE;
	Wed, 19 Mar 2025 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJ6PjV7x"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90661DF738
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400691; cv=none; b=Io/8zkaBxZRS7x1DkfOLKFGLDfLljatTGnvgh8lybaAibAiMv+QexcK64uCtHRBlUUQacLAJAw4ura0nmBPz7pNxO+HpFoeCNGV27mSE+zvu1n6TGOoaK23Mhdb94bpB3NblrSnyI6+92iqyJ3qalXhTaeGpLYGRQjEeIKKm9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400691; c=relaxed/simple;
	bh=8DqBsikgA7zOXmG6eiKnL/aYl0OdYNLj+g4Ue5RXTKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUOh2RvFTY2frvVJkJ7ehpNS7Jr/TTiZy/zny48MjzssbnOByHtCghf+Yy89jWzFH7j80SntOBLR1+VjrDKqSgc+GpvtrI1YLCVHg9tOMxy/SlyQn8GxyF66cKVtIX70QcWY7wo/O5fJb0uRcmpSrl3WEgMQbpy9SeMdXo6lz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJ6PjV7x; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f6ab1b8fc1so4148981b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742400689; x=1743005489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DqBsikgA7zOXmG6eiKnL/aYl0OdYNLj+g4Ue5RXTKY=;
        b=IJ6PjV7xT2yKSD72s30VOx1xkroEkpZ0UYYWSNYeOrpzxuDcUgG3ufibNz8OWoksl1
         FPNkB9AtmM8wUgrQHyfazvDtbxftnlgudStraelfkjDQr6grsqbSGHzyv5pWY0kx1+4Z
         Nnt6vBCMHSch+H0YCZmrtICLY1Hf809encfOqLhjuR8LXOmesSgluckk8H/p8DqekHor
         0eIoWxyc3Cut/asjEVTLfbccaeqafTBufPpDOFaoWh124bZQPbYOuz1/Ku+25CvU+FZ8
         jH/ucpza5y2kliAVShOq8oFn0JBWY2sQhD7iE9jdp8NPBl7wKd2rV1ARmI2OqAkmsGyp
         z9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400689; x=1743005489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DqBsikgA7zOXmG6eiKnL/aYl0OdYNLj+g4Ue5RXTKY=;
        b=HkMEhdzZRH+52rMwV8VoEkDvW8h3KhlhPTYGDoA4snC76/LM2rWH8HLnD8L/+6h9gg
         aYTVpWnHmUKNowtT5XjVkLzrsT6tiv0XwrgOuvOJpSyCcLrZcylM+C05nkprtup+QxXV
         cs2OrzH95oLci17+lURyLzHeoIiAa8W6CSMdCweZYwau486d2rY3yLf6yF9J3T6zhqNE
         0bRI+a6kSUrJoNvQ4RfVejtBnmX6vTANG5h0EagkNiDOcB9SWavXugGn6d3xxU4dtfnG
         3DGTdeRd+R8A6kszCmWGqW7/s63ru/xs1rZbPxMen1OnajevjATYOT+EscGShAh72IyY
         gK1w==
X-Forwarded-Encrypted: i=1; AJvYcCV/LtUS+UmCD4G++mSrYXtoqdqMSQBGGhrv3n4ob5YuIRv21TDSIvPU4qcAO5yK4MaI3XUD6dGZkxUpU/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8G69k9n+hFqiXEWjkPeNj/yfm2zTx8RgRuM/uwOsWhYqOo+xj
	4iH60xZGHeDD3lFmCfMRzPYpoijtvBSHEwmCtAKeClD9mk6n3/Nf5FU9hnlTacj7e36cVY1+FcU
	TqbP4H1LUo8xU5d8ehe6xQsS2EIWx7Jxpu7yQ
X-Gm-Gg: ASbGnctsjq92Soc8QQ9LZdeys0oymo5QWS6kiogIJ9rF8ts96KvKxS1itY4JRMI5EZn
	fescGb2uYFDxVrXysH6bFyOqg2HyuQIZvj3q2hbIa6Kkd0BwXVXe7QJyDgvt8qIOa9jMYgwTQ33
	UdHO7pe1qPKR1FLJbU0VmFB2/Nt7ZnEiSmDqfe5FZW3kOQzB6OOGzdPWgGm0NnFBQRNPE=
X-Google-Smtp-Source: AGHT+IEW9jnPz92hsq7khlXESplWvRv/nknbjLt/n9wh6GdkzRZMnj0RC4JOEcC0Vxh+2e7utxkJXS51NVDXJP+g6MM=
X-Received: by 2002:a05:6808:1692:b0:3fb:177e:f987 with SMTP id
 5614622812f47-3feb4ab7158mr33311b6e.20.1742400688840; Wed, 19 Mar 2025
 09:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319112822.1961241-2-bqe@google.com> <CANiq72=fBJLhgW64vohSopsR0RQLch+_cKqRKDQT7yR9B6A-mw@mail.gmail.com>
 <CACQBu=UC-DmLGpg30=Dyp5hhWV7HGXG+bL73YBSq5vSa4t3mig@mail.gmail.com>
 <CANiq72k8-5YRwmcn1h+avuyusAC36ttOqwsMH_eO-DLxTm5gpw@mail.gmail.com> <Z9rroCn3MAsXz1Lw@thinkpad>
In-Reply-To: <Z9rroCn3MAsXz1Lw@thinkpad>
From: Burak Emir <bqe@google.com>
Date: Wed, 19 Mar 2025 17:11:15 +0100
X-Gm-Features: AQ5f1Jr0LaiSOo7wg9Oxek0xiU32mVJbIh4vLfpBtIPhus0dJ2MigWJRIumPGXo
Message-ID: <CACQBu=XbepNPkeGW649Ogf9PNQ59kebatpM8XTgFN162TVj9-g@mail.gmail.com>
Subject: Re: [PATCH] rust: adds bindings for bitmap.c and bitops.c
To: Yury Norov <yury.norov@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:07=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Wed, Mar 19, 2025 at 04:43:50PM +0100, Miguel Ojeda wrote:
> > On Wed, Mar 19, 2025 at 2:58=E2=80=AFPM Burak Emir <bqe@google.com> wro=
te:
> > >
> > > Thanks, I was unsure about this. I understand the desire to not add d=
ead code.
> > > Yet, next-20250318 does now contain helpers for `cpumask.c` without
> > > corresponding `cpumask.rs`
> > >
> > > So, I will include this in v5 of the rebased series, but with BITOPS
> > > API BINDINGS [RUST] in its own patch.
> > > Thanks for bearing with me : )
> >
> > No worries at all! Perhaps wait a bit in case I misunderstood and Yury
> > wants to clarify.
>
> Yes, the general idea is to be able look through the all software pieces
> in a single series - from C wrappers all the way down to rust end users.
>
> This way I'll make sure you are using the API in a right way. And I
> think I already helped you in that department, right?

Yep, thank you for the timely reviews with the comments. The series got
quite a few better. I'd love to be as timely with sending back the new vers=
ions,
still getting used to the conventions, workflow and limitations of the
infrastructure.

