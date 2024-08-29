Return-Path: <linux-kernel+bounces-307167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2AC964960
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB4DB2918E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2021B3F1D;
	Thu, 29 Aug 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VgeFwcRk"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79A1B3F0F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943751; cv=none; b=bsZBjb7yumSTkMPt9gxuPXsw41fa+0eLzdCP5YDivl3LfSp+psSrCPeEWyrMmrASescxW37pAW6AmZZu06rnw+Dk0h5a6NAFqT3aeoE5rH3olvGy277bQwanShMlxO9fG4l8rOFStVjkzJl+5sT77s8zvwCwcYkfVWdWMMM2oDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943751; c=relaxed/simple;
	bh=Cs1G3Km11lKVbLwuzqXspUq0kocgRC5HF81O9ABdTIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffdO5sNneNjd6WXb/Nj4LXaVVste1C+pWborjuC9V3fR9Iy3u3M0munP8EzG/mJh7ibvNwIAyUYxxaSn4utva9YTdkPBc0GGCxdKjfIK90hJoArc6g0WpJuOm/MzONDkg39I8Ucut8LIx4ZPzZh51HMV9uoJ/N+Lh0cQA2fuZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VgeFwcRk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20353e5de9cso229185ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943749; x=1725548549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8Xok/aj4CcH+x0fW9fszJu1Uo+wA+cbGvy4Plgbunk=;
        b=VgeFwcRkEeIvkMID/hovXJ/6WUgNpA1anhIWz9HhBPyqsSCUCjjWpNJAb2xvOMp8+Z
         0DufmlUuoaXfkKJvz+sMSmOMTOsHXE81WbSbDA0s5Y87j9BnRz1zAg/ByTNN5j572j3N
         FpNHrXb0X6Vg+5NxtWcPdGH1iO0vbVTI2jzu6XqJQw0aTTzQpioztkdRaiQkbwVX2kBW
         Z3OVOhk9i7UD/YcMvvVfKghvT5VXenqP2S8utkZJlkzWTIL6T2gn6U52Bd/VsJRcGogx
         +xaozNmv5pOLpfL/B/WS9jKl1L7u7iVn586GYM3dvZnu0luznqBcJ6Q80AZUGkB8nqUF
         7j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943749; x=1725548549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8Xok/aj4CcH+x0fW9fszJu1Uo+wA+cbGvy4Plgbunk=;
        b=ixRvJu3JxMOhthO/s43V3IuSgBZ7a04opgqnasC1glTz5G6zT+fSMEh2vswl0F6wgy
         F73pMIcx++E8+yDmB9C63BL35imULzmrf6bF1Bh1VUSgdDKZl8U+R5XaB5+d/kIXQAg5
         7gmWlwXJ1l4cIncFXMkzXoYURygh9tmFDX2DfaATn7D+VXp6Kv9ouYTNq77i2TU8vNE+
         uSGXUdtSK+Ui0f5UN0EnhnDwv6gR6Jetx7pOHqHnXZlEm4/ua0etv1KCwtnnZXB5Ysrg
         xKbOK+gXuzY3qRg8THLTRUocXp7U92m4ab4xPVTFbrqodaSu6lUpCQhygn/owOzxWOV9
         1Pqg==
X-Forwarded-Encrypted: i=1; AJvYcCVKVVKWtvqVEKiVSU0JCnpFAQu5JQ8w4rI5CwYzYRgWViiyQ6h9WuoTsdRDiKHs+47OEOgEGvSqHM/h7SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgwKsVCtOsZ0ZS73EMfMKk2v6nDz1Xk4tJJD9gvnGYg/6FQWc9
	522PXL3twfBFX4KexZnH3PXp9UITSL+5bf53a2HPV6A9O5dO2cVVOys8CtHQwpIGBZaY1q5qE64
	GQrOghX+K/aLEMoEpRblPKTWxPcevjbUya4zD
X-Google-Smtp-Source: AGHT+IEgzSL7E+FoXmdOkwmpU8nb2C/I8uvJwxWSGmckCGCthEaA8NcbZvddARC4UJaGvXsxQWrx8Ws7gZmgk6Q/SBs=
X-Received: by 2002:a17:903:2348:b0:201:daee:6fac with SMTP id
 d9443c01a7336-2050d20274cmr3489725ad.16.1724943748890; Thu, 29 Aug 2024
 08:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809072532.work.266-kees@kernel.org> <20240809073309.2134488-2-kees@kernel.org>
In-Reply-To: <20240809073309.2134488-2-kees@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 29 Aug 2024 08:02:13 -0700
Message-ID: <CAJuCfpFY9=NOftvaKqkuohZH9L1QTHshORXeqLomrHBPPTd9kw@mail.gmail.com>
Subject: Re: [PATCH 2/5] codetag: Run module_load hooks for builtin codetags
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>, Jann Horn <jannh@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, jvoisin <julien.voisin@dustri.org>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:33=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> The module_load callback should still run for builtin codetags that
> define it, even in a non-modular kernel. (i.e. for the cmod->mod =3D=3D N=
ULL
> case).
>
> Signed-off-by: Kees Cook <kees@kernel.org>

Hi Kees,
I finally got some time and started reviewing your patches.
Coincidentally I recently posted a fix for this issue at
https://lore.kernel.org/all/20240828231536.1770519-1-surenb@google.com/
Your fix is missing a small part when codetag_module_init() is using
mod->name while struct module is undefined (CONFIG_MODULES=3Dn) and you
should see this build error:

In file included from ./include/linux/kernel.h:31,
                 from ./include/linux/cpumask.h:11,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/radix-tree.h:14,
                 from ./include/linux/idr.h:15,
                 from lib/codetag.c:3:
lib/codetag.c: In function =E2=80=98codetag_module_init=E2=80=99:
  CC      drivers/acpi/acpica/extrace.o
lib/codetag.c:167:34: error: invalid use of undefined type =E2=80=98struct =
module=E2=80=99
  167 |                         mod ? mod->name : "(built-in)");
      |                                  ^~

Thanks,
Suren.


> ---
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> ---
>  lib/codetag.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/lib/codetag.c b/lib/codetag.c
> index 5ace625f2328..ef7634c7ee18 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -125,7 +125,6 @@ static inline size_t range_size(const struct codetag_=
type *cttype,
>                         cttype->desc.tag_size;
>  }
>
> -#ifdef CONFIG_MODULES
>  static void *get_symbol(struct module *mod, const char *prefix, const ch=
ar *name)
>  {
>         DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
> @@ -199,6 +198,7 @@ static int codetag_module_init(struct codetag_type *c=
ttype, struct module *mod)
>         return 0;
>  }
>
> +#ifdef CONFIG_MODULES
>  void codetag_load_module(struct module *mod)
>  {
>         struct codetag_type *cttype;
> @@ -248,9 +248,6 @@ bool codetag_unload_module(struct module *mod)
>
>         return unload_ok;
>  }
> -
> -#else /* CONFIG_MODULES */
> -static int codetag_module_init(struct codetag_type *cttype, struct modul=
e *mod) { return 0; }
>  #endif /* CONFIG_MODULES */
>
>  struct codetag_type *
> --
> 2.34.1
>

