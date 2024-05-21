Return-Path: <linux-kernel+bounces-184919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1377F8CADC8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418FC1C221E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93167580B;
	Tue, 21 May 2024 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i16wuEf6"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6574174BE0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292710; cv=none; b=Q3F3HRmKlfYl84Az22PqdMSveD+yZKzLTgcVw4A7lKZmpY2s1B8uoQwBBFinGHyKBvELJ2Wch2AnBETpkvc24ScU7f8TXmztQVvLoRS/tvjdGx3s7R7RlFcSqXoL1yEnG7HzNiy/XGiEsLuF/u2vaxqsUqH7c18AdxsfQ3Cc+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292710; c=relaxed/simple;
	bh=+jG9xuB22fwuEyYoMjAoIfNKefXg7UjyZjI8O0yUL1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcmXPzhe6h0Oyjxs8A0jwMwM2fxTo9w6+8jgcalSKHapFJ63f7HmvhWBXK8kvix1GWr3u2F3MYmRRny0vtH1cun0qpv6+O+OzJ7c6mnuVIRib3qea1R17jj3w6imzrxZA0bniCvMIvROU4Yx+5qfhrP+92uGghX9Wv8p9g15Bro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i16wuEf6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f0602bc58so3455918e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716292706; x=1716897506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl4xtrNRlcHoV7wSWCkM1k4KuXaSIIXaD0dOTimDbMs=;
        b=i16wuEf6hBEOF7wPO2nCAFDr4iyLyaGaYVOyzCQhLVM8LqiLDgR7jCwAp+f0HxHPqy
         5OdpDsLQnuiQbMQeB3ElPca25AwwgdP96o4wH3EjwuV5xwI0Z6zflhLnuc/uJPLZSqE3
         Xk45CBt1UgkvqHMgYix+iQ6DXjErakUWwrMxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716292706; x=1716897506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hl4xtrNRlcHoV7wSWCkM1k4KuXaSIIXaD0dOTimDbMs=;
        b=SreiiF34dDsIuueJy5snEDl+9RUCpl45mg+7nDwOc4T2LmZVl51VKncw2tnajjFxio
         8jnqw1k3V/C0uuq13HsX08MJzmQRuu5d/ZQ/IVih6E1qKCabpgAog81YwaQzT7iFQ7nN
         /G4qbxHbZGgU9B0516TeNeutls8W5+RWPIWRFCdn53kMIVwSILS4lFU2nYUa96RE6h8M
         OllnR1xbxHogWohXWOWH3bZVkP72pNhqnXbIz7ZQLMqrS/ECcSe+UHc/4Q4mBSq2M73d
         pXFnYEdhPDd0J+Kcqmbh+KZCjKwkZXfhjWnEMDTNUHkQJu/nLLUF+1FH2n/xaBDCaa3a
         IHyw==
X-Forwarded-Encrypted: i=1; AJvYcCUx7vv7ufU8B4lODuCEAyAA2MJhaRlPpR5pfd72nxiskbBUbEhGO+KIJxawCWjJojyaOxJ6IjDPzuYZWrXbrya93gPBNQWQPr1J+L6v
X-Gm-Message-State: AOJu0YwsE83ClqXeC/EqWOUe76TajuDweb4aewDbJ3enGqZc1KIGsyXm
	cJR6X8W4d1nZMM9Wg7NPoVhxlbQRXe3lNvuBtd6MdlssLcGgo+UqcF38xus6lUNMchhnt6D5WQ5
	USSvodaf7FiJxeBtG1AvgDdpNFi3W9zLKG3o=
X-Google-Smtp-Source: AGHT+IEXiOWYVRnPOopki3CzZjprFt3g5/j9ODw0x2C/5S+s2lOIlpY4HcdHUtANNR2oWvzSNQ+l4N1dKxOybd8VTNY=
X-Received: by 2002:a05:6512:31c6:b0:524:1f84:a0e0 with SMTP id
 2adb3069b0e04-5241f84a2damr2972496e87.22.1716292706745; Tue, 21 May 2024
 04:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-23-jim.cromie@gmail.com>
In-Reply-To: <20240516174357.26755-23-jim.cromie@gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Tue, 21 May 2024 13:58:15 +0200
Message-ID: <CALwA+Nb8EKBRk+1ejxWhRBhoYf=Arge5TvA-mPzDD95Am+7pYw@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 22/33] dyndbg: split multi-query strings with %
To: Jim Cromie <jim.cromie@gmail.com>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 7:45=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com> w=
rote:
>
> Multi-query strings have long allowed:

Missing been ?

>
>   modprobe drm dyndbg=3D"class DRM_UT_CORE +p; class DRM_UT_KMS +p"
>   modprobe drm dyndbg=3D<<EOX
>      class DRM_UT_CORE +p
>      class DRM_UT_KMS +p
>   EOX
>
> More recently, the need for quoting was avoided by treating a comma
> like a space/token-terminator:
>
>   modprobe drm dyndbg=3Dclass,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p
>
> That worked, but it left unfinished business; the semicolon in the
> example above is a shell special-char (one of the bash control
> operators), so it is brittle when passed in/down/around scripts.  In
> particular, it fails when passed to vng (virtme-ng).
>
> So this patch adds '%' to the existing ';' and '\n' multi-cmd
> separators, which is more shell-friendly, and also avoids quoting and
> escaping hassles.
>
> NOTE: it does break format matching on '%' patterns:
>
> bash-5.2# ddcmd 'format "find-me: %foo" +p'
> [  203.900581] dyndbg: read 26 bytes from userspace
> [  203.900883] dyndbg: query 0: "format "find-me: " mod:*
> [  203.901118] dyndbg: unclosed quote: find-me:
> [  203.901355] dyndbg: tokenize failed
> [  203.901529] dyndbg: query 1: "foo" +p" mod:*
> [  203.901957] dyndbg: split into words: "foo"" "+p"
> [  203.902243] dyndbg: op=3D'+' flags=3D0x1 maskp=3D0xffffffff
> [  203.902458] dyndbg: expecting pairs of match-spec <value>
> [  203.902703] dyndbg: query parse failed
> [  203.902871] dyndbg: processed 2 queries, with 0 matches, 2 errs
> bash: echo: write error: Invalid argument
>
> The '%' splits the input into 2 queries, and both fail.  Given the
> limited utility of matching against the working parts of a format
> string "foo: %d bar %s", nothing is actually lost here.
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/dynamic_debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index c1bc728cb050..625838bd74aa 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -596,7 +596,7 @@ static int ddebug_exec_queries(char *query, const cha=
r *modname)
>         int i, errs =3D 0, exitcode =3D 0, rc, nfound =3D 0;
>
>         for (i =3D 0; query; query =3D split) {
> -               split =3D strpbrk(query, ";\n");
> +               split =3D strpbrk(query, "%;\n");
>                 if (split)
>                         *split++ =3D '\0';
>
> --
> 2.45.0
>

