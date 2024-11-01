Return-Path: <linux-kernel+bounces-392476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFFE9B94A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805182829C1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D81C729B;
	Fri,  1 Nov 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eohk9tsF"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073325634
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475787; cv=none; b=Laq4lyVjgzKsrXT4LT0OYqkeXCO9gbfgIG+EU+YqM/YEpOcirhTHT40uEO9Wr46r+EzRoNHpsg4iS5mynpL5YoA8PuLa+VZStF4KgIYaCYaabDkVAeu8iTDJf6XPdbui3OXLzFtML57FPqJiOUegZjwqlsCD19Wy+JmI7rQUwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475787; c=relaxed/simple;
	bh=4gZdD+3++gol8nGmxN7/4JFnTNURyznM1zpTtJDSSM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFwcTF6KTqmR9MW+eKvX+OCNlPIUF8W0zpjca1ZBGhjbeEauhOd4pj6tGtPo2kEIHKlGtHNiird0mxWfWaWbO1V6f5+opIKn6i1FMf5sakAsAE2Pu1uOxNGCwFg6o4bAstJb6K4JkIAFyCmlgIg2d9frhfn1B+TFQ6V7UM+XoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eohk9tsF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e6c754bdso1998433e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730475782; x=1731080582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJwxENcc3mC3+hRr6uLgVea6nCh5dJpo3ohINRfZN3Y=;
        b=Eohk9tsFqGkG8RF3lXUhfYIdRf7B+OURg2ZZHzFNmO+mpGI9NxFHzD3y7q0nIwDQMl
         nb+6uIeoEc02VzAoXm9e1xkYVR2llEbqCDJZnhKk/u9D1cb97Sb6ZdyCaKyfyHlEkmGa
         ifHjl963pHEi/bjF5cklacyBj2z0i7UF0ZLZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730475782; x=1731080582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJwxENcc3mC3+hRr6uLgVea6nCh5dJpo3ohINRfZN3Y=;
        b=usJgUXtnEIxQKcofci/54jzTWdSDULhCPsbphLe3VB9gL+QKUGVhLItrPhbnEd/ON8
         GQj+/mxCcu2sTODPy0U87S0VKj7H0hS/jlDg9ERqc3ryZ6BknJ3GnTcZY5gucUFsEIVc
         RQxtKaFV32+oD7RkjovH39Gj3d+GrRXQQhOopti9aOkaSob6fn/mVH81b+JHQ7U9cVbO
         rcfwK+LlAEZClXhxckNArzn3W6BPWKz2BNRkcKo+qC78HFKvK2XcdUXo+9IT+g/DWGUZ
         OZwL4T4AeTkCiddx+FxMTVlbPWzGHmWaNMrCgNA8+9N/nnojrtSh39P3eevyf0O2W1xc
         UlTA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ90uow9EP9GjInqybmPXOPOKs7CrRRPhhMDMTcl2NjZrT9zcHNiM0H8MeQQHlvv2h21/EuNDqJahxJf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzoQKilHz0mV3M5KlzB8Sk6CGsSJtzHvKKHTlxAwJo/2zUK3jl
	2u1Z4SSZO2q1bBnzn8sJm4Vw92AUnRx28okmbmW/yRujRZ7SBWKjFhMvEUWTNIeremmpz44VhmW
	RpM+2
X-Google-Smtp-Source: AGHT+IGc8k4xNkSG2u84wUkkrwFI2A8WS6kQwDEJDGduqTaEi5jBmiUKQHozbxPSzieByDD6RyYI2g==
X-Received: by 2002:a05:6512:2811:b0:539:f6c4:c29d with SMTP id 2adb3069b0e04-53c79ea4f23mr3955136e87.54.1730475781819;
        Fri, 01 Nov 2024 08:43:01 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde0c34sm592904e87.269.2024.11.01.08.43.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 08:43:01 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so2887190e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 08:43:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTifTCoJULHlIiJwxp42AhmlopuhRZpRBaW+GCWDfCHoDEBZkldPURoPRugaUCKfHrKKFnt23MSmtLRfM=@vger.kernel.org
X-Received: by 2002:a05:6512:3c96:b0:539:f699:bb2a with SMTP id
 2adb3069b0e04-53c79e2ff0amr3812872e87.20.1730475780269; Fri, 01 Nov 2024
 08:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031204041.GA27585@lichtman.org>
In-Reply-To: <20241031204041.GA27585@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 Nov 2024 08:42:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XY-mH2FxnnMsA99jQ2ZCcd=psTn+VJ4R9h9htK-f2ihw@mail.gmail.com>
Message-ID: <CAD=FV=XY-mH2FxnnMsA99jQ2ZCcd=psTn+VJ4R9h9htK-f2ihw@mail.gmail.com>
Subject: Re: [PATCH] kdb: Fix incomplete usage help of md, mds and btc commands
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 31, 2024 at 1:40=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> Fix kdb usage help to document some currently missing CLI commands option=
s
>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>  kernel/debug/kdb/kdb_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Some of this is a bit similar to what I tried to do at :

https://lore.kernel.org/r/20240617173426.2.I5621f286f5131c84ac71a212508ba14=
67ac443f2@changeid

...but that series kinda fell on the floor because my end goal was to
try to get it so I could access IO memory and Daniel pointed out that
what I was doing was unsafe. The earlier patches in the series are
overall good cleanups, though. If you're interested feel free to
iterate on any of them.


> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index f5f7d7fb5936..0bdffb17b163 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2667,7 +2667,7 @@ EXPORT_SYMBOL_GPL(kdb_unregister);
>  static kdbtab_t maintab[] =3D {
>         {       .name =3D "md",
>                 .func =3D kdb_md,
> -               .usage =3D "<vaddr>",
> +               .usage =3D "<vaddr> [lines] [radix]",

In my patch, I said:

.usage =3D "<vaddr> [<lines> [<radix>]]",

...so I had the <> characters and nested the []. I think that the <>
is supposed to signify that you're not supposed to write the text
"lines" but that it's a variable.


>                 .help =3D "Display Memory Contents, also mdWcN, e.g. md8c=
1",
>                 .minlen =3D 1,
>                 .flags =3D KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> @@ -2686,7 +2686,7 @@ static kdbtab_t maintab[] =3D {
>         },
>         {       .name =3D "mds",
>                 .func =3D kdb_md,
> -               .usage =3D "<vaddr>",
> +               .usage =3D "<vaddr> [lines] [radix]",

From my prior research, "mds" doesn't support <radix>. However, some
of the other "md" commands that you didn't modify do support
lines/radix. Let me know if I got that wrong.


-Doug

