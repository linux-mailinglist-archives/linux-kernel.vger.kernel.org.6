Return-Path: <linux-kernel+bounces-269287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5C2943105
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157EAB257BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8F11B0125;
	Wed, 31 Jul 2024 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnHFNj3V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E801B1503
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432870; cv=none; b=Xc3/My++u1gyV5uMEdZw+cG/GQUuvBW/f31PpJY7xjHOOeFfDiXlAzVCwkOB/VNtbm/Ilvc+1bDGGYdViqjrNKeqgrt7tEDQfnCMMxlbEO5AHt0QGmwGTN59XR1tgwaH9MjA5YU7dGZQVktcRN5N5nZUvL+oC6OFXR0+9YMsLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432870; c=relaxed/simple;
	bh=A+80YZ1JEr//DzbbfCPYd8sgD69akjqIYMI4pV9hTXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKHFv09TCgmj67w5U2DE4Xiu3CC8APobVNzyceFh5+xK0KnqIQ3VnJI6lDKLtX1AhLguYDLia/GGjvcLYPlwjyGL/5DqZ4xunmzXLVtNIXlgJJ1l+LP/Ho7iyNedyhX8QZPcS0Xq2rQgLP1ZOCu/ZkvWbRJylTNQu31QKFB3Mis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnHFNj3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA19C4AF13
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722432869;
	bh=A+80YZ1JEr//DzbbfCPYd8sgD69akjqIYMI4pV9hTXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZnHFNj3VxhaEY5RPZEthUUpJti6CuGvrzLT5UiOZjIqeBX6sW8OshcUR3VfVPpdkA
	 SQmCMXJlsQDYqdmtoJ1/cpwhOimBiBUalB+KOO45moiDx2mPC+3zINLaWJnGND6N/B
	 AYVlpy+hyWUiZqxGXR5hP/nDn5yq/Bhs/BPtLplu1QhNPBMbFj/jUF2eTfMSPWMsdl
	 t6nRWKjSTASv/54p/b53VsXUxdgwJqonT4gv9PvBxNBw28tAdUivjVe456TuyLJqZz
	 LX4x0RgYav53nNo7zRnTd/TqWiqEwFRCQuJmQWh3zuT8ZQIOvo/CcXFPBz/hrTZgBP
	 pW/QmB7x/TbIw==
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d399da0b5so5011006b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:34:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7PnsBZy+KgmVQ6cUqrQ6r6SFkf7Tbo+HzMucrh4LAtcxI/tXs/xOjzXKPiGibq2YzpwsrFL7KRrt5ccqrn5MnWf5Z8ieP9YucCN+v
X-Gm-Message-State: AOJu0YxAREQ+vkVDCF/jb3FYcGABGJLYS75qxGG1hlGL7MOBjlTSPlVY
	Sa7OXpIqCJZez6flLkdB27VNQA2sCKz5JT+t0m+z550ZeWG5LBeFmh84Gbiewjzq/NVDUfQLm60
	LdsNaBVZc40FvBh3ZefH5LBLxdg==
X-Google-Smtp-Source: AGHT+IFcXLX+kvOqT2wFnw1+ymXM2RCkqARP0iez8K/CuS6OcnyEGO/v4tJGIFKipqmPugj8auqSb13TYf9e2F5nJRc=
X-Received: by 2002:a05:6a21:328e:b0:1c4:6be3:f571 with SMTP id
 adf61e73a8af0-1c4a13a375fmr17120024637.39.1722432868814; Wed, 31 Jul 2024
 06:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
In-Reply-To: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 31 Jul 2024 21:34:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8ThuusfHk9Gd5pFP8VhJkG2seuJmkFiruK1rPQFZGBzg@mail.gmail.com>
Message-ID: <CAAOTY_8ThuusfHk9Gd5pFP8VhJkG2seuJmkFiruK1rPQFZGBzg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Support alpha blending in MTK display driver
To: shawn.sung@mediatek.com
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Shawn:

Hsiao Chien Sung via B4 Relay
<devnull+shawn.sung.mediatek.com@kernel.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=
=8817=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=881:24=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Support "Pre-multiplied" and "None" blend mode on MediaTek's chips by
> adding correct blend mode property when the planes init.
> Before this patch, only the "Coverage" mode (default) is supported.

For the whole series, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.=
com>
> ---
> Changes in v4:
> - Add more information to the commit message
> - Link to v3: https://lore.kernel.org/r/20240710-alpha-blending-v3-0-289c=
187f9c6f@mediatek.com
>
> Changes in v3:
> - Remove the Change-Id
> - Link to v2: https://lore.kernel.org/r/20240710-alpha-blending-v2-0-d4b5=
05e6980a@mediatek.com
>
> Changes in v2:
> - Remove unnecessary codes
> - Add more information to the commit message
> - Link to v1: https://lore.kernel.org/r/20240620-blend-v1-0-72670072ca20@=
mediatek.com
>
> ---
> Hsiao Chien Sung (5):
>       drm/mediatek: Support "None" blending in OVL
>       drm/mediatek: Support "None" blending in Mixer
>       drm/mediatek: Support "Pre-multiplied" blending in OVL
>       drm/mediatek: Support "Pre-multiplied" blending in Mixer
>       drm/mediatek: Support alpha blending in display driver
>
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 36 +++++++++++++++++++++++++--=
------
>  drivers/gpu/drm/mediatek/mtk_ethdr.c    | 13 +++++++++---
>  drivers/gpu/drm/mediatek/mtk_plane.c    | 11 ++++++++++
>  3 files changed, 49 insertions(+), 11 deletions(-)
> ---
> base-commit: 8ad49a92cff4bab13eb2f2725243f5f31eff3f3b
> change-id: 20240710-alpha-blending-067295570863
>
> Best regards,
> --
> Hsiao Chien Sung <shawn.sung@mediatek.com>
>
>

