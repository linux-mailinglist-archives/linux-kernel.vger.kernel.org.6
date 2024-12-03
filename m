Return-Path: <linux-kernel+bounces-429098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53029E1758
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA359285898
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFD11DF249;
	Tue,  3 Dec 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPUtDqNu"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3589A1CDA17
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217871; cv=none; b=liyxsAjtusT43xwFc+IfedMQABsolmOU1tsBqwXtCwVGs7P+mF+/nWu7HPlSlJp6CDBQB81DthaRf9oZ2v4x0vPvMPi/pyI7N4ymRZ+/OvZ4yD4n+dPMkl+qPOr8QXn6rt/ocMW1jksmUMCD29xvZt7X7Bu3otafRZfNMBNZiDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217871; c=relaxed/simple;
	bh=Gm7LmkU1V5zD5lJylDWxZ53/OMofczXKTWiDdNJmf48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGb1Ord9wQ9qHGjTqTgQRV33BJST8QnJRkTzXpA45ANoRHYZ/1ZbIf5kuAmwGpYtTF4dYUjzez1TpcmtvEwPJ6ZNbdTAd26md9NOQ+apQ9w7nQWd7zjH4LB74a+Z9BMgrlY0uuaBz9xP3Q/oSYWRdBwGNPNTKVhQfCSVtVOc+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FPUtDqNu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso1367274f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733217868; x=1733822668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfIxgcgQERlA3nZv+UURo7mpPSgExGKLGe0PuBaiCIU=;
        b=FPUtDqNuv4hsusXxlsaT3b2PYRc7t+AMBPuChdqEyOUvi2MVn9fG0GxCIIJ9FVGQCT
         CsLo+WP6R9H1H4sKD4tcYPPZIdYpHiKsaOCMfJgQesRnQbVOje9Dp/LipbKURRyeQ+62
         FwghBprxv1Ye+Gqaww9i3N7ylFIBAGvyC5juchbBx81myFy+oIogwhsttMKt/x7jmTVD
         CurzAt5mFDYKEVk7y1MC46YBTwKuOJKo7SJeLjLd24uVXW4HahID9Lj5fn2lFOnpETVo
         ulN9yBHeWcmCAeQL0/hNi1MQY8xK+OWQw3bjT+FVHRKGJ8tIHiMuR1xmvHDr1Pvgk5Jq
         cTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217868; x=1733822668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfIxgcgQERlA3nZv+UURo7mpPSgExGKLGe0PuBaiCIU=;
        b=gSHcvwGXkemvGB9ceYtXtGnGuVHW/1UlEDsFLPHQS8f9oen8K1vRqGpl6hvPbGpHoC
         dNSI2iEzgjOaDxjL8gpIWtRBjrJG5DaLxHZxpZ9ETVUCfEPjjocV6Lpgzv0cTAUlBnH5
         jucTjFFUnCiCa7nBAAdaT/3vb4DPluaTBFJAPGBV3yZ5Lwh6X5l37Fyn74oz4GEcEBco
         wSGtY93V9kZfNerFZZE/p+46h4qUJbT9z0k+jBUDc66TWTE8efdyqz+C8srORCj37ykE
         rZSLW6vsiaO4WfdVA1KJ/2k34ip8NGU7RarKUmoh9Ldf0CLZNCTYfm5es5ROPNiXQhyH
         xBCg==
X-Forwarded-Encrypted: i=1; AJvYcCUvb8Zj4f70J2aPQOEz5VjjoeQTztLANRD1o8RnQMHMs0dXyS63CaY9ZVORxPLBqzjCzn7Gt9mAzV+ovCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziIWRWxc/sn1z9/w6DFdRJSK6IPbDGt0xCipLsRhHKIAhkZOgQ
	+U03L2wgjcr+wjl5YCNFrSUnr1AbB1+LFZy9XDc4BO0CJfz3EKrY+93Sub2QdRV3sZNH2mZ+Ypa
	Oos1Vof8/X6VMHjCFIO0BCnRj304SoznnaRkg
X-Gm-Gg: ASbGnctBOjKJVc3xg7Oku+FU440V+6PDYY3lUEXvAxXtz2VlBongCYdG4JwX/vf04FJ
	+h3CFl+l1f/4ThQyJ+6I7LUdWstaunsNH/kzu4vIzPr2XduWz0nVfG9tNnX9gQA==
X-Google-Smtp-Source: AGHT+IFesu/47Q+++IOPjyl/eDemBF3SRkrLSXzJa8pQa9MVlMAAYrouhBUlDjUq4KfMYn9+YgN6KZ/Z0DfsuaueMHw=
X-Received: by 2002:a05:6000:2d05:b0:385:f284:c41b with SMTP id
 ffacd0b85a97d-385fd3f18e6mr1023879f8f.25.1733217868381; Tue, 03 Dec 2024
 01:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-8-dakr@kernel.org>
 <CAH5fLgjcy=DQrCYt-k40D4_NcwgdrykUW9d74srGn5hxxo2Xmw@mail.gmail.com> <a25f7cfe-ef43-4841-ab81-0ecf59b20f15@kernel.org>
In-Reply-To: <a25f7cfe-ef43-4841-ab81-0ecf59b20f15@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Dec 2024 10:24:16 +0100
Message-ID: <CAH5fLgjgvq40mEsFZZLGi1s_OHNBsOXPT1Si6vM2sruM=tibQg@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] rust: add `Revocable` type
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:21=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On 10/29/24 2:26 PM, Alice Ryhl wrote:
> > On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.=
org> wrote:
> >> +/// A guard that allows access to a revocable object and keeps it ali=
ve.
> >> +///
> >> +/// CPUs may not sleep while holding on to [`RevocableGuard`] because=
 it's in atomic context
> >> +/// holding the RCU read-side lock.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// The RCU read-side lock is held while the guard is alive.
> >> +pub struct RevocableGuard<'a, T> {
> >> +    data_ref: *const T,
> >> +    _rcu_guard: rcu::Guard,
> >> +    _p: PhantomData<&'a ()>,
> >> +}
> >
> > Is this needed? Can't all users just use `try_access_with_guard`?
>
> Without this guard, how to we access `T` with just the `rcu::Guard`?

I don't think `try_access_with_guard` provides any access that you
can't get by doing `try_access_with_guard`.

That said, I guess this guard functions as a convenience accessors, so
I don't mind it.

Alice

