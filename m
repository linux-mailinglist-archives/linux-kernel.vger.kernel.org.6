Return-Path: <linux-kernel+bounces-401649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2559D9C1D62
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AE72870B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C0C1E8848;
	Fri,  8 Nov 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc0DikdS"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0E1E00A6;
	Fri,  8 Nov 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070448; cv=none; b=bXUO7OM4sVieGeddRNTfTMp5pJBti4ZFcGUwsx+SuzV8PwwFZMVkqasusoyXXOKMeZqOdT6TC/fuLVuamyhcyFxJZ57vOQO1JyMoFdF9mhXMoaNloEKk6RYVCJPNzbePAQwUnqGk8d5qaqX33lLt0ranBQVgQpVoueeMYh7BmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070448; c=relaxed/simple;
	bh=Yvz0H/Y8zZiFugbvh32Aq7wBcwI/7h0sDm5Ksw3k5jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSHQqRfwzWi30GJj8oqvd+2hJ0UJfNpCppgcPsRLbecoZBU909i77ftPBHynZVM6X0LEnl1ZXXMB7I307MVAGaI4oXP/wt2dbzdfhqboQ2c+XJn29xUQz9S3s02ugiHj3N+1k+GC1lZ6ncpmqkyXoS9JUU0PE6/iCggB9GE0XSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc0DikdS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so2542721e87.0;
        Fri, 08 Nov 2024 04:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731070445; x=1731675245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvz0H/Y8zZiFugbvh32Aq7wBcwI/7h0sDm5Ksw3k5jA=;
        b=Jc0DikdS9ymfyhV+vt/cye7jKFh/HSOW8UfFuFMd7n+6T2kgYVSMXgLbPw9/SEAVNR
         clucb4cAwlh/Wh6JsEuCBfpVzG7KAwzjoTIFdY0PzZ1/h504Kr8IHRSiBpxvFeQ9T/rZ
         DmnzsCTKO8MjQtj4+Z8J/Azuak5NbQCRTfJ2GTERi3Hv7fTqm4jSOJMOtA9Gk9v7gi57
         lQVjoGWGNmREtDz+dylj9VxZs3LRxNZAeuTjRbxPX78/DqkJ8KtFPGcRvZJKwlwz8ELO
         inL2s/K4cMFU49fDTo/n1djR+4e73VGgeRX2c+5Uv1pzfUPfdp6gOmmojOhmeLyXFKgy
         qhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731070445; x=1731675245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yvz0H/Y8zZiFugbvh32Aq7wBcwI/7h0sDm5Ksw3k5jA=;
        b=fXpEvOoQdbKwVjwQVUk2SdSsxoGEX4QcNyUsG+cMY4I1cP9M14j8iH1jSeZmrrQaW6
         dyZlPb2QMF74OSZneDIxNB7OwkXrVdeuAe0nojA1T0Lx1MFmPuehWrAdMI1LnCKf2fpU
         c+fAnb2y0SMtBbWml7qQVj9OwPKvpdST1E4SKa/47lCjzPd8jVv79vDtv37NLAg2F+wV
         hQT+DVdppzAU1IJ+6CzMlF0/MuGO58+YlP/ygNRZBsmMqGnbbmDLTuJ+QVOSYZLgL5tz
         eOITBKkJf/zCrTYinh/gDilslVgckBE1coEmf4a8fB9dE9OIuuCsqFM6CRaR1AKljnAM
         iQEA==
X-Forwarded-Encrypted: i=1; AJvYcCW4FvLc7rLqVEYSk6++fhozXmkA7c/jhprCFfYmhlEhvabDEU3VKOjT+tBi8WIfoM7da3krwlMa0wqjRzBwimw=@vger.kernel.org, AJvYcCXsu/SZCJMc4BNUZFSgbx9sA7Ci2QVaxtbORZXQ/YHDkTfTL19MvrzTAXgjKc9+q87HjqdznUaHciSK0Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5CaVzU43bUYp4KtNZVuTqzBQIHguXslSTkDMdBLcPUVKloIq
	s1ymPLkSOxqnCMsQwtbweMzLOhYJQ9ml4CnLiOQsOJFtVfQBD5lws0FwFHn+gusrTVyxMn68LmG
	s+zRaZrmSkpmuyhCi84yZE2qulhI=
X-Google-Smtp-Source: AGHT+IHb1MRDNO0gqw9M4M/zgZqsXTO3f0QlKo7gx2naqOwIh5UCA7LEv2cl+FmyAKUFLrp77x6vQZEhv9DGKdsUt60=
X-Received: by 2002:a05:651c:1602:b0:2f8:c0bd:d65f with SMTP id
 38308e7fff4ca-2ff2016dff3mr14921521fa.20.1731070444628; Fri, 08 Nov 2024
 04:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-3-de650678648d@gmail.com> <CAH5fLgiMHE5GXQv8pSR_KYWsa44zr1o_FNrg1mj8QuTvNQmXhQ@mail.gmail.com>
 <CAJ-ks9=Ej0St7XnmvTysdnjPHh6O+4XdYFC6LouwEJR9GpUPNQ@mail.gmail.com>
 <CAH5fLgi=n-v5C4hH-+uozbiwwWCU_QGzhxfdTXfTyyy2ejJR+w@mail.gmail.com>
 <CAJ-ks9n8eSPsb7_RqWk-3OgtsrZquA=94uBopkdwtHuTPUisaA@mail.gmail.com> <CAH5fLgjukqj49UHw33uJewc5Z5q=_f4uXzv2jyQ2=2eFCyWa=A@mail.gmail.com>
In-Reply-To: <CAH5fLgjukqj49UHw33uJewc5Z5q=_f4uXzv2jyQ2=2eFCyWa=A@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 8 Nov 2024 07:53:28 -0500
Message-ID: <CAJ-ks9m33v4WddztHWOgCkBWuO0RdfbE8iZKj+1EJ+YBLaGyZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] rust: arc: split unsafe block, add missing comment
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 7:47=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Fri, Nov 8, 2024 at 1:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > On Fri, Nov 8, 2024 at 7:37=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> > > You could write `unsafe { (*self.ptr.as_ptr()).refcount.get() }` to
> > > avoid the as_ref call.
> >
> > Doesn't `(*self.ptr.as_ptr())` have the same problem?
>
> It's not quite the same. Both `*ptr` and `(*ptr).field` are place
> expressions which do not inherently involve the creation of a
> reference in the way that `NonNull::as_ref` does.

Thanks for explaining!
Tamir

