Return-Path: <linux-kernel+bounces-352092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F971991A0C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29785B20DA5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B99715D5C5;
	Sat,  5 Oct 2024 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XihFytbt"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A2130AC8;
	Sat,  5 Oct 2024 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728157722; cv=none; b=HpmH8PBeXJKOpWuqQpg3tmhPiHccChUKdPWKujbR3HviYbV24S8IaERYqT7DtCqJ90o+x/RtrryVt43Y9jV4NdcYayH4YJySPvWyqt7bmkq8h+Q2DOuawLwrpTAJQESsUj/hSMIvfmZZpT41jas8FP2xzbHB7ejFL722BJ2GZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728157722; c=relaxed/simple;
	bh=o9lwndcEObWOD4eMKX68Jnqn1u4SUdmNaScLpckTfnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7pBxMbus16gOitzns5QVjcW9/SjqN67/4s/Lg3dN72hzn4JDSawSIjcRM0Y6NvDaDU0vwXRn4kOoH3WHLSoQ2ZYidpfd/yzzGniQpM0rCAIGHQQrSjsGtfdmaBnshV6ZcfBpk+li4AwCMR/vel5r1mMM9KAonN7QP6G1Ir4rbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XihFytbt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71df23e0ffaso214268b3a.3;
        Sat, 05 Oct 2024 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728157720; x=1728762520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbHEGftmqqHevUuD1RbLqYiuIlmLINxCZjZlUo4G2Uc=;
        b=XihFytbtVgTqzQgSj7wru5XrMvaaEV5ezt9JaSN1f0HD4/lyYAfePMXrs32GWNzjix
         0BfGJNvWtDj4NaQp4U4ibzV6TGuvhTV03WWKW+sORcZW1K+a9EzlpgyvsE079lPAXOqu
         ueRHQaMhpZdRyXA3IXTriXVg2kMV2ob/dMBx9YUGuDiAEzQu7+dH8lwilRIjxr+XdRtP
         51rRYvq6KFPPKMigrz3Fq2tqNqxPL7vk3/3hofxnz+Xu0R4dRk78D4SZsZc7HnUXx34Q
         ThjJpCXd3n5BHj88bH94Hs/SCN/wyfavJ0XN+GIG3/UPHsZDLNDcC+GHPZKM8AtGJ+ad
         tsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728157720; x=1728762520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbHEGftmqqHevUuD1RbLqYiuIlmLINxCZjZlUo4G2Uc=;
        b=SJc9UkJ6NnBM8xdlch8Q1U16NiXcoS4bwVh1zeJteDc817QTmtIRdealUl3OmnfuXw
         EsAnHAvW4auoGSeZZ9ZAa4PpDAMAESk7mpEQ7nO95tgw7JQvjgcOn7D+zrI9MBUuFcBk
         fum/9MU2ONuBDN80lUV4Fdt1m+/zbiVpMCqacHDDt1vRFiHo36q/01wqGajUadrtVrih
         Men2vPc0AFQDzN7Sl51b9GwYcxfohC/PCjbvIaNWAzbKx75/w903Gc6ZEwyeMactfvJb
         oPFrgLn2x++F48B/5dh/Tem+5MV24IL1hJ09TypE/x31a+GlwB2RsZuPHEhLvWveGrJe
         bOug==
X-Forwarded-Encrypted: i=1; AJvYcCUfHrvvSTzo6IlgO0XDpqkr/CIhn+DlX0/e0OrIJQg3O3EGJi+D/2m4UBFdql1blDh/5oBsV4xGxQaZVLM=@vger.kernel.org, AJvYcCV0I7qnRJAsJpPsgAg4AHkUcLAX3Jf9lWeCFdrLe1MYjVk5XcemaAq2PTaDWjfXVayl37YAPUiLa0e2QA8fbVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaM4EJ2oVhGVOonxu0jvv8mIVBWh4h12r5f/isBp0VP0Bn2yZt
	3/P4uExxDql8cjGc/ucHFyB7rpK4rVsem/rw8AAtsy/2L9FkVNcYgXuMSRoiVfXlGVq1kbXsQky
	WvAjdvg2P9lcBn2ILu5AZY5h2ZYY=
X-Google-Smtp-Source: AGHT+IHYK4PAA8pIEJDKe/fEysdmD+nNiOosNdKJA9dAXcrT3N8VawCHzkXeKCJR8ccTqjCfrwCE4JQNwnYkwp4ohXA=
X-Received: by 2002:a05:6a20:2453:b0:1cf:2be2:6526 with SMTP id
 adf61e73a8af0-1d6dfaea5f0mr4424544637.12.1728157720451; Sat, 05 Oct 2024
 12:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004125616.49886-1-iapain@gmail.com>
In-Reply-To: <20241004125616.49886-1-iapain@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Oct 2024 21:48:28 +0200
Message-ID: <CANiq72k9u3aJhGjm7t3giCh=35OwrToXDCYqaHJ67_Ujs2=AVA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: std_vendor: update dbg macro from rust upstream
To: Deepak Thukral <iapain@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Filipe Xavier <felipe_life@live.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:09=E2=80=AFPM Deepak Thukral <iapain@gmail.com> wr=
ote:
>
> `dbg!` contain adapted code from rust upstream.
> Compare code with rust upstream and update missing column
> numbers in `dbg!` outputs. Column numbers are not copied
> but adjusted for examples in docstring.
>
> Thus update the docstring only.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1124
> Signed-off-by: Deepak Thukral <iapain@gmail.com>

Applied to `rust-next` (tags still welcome) -- thanks!

    [ Fixed typo and slightly reworded. - Miguel ]

Cheers,
Miguel

