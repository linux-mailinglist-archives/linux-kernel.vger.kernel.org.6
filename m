Return-Path: <linux-kernel+bounces-420746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8F09D82CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA34B25659
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE91917D8;
	Mon, 25 Nov 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRlGmrH4"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4112B17C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528058; cv=none; b=BwQZ3qooH7vp5/CWhVK0BL0ciEIjXQQ3Xx+YXBC8y7uaqQtSwmH+TXlNdx5KYrWmDZp86VYQPyN7XYndvP/UBPH+dzzlW2DudZLSUy6zWMFwrGybdJamuzE2JEmxO0qjI+++2IJ8tbIMnvMcApQJGDpW61wQiabg7xrnwd829fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528058; c=relaxed/simple;
	bh=GO8no/cfx72gD7oQPuPDCrFxfQFYozVCkdlLQfM8VCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGj3DH3/QPpKwrww8KtNIBDRhzlw+qXlDDjLnwT2pbM3I/xwz3kLYkUWZpNMxlolNekCLrdOAmz4ygIHa0P4KML4xwYFq2ZEDZRKtvC0hdp3j1ITa+EpU49N8tiG2X6U2Q75629xGtqKdOOYTpYiUsZfKxHqj1UKsAMP0PMIzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRlGmrH4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-382325b0508so2757305f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732528055; x=1733132855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO8no/cfx72gD7oQPuPDCrFxfQFYozVCkdlLQfM8VCw=;
        b=YRlGmrH4AwtbkOmh0ejXmJNhi0UWY9nEnslBTy405zfp0sI8mFQusK9H5LHiZUtkYE
         dqCqal5MIH7fxLlvYXObPKADoQzastGsZozlPJj7A1zN5/4IRTkC2qQW8en/uUPvN1MF
         eosvaqSL7OKhgF94Ry0ZAW+j2NZ6GGnsrnFDb9zAHd4cO/2Woxu1Z/ubJWB4fG0XlzJA
         LGgoSQKP6kdHO/ey2OfHa10WZET2vqtcGHzuMjmq3HZzcAmQskj9qR/XlkRnfeo9I9Lp
         Oxost0VRgWHLHPViEWO8kbgxZJMqvtLjURlTcW09T9IwxLLBNYFAaHo2JWt0bEJ/ID8Y
         EZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732528055; x=1733132855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO8no/cfx72gD7oQPuPDCrFxfQFYozVCkdlLQfM8VCw=;
        b=ETSxs5C0qd4YXEjGkVBNZyJGRTThFq9e1TPAygECW4EwmmYVl/EERNw+568JzbKLSy
         2HzZfp2esl7l4oH/DOOgM3K8KADluxQannpzRXxq2aQlyB/XhPs2FK9H64J8EKXWoqZN
         G0E1jhxQoyQNfhzEwfFHpiUmaJpJ2DIOG9t1Mv2ujpQTHADuFiZVQr/b6YpIN541eytE
         I0JG0f60jdQqeeAZSrCaKvX2Ktf6+GMos/mhrZKrMC5BWcXAPj0joXeixKwS4Z5LB2SK
         dJNz3EVgresls1dyw6uBYrMQNu9P6TS4fyrp8UZIGS+R9uL+0Ji/f7c9pTj0L6WXoaLl
         WG3g==
X-Forwarded-Encrypted: i=1; AJvYcCV+l+URPHabu6Lop5tsuGCEJQNTBlWYityOdSsuZNJMbntfOWStMUS4UeB0VufqRUlKBZ99hFb3SFbf3RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVJxdKxsBPWAOZ2Y0d1AvUVcraoZZYflxbEp6tKLpMlCKa//w
	rDGkgCmLb9+U0omH+y1cJMhvMW0Zlz9cMOuKuVOuLRxZ+ItDoYWRKRnwjhPITf1g9Ola/zIkW9T
	W+TjlV0i2hfVFlT9D/XyIo63+y7B/IHRT0tSi
X-Gm-Gg: ASbGncstp7pgkdZ6j11rUHVqGM2SHqFq/6D5h1BYHVTNrXiIAfg0ZAPiPkFxSMxGqCX
	SZ+RH7v2sJ2xutK2XJzDMP+7IBuamOhEk/04sIQLi6Yk+0b3V9ZZapl6f8u7Izg==
X-Google-Smtp-Source: AGHT+IEpXTEzc4q1fzSoh9mUZqkoV/WA5KSGRw8aa52k1fi2n2O0NsLcXMm+2RXhBKUhbx8SuViQ3liJarUX078bZrQ=
X-Received: by 2002:a05:6000:188f:b0:37c:cc4b:d1ea with SMTP id
 ffacd0b85a97d-38260be5fc3mr9216904f8f.53.1732528055106; Mon, 25 Nov 2024
 01:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120222742.2490495-1-lyude@redhat.com> <20241120222742.2490495-3-lyude@redhat.com>
In-Reply-To: <20241120222742.2490495-3-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:47:23 +0100
Message-ID: <CAH5fLggLe10CrG-t4sQwm73nUUC_ArsseugjBGbz8tD5KLWt2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: Add SpinLockGuard type alias
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Filipe Xavier <felipe_life@live.com>, Valentin Obst <kernel@valentinobst.de>, 
	Wedson Almeida Filho <walmeida@microsoft.com>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 11:28=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> A simple helper alias for code that needs to deal with Guard types return=
ed
> from SpinLocks.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

