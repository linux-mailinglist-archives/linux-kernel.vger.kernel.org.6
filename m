Return-Path: <linux-kernel+bounces-376280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688A69AA299
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974641C21EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518019DF49;
	Tue, 22 Oct 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0KH7pKV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1219B3C5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601959; cv=none; b=sLHbFPQ+4beuFNSty5qcnXvSdSllRgQsg8FhHwuIsFjd0bXu2zu9bxpU7P1mgwFMgABXtdIaKp9DzduxpNk6N9nk/qnx78EI1nHaHjKlXjdWPZYkfA9MW8217PfCNb9qt5xuyuNqG/H+AFEAyWbbMPzJrRopIXnemzW3e7PE0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601959; c=relaxed/simple;
	bh=mIEKpBgOrB0FNODaNUzKqQ4blGh+DPNU0es/6NTXQLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TH0W5R9gTGJcIhC3HDZ0YIE8eOAFndCnYJIl1cq95+XiqFKm21JtDOpifMHG7fDhohBGErcA+QdP6ZpciqiCnHqOEYzIc0GnUr9jSyq4OFmE72poMf4y8FAx+uzXuDHNENY3QVoHnVkBMNzMDvKf3HRZdU3/rxPlZ4bZSyXzzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0KH7pKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD578C4CEC7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729601958;
	bh=mIEKpBgOrB0FNODaNUzKqQ4blGh+DPNU0es/6NTXQLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g0KH7pKVFnhonU17674bEHRs9l7LlGqSm1Ln5m8iXpgdRvVrASryiRXz+ohffG8Xz
	 aykteqM2Tjx2SzSA9Ci7YyRzPFudv6SpkFqHC1Mf3XAl0u4NlhmXmQJonSqem3mZoW
	 liALVr9NrZJmqqvjhdnMz67/aKAlKEiMT2E29iqqPHWxm4f50rFHHwyi/8lmIOI4l8
	 l04/s5suLYZ7hLfCTtUOvAm0GTKVM9kiXZuZvPDuZLRPK0NYkEPHXQskY7bCHa/3/W
	 z0p7ug7VylR+HPNs4P/soUSo0SVcm0XnB4zTG2nh3QaxW9UIjWGiNpuN4Bf9nBNYix
	 xfv4mw9S3me7Q==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso4109000a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:59:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUe1H4mbULxIYUsZOiO6LSL5pOyJalCV4SeRjunGnGSSpmjrLgRJPRzalGGvRF1ETR1QhDdnIpFk3NCyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ3+8lKyNSGRujcJL3Vbns4XLp81lO4m50819QhHwVtV6rg8KE
	tvEeX5yybx2NDOC5y5PrRy3BOTy9kXZakWDtLwfumXaYQdFWWxD/tOdcGaqw36yGNHuWG0sTp8N
	VcWrKlhTGCbMiDw4nvpEpPJWc5Q==
X-Google-Smtp-Source: AGHT+IEz/fNKcgr+pPCPCQ70QsyRbpxSrHWljw6enWHdqVQbK33wZ/ouEzLGpZFmchdgpySyLi47Yl8GmCTU0qpkJZM=
X-Received: by 2002:a17:90a:a615:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2e5616c4300mr17536808a91.1.1729601957323; Tue, 22 Oct 2024
 05:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-color-v3-1-e0f5f44a72d8@chromium.org>
In-Reply-To: <20241016-color-v3-1-e0f5f44a72d8@chromium.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Tue, 22 Oct 2024 20:59:38 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9O9BPz0jhd4xM=vMmKZyhYdyOMi2mVhU41Ch2y9pmibg@mail.gmail.com>
Message-ID: <CAAOTY_9O9BPz0jhd4xM=vMmKZyhYdyOMi2mVhU41Ch2y9pmibg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/mediatek: Fix color format MACROs in OVL
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hsin-te:

Hsin-Te Yuan <yuanhsinte@chromium.org> =E6=96=BC 2024=E5=B9=B410=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:17=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> In commit 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in
> OVL"), some new color formats are defined in the MACROs to make the
> switch statement more concise. That commit was intended to be a no-op
> cleanup. However, there are typos in these formats MACROs, which cause
> the return value to be incorrect. Fix the typos to ensure the return
> value remains unchanged.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v3:
> - Add missing Reviewed-by tag
> - Link to v2: https://lore.kernel.org/r/20241016-color-v2-1-46db5c78a54f@=
chromium.org
>
> Changes in v2:
> - Clarify that the commit get fixed was intended to be a no-op cleanup
> - Fix the typo in tag
> - Link to v1: https://lore.kernel.org/r/20241015-color-v1-1-35b01fa0a826@=
chromium.org
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 89b439dcf3a6af9f5799487fdc0f128a9b5cbe4a..1632ac5c23d87e1cdc41013a9=
cf7864728dcb63b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -65,8 +65,8 @@
>  #define OVL_CON_CLRFMT_RGB     (1 << 12)
>  #define OVL_CON_CLRFMT_ARGB8888        (2 << 12)
>  #define OVL_CON_CLRFMT_RGBA8888        (3 << 12)
> -#define OVL_CON_CLRFMT_ABGR8888        (OVL_CON_CLRFMT_RGBA8888 | OVL_CO=
N_BYTE_SWAP)
> -#define OVL_CON_CLRFMT_BGRA8888        (OVL_CON_CLRFMT_ARGB8888 | OVL_CO=
N_BYTE_SWAP)
> +#define OVL_CON_CLRFMT_ABGR8888        (OVL_CON_CLRFMT_ARGB8888 | OVL_CO=
N_BYTE_SWAP)
> +#define OVL_CON_CLRFMT_BGRA8888        (OVL_CON_CLRFMT_RGBA8888 | OVL_CO=
N_BYTE_SWAP)
>  #define OVL_CON_CLRFMT_UYVY    (4 << 12)
>  #define OVL_CON_CLRFMT_YUYV    (5 << 12)
>  #define OVL_CON_MTX_YUV_TO_RGB (6 << 16)
>
> ---
> base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
> change-id: 20241015-color-e205e75b64aa
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>

