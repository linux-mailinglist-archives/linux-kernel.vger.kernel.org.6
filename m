Return-Path: <linux-kernel+bounces-321782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB1B971F5F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCB9288BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6541F169397;
	Mon,  9 Sep 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyMk5ex8"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13D1758F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899839; cv=none; b=ZRZjuoZpmVILILNq7xFNYtg/pI5m4TZWiZlBWUPmrJHYsg0HOvPhHQxzyvZrlaOd9GlqugUzn0TALzTbgZK4+8lnsoPaCJRTLRYfoDlfu0s9zfz3g96WUrd500tAc8jxyg85Mwpa3Z9CVTM7xpWi+46AtYKO5RUO7vADbJdayBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899839; c=relaxed/simple;
	bh=Vor9A51MY4LbHBQym1omjXXtWBlRMHBeYzCg0Ctn6GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDcr9FTaDbjkYk51r1OqGkPY5urdrIkIGsSmVjNnZZ0tlQYEq57kYz48BF4M7Ci7PRlRCdDXavGCrpaZNIFa1bs31FfFszClhuoMhpjUa0Blyn3L7kvUiLclxMrnkDUDOVvc0kyiA4+gjb5/iVWDYe9qNDCapb4G4d/e4NNO3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyMk5ex8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so2645281f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725899836; x=1726504636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVb7FZalp+hymwW1x9wgZGuiq1blreq92SNrbnhzt/U=;
        b=HyMk5ex8ajDB02NENOTjzqHs6Q87jKZQHT/TsJsGbjSjx+fcVy/wSoRv0pM0LzgoIe
         Zftjt+EFR9hfpTHdxG23nM64LdlC166ccGN+XKoe5Ehlpgmux2CmYGqZf9bkAElx+u7h
         OC+Fjo2Ki20yIMaOLZ8FwVB5OtH/ZwEJL7OOf7fI0SQECcTPyVljCaTNbCLgKHBB2wLT
         jeYZxafML4M5ap1/99RmvoT+RaVHsEryZab00PjxhX+RbMbS9PVF8sm74NaTw5UPWAQG
         coAmlAMmw70B7daoPIMCXubUbKKDOAr4PENt5yYDL7c7V29vskeGpcakMSQfUEkn1ex4
         eOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899836; x=1726504636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVb7FZalp+hymwW1x9wgZGuiq1blreq92SNrbnhzt/U=;
        b=PdPdqIyIk8iH21uJ/x4OtEqKWTAyvqW3yx/rtItKWqW8uApQNRev4CMdQPt9tHkp6u
         1d6EK7/po6KgIIeh8CWa1/G5bCzTVmSe0ijTXQ3wy7VElqv4HMtOsRKhZ5TDHq8y4Yql
         iW6wAViDEc+mJOZWEdsE/kviBnKy3Uie0O1mZvAEPgqr6q09Ev9SKdVgxhl4ialg41Zj
         EcN1pue+6s2AloBUGxvMtOva/23ug4sJ3nEZQxBWZmXff4FolbGgjIAJbsyEeQTxwLan
         xr/Sz0aTb/ssR+ECYA4Z63D3u0THCAFSaMED/yn34vVrlxx+pU601Q7CBu5DhRFuVfR3
         lUEw==
X-Forwarded-Encrypted: i=1; AJvYcCXzUzrdqsuILKy90n1Lt4I/0csldzDJOA31rukFoEV8Fm6Z3Y5MqhpGjbErxFVxR0Ofs7hrlmFBsWwXsog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPIgSvhLwfWlChfR7/sMSZIBBqkleiGR5huAqWi5mZULUau0J
	OwRRtnki0/cu+KnBsZjDiJBZG/V7oNUlfMaX9nsfozHBTE3x85ji2EkAy0Mf9aRa9WuCxx3Zwkd
	GvuCFy5IC0DY+2Nqargt+3dqowe4w2XMxkdpH
X-Google-Smtp-Source: AGHT+IFqGpX0VmbgWSC7nk1slW1l+OrKUWEzp/PMlH2GO3N0F90G8DHQsjE9OjeSQ5wBmNMyvA/uZ9VRq3o5WHdPitE=
X-Received: by 2002:a05:6000:d8d:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-378926858a7mr5320757f8f.5.1725899836155; Mon, 09 Sep 2024
 09:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com>
In-Reply-To: <20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Sep 2024 18:37:04 +0200
Message-ID: <CAH5fLgj6aCNxXfANt-0duhMfujQdOip9AjtX5yRraXQ5QaDReA@mail.gmail.com>
Subject: Re: [PATCH RFC] rust: lockdep: Use Pin for all LockClassKey usages
To: levymitchell0@gmail.com
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:13=E2=80=AFAM Mitchell Levy via B4 Relay
<devnull+levymitchell0.gmail.com@kernel.org> wrote:
>
> From: Mitchell Levy <levymitchell0@gmail.com>
>
> The current LockClassKey API has soundness issues related to the use of
> dynamically allocated LockClassKeys. In particular, these keys can be
> used without being registered and don't have address stability.
>
> This fixes the issue by using Pin<&LockClassKey> and properly
> registering/deregistering the keys on init/drop.
>
> Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-1-nmi=
@metaspace.dk/
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
> This change is based on applying the linked patch to the top of
> rust-next.
>
> I'm sending this as an RFC because I'm not sure that using
> Pin<&'static LockClassKey> is appropriate as the parameter for, e.g.,
> Work::new. This should preclude using dynamically allocated
> LockClassKeys here, which might not be desirable. Unfortunately, using
> Pin<&'a LockClassKey> creates other headaches as the compiler then
> requires that T and PinImpl<Self> be bounded by 'a, which also seems
> undesirable. I would be especially interested in feedback/ideas along
> these lines.

I think what should happen here is split this into two commits:

1. Get rid of LockClassKey::new so that the only constructor is the
`static_lock_class!` macro. Backport this change to stable kernels.
2. Everything else you have as-is.

Everything that takes a lock class key right now takes it by &'static
so they technically don't need to be wrapped in Pin (see
Pin::static_ref), but I don't mind making this change to pave the way
for LockClassKeys that don't live forever in the future.

The patch *does* introduce the ability to create LockClassKeys, but
they're only usable if they are leaked.

Alice

> -        T: WorkItem<ID>,
> +        T: WorkItem<ID>

Spurious change?

