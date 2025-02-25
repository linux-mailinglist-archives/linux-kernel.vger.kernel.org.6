Return-Path: <linux-kernel+bounces-532663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B396A45077
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2FE7A5003
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3212309AD;
	Tue, 25 Feb 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+UfumVw"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA822FF3A;
	Tue, 25 Feb 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523638; cv=none; b=WBltsAJUA6tbySjwcRwAz/odJxRUAgaZmF3SunW6pr15Lf/0zzuWhH7nl9tFdsZaQ1GyX43JcD48BAFE7K6xpNOvuXnI95qQEEERNAjuCuv8/I2prfGZmOk40Yz4euhe9YbYwtcw4W384chm2CU5jtju0ORQ9/IH1P8o9rd+MMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523638; c=relaxed/simple;
	bh=ny2ghrdd8gmVHUJmIR5VEz+T3IjMS6VPe2m4WRZaJOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMR2UwRIxYl+hbWG6xbPFuhso534K185VwUyzODkIOvkZNLxHfchAywnKx5vhNoMBj+j+GmpvVxGMX6m6DBEcLwYnvfGsGsM96/Xh6yfOGm4yjM939ahollZBRyZkpm8kS4fNxVRWdHKxEBoSfFiwWiiSaoWyBr1QpqazZuwTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+UfumVw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc95e20e72so1622556a91.1;
        Tue, 25 Feb 2025 14:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740523636; x=1741128436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny2ghrdd8gmVHUJmIR5VEz+T3IjMS6VPe2m4WRZaJOs=;
        b=m+UfumVwDPZqe7Xeha37kAkm72n38I0HD7YMz/ewzh9EtbidG/aDekLUBL6c4B/Lta
         2cP10tnbApRdre8C/+kr+DUPZEfJVVCgZ3X3VfXaPcu9g9t2SINZIHoZi9FA+4ej1CBh
         eYYcynpTzHtQsOgw8yqyQ0Fg/qorGFvVuYzl0PV08Qo6Xgh0L7YJmSaWgr+wJ44OqTk5
         t5r0Y11Ie8t1Lmh0TiPHPyzW9uSE7pWM7GxrUvI7ROoY226QLqJaN4Q4N0zmYgYQmDsQ
         k11LOK2vlsTnmRnoPQH2CA3rffti4tPCTH60H+dRHy3azvaxbWFFs5eb6pTn8RhBwemv
         2l9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523636; x=1741128436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny2ghrdd8gmVHUJmIR5VEz+T3IjMS6VPe2m4WRZaJOs=;
        b=kTbi6bGXN4Rm8iJYnpLV9Rj5KTEyGcITo77Vble7Y/B03/i+VLClql68z8iWpi2Qhb
         mP8RxV/tpTOdC1FrPQGLnfWXECpJRIX5/+w0yN7QeMeYaX53UFTspxbW+yimb7ypucIU
         NtBN1Xto6jb14o5IEXsqOpJolBlyo2NGyliuGNgZ8eix0esTXWViV+bM4GTlMkJ0eFC3
         rlxRJAiPBnlRZq/VigbzQwU63kznqLmX0M8XaAF2JtJD7M1fNH1OJXdmK35qw7H0evNt
         payxdc1AEqVhJqcnLvAXVSZQD6ZCRxuPVxpUAnn/cb69t/k5QvugASJFdQIsGv1EAweh
         NNvw==
X-Forwarded-Encrypted: i=1; AJvYcCW1/hIN0CguQ2AR33YwcwBcu8utsL8t/4XbFprXWgsL8rlzC0OWv5+7exAURE23nQ+bYcMW7/mx46ScT/c=@vger.kernel.org, AJvYcCWSeKTuClePOE67kECKIyyCILVhBmpmv8ztDHfESpUyK9H/eFF/DobHS9vD4A1+Bi/Qm+Z/bl0Zm+varjxpcaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Xp/suiWdj+/e9IM3FRQ6OExRFvdn6wna6Lu+bvo5l4iAVrBJ
	3sU/ZAxzhsqro5iUgEbME1uEAshNNmFIok3lJWnVVdBkq3TSXZgJvLatYOeh9YCPgHW38qKQdSV
	YIaJkvGvShGPDHbzgV7+GxG16q04=
X-Gm-Gg: ASbGncs6XOpwsugLPKf1N0FKany7z2/Vxen1iyjDoip8VMXoW8juzZBwRMkvVLthe6p
	QlKKr8GYkxKlJv+99xaDTo1tJ3h16os5b2Ga0Xt7jeZRha3HgCH36v0EGQ2BRKb2o9EN8fsL9hC
	QqWvBcMhI=
X-Google-Smtp-Source: AGHT+IGi39MZWp1FrqUalH4zLCzJZyUAjKjFfaYDXFXZ7HT8JiWDotjXJ+45bzkp2240ucesaig3+7yZTGxqAKsS4SI=
X-Received: by 2002:a17:90b:3848:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2fce7af8da8mr11771572a91.3.1740523636156; Tue, 25 Feb 2025
 14:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250224002745.7d7460a7.gary@garyguo.net> <CAFJgqgSNjF=LfrCNTH3GdYssXz9YG-AeCtpibejJ7Ywtx0m3HQ@mail.gmail.com>
 <4cb1d98b-f94b-410a-be90-4394c48bdbf2@proton.me> <CAFJgqgQ3P81-iskGu9R+T=c=wyB2K0JqUhx+Gj+6mkYeY8-ORg@mail.gmail.com>
 <a4b79751-f1c8-4476-98a5-c59fb2e545ad@proton.me> <CAFJgqgRdiQ29bWvwsu11yokZb4OFF7pYYUU=ES6CYv9847KgVg@mail.gmail.com>
 <c05cb400-969d-44a1-bd40-9b799ed894d7@proton.me> <CAFJgqgTs3h5YagY1RU2AZf3wKWKfXiPTE2mx7CuWyzN=ee-k3g@mail.gmail.com>
 <137dd7ef-b8f6-43df-87e0-115f913d0465@proton.me>
In-Reply-To: <137dd7ef-b8f6-43df-87e0-115f913d0465@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Feb 2025 23:47:03 +0100
X-Gm-Features: AQ5f1JpvOh4_I-FDP0Z4g4cSDvvRBjbQMQSAXGa5UM-gHOivr4L6ainO45xfxNY
Message-ID: <CANiq72=L4AHq0dNYV-KBsYy_TJwfDRwR+GTJn81EXs=xefvdsQ@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Benno Lossin <benno.lossin@proton.me>
Cc: Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, 
	ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:38=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> I do not get UB when I comment out any of the commented lines. Can you
> share the output of MIRI?

I think he means when only having one of the `pz`s definitions out of
the 4, i.e. uncommenting the first and commenting the last one that is
live in the example.

Cheers,
Miguel

