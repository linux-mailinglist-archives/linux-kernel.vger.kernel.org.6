Return-Path: <linux-kernel+bounces-435597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E19E79F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2383E1883DA9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29906203D6E;
	Fri,  6 Dec 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPvsHXC1"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256661C54B4;
	Fri,  6 Dec 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733516281; cv=none; b=Nvakk+4w5xEhWF+zpIUZRfU3uWNd4jptAxA/ccGNMoFGePOZ04X2TXwZiIt9BWi5ZKilwQLsG59GDxIzjHOVyUwKdQMd94v0iDd1r8RrlYFDN9bx+CroYMbzqDnGfO/jDNOOsjiRNPeZtE9Wf65JBExwqkw53BNoTHMfvGkYdXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733516281; c=relaxed/simple;
	bh=s0HpYL83/GsXpoQAd4zXeFovL9tM+YARNGIodtERH10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXb5xZS2xkb/4ovZPvvT9RVNvr7/FMN+tlBJ0tHE63DUi4Qs+90pyZbA3HSsYNA4IX37QpCvRkCFd649QY8hj6DIqWV/Qp7571cLdW8GGmrKbgACYL3v3xfiEGRG7qOraQY+EK22qJzUH3wtLFUnVjzQnD/0ybLE9Ntcvj7dT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPvsHXC1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee4b72d4d8so271040a91.3;
        Fri, 06 Dec 2024 12:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733516279; x=1734121079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KRjwlLeLlZr1Cq9mFs2/9O3gungZ1VFkbVziUGY7TE=;
        b=VPvsHXC1YYSekTjauCuymKa8E8v+NMruMtwZY1xtU7UadN3F3SfXv2TMJxNUZ9DPOQ
         SyYMbHWZ+pLrPlecdo/3e/mwAIAJEngi+FoMu6yQIfaoXOZwVvActJPN2hcOIsLzZypL
         V33+dIIS3MNRG7CzHrxX3aE3Yc1VS/hwDgXLSkCZ9sLHh3zO3AAm1vVqklDMn4f+9wKO
         SKO5kuaajdDZvVbBYWm9Eowjiko/Vl/3SJ9mA9EfZDxZwhTaVOHrV6zvn10qWYyClKiQ
         /Li0KYEIoPaosFgNDKAHPAA90fTryUUGhcdl0yl4OrQb0SzJCZO0LEPNEdXclpkTZl29
         QYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733516279; x=1734121079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KRjwlLeLlZr1Cq9mFs2/9O3gungZ1VFkbVziUGY7TE=;
        b=KfXF3Ylh6PClsLtBIlt0oWqImjXS06q7R33xbH8RkR9arM6ASPUMK41gZ1F8NX8Xax
         +wNwGnsYvHa3OXRHpGYg4AVHuhBqHqbnmwY8/kj3JsSikEf58g4oDLguvs/bzijEbl20
         MSg7aiZPARq5CK1aW6lTcMxnY9wj+j9L0R3b8fXPhmnW64/Hwsmb4Vlj/NX1PA8kfAsd
         z0YkyIhzL+8eQc1l1yznOe82TRA6Wb1fI9WsHDDAqAIFUt1zXVZNwDy3ulbmglvcHRyn
         7+m4vz1B5cKmHxE24SVljnrq7pc8e4VNGSvJVUF1tGNldxmad74osZQiJ4twaf1UAsPn
         ACUg==
X-Forwarded-Encrypted: i=1; AJvYcCWbGDzl4E8td752RbH3sNzhAgHP5Tesai8oDJm1JYLGe+lXDd0eNrFUuZ59cVvcnN3pc/mqH0wo4KnDneE=@vger.kernel.org, AJvYcCXF/LSdjWCuz8Ve/nTDfGRwfglBijw2hn67dxBmIVKTPrlF9ciuWBZ0ESTFzbMC1k0jV2VLJVsuJsq4TJki1Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJzFplPzJxp/kccVNhsu4O3Ypp1J67kSTgQZbTfi/dFLwu+n5
	pWiyDildYsN1mZBaknqelpwE+PlzC7qawsFMzhOQNFjQ7XL8wqsM2nk4ta2q1+XMA5gOActCAED
	Z7gxGoupDtINB4wfie7bi4ZdwIko=
X-Gm-Gg: ASbGncs4qKhvJ3ls7kFrE8jvTZpjHjx4vx/JLZzP3+Lidm1qYJJFcVIWM9P3XFFeNaS
	ACoQjIFcMczwIKZRigZwCss4R2Fq+3I4=
X-Google-Smtp-Source: AGHT+IGm2S89yMWdzllIN3KD3GHl6K/aWMHBG/4F5iX4Szq8LnCRxkaO0PidxAGvOd+E6Sdmt9W/y+wpSmKZkmX3A34=
X-Received: by 2002:a17:90b:1b50:b0:2ee:d372:91bd with SMTP id
 98e67ed59e1d1-2ef69462652mr2464471a91.2.1733516279307; Fri, 06 Dec 2024
 12:17:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206192244.443486-1-trintaeoitogc@gmail.com>
In-Reply-To: <20241206192244.443486-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Dec 2024 21:17:47 +0100
Message-ID: <CANiq72neo_RtANWJu_GW5LxsR5KWxriS1L8nsXkNn7ioiaEQKQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] rust: macros: add authors
To: guilherme giacomo simoes <trintaeoitogc@gmail.com>, Wayne Campbell <wcampbell1995@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	walmeida@microsoft.com, fujita.tomonori@gmail.com, tahbertschinger@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:22=E2=80=AFPM guilherme giacomo simoes
<trintaeoitogc@gmail.com> wrote:
>
> The module is only accepted to have a single author. If the module needs
> more than one author, you cannot define this in the module creating
> flow.
> Add another key in the module stream that accepts a string array with
> authors.
> Author and authors keys cannot coexist, so add a check that if the
> module authors addss these two keys, throw a panic!

Thanks for the patch!

There are several ways we could do this:

  - A single field, that only accepts a list.

  - A single field that accepts both a string or a list.

  - Two fields like this (that cannot coexist).

  - Accepting several "author" fields and append them all into a list.

Any thoughts on what is best? Could you please describe why you picked
the one you picked? (Ideally in the commit message). For instance, the
first one is e.g. what Cargo does and is the simplest, though slightly
annoying in the most common case of a single author. I wouldn't mind
it though, since this is likely copy-pasted from file to file anyway.

In addition, there was a PR [1] by Wayne (Cc'd) that implemented the
first approach, but it was never sent to the list. I pinged in the
GitHub issue too.

[1] https://github.com/Rust-for-Linux/linux/pull/904

> Signed-off-by: guilherme giacomo simoes <trintaeoitogc@gmail.com>

Ideally add (before the Signed-off-by) a Link: and Suggested-by: tag.

> -        for alias in aliases {
> -            modinfo.emit("alias", &alias);
> -        }
> +        modinfo.emit_arr_str("alias", &aliases);

Spurious change? Or am I missing something?

Also, this patch should update the documentation of the macro.

Finally, the title has an extra "[PATCH]" prefix.

Cheers,
Miguel

