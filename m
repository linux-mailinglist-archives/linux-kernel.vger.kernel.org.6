Return-Path: <linux-kernel+bounces-561275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2341A60F88
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA36D1883E15
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091EF1F0E33;
	Fri, 14 Mar 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDXCZEUv"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA92AF1D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950224; cv=none; b=VrT/K27FpMKXk3/5XSxiAbJZ/b3a6yX3TlcK5NxgukGCwash+tRXnfrBktpA0TZdCjCNeKOpNBh6CgAq+QW/j1suDjwaKg2ykNoGJKBEQMzXoGndGceGOvX6LjHysRwhMkzdOjkGGn5KEy5b4VKkvOnOkKWHE6HTXSVk6G22Lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950224; c=relaxed/simple;
	bh=Mp0KLuz5zlyW/33XrkywpWXJ9LusZq0UhQNvabBQwsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gm4256YN0EJiU95bYgglWwG06FeO/IarwGna2BxY3jZSCmjLg2a3qsS7zyBZvFIMZN1hHNO3KBm75jCEpufvtRh2pwmmsLRvD8p9qkQrqZjFz5SXJpilYGRpsXGy+KI9yBPwFmtnCHFchy6w0uPek3DF+9Zpqftc1Ior0zxTsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDXCZEUv; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bd21f887aso16963821fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741950221; x=1742555021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp0KLuz5zlyW/33XrkywpWXJ9LusZq0UhQNvabBQwsY=;
        b=RDXCZEUvBZ/Dzp09ZIFn9FOAXJLDLic+YsGcinPgC6pEdDKwMMnPQukcJg6HqDfQ5U
         fhpqGxRNXyTpZY/zlohPH/nQef2RP2XF+1Lc8XHANLQeuDpTPtXwgwa4bwfs2J4mxs8V
         cTV2ZmC+UBKEsyVq8baO7oAZ/B5tVzRyyFEgCeN47ZKzAVJwMFcHDayBB6LOL+t/Hi+B
         8TrQxG2v+wz7rEU7BFjMkWWLZejH/NQIRtlQuYRMnvlCf7/T3F8p79eRegzUpHmuSjMc
         7zpChsfi9u3L53qWnYtq/JPk/75zmRtX4kArLEIna4rrcaM5Kju+lZaUjClFWS40juWr
         qEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741950221; x=1742555021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mp0KLuz5zlyW/33XrkywpWXJ9LusZq0UhQNvabBQwsY=;
        b=hKbyUMmWcoAA7/7YbqZCjA05fJVu9wYDbKXwvzR5nMgVPd0TXgtkhbcgiiKL99Oq+M
         sFg+uhYAOKZC8UcK/iaviE4FBtE19JGBFyEyFfMOJ/wt9bj6n+bAIAC2R3LghfhKtvKh
         vBKNOWI5L0aJK/LM7drHD3/1PCaoUrTbsDfh0x2TClr4Ygc6uoGGyUT6OIjPkl/BHI7q
         CI1vZYWeVDzF4Fzlk2Pw96GMZeIAESi6d6T/iUZQpzQ0eHf72gWgtpqU+LvFbWwWcjJu
         UFuRWR1SUDY34rUq4ZrtSglBG7keQpbI/dGcvJueweSm6oll4MRxHPFNRteJLVwAxRnl
         uMYA==
X-Forwarded-Encrypted: i=1; AJvYcCVbkFOQROjd77X4/m2sm/mqVQ3wfPJvj9URdybigH08w1UQtebxdu0pPIemiNoye97B5htnT1Op3rnPLm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ni3uRsddxB2V+R6liNRgrVe4KwzpSqdXHTJ2rPFqcdfCd2jJ
	AIb933j5VDQVDLN/XD2XXrUi7Yvx4gFWMaaEDc8ndQzT77mNuah6zeZ0Z8Ns4Y0n4frjuBmG8Kr
	roeDcP4h8fvNEtYVah1pIyuB3V7o=
X-Gm-Gg: ASbGncvXeNeAxoDjD1zp68AF09w/GEZiEErZVebYZp3VgbVQN8ZaSo6tx4yxHNqdxOd
	qqjcRz7dIMfkPCckkUQjoIdnun4Qz5h03vuyLtAJ2bGcq0+w+p3rwdyE21S1/cEsH7YorfY9Ol1
	frY6noKjzSCbvDg6W+l84a2d5iYg==
X-Google-Smtp-Source: AGHT+IFfMwpVPwM02st6YCEzdnLacEqTgXCb+im6yhDvYG5huY1dHQxUdCDmCu8V1DXYnyvB549f3BP01QpGFHdObE8=
X-Received: by 2002:a05:651c:1a0b:b0:30b:b8e6:86d7 with SMTP id
 38308e7fff4ca-30c4a8768eemr7417941fa.22.1741950220430; Fri, 14 Mar 2025
 04:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313191828.83855-1-ubizjak@gmail.com> <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de>
 <CAFULd4ZTkBwFo3nWXNZKXSKiy4dgPoZ8i95nj3UdtQPApKdj3g@mail.gmail.com>
 <B7AB40CF-165D-448C-963C-787D74BB9042@alien8.de> <Z9QB0nP6Mb3ri3mj@gmail.com>
In-Reply-To: <Z9QB0nP6Mb3ri3mj@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 14 Mar 2025 12:03:45 +0100
X-Gm-Features: AQ5f1JoFD4hP8ZJq5KbkcIfV9gaWdpQ9GoLSkZPuHTq1E0meayoN182xhaiYBbI
Message-ID: <CAFULd4YutpSGTQ2xkgZSBdp1eyJ1csaEoRk3RECp=TbL3xHUDA@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in amd_clear_divider()
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 11:15=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Borislav Petkov <bp@alien8.de> wrote:
>
> > Sorry but this doesn't justify this churn. There's nothing
> > quantifyingly palpable here to warrant this.
>
> I disagree, asm() is a known-bad inlining interface for fundamentally
> single-instruction inlines like this one, ...

Please note the new patch [1] that uses alternative_input(), where "no
code changes" actually supports the change. alternative_input() uses
asm_inline internally.

[1] https://lore.kernel.org/lkml/20250314081453.565859-1-ubizjak@gmail.com/

Uros.

