Return-Path: <linux-kernel+bounces-222189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D1390FE07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7121F233C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243F4F883;
	Thu, 20 Jun 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at4SKJec"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094F1803A;
	Thu, 20 Jun 2024 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869784; cv=none; b=L4FlvI6bAl+pamKuy/7yXmBCD04Mq4VtVvXwADwa2jIbV4YhNRrubgkldiIfB4g4dWslsCgW7uyFBA4GFy9sjtWdEw5g9B/gCddoWK+xKyi3gqrpJh5v3UVu0KcnPuHI93TYdSc8shXK0HxoMkC7vGqg7aY8IL3nS89QpzYgpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869784; c=relaxed/simple;
	bh=o1XFCoagNhJXqXUIiNvyL2xj3ZTqbsjGmTXPfkrfaXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cu9KL4gNAnciqL2HNAP8gnEBa+WNc/Z9q0fMLvgez66V/BbgCTlN+pDJIIbF0Cn+kKlxJXGQDqd4yGLQV6gzAoJ6qz0VTUk9hlwq0ImHgOfNasDCF2e1zR3lX+9lyA8eZi1oFQ0vFKr9vytoGLsZtbqSd7Hh5l9C41f/LDXXkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at4SKJec; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70623ec42c2so499386b3a.0;
        Thu, 20 Jun 2024 00:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718869783; x=1719474583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03ztKaSOsfSrhkNsQs0sNY3YIw2YL4srv92sD8kx3lo=;
        b=at4SKJec8OV17ifVw8wDMpmAbw/WzRisiWjOeGI7l7S64lQNx5ps8H+gfo+dKHBa8f
         RyV8W3Y+ngzsgzN27YlOeqF3zlyZeIJRAPG3AX4lHjYaEd3rEY06eHFrz8nEV3BqkW2e
         DF2uLdFBWBvQlnYb7E6R5yxvIH8E3+/pYtdzTgEcK74sY0ZoC+zA/RCFyLTdDU7aAcpQ
         NHX8eEoyXYR7qbwo6m2hXQps0nR0FU0HB1Hlc+3dOu4dTf0/9A3vR45yhegUrU4o7Egl
         dbAgQx8nXydgpbV69IzcL53R4AC8jtp+OoofzyY/Bvn5A3DWiR9SV1LV/AFdRY7STAYO
         /Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869783; x=1719474583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03ztKaSOsfSrhkNsQs0sNY3YIw2YL4srv92sD8kx3lo=;
        b=rojTDsikBmzG5PwET/kQkOPqyw4vTlk95w7aSz7zcSPoMagLmtOy5Kp1M1SLbaxhDk
         gI0YXybbJ3Q0Y0cggHbeVHYbdlsLsokCakWTTTW3ZKlkGHq9SdQlgUV1vjA8SZUE1K4o
         nHoCCho4EGh5axZnbGnWPJoL+C3Y+CkFar8Tsww0KqAd8v0VU+d4SqsvgNHSfoLrUQuY
         qIAu4Uhdc/h1PWysjk6vzg31ZANgDoexTxUs54C5VcrWNk4Igi1z7ztd9QQy6CJJr6dQ
         gQj/LqaDMXdB/o+6leZwtmKzWViCLhztaGOK88TKBwCu2S5DsWx9EYN9UOgEJE7/nvkh
         MbYg==
X-Forwarded-Encrypted: i=1; AJvYcCU15d73iiC+P7X2LGTbvaMCRv8Fu1RYqjYxj0nAepmM7Iw/2M9VSLAe7/MAQOdYZAwc+bidn4/zSb5MT/ht2oV65jEnxnenymnqDzBtIZM2waB6Jy4Mo5phdMVEx1zGMdtkhu2NqAaDivvEGbk=
X-Gm-Message-State: AOJu0YxXx8tKce6CSBV+J36J5bb4/O05Kaj3uIC5CJvW78rF+rPeC1tM
	ZPHYgG18kiYQ4THWYag5pg3y8aGjxFdZLxYx5zycD+d0fAtW0jp+aA1BdIZGXQy5zEaaDmqcLR7
	ySfClOXklePIbOo/iDQpWQDICQsTxeXxGq/o=
X-Google-Smtp-Source: AGHT+IFnQPdlijHxiRw7/46UUIuekBm8mYgIp2okL+2RHHKQ4SYTYcEaoXKAkOsINHNkT/pVxZp9JHadT4awGf/9D8Q=
X-Received: by 2002:a05:6a00:26c6:b0:706:2be3:a2e8 with SMTP id
 d2e1a72fcca58-7062be3a3e1mr5664579b3a.9.1718869782582; Thu, 20 Jun 2024
 00:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620021112.136667-1-ethan.twardy@gmail.com>
In-Reply-To: <20240620021112.136667-1-ethan.twardy@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 20 Jun 2024 09:49:30 +0200
Message-ID: <CANiq72nSP8RcHuDmcPWAjjvYtyULi=g7tGcqOo8nKo2dN9evVw@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: Fix unused import warning
To: "Ethan D. Twardy" <ethan.twardy@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@redhat.com>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:11=E2=80=AFAM Ethan D. Twardy <ethan.twardy@gmail=
.com> wrote:
>
> core::ptr is only used in code that's not compiled during test, which
> causes rustc to emit the below warning while building the rusttest
> target. Add a conditional attribute to match conditions at the usage
> site.

We have an alternative fix (that avoids conditional compilation) for
this one in the `rust-fixes` branch that I am planning to send to
Linus this week.

    https://lore.kernel.org/r/20240519210735.587323-1-ojeda@kernel.org

If that one does not fix the issue for you, please let me know!

Thanks!

Cheers,
Miguel

