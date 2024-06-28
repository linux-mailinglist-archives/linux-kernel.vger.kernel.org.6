Return-Path: <linux-kernel+bounces-233912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6D291BF35
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6513028467B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602651B3F35;
	Fri, 28 Jun 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLntOJis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FDD158A32
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719580113; cv=none; b=QLTblHo8yvve7NkZ7zW146wd6obiH+qPb0J2jHgpeXOVOrPO4d5Vs21K6ei8G35XQWhRNtge8Heq05PDqFWq0cnW8hpobUsWL5ZcT2e/sjxCsZLLpz1UwzseKT7ff61NDhH6g0ZE44ReimeZo1oQpldPzC3pYj0+Bpv0gQymVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719580113; c=relaxed/simple;
	bh=JIVz5FNKvOgvnmUGw6kEzut1ksjPBzPXDnVwiaNYL9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeiBvyLj/w2u8LubaaV1ZjrCkV+/nfEROEmO30LqB4+4OevCAZAG1WdYReTo3fPaan6IvRm2glogONXjhuCdAM33IKNCkrqrB+x18kqZLZwNuAHnChvk+36Jp80gHfk9hZWAsNO70LK2sUS3lk59ws4hNBfvH0Zyp/FGsMRciB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLntOJis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDC6C2BBFC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719580113;
	bh=JIVz5FNKvOgvnmUGw6kEzut1ksjPBzPXDnVwiaNYL9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eLntOJis4L1ZOaIqToYV1m5g0zhnqfwnQb9LMmqz3N1a35Md98Ko+laaC7A2lM+LF
	 GvWtzk8GLmNHiJNaHQn7WzFB6/1kqAF3LpQ8HaH7zQxLFOJ5YqCwgFv6Zbu5MCHN6T
	 EWe8NaXmkRa9xVEZB56BXNZlVlug54g48v9B6RTB9Gi9SLC6eOQweFtRYzh+3s/Z/x
	 N8pAwNLTlPubOlZ3L2rHYATOLEmliZ+Z+W6kFeksM8LCxyrflfOY9lbkrfKwI/zY9G
	 g9DUsRuHMJvO2suzqlfcCHgwjPbwK0G5+HpwiLFEgRR/LXIdO0IDf3IPvYDKIjDuUS
	 u0TC7+rWqsu0Q==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c80637ee79so446037a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 06:08:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW96ijR9tKLkd0GrtWn4lLc873Azu/86ccci6lVKrHYuiSCZRT2lr4L5WEeJ8FtLS79EcTIyrNnJ4u6gEMdnP9LaH07QRQNG9tMCFJy
X-Gm-Message-State: AOJu0YxZpEi+aND29+Ag0n2q21YNb4ojEUXYjuWwlxd6x9l6m7QYg90U
	1f0ny7yW0H4Ytap57NJS8fqaGFpJQ6toFzBX7uHdDkbUtAUZnP1q1+X6Zs7yMmClPS1tJzxGKf7
	RXYfg3LGwrS08GDWhkXrzfhKaLg==
X-Google-Smtp-Source: AGHT+IF5mMCy7YrbrupOvlCOrOkU+rRYXca41m4MwdvomMcM+qWWY7QocDzkEcdXjTasG6C59jUoX3JcCm/MleU2EcU=
X-Received: by 2002:a17:90a:8c08:b0:2c8:e280:381f with SMTP id
 98e67ed59e1d1-2c8e2803890mr5364325a91.29.1719580112763; Fri, 28 Jun 2024
 06:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604083337.1879188-1-mwalle@kernel.org>
In-Reply-To: <20240604083337.1879188-1-mwalle@kernel.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Fri, 28 Jun 2024 21:08:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8mviPhxsqtUcsB4xjU02VEq02-04cNq6fJYsTndJVfvQ@mail.gmail.com>
Message-ID: <CAAOTY_8mviPhxsqtUcsB4xjU02VEq02-04cNq6fJYsTndJVfvQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/mediatek/dp: fix spurious kfree()
To: Michael Walle <mwalle@kernel.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jani Nikula <jani.nikula@intel.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Michael:

Michael Walle <mwalle@kernel.org> =E6=96=BC 2024=E5=B9=B46=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:33=E5=AF=AB=E9=81=93=EF=BC=9A
>
> drm_edid_to_sad() might return an error or just zero. If that is the
> case, we must not free the SADs because there was no allocation in
> the first place.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

>
> Fixes: dab12fa8d2bd ("drm/mediatek/dp: fix memory leak on ->get_edid call=
back audio detection")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 536366956447..ada12927bbac 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -2073,9 +2073,15 @@ static const struct drm_edid *mtk_dp_edid_read(str=
uct drm_bridge *bridge,
>                  */
>                 const struct edid *edid =3D drm_edid_raw(drm_edid);
>                 struct cea_sad *sads;
> +               int ret;
>
> -               audio_caps->sad_count =3D drm_edid_to_sad(edid, &sads);
> -               kfree(sads);
> +               ret =3D drm_edid_to_sad(edid, &sads);
> +               /* Ignore any errors */
> +               if (ret < 0)
> +                       ret =3D 0;
> +               if (ret)
> +                       kfree(sads);
> +               audio_caps->sad_count =3D ret;
>
>                 /*
>                  * FIXME: This should use connector->display_info.has_aud=
io from
> --
> 2.39.2
>

