Return-Path: <linux-kernel+bounces-349711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A179198FA5A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39311C22D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409D1CF28D;
	Thu,  3 Oct 2024 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFrDu7+H"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2367014F124;
	Thu,  3 Oct 2024 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997534; cv=none; b=esUaH3VVz2ahyPu/JaXXPkjGzZ5wXOpeQ/d8As9kpmEu0tXMsjOBP6rLpr7GlT32YQXjip+xyInT2M+UlJXdGVwdKPLnG+n8ps8n6cHFSZwzIuDcBnTZryk5E8Yi9DKXRPCGLKPC5L5zNuc1eb/70ziaFglZjnrnbKWIMDHZVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997534; c=relaxed/simple;
	bh=Zs6voFEF2fS8atYpq4RnQW9QfrHgLfVzQQOlVAkt/ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/vcLhIoYjXNy2D9h6JGbmJ9KE6i4U6GUiuru9QlMRlAwjMNrP4L2hdipqovJ2mpcRr5kHQeF5jKWE6/THKPJrAB+k3GW0n8U23wn3FEKVZDKMxBGifH/L56abfbAeVpSATVzAKUapamXTjWLkgKSBHSA4VLo52VJYJ+L3PQGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFrDu7+H; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718ebb01fd2so234653b3a.2;
        Thu, 03 Oct 2024 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727997532; x=1728602332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2MMb8prm5UINwUQ8XDMsqJEqKJ+JAk4pdQ2e8y2XKA=;
        b=YFrDu7+HA3EOQHwtkLxZ2jp/ohU7VmWLkBHONj3lQQNhVEe34dmDD6kg8CNJI2VJHl
         OJ0xm3QuUzSF+zyiIJriYEuOCfoRDboj+RVwC7jA81AiMiqHN3fnonPXQZKGMfWg4Yyf
         UnlEyAhVlzi6VuZ2fs5xFTsuMKpWWkeFbB/qTceBHZiS0lVzsamjbPWjj37rPmt/1SmZ
         Za6oJaNvZ41aRJM/N5fWOUd7JMdeAM626DF7wH3gz4p05fiXTPcoyPUlAQvWDXzNeQ1Q
         JKl7bWwjiUcU62wpEHhOHMFSEhLofrQlxAQ276iku1+d1E0RwV0XVpFfouLkezpQejEj
         JpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727997532; x=1728602332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2MMb8prm5UINwUQ8XDMsqJEqKJ+JAk4pdQ2e8y2XKA=;
        b=cVGFoamPfwKXQtjQs/fxr0lHYNWdwRd0W4NWG+Lz6NfvG8v0e+5KWZtTDJHgRI/XRa
         Anme4nQNpmjJHG6+uG7i/oNhjFfmhi/HfRliVYgHBiaCmq9ScPKVlmL9No8rGyw/Qq8/
         srLWspAY3voKvzxSM8rNiqgV3ytm0k6na0cnslYY5E/68mz38v6mrXzaGMEwQidUG79t
         tOanyZOayMK7MGEXaIOQLiiTyT0xSa03lgid4ROXZ+uMcfZ2Ci3JGYmjHntDht6nEXuS
         wYrY/QL87h8CfTp1zsVAtbm8ZZQw2nbBgtjvvuGql91taCw+wXmG8EWaGDJTry33Zs3K
         9t4A==
X-Forwarded-Encrypted: i=1; AJvYcCXcpjD+OFsPp7Zt6u+hL9cv+QZ+YJi2+6OAv0W+YII4TjGwgiNPS2BFeo/w6x5M8PYNiFMnaVKzlkPuawo=@vger.kernel.org, AJvYcCXyw15WAhQ4JWHKZBkXbUAWrbkZ4QuthpSNAe8Hb9Lz5PS+cx4PhZszrIxJ4ATi5BA8UxN9ZPfaR36CTMsZL6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo30U36m8tMki1n+OX2niEbmYYCsLfxzbsg5oY157hUZsi+mv0
	JhibeLnkjsw8cw9tGXLoE5JPNdOaA0Jc5JE21XJ/MALea77v6sWDkIDwUkr1sy4gFYzj4lpa3BC
	uXOKDSPx4JLSCTAo3WRhzsL7HCcY=
X-Google-Smtp-Source: AGHT+IFRNHb+dNwpjPYnEmZro8HD0Su7SI7wJqmlfkd6J5R/6fh4aSr/e96BMjJMCDjRBnC9zMn0tUiJXFRtnpHOYJY=
X-Received: by 2002:a05:6a21:78a1:b0:1cf:34a9:63d2 with SMTP id
 adf61e73a8af0-1d6dfabae18mr632258637.9.1727997532453; Thu, 03 Oct 2024
 16:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003221536.34826-1-iapain@gmail.com>
In-Reply-To: <20241003221536.34826-1-iapain@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Oct 2024 01:18:40 +0200
Message-ID: <CANiq72k0c+QxWkxfZ5f2VvzYmaX4z9hQoYvbPtKfF3pwLq-E8Q@mail.gmail.com>
Subject: Re: [PATCH] rust: update dbg macro outputs in docs
To: Deepak Thukral <iapain@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Nell Shamrell-Harrington <nells@linux.microsoft.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 12:17=E2=80=AFAM Deepak Thukral <iapain@gmail.com> w=
rote:
>
> Hi,
>
> This patch updates outdated examples for `dbg!` macro.

Thanks for the patch!

A few notes on the commit message:

  - It should explain what the change is and why it is done --
currently it just says "outdated examples", without mentioning why
they are updated or what the change is.

  - Please read the notes in the GitHub issue to know what tags you
should add above the Signed-off-by one.

  - Commit messages should not start with "Hi," (you can, however, add
that kind of text/message below the `---` line and it will not go into
the commit) and they should generally be written using the imperative
mood.

  - Please take a look at
https://docs.kernel.org/process/submitting-patches.html -- most of
this is described there.

> -/// //      ^-- prints: [src/main.rs:2] a * 2 =3D 4
> +/// //      ^-- prints: [src/main.rs:2:9] a * 2 =3D 4

In terms of the content, this looks OK. However, a couple questions:

  - Did you copy the output from the standard library? Did you
double-check if our output looks like that (in terms of the column
number)? Mentioning this in the commit message is a good idea.

  - The GitHub issue mentioned the column numbers, so this is good;
however, did you compare this file with the standard library one to
check if other changes/improvements could be imported?

Thanks!

Cheers,
Miguel

