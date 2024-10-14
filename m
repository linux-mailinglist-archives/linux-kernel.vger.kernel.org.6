Return-Path: <linux-kernel+bounces-363447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A299C299
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C895D1C239DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B925B14EC77;
	Mon, 14 Oct 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2lqoDwpK"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78919147C98
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893322; cv=none; b=bi+02ioD7vsJymAkpuGEMVEsWvV6kfrrWi8NFEZLoUNM05SGovQbKnEftqT1k34+0IGNKQ52ULEvZyanRC26l7iFxLlEBrQ1t7ex0eaBzf2CZXIbfO10avamJFT59ZKH5F0nOLFQt8zgoOAdGUjKUQaiwiBKbI7bOaOlyeFDcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893322; c=relaxed/simple;
	bh=O57o6OjgPVw3NVWHhelIPsfXEclIUKFq2JaWUSMci54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3UDBJ0MaikzMM0eL+A7oyL4sta1d+40i+NT2LhorORJum9UX25UmHTIo46WEtY43AMcDrJq3nTzmBYv6AckZFuBonpaNa48YD5vE9+E374kookz0iG0EZc1/DKegGD4igqgNx1h5gtx73e3s/1mOEDgYVwOe8MqyCqFQ75NLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2lqoDwpK; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so2295611fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728893318; x=1729498118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiUD3POxK4R2Vjsmnvv6htZOxYD0NUhQkka4uTSkr18=;
        b=2lqoDwpKbKqRPnSBB2OZBeszFH8ocwNYq0ZsNZ0njVBW+SLv9IdZQ9Kkq1f71hzKJv
         KG6/Eh0xTNTxkDqiFZV8NqshQvg7fv5xBEWok0BPvu2pko6SkrpQOpBFY/TTQmp4LUMi
         6OX2rorfmk/K7EE9jr1plAoCsAFqucbtWlH7M/Tv7FUOidpcGcG5cFmEAxtLn3olNt9n
         ptKcgKfy0FyZwOL4+6xk4MKIiM00v/Z8rkgNhoiZqsTWvi7MZpWpDiXWiW6d8H9IFU9e
         N0uM7SsXZQzsX1DkwXRyjTLs7SkeC7pCZOnmst0VL/S2bo1OZbf6u0IYbTacoXFWKJKN
         m95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893318; x=1729498118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiUD3POxK4R2Vjsmnvv6htZOxYD0NUhQkka4uTSkr18=;
        b=ZI30rVO1c/eHDX1FUMcnYs7tvsn8ZNEDMx6j6gBFqpGXxjZSnFBI17e0C8w/BsW1af
         8wmypuwgGVYIj1dcHrgX+wJisEEDjiRk5Lvy+Zn3/PFEZheC3pPhhO2kkcCdQl1UK+Oj
         7khbz/4ocjPqPp3oRBDYA1NU7V5sHDUr9DmCl8POuqu7zJZRiYuX12y6FqES9IKCWY66
         SQo17WvfNXxk2Gd9MtRg+iX9QObVdtSFsp0a3XhA+Vr4eAAAWxAC+o+FtDCg1C9OJjHM
         uIy03K0BXzrub5XMCh0rNdWvVKAOvQD+BrrkltmGvd628wzvUb+rN9kZIkdat5EYnFzx
         N6ig==
X-Forwarded-Encrypted: i=1; AJvYcCWXng3SPgsjT+YQOPi4ZKUUWI/LNTKFkIC++Dwbxi65JP9FU6eHgP1pOAJRsBWCvCk6BDlVxrfTw6TdVDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydOwd83pqLHbBVP8PsnCjO2AAQ2w20Vwjf0L02rmNP4YcOiNDd
	oXcAbP2gPFzJBGAm+e4nbF+iEI/muChirOFYOBfMKXO5hC8jTyh23Wtg+lxvvgf3XkBpp9L3zES
	cmxHYQ+HuNTdaVV+4O7qOcG9aZLK+KgED+kycnhcbLy4ucNUWNGjw
X-Google-Smtp-Source: AGHT+IFPTa9hxaudqbyLElcnQwcKZmv23t7OmMCD0Z6YvY+CWYg/OV3YuvertOJpjBO3EdZJC7zG32oHIJXoy1wq1vE=
X-Received: by 2002:a2e:82ca:0:b0:2fb:2ebf:3259 with SMTP id
 38308e7fff4ca-2fb3f197c72mr20149671fa.13.1728893318227; Mon, 14 Oct 2024
 01:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012225524.117871-1-andrey.konovalov@linux.dev>
In-Reply-To: <20241012225524.117871-1-andrey.konovalov@linux.dev>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 Oct 2024 10:08:23 +0200
Message-ID: <CACT4Y+YS4UTMwk_j+Fjah3bCQd0zFcr2XqsUJ5K8HC991Soyhg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: kasan, kcov: add bugzilla links
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Oct 2024 at 00:55, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> Add links to the Bugzilla component that's used to track KASAN and KCOV
> issues.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ad507f49324a..c9b6fc55f84a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12242,6 +12242,7 @@ R:      Dmitry Vyukov <dvyukov@google.com>
>  R:     Vincenzo Frascino <vincenzo.frascino@arm.com>
>  L:     kasan-dev@googlegroups.com
>  S:     Maintained
> +B:     https://bugzilla.kernel.org/buglist.cgi?component=3DSanitizers&pr=
oduct=3DMemory%20Management

Do we want a link to buglist.cgi, or to enter_bug.cgi, or both? =F0=9F=A4=
=94

>  F:     Documentation/dev-tools/kasan.rst
>  F:     arch/*/include/asm/*kasan.h
>  F:     arch/*/mm/kasan_init*
> @@ -12265,6 +12266,7 @@ R:      Dmitry Vyukov <dvyukov@google.com>
>  R:     Andrey Konovalov <andreyknvl@gmail.com>
>  L:     kasan-dev@googlegroups.com
>  S:     Maintained
> +B:     https://bugzilla.kernel.org/buglist.cgi?component=3DSanitizers&pr=
oduct=3DMemory%20Management
>  F:     Documentation/dev-tools/kcov.rst
>  F:     include/linux/kcov.h
>  F:     include/uapi/linux/kcov.h
> --
> 2.25.1
>

