Return-Path: <linux-kernel+bounces-436372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E309E8516
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 13:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9E81883D46
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C40146D76;
	Sun,  8 Dec 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBuqr+zJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5445BEC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661979; cv=none; b=W/0ab/s6OeYhSOm3eLBRnMfZ5gCQJYz7AMyKLPV+jYNhYRlEBDrDpMZElclRz7RbkQwD4wrUNbubGlC6sTP3rC4ZCYBYJl8LNww09QXXcO8ewr0gH4GxBU/ncgN6qEGaFT5/GYDT7FCUkzxhcvYdCFnh226T/3XSiriOvzQhpJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661979; c=relaxed/simple;
	bh=G+p6aefG5yTpC04xhnXMg+zxOzq9PDrkHv1FtQWhmjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMtQ9FGYlRMBXxFOFAUh+2J3LOVyn3zzp2V5WkE61W+VQGuV3hmTKrxRqEz5im2UN8Z8IRvmHinZWnKMODisKMmlf0nk/Q6tXDE28tWO/5ikokaGnIaFX77CGmQIV5FRbQ4d8Kg3/0OhhsL4wlfIErTVcorXkM41A/uOGMN6b0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBuqr+zJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AC8C4CEE0
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733661978;
	bh=G+p6aefG5yTpC04xhnXMg+zxOzq9PDrkHv1FtQWhmjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RBuqr+zJhG7T7ETBCjD5wUuICT9Ijq5dM4p0zCt65JTCLyUDKQB8/SuXpyVAP++AH
	 A2rllN39igG2Hx6nAOB7Mmlg6pdhQJaVNIB3ukUggTTtELO643c3Q/M3Mx8KsUf3Be
	 vPhhPa5iKSNenvL3MPVOaVdyEsy2vJtMjb5td5x+N99Kp0+AJC4e6GZZDJGLLVxp2D
	 e0z8esvPno9QOwr8eNWrwCVHE2Z8z1IrsL1CjkeRTo5inPG/5dU+OWsWwKbXsSH2/Q
	 T0771uIfqZLLE0xCin/8kgVuhnyYt3t18Wys9Ip9UFs8MaslaZNktnfozrWM1sE4Gm
	 FfR2Sz9wvMx4Q==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so4529271a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 04:46:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwnAf/ctPmAqN79kOdDG6nZgQppGia5yqpvWFq9qTGutUe8j15ImKFCTAl8Pz4/omXfn9ZhRpIycdgA7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCyo/niOWxAShJx5Pq+LDRwTi1qcaKTGJxpWVqWSztnzcX6jiy
	VIuz3c9WgYgE0TnndRJUp5sHwgetwbRLsdazXeh9uz4+inGbgW8w10IlCHAKzEszzZKl5H5Ac9n
	iS1VPAR8KVbRM0NYgTXnf4Zehzqc=
X-Google-Smtp-Source: AGHT+IH3ogGJ5uTEHqVPnkSRuDUt4C4nLjG3FPP0Jee8N3ikUt+9YXllbY96+wrPitK4OC9qpZnMjPBzUCCeAoV7X48=
X-Received: by 2002:a05:6402:1d12:b0:5d3:cdb3:a60 with SMTP id
 4fb4d7f45d1cf-5d3cdb312e4mr7386739a12.34.1733661977372; Sun, 08 Dec 2024
 04:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025094650.253599-1-hanchunchao@inspur.com>
In-Reply-To: <20241025094650.253599-1-hanchunchao@inspur.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 8 Dec 2024 21:45:14 +0900
X-Gmail-Original-Message-ID: <CAGTfZH2fMx6-Aitn8y3hFmtpdxaYJGUNoVePBrfDgFi-opWeOw@mail.gmail.com>
Message-ID: <CAGTfZH2fMx6-Aitn8y3hFmtpdxaYJGUNoVePBrfDgFi-opWeOw@mail.gmail.com>
Subject: Re: [PATCH] extcon: realtek: fix NULL deref check in extcon_rtk_type_c_probe
To: Charles Han <hanchunchao@inspur.com>
Cc: stanley_chang@realtek.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks.

On Fri, Oct 25, 2024 at 6:55=E2=80=AFPM Charles Han <hanchunchao@inspur.com=
> wrote:
>
> In extcon_rtk_type_c_probe() devm_kzalloc() may return NULL but this
> returned value is not checked.
>
> Fixes: 8a590d7371f0 ("extcon: add Realtek DHC RTD SoC Type-C driver")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/extcon/extcon-rtk-type-c.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-r=
tk-type-c.c
> index 19a01e663733..2820c7e82481 100644
> --- a/drivers/extcon/extcon-rtk-type-c.c
> +++ b/drivers/extcon/extcon-rtk-type-c.c
> @@ -1369,6 +1369,8 @@ static int extcon_rtk_type_c_probe(struct platform_=
device *pdev)
>         }
>
>         type_c->type_c_cfg =3D devm_kzalloc(dev, sizeof(*type_c_cfg), GFP=
_KERNEL);
> +       if (!type_c->type_c_cfg)
> +               return -ENOMEM;
>
>         memcpy(type_c->type_c_cfg, type_c_cfg, sizeof(*type_c_cfg));
>
> --
> 2.31.1
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

