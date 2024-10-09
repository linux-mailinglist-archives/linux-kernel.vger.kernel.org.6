Return-Path: <linux-kernel+bounces-356181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEB1995D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBAB1C223EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE31B6BFCA;
	Wed,  9 Oct 2024 02:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWrJ90Vf"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2E55E73
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439760; cv=none; b=fmpwEn3Y3r7suifGBlhn9WWNMmpLUq6PoTdu3CllL/n1xjhJE50kbIxg86AWi7TcKxVTgIHiOAZ4uMrE2cnZs788/KbqPaYrAZVIsc7Ytr4F2IHBUymcgOwMHK3njb5F4Eb8bfiNbV3Qn2rRL2kFFNdxHkyvGNjSffyrgN2C6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439760; c=relaxed/simple;
	bh=A99ew9gZR5pmHUG8WxOzLSgHb8WnT/ZsItTFDnJ2YAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL/9WFQ0b8fwoDJD88/QHqbRYN2De+RlbJmjPZpOCVrwOjsQ4WRaezneOOn7n+bJBzkM0WWqRpQnWw0aAH4RlJaBezIPfjTWHUiHyLeVGhUU5MM9E3ypI7rsTG8QJBT8zZw5zai+XJzyubrPc34tB9z8TlXAoaSUlS3vrXUJYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWrJ90Vf; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fb56d2fb2so133782241.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 19:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728439756; x=1729044556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qb1GBUE5bd79oRRfoU1wYzeVHp7KyK+orebRrydrldU=;
        b=VWrJ90VfeisGenCA5uZsDx+1kqeFaEo8NQ2u+vbbjG1AMbvm+Tl+xz0xlo/ftFc/tC
         EelLaGmCoPaM+9Tp0nq6QM5fGRaR+HcoLjr2ChzHrUjV5d1/9+kUX0WLAYrwiCdOZtu6
         umcgv9zpKo6SqBMPBgTot9OBXQpNvs/HDJkHYPF4c58tWOBWvLuteqOAMJSq8xtbbcqm
         Xx5cirTWc3Cuc3mQwKeI9OyAf9QVDE2XAnScDw6XsT/cqYr0rs5dkIbYmtx7c0e7SMqn
         cOQFcCYL6dCveP1yrU5UpG2LVDRujza7xV1MJLxwcvNLkUJrW7jPDG/7cYtipY+5uetB
         9SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728439756; x=1729044556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qb1GBUE5bd79oRRfoU1wYzeVHp7KyK+orebRrydrldU=;
        b=StSVx2yBGg9JHeakHxpjzK2UnLSeR/KM3/VuUSn4twuMwVqD0UWPfBBpKNXtLfpPEg
         97DUSZNXnxu9RC3RKVWC9HLGYx7zoqQHbl10AfWbiFTSCsGeYcopneWN74Lx85l42Gfx
         q9fxIxNIfgYu1LYIYNeVHhqPPOBGSwuPTXjQbHenyKDV3pZUiXZsbUG9YkWaiRkMiaRF
         ghoEyfskIUpdtMnJ4fEs/7FMWKreUeyPnjHoNPU+m83ArhVcPI57mRQorsidR+1w+7dA
         DH7auHtOW5d6FTDFJwJxjI0KO/9EWvndMXgHNLhLKp92zNDB7lPb/f35RniteUFp+Yj7
         T5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzR6AKDcvcYou3sG2XHTq0owiSq5f/gVYsYiGmCHUwmVKwroDOWiS/Waa78SU7MOxP3pvtOHKma4f6ufQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJk8HtP9RFjs2onx0zI9jk/IC2jw/xaUmH9SQtXlKDfiD/wnh3
	MDG1vXsrHqrLq06WC5onGi/tMaukYez2asCgzzZLjumzUUbNNMNBJJAVxc3HEkVkiHqc1lXUGor
	yVUjXMw8CL9fvJPo28kLj4KbvUhE=
X-Google-Smtp-Source: AGHT+IFu39wHmH+QO6CWG2Nv6HuHj1Qac8nNN58a1in00REEJe3X0XIxdNjzyUdLEZls7XOWPAn3Cnyf1yghCNWk3tQ=
X-Received: by 2002:a05:6122:2a42:b0:50a:c73e:b337 with SMTP id
 71dfb90a1353d-50cf09d1e41mr496087e0c.6.1728439756402; Tue, 08 Oct 2024
 19:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008191329.2332346-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241008191329.2332346-1-andriy.shevchenko@linux.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 9 Oct 2024 10:09:05 +0800
Message-ID: <CAGsJ_4w3wBG7SvmoAFsnOBbNihAO+ioiNJmU1tEObwFNq5nnQg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mm: Remove unused stub for can_swapin_thp()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 3:13=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When can_swapin_thp() is unused, it prevents kernel builds
> with clang, `make W=3D1` and CONFIG_WERROR=3Dy:
>
> mm/memory.c:4184:20: error: unused function 'can_swapin_thp' [-Werror,-Wu=
nused-function]
>
> Fix this by removing the unused stub.
>
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=3D1 build").
>
> Fixes: 242d12c98174 ("mm: support large folios swap-in for sync io device=
s")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  mm/memory.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 2366578015ad..c0869a962ddd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4181,11 +4181,6 @@ static struct folio *alloc_swap_folio(struct vm_fa=
ult *vmf)
>         return __alloc_swap_folio(vmf);
>  }
>  #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> -static inline bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int=
 nr_pages)
> -{
> -       return false;
> -}
> -
>  static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  {
>         return __alloc_swap_folio(vmf);
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
>

