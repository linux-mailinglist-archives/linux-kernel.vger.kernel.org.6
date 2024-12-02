Return-Path: <linux-kernel+bounces-426988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A899DFAED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E01528198E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3ED1F9409;
	Mon,  2 Dec 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mzM4iV/D"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869631F8AFE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733122527; cv=none; b=doLddYUOzvennvvhj52x9iGfUdDo0600qvSNRADQkNmNGJZLB661RDMKJYNr6A6lBsgp3vuwpILhteF8SBWm0QrDBdKkLZ7QYpRqM8+VW4p4j6T9DtzsMaLwetVZa2GhxXuU2T6mEeozYVt8urq0K+oKR/XdQbR4o6SEPojJw8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733122527; c=relaxed/simple;
	bh=1bSb2HvkHJM161iVHbxIoMiZf6zQmATR8vcs+p+kvvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9XZ8Qh9ZTeCeeUbC5JSzRrU4/tv3CTpnT8TDDDlUDewYOSDPlMpyHF20Hy3WebKAF/3GRTV68c7ucmEjIlBfWbJ+xQ9L1aQ1pawTRpzlJnFK+t99mnqTOGh26QuYKuDXMoTJzvPBDiQb6zLKhNQkvrrdSVf3upNazxvYVElLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mzM4iV/D; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso36782451fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 22:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733122523; x=1733727323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0nWzD+Lx38ifdjx/0KeRfxG6lCIDsNbyc9nq09sPzg=;
        b=mzM4iV/DX6cugbZOkkDxYG1soZM81B95Ce6/JxpR9+2mBXtrdmboc/TbsASFviBJJm
         Xp9qL8Cgp7/QrRWcTK1m68XmMAaLcjUI3qx7kI9ASOeom29ysBuwI8enD0fakWicrpUp
         bMy899oygRdz1UFBXJq8LrJxf/pzxriJCMzNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733122523; x=1733727323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0nWzD+Lx38ifdjx/0KeRfxG6lCIDsNbyc9nq09sPzg=;
        b=c3zqKaiM1MhkBeeRBtZgg6+o57r/oZmQ5w/1+Q60DXGCJaT4EKUHjASfhi5w7u1y4P
         oWOmvQR5X2srk3dN4okvIbyk5MXUNorpnIjS+2qcU929B0/sx6ZxyW8fQE9GQqmqwqqk
         OxyVetNFDar5GIx/+E6D6imxvvkmrGGs7QomhThykTmVMS+0FCKOktlfks3cJXK6dIzw
         n2H8+0AmPmiQG1GvcN83KCu9qUImrO6A7l2IEcIyxbcfkwUm3exjW0bZxxADes0RVHrT
         /cvcXyRU/Q4vVoG1OIg0uvyjgHCv5MyGbRXi2VkDcMwoYqiM2lXqKzWyHZF2U2IViBnz
         2h8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1RBA2CZm6JvZDNPtHfKHEY3E4H0pJp0VItQ2PZeNGEC7G9eTPf5k4ldfWrON7RRw1vligAxr8eT6yNfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjS9YV5ax7yF4qAn2pu/sY3owHjqbdvi+k4uH+2UQ6KJbBWN1l
	kUmV83U7lDWEH+UFy5D63IsfRx5IiwD1XjcZjgh3n+dQVe9jjj97HEDxkb4ts4XQMHv3u2AphA/
	uO4uLhaji+2n7Xtc7ZjRBf227Q5HEuG1oK3pCDJpKhrLXzsY=
X-Gm-Gg: ASbGnctwx48shTTmV66uIqoAHe9yKYKnDoHgIuTA9RCBf2wVbiWKeTR+Z38vYPLOKmR
	002qXpm/8UTc9c7vSnlTWTe0ZYumK6OTHHh0+5oSb03AiRx0+Ff/ADM+emn0=
X-Google-Smtp-Source: AGHT+IEhDuPhpyGV4L/ou+jUfLRVYtfsYdtVwBNOmHBMpBMrZhusEFwHylPLoeDz7/iqzLHY2ZH7xlMhRw1T/BJzw6s=
X-Received: by 2002:a05:6512:3ba2:b0:53d:a132:c68f with SMTP id
 2adb3069b0e04-53df0112a63mr10446660e87.47.1733122522682; Sun, 01 Dec 2024
 22:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202062826.66619-1-wenst@chromium.org>
In-Reply-To: <20241202062826.66619-1-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 2 Dec 2024 14:55:11 +0800
Message-ID: <CAGXv+5EYkG=Y1vWDO6DWnUhd0WRuctYn_3w2YkvJoR_7JhsCpQ@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: mtk_scp: Only populate devices SCP cores
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Tinghan Shen <tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 2:28=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>

Oops. The subject should read "Only populate devices for SCP cores".

I'll let this one sit for a couple days before sending a new version.

ChenYu

> When multi-core SCP support was added, the driver was made to populate
> platform devices for all the sub-nodes. This ended up adding platform
> devices for the rpmsg sub-nodes as well, which never actually get used,
> since rpmsg devices are registered through the rpmsg interface.
>
> Limit of_platform_populate() to just populating the SCP cores with a
> compatible string match list.
>
> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-co=
re SCP")
> Cc: Tinghan Shen <tinghan.shen@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/remoteproc/mtk_scp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 0f4a7065d0bd..8206a1766481 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -1326,6 +1326,11 @@ static int scp_cluster_init(struct platform_device=
 *pdev, struct mtk_scp_of_clus
>         return ret;
>  }
>
> +static const struct of_device_id scp_core_match[] =3D {
> +       { .compatible =3D "mediatek,scp-core" },
> +       {}
> +};
> +
>  static int scp_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> @@ -1357,13 +1362,15 @@ static int scp_probe(struct platform_device *pdev=
)
>         INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
>         mutex_init(&scp_cluster->cluster_lock);
>
> -       ret =3D devm_of_platform_populate(dev);
> +       ret =3D of_platform_populate(dev_of_node(dev), scp_core_match, NU=
LL, dev);
>         if (ret)
>                 return dev_err_probe(dev, ret, "Failed to populate platfo=
rm devices\n");
>
>         ret =3D scp_cluster_init(pdev, scp_cluster);
> -       if (ret)
> +       if (ret) {
> +               of_platform_depopulate(dev);
>                 return ret;
> +       }
>
>         return 0;
>  }
> @@ -1379,6 +1386,7 @@ static void scp_remove(struct platform_device *pdev=
)
>                 rproc_del(scp->rproc);
>                 scp_free(scp);
>         }
> +       of_platform_depopulate(&pdev->dev);
>         mutex_destroy(&scp_cluster->cluster_lock);
>  }
>
> --
> 2.47.0.338.g60cca15819-goog
>

