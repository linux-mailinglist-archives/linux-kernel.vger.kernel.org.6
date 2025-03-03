Return-Path: <linux-kernel+bounces-541117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B6A4B8A9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452CB3A6E38
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7DF1E9B3C;
	Mon,  3 Mar 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DN3H11wx"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644ED1D63F7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989106; cv=none; b=NshpEhk9BBK6fpYbQ98+nffQ87s+NPIxUn0J8LA0O+YezS/6A2A/4xxrJFE5JKemJdiklReZqHMR0YWD5KtdzSPIwEjwr61qaWMcUu0NcRT5wLFBqVT1zKMjyBgd/NVCrVjAJB5Js+Ds8jpD4CPFlGpafLTOz+ZKxVjWBxqb3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989106; c=relaxed/simple;
	bh=JHlXb3zul+rNFkDXGVQOrWhVuAYvI+ZjVaYWHjEHsuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+9ce6UjX17Rtbf2ISX4c8Pr1YuC1sw5CkS+/4IlxFIYXha3Qq7BgdCMy/gcdxBTFYmvmktZsQ8UmlseYKO7Z9hLblxq363q1Xb1Xx2dW9BjYtp9RzsoE2t/VioR4p1q8ME6YPHggtpD53JBZM04C5JKON4ZYP39LwVT3hN2enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DN3H11wx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so36815445e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740989103; x=1741593903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBB9+bS3IdAEw2Zo9wy+KIRO8+GAYmgN6Dv1bAKxGKQ=;
        b=DN3H11wxatL3cArjcoi0gb7tLt1aFRvKH5UcTmqmM4Cp8ToSfni9pxgCgQahywKBoL
         wjJzTP+yS6W+N98u2cc+tF0fdh3p3/5ZP+R5bKKwWNUXJxd08hWLrFmJV+0Qs1glcQL6
         BQA4IUQFaDhpOfBqCG3Ne/MSdWvBmpu2k4ej4gLKfA/RxlWXVlVzO+tgVn5J8vlrES0+
         R0GXBwXC2hoExKYNGlJkh4ElT1A1bL57wzGjicGr3hryUZWkloz1UbrIY8Z7AkQs7G2S
         TPG3raYUm0pmfYXCk5PDzChFfJt/G1nN567xeS2T6dsZltZtgvfA4KNr4kR4tcOYEzjr
         /L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740989103; x=1741593903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBB9+bS3IdAEw2Zo9wy+KIRO8+GAYmgN6Dv1bAKxGKQ=;
        b=Wr5xwifzrMN2EO3E4csD9SR8nexVaBWvCYpL44xzevZtGJPZEtaWIbzYHQGhK7zVHL
         6IpnmtbVfgprw2qzbj0APpC/WPj0NqfRWY+nvMVzXAuGAUBDJS5bdFr9+PfC/2sfqFd2
         btCokWFIT8lXcoNt8cWzmrcOqP7Z0ey3oqvx27Xi0+KytCpeD5O6jrNrLWoUyECqZrOA
         a/tBIVoQ22AZbCVzqA1kwOSiE89v16LnYVji+pJAMtKcLDu4eXuHYRp+IAzdqQErLtVH
         PG66y98gi0ulTyNL2xyYdmLE9Wg60FDIQA/pSI+kuz5emRyH0ZT7hyidOVet4ecpTwFN
         8NYg==
X-Forwarded-Encrypted: i=1; AJvYcCXxtUCaTv6SGYjCwcAmDgMw7WxCC4X5x8fI81sPqTPBHE5zAUb3CAHEtCWMZFkbh5thyfuYQbRoLuB2Two=@vger.kernel.org
X-Gm-Message-State: AOJu0YyopsfNmX1siOG8ow8yxJqGYviRVOjekepnbhoOCqS1eVbFdkQp
	uWUokUx0jVwlN0eCGRZZUhgB+rgRFKbPNk3U9ZBzyh4vhmtn6xxyevUEoK9jxVNYVNPQOrLOM4E
	z6R9ZBNR5mUGRYEbi1dcHyATHPISUlf8p5i6Z
X-Gm-Gg: ASbGncvjq0mUdXqPpO5tO8vzU8GPrPi+Wu4o0RT3LtOJD9sioNbQwJyDjbmxgPoc9c/
	A7EDAxuhIgu0PYD5MKZZr+zUQZvtiYfg3VDEPTMZyZmblMMX4dAKd875tXWyTKrPPBydiP5PVhc
	wsju0w56CjCNyCkXHkhfr1LQmdPfTZvj6+AN6vy9hQw4v9jkn0JJQFYmvM
X-Google-Smtp-Source: AGHT+IGpdxgjf0gkSNOiBqhKXbQc9hRhwlo2W/nTX9MqGqqFdt/JgT25MM6r5uWJ1chlgrzzP+QlZYMm6vZ2gmLXFNk=
X-Received: by 2002:a05:600c:3b24:b0:439:9496:17df with SMTP id
 5b1f17b1804b1-43ba66fee15mr102753595e9.13.1740989102617; Mon, 03 Mar 2025
 00:05:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301231602.917580-1-ojeda@kernel.org> <20250301231602.917580-2-ojeda@kernel.org>
In-Reply-To: <20250301231602.917580-2-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 09:04:50 +0100
X-Gm-Features: AQ5f1Jo80hSF1L-_KjqVRtXigJWOzdDSnpQhkOp567xZ9U8afL5p9lZs6wbyFLU
Message-ID: <CAH5fLggKXw-SCtR_vAOAU8KJaAvmNP20egmtV8KmX0xV0DA0dA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panic: fix overindented list items in documentation
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Gaynor <alex.gaynor@gmail.com>, dri-devel@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 12:17=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with the upcoming Rust 1.86.0 (to be released 2025-04-03),
> Clippy warns:
>
>     error: doc list item overindented
>        --> drivers/gpu/drm/drm_panic_qr.rs:914:5
>         |
>     914 | ///    will be encoded as binary segment, otherwise it will be =
encoded
>         |     ^^^ help: try using `  ` (2 spaces)
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#doc_overindented_list_items
>
> The overindentation is slightly hard to notice, since all the items
> start with a backquote that makes it look OK, but it is there.
>
> Thus fix it.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

