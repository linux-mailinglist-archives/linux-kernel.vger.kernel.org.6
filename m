Return-Path: <linux-kernel+bounces-336229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C197F0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2204B21B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA719F128;
	Mon, 23 Sep 2024 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0GUxNaU"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89411FA5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117641; cv=none; b=ZL6YglQR4+0kWc8gWrCgCuqXHuZpYmwJKIidMkjXdLU2YtZ9TjC3/RBsCzU51hSzsvigimD6lgIj+o+m2cx2fUtfIDb/2kijy5PCK2uTyO19CPYRnR3Mj3iwDAe2gqGM1939qQbqQkZhovmYD5glGDT96VbvNvapYw4YNP37FKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117641; c=relaxed/simple;
	bh=RJp3YO2xkCkvAcGybOy1O0e0pLre294chzcT+uzyV7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fk4rWL9fmxLhFStYAh+TcX4tmEycSQXRWr6QVYzdOTNKIYScf+8w/EP7ZeEh/Vtys1lJOyefDUofgV+0C5PCvch+ONe82DLlHRFGpx82r+rvInAU61VpmKuWKat112jaV10SZS6ASAkmV58eMjfUXqiQ7B/GCCr7HolRrcoBf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0GUxNaU; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f78b28ddb6so41611731fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727117638; x=1727722438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO1L3+X0KalDwilFQ9Qm5x9BvI3ulI14EZ5c5LvvLro=;
        b=j0GUxNaUS1in9uMcE2BQNbx2vU1D1utv+7zGH5CslBGEhqbgAKcOfI1LJsabqbgL3D
         /aM9neqGgOyHiLFswZqhflau27HcqiolPK04F9Og6FWv7B7VkJ1C39L6LXrQcsKHHrJ1
         4vP0igVm7kaagXNBuolZDAg59G0Tlc/RWN0A9TMM2Zkkzv/FqjmmybhsOBNhp2aPFu1d
         a1sfm69s2gUWDFzludhG+/5mRef+AZuzpjUe2vZHG9c6o66EWexYxcim9Vc6xQOxsJk2
         HNMCAxmOsa8PKUL0CBKJ7HU6ig6TFI9Oxc8KPujQG83bfmLgrfQyYTvBpCQJUS2pUMJG
         9HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117638; x=1727722438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JO1L3+X0KalDwilFQ9Qm5x9BvI3ulI14EZ5c5LvvLro=;
        b=v2Rslzs0ZPpbaOCHMW7bUVWkWx2mJxBIdkWBquehQ8RyhEhXSKUzSOqiND1LqzCuuY
         g1my8lOQFbKFSvkhlb/NUIE7G6Ec1TKHJgsEgzIYnx6MTg9CqhcEdFxg8g+fIgcuhOee
         8a9XT5X4Zpno/Ga8cATKGooxLm/oarm0ftwqORxAsVGutE1avVEbZCJ5n/qJu417rCCH
         VyMZa9gGWmRdSfgdIs3jYguUmvSmvcKOf0nhx08HYGxCzaQPhALjg6HUlMwsBB0wfm9b
         gDmx+tAvsqdK4fWMdUcak0Ibm30VJrF+8XIYLSsj5GFfbWJ25tH3xb0UrPmrdEaBq47y
         zP5g==
X-Forwarded-Encrypted: i=1; AJvYcCUEx0TrA9MXi5EK5AkK62JR/2pCNyTqIAjOwagQlWSObxKwnTeutU8JHoqLZRi4u1nKyKTMyC174UT6+/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zGIA1Y2pZfGDfYvP9mIL6uAtnLlZToGA7oG+AOr+9II4CTTQ
	juXv9T3ZwtX24phmiEFsdp+KL1Za1EPhjcgUT3iT93eitBwLWZkropZCA4HGOLnAoxoujop1RVx
	XIP7XEI+lo79nqOZbDbfVrimQ/wazkB075/oj
X-Google-Smtp-Source: AGHT+IH04U1Lg+9AA4YzEyOY/oxn77fuWi8731MNJkLuZIm9Gh2b+asVsvcOw5J2jN6b1VOS+heEC3oArB0KM2NBRJ4=
X-Received: by 2002:a2e:4619:0:b0:2f6:4aed:9973 with SMTP id
 38308e7fff4ca-2f7cc5dd734mr48046651fa.44.1727117637790; Mon, 23 Sep 2024
 11:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917012808.24037-1-elsk@google.com>
In-Reply-To: <20240917012808.24037-1-elsk@google.com>
From: "Hong, Yifan" <elsk@google.com>
Date: Mon, 23 Sep 2024 11:53:21 -0700
Message-ID: <CAABy=s1FOwMx99m2D6R9JwaRQDgu-MAKpEJUYSqWOzxf+3m1XA@mail.gmail.com>
Subject: Re: [PATCH v1] objtool: Also include tools/include/uapi
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 6:28=E2=80=AFPM HONG Yifan <elsk@google.com> wrote:
>
> When building objtool against a sysroot that contains a stripped down
> version of the UAPI headers, the following error happens:
>
>     In file included from arch/x86/decode.c:10:
>     In file included from .../tools/arch/x86/include/asm/insn.h:10:
>     In file included from <sysroot>/include/asm/byteorder.h:9:
>     In file included from <sysroot>/include/linux/byteorder/little_endian=
.h:15:
>     In file included from <sysroot>/include/linux/stddef.h:9:
>     In file included from .../tools/include/linux/compiler_types.h:36:
>     .../tools/include/linux/compiler-gcc.h:3:2: error: "Please don't incl=
ude <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
>         3 | #error "Please don't include <linux/compiler-gcc.h> directly,=
 include <linux/compiler.h> instead."
>         |  ^
>     1 error generated.
>
> As hinted by the error, this is because <sysroot>/include/linux/stddef.h
> (a stripped-down version of uapi/include/linux/stddef.h) includes
> linux/compiler_types.h directly. However, this gets resolved to
> tools/include/linux/compiler_types.h, which is not expected to be
> included directly.
>
> To resolve this, I added tools/include/uapi to the include paths when
> building objtool. With this trick, linux/stddef.h is resolved to
> tools/include/uapi/linux/stddef.h, which doesn't include
> linux/compiler_types.h.
>
> Signed-off-by: HONG Yifan <elsk@google.com>
> ---
>  tools/objtool/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index bf7f7f84ac62..f56e27727534 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -24,6 +24,7 @@ LIBELF_LIBS  :=3D $(shell $(HOSTPKG_CONFIG) libelf --li=
bs 2>/dev/null || echo -lel
>  all: $(OBJTOOL)
>
>  INCLUDES :=3D -I$(srctree)/tools/include \
> +           -I$(srctree)/tools/include/uapi \
>             -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
>             -I$(srctree)/tools/arch/$(SRCARCH)/include  \
>             -I$(srctree)/tools/objtool/include \
> --
> 2.46.0.662.g92d0881bb0-goog
>

Hello,

May I ask if there are any updates? Do I need to revise this patch? Thanks!

