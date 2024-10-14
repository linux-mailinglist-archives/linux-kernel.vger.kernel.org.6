Return-Path: <linux-kernel+bounces-364755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B58C99D8E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFF1281AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2106156F44;
	Mon, 14 Oct 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNDBMS6n"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E814B965
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940626; cv=none; b=ADN8jCRG+xdazhr172bLLaDKSQOXwKTTRGBxQrINZzH2oA0n/uc4VWs098ABA5Bc9NiPj/oSelemtMqJQpP3g/qFgphXjpiqSyG5+H8kRpEm3ITVoLB5FhMWyFmO9UAp/fx0h3iK6XBMrPN1cEXSFa3oRvjXcMOZHKsRJEvwEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940626; c=relaxed/simple;
	bh=ZI3U8sCOJ726YZ30gGwRvvoQ5UXBS01WMq3brNnRKuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIzWSa+twU3OJHVTAqmGHslfblIao++1+DY2I7kaLOVT9z+Y0CkWFyp6c5G0Mx4c+Uht48NswCOY0eA0k+BvORumwc2/Wk3JvtOykX8sTmBeZ5mjXOLsidCSs6EcXcKjstMoJhwycC83Z0H7yIwfBoB8f5fz2n159txvwXwcAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNDBMS6n; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4601a471aecso501791cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728940623; x=1729545423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHb7NtoAh9gjfT6eZG97rGp2AF3tFOHSjIj6ouJz5Jk=;
        b=VNDBMS6nJtQsXHg1tmol9WWSGlyG+8HKOyLI3+5ffjrN0BuVhvNyw8W57qRjsgDuie
         8W6vjW23IftYn7I8a8LzjOa/akFZTBugmgNeGM1Jn6lEoxG1Fe9ATRBiVF1nOQgYIuzw
         3Dea06z1BLeZFjjMzm2ie1veuhaCx1tvfweUzK0Ww6auubTgSDYvE28zjfsZod/8WeWh
         2i0KOk8cm9ov3KEJlsTEgIWJHhXJ7ev35dB1HQZpNUx6ixf4ZCLQKpm9m9v2CEGQEyYK
         VgFD70ezaM4HV5lFjJ6mZtdeU47CQZ+ZG3AzdlL2Qtp3x/WSZJXQtkwwE/3Z9aZI6GNu
         +7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940623; x=1729545423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHb7NtoAh9gjfT6eZG97rGp2AF3tFOHSjIj6ouJz5Jk=;
        b=hFHnIY5NktHDy8LiwDGnM5KSQihOVucc/UvcbhKFikNTZK+dTeaFnGJGQiRjqGwR5R
         CZLJiESCloncEJkk7g8BEkHEFd00/PGdoRV4s9GOHsBLqjTXdga5KryKfHfLxF86WWNE
         P/xx/f6nOgc6ydH/2ZpOhctom90GrJSQ6k8nBpfthzalF+OGM++a0FE3B6SFS1AmC/SP
         V+/EBUr0MOOLraeBwuFtB/QAAe6ggoZlJWP394iNG0H16gCowo8wv/Tja/aGPpgBdnZj
         +A8PO3n5RN51Pi/gZfPcZrjNnq5qY/NCeOfDKzMsBazoIQg7Zk3CzZJOum2ba0AiACTE
         bn0Q==
X-Gm-Message-State: AOJu0YwXk1XM5cJ3+QOCQekd/9xAyMy58b7qIRDOxiY7nCsULEGUL1u9
	M6UJfSpBsRFKD80JVdiJOqS8YaqR/q1/qHMAyDFwEIQvRIMdwORoM+nRzQ9Rye9oGJpmxxKLrQm
	qQa8l9sPgi2rhcyJg1yNTvnBFGDt4wS93a0kg
X-Google-Smtp-Source: AGHT+IG1b7oU0kZLAEWD5hgOJFQGchfVhmH4qbX+aT93IIjRDuRwkmmDWWwjoBxrsP4yYyMAPebwXvZWRqMK+tLF+yE=
X-Received: by 2002:a05:622a:7d0b:b0:45e:fea6:a3b1 with SMTP id
 d75a77b69052e-46059c78199mr5347011cf.19.1728940623190; Mon, 14 Oct 2024
 14:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014125703.2287936-4-ardb+git@google.com> <20241014125703.2287936-5-ardb+git@google.com>
In-Reply-To: <20241014125703.2287936-5-ardb+git@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 14 Oct 2024 14:16:52 -0700
Message-ID: <CAJuCfpGXBH0FQppLppSkCLeRwCJsAGUMWL6F+G1TdqU4d=q4og@mail.gmail.com>
Subject: Re: [PATCH 1/2] codetag: Use dot prefix for section name
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:57=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Sections typically use leading dots in their names, and deviating from
> this breaks some assumptions in the existing code, e.g., in strip_relocs
> on x86, which filters out .rela.* and .rela__* sections.
>
>   [65] alloc_tags        PROGBITS         0000000000000000  03a57958
>        0000000000026340  0000000000000000  WA       0     0     8
>   [66] .relaalloc_tags   RELA             0000000000000000  08dbb868
>        0000000000044c40  0000000000000018   I      280    65     8
>
> So use a leading dot for the alloc_tags sections.

No issues with renaming the section but please note that I posted a
patch [1] today that will have conflicts with this renaming.

[1] https://lore.kernel.org/all/20241014203646.1952505-3-surenb@google.com/

>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/asm-generic/codetag.lds.h | 2 +-
>  include/linux/alloc_tag.h         | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/code=
tag.lds.h
> index 64f536b80380..dcd18351ba2f 100644
> --- a/include/asm-generic/codetag.lds.h
> +++ b/include/asm-generic/codetag.lds.h
> @@ -5,7 +5,7 @@
>  #define SECTION_WITH_BOUNDARIES(_name) \
>         . =3D ALIGN(8);                   \
>         __start_##_name =3D .;            \
> -       KEEP(*(_name))                  \
> +       KEEP(*(. ## _name))             \
>         __stop_##_name =3D .;

I think leaving the SECTION_WITH_BOUNDARIES() definition as is and
changing its users to pass the name with the dot would be more
explicit and more flexible.
The only user today is CODETAG_SECTIONS() at [2], so I would add the
dot in there instead.

[2] https://elixir.bootlin.com/linux/v6.12-rc2/source/include/asm-generic/c=
odetag.lds.h#L12

Thanks,
Suren.

>
>  #define CODETAG_SECTIONS()             \
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 1f0a9ff23a2c..d45a8a582970 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -76,7 +76,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_allo=
c_tag);
>
>  #define DEFINE_ALLOC_TAG(_alloc_tag)                                    =
       \
>         static struct alloc_tag _alloc_tag __used __aligned(8)           =
       \
> -       __section("alloc_tags") =3D {                                    =
         \
> +       __section(".alloc_tags") =3D {                                   =
         \
>                 .ct =3D CODE_TAG_INIT,                                   =
         \
>                 .counters =3D &_shared_alloc_tag };
>
> @@ -85,7 +85,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_allo=
c_tag);
>  #define DEFINE_ALLOC_TAG(_alloc_tag)                                    =
       \
>         static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr)=
;      \
>         static struct alloc_tag _alloc_tag __used __aligned(8)           =
       \
> -       __section("alloc_tags") =3D {                                    =
         \
> +       __section(".alloc_tags") =3D {                                   =
         \
>                 .ct =3D CODE_TAG_INIT,                                   =
         \
>                 .counters =3D &_alloc_tag_cntr };
>
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

