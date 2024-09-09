Return-Path: <linux-kernel+bounces-320789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96871971033
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F33F1F227F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCEA1B151D;
	Mon,  9 Sep 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0YWHXAD"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70EE1B150B;
	Mon,  9 Sep 2024 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868097; cv=none; b=AudAyrAmQi/Gd+qTICvOzhxUveRJ2CJNi/n6+eyENin0RmwKEmG6PQVfMosB4VNdc2QO1RIIiBx83pnRDcVoWZM9vSvYQcVZO7s9sS16AL1/ZpuVJIal187dqP/I9gVWkJP+xkHHWKsOzsURlE+tboiDpM+7o4yWM/uYWP5Zb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868097; c=relaxed/simple;
	bh=RCblciRLmG9vwIGMPBDV32VowG4pF6LjK3qZle6qcVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEyYo4+6W85NeWIr8c8pr7s5TCLtIrXlyHgxjpZvQ5XfSFE9GEYiLJq+RUyAq6vsDOAPgYZPWcPhNNFqeQk3dUyfqlkc3SdO2EbKxyA1DnVsw+y/CTHtdaVEGICjPKwUyetvk4WBcvi/3v47zvvfKc7y7CNKqihegYvCW11NVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0YWHXAD; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84876d069acso1066330241.3;
        Mon, 09 Sep 2024 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868095; x=1726472895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9C1TrwRuNl2V3GdBORwdTZyl/hPud0NNpEnj3t5Hu0=;
        b=D0YWHXADo8ECBmnz/ZTZ2yhNVTE569SJKPYclvx5KpStwYJ3l6WgK9iYmV1Z8MU/++
         PkUTXQWG3M6hU7OSidujHRovcSA+wk4OALkly5sGs4daR7n00c9MBc7hOftFyij/0dL4
         wajbiPPehSSnvPBQXKiutYpgZjaSh0p1wBCzH5I66gPKc51yocxrKxuWS8m3qdWkDrYU
         S3qneWtcWEerxZt8jJ/LXKS1JmFc2h/EvxYDUSWJ0M1MDFLN8Je46lquY5tUjigA4UT0
         a1Zkvk/WA0rurOpd/AnM/xg/ITxaYNL/88+sBN1RB/Buh2vRrPquyQA1YD8NCtX1iLH6
         EX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868095; x=1726472895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9C1TrwRuNl2V3GdBORwdTZyl/hPud0NNpEnj3t5Hu0=;
        b=PCENI+H1nWZ5DOel4WJcY1Jz+u5AQsdWnnIV6i8CbL+nZsV6oAUMf6wdrPkrdWnvKP
         6KIL3XX4oADi8xKBwzQZL1+UEJv+iv4ESaMaBKSralXEn86yz8UbDGmY4C9CLNwTUf1W
         LoOTvrtnsvq+V85MufzxhFl09vRdfnvMKmIJkHgwNzecQxsy962+ZBjAf21zZVS82rqo
         SjxrkjKKyn7zf1D/eI411BHpjYvSrZXumvZBtlJ7OLTegBImdjAqZsPp6Ld8XiyXqWXI
         vl+RY+mjCYNceXSF05FPKejU+36rU7D+3H+CFWfRWM8917t0a35C1ZmkOMhkik79qd5R
         /EnA==
X-Forwarded-Encrypted: i=1; AJvYcCUpYkKUPEXRL5JBjOeJfZ27JLZXHwY8AsxsyZFdGFd55roei2nffMyb77dxTne7rVJ60tvIFSqBWC2JSCAW@vger.kernel.org, AJvYcCWl390D6pnwMg40n0mbFtWQ+bwXtTcd6wRFTwa/8RSBhp6L/BJXUi7DaiEX8gjMnjTYxc78UqpfK58L0m+sVLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCp78W/20kyEhUIIPiqiBTYoXXxWuw9quoGu6NlREamOD+Aga
	C2BajFYY8Xg6ni30a8nf12ZupY3rQ9q2c9ARpxyEnabkzvensJ+yvARsjwIrC8oo9XOpbIY8USi
	ImcL7L2nuyyQ9Re1aIaU1/dyC+Lo=
X-Google-Smtp-Source: AGHT+IHiWIxeOUfdstmRt3zKkEtldlv+HPEGhxFdfwRbfddLjqQ4CbgWfszpdINyzfVt+SIxOKtfIyXhSXbma0f1ztw=
X-Received: by 2002:a05:6102:3f44:b0:48f:89cc:dd2b with SMTP id
 ada2fe7eead31-49bde1960d3mr7916750137.11.1725868094457; Mon, 09 Sep 2024
 00:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725791361.git.christophe.jaillet@wanadoo.fr> <1aaff0efb601832cd11949653d5872e7e39fbd7f.1725791361.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <1aaff0efb601832cd11949653d5872e7e39fbd7f.1725791361.git.christophe.jaillet@wanadoo.fr>
From: Iskren Chernev <iskren.chernev@gmail.com>
Date: Mon, 9 Sep 2024 10:48:03 +0300
Message-ID: <CAL7jhicmTD5Ukwjwdpp14L9aoe4PeqNAUijGnhHZ+DDhetZxiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: max77826: Constify struct regulator_desc
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Iskren Chernev <iskren.chernev@gmail.com>

On Sun, Sep 8, 2024 at 2:41=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'struct regulator_desc' is not modified in this driver.
>
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
>
> On a x86_64, with allmodconfig:
> Before:
> =3D=3D=3D=3D=3D=3D
>    text    data     bss     dec     hex filename
>    3906    5808      16    9730    2602 drivers/regulator/max77826-regula=
tor.o
>
> After:
> =3D=3D=3D=3D=3D
>    text    data     bss     dec     hex filename
>    9218     496      16    9730    2602 drivers/regulator/max77826-regula=
tor.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> --
> Compile tested only
> ---
>  drivers/regulator/max77826-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/regulator/max77826-regulator.c b/drivers/regulator/m=
ax77826-regulator.c
> index 5590cdf615b7..376e3110c695 100644
> --- a/drivers/regulator/max77826-regulator.c
> +++ b/drivers/regulator/max77826-regulator.c
> @@ -153,7 +153,7 @@ enum max77826_regulators {
>
>  struct max77826_regulator_info {
>         struct regmap *regmap;
> -       struct regulator_desc *rdesc;
> +       const struct regulator_desc *rdesc;
>  };
>
>  static const struct regmap_config max77826_regmap_config =3D {
> @@ -187,7 +187,7 @@ static const struct regulator_ops max77826_buck_ops =
=3D {
>         .set_voltage_time_sel   =3D max77826_set_voltage_time_sel,
>  };
>
> -static struct regulator_desc max77826_regulators_desc[] =3D {
> +static const struct regulator_desc max77826_regulators_desc[] =3D {
>         MAX77826_LDO(1, NMOS),
>         MAX77826_LDO(2, NMOS),
>         MAX77826_LDO(3, NMOS),
> --
> 2.46.0
>

