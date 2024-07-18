Return-Path: <linux-kernel+bounces-256404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B04934DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1AF1C21C25
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4A013D25E;
	Thu, 18 Jul 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNZOdzPU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC654645;
	Thu, 18 Jul 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308365; cv=none; b=fe7zOoUd2KfoPfYxXjBPT73jeEqOoucbtJMouqIHHs2tJ1i7sAlYv1B9XYHSw9I6xBkpawUuk1xuM6GYFnzH1w6R/5LXXCMkOXfrLlDyNenXy7bHrI78uhs0y/Tz9OLNqz8lWbR8yPaiLID+/gmqxBv9CzC0Op64og2UKiMqR7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308365; c=relaxed/simple;
	bh=vYl8MNkELU4Ts7nwqTZXYDv94oAOQlp6vOMvp3c6lbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWevThNvri8tiBsUxTl3dk6cOp/+acsxDlGT0dOPDPk0qGPwMVWwNA30Ez3IBodky1qPqoXJauwcuiTVgcYiGDeY/LgOQw024F18NDpXDOY4k4Yxtsc5zIlbdxMiUvMenS5os1sESNFOU//gefnAxD0sd/w0fjMXkomOW1URL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNZOdzPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78C9C4AF0F;
	Thu, 18 Jul 2024 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721308364;
	bh=vYl8MNkELU4Ts7nwqTZXYDv94oAOQlp6vOMvp3c6lbk=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=mNZOdzPU3IGxduoRU3eUL8+SX4K40LDy43/8SFyyUGj22aTZUbJcavTaKvCCXaQb0
	 x86PJXfz31XIQdtuOnQls/V7gf4vxWQOmRxxPoLFcaZfeWkktO1CeYnKPvSkhKdiUO
	 rgu2Nrv1Vcpj2Gj/4iqrKWjjg4JVLIQAD2FwprcXGD7ncx8+28RVs+O964iS3yC2IL
	 n55bS1Nd1OiOAvbbRz6MfhGbL1qZgwhAi7+ZeLGBIU7l7TRU0e7lPhUCeuBvQwqHb/
	 8FLmFwLMLfq4BKUwqME4qEwFlf7wgu7xuwwm+6kezNO0tKMk6RwT9qWgZOAEmk/9t3
	 WVB7hotnzJHjQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6659e81bc68so8732677b3.0;
        Thu, 18 Jul 2024 06:12:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2edz7UiXXEhrzEqSz840ejpZwDlSz6OJe+mKlNls87+lB/+/SYq5dWn39knA3o7N2Qzp+70we/AZI3y+sVM7jb+0vvQuFa8gMu/5n30zpAciL/eRStu1rGpvHnnjlgFwvGAfzFcuZd2o=
X-Gm-Message-State: AOJu0YygwpfQLOAaoGEeS18xf/kP0xvrGKn1pLsHoUPGZVQ1adkZT3yK
	0fwPI4pU9knjaSuBB8zty9mZV0SUyNhJBBNG8jvtmydte93T5k5kzICix+pvSHhwsQH8HdqLQzK
	jS+1mA4TFMGnWnTWQcK7aVhVfH/8=
X-Google-Smtp-Source: AGHT+IGHGsKu3aGgiDsmP3QMUlXnyDu/titXfL14zN189O3HKZ68TtQ10LQvGGJTe2Rdb33EsSSV39sXbLdHNJmfdlQ=
X-Received: by 2002:a0d:e443:0:b0:63b:ce21:da7f with SMTP id
 00721157ae682-664fe74049dmr51662367b3.21.1721308364100; Thu, 18 Jul 2024
 06:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718070022.591-1-shenghao-ding@ti.com>
In-Reply-To: <20240718070022.591-1-shenghao-ding@ti.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 18 Jul 2024 09:12:32 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4cRtsC6a3AvW65==seufG3zoiUtL0N9PPLpYNEvNYwwQ@mail.gmail.com>
Message-ID: <CA+5PVA4cRtsC6a3AvW65==seufG3zoiUtL0N9PPLpYNEvNYwwQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: tas2781: fix the license issue for tas781 firmware
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: linux-firmware@kernel.org, zigo@debian.org, baojun.xu@ti.com, 
	13564923607@139.com, v-po@ti.com, linux-sound@vger.kernel.org, 
	robinchen@ti.com, linux-kernel@vger.kernel.org, mimperial@lenovo.com, 
	cchen50@lenovo.com, soyer@irl.hu, stuart.a.hayhurst@gmail.com, navada@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 3:01=E2=80=AFAM Shenghao Ding <shenghao-ding@ti.com=
> wrote:
>
> Fix the license issue for tas781 firmware, which are shipped as .bin
> opaque. Remove the GPL-2+, which imposes having the source code
> available.
>
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/257

josh

>
> ---
> v2:
>  - Drop "Found in hex form in kernel source."
>  - Drop Allegedly, Add Redistributable.
> v1:
>  - Remove the GPL-2+ and fix the license issue.
>  - Update the year of copyright.
> ---
>  WHENCE | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/WHENCE b/WHENCE
> index b2fc018..3d95a97 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -7384,10 +7384,8 @@ Link: TAS2XXX38E0.bin -> ti/tas2781/TAS2XXX38E0.bi=
n
>  Link: TIAS2781RCA2.bin -> ti/tas2781/TIAS2781RCA2.bin
>  Link: TIAS2781RCA4.bin -> ti/tas2781/TIAS2781RCA4.bin
>
> -Licence: Allegedly GPLv2+, but no source visible. Marked:
> -        Copyright (C) 2023 Texas Instruments
> -
> -Found in hex form in kernel source.
> +Licence: Redistributable. See LICENCE.ti-tspa for details. Marked:
> +        Copyright (C) 2023 - 2024 Texas Instruments
>
>  ------------------------------------------------------------------------=
--
>
> @@ -7397,10 +7395,8 @@ File: ti/tas2563/INT8866RCA2.bin
>  Link: TAS2XXX3870.bin -> ti/tas2563/TAS2XXX3870.bin
>  Link: INT8866RCA2.bin -> ti/tas2563/INT8866RCA2.bin
>
> -Licence: Allegedly GPLv2+, but no source visible. Marked:
> -        Copyright (C) 2023 Texas Instruments
> -
> -Found in hex form in kernel source.
> +Licence: Redistributable. LICENCE.ti-tspa for details. Marked:
> +        Copyright (C) 2023 - 2024 Texas Instruments
>
>  ------------------------------------------------------------------------=
--
>
> --
> 2.34.1
>

