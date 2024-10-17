Return-Path: <linux-kernel+bounces-370566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFE59A2ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B066B215B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3185229106;
	Thu, 17 Oct 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRcCd71r"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD742281DD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197536; cv=none; b=lYgoU4njHdrYltDKn9GkCtqqwKkKKVEpQTk/UkvmRkk+oACqEfqTpla0HG3//zB+gu3LBPcmii/ad4LrCqYukK5Nx+4OWjurDbvp9V96BTb2cd9KQwXCkOIKZptS6bYsih3tD8TXc8/DcXThGE4GBTRK4mNSJdF7rPUqCKclVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197536; c=relaxed/simple;
	bh=cnQlnqdueLjUFXPl+rjNUrcziR/Uu37bRyAKm+ZnoQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn6MTjBeGcw1WDpsXeorGRvVrUm96/Rv2fgp2cXmWD/c71ZHVRmIb6iagF6EaYZ20zm2MwNzctxxhs+Yy9BzunWDiaekIiUq/uS2Ykeht/LksHoFlowkMHf5ux1Iodl1zeTtiO3Xr0Y906PwLeWKVWKqnXpKv2CLY1DqV2P4N1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TRcCd71r; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d447de11dso1006417f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729197531; x=1729802331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrcUDqdyzXImioFxfeLr6A00K3sNtV9qNS2Npm9oScs=;
        b=TRcCd71rwrA/I9JsY4MTxlkiu20pWrGzR0kfgJlfzNyOqJz3LDBkFZ4UvwhO6IyQSd
         vEJSWALfF1mkDuUqc413LamRc0uE76wLitrPNsW9jKZv5qHZOZz5rlpYj6O5/ZqNFZmF
         lKCLabNufsvada+lUUZLuo/1A3Q+dA+/Q5L9RdQjUWlVRrXDY/65705qAENlBZ6S1+7y
         g+qXLdKCcGex5meAtsycLbyzafMT7N0J6d9Ygxyap02oUvacwOy5Ktq/ZAFK43M+gD/t
         i9TFto5a3K7F4trV84vCLssEi9jMwTfEBoQ639qFgVffedVw+5xLAG6BcKPUG00XdhIQ
         tkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729197531; x=1729802331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrcUDqdyzXImioFxfeLr6A00K3sNtV9qNS2Npm9oScs=;
        b=w+xLMeKVKykN9a0YkFVfQhQxr2jbVEmsOtkpnSptN1dALfHVZqz5JhRWeBdn9/j9NO
         F+NxsG0qb7KeLkJymJcOFwglbXQeaIuc+knatHihYRd4NIdyuW34RQw0CCy6/GZM5edV
         8CJ7AaStuq5fBRFSYSG/mSrXO56SVo2OdNahgmgz58o20bIDgjpvo/QZLRzSs3Cb/Yt7
         8OABu2sqwkXJsXcmV48LSQ8rMzB1WqGfNncOiPB0lHh/n1gWVaR02uuuwxe+HHH/9MHn
         43rQw6Ui8fRhIYldnLo2yCADr8c5FkrXTtuFGIkeMa3fzErB1YE2KNTzO9EZOrkgrKID
         1elQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb2fi1fntsQj0wKfyEh8+QeiNfDodDY+iiTH+VyDX7aIkL/430Fj59B9pULOn3S61mwXRMG/79ByQ773E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KZ9t2hKg89tiriPG2FNXbfbTiIZXBvhUQH993OXeUr/Xkmj5
	peMeGbhLw1BJn7cmAFimH0zp0G3aoqlrP2HZhzGTajaF+/AG+Ho9FM1rPRbfVOOCOoQnh3ybs4r
	ma1FFMRhnG4hqpIOWT60MxVeACSeL/LIg7o/K
X-Google-Smtp-Source: AGHT+IHcG3qFIxzTBgPLhK0vUVNvs8oMv5K7oaKrCVIEfYnMO/l//my7v70uumTSJb7AZ47qEdjZy5rUy4JTUVaI2bI=
X-Received: by 2002:a05:6000:1807:b0:37d:5035:451 with SMTP id
 ffacd0b85a97d-37eab4edef1mr132912f8f.10.1729197530525; Thu, 17 Oct 2024
 13:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017200138.2390077-2-elsk@google.com>
In-Reply-To: <20241017200138.2390077-2-elsk@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 17 Oct 2024 22:38:36 +0200
Message-ID: <CAH5fLgh3JyY9L6Fg+LXVguyx8iPRbHVHqTyXSfM9gq6jdWRdtw@mail.gmail.com>
Subject: Re: [PATCH v1] rust: add PROCMACROLDFLAGS
To: HONG Yifan <elsk@google.com>
Cc: mmaurer@google.com, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Jonathan Corbet <corbet@lwn.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, kernel-team@android.com, 
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:01=E2=80=AFPM HONG Yifan <elsk@google.com> wrote=
:
>
> These are additional flags to be passed when linking proc macros for the
> Rust toolchain. If unset, it defaults to $(HOSTLDFLAGS).
>
> This is needed because the list of flags to link hostprogs is not
> necessarily the same as the list of flags used to link libmacros.so.
> When we build proc macros, we need the latter, not the
> former. To distinguish between the two, introduce this new variable
> to stand out from HOSTLDFLAGS used to link other host progs.
>
> Signed-off-by: HONG Yifan <elsk@google.com>
> ---
>  Documentation/kbuild/kbuild.rst | 5 +++++
>  Makefile                        | 1 +
>  rust/Makefile                   | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuil=
d.rst
> index 1796b3eba37b..d9866394bd98 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -91,6 +91,11 @@ HOSTRUSTFLAGS
>  -------------
>  Additional flags to be passed to $(HOSTRUSTC) when building host program=
s.
>
> +PROCMACROLDFLAGS
> +-------------
> +Additional flags to be passed when linking proc macros for the Rust tool=
chain.
> +If unset, it defaults to $(HOSTLDFLAGS).

It may be less confusing to say "when linking Rust proc macros" here.
Saying "for the Rust toolchain" could be confusing, as the proc macros
are "for" use with the various pieces of kernel source code. Most
people would not think of them as being "for the toolchain".

If you want to mention the toolchain, you could add a sentence: "Since
proc macros are loaded by rustc at build time, they must be linked in
a way that is compatible with the rustc toolchain being used."

Alice

