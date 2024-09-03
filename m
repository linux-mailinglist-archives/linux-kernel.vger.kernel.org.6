Return-Path: <linux-kernel+bounces-313578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CCE96A734
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC369B21BA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82BF1D5CF8;
	Tue,  3 Sep 2024 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9pBbSqA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621D1D5CF4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391068; cv=none; b=Z2P7f3XGGpGu8ReynD3tYmwtGQh/MiMcLwX/NSn7xzRgwmN5WVQk/JaWfgmy3LAYGX7J6Y1ZvmYpyYE0p4GytKRV5+LHN6XGNq3Yfb3TAAbz5nJSBMQot1vkuaOfMTMqaGDv1vKwHugNZGkv0V39zhgvQLXncDSM55OQ7ZCAt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391068; c=relaxed/simple;
	bh=kNDVDagqIyJUR6yMgqE36mAL/l1EP0M2wYM/1b1fUJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYqocoS8CPuhtfAPqr75maCH8gzhwwzRqtKitYxcNr/0LPzCOo7bzO3EIpZIsj0TpVOL9KNVqNCVZy0JjhwNtXSc+kQ6XYxLywicwVXt355vBilNCu0xT34JSa8s/rB2bgXz44yYM63pX/11GdqcGwW1BDELB0JjBQO/ODBrBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9pBbSqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06E8C4CECA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391067;
	bh=kNDVDagqIyJUR6yMgqE36mAL/l1EP0M2wYM/1b1fUJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y9pBbSqAibAVIh1oK7X9JNVFyEY7O6kfYv3UavhNHnH+eW40N7YSHsstve2hwYNbO
	 dbMgWf0e9MCJg/IytwHRfInIvlXdjlweqOqkfzd2RTm5hEAe4DGB1ErO64UIQxDzho
	 1ewtDojyQtSzBO0MAc2f3IYo9dNFXWkagXiVaLgguqWfqOUwSaTBB76fAE6vcor5ll
	 pHsnHpoP0n0rWbJ3yH63MCTj1d+i1XMqaQKljhufcoHhn6Hc9ojj1/+xmhd885ETHy
	 HrRdhe7EX2dClhsV/hDFGB9S9w+fS0VuuGQyHfWZkxXAM8K1bZKpbL2xwygurbIy/A
	 P9kh7cmD3II1Q==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f4f5dbd93bso54851941fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:17:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXA169DNXWFzht+V+X7EUFP5xngemmcEY6WYu6ZhMv7sTaV2hx0lWEdZWTCEU/jvPKqx5OkUel28e0RgOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzihB+kEeoh1hP9tGslgqPIBzFTk1QmcV/A/E6Y4ywwfyiV7WBH
	zMjdD7mzux+Q+/Zi7nY30Lc4yBWoTkRq2zuq3gA4a6siHNMh2g4EeO14SMRiZ98bALrJ2Lte7Ed
	A2fSB/APTkmUDz/MZ+UOvlu8g1w==
X-Google-Smtp-Source: AGHT+IGmrptwa9msLQUlQ1DEWIkWxsXnOS/2hU5mBSL42INWPkCCj9BFmS8VKk8qPYlR1d8v1BAIAPmETQG3Ch6X1Jo=
X-Received: by 2002:a2e:a7c1:0:b0:2ef:2ef5:ae98 with SMTP id
 38308e7fff4ca-2f651e11020mr772341fa.34.1725391066018; Tue, 03 Sep 2024
 12:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-26-robh@kernel.org>
In-Reply-To: <20240731191312.1710417-26-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Sep 2024 14:17:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKC5S_-vJjdYEsoFHAQiQvymVDE4_moy5g_p7YEfAmDLA@mail.gmail.com>
Message-ID: <CAL_JsqKC5S_-vJjdYEsoFHAQiQvymVDE4_moy5g_p7YEfAmDLA@mail.gmail.com>
Subject: Re: [PATCH] nvdimm: Use of_property_present() and of_property_read_bool()
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:14=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> Use of_property_present() and of_property_read_bool() to test
> property presence and read boolean properties rather than
> of_(find|get)_property(). This is part of a larger effort to remove
> callers of of_find_property() and similar functions.
> of_(find|get)_property() leak the DT struct property and data pointers
> which is a problem for dynamically allocated nodes which may be freed.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/nvdimm/of_pmem.c | 2 +-
>  drivers/nvmem/layouts.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Ping

> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 403384f25ce3..b4a1cf70e8b7 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -47,7 +47,7 @@ static int of_pmem_region_probe(struct platform_device =
*pdev)
>         }
>         platform_set_drvdata(pdev, priv);
>
> -       is_volatile =3D !!of_find_property(np, "volatile", NULL);
> +       is_volatile =3D of_property_read_bool(np, "volatile");
>         dev_dbg(&pdev->dev, "Registering %s regions from %pOF\n",
>                         is_volatile ? "volatile" : "non-volatile",  np);
>
> diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
> index 77a4119efea8..65d39e19f6ec 100644
> --- a/drivers/nvmem/layouts.c
> +++ b/drivers/nvmem/layouts.c
> @@ -123,7 +123,7 @@ static int nvmem_layout_bus_populate(struct nvmem_dev=
ice *nvmem,
>         int ret;
>
>         /* Make sure it has a compatible property */
> -       if (!of_get_property(layout_dn, "compatible", NULL)) {
> +       if (!of_property_present(layout_dn, "compatible")) {
>                 pr_debug("%s() - skipping %pOF, no compatible prop\n",
>                          __func__, layout_dn);
>                 return 0;
> --
> 2.43.0
>

