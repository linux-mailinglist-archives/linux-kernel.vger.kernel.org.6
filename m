Return-Path: <linux-kernel+bounces-356835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC49E99677A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B73B2455A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F58190665;
	Wed,  9 Oct 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JiCgrORU"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE01917D7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470303; cv=none; b=rWsC7tQ6Ju8XYlrOqRBACy8iEYv6MKaHUERp7HgU7U07fkvFiCT1yPZofs8sUlaLqES7ey/h/FzCohr8v3+7a07G0sOl4IYyMTGsfkTUy/7E/5K/i6Q5g5GoZ0C0n1LSFvmWJ84XmG6kSdKSgkqVjQXkRWQVdZ8r1JXaPXg9LHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470303; c=relaxed/simple;
	bh=nB0qJf315S0Z2/pGNasKouhjG0Xme3kreiC0BS2FG1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWrb2fxL/yqLDfqniL3Nq7Da/zs32s3/XVRuKaoRkaG/elx1moKO5h24WvPf8XxRPONd8w9j6zjPzSdSh/R+hR3aoaUiABQRy9ehAkP3RurBWLaSeZDOOMrdPnrkwyV1xPDVplNaTT2XgCUcRvbvKm7VC673zGSJUexilqp7Sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JiCgrORU; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fc33fd8eso772001276.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728470299; x=1729075099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4S9RR3K6QnDDxjEOls4CSG3KtERGY2SF0IBRo/ZWYE=;
        b=JiCgrORUJaneIN4tqpe4Bxc+0GDL7IACs6wDS34VQnn5gcYJ0ofb8On+wfA/FvvHFK
         h5gDUwrKpeUFIy9Ort7NclbEDuGN8x8Ck+qHuGdexN7vMyPVplEbjEhwyMVmhZSvQQEd
         nNgsXm1Ox2VwNnso4tM7fajE3qjCwo3ukM+82TpUFxqpgWwVyyFIc+pflOEQhmD9M+al
         CFRL6mnn3AiwehukNDjnypTZ9RByqZFY4YyZblPIpR+VHn3Jg0U+xP0ZWZma/OdMAATe
         srh/DEQQBkiCC4tQX32t5mupWutZBgwutx3O8vl4Sn2OLhaWfNtjTLBh1OrIjr4WfSPP
         Ejww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728470299; x=1729075099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4S9RR3K6QnDDxjEOls4CSG3KtERGY2SF0IBRo/ZWYE=;
        b=Z1aNDxYeUbxaJOoVbkN7MptF8M7LIgPNho6CHBeFf+dba6CM4AruUiw94cFmPEM64G
         6gvvZLEum9FSpr+TDd909WQhD8yLuuKsuU1OKPo3M4pOEbJHRi11aHnzdaHUydEffZhs
         7jObH8PlfZTHW1rBPZoHoDu4/efu0hK2fOZz4h3mSj58XG4PeYTp9Wz7daVw9pULd8Ka
         i7DSaKvOYE9mUQDVVEqpjLqlQh+aR7grL1qYXYA4FgfIZAbnf+ZmLKn8XbOjpbRvPsh0
         nwaOESSeGUEkacMYgqSd23n3M3WThYa2NLBGlwXhaH8a16c+0kQ3fbAFDyh/jA8p7hYQ
         fCFA==
X-Forwarded-Encrypted: i=1; AJvYcCVOOctUy4nvepr0RPtoBRGHY75q2ZoB0s2MtTs8xEl6T9bVKorpSz/PAzsLrGxJKJtCpbTGZCFkFDheZlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCxB5r/QqW5O96y2bnOr+58nwNo8g4VU60u0ldK/zWZOhatgG
	HPKTDBViiay0xZ2S7UDngyU1ymBT3y4zNoMA1RIZmvdfvxWzY1oo6Ws3RVjaoqsV7F0fwPwvm01
	ZEahmxKEkvYdu4KGasrN2OnlaIHXcvIZaAr7WzA==
X-Google-Smtp-Source: AGHT+IF6wNDrtR2FR+iF3ORNX+EA7mJBmScQFeE/O1idJ5pgxpXmH+PgvKvohSwwMIQTiTd83HO2gsvdOY/p+lw2vhE=
X-Received: by 2002:a05:6902:1444:b0:e28:f132:3fae with SMTP id
 3f1490d57ef6-e28fe50c250mr1668617276.48.1728470299271; Wed, 09 Oct 2024
 03:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008160134.69934-1-brgl@bgdev.pl>
In-Reply-To: <20241008160134.69934-1-brgl@bgdev.pl>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 12:37:43 +0200
Message-ID: <CAPDyKFqvpSJCpG00NtDwpuxp51T8t9JGMm6Ssxvzpg4fNGSGBQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_spi: drop buggy snprintf()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 18:01, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> GCC 13 complains about the truncated output of snprintf():
>
> drivers/mmc/host/mmc_spi.c: In function =E2=80=98mmc_spi_response_get=E2=
=80=99:
> drivers/mmc/host/mmc_spi.c:227:64: error: =E2=80=98snprintf=E2=80=99 outp=
ut may be truncated before the last format character [-Werror=3Dformat-trun=
cation=3D]
>   227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
>       |                                                                ^
> drivers/mmc/host/mmc_spi.c:227:9: note: =E2=80=98snprintf=E2=80=99 output=
 between 26 and 43 bytes into a destination of size 32
>   227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   228 |                 cmd->opcode, maptype(cmd));
>
> Drop it and fold the string it generates into the only place where it's
> emitted - the dev_dbg() call at the end of the function.
>
> Fixes: 15a0580ced08 ("mmc_spi host driver")
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> - instead of fixing the buffer size, just drop the snprintf() call
>   altogether
>
>  drivers/mmc/host/mmc_spi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 8fee7052f2ef..47443fb5eb33 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -222,10 +222,6 @@ static int mmc_spi_response_get(struct mmc_spi_host =
*host,
>         u8      leftover =3D 0;
>         unsigned short rotator;
>         int     i;
> -       char    tag[32];
> -
> -       snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
> -               cmd->opcode, maptype(cmd));
>
>         /* Except for data block reads, the whole response will already
>          * be stored in the scratch buffer.  It's somewhere after the
> @@ -378,8 +374,9 @@ static int mmc_spi_response_get(struct mmc_spi_host *=
host,
>         }
>
>         if (value < 0)
> -               dev_dbg(&host->spi->dev, "%s: resp %04x %08x\n",
> -                       tag, cmd->resp[0], cmd->resp[1]);
> +               dev_dbg(&host->spi->dev,
> +                       "  ... CMD%d response SPI_%s: resp %04x %08x\n",
> +                       cmd->opcode, maptype(cmd), cmd->resp[0], cmd->res=
p[1]);
>
>         /* disable chipselect on errors and some success cases */
>         if (value >=3D 0 && cs_on)
> --
> 2.43.0
>

