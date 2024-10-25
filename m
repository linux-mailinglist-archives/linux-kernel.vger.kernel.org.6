Return-Path: <linux-kernel+bounces-381185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DA49AFBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E093B2115C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75411C0DF0;
	Fri, 25 Oct 2024 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1fOE+Hpq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0841B6CFE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843059; cv=none; b=cuPVqa7Ls6L4HQDR+O89HNNKoJpoFpQlQdP4ParbzpanskO0XIZl5zM8rtbRhrGObw83WDEUaIeqCAmjoEAniC/ySOBu7g8Fy8N3OnW9ygb9yQubEIt1N9y+kYH6ea7o+DpajbStpzTx7yQegY/uWFBzuAFlS8lH4UGTveOCvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843059; c=relaxed/simple;
	bh=GUWVH2uka6Ld8tCz6VApcxZXAPIqIZt0tZL1jnDrQdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DL2zVdYnjmIZBJrORz3MTPzy9sUSqF9JzjBZSfGRlefV1byqm/Ztk+b35nMbTBb4Uz9x6B2fhhvZagFnt2pyp+3KD1a4Yu6obQ99tJ0QUL0eCZgIDob60sN7LiZscCrEA5kM3k2ob/o7Vq+KBwKPfFb497Ry0m3uthh3T6fKQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1fOE+Hpq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539983beb19so2240746e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729843055; x=1730447855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMR9mRKdj+7kyzA4vhiQt23W1ro+2aLzgQAgkPaGHvo=;
        b=1fOE+HpqWTSJs93V/tSdANSYrglX1QBr7zHBd4sR/rYtAibgoLOmMgz1+DM04ZlN+g
         ZF8EroAa7as8kaQ2t+hnHj1OC5osSmkUC30GNeeapxpXdXJ8QQsvf1y6dM9//QeSc/v2
         xnU0G8YciREuXgaFGHclkp2ABFoFSXQJIddUJHI763C+e0PMUDCbWom3FeE5TnzjIuO1
         Hti8HSqtC06JUPecBYJwCLYHrQV4cYky/yvczySIHL0GfkukZLa9aAATGzdgKHfu/MdD
         ab13Kc3ytDJvNhoXcXa2CaiJIfil4r5UoRYEzQopUqgE1/HpgfmPDneuhM3sBg0S/4HS
         oqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843055; x=1730447855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMR9mRKdj+7kyzA4vhiQt23W1ro+2aLzgQAgkPaGHvo=;
        b=pZvnNcWvYr1BoCoKdcHH/5AsAFag7vF3D+F6uk7JdCtsWtcqTZGjeWhXyO1f+kGdgp
         wydhyEOpjxxwzcvAWLGHU1uvF/2syvsM+pIESbRnY83AeEk0aNo5JlliIFwiiWfM8Ty/
         lMGN/lxeRtlUus9rSOZf5Yxs6d30HzLhNod/Wt8jNsHY87Hgzal5s7KXwllC+GWQRrAB
         PNtvGm96A6Sy7IF7zsd4S37HOOiPhZkseoZnASx4o+he1qqYUqWfBSg/0A4XKuCfdmqG
         MhrlCHtWzF6/Cw33nfC9pCMZ0VaNoFIJHeUsg+8bEgLH66TtFzaOqfDEIiE8GbGY2joz
         527Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqMTNdRPVXUgoASNflG+0YhMHI+SvDhVkN0jUyRGSIUoDYCc35qXzMWGCxQRuKYdkwMiGvGEPP4IFlVVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3ZRwolwfHeNxdGuyTqQTrS/1GUcELRPiIthqDia2g0xaWdCn
	p/EY9a4u7GW5DTd4DiiFLF4Itn+WrzliuWA3rDGqA6iM+na6EI7NG+aqXm20ViRjb3Oer7/4ASg
	UY+10zDT0b8sgK0Tnu58ADqsodGYjYoObkn7EDw==
X-Google-Smtp-Source: AGHT+IG81yduQs+Bl3t/NFGz2vsyEiOruGsX6ejobqqT+9o7J2c4ElDzuZkjCn3QbP2hahDTUHVemSq8Xd5QxoUYmdw=
X-Received: by 2002:a05:6512:2354:b0:539:f12f:2531 with SMTP id
 2adb3069b0e04-53b1a37ca2bmr5293218e87.50.1729843055382; Fri, 25 Oct 2024
 00:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org> <20241025-pci-pwrctl-rework-v2-1-568756156cbe@linaro.org>
In-Reply-To: <20241025-pci-pwrctl-rework-v2-1-568756156cbe@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Oct 2024 09:57:23 +0200
Message-ID: <CAMRc=MeWQLGDcjNpdnwAdXr0k3ME_g65dFXyd78bzK-tPrEW_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] PCI/pwrctl: Use of_platform_device_create() to
 create pwrctl devices
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:55=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> of_platform_populate() API creates platform devices by descending through
> the children of the parent node. But it provides no control over the chil=
d
> nodes, which makes it difficult to add checks for the child nodes in the
> future. So use of_platform_device_create() API together with
> for_each_child_of_node_scoped() so that it is possible to add checks for
> each node before creating the platform device.
>
> Tested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/bus.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 55c853686051..9d278d3a19ff 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -13,6 +13,7 @@
>  #include <linux/ioport.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>
> @@ -329,6 +330,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pd=
ev) { }
>  void pci_bus_add_device(struct pci_dev *dev)
>  {
>         struct device_node *dn =3D dev->dev.of_node;
> +       struct platform_device *pdev;
>         int retval;
>
>         /*
> @@ -351,11 +353,11 @@ void pci_bus_add_device(struct pci_dev *dev)
>         pci_dev_assign_added(dev, true);
>
>         if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
> -               retval =3D of_platform_populate(dev_of_node(&dev->dev), N=
ULL, NULL,
> -                                             &dev->dev);
> -               if (retval)
> -                       pci_err(dev, "failed to populate child OF nodes (=
%d)\n",
> -                               retval);
> +               for_each_available_child_of_node_scoped(dn, child) {
> +                       pdev =3D of_platform_device_create(child, NULL, &=
dev->dev);
> +                       if (!pdev)
> +                               pci_err(dev, "failed to create OF node: %=
s\n", child->name);
> +               }
>         }
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_add_device);
>
> --
> 2.25.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

