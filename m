Return-Path: <linux-kernel+bounces-401643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49049C1D4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7D1286D19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109C1E882B;
	Fri,  8 Nov 2024 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJ5nvB13"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA581E00A6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070050; cv=none; b=YnagSkOxMxdkS3xlFTXUQ4ktmzMqg9EgLQLmArc1vTUoDlJxFtvWTT25MsV3z1/oicpYV6l++QU5z3Ef/ts/SnmgD3E2vW1H3BRLWJxQOmKydbsnqBzlajhegs01WLaTf8AvSvkJ5M4LbQaR5RtoUGYyxpAp7I4zdaaSa2fc9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070050; c=relaxed/simple;
	bh=CEZa+qQzOPZLsTrs3JwvPgcvIgeFmTEXgAfXPGjswmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPmB9VxVfdnJxlcbBhX1mxLXQg7FhV/NMwWfRW0L3AjAHkYfz5DPRFrapgTq0OTb39ACUlgBw2j9D2JVRbea51c8QadRFqLEzaxrGHFypywkL3NNP6J0miB17jDim09bBgBVM5+u+T6NHwcNvfSuDb31K9edNiE1kOB4qWEO8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJ5nvB13; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43193678216so19524755e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 04:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731070047; x=1731674847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEZa+qQzOPZLsTrs3JwvPgcvIgeFmTEXgAfXPGjswmY=;
        b=fJ5nvB13uuNeRjGx5CZeMNTwV3ZWhVZcHkXeEyOxkxJpKLRwEV/ak99cGbc94qdL9v
         6vFkCsbxV4ITpMgBtRweF/zA/JCCgE6prVEYKNZBSaexwmJFLzLQNMR7TNcY8wC5hTTa
         CMfCXwMoNUWB5H30kPliKvr67HU0KwIailLsG+Cc+ocoNqASFpEWX14LADQsU20pL05k
         raeIjNBd5lBBJ9wVEzdnwfqtHbJsz5WIGePOELSQhd1w1FvkFfG04rqXg5Rhui1Rc2PO
         6fjRUHH5xr6ehR9Vk9Bb/B7+jQyvIq3eUB9VJ7j0yg/xeT6mbLy93VyxviC8Fct8mHlx
         niGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731070047; x=1731674847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEZa+qQzOPZLsTrs3JwvPgcvIgeFmTEXgAfXPGjswmY=;
        b=IVj7ONJDK5Hj7xU2+uMMRh8XLLn+5pKCWGaxH5T9Ho2B5Bkwx6yx77PEM+8YvQPpuI
         J2Ai/nqOmin5KbOVpw4ujpRtZ2xnKqX+UJbFq8WnAFoJQNfYw9tJxH3HKx37I2epz3GW
         XWJ8P5A3tvR2X1n2XMkn0FE2ZEqaMaAlL7A21hYbWS3gkHFvR1l09hoLrx7B6xkf8zaf
         iPF1jRncwZq7ZvdsEAFcyTTqgRIJbwj8ToTjiWBli4JoNSR8RYQG65123k5JRsC7OMmM
         qN8YbdKjRplRYCJX3sv9eT3IQgsBx+PKzaY3V315/qlOE4e+dI1+SVn+eTurqdz9TBjn
         Kn+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1qJIA0BcMcjNlUPsE3zR+CQRZIJsvKtMjpqG1EkvlA34qRrAoS40mEDeT5hspV9RErliGS7RZ9/hookc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAkyL2u12ib4fIjHJI/Bwf7LTRxRfIwjJc19hCVT3JQyFKM2Mz
	Bmn3F1C2LnzZhjs7BFekFtwQ5m3B7LGXcm6onNnB2YxRklXx1k4LtzPIO/u41IEj3wNhZUag8KP
	klqrIgP2vm68Kw4CPTfQEOzIWOhpvUAH0692h
X-Google-Smtp-Source: AGHT+IECWSC29NjpRVyfbEqFo681Bx2KDaiI3DjX2JaZRc429vaQ4ogNVuwydf2RC+StSAf7pGRwTWbqEWExU16uXaY=
X-Received: by 2002:a5d:6c61:0:b0:37d:5084:b667 with SMTP id
 ffacd0b85a97d-381f1873091mr2196958f8f.33.1731070047176; Fri, 08 Nov 2024
 04:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-3-de650678648d@gmail.com> <CAH5fLgiMHE5GXQv8pSR_KYWsa44zr1o_FNrg1mj8QuTvNQmXhQ@mail.gmail.com>
 <CAJ-ks9=Ej0St7XnmvTysdnjPHh6O+4XdYFC6LouwEJR9GpUPNQ@mail.gmail.com>
 <CAH5fLgi=n-v5C4hH-+uozbiwwWCU_QGzhxfdTXfTyyy2ejJR+w@mail.gmail.com> <CAJ-ks9n8eSPsb7_RqWk-3OgtsrZquA=94uBopkdwtHuTPUisaA@mail.gmail.com>
In-Reply-To: <CAJ-ks9n8eSPsb7_RqWk-3OgtsrZquA=94uBopkdwtHuTPUisaA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 8 Nov 2024 13:47:15 +0100
Message-ID: <CAH5fLgjukqj49UHw33uJewc5Z5q=_f4uXzv2jyQ2=2eFCyWa=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] rust: arc: split unsafe block, add missing comment
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 1:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> On Fri, Nov 8, 2024 at 7:37=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> > You could write `unsafe { (*self.ptr.as_ptr()).refcount.get() }` to
> > avoid the as_ref call.
>
> Doesn't `(*self.ptr.as_ptr())` have the same problem?

It's not quite the same. Both `*ptr` and `(*ptr).field` are place
expressions which do not inherently involve the creation of a
reference in the way that `NonNull::as_ref` does.

Alice

