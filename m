Return-Path: <linux-kernel+bounces-387102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574589B4BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032A01F238B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235B206E90;
	Tue, 29 Oct 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwFCwFZX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBCE1E507
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211472; cv=none; b=t6iVuu9TP6T6gAwegOj/JEa8kDPRbegVIBHRJeXSAtJOMxKsCo2f8gRv/xMb2KyciJhy2Q/wS312fIfzBMtSk4UT7/BmMLL7xgcqC1lfxZ0egljpP0D6Cb6/pM1s8YnJ56UlLFpEyVXn6noppOnKglo4QVp1mWJFKvH2jX77OV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211472; c=relaxed/simple;
	bh=L6njmtDV2cbOykXHmeJ6c8LVfIwB8LafghBRfLJvvy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6R1nKLL0daiL2loy24W5iLH4gC8qfrL7J0bccRAfHangFBs3QOM1UScEhm062Izb599alws7+TRXFQm3nNuX8zeC80eU5MlWspTJ7BX22aYv5NxJzf/co2NVZIy9xQZt0Kxt56FxQDiRQFc4HNj0jOh6lEA/8fqjVY2HFt5uO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwFCwFZX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so56817155e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730211468; x=1730816268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6njmtDV2cbOykXHmeJ6c8LVfIwB8LafghBRfLJvvy8=;
        b=TwFCwFZXPn+V3TXef0Gr+Fq/AB6ok554ZcAKIpCXw/oXL9C4Nh498UcHG3LexRKDIl
         wC9Kj3gGgtm7Y175kX4gC4YFeanHtk1/OoKdAqU4nkuFKP23fVir4AvjQzLFcErQj3pM
         RmwvJAHZPyEXwMKM0qZtm8tsswmawWksau2brE5RNo3XLOh6wIjN+QfETgziIlxY3pLX
         c0DPvTCG7TC8tBFgapK69xqdn44+bFK4V7MHNh5ieJPqKcLU2VGBrHFqWO7MoIarlUBs
         7KXPoENevovQ9HQlYFS7IgNJ3RnpmUYKbvGNOkVWl2C2aeIPvHu5BskyPji/8mnYeHSF
         F1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730211468; x=1730816268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6njmtDV2cbOykXHmeJ6c8LVfIwB8LafghBRfLJvvy8=;
        b=cJjPzNC5gbqlmm7PXsB9X7vr84uZunsh+eYedtiMC76pi9ZaGeYz0aABqrvjL5b/gS
         p9nGwF+zY6l6rzQV84SLqgrnzd2bMEr+u+g1XV/6k6wxag8b42ndqjUqsj+epsRDfekv
         8bILpzBCNrW1mMXFadiR4E3mMY2RRo1tC1GHAs1mk1fFt7hREzfvzOiJt9As9ku83IwE
         U1+d6JG3U8r4KTKE14gxvDH/j6DN21vGu6q6l0YfrIeeAWIYuNvUBWLIe5gBqk6OEYae
         5R4gttGkgJBxqGbkj3xoZaEfocMOQ0nP3MNbOTVD67xRbNF47NanlXPcsT0ha3lUDx0V
         jTdg==
X-Forwarded-Encrypted: i=1; AJvYcCWdJB9SKviWusxR0lEUHmrygOZ1yRZ+6YvRoS3BSTD9AYHwuU+AX8xHbag/s9yQJtNLr5IfSyITqQx8mNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmUPwUu67ND6TPSVnd2QHAEpZUiJOtFC7TVxDlobx8bTXeez7m
	FbMf6WdQT8c+k8ANw9D++iLMW0CWgvK8xRUxuL8iYgLS26rXA2xuH/aI9fRJQrEkY/8cb55neyN
	MRPo3tau/LNn7EfxBkzIEK4IjAnwFAOlo/HlU
X-Google-Smtp-Source: AGHT+IHhbBKGiK7BgU4W978cOb33NcTjzUbMbdW09EsxTh1luCi/3DLowadG0MtS+fdBvmIOkjTTesI9JgwmFdik64o=
X-Received: by 2002:a05:600c:4f03:b0:42c:ba83:3f0e with SMTP id
 5b1f17b1804b1-4319ac7078dmr109957335e9.7.1730211468245; Tue, 29 Oct 2024
 07:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023-static-mutex-v6-1-d7efdadcc84f@google.com> <Zx_OoCRrA_WTay_O@Boquns-Mac-mini.local>
In-Reply-To: <Zx_OoCRrA_WTay_O@Boquns-Mac-mini.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 15:17:36 +0100
Message-ID: <CAH5fLgg6xO71ud3mHvEaKhU1tYKf7RKTrVcL1brHoORf9nSgoQ@mail.gmail.com>
Subject: Re: [PATCH v6] rust: add global lock support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 6:49=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Oct 23, 2024 at 01:23:18PM +0000, Alice Ryhl wrote:
> > Add support for creating global variables that are wrapped in a mutex o=
r
> > spinlock.
> >
> > The implementation here is intended to replace the global mutex
> > workaround found in the Rust Binder RFC [1]. In both cases, the global
> > lock must be initialized before first use. The macro is unsafe to use
> > for the same reason.
> >
> > The separate initialization step is required because it is tricky to
> > access the value of __ARCH_SPIN_LOCK_UNLOCKED from Rust. Doing so will
> > require changes to the C side. That change will happen as a follow-up t=
o
> > this patch.
> >
> > Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-=
08ba9197f637@google.com/#Z31drivers:android:context.rs [1]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!

Alice

