Return-Path: <linux-kernel+bounces-313586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AF096A747
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E321C212B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2A18FDCD;
	Tue,  3 Sep 2024 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOnGooX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E531D5CF4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391240; cv=none; b=KpAnxK1eoXA9jtU+6rjm/HY9LX16XxYsktP81jYTRrZS+LElEGpFoOO0ux7LXH1hJgzQU6+yYqP5Fi1HsrkMrGAwOSSDKTjmKqvNOgoTie2lRdiEx/AY0/uj4YGW/Plr/IbNj/9m/4KLLYg/aLTC8rzKueB5a0l4QK5N0gJFPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391240; c=relaxed/simple;
	bh=X6XtPCWO0ok2gFlBZfY7nQ1xeBg83zqwM9z4A9P8jZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMdRzQwYbli7q02lI690z6pKsY8hD5m3SP7KBRFulVUIHm/dhqIE4IErXRCMIxGfKsKwh+ulnrcMomvnQOjEMPUEXZ+k2V0YG25MYR9giR4gh8ru2Xba/ZewdB1OuJQ9JatngDKoH+aeOj/RpApH7DN2zBo7FwnT8ONpBtYB/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOnGooX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF62C4AF0D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391240;
	bh=X6XtPCWO0ok2gFlBZfY7nQ1xeBg83zqwM9z4A9P8jZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AOnGooX/hpJZjbVzqHnwllgMy+gI/SL/fhdMnrw9mpQNnfQ76dfEhLf+fXXH8R7Ew
	 1+kYy/9FYTzduExSN5oDvD42+nljUqglPO1DUsxEo2TtNVfoMa/rZR+pdwqS19/Z3o
	 tKXol1B2rEWG7I1kqpWDbz912A9/ekGGN4TaBtngcfQN2pCklhBC41cDFCdTjM9rhJ
	 zQy0NkzHVuuVWnRWv0AAjetWvxZjhvgrHLSzmyiXLzgT4ocz1Z+oxT99stqjKXihHd
	 10aISAjLJ9i5EtNrfvbuZTV8zYjqpm3n4NhvWvsporFTJQklai00YeVXOHHG//7iWP
	 ZVHVvmo7j6zbg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53436e04447so5884463e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:20:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5dQMYWowMq12RZ0SB6lSc417vV7bHbaHmx2A5lXgIqx5sKEVnnLY/WB3loOOPRn0RMZnPc3T7uZNepmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5E9TRXVfT28wa1VZMFxMUXJGonBZfz5IsaNisq92wPD+D7HNA
	1sfbXTlhJ+DeTy7cO2aoeGHOR9qAdgTtgkycyQ5QM59R8D5kxl1hMQOjfviWi3tirCfqFKkGAx6
	0bZOi7HLH6f1uJEyywTsN0xfeVw==
X-Google-Smtp-Source: AGHT+IEO8+TpEsd33CZ0Mf74xjT6tw/Gkb3NEipRAAblad7qK2mRr99zUAAn51a3sx4CzGhjSLA2yF6P2Ebn+PUSWGc=
X-Received: by 2002:ac2:4e09:0:b0:52f:c281:72de with SMTP id
 2adb3069b0e04-53546306584mr4621799e87.15.1725391238537; Tue, 03 Sep 2024
 12:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-6-robh@kernel.org>
In-Reply-To: <20240731191312.1710417-6-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Sep 2024 14:20:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJt4FUTwMggsPOxC7vPoajN_yAdH+C0JH-OKQ7CiE=9kA@mail.gmail.com>
Message-ID: <CAL_JsqJt4FUTwMggsPOxC7vPoajN_yAdH+C0JH-OKQ7CiE=9kA@mail.gmail.com>
Subject: Re: [PATCH] iommu: Use of_property_present()
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:13=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> Use of_property_present() to test for property presence rather than
> of_(find|get)_property(). This is part of a larger effort to remove
> callers of of_find_property() and similar functions. of_find_property()
> leaks the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 4 +---
>  drivers/iommu/of_iommu.c        | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)

Ping!

>
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_dom=
ain.c
> index e9d2bff4659b..30be786bff11 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -416,14 +416,12 @@ static struct iommu_group *fsl_pamu_device_group(st=
ruct device *dev)
>
>  static struct iommu_device *fsl_pamu_probe_device(struct device *dev)
>  {
> -       int len;
> -
>         /*
>          * uboot must fill the fsl,liodn for platform devices to be suppo=
rted by
>          * the iommu.
>          */
>         if (!dev_is_pci(dev) &&
> -           !of_get_property(dev->of_node, "fsl,liodn", &len))
> +           !of_property_present(dev->of_node, "fsl,liodn"))
>                 return ERR_PTR(-ENODEV);
>
>         return &pamu_iommu;
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 78d61da75257..e7a6a1611d19 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -214,7 +214,7 @@ void of_iommu_get_resv_regions(struct device *dev, st=
ruct list_head *list)
>                  * that represent reservations in the IOVA space, which a=
re regions that should
>                  * not be mapped.
>                  */
> -               if (of_find_property(it.node, "reg", NULL)) {
> +               if (of_property_present(it.node, "reg")) {
>                         err =3D of_address_to_resource(it.node, 0, &phys)=
;
>                         if (err < 0) {
>                                 dev_err(dev, "failed to parse memory regi=
on %pOF: %d\n",
> --
> 2.43.0
>

