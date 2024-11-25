Return-Path: <linux-kernel+bounces-421367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA999D8A41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE702857AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FF51B415D;
	Mon, 25 Nov 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9kaCpQ9"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C41AAE0B;
	Mon, 25 Nov 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551995; cv=none; b=hQ5UTse7uM868NzKtE5c11X+pZMIQzPTYjUXsKaPk4T8XjQj6R6rszcg4IOEq7zFakJA4MLAFTvddBcV37Lqeetja5i1QJA1Y+UJofjdVxVLvTFGnjZyLjm1jf81/NBpK2W2OEbMe0JmMoq2ijnG3O8ypG+p1WIydgeBc0HW/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551995; c=relaxed/simple;
	bh=l1qWIVwvXjEkCYh8peO0L0gffJPk0BmLlnRXYEB1NGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qH8//xJXAkkZTmOW+PKMIvqOHjgkKqI+60IMySRb/pi95HQLQ6D3NQhFyaJ7nQfJwsKxrVZQoC8mhyLL4VAgcXOxfqL45KpKWAjy0NbGCmViCG2LRTjF2SHgHmhvPRb/AYnxXoPxZiTkguUAqt3wValiEnPMrqmaRgs001XyJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9kaCpQ9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea501acd25so825872a91.2;
        Mon, 25 Nov 2024 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732551994; x=1733156794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1qWIVwvXjEkCYh8peO0L0gffJPk0BmLlnRXYEB1NGg=;
        b=Q9kaCpQ9kHMktGt1EuVvf/m9GuznjTrBoIot2z7JOhK7tk6dkLM5tGBH/+6csrs3lT
         0MWXrWqrqhBdGXA/zgOtO9TH+obDnVWbhs8oHT48pW8V4eqbM9hIaDOLNw0ob+JrEqqK
         bqBUZogzJdOrI4eQhQf0qagR+i+Kdb/TNOvg/hFG0jzv7RyQUgryWwiQLGQjDVe7CEBQ
         UBlerpqJIxaoCg+DYcRK2H9bl9BdDMCwfFXDgUyxy+dYPlX2WtaT2DNtukJKwwuANcqQ
         Btw89q+z+QJaduTf64FX3UdRATxwohLm6KJfZ84M3MBUXpdf5qy9KkskuUnpI91n0p0Y
         JscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732551994; x=1733156794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1qWIVwvXjEkCYh8peO0L0gffJPk0BmLlnRXYEB1NGg=;
        b=k7oW9F3v06KYFUJBxfpZhiKuyZn8dtMLAnFxcSucrSMzAM9x4XmWvPmL1PC2fLNUx6
         7U8MTxa3BgrbQctOIl6QexM6rfQBL9miuvsU6ajY6ex6hBwCXdOfZSFcjMrIDasWW0wL
         gBBLmU7CxGUfDo6VOkWwVaeCL52/TBAZIXPW9+pYZsPCYBGWcMwmJy6mGNuhnq5Su9iX
         5H/RfpJwapx7u86D1sQjEzaBtGQxXr2TAnR64Ja81v/St3Y+BNqrObd7yns6XiK1+Kr3
         /D/6vpyKBjCNGBN0ul0DW9697ppBp/VyU8Xe9m9BNsknPb2dRtSjUGYnhHL2Z5Dlh1VB
         ULcw==
X-Forwarded-Encrypted: i=1; AJvYcCVl8JRDllhkq/ezTpfeLjM1E3e+2ZptU5heXdqhXchAjmhM+jNYAjhDt02Yq7V0MiJ3T1YNu4FvrGy8jdx3Hhw=@vger.kernel.org, AJvYcCWUSNy9dMzqKmPx1R4pJhIIJv56Z8SJiUwviaMQFE4sd53wOSi4KjXlvAVydkD2Ei9z14dR8pOjURBPj1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0eyYkudKIdbIPkxQUi4qJ2HPyaLE6tWpo6MLbsR0mBkJ4kDy
	3bORdyM0umjYLYXIf++w4rvRdZ2pL3hcSk8L6phQiV2FpQL7J0Oq2gHfS3xDACU2SDgrq2+nV9q
	YEMNU/56Qr4TojycHynlGUsT4zw8=
X-Gm-Gg: ASbGnctZkrrc8yvoReYse17fJ1f1gPnXYTqMwhadbThUOIZTiGeDmbAotcF4ApuqM/w
	oZuzVtYbEJHVcr/xJKEmVunNA3WV8TN4=
X-Google-Smtp-Source: AGHT+IF+8fEQeszb1CA+TJE0pUpQ7FhynpOE1PM0+96KcWBP3IR2nn1UVp0S0hnjEA6WnDs/Au1QOKwMAvSC3gQFWPI=
X-Received: by 2002:a17:90b:2249:b0:2ea:c768:3c52 with SMTP id
 98e67ed59e1d1-2ede7e68c98mr345414a91.7.1732551993870; Mon, 25 Nov 2024
 08:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
 <CANiq72=axLe_WvPohRRpAnmmPOHtwSK1W3e86n7FMF2mao8HUg@mail.gmail.com> <Z0SjvVIALIkOE3nj@boqun-archlinux>
In-Reply-To: <Z0SjvVIALIkOE3nj@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Nov 2024 17:26:20 +0100
Message-ID: <CANiq72kCWQW1rjdpG-2pxrDJ_oKuTi3A1wyQcAhRRTpNPvV3kQ@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: Fix `ArrayLayout` allocations
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Janne Grunau <j@jannau.net>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 5:20=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> While we are at it, I think it'll be good to add some example/tests for
> those functions of ArrayLayout, for example, the below will catch this:
>
> I will open a good-first-issue.

Indeed, thanks!

Cheers,
Miguel

