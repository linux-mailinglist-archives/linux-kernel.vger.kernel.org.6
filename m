Return-Path: <linux-kernel+bounces-523922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1180DA3DCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD701645E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0B41F8EFF;
	Thu, 20 Feb 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjmJyU+j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CA28EA;
	Thu, 20 Feb 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061923; cv=none; b=tGODDkhuWgX4MExmHhSjWVtJx+thbUfYtXKoMz1mGxvHcvenHKgv6JisxpqvA+mv5P+ZfeOAwpeUxQMLPUY3MXc+904USLz/WA14CL2FUHugiYvL7rnZloM3OVEKyN6OisekLt6Lvbl7aBKNRWrj0w1u9JQMqojjMUiSrPtM4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061923; c=relaxed/simple;
	bh=GoGvedSskUunt8JR0ab0OKe1KhMr9oaefFluEv4FAqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCtv064fO0b2ntfdeQBiTht7hxG6kLD2Rde0C4usWd+Bd6Nijf/Dixw+HlQYRWleRGlnPj3gjhtnCgIcfpDZXdNiAhBP50maSWh/JsPpcRpAaaNm8FSGVIFY8myDGfx7oCnRihdXfIXLoeU8TtmJO2pDNtzizjcSRQrjZcI07W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjmJyU+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3917C4AF09;
	Thu, 20 Feb 2025 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740061923;
	bh=GoGvedSskUunt8JR0ab0OKe1KhMr9oaefFluEv4FAqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BjmJyU+jXO9wcmng76nLJ/zgZme8LgV8F0crqAhH7kvY3zW9ea74lEjJqAxWsXukp
	 N01BsmLRRcczRdhIGbHIrQ40uIgVOojwYi1/l/YgZOoThWIjLxQtc6Y5A/ywMc3Z8b
	 Da3lgj4JchDjRNlOyD+TMTLzdSIY1deamLy/aWzZfpOg4M1TZLmsPWqwu5jzBeWLDi
	 wbf6WtxKT1bOmH4UvHf2L4aIQBS4u1ybc7uPjYHM4GjJ8J8+zl7gEE+5S8hKHzJekb
	 BwNuueGBvkDmvA5w0y5IZoD8JK/m1eTEmOESlVJrXPvmq7Of4cgq8qZiFdBnbADiQ+
	 vKL9WXO9MkwEQ==
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso2092813a91.0;
        Thu, 20 Feb 2025 06:32:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvNVHhYd6Qa+CI1nQm0xlEeHzFj3+Wtz1HyeVo+EOrmavgrKltjSuiLYs4nIM22lvC9MeRkZopJl8qi4sf@vger.kernel.org, AJvYcCXaR9kQ57or3aKhYqSXZhwGhTn7HzyvPl436LbOINvWPjAmc3C0B71ctTEVhdURTtZHGrfI9ef2Dsl/@vger.kernel.org
X-Gm-Message-State: AOJu0YwBjH0Yx4hJ6QGvDXuLGKpUkzFnMT82FKZH1+zB08swVYNAn9Jw
	+M1UikN0zOS81547STJWBl1iww1alD23O0WsqLBGtuWmPLXza4CrQdwTrT1TqJz66yVts/hsZ89
	FAru//AYEkPqBRugdLL/294EeAg==
X-Google-Smtp-Source: AGHT+IEEvVnA4H81470tv1H4G5h0w0yEGHELm51+9xXj/GLBqX14Y9VHjS4nUzKS5Ntqk6uBqNxa9Lc6bKjwcl3wf1E=
X-Received: by 2002:a17:90b:3809:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-2fc411509b7mr38299734a91.33.1740061922487; Thu, 20 Feb 2025
 06:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-34-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-34-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 20 Feb 2025 22:32:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8a+oV_XwBACyy09bKdwKVy+iEPxbfZBkkdYm2jYD_k2w@mail.gmail.com>
X-Gm-Features: AWEUYZnj0eBVMJFGwcqYWEal64YwZLRUffmMdq4xRpXkJqA2A3_JsPYTIk5oAgc
Message-ID: <CAAOTY_8a+oV_XwBACyy09bKdwKVy+iEPxbfZBkkdYm2jYD_k2w@mail.gmail.com>
Subject: Re: [PATCH v7 33/43] drm/mediatek: mtk_hdmi: Cleanup function mtk_hdmi_resume()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com, 
	jie.qiu@mediatek.com, junzhi.zhao@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
	dmitry.baryshkov@linaro.org, lewis.liao@mediatek.com, 
	ives.chenjh@mediatek.com, tommyyl.chen@mediatek.com, 
	jason-jh.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2025=E5=B9=B42=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:=
50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Remove the error print in case of mtk_hdmi_clk_enable_audio()
> failures: since the APIs will already print on their own, having
> one in there is redundant.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 50f9ab48cbf9..2614561e2634 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1704,15 +1704,8 @@ static __maybe_unused int mtk_hdmi_suspend(struct =
device *dev)
>  static __maybe_unused int mtk_hdmi_resume(struct device *dev)
>  {
>         struct mtk_hdmi *hdmi =3D dev_get_drvdata(dev);
> -       int ret =3D 0;
>
> -       ret =3D mtk_hdmi_clk_enable_audio(hdmi);
> -       if (ret) {
> -               dev_err(dev, "hdmi resume failed!\n");
> -               return ret;
> -       }
> -
> -       return 0;
> +       return mtk_hdmi_clk_enable_audio(hdmi);
>  }
>
>  static SIMPLE_DEV_PM_OPS(mtk_hdmi_pm_ops, mtk_hdmi_suspend, mtk_hdmi_res=
ume);
> --
> 2.48.1
>

