Return-Path: <linux-kernel+bounces-391923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7B39B8D66
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D621F23255
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E552E157E78;
	Fri,  1 Nov 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xIoTN7oF"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479103FF1;
	Fri,  1 Nov 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730451708; cv=none; b=TkEmxad+dfp00e9aReFf4aKcR1Je0gdFBoOyiWAgVuUnZ+pjdBqHqPlU/OSYAhgK/OLJVDLIHjfSJwNL0Y+vuvbpOvy4RzXquWxCvxpWraw5hfoUtUCKtoatGfzJvI38TDFz6RM2rwvM+TVhgVo1u1xtxTp2UinOSETqE7/tPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730451708; c=relaxed/simple;
	bh=J5++sjtFZWeNI50vrtuCNlQDzXvi1836X4y4WE7UGPE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVDguX3LmPEotLca6jgpTtUgVcbeOL4APrUmVxGM4vMSYlnRDPUS3nkU91TdcfFGvCnuZUGG85xzQ0KMKUlGMtlO/cpXfKhBgA+HSq9sfMzRYW9WW53tc8zTqKyFWjDIVLjw2YnI6GJnx40pCq2L4MUL70NoJSLcO4Ync2Q5CL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xIoTN7oF; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1730451697; x=1730710897;
	bh=Go4mtHQykmlWp4vclsuDHc2ni+VMGXx/GypLE6dY+gs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xIoTN7oF6JOMzCKFMU0XKqfiac9rzToMym+yjvSYUQM75UiJgCZqKOqE4QzMtePz5
	 70Hu4RB4RuOxuFtLZ70VJsMXPuEqQ4miNSXevbpwS3INa5kdj3UTLlhBVD1WwNCMZL
	 o2OTU5OgrjZOSnFPj1YHGrkhNzecnRlmtIXoqPRVvVZgUTZR/RJE8Lyyhj7Ur7AJ3l
	 ogN0G87pGd/XuZhplZJmQiT3pAV2Ye7+3ZzlyrVyezj4p2nys5brfeB13eLWnBd+Hg
	 Hz1ZnINuN16H0aNF95dQX8sc8LpfG+zMuy/rbdscl4hoTjcDL3sxgUOmAmerQZu/+1
	 0TgF839GXHZBQ==
Date: Fri, 01 Nov 2024 09:01:32 +0000
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: mediatek: mt6735-apmixedsys: Fix an error handling path in clk_mt6735_apmixed_probe()
Message-ID: <882779be-6d8f-441d-89ea-f8be79ffd3ba@protonmail.com>
In-Reply-To: <89ad840e7a484eaf4727470824acfe0fdc60fcef.1729871146.git.christophe.jaillet@wanadoo.fr>
References: <89ad840e7a484eaf4727470824acfe0fdc60fcef.1729871146.git.christophe.jaillet@wanadoo.fr>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: e77f34d9023207e3b609739a38960c2a439f5ca0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/10/2024 6:46 pm, Christophe JAILLET wrote:
> If an error occurs after a successful mtk_alloc_clk_data(),
> mtk_free_clk_data() should be called, as already done in the .remove()
> function.
>=20
> Switch to mtk_devm_alloc_clk_data() in order to fix the memory leak in th=
e
> probe function, and simplify the remove function.
>=20
> Fixes: 43c04ed79189 ("clk: mediatek: Add drivers for MediaTek MT6735 main=
 clock and reset drivers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>   drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c b/drivers/clk/m=
ediatek/clk-mt6735-apmixedsys.c
> index 104722a61dfd..e0949911e8f7 100644
> --- a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
> @@ -88,7 +88,7 @@ static int clk_mt6735_apmixed_probe(struct platform_dev=
ice *pdev)
>   =09if (IS_ERR(base))
>   =09=09return PTR_ERR(base);
>=20
> -=09clk_data =3D mtk_alloc_clk_data(ARRAY_SIZE(apmixedsys_plls));
> +=09clk_data =3D mtk_devm_alloc_clk_data(&pdev->dev, ARRAY_SIZE(apmixedsy=
s_plls));
>   =09if (!clk_data)
>   =09=09return -ENOMEM;
>   =09platform_set_drvdata(pdev, clk_data);
> @@ -114,7 +114,6 @@ static void clk_mt6735_apmixed_remove(struct platform=
_device *pdev)
>   =09struct clk_hw_onecell_data *clk_data =3D platform_get_drvdata(pdev);
>=20
>   =09mtk_clk_unregister_plls(apmixedsys_plls, ARRAY_SIZE(apmixedsys_plls)=
, clk_data);
> -=09mtk_free_clk_data(clk_data);
>   }
>=20
>   static const struct of_device_id of_match_mt6735_apmixedsys[] =3D {
> --
> 2.47.0
>=20

Thanks for the fix!

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>



