Return-Path: <linux-kernel+bounces-290652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A019C9556E5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FF91C21028
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2856614884D;
	Sat, 17 Aug 2024 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="nu/O0F34"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138113DB99
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888106; cv=none; b=IBFxZLYJdbSBcA9dCMwabXiMS1ScFlzST+FK87+j53vT8ZVe4MT54mmwagSgMTSCQpi6Ddpdiavj1J7Ha7e4sHmBBBEGrHFm5tKTQ6UCL8q/VufNzL0km4n6MW20vXd7McIORPXBVvOU1hETHQUhVruUYjuHCKUfxwIo7q+kTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888106; c=relaxed/simple;
	bh=AZx2BJBXH8oQq7xdyF9rrqUH+UIpxBGVygKCLrGYUlM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=No4YoF6vM0SpP4nq6vsjprta2tiXLM7pv/H9KQ9N+2lvZzZSXlaLw6RgH76gETJs62xQKM0fBI/aBdSXPa341SEFEgliVKyYXCirge0F4+H7ZPECuNuF4bcvA9REsfZ+K5gtYHVIrQaJETUZ359+7EOi0zmMqGcFC5h34KfmSx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=nu/O0F34; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so32170381fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1723888102; x=1724492902; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=350RyIMKXGOQLd/8HTZr3pRXPYZz9XbRH5Vw+7o+H40=;
        b=nu/O0F34jB1ZW2kCAdf23PO7x4QFVu9KeHT0q5bfOC1hEkMcu6Gd8bU53YdBcjtarG
         tqaEYWucfci+eSkxiXvtQs14MTiB8zQMfWi9L7zL4cM4EJFGbWUdbwAHTe2BRbDMERxI
         BSr3o365xwZFvjO/UEAEci4eQJxr+bIhtVQl4iutRMxQfuw2u3PxDsJnH/M/SUKFQHKG
         cAqaEk5QP2GKtKp8qbKiTeZaArSvU5ArA3rBWj3k3AUzpowGTJ8viJ+GOHpz9X/pcQeA
         Xcz08Wcl3+nTMJB6JhziQNf5+gHfh1Kwips7pugKog2E9cgBuyZ7gq0LYaCpBqLRW07O
         Cdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723888102; x=1724492902;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=350RyIMKXGOQLd/8HTZr3pRXPYZz9XbRH5Vw+7o+H40=;
        b=FyKOPRi/9pYVZ9HuSVn4RrrffMRrNBgDFvFq4MzSfTDlzoHhYvB8ml7sb0dBZMGsSX
         nHjJiqEMc7M0eQskN3Hspud3SA2eZGgiXeeLbFzFgW9+S0n4Jp5Olu30lVngAnhFu5JA
         YA1gxe1q5jivvxHtpXKLSg3nI8Qg4GyBBuOae+8znBtcAFvrMKGRZiUWG2z7LVMQH09V
         6RzSlpSzm2DcoCVudPWoNuZc0Zl2QoTEJwp48aY5cShDfWweoSEkE5orrcbE/g8lKtVi
         GPYS1NQDXZugwg89jjTyIKCcObaTHgOe/oqkdkK/b0Vd6QU7Bv0W/zeuqRi48xl4hq7V
         teNA==
X-Forwarded-Encrypted: i=1; AJvYcCWLbHLPh/Ae0fjW2NRaKR9EUfInZGOiTGYNEhLFkcSUVfT9tNiNEJAzYepf0vicSPTBs243P+1fKpQS6FzqKJTfhQ71YVaCq2VA+Sj8
X-Gm-Message-State: AOJu0YxgosOUt8rdKDZN/n3ytVbW7y55VqD7GAtTdfvs1wrtvUHHZreU
	HuwT5r+6RCvWHtGUInHDXkhWYeSzQCi3X/pno3RN+V9MKA5xMXRXBNlviGGQi3M=
X-Google-Smtp-Source: AGHT+IHqnXF5BOfwuJW2UnmBiqatHyT9kJAyaAOLERxfSFlVm4kaSkuz6kKxlR9v7OJqRmYcz5htpg==
X-Received: by 2002:a2e:a490:0:b0:2f2:b2f7:c8a3 with SMTP id 38308e7fff4ca-2f3c91334ffmr10398731fa.44.1723888101375;
        Sat, 17 Aug 2024 02:48:21 -0700 (PDT)
Received: from localhost ([194.95.66.31])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6e96d61sm1829227173.67.2024.08.17.02.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 02:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Aug 2024 11:48:14 +0200
Message-Id: <D3I3BTOHN2RW.2DUYSKP3JRT5Z@fairphone.com>
To: <max.oss.09@gmail.com>, "Max Krummenacher"
 <max.krummenacher@toradex.com>
Cc: <stable@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] tty: vt: conmakehash: cope with abs_srctree no longer
 in env
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240725132056.9151-1-max.oss.09@gmail.com>
In-Reply-To: <20240725132056.9151-1-max.oss.09@gmail.com>

On Thu Jul 25, 2024 at 3:20 PM CEST, max.oss.09 wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> conmakehash uses getenv("abs_srctree") from the environment to strip
> the absolute path from the generated sources.
> However since commit e2bad142bb3d ("kbuild: unexport abs_srctree and
> abs_objtree") this environment variable no longer gets set.
> Instead use basename() to indicate the used file in a comment of the
> generated source file.
>
> Fixes: 3bd85c6c97b2 ("tty: vt: conmakehash: Don't mention the full path o=
f the input in output")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
>
> ---
>
>  drivers/tty/vt/conmakehash.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/tty/vt/conmakehash.c b/drivers/tty/vt/conmakehash.c
> index dc2177fec715..82d9db68b2ce 100644
> --- a/drivers/tty/vt/conmakehash.c
> +++ b/drivers/tty/vt/conmakehash.c
> @@ -11,6 +11,8 @@
>   * Copyright (C) 1995-1997 H. Peter Anvin
>   */
> =20
> +#include <libgen.h>
> +#include <linux/limits.h>

Hi Max,

Not sure this is the best place to ask but this <linux/limits.h> include
appears to rely on this file already being installed in /usr/include and
is not taken from the Linux source tree that's being built.

This mostly manifests in building Linux kernel e.g. in Alpine Linux
package build if 'linux-headers' package is not being explicitly
installed, failing with=20

  drivers/tty/vt/conmakehash.c:15:10: fatal error: linux/limits.h: No such =
file or directory
     15 | #include <linux/limits.h>
        |          ^~~~~~~~~~~~~~~~
  compilation terminated.

Apparently this is (understandably) also a problem when building on
macOS:
https://lore.kernel.org/all/20240807-macos-build-support-v1-11-4cd1ded85694=
@samsung.com/

I did try that linked patch a bit ago, but unfortunately didn't fix it
for the Alpine Linux build environment.

Any ideas?

Regards
Luca


>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sysexits.h>
> @@ -76,8 +78,8 @@ static void addpair(int fp, int un)
>  int main(int argc, char *argv[])
>  {
>    FILE *ctbl;
> -  const char *tblname, *rel_tblname;
> -  const char *abs_srctree;
> +  const char *tblname;
> +  char base_tblname[PATH_MAX];
>    char buffer[65536];
>    int fontlen;
>    int i, nuni, nent;
> @@ -102,16 +104,6 @@ int main(int argc, char *argv[])
>  	}
>      }
> =20
> -  abs_srctree =3D getenv("abs_srctree");
> -  if (abs_srctree && !strncmp(abs_srctree, tblname, strlen(abs_srctree))=
)
> -    {
> -      rel_tblname =3D tblname + strlen(abs_srctree);
> -      while (*rel_tblname =3D=3D '/')
> -	++rel_tblname;
> -    }
> -  else
> -    rel_tblname =3D tblname;
> -
>    /* For now we assume the default font is always 256 characters. */
>    fontlen =3D 256;
> =20
> @@ -253,6 +245,8 @@ int main(int argc, char *argv[])
>    for ( i =3D 0 ; i < fontlen ; i++ )
>      nuni +=3D unicount[i];
> =20
> +  strncpy(base_tblname, tblname, PATH_MAX);
> +  base_tblname[PATH_MAX - 1] =3D 0;
>    printf("\
>  /*\n\
>   * Do not edit this file; it was automatically generated by\n\
> @@ -264,7 +258,7 @@ int main(int argc, char *argv[])
>  #include <linux/types.h>\n\
>  \n\
>  u8 dfont_unicount[%d] =3D \n\
> -{\n\t", rel_tblname, fontlen);
> +{\n\t", basename(base_tblname), fontlen);
> =20
>    for ( i =3D 0 ; i < fontlen ; i++ )
>      {


