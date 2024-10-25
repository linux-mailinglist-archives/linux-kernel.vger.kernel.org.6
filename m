Return-Path: <linux-kernel+bounces-382718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D276E9B12A3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0157C1C219C8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F021315E;
	Fri, 25 Oct 2024 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QSphtebK"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603F20EA55
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895519; cv=none; b=XrAMiWndyW7JZ1p+2hxJL8ndgfkxxMslkg7GN/V640bJqsA3wNnW4bQLBDE+WWZhPKrEbJzQcSZ6QQRAV9Fj9M5zMM2oybOeJ3/4M9T7OSOPBKCQMFEcGsnPkZiKGAo95GUL8iLc0A59Ko5QrVZytL9xqmxvna613U/936FAdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895519; c=relaxed/simple;
	bh=Pmgxmkz/+mibX3Vvf+b416HY3mbxrWVnMpirkRa95Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OT3PdDsCVCI3OHPXdQ+nJNDr0soZRYhDU1m7HmfXeDNYZQjO0wD3VL4hzRYZ0JTULGz5sQD4Qndvxdc2cuUQrDg4sez40jB7nz1/f4pCEhy4biPExi3OcQvpL+n9lH9l3tUjiWvdD4PPLJuLhAOW1023L6lZw/zC1com8Kno5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QSphtebK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso26025511fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729895513; x=1730500313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+pu9+IFniI0vxwrFMTIumDSK37smBdwK2XEoZEbtTA=;
        b=QSphtebKM8aODZk1jtYghcstp4wQz8TY5tWSi2aSXn3fW3yTxGlvtsqP723o89UnJn
         O8am9o9uvAyldO5hkOEeWWijoAokcB+m4tPVn6CkIvm60lwp4FrYFP0mCD3qtq3KSon3
         4YkrYPLOCYYcLFH0+BEjc6EVuHYn2Jd4EvRZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729895513; x=1730500313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+pu9+IFniI0vxwrFMTIumDSK37smBdwK2XEoZEbtTA=;
        b=kWWgFo+ZjwQeNZdYvFssvqH8QpVNDMKGzrf0iC8zsibsIBTHu50d+QSH/Oyvu9r0oF
         mKwlb0mLLvnwHcGrjW0MoUw6jOAb0U+XDjc0IjcAv6IeiFFlsBXkl+tqQAAg4jJucVa7
         ShEK2BgyZvcvUjyqo6lvIvbWd3D85UQqKS20cyKOxJ0OKdxQmHHvzbKO0aQ56wyaFnTp
         VZSdEDrP0SGYdMKm6z3pIBSTev9XtCywTjT4vP9CJOxDQHpCGgoihRv1Ajl5cRVAuLIs
         l/RD0aR0F//SKAF59mCtWmF9cpBvwgwww9N34uILYzRWP/Dv0xnpHMDAG+vqu37kEO/y
         m37g==
X-Forwarded-Encrypted: i=1; AJvYcCVnczSPVKnKvLgF623m2vQqS/QwjR2CI6QI8B2uVpNs9goa7XST8MFdiFAog0CwKhksljBThhQ6NGf/gaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8NuV/kY64DLiEgg64eLFYeeduFUiimK0MzkBQpm4RqGxyGDt+
	yrrzCOyG+pZRfClXhRDtI7Lanx16zGDc/+tzMr3pOLHilo5CqFywqvqQb6vpSR+enpHSUd6TF62
	U2Q==
X-Google-Smtp-Source: AGHT+IHDjSmErzHWBIZWRYyWYJ+VAYhRzKydin815w5lNtRLLUHHQxXTePT4VDeExNAKz6AyKO9wAQ==
X-Received: by 2002:a05:651c:1548:b0:2fb:6110:c5cb with SMTP id 38308e7fff4ca-2fcbe08cf6amr3564371fa.34.1729895513423;
        Fri, 25 Oct 2024 15:31:53 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4618b4asm3385981fa.131.2024.10.25.15.31.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 15:31:52 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so27536261fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXnHfzgJ+HUNk7j3kvPdVi+mJiIhW7Ds5KTSSElZ7PoTQ9yc2RS8/cTHkGjtgOBdlrGv/h9HOIS1J+rKg=@vger.kernel.org
X-Received: by 2002:a2e:612:0:b0:2fa:d4ef:f222 with SMTP id
 38308e7fff4ca-2fcbe0a8fa2mr2908991fa.38.1729895511516; Fri, 25 Oct 2024
 15:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021211724.GC835676@lichtman.org>
In-Reply-To: <20241021211724.GC835676@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Oct 2024 15:31:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+sGVF91WFDpB9cdXboCnL1NX6nZ4z2qE_ctYqZ0sNkw@mail.gmail.com>
Message-ID: <CAD=FV=X+sGVF91WFDpB9cdXboCnL1NX6nZ4z2qE_ctYqZ0sNkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] trace: kdb: Replace simple_strtoul with kstrtoul
 in kdb_ftdump
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 21, 2024 at 2:17=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> The function simple_strtoul performs no error checking in scenarios
> where the input value overflows the intended output variable.
> This results in this function successfully returning, even when the
> output does not match the input string (aka the function returns
> successfully even when the result is wrong).
>
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
>
> This patch replaces all uses of the simple_strtoul with the safer
> alternatives kstrtoint and kstrtol.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple=
-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>

I have the same comments as patch #1 about authorship and noting what
you changed.


> ---
>  kernel/trace/trace_kdb.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index 59857a1ee44c..eadda6e05526 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -96,23 +96,20 @@ static int kdb_ftdump(int argc, const char **argv)
>  {
>         int skip_entries =3D 0;
>         long cpu_file;
> -       char *cp;
> +       int err;
>         int cnt;
>         int cpu;
>
>         if (argc > 2)
>                 return KDB_ARGCOUNT;
>
> -       if (argc) {
> -               skip_entries =3D simple_strtol(argv[1], &cp, 0);
> -               if (*cp)
> -                       skip_entries =3D 0;
> -       }
> +       if (argc && kstrtoint(argv[1], 0, &skip_entries))
> +               return KDB_BADINT;
>
>         if (argc =3D=3D 2) {
> -               cpu_file =3D simple_strtol(argv[2], &cp, 0);
> -               if (*cp || cpu_file >=3D NR_CPUS || cpu_file < 0 ||
> -                   !cpu_online(cpu_file))
> +               err =3D kstrtol(argv[2], 0, &cpu_file);
> +               if (err || cpu_file >=3D NR_CPUS || cpu_file < 0 ||
> +                       !cpu_online(cpu_file))

FWIW, this is still changing the indentation of the second line in a
way that makes it worse list like v1 did [1]. :-P The "!" in "!cpu_"
should line up right under the "e" in "err".

That's a pretty tiny nit, so I'm OK with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

When sending v3 you'd want to keep Masami's Acked-by tag and my
Reviewed-by tag. They should go just above your Signed-off-by tag.

