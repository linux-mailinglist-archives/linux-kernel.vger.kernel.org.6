Return-Path: <linux-kernel+bounces-374831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48799A70C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6FC281EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0DD1EB9F9;
	Mon, 21 Oct 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XtYs1RCT"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CF47A73
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530878; cv=none; b=Ky/CVa3tAlb+yvoWuXNNw24d5QZGhxlYI8g3+Zq0+utvCfac9WIL0bQLsALbYzgtgbx7VpMZQSX4NIxgDpO8ZLGnkjp8+BHZ1yR9uqGrvgnm06WbOxsiYvn9STfzRWkzaivIEKT8Dt5+w3l7+BkwRdH4QfsU0kZwxBj/wRpt+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530878; c=relaxed/simple;
	bh=CATGaHR4fhEy6l95MU+JqQ9n468on57jS5Irl2kdffY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhyAtG/i6vtxj2GPK4JYj+JipeRQzFNZmSm/LCiY/j35t/PDTlbOPlhMpVa47F1G6h+7DzH+A4lhLkSbLtgTF2ujVI+dZ7NFABv2TYiQqrLxftpbzvht8Q6CIezLE7XvkH7gR58qWgJdt0HTMVnpFsQQFT9JZRU5QS/y13BrFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XtYs1RCT; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539eb97f26aso5369603e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729530873; x=1730135673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsib8brj04kt5t31GVl9YzoyI3Dha46Vq2MQ+TRkJE8=;
        b=XtYs1RCTcIsxUqTsvY2i19KbGOilRFBb+z/98UW1F7zhULbJO7VTlMUEUW3Rwwe7AJ
         o/UnRQq4VsAuC0px015parDIFEfmHQ/h7aglHfbVUUMBHxkKUQ8MBBWrG/Fg/D0EQkBw
         OPYHUr1wjPj62JIBkksr/Y5VtYRw4A/fWqZo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530873; x=1730135673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsib8brj04kt5t31GVl9YzoyI3Dha46Vq2MQ+TRkJE8=;
        b=I5jwvkoHP2Zh2ZJORLeXXnddJQnQ2Ip5tQhmyJQduI5Q0bi4GBhNxS1+ocvfo12PZV
         p8Falb4Sr33UzpQaAcnW75a/NV9J4bMwhgKmrTSZoXizkHOgyvz2JjM/yAcQrRa69H5n
         D87YW4HfDQf5DoSAlF4QfmDBs3p5gZQSpBuqMWl1FXECIvbfHee/p4Y400dgraLekYGP
         hqxdI3/LZUvBTYDx2S/g2yzDtRhuJqmQBfBiU6wbumOP0XICICccka79FfRTiR6FJhBg
         bWrlqWtwhVDrAP9pfzOwZkxZELqr47zQG4nBb1MaFhYeziAuWZsBQ3CtPSX2ZeaFrPpK
         uvFw==
X-Forwarded-Encrypted: i=1; AJvYcCXcinzBF/Yrr1pmaiosZsNsyIYhdkdadIfYCn8sXo9UVdkMloyd0Q9Sa2YbUPR1LL9XDddlFQmW6Ini3h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy45kCcvCJyvYOHr5Wj/dMBBI+TChqJ2trPOEFZ6wdWdizGbU+A
	KpKJ679zBJ529v+LI0GRd/u7mpmGev3wSVIb74gT1cTue8l7zaw7Z8iwb2hoBzxMlrVx/9VTtzB
	aZw==
X-Google-Smtp-Source: AGHT+IEkYNP8R++Mi6pg7bNR0RPeZxFAgpGAyYkrmBFZNKRCW1HsHzziwesErkIQ97cVNmC3t/nVHQ==
X-Received: by 2002:a05:6512:3f13:b0:539:d428:fbf2 with SMTP id 2adb3069b0e04-53b12bfd423mr444772e87.13.1729530872600;
        Mon, 21 Oct 2024 10:14:32 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224202e0sm519406e87.167.2024.10.21.10.14.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 10:14:32 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539eb97f26aso5369541e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:14:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAloL38YLN/cAPp2dlwFZtikLrY/5Dj7Gpvhl8E4W1YNgGmlbCJU81eUPs7FB3F2kGleAQV2rnJTjubnk=@vger.kernel.org
X-Received: by 2002:a05:6512:31cb:b0:539:da76:4832 with SMTP id
 2adb3069b0e04-53b12c36b0bmr447752e87.37.1729530871219; Mon, 21 Oct 2024
 10:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019195715.GA810861@lichtman.org> <20241019204212.GA811391@lichtman.org>
In-Reply-To: <20241019204212.GA811391@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 21 Oct 2024 10:14:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UpKjTe78vexUXFThPXtx1KjhfR_u+1hpQpkh8ei-F5aA@mail.gmail.com>
Message-ID: <CAD=FV=UpKjTe78vexUXFThPXtx1KjhfR_u+1hpQpkh8ei-F5aA@mail.gmail.com>
Subject: Re: [PATCH v2] KDB: Fix incorrect treatment of numbers in the CLI
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Yuran Pereira <yuran.pereira@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 19, 2024 at 1:42=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> Problem: In many cases, KDB treats invalid commands as numbers and
> instead of printing a usage error, goes ahead and just prints the number
> in hex
>
> Example: This can be demonstrated when typing for example "aaazzz", this
> confuses KDB into thinking this is the hexadecimal 0xAAA
>
> Solution: Transition to using kstrtoul instead of simple_strtoul.
> This function is more strict with what it treats as a number
> and thus solves the issue.
> (also better practice as stated in the definition of simple_strtoul).
>
> v2: Removed redundant if condition I put in v1
>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>  kernel/debug/kdb/kdb_main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index f5f7d7fb5936..4cbd5cd26821 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -402,18 +402,15 @@ static void kdb_printenv(void)
>   */
>  int kdbgetularg(const char *arg, unsigned long *value)
>  {
> -       char *endp;
>         unsigned long val;
>
> -       val =3D simple_strtoul(arg, &endp, 0);
>
> -       if (endp =3D=3D arg) {
> +       if (kstrtoul(arg, 0, &val) !=3D 0) {
>                 /*
>                  * Also try base 16, for us folks too lazy to type the
>                  * leading 0x...
>                  */
> -               val =3D simple_strtoul(arg, &endp, 16);
> -               if (endp =3D=3D arg)
> +               if (kstrtoul(arg, 16, &val) !=3D 0)

Instead of just fixing the one case, do you want to just take over the
old patch series that tried to do a more complete job:

https://lore.kernel.org/r/GV1PR10MB6563E0F8DB2D335BD9CFE4D3E8B4A@GV1PR10MB6=
563.EURPRD10.PROD.OUTLOOK.COM/

I think in general that series looked good but just had a few nits on
it, but the author (Yuran Pereira) never followed up with a v2. You
could take that series, fix the nits, add your signed-off-by, and post
a v2?

-Doug

