Return-Path: <linux-kernel+bounces-548832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D9A549CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223921776A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663D20AF64;
	Thu,  6 Mar 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndz2o95T"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213420A5D1;
	Thu,  6 Mar 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261157; cv=none; b=Hq3VfwJBhb7GnRNv9ZateJyTGmzk64lZGOAIfu/pnW1dxlZKazeiYU6OcvFJiM5CmB6/X0DuMWP8fOt8OhnRWI9cBL8Pj6meiEX1bfWGm0i/QKEfWYISPP9HBwqpiAU3G+gbXXRMiG3Cj125oEzHpYL0BsiY2QWolTLnNy3215o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261157; c=relaxed/simple;
	bh=DIw3ZNfmKEavYgsFL5k+QNr2/ynyAQxKvjnopLtQelQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CL3M2zSR6JVAx0K4sxOtXVgN8UyOqEtTLCvDz8rF2rJTDWTh31xQtdn8yOve4kGQQYC+js2JkpLY14K9JAx7986UyYQzzmlQV8QdFgMsKZnGhy3u5KxGka0DNIQNQKFh/8Xhdf7RgTf11MG3EGTiPz6thhlAY9gn2RLKFqMEvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndz2o95T; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so148391a91.0;
        Thu, 06 Mar 2025 03:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741261155; x=1741865955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIw3ZNfmKEavYgsFL5k+QNr2/ynyAQxKvjnopLtQelQ=;
        b=ndz2o95Tf6zAfp1i8s9OYebJiEZZSnubrefa3lMPQesLB4bBNtkoT72h4uuWVQsYAs
         LChgh9VdVn1IcToYhuqePom1l1g43GPztjiwKSDyNvDgjNp6fTsrUhkrKO7pSlPJdsz3
         bIAkE/peHBLD6FYqeIY6YiuJgUWXVJA0KIa5J/yb4RqaRlPqQJtuTbHkPLnM0/RM+BdO
         I8PxlMMalYHeDLKK8Ybb7c1zzSKed9d0Y7SHTvDpiyPLyIoUL99FEVF59qXBSmO13yQS
         bOZ9tdRqLgarS8BqV+OA5SzuQI1Z8XjCxRn8JTvqQUrLklL9ZThDqP0Ag8Ac4hNooR7+
         mciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741261155; x=1741865955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIw3ZNfmKEavYgsFL5k+QNr2/ynyAQxKvjnopLtQelQ=;
        b=elLDC9+1p9SYCt6SwWfTjqehc+q6UBU4gUgLPzLH38ECTokpfkf8RwxMiQ3Tnv+FPq
         lHASb8I7i9Sd1A3BZMUoHQkcFP+fJm6NoY6oDwDfuhPjHzjw0LY5pqPByrnXv38cB5C/
         /Mm/fWZWyxGhK1DC4C2IkQmAlDOw/NB+/rtHHQctSSRFBu63PXDqNBbO/LwL/LNxhzrc
         mm1+JsxLFVVsS9NI+dIBxpwzt2HJMFT2FKduHZUZQAd98eu/VQV1xUZhh8jRf8iEG/zw
         u2Q2oKhE4Ni6KjLVa91iwJMbjIxceRFQeTMd5PdxeRPhTPazuIAamR64+DY1whZovhIi
         Ll2w==
X-Forwarded-Encrypted: i=1; AJvYcCWzJnRs349+Z2N4hJ4nLukf20EC0YES6OiAiBmh1VX1inAnGx4zStHBURCc/OvxzHwLffIVEScRCdG/dkQ=@vger.kernel.org, AJvYcCX0iQEOZvwpnJdYBKHAtYHJ/wyKOOUC+zXq4ViMza7cHkEUD/G8z2u1LLXDBnxRAMSN9tJpXv9N4M165uRCjcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVsKpyodc/oGFUfhJtDbGF5ZwI3priU4UIXhuSEdZfvHbZMZW
	l31JXE98Ma7T5jUJ45AvWFZOq6TcadrjPzJnF5gIYfjpqlNBeld+o+LvPxaph9/SE5MiVEbxZzV
	5TOv/NknWztVqMsb0ZvP1/wBgHgI=
X-Gm-Gg: ASbGncusalSkIXlTgeO1XOfLWLVbGzzTC3dy1PngGkMJydS2wiH/uPJiystLs3xWGvf
	ASY0bHockCo7oBg2HX3NKAPygzx0zF6dutfFoXkKzI7RQIsff5ay6GGd/e/2Pw8AMdRFBSMVeUI
	mzbicg56xu7wacr/Ypqj6WpPQb4A==
X-Google-Smtp-Source: AGHT+IETc3OTWIDbDkbBtj13nzkDlG4jrI+FbbIMUpzhoE3NNH/d0m+A66/omoTe/ImHZUflDCN9IwVVf/kKQ3yplqM=
X-Received: by 2002:a17:90b:4d05:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-2ff49717553mr4247092a91.2.1741261154896; Thu, 06 Mar 2025
 03:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72koDba445gMYtC_VEcFk2+O-Xg2-2y6uMyp7onBy=7rcw@mail.gmail.com>
 <20250306015901.241800-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250306015901.241800-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 12:39:02 +0100
X-Gm-Features: AQ5f1JrT19LxdwelEi_ms3E0EwUNOs1hBDwrCHdoabTj9taDV68gZE71D_mYZhY
Message-ID: <CANiq72n=gFWrv9yFmzntaeR+RH5=qeD_uOs6NiW4dHkdaopKKw@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, 
	ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joe@perches.com, linux-kernel@vger.kernel.org, 
	lukas.bulwahn@gmail.com, ojeda@kernel.org, pbonzini@redhat.com, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 2:59=E2=80=AFAM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> I don't know if I really understand how this would is do.

Do not worry about it for this series -- it is something for the future.

> The rustfmt have a array_width parameter [1], but with this, all arrays i=
n rust
> code will have the formatting that we set. (In this case, is 1 per line).

Yeah, I was thinking more of something like `skip_macro_invocations`
(but it is unstable) or perhaps one like `format_macro_*` that refers
to arrays within macros or similar (but I don't think it exists yet).
I added the former to our wishlist at
https://github.com/Rust-for-Linux/linux/issues/398, anyway, since I
suspect it could be useful eventually.

In any case, without changing the configuration, i.e. the current
status, what happens in the different cases? e.g. 1 item, 2 items, 10
items...?

Thanks!

Cheers,
Miguel

