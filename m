Return-Path: <linux-kernel+bounces-377865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B8E9AC7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337291C22785
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79531A0AF0;
	Wed, 23 Oct 2024 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iS3PYSVV"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8EF1A0AE1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679051; cv=none; b=MHvtBHEy/ga47fK4ClAEVWybALAL/O46cijXqGLAy0YfcZ3tXvAaChBjG9FbOLazJV/o14p2ag9cHDsE60FdynVL3YPpdj3zkZ9OX133L0pKJuR9wL/GOu0yXhSHvmWUCLpGBWKPWsOTB/yIaH4h6q7Bvfc2ID/W33ZtiM3deU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679051; c=relaxed/simple;
	bh=TjiTlPfISM8VKrOVCsz48i125V/FB1aOlc1HLJaHSYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYIWRQGPPgYGEkyZk1i684HO5SgRWqPXpNJnn/WS7CeXXS9xl0UwGZbrFmwv214bwwxzIgZPjDK0afuzkcSZYlKb+ME5jyToIFbiJ04cKj2wju6sbhGfO/00IxNyj4Gdg5jBMsbmoGsYbgeAuXFEdf0d2HzMHjorfwv81KVDLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iS3PYSVV; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e290200a560so6341773276.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729679049; x=1730283849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FeEmQ2K237udnXqKdoHb2MCk0omcaTpa4VHynOY1FGI=;
        b=iS3PYSVVjEq+6Lfj4FVbc318Bu55t0+DTdYLyqmukVxRsrIjUfDRds7TciidGnr+Ss
         2t5DqtVTpEN9Y4JXxTKFTrQdI6ocMrx7PORHNBmdCukzMl5Fk7KIQp28ggbaK9fHHLbw
         Y1SUkxiACSJH7Vvo7cL0qaBD0bMEXZehZoJrE0lDKs53F9kblscNcVaVdqJ221h7SQIX
         ClGG3RgU/GJluqmhXZhZ6J7LV+0JFTgw1gBOAeVe0QAlERqAXZRaakV9yLXPkwJIfXxK
         nIsi/r2D52VJzpsM7de8HJaK+5uRavXnaD5VXYY9aLzogp5UNLsX0pPt7sBP8Fthmgp1
         WlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679049; x=1730283849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeEmQ2K237udnXqKdoHb2MCk0omcaTpa4VHynOY1FGI=;
        b=FQcKJW4vcCpjW6zaOOO7zqllc0Dvxob3Fq5aNeEiJJjxNlszzggwLMy5RpDEYrrK7P
         vwVGqjg5y7nlrJ4yrPDjCzL/WN0nMjirQ6NZceSzy3KlHjJjGvFDjywymvBpLEsQgXY4
         JNB6mKwHdgPQYOmT8yWCgnP8fcuTk+T9r6SaPHFS69YpXSEjucro1YacVwV8f50DciK4
         mJK2pGeDFfPV582zkx2Odk6g0fnbYkCwOrO2BlaZnbnd4HgtgrDWZ+YmXxI+CJbN0IA2
         GLFqWDpNr1opcBOGIdyIiR2J/BfheapGdzcRwN1ISOPq7vA3S1CpVuIGK/r878dGJTPK
         6YQg==
X-Forwarded-Encrypted: i=1; AJvYcCVsBAezVNDbd8+moJJKuoPGDv6suStUb2v/K2T2GXBR/gXCdpC4yOmHlDaL6LJaD3R7Nx+SFPu09pa32DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPitwwYX6gjClcgQhWKD6ZNoL7XSfopiB5nOVhvFSXSvWD5fIn
	ttibT7RlxSAABdkkTZ0OadDl+U0KU3K3DdBnQ7itDKDtY9lHiUe4G5iyLIXJzKvmqOaoGVWMiq8
	PBG1nyrq+j2cnRiQCCZY1bWq3hGQJezB4u1BDKQ==
X-Google-Smtp-Source: AGHT+IGhf1yC7pWbHzT6DujoVjgz3E+axOwFuFJCrQlg4LOtDNk5n/BtaR/BP1bo3yfChmnpq/mlL6wIWTKz/UjJuvY=
X-Received: by 2002:a05:690c:907:b0:6e3:153a:ff62 with SMTP id
 00721157ae682-6e7f0e7eb36mr21717207b3.23.1729679048670; Wed, 23 Oct 2024
 03:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org> <20241022-pci-pwrctl-rework-v1-4-94a7e90f58c5@linaro.org>
In-Reply-To: <20241022-pci-pwrctl-rework-v1-4-94a7e90f58c5@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 23 Oct 2024 12:23:57 +0200
Message-ID: <CACMJSesmyfS4wj=ys16FmqpAoojuChY1OHSC750bjtM23y5baA@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI/pwrctl: Move pwrctl device creation to its own
 helper function
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 12:28, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> This makes the pci_bus_add_device() API easier to maintain. Also add more
> comments to the helper to describe how the devices are created.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/bus.c | 59 ++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 351af581904f..c4cae1775c9e 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -321,6 +321,46 @@ void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
>
>  void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
>
> +/*
> + * Create pwrctl devices (if required) for the PCI devices to handle the power
> + * state.
> + */
> +static void pci_pwrctl_create_devices(struct pci_dev *dev)
> +{
> +       struct device_node *np = dev_of_node(&dev->dev);
> +       struct device *parent = &dev->dev;
> +       struct platform_device *pdev;
> +
> +       /*
> +        * First ensure that we are starting from a PCI bridge and it has a
> +        * corresponding devicetree node.
> +        */
> +       if (np && pci_is_bridge(dev)) {
> +               /*
> +                * Now look for the child PCI device nodes and create pwrctl
> +                * devices for them. The pwrctl device drivers will manage the
> +                * power state of the devices.
> +                */
> +               for_each_child_of_node_scoped(np, child) {
> +                       /*
> +                        * First check whether the pwrctl device really needs to
> +                        * be created or not. This is decided based on at least
> +                        * one of the power supplies being defined in the
> +                        * devicetree node of the device.
> +                        */
> +                       if (!of_pci_is_supply_present(child)) {
> +                               pci_dbg(dev, "skipping OF node: %s\n", child->name);
> +                               return;
> +                       }
> +
> +                       /* Now create the pwrctl device */
> +                       pdev = of_platform_device_create(child, NULL, parent);
> +                       if (!pdev)
> +                               pci_err(dev, "failed to create OF node: %s\n", child->name);
> +               }
> +       }
> +}
> +
>  /**
>   * pci_bus_add_device - start driver for a single device
>   * @dev: device to add
> @@ -345,24 +385,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>         pci_proc_attach_device(dev);
>         pci_bridge_d3_update(dev);
>
> -       if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
> -               for_each_child_of_node_scoped(dn, child) {
> -                       /*
> -                        * First check whether the pwrctl device needs to be
> -                        * created or not. This is decided based on at least
> -                        * one of the power supplies being defined in the
> -                        * devicetree node of the device.
> -                        */
> -                       if (!of_pci_is_supply_present(child)) {
> -                               pci_dbg(dev, "skipping OF node: %s\n", child->name);
> -                               continue;
> -                       }
> -
> -                       pdev = of_platform_device_create(child, NULL, &dev->dev);
> -                       if (!pdev)
> -                               pci_err(dev, "failed to create OF node: %s\n", child->name);
> -               }
> -       }
> +       pci_pwrctl_create_devices(dev);
>
>         /*
>          * Create a device link between the PCI device and pwrctl device (if
>
> --
> 2.25.1
>
>

Would it be possible to move this into drivers/pwrctl/ and provide a
header stub for when PCI_PWRCTL is disabled in Kconfig?

Bart

