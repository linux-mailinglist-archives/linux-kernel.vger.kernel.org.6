Return-Path: <linux-kernel+bounces-255269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A2933E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A1BB23274
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BC6180A8E;
	Wed, 17 Jul 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN9vrbIB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D85181305;
	Wed, 17 Jul 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225574; cv=none; b=nRlVTudvAmMtLMRCoWlen16fUcxfhbd4dz3zfhAL9suODpgSqZd3KkfruhBSAEj/FUcyqDfwMQSZ/UNdWQB7HuZtMm+awgNcM+u2dIYEWoUIuQ1hPhjJklfVswwX3IiiS6tpD55kwW5iiZxnPqZB65JnQzX0RMg7jd9UTB+1uck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225574; c=relaxed/simple;
	bh=UcbWLPYQntYVmfXK2X6IbJP5lHIGrxw6vOIqQ/cn1s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnsJSsua/yr9liur/FO7OqrZ6lqDHx39yBZ86bfPoHgS+lUkgTHZgC156anMBIwRuppweA5kkC7Lx7gFOAObZLWKZVcnUJF2VxeEKQU7FZAwLzDEAoX+y1Q1lIlzLMqAQAUKM1rcAP8S88/1NqZVRvlzf6eE+EVKkc/haUlAzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN9vrbIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A451CC4AF61;
	Wed, 17 Jul 2024 14:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721225573;
	bh=UcbWLPYQntYVmfXK2X6IbJP5lHIGrxw6vOIqQ/cn1s0=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=LN9vrbIByptEvwnomQXqWzdC3QlGo62qxKV9cxz63VPGUBsomfJl6u90aLNhJR6v5
	 53ybm7kyxZQg8qJ6+qbcCSuymtIBw5QUvEjCiL8pCzNBiKyTM38fXBk4NRkIpAf+3r
	 Iq4gBrKuqY/JWsEisRdCPQsjqxYiWyBVWXCMGatmzDWqYBiI1TFWgCZ67HbfoyKZI1
	 xmLnN9gncUMbl1peo7GUKbJ4uc8Y0xrCmbPqKJRoBx59HGT7yAztM0oLRwPPznMnni
	 ucBnEd5caqaIbd/v0W6KRbWmai7UTx/b64wJoAuvM3ZxsjLTYGKkkL7JDLb29NTt+P
	 uBxRyCWR6jcig==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65f852c82fcso43494567b3.1;
        Wed, 17 Jul 2024 07:12:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkb6uQ/B8XA/RM4alJHkAf9Ggl9eyqsFtMajtMKIebufIjw1mrMABrQpeR3QCVHXzpgtVOUwm7noWaBvpZ+/sI0qMZk6RG2YeDGsDb+iuZ59UmYSCV/nEZLXOeAmVwjC5IbYcRlkCT45A=
X-Gm-Message-State: AOJu0YxVeGUs1bda3/WVZbAieTTGq/kV98aByns7NqVvg/F9GDvBkW23
	30FXERshwmVFFRlwlENeRQb0DvrmiOOdSr3YDoK9LMerRpmjCZq3WFE7aqAuuwzCfICfOzPGmaD
	QkSx1JgV/oQlb2wbjJTki8A2r37c=
X-Google-Smtp-Source: AGHT+IFjODKypc3lezmIIFKqlRNeK8zb0Fg6q8S7rMTD1YQYcc7RC4iiQWiwvHZdvcRV245lHjF2h9E2cL0tShkyqSY=
X-Received: by 2002:a05:690c:6c8b:b0:61b:3304:b702 with SMTP id
 00721157ae682-664fd59ec35mr25309827b3.5.1721225572793; Wed, 17 Jul 2024
 07:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717050919.692-1-shenghao-ding@ti.com>
In-Reply-To: <20240717050919.692-1-shenghao-ding@ti.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Wed, 17 Jul 2024 10:12:41 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5y5q_uXsmLykeNny6h8GLJTOqk_y2X7-bnnFtZsJRb=w@mail.gmail.com>
Message-ID: <CA+5PVA5y5q_uXsmLykeNny6h8GLJTOqk_y2X7-bnnFtZsJRb=w@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: tas2781: fix the license issue for tas781 firmware
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: linux-firmware@kernel.org, zigo@debian.org, baojun.xu@ti.com, 
	13564923607@139.com, v-po@ti.com, linux-sound@vger.kernel.org, 
	robinchen@ti.com, linux-kernel@vger.kernel.org, mimperial@lenovo.com, 
	cchen50@lenovo.com, soyer@irl.hu, stuart.a.hayhurst@gmail.com, navada@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 1:10=E2=80=AFAM Shenghao Ding <shenghao-ding@ti.com=
> wrote:
>
> Fix the license issue for tas781 firmware, which are shipped as .bin
> opaque. Remove the GPL-2+, which imposes having the source code
> available.
>
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>
> ---
> v1:
>  - Remove the GPL-2+ and fix the license issue.
>  - Update the year of copyright.
> ---
>  WHENCE | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/WHENCE b/WHENCE
> index b2fc018..b5b12c2 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -7384,8 +7384,8 @@ Link: TAS2XXX38E0.bin -> ti/tas2781/TAS2XXX38E0.bin
>  Link: TIAS2781RCA2.bin -> ti/tas2781/TIAS2781RCA2.bin
>  Link: TIAS2781RCA4.bin -> ti/tas2781/TIAS2781RCA4.bin
>
> -Licence: Allegedly GPLv2+, but no source visible. Marked:
> -        Copyright (C) 2023 Texas Instruments
> +Licence: Allegedly LICENCE.ti-tspa, but no source visible. Marked:
> +        Copyright (C) 2023 - 2024 Texas Instruments
>
>  Found in hex form in kernel source.

I realize this was likely a copy/paste from other existing (and very
old) TI firmwares already listed in the WHENCE file, and cleaning it
up is the correct thing to do.  However, I think this patch needs to
go a bit further.

First of all, either the firmware is licensed under the
LICENCE.ti-tspa or it isn't.  I'd suggest:

    Licence: Redistributable. See LICENCE.ti-tspa for details.

for the license statement.  It's certainly not "Allegedly" at this point.

Second, this firmware was never found in hex form in the kernel source
as far as I know (which is where the original ambiguity came from with
other TI firmware).  If that's the case, drop that line as well.

josh

>
> @@ -7397,8 +7397,8 @@ File: ti/tas2563/INT8866RCA2.bin
>  Link: TAS2XXX3870.bin -> ti/tas2563/TAS2XXX3870.bin
>  Link: INT8866RCA2.bin -> ti/tas2563/INT8866RCA2.bin
>
> -Licence: Allegedly GPLv2+, but no source visible. Marked:
> -        Copyright (C) 2023 Texas Instruments
> +Licence: Allegedly LICENCE.ti-tspa, but no source visible. Marked:
> +        Copyright (C) 2023 - 2024 Texas Instruments
>
>  Found in hex form in kernel source.
>
> --
> 2.34.1
>

