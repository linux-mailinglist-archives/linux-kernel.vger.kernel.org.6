Return-Path: <linux-kernel+bounces-568114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8184A68E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E4116EB91
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FFC17A30D;
	Wed, 19 Mar 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17hBpNpR"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F68154BE0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392708; cv=none; b=XkNB1fVQcuIw9V8ZOa3nIPKB2b5pHLtxHpPnMqC/UuhO3oMctrCuRVlKC2Zt5bCCqnfTTfYtTciNgFY8Cqa0eRyHAGUNWBQv8vg16fPRSOuHfRxozemgjfQQYdhcqk5S9pYVAP73zSeoOv5WzzoRaeH4/cgPdH9XksfJXfV/9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392708; c=relaxed/simple;
	bh=ylbGEe04ax3zq0kly3Mtq4h4UGQtoyOxtZpY4SszLa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNte5QXYc0UHE94BldLoI10w/TnEiIXyrswabihCsl4lJJOHLbAEP3gtOYymXkDAXhNHy/DXCgbVwFU2GQDGhyF7RpQaFiUEqYiLjyBbdMmhCy1TTAHgdyzvaOuTuViAWUBVV62VS0gcmBLaxK8oBXNqiVAJovjvDRLRI7mMfOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17hBpNpR; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3fbc00143d6so3574597b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742392706; x=1742997506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylbGEe04ax3zq0kly3Mtq4h4UGQtoyOxtZpY4SszLa4=;
        b=17hBpNpRs7TR01JswpCJVAnCohjmkdqD3xZwTpRveBsygSJDC0pNQWAx63vIo5qsoz
         qoGIf5IJrk0b9D0Ke7O9LYNQIeVLAFtqnTVuh5M/OUtsQpRGzeFU0noNZ+0ufz/ulXPd
         y8tCmcEkAEoDYVTrFo4JUmmfdZ+TzoXUMpj06NMgEnmeS/wMtin7S+JKDjmh8IQmeFlE
         n/sFQn8FUtokLw5ZU4BhFK2ct2QW4dZNN0AkyS7Iv+LjgZIA8ZXpqYkcYlliQeSPeNfU
         5xkZYzinBzHYkhUhfRQp+4j+eq9KzDjj3+VlFRPVD3xzda9DxWh1ABWRzGyJRQxtfQeV
         yIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742392706; x=1742997506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylbGEe04ax3zq0kly3Mtq4h4UGQtoyOxtZpY4SszLa4=;
        b=Yafcna8qiVp1q8/rNHeFCifaqn5rxJIiNimi+2Q0PkYaleZNMoYCFZLaCDWX/YvO5n
         vNvF0kR5zV916qKR/DvTYMaK8FZvF83V4hd2XSZzbzL3MQjio+wPFLUlnVfQNKQzPxky
         Ql19k2geY335DZ37BlmUN4CCHrvI4jc15gKSO+g63kaYCiiA+DeNBn7hlMi/p71cRizQ
         TJT9YzayJzG51kVwfAHI7u9RT+AkJxi8P/cCMJCeGTvE+fc45DcFcfHyJNsmrnvpf43f
         qm7nquEfA9GvToIhFfuVmjep/Knkwix+ki6gnzHNvYVfdEPwli2Rerf9nZPbyziB1iI1
         cQIA==
X-Forwarded-Encrypted: i=1; AJvYcCVk6af+Ovx8EKWTQDmGrRxaTibWd5XQ83QHFAIgLd2ke98BEJoYo9mrkyNUEeSoemoBlmiMq+fYIPUNygM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygW2tUUvAs8QB0Yyym7sEJtEF2h2yZSV1fPMSjwcTMys5aBMJ3
	JCJxmB293u7EiIFtd/EzuLQs8izFYAnvauKTZqLFW7ugrcu74cbSVO+QOHkFkKQETYI4HvGiYwQ
	AyIslFk2vXxOCeWeLEEv6FjZcYjKMV8ixOdqINI0WeouX1yy6mQui
X-Gm-Gg: ASbGncuoocrou6GH8ebgkxENEHEN/1wc+ttlvu55mUotU0KJCGMiIRRkrGcDUIkcwWQ
	R9A6RKwA0tndD3gxHPiXbkOfJRLZmlTFJvB9qAnnO1BSnDYO0kLSs+hLLOQuTPWedPH3QoNbKN6
	mISeiszS7m4EUqV1GTSg0mBqoho4jgfceaWuPFafrdjANuyQVF1n3sEJ4=
X-Google-Smtp-Source: AGHT+IF4KLt31NtS++GZ7psOfwQ1LFfpcHS2BYBhL8/8SUWRwtOGK+yI8x7Ow9O0T89BGh98U4q/nmR2FkWXNFk8q5c=
X-Received: by 2002:a05:6808:3094:b0:3fb:7ac1:512c with SMTP id
 5614622812f47-3fead5876damr1932458b6e.17.1742392705822; Wed, 19 Mar 2025
 06:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319112822.1961241-2-bqe@google.com> <CANiq72=fBJLhgW64vohSopsR0RQLch+_cKqRKDQT7yR9B6A-mw@mail.gmail.com>
In-Reply-To: <CANiq72=fBJLhgW64vohSopsR0RQLch+_cKqRKDQT7yR9B6A-mw@mail.gmail.com>
From: Burak Emir <bqe@google.com>
Date: Wed, 19 Mar 2025 14:58:14 +0100
X-Gm-Features: AQ5f1JpxborytBWlBSLs5_XmZ4Jy6yuj11WAe_di_o4qZZZ-INHB9Nj2dmBh-NE
Message-ID: <CACQBu=UC-DmLGpg30=Dyp5hhWV7HGXG+bL73YBSq5vSa4t3mig@mail.gmail.com>
Subject: Re: [PATCH] rust: adds bindings for bitmap.c and bitops.c
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 1:46=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Mar 19, 2025 at 12:31=E2=80=AFPM Burak Emir <bqe@google.com> wrot=
e:
> >
> > Part of a series that introduces Rust Bitmap API that has received
> > a few rounds of review. Thanks for the helpful review comments.
> >
> > Rebased on next-20250318 and split as requested in
> > https://lore.kernel.org/all/Z9nAVIokrWqoRiFR@thinkpad/
>
> I am not sure Yury meant to make it an independent patch, but rather a
> different patch in the series.
>
> Doing it this way means we add helpers that are unused, which I don't
> think he would like, and we also normally don't do that either.

Thanks, I was unsure about this. I understand the desire to not add dead co=
de.
Yet, next-20250318 does now contain helpers for `cpumask.c` without
corresponding `cpumask.rs`

So, I will include this in v5 of the rebased series, but with BITOPS
API BINDINGS [RUST] in its own patch.
Thanks for bearing with me : )

- Burak

