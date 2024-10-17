Return-Path: <linux-kernel+bounces-369687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F79A2108
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19521F2794E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC781DCB3A;
	Thu, 17 Oct 2024 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2uOc6Fyj"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A161D517C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164966; cv=none; b=Cf0+Gr0AIVHgizEQcauqwoxwrHNJp4BuHEz4eXVKZt8DB+rTazZaJOTTLNBMBk74Pq51l3hD3VGvoP/kQm4Su4kr0GPTcHfzleqE24FBOFEKu+Z6HEOumHsMpbD2dT1Ih/NLSnlw5uxT0HD0HqhAD+kqMalR+nWrJSMh7lSXSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164966; c=relaxed/simple;
	bh=Sy/DXM4pRzPmWe5V+bTLfH5NmwJxXluhw8HitOORpCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXHFgNAoL9Ze1XwV5L2b9X2gOFQUja8kPCycx0MKrm0chaTlmbvBuMZS3X+d5KImBKenXw+9lnBVtyL/RDKSBeyCzQlZjIYdHSSxqTczIPeSghDNculeVzJgKXPnPHhRWfwJS7DKihMbnVjhcgctJvnxlHp+GOyHEFC2zZj1z+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2uOc6Fyj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d41894a32so589294f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729164961; x=1729769761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+wLTTflWqI7DwX3CtVzbxrUPGaxb2nfMLXt3Z9pOZU=;
        b=2uOc6FyjPSTk+2i/cb5sxtRwtjlJ6l0y4TdiL2ovZYWVZiy8khRuOYHfs9KvuEuveh
         IivHAG2YM6NV3D+w/0VOP+C5IiGXpIdCAKyi6ZaRn4u5MkJh7vFSx7BZO6wwCcsAPB19
         UwDrj9XhhRNuR1uQe+zQR4c/NrTAitM4vvRcpCGYXjZjtTEm6dzq25jS/iDVnHHEge6j
         I8Mr28uG8GTTHtudJ4yYoH/RuNVSUbsc2ybqz+kv7EGj/K2FdbBrOWyA5kzsdZrTjSw+
         LVdcHzF355UWpLNpU4wqn393pFrN7uTj7JeAXtUb4VFT+hgeg0lm7m3IdKLoBQdczVSO
         K33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729164961; x=1729769761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+wLTTflWqI7DwX3CtVzbxrUPGaxb2nfMLXt3Z9pOZU=;
        b=TIbCxzQ3iTW7sIe4Pj/4J0e3oaFZ6d6Wv5UpJllS6RWYpXa0P9Pk0V/eT2HUNP9fKq
         wd8ZJsiWu99px/iLeJOvuq0mE175OR26769gWLXxi7l3nJ/6n+AGDbGj4bSfYB8CDo8C
         XG/8Uyflu+ILirv93QPThK69VFK4P68gIKf4bmFMtpKPiZMR+rhFf6V6e0G3o9agBe9I
         Rjy2tAwMyF8IcvOYJl4ogl8JwSWo/1YsZwwjbnxOBTYFoYTP7P7zIWiOEAaZgKf6MwHZ
         JnTIe5fpyhpPY1lZg7N7nSZbQKQ0Sy4GO+yt7u2OmzBJbEIQu5jV5O2EKIQdawdCirTY
         NhnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHvjxGyIYMKirt24Nwuqx+OMen79AZ8dxW7sIZwB4ZBbIzdMaIHuSN27381/Lc2TU72pyj7xKqdM/u/YU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe32X7sK9KctkIGFMTbgxi77gf2EPhF+1FS7SB/vNj/Yyji7B6
	RH6Hlcyk7iZ3H5NCKVLZQXMsg6VMNAJZshKTqN9FBwUTILPkFT0jLnF4v76oMNv9iaP7b88H/xJ
	TRTMf1K3d3i2ihDaQybl6ahW7vcCQl4DQekUd
X-Google-Smtp-Source: AGHT+IFScq8wKf7b4NIwQ3yADJ8Emmb+sibLS27zjBHCwk1+AGLKIvy4me1EDq7fdYz69Y5S1X8upaam6ElK0/Xz4ew=
X-Received: by 2002:adf:f64e:0:b0:37d:2e74:2eea with SMTP id
 ffacd0b85a97d-37d93dcc0d5mr1815750f8f.5.1729164961032; Thu, 17 Oct 2024
 04:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006225952.45012-1-luna.xin.lx@gmail.com>
In-Reply-To: <20241006225952.45012-1-luna.xin.lx@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 17 Oct 2024 13:35:48 +0200
Message-ID: <CAH5fLghcW5HgHaV43++Pdf4i7kPQ3CbJKmNmACUyw8iZDWzt3g@mail.gmail.com>
Subject: Re: [PATCH] scripts: add `uapi` crate to `generate_rust_analyzer.py`
To: Luna Xin <luna.xin.lx@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 1:03=E2=80=AFAM Luna Xin <luna.xin.lx@gmail.com> wro=
te:
>
> This patch updates the `generate_rust_analyzer.py` script to include
> the `uapi` crate.
>
> This allows a proper `rust-project.json` to be generated by the script
> so that driver developers can take advantage of rust-analyzer code
> completions when interfacing with `uapi`.
>
> Signed-off-by: Luna Xin <luna.xin.lx@gmail.com>
> ---
>  scripts/generate_rust_analyzer.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_an=
alyzer.py
> index d2bc63cde..61214fd2f 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -93,10 +93,18 @@ def generate_crates(srctree, objtree, sysroot_src, ex=
ternal_src, cfgs):
>      )
>      crates[-1]["env"]["OBJTREE"] =3D str(objtree.resolve(True))
>
> +    append_crate(
> +        "uapi",
> +        srctree / "rust"/ "uapi" / "lib.rs",
> +        ["core"],
> +        cfg=3Dcfg,
> +    )
> +    crates[-1]["env"]["OBJTREE"] =3D str(objtree.resolve(True))

This says that uapi only depends on core, but how does that interact
with this patch?

https://lore.kernel.org/all/20240913213041.395655-1-gary@garyguo.net/

Alice

