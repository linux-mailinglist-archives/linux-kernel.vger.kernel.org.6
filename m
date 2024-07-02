Return-Path: <linux-kernel+bounces-237529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97776923A59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B1C1F23F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B177E15689B;
	Tue,  2 Jul 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWaxIt3c"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F2155312;
	Tue,  2 Jul 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913302; cv=none; b=bamPYybfuz09ra7QgzFBy53Hq3w+1jQAGRfQOXtcki/oFy2leyL5eURt5Zt6TC7MhqxyhgHZ96ilbZOL3xWUbzlmcfLCCb3rwfS1pdC5PRAAFGqBPsgjXNM/QMkv+tcl4fHWiub/C85Ztau5gO3HUZ9AHWXc3TdsvLkzBm+JOxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913302; c=relaxed/simple;
	bh=rrHJuzABvv32dcWokveTz7Dnd/80nmaf3YwG2Ar19yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1jJ/WQUrcQO0m9pIQ82mQCfqmM0bEmS8g9+8P191HPj9+kc4n7LcbP/ouRNrJMeMcebO6bPchTrtIXaBzJ2wiKHkPN4Ylwum7z7eLXY277GtoyY35ufi+Q7XBwe9bnCpVlgmTm/yjeQ82OlQOq2zo4Ys+Zvk9c1cFXfcn3y3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWaxIt3c; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c8c6cc53c7so2731048a91.0;
        Tue, 02 Jul 2024 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719913300; x=1720518100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrHJuzABvv32dcWokveTz7Dnd/80nmaf3YwG2Ar19yE=;
        b=EWaxIt3cf1wXAoV7eCxzvLnu/RJrtIQKk1u5/eVfZohla6F04WhG6VB8dK9c2PTCKk
         nom8CftNH43FlRxL2UBGjboUxTkCWcpQLM/mXfzv+D6dcFiYpPE1RvCdu3qetHj0w/Jk
         E5h5xNoKvKTm/VqoqAjgvgZZPdctD6pMW6VKs49V72iDUxWZGaDPtkCkhtiVBciDAjuT
         yRXwYlWpyDNKk6Lu4hpd62xNA50htXnTStXa39eIXtkXAyWrdEq4cvh9kgfiAfEmnzza
         P6GjvvesALtBi6mF9GP+HfYTBH0B2gEbqPIPS1rsCCVPEYurTfuNfoXXGTh256CqxiEE
         sTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913300; x=1720518100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrHJuzABvv32dcWokveTz7Dnd/80nmaf3YwG2Ar19yE=;
        b=SJKYJcc3N34tYVXHx2BZ8e96+K2SjQrgZEOCA/XXXxqKRK+Rm22lXjb9WFBXOabx3C
         hWLpdVm3lPt9DFICOrgkHdeUqm14Y2AxHrYnSoSFJWAs7FwK0sAqLnjdKR0hDTW4QC4J
         eNE8cLn3KFxxy0INeAwOkd/CdjAEfiLn+rLrlag4/heMo8K1qmsHFW/LPfLx3x6IiP2O
         8JBHlnT7qMH6UvHcLd7DibQqE6JIx7jrt4DVniY4RaisClro5LMjjTImdr+9dM7VNsBr
         ekwrsoTJlJ/384L+wFBw2aETHoXsdQxOnjn5r37HB5aQOlOZ6tldVCnWUa2MtoWXm3LX
         Xnxw==
X-Forwarded-Encrypted: i=1; AJvYcCUGR3fGBdxhWs+Q6tjkZeE188/V7fUB/m2+KFpjriTfk1CJvJerSJk2vnDA8DBvOea/KnZy5ElhmyTXw3biQCfzZuhP2PIZVzwdo3FFBHoLaml2UFPhen5/fsJgDJlHsbrRDxuSS/ie4cA3rlA=
X-Gm-Message-State: AOJu0YxqUcrkii58zRyy9BSZ+2M81+kFBCdYTmf+j2TpzrebB7KLBu8R
	EkcYTkgpSC2WQFl2t+yTYjqqyegUR4tLIWD6esZp7UUEn2yQADt6D/ienCP7hf4LnobxRogMkeY
	wJwyYCGXakfEjv9XjxIygk9c/mNA=
X-Google-Smtp-Source: AGHT+IEDftu7sk+tfSLkqpQkBEgUNXL8IgNpgAL9Frlx/qQPKc4RNAvHIN4qui+yL3vGvj/+3mk7DlNTp02STXHJzQQ=
X-Received: by 2002:a17:90b:180d:b0:2c5:32c3:a777 with SMTP id
 98e67ed59e1d1-2c93d7242f8mr6335964a91.28.1719913299802; Tue, 02 Jul 2024
 02:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701183625.665574-1-ojeda@kernel.org> <4fa15761-7cab-4463-a2ff-717256c67d76@proton.me>
In-Reply-To: <4fa15761-7cab-4463-a2ff-717256c67d76@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 2 Jul 2024 11:41:27 +0200
Message-ID: <CANiq72kX2yhAVwd2FVRaGZvGrhPhTnnM=v18nng___Pu+aZaSg@mail.gmail.com>
Subject: Re: [PATCH 00/13] Support several Rust toolchain versions
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 8:25=E2=80=AFAM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> I applied the series and successfully ran the kunit tests on nixos.
> I tried the following rust versions via fenix:
> - rustc 1.78.0 (9b00956e5 2024-04-29)
> - rustc 1.79.0 (129f3b996 2024-06-10)
> - 1.80.0-beta.4 (64a1fe671 2024-06-21)
> - 1.81.0-nightly (6868c831a 2024-06-30)
>
> My bindgen version is 0.69.4.
>
> Everything worked as expected :)

Thanks Benno! I tried nixpkgs' toolchain for the examples in the docs
patch, but not fenix's ones, so it's good to know those work as well. :)

Cheers,
Miguel

