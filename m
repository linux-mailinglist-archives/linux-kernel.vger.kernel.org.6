Return-Path: <linux-kernel+bounces-555600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CF7A5BA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0D03B0633
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880D422259D;
	Tue, 11 Mar 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBSpbxDR"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD112222DB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679031; cv=none; b=u+zgVO+PGa1FPG950bZy6TSaNMqlLkKADzXsQEb9kpkBqWiPyy3pWZz9/BHIPGerfcz7bXDCda78nM1YyCWh2clWfYx6Tvp9CgMSKNerM1FOBlMz6t+7op/NpBuOafF5PlRal8ZOqvuxU1yyv6hD7aJHxb0QoUswAuet+mUF048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679031; c=relaxed/simple;
	bh=rEB1phDGuMJuuHMPeNJgudH6DWwTHq/O/9wLKkeg5Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSH0w2T517rtVMz84u9OAsRGqB0+kKA2gChhkFau9f82O7sxvlvYhJORslXEBOjiNA0t4H2tuwSU5eflCYxOjv0iafbKFvvDydkun3qrZLWXGb9kSr/0uCl9ssBVeBTCqhCHP31y3ADx8QLa60XQa4QNO39qw0Yz5u55uS8zwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBSpbxDR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913b539aabso1570333f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741679027; x=1742283827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEB1phDGuMJuuHMPeNJgudH6DWwTHq/O/9wLKkeg5Fc=;
        b=rBSpbxDRp1qVKi1RjDki0YIcaMoUptMtJ2B0SLS0cKW1T4GyOEiVIpffT9n4GOQd2f
         FFDce7XSiEiX3SYxcW/DONVlpAN4WSamRChReriCBotMx4sybXBJQEDs2gr37S6fw29J
         L3gmjgjD1y3eEHMiHK9bMpAqCA+MCObXqeLeYKOv4V47JAf3fvE5KJ2QKjjWpr1jeIRc
         Ao7Xdk1+u6AbN+7D6FUpmvDGB1fFuDHNqfPn70q12krpg1uu9CS7r35LfWFpEWBKjEzv
         LzbeWZnO/7H8x50YnuVnuYSgHNmzksmeWVup3AUI2QPmg6Uden2tCmx0zaBVqNbX4SNu
         x0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741679027; x=1742283827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEB1phDGuMJuuHMPeNJgudH6DWwTHq/O/9wLKkeg5Fc=;
        b=A2JZETiI8XZHju0/VJjfV0IBttcm7rdE0acyTaRS+ee5KHT7cznlJwOp24CR9aUHdo
         xQeKphCfPXFRZMZMd29QDFsidB2UZHBhGVkgig/smE5j4g88kR1pyVIxSUXtE4LpVAFc
         fqzBy8WQfpzqS8rZFdv+HJP+0y1jxW+oXhSpn/sb4wOqL0ZTBYuf4Uazb1XxQr3OOi2/
         OYr6iS+HLiVwruDyoYuLmYb4blORH6HAgskh+nZ0mrpd8xmH+RHMTKgxr+OCx19YEoxQ
         jwOabVo61x/Lg7532p2VQkU5rzeVZ5oLCmgufscprDiqdRXJZKML82sxicndV6oQlljx
         yzaw==
X-Forwarded-Encrypted: i=1; AJvYcCWl9renv7Gdn4k78aZBDJpn6BocUx8N19W29ALOLSMm4O3pUyvEiNIfMwMZdMwSIoFGi+DoJbDbNSq9byY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZuTosiIYCZJp68i2uDBwCuPNjyvZu8ALJEMZnEk7KQw8le/l
	j60ma6BjV9MlHMLFGjM7Fqy4mOWbJx3b2LgIpu+jrsG/h1XgF+EsFIXMAiGXOqAb/S681PEhCFg
	27H4q1xpRR0WUmD0DHb6/31FxDV+Uf93oKQ+1
X-Gm-Gg: ASbGnctwKTqM7J6Sk6QKroHLduUSzNhVHZzb+sW4hIREabUb7hA0swW2DyI9OrV7MCg
	oHxh4hCfZZlu4WOFIs4fAo28FupV1s9IxK4DO1InyAs5RYqY2FuxlkeCy9/sr6HUwUVL0iV0ulZ
	dIxhzIsJBC9SbUvItmJcLoXLp0Sos=
X-Google-Smtp-Source: AGHT+IElGicg9Noy3KNYc3X1Hx3ljvy9PPIG+fte0j2wopqhPKBVVw/+1a1GI96/SevkXuNGDp7MGGQrGtMUp4y0Itg=
X-Received: by 2002:a05:6000:1844:b0:391:29c0:83f5 with SMTP id
 ffacd0b85a97d-39132da9406mr14060098f8f.44.1741679027502; Tue, 11 Mar 2025
 00:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0100019582fc6956-3b420cce-f122-4a26-8fea-94000b22bc90-000000@email.amazonses.com>
In-Reply-To: <0100019582fc6956-3b420cce-f122-4a26-8fea-94000b22bc90-000000@email.amazonses.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 11 Mar 2025 08:43:35 +0100
X-Gm-Features: AQ5f1JrorvKt0joSAmNhbI8X1OvgY1sTRzY-RUvYu31UhNpzzuvWgmT9z1NH5g4
Message-ID: <CAH5fLgi+HrV8raKqdzHyJ3HweFwbkY+D6OkWxhOrYg8q2TgRaQ@mail.gmail.com>
Subject: Re: [PATCH] rust: uaccess: mark UserSliceReader methods inline
To: Antonio Hickey <contact@antoniohickey.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:15=E2=80=AFAM Antonio Hickey
<contact@antoniohickey.com> wrote:
>
> When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
> toolchain provided by kernel.org with ARCH=3Dx86_64, the following symbol=
s
> are generated:
>
> $nm vmlinux | grep ' _R'.*UserSliceReader | rustfilt
> ffffffff817c3320 T <kernel::uaccess::UserSliceReader>::read_slice
> ffffffff817c32b0 T <kernel::uaccess::UserSliceReader>::read_raw
>
> However, these Rust symbols are trivial wrappers around the functions
> copy_from_user, _copy_from_user respectively. It doesn't
> make sense to go through a trivial wrapper for these functions, so mark
> them inline.
>
> After applying this patch, the above command will produce no output.
>
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

I believe you're missing a Link: and Suggested-by: tag.

Otherwise looks good to me.

Alice

