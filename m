Return-Path: <linux-kernel+bounces-277989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2C94A918
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696361F291F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00AD200127;
	Wed,  7 Aug 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ouva0LCv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3771EA0B1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038838; cv=none; b=LzMA/pi5xyG8Qb6KbGP/5qj18xLrfJ4dD2NG1nB6Db2LzzRUF4LlFbMuVRu/+kUMmL9R1OOYoZpa6nmvv5d3VMVMW8Wtv12DpAJOkHifHpsNIPYG/sQneIU863GpUfj2emy8/5VrhpsMbMigg9nZDbBimo1xZCA22M3YTpKV9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038838; c=relaxed/simple;
	bh=HEWPD4RYhf42OgDEBSAqzCtgkLgNuAtRpK1JqvDROqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCJBlURZdWHpMFse6PkAEfD68YCXoVzZ5C1iN6hv1DmaqEp8vNcAndwCPpQq2opjxDQAQNWLRJ9dN1FvGeRfdTlfEramHZv7dYVP2TqyXxzAbwE8v9Ls/3CZh36H0v58b2yIZoYTWE3YITtKSINrFWlboiyqCNbcGRF1erBSt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ouva0LCv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so12265925e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723038835; x=1723643635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4f8NXiPa/VCy0Z9ngspkDts0pjL5jp/vzu9TZfOD2c=;
        b=Ouva0LCvDHZ5WKfqAIEIbAv0K6GqVnc7WAdBa443uPp6Et44tag8YKwDgyATJ3pVAb
         iQ4n78w0cmuVJXx26BcZUj5M8bMDhRtmgmKoE83W3ZVQzw6TB2to+D6jX8AJM7o889am
         hZCt188nJuketluM4fsXZsmhIq7VCgLHw98EZ4aBJkfaqhxpnzTy/Q9Y8ddJXHBKD6TX
         WJOxUo74c7kM2OZOj8K21cDWoPk/GV5rV0HAbhxl5jBwz30ZZ3i5GcYITRlgfsJgLT8z
         2w+TyhSuWIR43delVs4Q8ABauQgahPClfyx9OrCSYAqrTzhgjqoLtEyuphN5aXECtObp
         czyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038835; x=1723643635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4f8NXiPa/VCy0Z9ngspkDts0pjL5jp/vzu9TZfOD2c=;
        b=gRKecR2cyerg+Je8zw6HPqtQw8rT63YeBzS/KiVGPpYbKMBodhllcAvppyJARiz85Y
         kWM14FAiqxFkkX4IMgxxUNp3TOnlKbENOhEiDdymP8WdVel7XLpnCYGoqAyoW3XS3zTP
         3k/CMj82Xa5qtIKmUjXUdls9j2ZOazob5it8MOcoPOG3Nx+eeKepA5Ccjj2CjdL3jS59
         S1/dvl9Bv0sgmxup5uBSzcsifVLISFL6yRwK84ZHQHAY3imy8lvjItVRdWKv/zfrYTQh
         EjQM/qTwPu3CbgXfjqx0xfg2JuKC1YwSDuqTfbaomgC5B3RhW6cM8EOr35i9/ttsN5zb
         KcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJdznKDMObF+W3vTRzDR69RkvikwRJe1OypYsLqAk0R4hmyONJ5CQf3FJEwelTUcorUA7Nlj1EAVaeIEUsn2wLC0zk0VjP3GGLTXwu
X-Gm-Message-State: AOJu0YyV/anKkJaX3U01pxkFwJtnX0zBSh/VgJ7so+5S1zG2FNMd5o05
	jCfZawJQrasSlm9hWDS3nTPZxeDxrr5f+LJGu7s/BKwYyKn/M0Afk2wUCv81uK/QmD3Y/bTkRMr
	n5y8mcyVGGarN4Lmy/zkqJUU+lZ+ZgP6Yx9Vx
X-Google-Smtp-Source: AGHT+IGICoiOOIqvUaYwYlvcxfUr8G6r/fYfPomDA2SxiWWEDk1Bcq9uAnBPbZdXf5nWDFU3T4u2S26B68nV+TOpN9M=
X-Received: by 2002:adf:eacd:0:b0:367:9d2c:9602 with SMTP id
 ffacd0b85a97d-36bbc194267mr13600511f8f.49.1723038834584; Wed, 07 Aug 2024
 06:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-25-dakr@kernel.org>
In-Reply-To: <20240805152004.5039-25-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 15:53:42 +0200
Message-ID: <CAH5fLgjTRjRx3LYMjSmVUGMa1=kLqcAGfwZO+Q+399fh5FwGOg@mail.gmail.com>
Subject: Re: [PATCH v4 24/28] rust: alloc: implement `contains` for `Flags`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:22=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Provide a simple helper function to check whether given flags do
> contain one or multiple other flags.
>
> This is used by a subsequent patch implementing the Cmalloc `Allocator`
> to check for __GFP_ZERO.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

One nit, but:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/alloc.rs | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 8a1cecc20d09..615afe69d097 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -34,7 +34,7 @@
>  /// They can be combined with the operators `|`, `&`, and `!`.
>  ///
>  /// Values can be used from the [`flags`] module.
> -#[derive(Clone, Copy)]
> +#[derive(Clone, Copy, PartialEq)]
>  pub struct Flags(u32);
>
>  impl Flags {
> @@ -42,6 +42,11 @@ impl Flags {
>      pub(crate) fn as_raw(self) -> u32 {
>          self.0
>      }
> +
> +    /// Check whether `flags` is contained in `self`.
> +    pub fn contains(&self, flags: Flags) -> bool {
> +        (*self & flags) =3D=3D flags
> +    }

Since this type is Copy, you can do this:

pub fn contains(self, flags: Flags) -> bool {
    (self & flags) =3D=3D flags
}

and avoid the asterisk.

Alice

