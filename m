Return-Path: <linux-kernel+bounces-311868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4CA968EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998852839C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA361A4E76;
	Mon,  2 Sep 2024 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="UTTeGmJe"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6591A4E64
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725308091; cv=none; b=Tstd6UTOGjrYex14jBgwSKXtVDQA7NAONO5oFCnfRfPNbYBbbv6iRIgbg114Xo+ijOJDFm5z/4xH3EmyP/bsIrmmIGzfGyQnjgC2OwlbPEVCub3x9AImsBhCrWKZkt8p6x7gVHjRN8IiOfMkwh5iLBMjK1vsBqJxybGROUWzGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725308091; c=relaxed/simple;
	bh=VUBUrgI8fZ9UdZTf7JBIxZO5g8A0/zi0bMsBWCmBpmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPa+zyAb7OxnrY+JcfkowlLl+fBNQDqT/c48CPyeuMSKit80WiA/L2S0brIowHOrUhbZQ3mIF4C74Tk81+HyOEPd44g4MLm+keZCoN8UrNYEvPPYIVrS+VQinr3GHdUw5ALedaIzOTSbv+84/P70N7LbMEjVd8ojGyxIOU3bLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=UTTeGmJe; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6d5893cd721so20424107b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1725308087; x=1725912887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUBUrgI8fZ9UdZTf7JBIxZO5g8A0/zi0bMsBWCmBpmI=;
        b=UTTeGmJewPywWFuxoGo4e2v1cT/VTq1hCiE7ogEgBRNdlRnze46w+3ady4jkTA5+UU
         VtRyBC1b2ftd46znZf4fu9quiVDmEc1BOj6uoCx7XxYPoEuqErhetSm8ioALW5WNOZ3l
         lSV31tpklmLkrIFxHnBNOp116ag8JeJp9RBxCXv68DGVnDiHcEus3UcCfHLtnIuOAKnW
         1ZLmhWUPNW+aegWuMkSGKTDUNiwBnTwfVWbqkzm1bWAh4m8p7U3e9ggnm+PdWjYakbzQ
         OEaqKZ42nK+OGxAhhe8lB9SnkRU1ZLf9Hitnwyd2PzmZum22fhmdix6AaIF1omVIrZGM
         Xh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725308087; x=1725912887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUBUrgI8fZ9UdZTf7JBIxZO5g8A0/zi0bMsBWCmBpmI=;
        b=m8+W5S1RhPpVhS8bDwexaj132iz73B6vEJSfWxJLKPR9cyRlHapLjE94l4cyDlsIbF
         FpC9jM8ynbntCMR+zt4CeWFO0b5Y7goT+b0G4Q0pZqOD7eMyUh+BiQEfU2va8BO/Vzc7
         paFmSH68zv7YYc+2a/EjeMeqgjeLuRIOpXDPuSRkSfeHDb+3Zwn5/BzgG3QtfK7X7bhe
         8Y0AL9r46RW5ieD0hgbmy2NXcD9Rglg93/n8Nm1/N04gf2ratkwAOoIkmKJXuApyfO0C
         xSqv3rOtvcpjXhQyGRQ0p4yEYb6pdm8rnccdrQn7S2ltoVtKn2n7rxqHcAUFwSGpou0h
         j4+w==
X-Forwarded-Encrypted: i=1; AJvYcCWPQ1Vdj6GrvMkn3i3Q8cFJmqNYVCG6iKkeRdq62mvjdQn200CxyApTRI0TeXkwM+xl7f8j2Q/QCJD9+Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvCKVDSVNHoaq4KaAN+egu0RpyUlMjNYzRWfoIQXV9j5pl1Yz
	fhHzFt4+qZrNiFL9gK07dKDmEcUU3iHe8hT0ghqem9IjxcvX8+cNiXPbURWmdFTfMj8AcIZ2xha
	4PRrsE4foTzbvqeJXdO5+QetO5Id2C2b/aqIEZg==
X-Google-Smtp-Source: AGHT+IGsXiR+Wz+6S4QOoyChhXUKek0EL7dfcorJfeKc88gOTnhJF8XcgdnaFG0Y0Q9vn6kCbLybTQ+QQtTSSBDJQwA=
X-Received: by 2002:a05:690c:418f:b0:6d3:f400:81e1 with SMTP id
 00721157ae682-6d40e17f6a2mr89660447b3.14.1725308087698; Mon, 02 Sep 2024
 13:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902173255.1105340-1-ojeda@kernel.org>
In-Reply-To: <20240902173255.1105340-1-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 2 Sep 2024 16:14:36 -0400
Message-ID: <CALNs47s_DT4Vt3WuAAcP54GA7so_aNg=LY4CCB01xn2nGiUjDA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Trevor Gross as Rust reviewer
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 1:33=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Trevor has been involved with the Rust for Linux project for more than
> a year now. He has been active reviewing Rust code in the mailing list,
> and he already is a formal reviewer of the Rust PHY library and the two
> PHY drivers.
>
> In addition, he is also part of several upstream Rust teams:
> libs-contributors (contributors to the Rust standard library on a regular
> basis), crate-maintainers (maintainers of official Rust crates), the
> binary size working group and the Rust for Linux ping group.
>
> His expertise with the language will be very useful to have around in
> the future if Rust keeps growing within the kernel, thus add him to the
> `RUST` entry as a reviewer.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Thank you Miguel!

Acked-by: Trevor Gross <tmgross@umich.edu>

