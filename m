Return-Path: <linux-kernel+bounces-174644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F3D8C1216
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BD21F21EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B0616F287;
	Thu,  9 May 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B3r5JkHR"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6216F26E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269129; cv=none; b=ZWrLzFpS6LR6itBjlrdIVqNgQB8Kcw+NX4okK2sopkgjKF82rx4XNDXbgYhKvps/ahdl49geQilEqSjQr7eFB32l/pNGMIihtTKLNIXzQ8F+SgjnNEBEQueAekH7Hn7t2+P0JhWnn3GPISPpDI+W65FAJlu/Cjrs/NhmnVNzomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269129; c=relaxed/simple;
	bh=VbUryaWATGCZ5EXBoBZLCN4tFKqA1uiKbgb/q6kse1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vC+4sezner+60sAJI4PJsKU73TAeRAXVEBvgYSvVLm1nBDpao7W219Ev18Js6wkjLaBRyC/LBYpyZniBFVVLQQI/IRL907YQa+8S8CcOdmCFEWaUdoWJ6fDDnSqbLJujKVnOpUvOj2wsj1KR/9GgxUoCxsHo1fWUt0AArgTE014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B3r5JkHR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a599eedc8eeso274373366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715269125; x=1715873925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1rcGIIRAYs5g7y2tSFAfBRRtjyll1Cgq8Dp6vv6m/q4=;
        b=B3r5JkHRn4S28scVky0RpYUj4PqttLFM8uOw4FqhUkPIb3nwHfP+Q/hMku5BRkXeZE
         vO3cJYRBbB0UZVm6pCOmQis8MqTyIqm3krqDEaO8jVGIGa1yINSmAwZTVdXTDFER1J/8
         jnBGjy6tpTB/DdRDj+laMqau1ze46UxS6HCZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715269125; x=1715873925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rcGIIRAYs5g7y2tSFAfBRRtjyll1Cgq8Dp6vv6m/q4=;
        b=Jv12thZBbAEFGxzsY8uol2/1toNX5SPB4v3FprgSdkRMrsIvY/ajwwe/SaS/W0+nqc
         GEPgnOHsaIoymiew2JFmnmeBrVHpcDbrq2Y7CkExOPVxN67JEC/doKQ3i0i085kzVlt2
         ML61pS2DCoFKOu25C/whJKaiog3RFRcGbnDKD1Fe/LP0k4gPfCOMUYrM+TP187+ypqdT
         31rjNy0TBUaBTSmPP0h+QcPFJES9t2xqKBVyQTbUtm62+/ZNbQM7GYMtIo1URNZK3JcO
         jmFMeQNMMDy7TF+8AHE7h/LOtCPwOIL7J8WT63MvkLCcM7Xgfkmq3sak4F0G7P8xX2oC
         96pg==
X-Forwarded-Encrypted: i=1; AJvYcCVjZYhu2eOWp6gHqPrtmfQ9gLDb2ABbCUoS2rA0RPOM41LOWAel3sscQc+G0i7/zvWr69NU8n4vw2NMJ03xSCOo+n/fteMC0kHadOqC
X-Gm-Message-State: AOJu0Yx4DBJdz+3J8moLcUnpeDdvlfz6B6T+pvOPVdrOXqi6zDxIe75Y
	Y5fvP+iFBkv/nDG8G1K3PHeEDA3XaZ37QU1zrc1DsBrJeZDChc+fo41DCKl+GmUTkESyU1pvqgz
	1kQoCqQ==
X-Google-Smtp-Source: AGHT+IEPWaDf4+SaKKZO5nKgQ0kYDbjWLUCUp1T4ZUFQnVeolzetm+8X3SeufUG7QpKHX9pKRX1qxg==
X-Received: by 2002:a17:906:3aca:b0:a59:c9ce:3387 with SMTP id a640c23a62f3a-a59fb952cffmr379731166b.45.1715269125598;
        Thu, 09 May 2024 08:38:45 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b0145csm84160466b.158.2024.05.09.08.38.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 08:38:45 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5a13921661so229303966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 08:38:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVufAmwE0Kjk7FrL6S8r8EMoKx1uusggtBh+/iJPSnIA95SXMiRCJdrRC6NzcAky/Y5w3LHPAyjbT3NmHbGmoxx3V0qZsMXqzU4IaM0
X-Received: by 2002:a17:906:35c8:b0:a5a:1562:5187 with SMTP id
 a640c23a62f3a-a5a156255e3mr176942266b.55.1715269124579; Thu, 09 May 2024
 08:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook> <20240509140854.GF3620298@mit.edu>
In-Reply-To: <20240509140854.GF3620298@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 May 2024 08:38:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
Message-ID: <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 07:09, Theodore Ts'o <tytso@mit.edu> wrote:
>
> struct ext2_super {
>        ...
>        __u32    time_lo;
>        __u32    time_high;
>        ...
> }
>
>         time_t  now;
>
>         sb->time_low = now;
>         sb->time_high = now >> 32;
>
> This is obviously (to a human) correct,

Actually, it's not correct at all.

If time_t is 32-bit, that "now >> 32" is broken due to how C shifts
are defined. For a 32-bit type, only shifts of 0-31 bits are
well-defined (due to hardware differences).

> but because of stupid compiler
> tricks, in order to silence compiler-level and ubsan complaints, this
> got turned into:
>
>         sb->time_low = now & 0xffffffff;
> #if (SIZEOF_TIME_T > 4)
>         sb->time_high = (now >> 32) & EXT4_EPOCH_MASK;
> #else
>         sb->time_high = 0;
> #endi

This is the wrong solution.

But the solution to the undefined shift isn't some #ifdef.

The idiomatic C solution is to do

        high_bits = (all_bits >> 16) >> 16;

which works even if 'all_bits' is 32 bit, and the compiler will know
this idiom, and turn it into just 0.

Going the other way is similar:

        all_bits = low_bits + ((u64) high_bits << 16) << 16);

and again, the compiler will recognize this idiom and do the right
thing (and if 'all_bits' is only 32-bit, the compiler will optimize
the high bit noise away).

And yes, this is not great, but there you have it: C was designed to
be a high-level assembler, and you see the effects of "this is how
many hardware shifters work". The shift instructions on many (most?)
architectures end up being limited to the word width.

We actually have some helpers for this in <linux/wordpart.h>:

  #define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
  #define lower_32_bits(n) ((u32)((n) & 0xffffffff))

but we don't have that "combine 32 bits into 64 bits" helper. Maybe
worth adding.

                Linus

