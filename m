Return-Path: <linux-kernel+bounces-446138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806F59F2044
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 19:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7491887FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8343A199924;
	Sat, 14 Dec 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E08cEg5U"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC0EBE;
	Sat, 14 Dec 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734200217; cv=none; b=HZX6EXNWp82gCwt9ZZnCyM6Dm7zhI08F1etw1cOWzDVJ9Osx9ONBd0PfbiW9k4tG60lGzOLPrOvWmy01trXJO8kUkgR/ZMMvbuNMAT83mXilh0r7StC5xBC14JHv0kx1m62kB6vaJt+oRCkIQ384piHCurkosn8vKl7kjqU0MSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734200217; c=relaxed/simple;
	bh=9ySotLG2I7e8lQZdgi7KU14SuDxhDwBtC3BHM7KKGZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tt6ayIURO5hzBdZfc0L9iauUT2yJ6UO+fN5QrA0MIZH94ZFdZcv2SLKlW8Kv1nxDljd6PVf9R7ORH7w5PITvfaHKcLv6JVSpl5jMxo7dZje49YWxT9oLiQTTqCk7xods0zsF/Awy8tGGpqlD7tis3Zgm//wMJu+5smLUOkqfVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E08cEg5U; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef05d0ef18so410742a91.0;
        Sat, 14 Dec 2024 10:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734200215; x=1734805015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ySotLG2I7e8lQZdgi7KU14SuDxhDwBtC3BHM7KKGZU=;
        b=E08cEg5URl5BDATQk5CJeb8Q/GJCIJ39k+1nP7kXJx9ArtEbA6yIT5OvGQSwsXqcLm
         wyOmj5cI0c92Ds8bHLnOaZiYspSfvl0aAn9s3O5GYYbQQ+Qx8Z+mm/xmL42/XwaCakfu
         xsmGO+gkOOUiNML6FM18iSGgSR7lT8onlgX1tq1M7/4CXWf7vvjHeKOvV6gSpZy6NkEl
         dlgpCGZdzSVECGaMCORhKn1UwowMv03xu7tZ8VMTYqfKtRCR8cgGt9FHCrlrY9B4w2z5
         IKJ8QsXileM8Ryv+LCLaiRVnrVgPhASfXTSMz3zVy6BIfKogPoyYCUol4WI5hwzzbI10
         u3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734200215; x=1734805015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ySotLG2I7e8lQZdgi7KU14SuDxhDwBtC3BHM7KKGZU=;
        b=TgbAEEBtXf85Yjzn4VV0we7JiCE6qHRwV6ihQmK/nUiShACQ268QYWtpM28QO7Z3ii
         tlMHhC8/zfx04k4UOZdrA0uhQ7dsHdq1IR8JELqX8KWdLRj1+hhS5OPQMb4Lh7xWAhrK
         7g1aJHaRRFsa2WcGFFeno8upHQS1U4LMn8oxoP0e3dAygmDqv74VNyDD56eLdViUV9rr
         IhknQNNh2JACosjIKPY5Z/PBP6iWtKxiNzWunpLyZS5Duw8R4F/ElA59lxnJgn9RFXFQ
         Ae9+Q/KdWqKlVWakbje894Gpu3W+/s/X+/JahS8L3EmM36HJZGD6CP3PENiUWxnqg1+U
         rhnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUXtm2288SxWb4r4MOKV4jdTsCFKasQ9alKB63r6vVL9F4GrQm5ixBcfrBlK5Y2OlTFGvg9MnxvGvecEc=@vger.kernel.org, AJvYcCVwtrwDIo4y9iJeRGlbL+SfoQYWdNLEPHxO6ZjzxzxYjWM+IsyOUQdFoEaITPCA9gwTjkMVLlvnhR+vwdr8tn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJiprR+qfuno6mmPwCkjXKH3fmjULjEXNFlU4DpTnqD0CbH/p
	GnXum2M4lL/KJN087oCXOVWYqZBS7qnCW8XpPMQihB98mkN0FtuNJMK/olnWeGUcYeZAAHD7byW
	hxJPH03NOUX0HT1T2XkIJ+ZDnHL4=
X-Gm-Gg: ASbGncvm4UQnxDvVJBXE/E8QLkk+JfvN5WobHHmxjKLo65kInCGHh3ZiKCrVynssT1C
	7DoBSrW9e14TomFzp1XtnVHvK5Xgt2Hpfkk4fKQ==
X-Google-Smtp-Source: AGHT+IE6qyFg9sNDsL5Pk2GS/f+8WuwZx/Sv8wQeZG7CEcgORT1t1vd3s++rirzQxQ3Fvz1H1tM20lNf4vHG2+tZAQA=
X-Received: by 2002:a17:90b:5107:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2f28fa55570mr3932799a91.1.1734200214825; Sat, 14 Dec 2024
 10:16:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214065217.195385-1-ojeda@kernel.org> <CAHk-=wgXdJswe7JWZ2G6m11rL4Yxatrz_iFBKpqCO5xHPwMyJA@mail.gmail.com>
In-Reply-To: <CAHk-=wgXdJswe7JWZ2G6m11rL4Yxatrz_iFBKpqCO5xHPwMyJA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 14 Dec 2024 19:16:42 +0100
Message-ID: <CANiq72kd0UTqvFB+PHGeSFdnbO55132u9ZdPgtCPP4TQ7DBaXw@mail.gmail.com>
Subject: Re: [GIT PULL] Rust fixes for 6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 5:54=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. Is it just me, or has github become almost unusably slow lately?
>
> It might be time for you to mosey on over to git.kernel.org, and use
> github as a backup rather than as the primary repo?
>
> But I'll see if I can reach out to any github people and see if it's just=
 me.

It has happened to me as well in the last couple (?) days, e.g. when
pushing the tag, so it also seems to affect the writes. I guess it is
temporary.

But happy to use git.kernel.org as the primary repository.

Cheers,
Miguel

