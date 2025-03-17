Return-Path: <linux-kernel+bounces-564794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385EFA65AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D863AA03A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BCD1B043C;
	Mon, 17 Mar 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC9fQj8d"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF21AD403;
	Mon, 17 Mar 2025 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232523; cv=none; b=Bj1sAo71CLET1MVEGwVl2KDDNPLNWzClWMHK+Bmi0+UdevP5IY8B1LOEvBnNEx/6WdBY49GlceifKG+RKI0h9fLWbakRscffJzAN5VxuAW0oc/lHl+skDTFjN51ynejSumVEVt5PcM1Fqo7t9Lp43uxX2TY7DIT/qHXxcI7xYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232523; c=relaxed/simple;
	bh=KKeg/xdBR886jSb6hzGocvg5k8dTbM/SfH2DkisMzUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPpWTPO2ZosRO40q6MV4zFDOIPoHT5pJqD4h5a5RtNYEDO3UT3IhtcaXiJUDJilqeAsD83vGneIf/NxmTQfH7ze+UFpa+J8R19BvilN+1TWtkZXRbsygNwV8MhWS7n9GoqGF+NhhDNtB7LF2yi5ueh+oqoLpoKqu7Sm4fW4hNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC9fQj8d; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307bc125e2eso53112201fa.3;
        Mon, 17 Mar 2025 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742232520; x=1742837320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DxwEiWPDAbVClr3XraKyBCH9dtcXkOkEq+5vtLipTo=;
        b=eC9fQj8dksFQ/WsvqXGkGldI2PTgUqrQ5AZZwH3rCt4vvM4UEeKdQ0b5Q4l7BFe2Yv
         EbDP6qccG1JgNpxJctWzti61nv4WAr4wnKPxaIAPwvICzKUF/OmOkZzN1ZV16K98iSNn
         ojdqZdKXm096P6IH6FBDDg1fhUfeHWdLkagNd2PycCBFo8CzcoqqtDVHvsjRXMQjJJJG
         DMRlHlM/yR1N9+RSDP76rToC8BsbOKgI8LnlcMJyw0WENc71vyJCVQOG/olcez6UnmTZ
         dD8cKh8iqnIvBymeb5R89bcVT8TC4icmJn0gMiJUuYs1VzatJ+B7YZQPpM6gKKyQ7t+V
         Pytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232520; x=1742837320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DxwEiWPDAbVClr3XraKyBCH9dtcXkOkEq+5vtLipTo=;
        b=AO5dmPXIV41/hOYMD1IifEtFXhrYcYqopffMundPObFKd4b2ozbv9DdqAarYdKTg74
         g1D2VRVF/kzxbxFU2r5f2kpLxAkd5jYD93VK4d6CCC6WqguB1JtiMc+skdWHJptmX+FD
         NG1gJLzfxAj20QXrUlZuhrgt2hrzmbg9N81gaA3BduRZiXbahZkpqto01y1PI2rLSC1d
         zU79Rp0lVvmhrAnGgk0CJYUE75EkzC2iBxbc/wdru/jh4RNbs5ECSXWeuKVIRIb5dEiA
         eqGpD3+OmiPdOVrPRpYP26LwuArfWUGXKW6EGF/Ki4KOJF6kIf8M4/R5vfuyPxG8m8W8
         M0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDCvdPgEq46VtAH89/+RMkTHq5ju5G3KBQeb+tYXHeSE3zVy5lWHucuedRaM7kllDml2V4ijYUP6iJZT8=@vger.kernel.org, AJvYcCXjTHkSebPdZZ34tI+YYn+heT+UDfQLaJIOovMv2Jp1rjbgQIcFCCsvHF6Aq9pl2seYfYKsQD+euuXZX3bTGpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZukEfXYFzxzcGZNolY4Kl60trCrqCz53fe90+zxmVFyGXjTtD
	/UEva/0AMplsyliGV8n0q38gugzpBfHxDr7GUTAvIkQHLMg0kb+DKS+DfiVyVxmoudyQbBIJFH4
	MmRVd0xXws7soro5d4V3eOvj+ZG4=
X-Gm-Gg: ASbGncvQLZxXyzDGt9cnXVPb7fufSAFFDYR75Pi9HnzoFUaw7FjEYZvgwrqioXKibHD
	wydJ0PVUbL+3q15RoQG+F6ApaYYc9ZGM2uWvKO7bUhTtVc+jKz0Xl+JeevYrnvJvD+dhJbTcGmt
	boG19yWcY9EXDO6SxJ4YtwSsfco1MGFn+Td9vfpHCCxGgDbKdAXMGCFTc5G7Q=
X-Google-Smtp-Source: AGHT+IHOgUcarkWMSi3spaqnGW8+da4VMfEM6aq6JlQ+sunW2iFzN1kYYqz3UF+ZmtTf2eagyJOhPuaYk1Cq4A1cp20=
X-Received: by 2002:a2e:9698:0:b0:2ff:56a6:2992 with SMTP id
 38308e7fff4ca-30c4a8f56cbmr72694241fa.37.1742232519809; Mon, 17 Mar 2025
 10:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <D8IMA0GUIPTD.34ZEZ3W8QSKTA@proton.me> <CAJ-ks9kXZDO-5utmQb2HLkxmxmQ-bg8jZ4FdvDatTj_79W2dMA@mail.gmail.com>
 <D8IPSWQWM6U0.1VLTOFNL99G64@proton.me>
In-Reply-To: <D8IPSWQWM6U0.1VLTOFNL99G64@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 13:28:03 -0400
X-Gm-Features: AQ5f1JoRkKiTIQL8dvFpgP9mk71K9uHZkpYwtu8bQmGA-AH1dzROepmuf1oki7Y
Message-ID: <CAJ-ks9=v7fdT8gS01qo1kjQQPT0DpAv8ZimZS+p3OEEkjo-1Xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 1:25=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Mon Mar 17, 2025 at 4:37 PM CET, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 10:39=E2=80=AFAM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
> >> On Mon Mar 17, 2025 at 12:34 PM CET, Tamir Duberstein wrote:
> >> > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@p=
roton.me> wrote:
> >> >> On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> >> >> > +    ///
> >> >> > +    /// # Safety
> >> >> > +    ///
> >> >> > +    /// - `count` must be less than or equal to `self.len`.
> >> >>
> >> >> I also think that we should use saturating_sub instead and then not=
 have
> >> >> to worry about this. (It should still be documented in the function
> >> >> though). That way this can also be a safe function.
> >> >
> >> > This doesn't seem better to me. I'd prefer to have more rather than
> >> > fewer guardrails on such low-level operations.
> >>
> >> Your second sentence seems like an argument for making it safe? I thin=
k
> >> it's a lot better as a safe function.
> >
> > The guardrail I was referring to is the requirement that the caller
> > write a safety comment.
>
> But saturating_sub is a better guardrail?

It's a different kind of guardrail; one that attempts to do something
correct in the presence of incorrect code.

Put another way: do we have line of sight on a caller that wants to
use `dec_len` without already knowing the current length of the
vector?

