Return-Path: <linux-kernel+bounces-562491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7722A6299C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BC93BFA96
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A43319F117;
	Sat, 15 Mar 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn/v39l6"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144CED531
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029767; cv=none; b=pbWhah8KoI+9rTLZXTYffJZjDrakeO971JTRfOxzPM3qKswj5+pcuyDbvmLVGfyK40/qnswrMk03+U8j/WHcaA8jgaJrHwc8crTqyw6s1KbGu8vY21lHUPl6/KzC++JGnDdV1yXenV9M5Za/SMFpGJ46r120kesa+mpCFroh0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029767; c=relaxed/simple;
	bh=pYIydlk3JNGq5DJbvgnImEZDd3v+yHD2X0dhIYliRNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvjCB0syHs2i9zs7KY37557x5/y4v1lM2h5uZV6SxtoMvEOirQxVDJt8tm8qrl3GIKVG5EGBoOYQU5LsfQ/6isOubxOqV8TpKi/00Vg6rROmdFFb2fB/YcAOHe7QhOEyrTzlUiE0YLJlOdv2HO8gSzrosUvkQjOH2aSwBGMImTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn/v39l6; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30b83290b7bso29120811fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742029764; x=1742634564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbm9z53yyr97OQh0sptuF1yqsD9U3jLtnUmZbsvhBGc=;
        b=Jn/v39l60/dMwlnA2VdvhX/3w21dSDiXsMdOWXmumCvMSpJBG8k8F/oF3o3y+5njuI
         Imh22WFxue51+4Sm/haGQSE3bUwQCPuPGUIAFixh1Gk3semLcPxzf/6yv/sLwh2OoIWt
         8A9VMgFA8yre6BiVCWG3bgIi9qxPj7fzXkTZvbpPm0U/Qr4UdHdbDhYO81+D0zVqv5V3
         Q+C+n5bNeHZ84gmEj6WZzZsogPe6l7q0JSsbMFzdWQfUz1lomIRn2SFKQz+iWY31lNeO
         6cU3WikuVaEVbu2mChrlItoZoxT4l7AZ/4AP/ydT6/bGxzS4RJugVvcWfXUkc2XyKd7G
         k7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742029764; x=1742634564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbm9z53yyr97OQh0sptuF1yqsD9U3jLtnUmZbsvhBGc=;
        b=ViE2CtGh1Je3j1HY4tf4ws9Vl94guk6AaqLyE8EVoplCyc4X14afDXl+01vJ+lU7rH
         9f2YNZ9h8UFy6ObEdx8IQrM6Ttgd5Ep1NJ2NSlr1d2YxdOdT8pF+wmyXmuhbOlIi936F
         O8wCyRu4JpgwHaFxu17azQtUarIKYOD7XkkITjrrYCmEBUfw9ERLVgtFnRE0u3oOk9ah
         VaWSX78bF1rXAAZkToGyP+2MG02wPPzw3hklRoHsWy5uap3Ll7V//LODgaBS/BX8weS3
         X3XFz/EMJa/RiMOJ62vwlrnN8dNz1+uFu0GUb/1tYRAsWLWf17z+N/Mk7MCi26BVf1UX
         5fIw==
X-Forwarded-Encrypted: i=1; AJvYcCWhy9iQKvHJE5sY7QdtMS+rc96Lf6SXGe/SgvvYIRiNXKqMLD2roXlP6KG/yWZC1PPeUvZjhcDR2YGx10w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxujNeZuMcXg3ZNCkvrBkqd6vdlt3B2wJz/+PMLcBXxX1VKswlP
	GwNHCdxRq/GJqCLrjjc7r/SOOzP19wUHn6icdi/KfcB15xCDEuVcbrPKMnZhy1rWEIxkx96KbQi
	Fl6u5ZDaP/sO52z4oROUfwa8AAwM=
X-Gm-Gg: ASbGnct31z2vvS9ATZjiLO72Lxp2vYSg0vqLB7l/V1+BtPOY1/HgqCQ9vp06c6DmuCb
	O1+Qkpsh4ZlxAYdy/WDJdIoAnXZDy/z8v+L9ODfWor4QPj8CL2+DOcEcVtsYnjt+KV5gnjnJyWI
	hgOHxEVNRbB2cjtO2todvzta2mlQ==
X-Google-Smtp-Source: AGHT+IGY1zlquM3FqkPyh1jI4yzNc7l1i6dK42nIVVgJkKbch/vxhOiwolP4lowilQlNb4L749l0EK5i2ovZXxG5HEc=
X-Received: by 2002:a2e:a370:0:b0:30b:c5e7:6e61 with SMTP id
 38308e7fff4ca-30c4a875eb8mr17906901fa.20.1742029763912; Sat, 15 Mar 2025
 02:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <1f39866bca670a7d0087febee29ab5061b8f9fef.1741988314.git.jpoimboe@kernel.org>
In-Reply-To: <1f39866bca670a7d0087febee29ab5061b8f9fef.1741988314.git.jpoimboe@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 15 Mar 2025 10:09:16 +0100
X-Gm-Features: AQ5f1Jr7Zc8uJLeOZRbbyE7Wok-4Qc_2lYcIRDz8bdUIDksE_UZMfwalfjsmgXU
Message-ID: <CAFULd4aY7bb6252YTFdPS4EZWi85Ra2MVr+4hVAP5X5_B8hvyQ@mail.gmail.com>
Subject: Re: [PATCH 18/20] x86/smap: Use alternative_io() in smap_{save,restore}()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:42=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> Use the standard alternative_io() interface.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/include/asm/smap.h | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
> index 60ea21b4c8b7..8b77ddcb37e7 100644
> --- a/arch/x86/include/asm/smap.h
> +++ b/arch/x86/include/asm/smap.h
> @@ -39,20 +39,22 @@ static __always_inline unsigned long smap_save(void)
>  {
>         unsigned long flags;
>
> -       asm volatile ("# smap_save\n\t"
> -                     ALTERNATIVE("",
> -                                 "pushf; pop %[flags]; clac\n\t", X86_FE=
ATURE_SMAP)
> -                     : [flags] "=3Drm" (flags) : : "memory", "cc");
> +       alternative_io("",
> +                      "pushf; pop %[flags]; clac\n\t", X86_FEATURE_SMAP,

Please merge two lines above (if possible, otherwise put feature
condition in the next line. Please also remove trailing \n\t.

> +                      ARG([flags] "=3Drm" (flags)),
> +                      ARG(),
> +                      ARG("memory", "cc"));
>
>         return flags;
>  }
>
>  static __always_inline void smap_restore(unsigned long flags)
>  {
> -       asm volatile ("# smap_restore\n\t"
> -                     ALTERNATIVE("",
> -                                 "push %[flags]; popf\n\t", X86_FEATURE_=
SMAP)
> -                     : : [flags] "g" (flags) : "memory", "cc");
> +       alternative_io("",
> +                      "push %[flags]; popf\n\t", X86_FEATURE_SMAP,

As above.

> +                      ARG(),
> +                      ARG([flags] "g" (flags)),

Uh, a build failure waiting to happen here. Please use "rme" instead
of "g". PUSH doesn't support 64bit immediates ("i") on x86_64 ("g"
expands to "rmi").

Thanks,
Uros.

