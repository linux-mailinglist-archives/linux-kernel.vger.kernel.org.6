Return-Path: <linux-kernel+bounces-527220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7125CA40898
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F8519C01D1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDEF206F36;
	Sat, 22 Feb 2025 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz75jhss"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9D1B2182;
	Sat, 22 Feb 2025 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740229820; cv=none; b=tLYqks7ll5JrghhiYvrqclDck6+ENw/ckbV2LzmZYYiCrYQBih4+ojkSvaHUhZg/iZgTTS3qk4vyuhrp+2Prq9ZyinFq9O704ilyKIbDLoyZL9hQzYmibUogXAPZ2dIuBqcIhPvMPzl7FEYwJUI2HsDq7JTncwydFquCrnDC+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740229820; c=relaxed/simple;
	bh=J6s/YMcNE3VO47h7esumhnCOP/O09dk+lTINlLDts0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0BgaVVnso+vWrnx6AZIxobmQzO+FvbriBA2AOK3VAX0AE1Vp0BbikGRhUfCjjk2pDqINTZeXyK1EGEVKLA69Mpr68EA79LCC3aeRCKuwG97SSG6UrOaDS3t056d0WHamKghV41U7U52wTs5ItS4t+Py86PE8by3bmgTM7nRzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz75jhss; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-309302f629dso2022461fa.3;
        Sat, 22 Feb 2025 05:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740229816; x=1740834616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6s/YMcNE3VO47h7esumhnCOP/O09dk+lTINlLDts0c=;
        b=Zz75jhsshfLDZ6V6Vb2yNxpiTZUfvbOYVSE/YQGIU6Ku0E/CQyMUkX8nyZ1JGREPsl
         4VH9SkTWr298exsg+AjJJAcsR5PqOdKkB7f3mXXIHNHd2ZLpwr7HDlwkmrPyyxdwUha/
         1KTOKHYOixVPOh9fojnMM/iEpx/YKM9YAufBb9cPVpTPxR4QwE1xIdXjpYV1wWGaMXlA
         Q/7HcQvys0O3RtWSOxjhPayUeIBOBltQ1ddG68af1mq3yoUY/HrA5EQDJzrTztK65+xZ
         nNY7Yq6bg7V7yW/F92tELFPCvE4O9eRA/jHTrprlXGI4yBh+9uAqfsZ+6r5+CkllP7hc
         eXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740229816; x=1740834616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6s/YMcNE3VO47h7esumhnCOP/O09dk+lTINlLDts0c=;
        b=Mqyecu8hDzZn2aDmmYj6S6VBTtcEgK0w0W7kK1cPsIz6X8qyUjbbiDPf4XwPuLkqnC
         jYH4i0chqeOosWhij+V6lYQUmt4eC8Y6a3acVait/8j7BoOVVdrmH8Hjp0wWhP/0q4Uc
         mOPsMLf1npXb2Y6ZUCu4ET3ycfvrfvLn7tau3OMa6mkNrKQ5SxeGJy+RU9qWtv92pVAT
         KHT+vK8WEu2M7npb/Ps9ed0a0vUAdfcdkVo/QDmfmJuwCs+ik8k5gKFeSGmUlZAshU8q
         gdLM7o4Fue7Nunsjp2FKLgRUNSgnO59iBM3uhC3/AvrSKavm7d0m3kSHkM/Q4bzhMqNx
         O44g==
X-Forwarded-Encrypted: i=1; AJvYcCVNGpULPU/hraJSkC0MbIUwb0r1uvX1ONkVxG0skSgEQW1zCesBjTBDO+dAaR4GYMHdX/o7wlJT5Njaflc=@vger.kernel.org, AJvYcCXu1sGBN3+bNFtZmNnNk+teVo4SFnhWh7kQJISpK9PuyiXBVeL8Tj1JsvYXLZksjeviOaudmaKIVkCIfpJddCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpBZ/s+/8jCrSBrm9/oydPVsCn+g5BwT3igmjJfQAAMoW3sy3
	1j8zlGBG/xdF0ljeQVT6s4V4T2nJYGnaunbsvVkeXT2qFfUheIMyNGpWPuNS4KuqmZLNQB3psvp
	Dy8U4LUtF3qpIQdKYqi8ecnfz3As=
X-Gm-Gg: ASbGnctWJq0LFqcgeGbCy08S3d/JSXzJuOzFWsBnmKIDBw3kEzoJIu4lA4uocbNelNE
	NHkT4W6yf15lf0ndCxkvDCNr4+ojK5scVSRprnT/LcAiK9ymQ1Z2CvmMNDucmmG5Iq/zL9Wfusf
	kbVOTLM6A=
X-Google-Smtp-Source: AGHT+IHwNzln5yKY10f/SLa7TyzzKb8WlyM1GP5KT5C0jwJzPvt1rxHzqxCiqNKDtD/05q4YnBuIqT4NRA9agZ18kGU=
X-Received: by 2002:a2e:ad0a:0:b0:308:ec50:e828 with SMTP id
 38308e7fff4ca-30a597723b7mr9409781fa.0.1740229815812; Sat, 22 Feb 2025
 05:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIJ0ymzdUceCN05hwJpth4erH5u2SHYzYl52wGeT3uiO9bdk92ZkEmEEq9a9NXsInJYSz9uziwq-1fvdsXoeDA==@protonmail.internalid>
 <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <877c5mci3p.fsf@kernel.org> <5kF-NYTBZbEqnnQud5LKnRXO0lfM0i6I2PoeFrpKDhCYwUuk_bG2Li1T1Nuv82r3VFD8adTcdx7yenXSIfTwmw==@protonmail.internalid>
 <Z7eYp_vZo5yDVOdI@pavilion.home> <87frk7hera.fsf@kernel.org>
 <Z7hheOSAuKdhq-1C@pavilion.home> <CANiq72mpYoig2Ro76K0E-sUtP31fW+0403zYWd6MumCgFKfTDQ@mail.gmail.com>
In-Reply-To: <CANiq72mpYoig2Ro76K0E-sUtP31fW+0403zYWd6MumCgFKfTDQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 14:10:00 +0100
X-Gm-Features: AWEUYZnbevjDVVDRQckK-fGJKC6w9oGW8ziT0fjdgnV8upF63x6-u8HZ3SJGxx0
Message-ID: <CANiq72mCF51WP6R00_y93mCXJftj7tVSo=ej9a6K2-xcGy0Mdg@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] hrtimer Rust API
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 2:04=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> send PRs to anyone yet, but I think it would be a good time for him to
> start learning how to apply patches himself etc.

By this, I meant taking care of the usual maintainer bits, not just
the actual "applying" (which he of course knows how to do!).

If you decide to go for PRs from him to you, I am happy to help
getting him up to speed if needed, too.

Cheers,
Miguel

