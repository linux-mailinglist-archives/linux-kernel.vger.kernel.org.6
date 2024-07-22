Return-Path: <linux-kernel+bounces-258695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EB3938BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC2B1C212A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374571684A8;
	Mon, 22 Jul 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kymzt0pR"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F7112B63
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639361; cv=none; b=XSjNXxpkUtXGVWvBj2GHBTd3X/w4j0tc2nYV4DYzDa4b+WQgsM/mLDoHFn42Hv12NauGCCzSG96RctqC3KPAkEeXK+ZJ1MZU1rzHtiLLdTTzjm0JY1B2B31wtDsphH9qQ407kHhOgG/9gF0VdlFT1fRVQU4xPNu9RJpof1SuE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639361; c=relaxed/simple;
	bh=gTL1VCkA01/hHiwB+85YSNQGYqFQPUDfry1s+s15yNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oR1n5TRs7O6FUl7InkV08PPsh4N1r+MePutjT6tUy9+8i6BAxose22WjTTDMQMM/rB9oDDJGtlPUWF8JvY3B4Aez1mvnFv1ZCAI1j4dWCkV3Oms+auwnkjuV+jGjEfdE7FRGoiFxV+i7otjs6FuIM8gJ6hGlvgxe28Bhq6sAl/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kymzt0pR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3683178b226so1922582f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721639358; x=1722244158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah24y1yQSASYJYM3HEnqaKXhBwm1vy49N5JwUW8UEr4=;
        b=Kymzt0pRQ7XrLu/DJUN98O7FJr31kA8xbLG5ECWN68ND5BLwh9/hMpJyN+3/L8eP0b
         f8ELTqDePI9nFxRfCgjkXU1pEsiSaUg/DVmzrAryZeJUgQS7QOx1jPn5Ca2Xl0Di0qc5
         OidTgu/3pnxcXO98Tbd5f8ovTIokQly4OF3HCAkCAzW4lwRLlp59qkSFjqVNixsNGXwH
         0W164gfVruLCFIHdsVi3nf99bdvxS0+Otq5VHpZbTO4tfSSUndzxZBJkGDsioJyFGmWs
         FnYHGjEvuZykkjXS1YIryrcGlMJLsmxO+ajuk6u9BLjuWZfggUVLGqhKYqY3Y15rKA9a
         BKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721639358; x=1722244158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ah24y1yQSASYJYM3HEnqaKXhBwm1vy49N5JwUW8UEr4=;
        b=aBX3VeWO3PrntYZDRMC5TLXDO8uxo+SR4JobmjpjVaP0EFcu55+ce3SPUzskxI++4V
         ApwXazcT20JeUpzAYnvSirpxv76bpDzGD2DhGVmIq4Jo9vdCoQ6oSUfGf/eo9Jg6kW+7
         FrGClXZCEdTh2MaJQ24gOhVXGk3g3lEPVTVFFxA1EYjf7mJ4vzlxRagnhE1+QKyMGJ5B
         RDUoVda1wZ8tCGsW3VBmnNhU+s7zWfvieYjXp+iUy8tf6R4IWogIPI1SCpAs9kpz6EhS
         x5mDtd2y01zPEjcxw/7dZ4uCuLoT7ftms+CuF2nF7OaIryn7g9iEwgXekHxN9phb2BjG
         ljjw==
X-Forwarded-Encrypted: i=1; AJvYcCVteCyzQSsM+WuMUbERsCGroaJbxdK1W8MFQdxF+/uxiKIIWm/769h8Rm7Cg62opO9fbkz7G+7fRrowtW5wIBoU81lsPORevfmNMHOm
X-Gm-Message-State: AOJu0YzmMtYuJWk5ch5QhaHyCiRx76dMPnpxoZX+D7cnMfbFdyVxM6T/
	+pqmHqgatfDZ4sJCfaANLuosfa7l96esj2ptfdovEPYGWr7wIREpPfLtJhondDAP8JtCar5THVU
	ZkWM5Lj69pBm1c2jvzNtf7yX250AYh6ciSSmL
X-Google-Smtp-Source: AGHT+IGwSprF0fVSAeDXSVP69s81y0vecBUb0pn4T8XiVJU9XW190kHqnX6vSFoO3578vVBstvt8xVTHpBcR7doSBF4=
X-Received: by 2002:a5d:58e4:0:b0:368:4b9d:ee51 with SMTP id
 ffacd0b85a97d-369bb2e1a52mr2903177f8f.57.1721639357955; Mon, 22 Jul 2024
 02:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719192234.330341-1-alexmantel93@mailbox.org>
In-Reply-To: <20240719192234.330341-1-alexmantel93@mailbox.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Jul 2024 11:09:05 +0200
Message-ID: <CAH5fLggs=5k0HR2G9XbZ3k-9gjN=CwU_ZHmAbB7zzWj4Lcu+aA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: Implement the smart pointer `InPlaceInit` for `Arc`
To: Alex Mantel <alexmantel93@mailbox.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:22=E2=80=AFPM Alex Mantel <alexmantel93@mailbox.o=
rg> wrote:
>
> For pinned and unpinned initialization of structs, a trait named
> `InPlaceInit` exists for uniform access. `Arc` did not implement
> `InPlaceInit` yet, although the functions already existed. The main
> reason for that, was that the trait itself returned a `Pin<Self>`. The
> `Arc` implementation of the kernel is already implicitly pinned.
>
> To enable `Arc` to implement `InPlaceInit` and to have uniform access,
> for in-place and pinned in-place initialization, an associated type is
> introduced for `InPlaceInit`. The new implementation of `InPlaceInit`
> for `Arc` sets `Arc` as the associated type. Older implementations use
> an explicit `Pin<T>` as the associated type. The implemented methods for
> `Arc` are mostly moved from a direct implementation on `Arc`. There
> should be no user impact. The implementation for `ListArc` is omitted,
> because it is not merged yet.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1079
> Signed-off-by: Alex Mantel <alexmantel93@mailbox.org>
> [...]
>  /// Smart pointer that can initialize memory in-place.
>  pub trait InPlaceInit<T>: Sized {
> +    /// A type might be pinned implicitly. An addtional `Pin<ImplicitlyP=
inned>` is useless. In
> +    /// doubt, the type can just be set to `Pin<Self>`.
> +    type PinnedResult;
> +

It's unfortunate that we can't use an associated type default here.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

