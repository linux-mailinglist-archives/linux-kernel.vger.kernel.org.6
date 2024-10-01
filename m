Return-Path: <linux-kernel+bounces-346398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B7698C440
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F671C2161D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261111CBE96;
	Tue,  1 Oct 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yko3GG+I"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCEE1C6F7B;
	Tue,  1 Oct 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802724; cv=none; b=qp+Vx/KriM99jRT53oyDqcfpM9jnXMmegD+VJdrJWlcWkDaZg+diixtQII24qcnWJ4BzIG6XzH1EoMRfaWP6tKw46HotfoUiqBEEIvXPd+3j6dAQKyuNVbyK3YVWDk6rSCxgu0uY7mssY/NKi4BE6L4jsUyyziEED8WLf13aQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802724; c=relaxed/simple;
	bh=sC39jjPhAHkzIyKoYVlvv9pTOoSBbDLMVZDLzFNZwoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrTclCmzEOFRlQdkzHaa828osUBfkZgnpUwU/Ctu7vD42G41thDcIYTzGre5swy57N+hbof2Kx3gXHyiYytx96/fhLYZvVlB0rD2uzR/eMu+HVClVFf77HRksw2BaTNzvsTav8T0Qf1JguAJNPJZ6gD/jCrswaTddNC4yrZ3xyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yko3GG+I; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fad48f6f9aso883541fa.2;
        Tue, 01 Oct 2024 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802721; x=1728407521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC39jjPhAHkzIyKoYVlvv9pTOoSBbDLMVZDLzFNZwoo=;
        b=Yko3GG+IqyIZ83+IpsdIgpuGT4EGGf1V9mCoctLzKxvtx0wKjHL6r9fZPxYaDxdbvS
         qGHpy/E+09DlTu3Y9wAqlWaKJQDvwn79zwrPTX1sxjDqDAzQbyEE8S6/pxguvsRcSGUa
         TvLDoR9hLt9FAvAlnczP3LgRrpB9w88ESUy+6974qWMTppCnxDpJvAJAvYsXlMssDCQD
         80B9fvcEdkPXCGaA7enhn+cZDg5SSKc/YoSaEjd6dULcSS2jifHcRJSdXoH9xARMdeEM
         tNX+fnYtGkXFgeSUUevnzlWim/ZmiX3G2YAYDAKi0ua7og2wiQI+9FIbg1C6gWNWsBDA
         a3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802721; x=1728407521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC39jjPhAHkzIyKoYVlvv9pTOoSBbDLMVZDLzFNZwoo=;
        b=Nh/PTHezRl40zQ3U6vmv8IMItbb2MSLXMqW1hy8AHJg75y98821bQ9NWAydMrJPTqz
         9XtuluQqrXcbXaMnAM7vQSC+AGqjdyzrkgdjWVpa6dvzo5+KscU9THg0wDu2dDHHG425
         DGgemHS44i049RIt00yitnILFvd+BT8Ze0ZiZdIQYHEd/j0/pVDhfTeXXWtIdHsfnlx9
         cAOi/FYZY4EDRzJWgYGjI7p4EDsYOj1qJrnlPF4955n4kt0svxQ3xPDhnGSZ8hBMnedl
         ik5y62DPmQewB3DBEasD63U3nTRKFHD5lVfcDzDxoaVVX9dzQi6zywCF/yoCDkHjG6/N
         Ij1g==
X-Forwarded-Encrypted: i=1; AJvYcCUyaV+tXuRtDs4nsjbL5chHR2nfVAs5LfZ3uomZEwfUI8XluT3KSkyIM1jCumyM71WAUNrfGJILx8EKP6Q=@vger.kernel.org, AJvYcCXKAgKB5Xm8xdSO2x7brlBm4/judocRVz32dgjS50p5kY0+RK7rOaUn/ugMnsOx6cx9QFuJhf4OC1v+TrLwIvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLhbjfvGfyGDOSkSQdMsMXmfesc2nT8xvY71iUl/10p9piVm1
	msOE+hdnOsMOQ4DWohjBJL2eQTR9X4CLDwLtJpLShNE2CF4wXZNICVExR1FRScSy+Cafx2jdI/P
	dvOMrWpNZY8ihO3UDRqWWSWknc98=
X-Google-Smtp-Source: AGHT+IHKHRku2EkBhzAUSqu18scL+pCkpv1wbY1i5srIBY1ciu173sLzEq6cGISO9u9P0jB3frWmDXmFZMHcBbV3S2w=
X-Received: by 2002:a05:651c:501:b0:2fa:c4b0:a0eb with SMTP id
 38308e7fff4ca-2fae1020a1fmr1101491fa.5.1727802720878; Tue, 01 Oct 2024
 10:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-19-ojeda@kernel.org>
 <CALNs47vPzH7CSjRh=jW0xNTh9=oajUs4SAkTE2OHLd5M2e065A@mail.gmail.com>
In-Reply-To: <CALNs47vPzH7CSjRh=jW0xNTh9=oajUs4SAkTE2OHLd5M2e065A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 19:11:45 +0200
Message-ID: <CANiq72k21-kke0XFNf0iQ5gpECjAtEPg00tm-JwpNjff34n5+g@mail.gmail.com>
Subject: Re: [PATCH 18/19] Documentation: rust: discuss `#[expect(...)]` in
 the guidelines
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 7:11=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> Would it be good to mention that a reason can be specified with
> `reason =3D "..."`? I don't think we use this anywhere yet.

I mainly wanted to introduce things "slowly" :)

But I would be happy if we consistently use `reason`, I think it is a
good idea to document those, and perhaps we can get to the point where
we go for `clippy::allow_attributes_without_reason` too.

Relatedly, I also thought about `clippy::allow_attributes`, but due to
conditional compilation and the other reasons mentioned in the docs
added in the series, it is likely not something we can easily do.

Another tangent: I find the `reason` syntax a bit too "busy". I think
in some cases we may just want to write things as if they were "normal
comments" (and multiline and so on). Highlighting in particular ways
could help perhaps. It would have been nice to have something like `//
ALLOW` on top of the attribute, similar to `// SAFETY`, and have the
compiler understand that directly like Clippy nowadays does for `//
SAFETY`, but I guess there are downsides.

Cheers,
Miguel

