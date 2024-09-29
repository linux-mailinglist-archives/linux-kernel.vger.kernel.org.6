Return-Path: <linux-kernel+bounces-343216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 001AE989841
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37E11F21AEB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA3C15666D;
	Sun, 29 Sep 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="QwTmHPm0"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14824C69
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727648128; cv=none; b=WCwrKlZ3i6EzupPnZc41v4oknEbvkEuJUe68CIHM0Lwyjoa3owzmBALaRh9aWV5p11g3+Y3tGkunSwxKLgoFzSW/5QuLLmZ563y2Ml6ZVDCbTWDsbWL3YfnQacxks4iRI16oMqj3Jxxy/nGEwSm1LCj2FgGfu09iS1K6ni0euik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727648128; c=relaxed/simple;
	bh=0eFr9Bk5xiWCz8BgzMTr8R6G4u7fPxSTQA924sYJQ3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwsvHC5VGXJRjJR2Jbrw1LMWBuDTqXd/M58YqHj2VMzy3QZokD/q3jSoOFl49AomhKFjxSo6W8i31K5HdMIpyNM1WvimF7OyYwS3wJ0ucYNkGPclq3bzi2l6+sugV8zo7A+m8qQ9IY7kTCEHzmVaOsWC3bUEUrpgs8gzbF0kUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=QwTmHPm0; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e25cb262769so3213680276.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727648125; x=1728252925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrDiLAAMBLULdnd9JA4k6M4CX7P84ubsQWj96kmGwtA=;
        b=QwTmHPm0jVo6pp0zIpw77t+Ks8LL6QUVmnqKQrjxO+HLhd04jl+88KZUqGEsu2/Udv
         kcoE6pHDDOSX2Y2+RD459hT7VWHgv55lAiMiN/l8zK/thOVtJBCXwkqD7Pc1Ags4Rd5E
         E7381WKIMz43F8wMHe1v9OXqCJ3C2KK7Fle47Yj/jikt2Em7eO25oj/ZZEbCFSDWg7Ke
         C6xS3/CwFMCrJxpm+qPXg8/SXEe/3nDJfDl3qB0smnLO2qBp7zYqlLTXuMbQd5JYwMcx
         M4elvFITfBcCCsdgiHBVyNE7S2lm5Pi7Uwg5jyZTkWti8scYVE2a+Fa247tVoq4/ZScR
         1gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727648125; x=1728252925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrDiLAAMBLULdnd9JA4k6M4CX7P84ubsQWj96kmGwtA=;
        b=gEV8rrX98sZG+g99PzYuIAAcCH1P3vochzdIElkumAyuUs2VfiLsoKDai/Z0YRc7ie
         N6+XdiiDHU/OnIVtghVn1MyWDvDACqMA4olt69Un8u7a3FYG5NGpbCUEVHsyM/cMWPgZ
         wXnceoM92fC/KKO1lIwDKZughaNBjkyxAucXROFJ+KRY2w6vWZt0anmUctf1YvNfgGyV
         nawfBfbmgeWVCFHZphgCafBep/KsSBZnETHDzMQQMfJAZbGWMUgEU+kdSQ7Ef65LZFZP
         yMohhoV8SOPosefdPRauD4b3mcWRQylZyLm60bRZSxZ33TDL0ulogSsIqpMBfB/1fNRr
         /+AA==
X-Gm-Message-State: AOJu0YwzWELoIDBbMNUFzsHFCajccp9FL/VQl0W+l/r3dxsdpheDk6DD
	VVVHau59pKfWRdBZSay46vrNcH80+he1EFbAV1mjKN4vRc5R5sdjRuA5EjTLTgAwxJ8WRj81qRG
	vL0zo86S0w4UNcYrqe9qojeWiCUvN4TOc8HWjuQ==
X-Google-Smtp-Source: AGHT+IFU+upOkL1h5/rmQ3rjwqb1zvlkH0/0EkyJvLl4+CPbB389BnqR/RccU4a6zbMBvHq9yezHm2LKnS7F8Es7voE=
X-Received: by 2002:a05:690c:2b88:b0:6e2:2c72:3aaf with SMTP id
 00721157ae682-6e2475b980dmr54851107b3.31.1727648124778; Sun, 29 Sep 2024
 15:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
 <bf6544faba2b53ce901b2e031f3d944babcc7018.1727606659.git.hridesh699@gmail.com>
In-Reply-To: <bf6544faba2b53ce901b2e031f3d944babcc7018.1727606659.git.hridesh699@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 18:15:14 -0400
Message-ID: <CALNs47vT=g2D7A_cDq_8F2xJRJTK-7KtQY4brFYfkopyCSjLTw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2 RESEND] checkpatch: warn on empty rust doc comments
To: Hridesh MG <hridesh699@gmail.com>, Patrick Miller <paddymills@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 7:16=E2=80=AFAM Hridesh MG <hridesh699@gmail.com> w=
rote:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 39032224d504..c75bc3927bf6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3884,6 +3884,13 @@ sub process {
>                         }
>                 }
>
> +# check for consecutive empty /// lines in .rs files
> +               if ($realfile =3D~ /\.rs$/ &&
> +                   $rawline =3D~ /^\+\s*\/\/\/$/ && $prevrawline =3D~ /^=
\+\s*\/\/\/$/) {
> +                       WARN("RUST_DOC_EMPTY",
> +                            "avoid using consecutive empty rustdoc comme=
nts\n" . $herecurr);
> +               }
> +

We got a request to add a rust-specific block in another patchset [1].
It would probably be good to coordinate here and have a patch adding
an empty block, to be used by both of these changes.

[1]: https://lore.kernel.org/rust-for-linux/a9112679-b251-4b98-b55e-e8aabf8=
2ad46@proton.me/

