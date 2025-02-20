Return-Path: <linux-kernel+bounces-523861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B9A3DC31
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7260D17E72B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6310E1DE4DB;
	Thu, 20 Feb 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiWxuCyn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6921BC073;
	Thu, 20 Feb 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060593; cv=none; b=W/hgGb5X72gDJoZzpX3/Yvo3j1cUTT5RVVo5YCu50gYGUU7r+cct8qLjx4hRVbcs3LIe2x2XIQd2T6bhEcEZzmj/JNLgzVwu/6DCVsarg5fS66L7TlQ2nwbleUqGjXQaRmx1EItIrLwdauNtA+wDaxzb8vbExQgMuHTJyuqftPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060593; c=relaxed/simple;
	bh=x9CYPp92qt7nrQ8n1R6hogiZ3ztLUyzp5dk9F+0pnAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzKR1lI76g3ZsSvedl1UapkUxX68tu329flu6UxSNlwA18svp/8VgiAJGt3pnsCMARCxncSdrM+gXvEgpQ5xb/6fIOmGNa9RXKifPFHeSlMLs1tWPv6iKXz9QiGg0BQ675YDIuVdVg7eVlORvyd6f0E07q+QjwWvM8lgIWOpe5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiWxuCyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF21C4CEEE;
	Thu, 20 Feb 2025 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740060593;
	bh=x9CYPp92qt7nrQ8n1R6hogiZ3ztLUyzp5dk9F+0pnAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HiWxuCynedPnTLyt9VduRt3IIwD1IfgC1Cnl08Vn2y0UtKvqjmxX7ucBMSN8sRzkA
	 8XEK6trVBftYiqPjsDxU5Hn3rX7tZ/WsbN0JNuKQY5BGUFikvybXRtAwPvTXNeZthT
	 jYhAR5N91dXRWNGvY9vysE7EvcsmJGMzS6hY2YMuCJvdbTFarAu4H0Urq2WE/H+pdb
	 ttRKIzKxjpjfOKtPFZ5DTBfbWISx/puz4crnoNVq+KTT5C3eZnD2ud8w1YZ73edmHz
	 pLq9FhUZ4cxQfGqaKPph2YRru4cADZYuseTSZf3/ZjDXAh+k39ze+ZqVL0TBXzoMkf
	 wWS15/BieXUeg==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fcce9bb0ecso1726275a91.3;
        Thu, 20 Feb 2025 06:09:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYse57riNz1Gvaa6Ufq38G8h3UHyLFn+9G7DKm4HY3nvJD2s9Y2XXg0aOmyqJD1FYfrjBqmBIsU61P@vger.kernel.org, AJvYcCXIvGAI+q5SES+OzbtV6OCdP/1WlG77edNmWS3nB/3C9b7G36hsRTwQe9an66kwpxoTL9PiSm/6g4cGZHJ+@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcY84BJ7IfKKts5tzZJ77wKARFs01ub2/0JorP683QxwctsRT
	2XI1dPJjUnhWl1JbH9Ars6GTo3oktdk2DzKaBZsdATsXzOLH1PjzoELZmfjZXOyJWoftN9JgRCK
	sY2EO62WgM83+sNiVf0H3s4PGVw==
X-Google-Smtp-Source: AGHT+IE0v84Qb6FC/gDtH8xNJeXoFkB/nAfUjSnTsVJesFFxd/imMIypRaefBomgcHEC0WrtRHoFrNT9UaSnKPKXvqk=
X-Received: by 2002:a17:90b:4c07:b0:2ee:b8ac:73b0 with SMTP id
 98e67ed59e1d1-2fc40d1245fmr35061143a91.2.1740060593030; Thu, 20 Feb 2025
 06:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-30-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-30-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 20 Feb 2025 22:10:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9U4gNASfdiF=B-5+er0qs+F7V=gO1RwjuXw7FagMiUwA@mail.gmail.com>
X-Gm-Features: AWEUYZkEgaHMKjmDQHz4a-_W0aseAk_FLY9Y1EUWnfNXr-s5564_MkXpbtF3WgU
Message-ID: <CAAOTY_9U4gNASfdiF=B-5+er0qs+F7V=gO1RwjuXw7FagMiUwA@mail.gmail.com>
Subject: Re: [PATCH v7 29/43] drm/mediatek: mtk_hdmi: Use devm managed version
 of drm_bridge_add
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
> Simplify the probe/remove functions by using devm_drm_bridge_add()
> as now there is no more need to manually remove the bridge.

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
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index e79ebed21eab..f539472307e2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1674,14 +1674,15 @@ static int mtk_hdmi_probe(struct platform_device =
*pdev)
>         hdmi->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;
>         hdmi->bridge.vendor =3D "MediaTek";
>         hdmi->bridge.product =3D "On-Chip HDMI";
> -       drm_bridge_add(&hdmi->bridge);
> +
> +       ret =3D devm_drm_bridge_add(dev, &hdmi->bridge);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to add bridge\n");
>
>         ret =3D mtk_hdmi_clk_enable_audio(hdmi);
> -       if (ret) {
> -               drm_bridge_remove(&hdmi->bridge);
> +       if (ret)
>                 return dev_err_probe(dev, ret,
>                                      "Failed to enable audio clocks\n");
> -       }
>
>         return 0;
>  }
> @@ -1690,7 +1691,6 @@ static void mtk_hdmi_remove(struct platform_device =
*pdev)
>  {
>         struct mtk_hdmi *hdmi =3D platform_get_drvdata(pdev);
>
> -       drm_bridge_remove(&hdmi->bridge);
>         mtk_hdmi_clk_disable_audio(hdmi);
>  }
>
> --
> 2.48.1
>

