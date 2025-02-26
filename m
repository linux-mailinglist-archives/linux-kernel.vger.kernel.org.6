Return-Path: <linux-kernel+bounces-532700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4FCA45127
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C158A3B0184
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88A92581;
	Wed, 26 Feb 2025 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU7wpRdo"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CE382;
	Wed, 26 Feb 2025 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528353; cv=none; b=rzqx27RBHxDSQdDqkBfkIa3UlklqZobKxJEOsnwR0BcyEQhlgUVAz12uBexklrF9F51zuMWg7du9DASJDqbizJcOhewSnJPBqLDYRzZrk3w7ey3DmgKL2JisR2cet+vwprEAgYHTwZlzaIeJ7co7Kqd6WWF9JfnVE7i0MK+8EGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528353; c=relaxed/simple;
	bh=o7nXJE4/tR29kcZ0RxLhCK5271BhFYlP1dAyO4djKgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8V9j11nm/ChqqcVeTRqjvhk7Ha0W3eoLTlNJwWKLXWXVk+lz/LjwJA/Nl5uWeE+V35DNxIVY5+iDdyJi0j01h2ktcBY5UL7Ggopl5Kjd9abHp3fHsMJQf1WkTT9s8RZVn2Fw1So7cRlauDOD55bWWzaTvEYeV8ArJ+dr4qo/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU7wpRdo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d47b035fso14290765ad.1;
        Tue, 25 Feb 2025 16:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740528351; x=1741133151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUAvjubYZLJI1LaubMDXI2X+TYdJbP6ozpKUS1AuvfI=;
        b=lU7wpRdoLjlBOXXOEOq9wS8w1hxYm52agVSwlDTs3RtDm3LCc6SHAIOqvPsSa7LDo7
         F+xSMpql2NBXD+cZrS2AENP9UZYr/BsyIShoaN28TJgrV0QUtYnjuqr0wLXWjuqxiFFu
         VEExmsE+K2KxChO6OkBs/7GlwqLQBwHWXcFxfdR4z8FBkEVLuxAExyaKJxIDg8uWoWuf
         LiqG6I4csj0DwLhNxW3Hezo1rFnYV+SVblfddywkCTLpvCdIk3gcxrDluxst7TxiBeJi
         FOuBkZ8CVTWigpdO+plDyFBGbOf3M8Qabh9itoR0f6jf2aYKl6DaBu6wlV1fLpH0UzlU
         gxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740528351; x=1741133151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUAvjubYZLJI1LaubMDXI2X+TYdJbP6ozpKUS1AuvfI=;
        b=cG3atMlIb1S1CoyYHk6auxkgGEGjIapfON4VdqCLMs4ewxbrQtCQwJUMXj6+sEruNT
         gvZB+7hW3AkMwaSZFjp/hLW9rFsjsONoZGZ2rLmphZuL5yyPuoXKE8YCBT8X7oIkldy0
         90TDCsc4OZbtzqvsOMA/iha8NoUtAHYH98vPhPyM6bTAS/6f2dV1ArEUQOWQxQdjmKfY
         HOf6w2Xyr1oZJbDr9qB+H3KxWWR/9wAw4dzN/A8RvtoSuzrtZvyNPVjz0rDiDMyMIN1e
         gfTmF0DnxsZ7l0K2sdtDULJUmFWdSiOPYzVHlKPdejNAL5o72dhOkqcZY73qX4rESZNz
         uDjA==
X-Forwarded-Encrypted: i=1; AJvYcCViPd5JQhGeBYvSkg4i2s0xGuLrL3iOagI1EtPzk70OXAqCnHdL0jSYGQpMeB2YmBaVQm8x+gpV+S0tAz8=@vger.kernel.org, AJvYcCXQppR351R3mw1WuhbRl7jwGpZyLYsmoMCLHnC+oBdBLxrSR4E/7Vt6FjN6Q9twV8DROVvO+/yj9XgZhd35zEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPcenCQiftBi+Iyg2PRv9eqzis+o7Z0xIAfaj5M/GFFnV5LyC
	yiv6zjeMc4LgBMnHApf7tAZ4vJKX9VxugL/2sZDSUY26Yzl6Vtcbns+JpMxtriXNpWPQx36P4zB
	yHhdkBxOPz9JGpi5hfar1i/wrvN8=
X-Gm-Gg: ASbGnct422bMtgeoq4oqFCk1/VGChLZ6wBHaLulAjoth4rjwn6HClGNmQxKr1nhiN8D
	uPzl8J67KnA8gsH1FCNKDqBsXseahhTgJExIncCqXZDHP1fXdX5rK5o7kyqtnIxYOBNwLHLnWQA
	UfmHpzDuI=
X-Google-Smtp-Source: AGHT+IHxJYtBEK/vIkPSuGiT2cdGhB+Dp2qltN3Si2ziuSqv9qgyA+WLvw+xjFqa1MqLcr61X+91n33B0YCU5Xe3tgU=
X-Received: by 2002:a17:902:e74b:b0:216:30f9:93db with SMTP id
 d9443c01a7336-2219fdc4218mr116488315ad.0.1740528351197; Tue, 25 Feb 2025
 16:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
 <CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com> <CANiq72kSdPvh81uOm=N-=37f7NT7udRV-PozfO2pcfbT6aaWyw@mail.gmail.com>
In-Reply-To: <CANiq72kSdPvh81uOm=N-=37f7NT7udRV-PozfO2pcfbT6aaWyw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Feb 2025 01:05:38 +0100
X-Gm-Features: AQ5f1JqmcnqUGZJTUm_HLdCmNW5apMCMsos5veOlcb7tjSSn4RdGk-1LU5FePhg
Message-ID: <CANiq72ki6evya6T3EuPQGbNMgaDv-O0XRvJAYx5U9PxOY=tJVA@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:45=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Both of them are essentially `restrict`/`noalias`, and thus no load is
> performed, with a constant 42 returned.

I forgot to mention that while having so many `restrict`s around
sounds crazy, the reason why this can even remotely work in practice
without everything blowing up all the time is because, unlike
`restrict` in C, Rust will not allow one to e.g. call

    f(&mut a, &mut a)

Complaining with:

    error[E0499]: cannot borrow `a` as mutable more than once at a time
      --> <source>:10:19
       |
    10 |         f(&mut a, &mut a);
       |         - ------  ^^^^^^ second mutable borrow occurs here
       |         | |
       |         | first mutable borrow occurs here
       |         first borrow later used by call

Even then, when one is around unsafe code, one needs to be very
careful not to introduce UB by e.g. fabricating `&mut`s that actually
alias by mistake, because of course then it all breaks.

And the hard part is designing APIs (like the mentioned `Vec`) that
use unsafe code in the implementation but are able to promise to be
safe without allowing any possible caller to break the castle down
("soundness").

Cheers,
Miguel

