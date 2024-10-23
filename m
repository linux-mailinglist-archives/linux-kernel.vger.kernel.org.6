Return-Path: <linux-kernel+bounces-377862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F41C9AC7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D0A286F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA641AC43A;
	Wed, 23 Oct 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1Jlkg4U"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C01ABED9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678983; cv=none; b=i0EXxyo8/VDH3aN5vu0YYLd8epwAQgppo0EmA+CsW0IEHPomE8bqATnkj2c+AE4tgzSGG8shDj8Du41VkHO9H+Q1IdGR0EEEqV7ux9WGPeEkBqaeBXV/Qk76J6V0KS7kR5F2PVKpkTRsFRPQciPQ2rIXXtGwIcuOBTd+ZgsW5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678983; c=relaxed/simple;
	bh=4FLQu9BGwr70jNARbEZ6AXOyAf/HYGRBedvzNbHPKBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BooTvftQPZaujeu+IvVyDtIowIMH5QkBAf352q8rpTEXCyLrfjDDDxXStn+4c9H5zAGYk0H4B3gzhW+iOvytxEcUA3IlIWgkZB/h/3+R4BlyhvuJd6GWIBgtson7VCFgPmK4vjHxJZqbDE2A2dNREczEgZeeiMssi2cuGVKMWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1Jlkg4U; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2bdbdee559so3473820276.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729678981; x=1730283781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NM2XZc6ptcLAUeyk+hXfl1t1bLG33N5E/Q/VVFyS1FU=;
        b=p1Jlkg4UWRcGXUI6sISrNwF7TmruXcBphyC66Jd2TiTtAgFhSyQl28KzXW3mKPqUZE
         +guWdBFNhKYGLXg9NXtSrxBq6jjMnc9DHHS1CWGTTLMD+NncyP5sm/e0v40yP2H+lTjs
         6wI0SA7g/EVm3alsHZyXPzKuup1eb0zr1fmaXDp62qEb6u2ZgnUoe/UoTft5zdYmK01R
         GPcMpG7MtBEUkblKYVhaEgUKrGPmZ5SMMgD2O/5ZpPmjuWpiKqmmq54wu8SQboeU4UaN
         XvegWAt7eyFUwFzEnvzSW0dqKj08kspv9C2+ydDUpE5ysHcYUZNnitaKtEC5PQp9wg0W
         bDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678981; x=1730283781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NM2XZc6ptcLAUeyk+hXfl1t1bLG33N5E/Q/VVFyS1FU=;
        b=LRKgNnH1uLvN2L4egJv2CYexW5b5f3xQ1fYGJFxCtxFO7Kgo46zqrln37wY57g90a6
         KAPvxMOKJYZlpqtEaXUD8IqkLZBsz70CuQetQBWJyA1LLzPaP0Fv4g7szRICX0RagYZ3
         aijPzsazLsKfDSKkm0P051lBQR5mWRJak3ZuljrfdKDZ9HbOQk+cpfmAQZODwavM7U1l
         4zcctMeJN+io7HS1oaEyGBHdlYKEy8L3wZGvo2SnHm6Hx2/iAyBbAklva9/osGmfWW1I
         nRZgLwukLlPTB6xi0HZB7jgwlBssDOue3X9PDtQtPK8Ozb79uKsC6fEy7fhreytSmRNM
         7kUw==
X-Forwarded-Encrypted: i=1; AJvYcCU3iXqcoWT47EI5fs8gHeeVHMHXvvNO42F6Ybv5gsQ2tmkcmhdqEo3Umih8HrAHe1tx4AkwAmPBKheMKmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhaMFPcBrasT2ZJy3fIkK+vrcjU0DPdpPXhK8WdQH4Sj9N9GYP
	aIOm4tNlt0uHspgig4S+2tcGJrD+DkkLY4VLIhJZbZQqHO8ffg49dl1cbxzohj1x+J3VVDlxeN4
	vwBxCh81LlflhdIj1U15+tBtOGU4sB3ox2QwDnQ==
X-Google-Smtp-Source: AGHT+IGfLHM8mlIPD4ifH0wMhv5Mj4ci8eevlzwj0i84XjuUhGRuHL8t+6PKtfrvqGKxH99+z9AVzyJTC5H85T2XyHE=
X-Received: by 2002:a05:690c:470e:b0:6e5:e714:3bdf with SMTP id
 00721157ae682-6e7f0db3584mr16416967b3.5.1729678981138; Wed, 23 Oct 2024
 03:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org> <20241022-pci-pwrctl-rework-v1-3-94a7e90f58c5@linaro.org>
In-Reply-To: <20241022-pci-pwrctl-rework-v1-3-94a7e90f58c5@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 23 Oct 2024 12:22:50 +0200
Message-ID: <CACMJSes9a_LA6YZh+FyKteKoEgKfc4nYs+DTVUOHF3u03F6cug@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI/pwrctl: Ensure that the pwrctl drivers are probed
 before the PCI client drivers
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 12:28, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> As per the kernel device driver model, pwrctl device is the supplier for
> the PCI device. But the device link that enforces the supplier-consumer
> relationship is created inside the pwrctl driver currently. Due to this,
> the driver model doesn't prevent probing of the PCI client drivers before
> probing the corresponding pwrctl drivers. This may lead to a race condition
> if the PCI device was already powered on by the bootloader (before the
> pwrctl driver).
>
> If the bootloader did not power on the PCI device, this wouldn't create any
> problem as the pwrctl driver will be the one powering on the device, so the
> PCI client driver always gets probed afterward. But if the device was
> already powered on, then the device will be seen by the PCI core and the
> PCI client driver may get probed before its pwrctl driver. This creates a
> race condition as the pwrctl driver may change the device power state while
> the device is being accessed by the client driver.
>
> One such issue was already reported on the Qcom X13s platform with the
> WLAN device and fixed with a hack in the WCN pwrseq driver by the 'commit
> a9aaf1ff88a8 ("power: sequencing: request the WLAN enable GPIO as-is")'.
>
> But a cleaner way to fix the above mentioned race condition would be to
> ensure that the pwrctl drivers are always probed before the client drivers.
> This is achieved by creating the device link between pwrctl device and PCI
> device before device_attach() in pci_bus_add_device().
>
> Note that there is no need to explicitly remove the device link as that
> will be taken care by the driver core when the PCI device gets removed.
>
> Cc: stable+noautosel@kernel.org # Depends on power supply check
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/bus.c         | 26 +++++++++++++++++++-------
>  drivers/pci/pwrctl/core.c | 10 ----------
>  2 files changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 698ec98b9388..351af581904f 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -345,13 +345,6 @@ void pci_bus_add_device(struct pci_dev *dev)
>         pci_proc_attach_device(dev);
>         pci_bridge_d3_update(dev);
>
> -       dev->match_driver = !dn || of_device_is_available(dn);
> -       retval = device_attach(&dev->dev);
> -       if (retval < 0 && retval != -EPROBE_DEFER)
> -               pci_warn(dev, "device attach failed (%d)\n", retval);
> -
> -       pci_dev_assign_added(dev, true);
> -
>         if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
>                 for_each_child_of_node_scoped(dn, child) {
>                         /*
> @@ -370,6 +363,25 @@ void pci_bus_add_device(struct pci_dev *dev)
>                                 pci_err(dev, "failed to create OF node: %s\n", child->name);
>                 }
>         }
> +
> +       /*
> +        * Create a device link between the PCI device and pwrctl device (if
> +        * exists). This ensures that the pwrctl drivers are probed before the
> +        * PCI client drivers.
> +        */
> +       pdev = of_find_device_by_node(dn);
> +       if (pdev) {
> +               if (!device_link_add(&dev->dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> +                       pci_err(dev, "failed to add device link between %s and %s\n",
> +                               dev_name(&dev->dev), pdev->name);
> +       }
> +
> +       dev->match_driver = !dn || of_device_is_available(dn);
> +       retval = device_attach(&dev->dev);
> +       if (retval < 0 && retval != -EPROBE_DEFER)
> +               pci_warn(dev, "device attach failed (%d)\n", retval);
> +
> +       pci_dev_assign_added(dev, true);
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_add_device);
>
> diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
> index 01d913b60316..bb5a23712434 100644
> --- a/drivers/pci/pwrctl/core.c
> +++ b/drivers/pci/pwrctl/core.c
> @@ -33,16 +33,6 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
>                  */
>                 dev->of_node_reused = true;
>                 break;
> -       case BUS_NOTIFY_BOUND_DRIVER:
> -               pwrctl->link = device_link_add(dev, pwrctl->dev,
> -                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> -               if (!pwrctl->link)
> -                       dev_err(pwrctl->dev, "Failed to add device link\n");
> -               break;
> -       case BUS_NOTIFY_UNBOUND_DRIVER:
> -               if (pwrctl->link)
> -                       device_link_remove(dev, pwrctl->dev);
> -               break;
>         }
>
>         return NOTIFY_DONE;
>
> --
> 2.25.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

