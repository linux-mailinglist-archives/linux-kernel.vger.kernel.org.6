Return-Path: <linux-kernel+bounces-379241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CAE9ADBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC69283CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8668417A58C;
	Thu, 24 Oct 2024 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzXwnNNb"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1963176AA1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750629; cv=none; b=pYATr+nPpV1bq8TJgL4SRVHPudQFINXTtUGMC9w9pvYqYWvHx+TdtrWcbcRJPOy8vqGP+Z0gsC7rrudh9dj2ajGB0rB+bLDE3o+ujWuKD7yqcE7pLPqTfdT5Pv0gUex5nmf37eGQGVlTzr/ZJzLwtjgweA0cXPshqtkDyRbR7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750629; c=relaxed/simple;
	bh=beUOJwjq59gvjOg+j0hyEZL5iyRhWmXytQywp1xo9Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xx33Rk7/CfohI5h/3M8jzRHKK1wHrz1PTGfruRsT1/wIqB+Ix7ktg9wsQ43sM+DqBl/7InU/2qMjvzHLcyoG2dL4mhBpy+qC/uHd8c+aSFljk7R3asFfig0pGqv1iHZTUFhb7Us/arBfBMiyy+eV3KjqiX4REecfGcwCFDWCqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzXwnNNb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso364867b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729750625; x=1730355425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kDqeaAprBXUkM4Fq1Ym36ZhnawEXTDWt16M3cGZQYI=;
        b=IzXwnNNbyYwfHPTThI9keQNoqa8QunTpsUXmMewdCGxXs2SQR9WIZAN6pivUMv2KC/
         shlBnZx+AwEzUuQds2aDvEutsuj7kUu1Pw+4czYOSuf/XpWxdBnppN168cRVC6+FEVXy
         05AVveqo3luTH64PPSlNNGdeKBCsLOAlKi19T+4AocTI8i48j8gfcCUX82lDP44U64GG
         jKFY4g0RmtFQyMENfq/MNpaV/trEhj9uyMVf/lyPLoKqiKNNbrqjWCwaoh2lGFtLiT0y
         wNytoGJUtHggVnsh8E4m4UhmpLMFV1FYgGs5VVaJMs0UJkixNQI1UpzBuveVJ4drFIQi
         C0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750625; x=1730355425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kDqeaAprBXUkM4Fq1Ym36ZhnawEXTDWt16M3cGZQYI=;
        b=EYL0c/kn2Nu8advEKYc3bu17sKGQ5KlZcv8DKPE0M+4+ssj720xGY83VdJx1WeDLYl
         7jVyYcqw38Vk9AGRtgqdJHwaLt/ZaJT8Q0vEsFFqX9cCxXLth/ghLlvg+KYr0hkw1Kkb
         FuPcaXZDbZndw6fNVQZJHG0KknAZqa5wLSrDeDuun4UQvrTMAdQYwPE3rg7pZC8ie1q0
         T0Pz6yuS8WoQ4fj0K31EAq1EzXpH8TGQR5vIiMTYXk7lEUtvt/snE/D4VxLMfF7k2uqg
         tFTBTszilPPOgrmAvF5pX2FfxYhj5Z2OH7vn1jZN0l6R9DX3eYzXXVGWBEiVYFflPf03
         qN2g==
X-Forwarded-Encrypted: i=1; AJvYcCWdBRzxUNjjf4ng/ln01fpswlT3zlx0vSCRvbz2azII/If7Z1LnNecOGqk0skkRpBCHWzfQQW33SjzEn3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5AlEFVbrumQwSY0of9iWibMyAZ73NnbqYwlPhHzgfLxa6Wjq
	OTNa2vxiQ9qCLAq8cu3tXYuQkPdcC+aW1OCd9gZn7HQkeMPB5RsWWWxBGJm85BAvd/xGxI4mpY3
	nMMNG4JPpgn1nAyy6/cik3SWNeH113oRJl9K5
X-Google-Smtp-Source: AGHT+IFcCYtp7nVgkoJ5rzaztD8OtipNso126UyODrDbPTgNIyDaB+s9edBYS51aMEHDl37/TiPH24OOcDTayFV74a4=
X-Received: by 2002:a05:6a20:5da3:b0:1d9:83cc:ef90 with SMTP id
 adf61e73a8af0-1d983ccefdamr1940597637.8.1729750624651; Wed, 23 Oct 2024
 23:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024061347.1771063-1-saravanak@google.com> <20241024061347.1771063-4-saravanak@google.com>
In-Reply-To: <20241024061347.1771063-4-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 23 Oct 2024 23:16:26 -0700
Message-ID: <CAGETcx_0gqbo5Xf9mZGrBZszZsmKBdqRreb-=O_PvOR_2Yc5Cw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drivers: core: fw_devlink: Make the error message a
 bit more useful
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greg,

Can you fix up the commit subject prefix to "driver core: fw_devlink:"
please? Don't want to send v2 just for that.

-Saravana

On Wed, Oct 23, 2024 at 11:14=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> It would make it easier to debugs issues similar to the ones
> reported[1][2] recently where some devices didn't have the fwnode set.
>
> [1] - https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@no=
tapiano/
> [2] - https://lore.kernel.org/all/20240910130019.35081-1-jonathanh@nvidia=
.com/
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a4c853411a6b..3b13fed1c3e3 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2181,8 +2181,8 @@ static int fw_devlink_create_devlink(struct device =
*con,
>                 }
>
>                 if (con !=3D sup_dev && !device_link_add(con, sup_dev, fl=
ags)) {
> -                       dev_err(con, "Failed to create device link (0x%x)=
 with %s\n",
> -                               flags, dev_name(sup_dev));
> +                       dev_err(con, "Failed to create device link (0x%x)=
 with supplier %s for %pfwf\n",
> +                               flags, dev_name(sup_dev), link->consumer)=
;
>                         ret =3D -EINVAL;
>                 }
>
> --
> 2.47.0.105.g07ac214952-goog
>

