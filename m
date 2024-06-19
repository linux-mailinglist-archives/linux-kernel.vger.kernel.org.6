Return-Path: <linux-kernel+bounces-220834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DB490E7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D20E2820FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC98248B;
	Wed, 19 Jun 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ehBWRCi+"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9BB82495
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791830; cv=none; b=bLVYdKBuhB5Rj6XPgUVUOEaFmSWcX0nxBOn0aZ1UYb5M0DXJNUCRvX3zpvpmUtEcHDfaIPVvNS/7ge96BFWUDFwI6PacVC5rf4hv4UZl+dzMVYMeKah90WIEsHrR40g9EOLfoUNmTEoSuIkK8HmD+gRM/dUtSI25GNOOtQWRW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791830; c=relaxed/simple;
	bh=N45zKq2aQKCCGMd0eceleGJKTr4y8XnnRwYHdmGOExo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLuva8iZ+6L6Nqkd4QxifNq0VTiA6BWOaqmlFq2liiwPggNaqiWg2bX/kEe8E3Bx9qnq1JCFLfa1D/ni+WI3ng7rxgwrF8EvlddPnQEHm09i/3ssXoROVcA4e1TDPTjFyvZ7x/9TEM6+T68dvUxHIX3DasKfQ+T+0/Fi2EIBQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ehBWRCi+; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48c458b9aa7so2085257137.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718791827; x=1719396627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ngPGc/hFtGsrMMFvI2VR8EgB+U9LeNzTYZovoR1s9s=;
        b=ehBWRCi+0KP036/rL1p8XKV1xDGAHhwiE2S8APRBabMVBxveD1a5Qrzs/6PabL+XdX
         rxd97tkBLRaoG/y6J932gZ5zU5L1/+csk587cc3WKfd0ThkyBV+gpAYX65BAUtX/Y2pR
         re7Ufk+z15r8H/F0a/2Fk5EWV45ZbD0M4K57w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791827; x=1719396627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ngPGc/hFtGsrMMFvI2VR8EgB+U9LeNzTYZovoR1s9s=;
        b=Jj878Eaqgljtduq95d8gVWac07SNrTrh2vQkihrjq5QeAxdltzWasqqHPSHXJRCJFv
         CpTgMMcog9s6qNkhQcnkkWrIicMpsdGRrVVIBOQUFgBx4c/Q5u8ILFIxp9/uCxVEdk2C
         0OUkrlga6Psr4VWvENYUrQ81clXw75N7CPdYwnXIKZLuyFFH7EHwwaav12tpuGBKWYaG
         s877I9rJ5pbOkCb/YKRQVxIpHef9qUOouCG9LmFMJDhd2sVccOvpDUycOWZ8NcdbiucD
         YdhjZs98KQH2V0CU4Bu/VFAdgzMbvJATFm/+mLP63aux8aIX5OADH4XyI1q0oAX3STjc
         NIaw==
X-Forwarded-Encrypted: i=1; AJvYcCXoM4y8nHd+uknO/fUge1Gun1E1vSqgJXvIooTIqBqL2lMm4kDIyc6q3ool/jAN8hK5oHBogk3XxRp11UcGL3PimiGZtorvjGsO354o
X-Gm-Message-State: AOJu0YyOheefXhJClkKgLtK0MRP7NX6IeP74NLHYQy5evIBbCB9k7eki
	+yNlv6VflcPSpA5B/CgH4TF+/M3weXXjYJLABWO3CRyA8JTeYIWv3XNT2I6BIBJCR7/iObUfJGI
	=
X-Google-Smtp-Source: AGHT+IEcd153Da045sE1VhnnVnmoaw+o+jnkJmyMriKSbUA8cOy5dLc+6LS1xR3uiXogI0abCjUayg==
X-Received: by 2002:a05:6102:180d:b0:48a:36b0:87ab with SMTP id ada2fe7eead31-48f130bac0cmr2128101137.31.1718791827418;
        Wed, 19 Jun 2024 03:10:27 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48da43ff4f3sm2494826137.18.2024.06.19.03.10.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 03:10:26 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80f5a2af017so171755241.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:10:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUX/T/jslx/nZd8KgevLJNUYP30pTnQ6LhvvKCelXjLATyR45x5iJPzgfZ5ChidpGGxhUDMv3FE43L+q/NLEHVcNArRRp2oWoPtTW/s
X-Received: by 2002:a67:f80e:0:b0:48c:397b:3996 with SMTP id
 ada2fe7eead31-48f13007867mr2130877137.8.1718791825452; Wed, 19 Jun 2024
 03:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com> <20240322092845.381313-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240322092845.381313-3-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 19 Jun 2024 18:09:47 +0800
X-Gmail-Original-Message-ID: <CAC=S1niaYZ=NNTwfSrJPdj79uG_hmqGm=cz_Sis3Zrf9octsnw@mail.gmail.com>
Message-ID: <CAC=S1niaYZ=NNTwfSrJPdj79uG_hmqGm=cz_Sis3Zrf9octsnw@mail.gmail.com>
Subject: Re: [PATCH 2/4] soc: mediatek: mtk-mutex: Add support for MT8188 VPPSYS
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, amergnat@baylibre.com, moudy.ho@mediatek.com, 
	hverkuil-cisco@xs4all.nl, sebastian.fricke@collabora.com, 
	u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

On Fri, Mar 22, 2024 at 5:29=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add MT8188 VPPSYS0 and VPPSYS1 mutex info to driver data
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/soc/mediatek/mtk-mutex.c | 41 ++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-=
mutex.c
> index 73c256d3950b..b5af1fb5847e 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -496,6 +496,39 @@ static const unsigned int mt8188_mutex_mod[DDP_COMPO=
NENT_ID_MAX] =3D {
>         [DDP_COMPONENT_MERGE5] =3D MT8188_MUTEX_MOD_DISP1_VPP_MERGE4,
>  };
>
> +static const unsigned int mt8188_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] =
=3D {
> +       [MUTEX_MOD_IDX_MDP_RDMA0] =3D MT8195_MUTEX_MOD_MDP_RDMA0,
> +       [MUTEX_MOD_IDX_MDP_RDMA2] =3D MT8195_MUTEX_MOD_MDP_RDMA2,
> +       [MUTEX_MOD_IDX_MDP_RDMA3] =3D MT8195_MUTEX_MOD_MDP_RDMA3,
> +       [MUTEX_MOD_IDX_MDP_FG0] =3D MT8195_MUTEX_MOD_MDP_FG0,
> +       [MUTEX_MOD_IDX_MDP_FG2] =3D MT8195_MUTEX_MOD_MDP_FG2,
> +       [MUTEX_MOD_IDX_MDP_FG3] =3D MT8195_MUTEX_MOD_MDP_FG3,
> +       [MUTEX_MOD_IDX_MDP_HDR0] =3D MT8195_MUTEX_MOD_MDP_HDR0,
> +       [MUTEX_MOD_IDX_MDP_HDR2] =3D MT8195_MUTEX_MOD_MDP_HDR2,
> +       [MUTEX_MOD_IDX_MDP_HDR3] =3D MT8195_MUTEX_MOD_MDP_HDR3,
> +       [MUTEX_MOD_IDX_MDP_AAL0] =3D MT8195_MUTEX_MOD_MDP_AAL0,
> +       [MUTEX_MOD_IDX_MDP_AAL2] =3D MT8195_MUTEX_MOD_MDP_AAL2,
> +       [MUTEX_MOD_IDX_MDP_AAL3] =3D MT8195_MUTEX_MOD_MDP_AAL3,
> +       [MUTEX_MOD_IDX_MDP_RSZ0] =3D MT8195_MUTEX_MOD_MDP_RSZ0,
> +       [MUTEX_MOD_IDX_MDP_RSZ2] =3D MT8195_MUTEX_MOD_MDP_RSZ2,
> +       [MUTEX_MOD_IDX_MDP_RSZ3] =3D MT8195_MUTEX_MOD_MDP_RSZ3,
> +       [MUTEX_MOD_IDX_MDP_MERGE2] =3D MT8195_MUTEX_MOD_MDP_MERGE2,
> +       [MUTEX_MOD_IDX_MDP_MERGE3] =3D MT8195_MUTEX_MOD_MDP_MERGE3,
> +       [MUTEX_MOD_IDX_MDP_TDSHP0] =3D MT8195_MUTEX_MOD_MDP_TDSHP0,
> +       [MUTEX_MOD_IDX_MDP_TDSHP2] =3D MT8195_MUTEX_MOD_MDP_TDSHP2,
> +       [MUTEX_MOD_IDX_MDP_TDSHP3] =3D MT8195_MUTEX_MOD_MDP_TDSHP3,
> +       [MUTEX_MOD_IDX_MDP_COLOR0] =3D MT8195_MUTEX_MOD_MDP_COLOR0,
> +       [MUTEX_MOD_IDX_MDP_COLOR2] =3D MT8195_MUTEX_MOD_MDP_COLOR2,
> +       [MUTEX_MOD_IDX_MDP_COLOR3] =3D MT8195_MUTEX_MOD_MDP_COLOR3,
> +       [MUTEX_MOD_IDX_MDP_OVL0] =3D MT8195_MUTEX_MOD_MDP_OVL0,
> +       [MUTEX_MOD_IDX_MDP_PAD0] =3D MT8195_MUTEX_MOD_MDP_PAD0,
> +       [MUTEX_MOD_IDX_MDP_PAD2] =3D MT8195_MUTEX_MOD_MDP_PAD2,
> +       [MUTEX_MOD_IDX_MDP_PAD3] =3D MT8195_MUTEX_MOD_MDP_PAD3,

I know it's too late since this is in the tree already, but I noticed
that MDP_COMP_TCC0 is added in the 4th patch but not here.
Is that expected?

Everything else looks nice, so just a record in the mailing list:
Reviewed-by: Fei Shao <fshao@chromium.org>

Regards,
Fei


> +       [MUTEX_MOD_IDX_MDP_WROT0] =3D MT8195_MUTEX_MOD_MDP_WROT0,
> +       [MUTEX_MOD_IDX_MDP_WROT2] =3D MT8195_MUTEX_MOD_MDP_WROT2,
> +       [MUTEX_MOD_IDX_MDP_WROT3] =3D MT8195_MUTEX_MOD_MDP_WROT3,
> +};
> +
>  static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] =3D {
>         [DDP_COMPONENT_AAL0] =3D MT8192_MUTEX_MOD_DISP_AAL0,
>         [DDP_COMPONENT_CCORR] =3D MT8192_MUTEX_MOD_DISP_CCORR0,
> @@ -735,6 +768,13 @@ static const struct mtk_mutex_data mt8188_mutex_driv=
er_data =3D {
>         .mutex_sof_reg =3D MT8183_MUTEX0_SOF0,
>  };
>
> +static const struct mtk_mutex_data mt8188_vpp_mutex_driver_data =3D {
> +       .mutex_sof =3D mt8188_mutex_sof,
> +       .mutex_mod_reg =3D MT8183_MUTEX0_MOD0,
> +       .mutex_sof_reg =3D MT8183_MUTEX0_SOF0,
> +       .mutex_table_mod =3D mt8188_mdp_mutex_table_mod,
> +};
> +
>  static const struct mtk_mutex_data mt8192_mutex_driver_data =3D {
>         .mutex_mod =3D mt8192_mutex_mod,
>         .mutex_sof =3D mt8183_mutex_sof,
> @@ -1089,6 +1129,7 @@ static const struct of_device_id mutex_driver_dt_ma=
tch[] =3D {
>         { .compatible =3D "mediatek,mt8186-disp-mutex", .data =3D &mt8186=
_mutex_driver_data },
>         { .compatible =3D "mediatek,mt8186-mdp3-mutex", .data =3D &mt8186=
_mdp_mutex_driver_data },
>         { .compatible =3D "mediatek,mt8188-disp-mutex", .data =3D &mt8188=
_mutex_driver_data },
> +       { .compatible =3D "mediatek,mt8188-vpp-mutex",  .data =3D &mt8188=
_vpp_mutex_driver_data },
>         { .compatible =3D "mediatek,mt8192-disp-mutex", .data =3D &mt8192=
_mutex_driver_data },
>         { .compatible =3D "mediatek,mt8195-disp-mutex", .data =3D &mt8195=
_mutex_driver_data },
>         { .compatible =3D "mediatek,mt8195-vpp-mutex",  .data =3D &mt8195=
_vpp_mutex_driver_data },
> --
> 2.44.0
>
>

