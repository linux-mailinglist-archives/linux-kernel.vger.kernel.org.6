Return-Path: <linux-kernel+bounces-256639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06CD935160
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB11C21F92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757C41459E8;
	Thu, 18 Jul 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tI0wHB8M"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D814037F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721325284; cv=none; b=HQiEW/613gDbxyxEcY9oV08Vv421D1DVyPME86DHjq+unfNG5/GE/xaSMrCVX4wiahOaRezr3g1U5QTJZMrP2IkRaW/uDi8NHfZnDQ6liQL1mpPHTYoBAfGYScyJhiR/GNpMD0dNbiTFQka940nBkjnZM9lhkt4nz+Ay7WgMCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721325284; c=relaxed/simple;
	bh=er1KGbL9lI7rHYeiRUh/0c+RhXEbNw4CXvEBwGOKCek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrzmtG6BhRCE4TyzBNVPrVWUJ15T11cxXF7a1XHxrQ243VrjcHr1gzXnNE/s5mHtz9cXOM0169fP1YL0pndnPc2QVEIGIYLuengmHhPqEK0UfDMe6as6Ob5e9fFsAyNOsgbBlR3p20adXVTCeIaRVshx3z5e785fN/AgseKCFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tI0wHB8M; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-810177d1760so320514241.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721325282; x=1721930082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4SvoCOfHNYf2EY8mfu400oO+cE1SqNQGKec2qHgTrs=;
        b=tI0wHB8MNkeNURiYC9YiZWmCbSzwT9s+ClxUvG5RC4HmUtpgF02Vw9jH2aCC90X/gk
         rEIHP1Nag6WHPwnoB7ikM1uh065Y7cZ+MPt27sehooJAHoiBN7YdmvOvsclDIan1Qjw3
         xklhvtj/0EGNfjhBPO1Z04cXlSnYWWUI67lGlPQLsqM47I01Gzf3vB3BHq9gZPkCU0Jq
         BMVkO0GpIPOpoWrI0aInq59N3KHebKlMQrMW5iluzJptAXUpbXMo86bkaPl4NkNqUpjx
         FTuxTpOOsLHTZIczAzRgx2IJS54LMbZ2p6v7KWP5MMS4cnrAy8JLOHGXhCWRPP2K6mpr
         jFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721325282; x=1721930082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4SvoCOfHNYf2EY8mfu400oO+cE1SqNQGKec2qHgTrs=;
        b=H8MtM5/n30lB9fb0xsI68LaueB5RssSGa4V3XjSmmfr5F+TswiMpEewX51U3wBdK7U
         IY+mBrwf99CX99kM5+SjcsiggJk9Oa/9VKV3QBbOtPAEiLXQCnNkmOcQcRQP5fR2k35h
         Jv5vvXipXMryB6VBhXz4RmqRz2pm+6TkKuUJHeOknGzvPy613F3vXoVvnmnPO+G5oC2t
         fyZzvDPz6enLbflOjwaC1JTDtv7U8wZCYbS9W8JueV6VXBeWIC93sG7q/cLXpLZklTux
         wIR9k7xSXB/VJjFA4UPCKUMYTLxEqOJB4ID6+gOgQI3IF7K/aNDgSWjDdEu5Le4iU7Eh
         jUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1PwOi6MZFZwNrLKeJ6vRkH3sdxpO7PFykKWnOb14RJ+EbWU4QFiabg00Tkk+Qy5AV0PYuJNWkehIMCnY5gddVL/1B42zDjBXZrYCg
X-Gm-Message-State: AOJu0YwC20aCqhWTgZVEau3ROy/rGBioaBh6MgSQ6HD8aTg1Ifj+RW3M
	MgrSQB2ojJFupVOu4nZZ5pqKgM1SsnS5R4YlOWSgQOS1pBxprFihOP9iJCNtZLYr3yq2xI9NAaH
	4IbplcXYZGJM2wsi+hXdTstrPj8FbpP2zwEAf
X-Google-Smtp-Source: AGHT+IFu8fSO+esPncf5i90Eh9ur5Prn0Oq01lFyV4cisEHacDtIFIUR6lWCMmPTIx1Hw8JznJo213vAvtbAhHdx1OQ=
X-Received: by 2002:a05:6102:15aa:b0:48f:79de:909e with SMTP id
 ada2fe7eead31-49159849e1cmr8258860137.18.1721325281957; Thu, 18 Jul 2024
 10:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717182828.1527504-1-masahiroy@kernel.org>
In-Reply-To: <20240717182828.1527504-1-masahiroy@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 18 Jul 2024 17:54:03 +0000
Message-ID: <CABCJKucE0c7SLbf5sxcNCj+tiL9uwYDKspg2Zq0vjR-ZSePpng@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: add comment to discourage tools/* addition
 for kernel builds
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Brian Norris <briannorris@chromium.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Wed, Jul 17, 2024 at 6:28=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Kbuild provides scripts/Makefile.host to build host programs used for
> building the kernel. Unfortunately, there are two exceptions that opt
> out of Kbuild. The build system under tools/ is a cheesy replica, and
> cause issues. I was recently poked about a problem in the tools build
> system, which I do not maintain (and nobody maintains). [1]
>
> Without a comment, people might believe this is the right location
> because that is where objtool lives, even if a more robust Kbuild
> syntax satisfies their needs. [2]
>
> [1]: https://lore.kernel.org/linux-kbuild/ZnIYWBgrJ-IJtqK8@google.com/T/#=
m8ece130dd0e23c6f2395ed89070161948dee8457
> [2]: https://lore.kernel.org/all/20240618200501.GA1611012@google.com/
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Nicolas Schier <nicolas@fjasle.eu>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v2:
>   - rephase the comment for clarification
>
>  Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 768d3dc107f8..943899656977 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1328,6 +1328,12 @@ prepare: tools/bpf/resolve_btfids
>  endif
>  endif
>
> +# The tools build system is not a part of Kbuild and tends to introduce
> +# its own unique issues. If you need to integrate a new tool into Kbuild=
,
> +# please consider locating that tool outside the tools/ tree and using t=
he
> +# standard Kbuild "hostprogs" syntax instead of adding a new tools/* ent=
ry
> +# here. See Documentation/kbuild/makefiles.rst for details.
> +
>  PHONY +=3D resolve_btfids_clean
>
>  resolve_btfids_O =3D $(abspath $(objtree))/tools/bpf/resolve_btfids

Looks good to me, thanks for adding the clarification!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

