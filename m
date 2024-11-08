Return-Path: <linux-kernel+bounces-401608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5EB9C1CE1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DB9284F49
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA4D1E885B;
	Fri,  8 Nov 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI5tM7gJ"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D81E767C;
	Fri,  8 Nov 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068660; cv=none; b=YBxQgKTr60wfRQCXKP7iJBMu3qrMfXtBoNtK9/cPgqnTKOkWsFExm2eGAyhqTicNq3TBPBpvjo1ryPasLfJblARBHafT1jfpB6p6LVTqNZFI+Mxtr/PsFm6fEuQnCtl3SJFD6XWqyV8T05cwI26FRkRp53RzGrjKL7IGSp8ap2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068660; c=relaxed/simple;
	bh=19VOh0mfo+GkU0/6whFY/DMa3nyp2+WBMNfzkRFhso8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3OXhbKjc5AAdqXY5pRPVo8hl9jhE0J0sgOA4xaYZVU6Mc8bJvElsB22a1iQaMpvPeqrPJg+iwigQcx8b5AePMEwzJPhXtvioR7v/6B1L+v/QAnllZEfbg53cQcM3BdH35ucybWN2eKFW0vAmOmHielpIdgCrUE/Bi/Kx2hePTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI5tM7gJ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso19382671fa.0;
        Fri, 08 Nov 2024 04:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731068657; x=1731673457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19VOh0mfo+GkU0/6whFY/DMa3nyp2+WBMNfzkRFhso8=;
        b=lI5tM7gJ0c1UzZ9MPFyGQB7ktJugfnc+pQstvqfOBNAJfwhtm58BjTX5DTJoJKmJwT
         mu3ctwuF7nI9QBKJDO+ovg+3SynJgn0NKvhAfNe634HOeYrVV6fFr/Dgts3Z9YM06wiP
         XtSSSMC0Lwy6QfKDqJLYjstR9odAQXtjWxJa0JHv59/3N+VxrRlcncXv1Zpn6nHVUkbJ
         kgJnYi620C7JmsOr+f9WKieJkQZi8PmqYnWpxnljr0GFQLcHwTdh4ZSodjKr8q5HUd6f
         /ZIBSLdosHgrlWmyUWcwbAb6e3uMevZx7CWysoH9DqHz7TbgecQihXkkOD/ssCER+09i
         VZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731068657; x=1731673457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19VOh0mfo+GkU0/6whFY/DMa3nyp2+WBMNfzkRFhso8=;
        b=GVg9/VZyx7++OZE3xQc2HpDnnxLR5S/cO0F1ZCOqhDKXsHuwRlYgc2iVo7jeSLhVsa
         umjDthxorD0Z+bAjHOWsCkkSBYIs5VDH9don5PXUX6ZWJa2f/oZ7y00lwipykONqv2WQ
         zEE7ved3zKK52vcU4BLDIarGCreD4MfPDr2S1S800uSn0apz2LqrgH+Xg24pGpJTvg14
         uZeAGvsFf1jzT9TK8gCe6ReAhs41J7R2vWwZ0DcvnPUGmbDE6ZTMNn8q/qDsN+lR3ek4
         HvvjhI6wBgI0+IyyMAeOyPzPWKrjm+6p8W0EfDp42S8LstjkXUAWzGRPVsR82yayaE29
         IIBg==
X-Forwarded-Encrypted: i=1; AJvYcCUGJXjzjwpvTzaOv7iMTW9gJYXIKFjgmWYjIIipHyg6QRlEaboZyBUjd7vbPcQ8xOnuNlO7tFN4d2rdxgf9jwA=@vger.kernel.org, AJvYcCV0h2rNtq1LA8PpvfDIb68yWrt0BFcoEpsNNPLwzhWEUFE88cAbbU4612ffhYqpFSVZyfswD49imoXxOEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBYoencnPx9MAKZp9PShF5kfjSTq7+/qRynOGhdDebSMeVgVs
	FultVr230sAYoLxWOazxJ2L5eJsCjA49BrzxhEjPE8fP9UQcBCHqJJsHNb1Y/i8Wk5fgYGn7vSV
	K2WLGbg4dzpNodl/S6B+HckbZ0ok=
X-Google-Smtp-Source: AGHT+IEGspbaqqpTSvYg3MFUuaDdZlJOHhSuCJ06Z+cgzGLAz+L4ChvxSYk4aZjUWABaiwlVApX6ikLX0yzbAcqanFQ=
X-Received: by 2002:a05:651c:1551:b0:2f7:5f6e:d894 with SMTP id
 38308e7fff4ca-2ff2028a857mr15426871fa.25.1731068656979; Fri, 08 Nov 2024
 04:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-4-de650678648d@gmail.com> <CAH5fLgjmVaGiHGkZa+hUmLfEJVQs7irNPamXJGu3Q-x8oPw2QQ@mail.gmail.com>
In-Reply-To: <CAH5fLgjmVaGiHGkZa+hUmLfEJVQs7irNPamXJGu3Q-x8oPw2QQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 8 Nov 2024 07:23:40 -0500
Message-ID: <CAJ-ks9=JNfhWNf2t08nbkMROzXme7k-NHtg3psag0dWjYDnoTw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] rust: change `ForeignOwnable` pointer to mut
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 6:39=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Mon, Nov 4, 2024 at 10:20=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > It is slightly more convenient to operate on mut pointers, and this als=
o
> > properly conveys the desired ownership semantics of the trait.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Normally you would put your SoB after RB tags.
>
> Alice

Thanks, will do in v3.

