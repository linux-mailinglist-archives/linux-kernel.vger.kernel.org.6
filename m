Return-Path: <linux-kernel+bounces-575084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F7A6ED57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBF11893EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FDF253F04;
	Tue, 25 Mar 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npWPWvX0"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990F1DE4EC;
	Tue, 25 Mar 2025 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897594; cv=none; b=kFpmPFLHG5yJsHLI6uTsH+BAkvLApNIySae5HG6LrG9UVt8qR7jcMp9RdZ62EwVkBErvNurSYLJhlatgsNpv0sR5OvYRaztOhiOc1I9cROnxxf73/g0mwtSs1I+iWnShIR2/Dsv3wgzbl8RLWnrzxRlXsA90+mtJIy1Wu2nYrh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897594; c=relaxed/simple;
	bh=EsU90UIiG95rJav2ydFFuzd10jY7lOEUJhuV6bJUvE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpaBHolAQxewLwuZmFp8PgqztioFAJ8UmhbAExJAegPr0GiZPPx5fCd25+PMQwzebRyx4oDfkeQ9ib8Aumb2TiP/pqvIhkyB8DwMg0DK1bJoq3Vb0X+AE+b6bNYM2H9/wNNHAYDdXYwhOiA8bNDXgtBBi/Yvgn0lUg/NIMj+m2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npWPWvX0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2260202c2a1so10943565ad.3;
        Tue, 25 Mar 2025 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742897593; x=1743502393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEDq1UJUqtq05PctL877nPjaHHGlNyms9RQr2/wNvlE=;
        b=npWPWvX0HQ09XD2E4MUWTVXZhDqQMafSXJ60v/wMLjJh1b5DIh0/rxKDhVcidZlNkS
         6JT7AdH2Vbs36UsELrKFUE3D44B6aoq8pX0Y5frvFBkHax8WarDqpFr1WYn4zxr38asY
         ChWahgPLytcZgKmwBX+oLoGA7XeZ6WqC3NmzQroRAM4gWLDHWTeDPoiSt9q8T5bE5Wjw
         h+vs0AivLiMMGKBRUej/LFRwAqLd//FTz4Jo1EwFW5TdmH1eKGRqYjmXaNaMRYdsO9QC
         y3ON2daDVE4HnaEK1HWJ64q+yd4jKsFWlJqnQp+mT7D0u4DVfSSNDa3lY9E25wTe1vh+
         neeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742897593; x=1743502393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEDq1UJUqtq05PctL877nPjaHHGlNyms9RQr2/wNvlE=;
        b=tiPMhPvy0jAAz7MNbiN9MR1Mwl6cgxXfegV5H//3Z6tk/icNNoHZYhd0i3Wpp7laEM
         wJis9VdRlaARNTDxDs0gqOiwMrYl0AiJ06r9u/EMWEX5uw0JNckOeIFUi6SWTfjPaRMN
         pwp1Sd0g3DFoQV559zKLRC5RlrKGghUe9rYYU/kl7xM+PdCPEDTXmftzJqLInT4fd0lE
         FVaYWnqJxxzywF1uhpIScxbFsJGdupb4Ni24XXUd4oZt9O0ldfMEcm1fTTNEctlrDa+n
         wgH0TNMxCMlbjs6Ljj/lPFIiWoR9EjHmJiK0iHPrerYQZCCvUmCDYAcG0delGzXDKX6M
         nrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHKaPjEkRQJ/orynywEF61WVPLdryLF1UoUYzYRpzH5PJadGGFxwNbGP0jC8t4kONePr2ngVuPtN9R284=@vger.kernel.org, AJvYcCXr6vNh58SZws8t52LLDGG0egePm7BHC57FAqLcJ3iQrkC3Wx7OMr4xaa03yuQJR5XpFC10yW1r3kHGeGgeSTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7wP3gre9WBGG37KFATAfjzwg2CW1DjNWUmkGQ6vuAtv+gAJo
	LLBwTN5gLRoXSFed4OEvB2jJrQNHo74V8PXltBWmXjYo5xd6tWRww+4UFWYkQ9/D2CP/UtExpKO
	WzBwi6KvlAFD5173ane1pGq1u1bw=
X-Gm-Gg: ASbGncvVLfCIfsFz46igY0PNfvoLNCNkk3Uwk22unriHSxtvQ30lTwJXA1mTlspkqS0
	YgjWHUMHCGwNe6vN+GiBp8MlubkK4dkJBnRMRSHurd19UF9Foub8XT0GjUOHMWKYRzDAdbKTfXb
	XO22Avxi1Ibd7P8uG15nVA772OJg==
X-Google-Smtp-Source: AGHT+IGNIu/26kDQcyv6aovbIEaxRmM9jIjrb8hE/W/g3KOwMrnzrKUZGYd3te7lujLCPoR0R3YJ3Fd4QcZ+SvYxRao=
X-Received: by 2002:a17:902:ec84:b0:224:10b0:4ee5 with SMTP id
 d9443c01a7336-22780ba2e0emr81920905ad.0.1742897592462; Tue, 25 Mar 2025
 03:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324061835.1693125-1-kunwu.chan@linux.dev>
 <CANiq72=KjT8HRJA0NStHeqm-9286gay496CU8edNALPQ9_N+ww@mail.gmail.com> <52e7d34e-cf86-40d6-a294-b318df98d72a@linux.dev>
In-Reply-To: <52e7d34e-cf86-40d6-a294-b318df98d72a@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Mar 2025 11:12:59 +0100
X-Gm-Features: AQ5f1JqyCfGL5XbhQM2bU_PPn0fepDdpk4JpK1BPHHTum3dXPrHhVO5NorHN1DI
Message-ID: <CANiq72=iMaEOALbh8EBrgEc5t0KQ2BTPADro3vmBtEM75pO3aw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: sync: optimize rust symbol generation for CondVar
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 4:02=E2=80=AFAM Kunwu Chan <kunwu.chan@linux.dev> w=
rote:
>
> Thanks for the kind reminder, I'll follow this next time

You're welcome!

> Now, the default '-Copt-level' is 2 when define
> 'CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE',
> and in  KBUILD_RUSTFLAGS the  '-Ccodegen-units' is 1.
>
> So if the config not change, the result should be the same.

I don't think that is true, because there are a few `rustc` versions
as well as LLVM ones that we support, so how inlining happens (at both
`rustc` and LLVM levels) may change even if the configuration is
essentially the same.

And, of course, then there are other non-compiler-related kernel
config options (i.e. not compiler flags, but other stuff, like `cfg`s)
that influence which and how gets emitted and thus the inlining
decisions.

Eventually we should have pure GCC builds too, which is yet another factor.=
..

To be clear, I agree with Boqun that having to write `#[inline]`
everywhere is not great. Rust 1.75 already started to tag small
functions as `#[inline]` to try to prevent the proliferation of the
attribute, which is good (i.e. which is what triggered the message in
Compiler Explorer).

By the way, one difference is whether it is `pub` -- the `notify()`
isn't (unlike the others), but if it were, then we would have needed
the `#[inline]`, from a quick test.

Thanks!

Cheers,
Miguel

