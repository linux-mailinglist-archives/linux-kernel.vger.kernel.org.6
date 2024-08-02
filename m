Return-Path: <linux-kernel+bounces-272129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0894579A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BF41C23BD5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977622E83F;
	Fri,  2 Aug 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7BDZNdl"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D4200CB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722576795; cv=none; b=R5DwgveWjS33ipPJJpcNTUK3fzCn8gFuXDOxzs1AVVflZ6J8pv04NpTsoOrhw/3MnszeCYATaYx/82eQF3aZilVhIsNUrkiX8ONpholqCzY9I9WUhYX7muriPJgjmFtMDG3AZpTSbIZw6nkNxIDRD4bJ8FQmVPiWKOj6iHPZN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722576795; c=relaxed/simple;
	bh=4/KDd5xHy+1AQ119uFf/BG/Hdt/+maDe9LcLIS1VPIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9ZqcGZQpQ0IFDtHZtGGeotuiIR2BwxenM7w3EMinY5mdhR7qSfySOwBM08EPbW1298gcy7px7h6bAMRmtH1UYeuaQu6ZQN0zYgp+IFCqGnrV5FJbAE4Vkh1EhaXS2vfi41TR3L6XIQjf0zwKs8M20mkt4e4MmQpnNkP1QP8H7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L7BDZNdl; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-26827ec5235so2119149fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722576792; x=1723181592; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ytXU4cMk/Sc4v76Z1wIWQSYy2VF0oJUjTlSBnv1Gqck=;
        b=L7BDZNdlKOxTrpdwY6pQXDMcwtKu6HhdX6WaekyRZE6pNRl7uVpnz7N6dBTWTqBnfr
         sp6Hfn/idr+Gr+GuRvBOrki3QTNQWb1QNQmtpWDGKGlw5gtZjqqhzXn9/UvXyyOFWPZH
         Q04iZgdj9KNZFJwe+9NtFfHutO8WgP+oIWItK9nOtJEG+f9I3ajvFKRxEBSbTcbXFw3E
         AmqUjP3av4wCOudjv+6AHjpT0owPTLAcMLuHrxxjaPJ/4HOINJvBzRRUfdoz055J5wGY
         j1pXE8xm4ycJ65uDa2WBTzkfdEjDe/0FvVSCA+SK/Iby/hmHaMNDeQRSA5hIpmyBjk8o
         KUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722576792; x=1723181592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytXU4cMk/Sc4v76Z1wIWQSYy2VF0oJUjTlSBnv1Gqck=;
        b=Kp6dsgJSo8LS4p5/BNlqQFiIVeAu1P0DIE2VRr5ChOk9+o+dgRSYTSShkyxhJLhUzH
         j+lSvr/fDoSUaR19YdkQ6a429uFkw8564Y7EFtSfzMr3ldTXJ2Pk1DHysBcj2pc3P238
         maJIB3k5XZHckWLdMZl9inVFEcFbQd9Mi3BRRJkXEqxSeKWkNfKnI/1YKv81IHpLIgzQ
         b3YSqDmN5s9nKgk+1luG3JUqFVrHcAcmHhk4bcW7HL/aSwx6yVHvv6fd7nToNKRRuEQ8
         vU23iU2doy57YzmUs+XsFsywqAaGAn2M9OE/zB7zit1CIYFpisRP0J9Z0DXi5OGLtDAY
         4N3w==
X-Forwarded-Encrypted: i=1; AJvYcCV+LGQDT+pxDMT3w1c5iEnpCgs9ydR0HhJt2lLkq5/IZo7N/c5S+2KpovCwes1oQN9Y4UWnAjNmbAuM1PF4MQFOXYGMrGKhPH/4oTWT
X-Gm-Message-State: AOJu0YwQ9Ey3xdicVwTgZIp9Ah/rLJFTTs0BI6tEMAV4bRYUzQkKFs6q
	mPv3tflYPXovYoBIZLzfIqg4IK7d0nWHiY/5iwlyoxbMAgvRlghojuAFUPSnow==
X-Google-Smtp-Source: AGHT+IG60xjRDah2UUnb+qlVLtrauF01HB7uWYz/dwXzQ+jmmpaXHD55NtswhUqOD0embOkalwuIFA==
X-Received: by 2002:a05:6870:b6a3:b0:261:72a:1336 with SMTP id 586e51a60fabf-26891f26da5mr2512428fac.50.1722576792494;
        Thu, 01 Aug 2024 22:33:12 -0700 (PDT)
Received: from thinkpad ([120.60.54.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdfe38sm666338b3a.120.2024.08.01.22.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 22:33:11 -0700 (PDT)
Date: Fri, 2 Aug 2024 11:03:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v4 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240802053302.GB4206@thinkpad>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
 <20240326-pci-bridge-d3-v4-3-f1dce1d1f648@linaro.org>
 <CAJMQK-hu+FrVtYaUiwfp=uuYLT_xBRcHb0JOfMBz5TYaktV6Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJMQK-hu+FrVtYaUiwfp=uuYLT_xBRcHb0JOfMBz5TYaktV6Ow@mail.gmail.com>

On Thu, Aug 01, 2024 at 02:07:41PM -0700, Hsin-Yi Wang wrote:
> On Fri, Jul 26, 2024 at 4:02 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Currently, there is no proper distinction between D3Hot and D3Cold while
> > handling the power management for PCI bridges. For instance,
> > pci_bridge_d3_allowed() API decides whether it is allowed to put the
> > bridge in D3, but it doesn't explicitly specify whether D3Hot or D3Cold
> > is allowed in a scenario. This often leads to confusion and may be prone
> > to errors.
> >
> > So let's split the D3Hot and D3Cold handling where possible. The current
> > pci_bridge_d3_allowed() API is now split into pci_bridge_d3hot_allowed()
> > and pci_bridge_d3cold_allowed() APIs and used in relevant places.
> >
> > Also, pci_bridge_d3_update() API is now renamed to
> > pci_bridge_d3cold_update() since it was only used to check the possibility
> > of D3Cold.
> >
> > Note that it is assumed that only D3Hot needs to be checked while
> > transitioning the bridge during runtime PM and D3Cold in other places. In
> > the ACPI case, wakeup is now only enabled if both D3Hot and D3Cold are
> > allowed for the bridge.
> >
> > Still, there are places where just 'd3' is used opaquely, but those are
> > hard to distinguish, hence left for future cleanups.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/bus.c          |  2 +-
> >  drivers/pci/pci-acpi.c     |  5 +--
> >  drivers/pci/pci-sysfs.c    |  2 +-
> >  drivers/pci/pci.c          | 78 ++++++++++++++++++++++++++++++----------------
> >  drivers/pci/pci.h          | 12 ++++---
> >  drivers/pci/pcie/portdrv.c | 16 +++++-----
> >  drivers/pci/remove.c       |  2 +-
> >  include/linux/pci.h        |  3 +-
> >  8 files changed, 75 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 826b5016a101..cb1a1aaefa90 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -346,7 +346,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> >                 of_pci_make_dev_node(dev);
> >         pci_create_sysfs_dev_files(dev);
> >         pci_proc_attach_device(dev);
> > -       pci_bridge_d3_update(dev);
> > +       pci_bridge_d3cold_update(dev);
> >
> >         dev->match_driver = !dn || of_device_is_available(dn);
> >         retval = device_attach(&dev->dev);
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 0f260cdc4592..aaf5a68e7984 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> >          * reason is that the bridge may have additional methods such as
> >          * _DSW that need to be called.
> >          */
> > -       if (pci_dev->bridge_d3_allowed)
> > +       if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
> >                 device_wakeup_enable(dev);
> >
> >         acpi_pci_wakeup(pci_dev, false);
> > @@ -1452,7 +1452,8 @@ void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)
> >         pci_acpi_remove_pm_notifier(adev);
> >         if (adev->wakeup.flags.valid) {
> >                 acpi_device_power_remove_dependent(adev, dev);
> > -               if (pci_dev->bridge_d3_allowed)
> > +               if (pci_dev->bridge_d3cold_allowed &&
> > +                   pci_dev->bridge_d3hot_allowed)
> >                         device_wakeup_disable(dev);
> >
> >                 device_set_wakeup_capable(dev, false);
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 40cfa716392f..45628b0dd116 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -529,7 +529,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
> >                 return -EINVAL;
> >
> >         pdev->d3cold_allowed = !!val;
> > -       pci_bridge_d3_update(pdev);
> > +       pci_bridge_d3cold_update(pdev);
> >
> >         pm_runtime_resume(dev);
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 0edc4e448c2d..48e2ca0cd8a0 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -166,9 +166,9 @@ bool pci_ats_disabled(void)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_ats_disabled);
> >
> > -/* Disable bridge_d3 for all PCIe ports */
> > +/* Disable both D3Hot and D3Cold for all PCIe ports */
> >  static bool pci_bridge_d3_disable;
> > -/* Force bridge_d3 for all PCIe ports */
> > +/* Force both D3Hot and D3Cold for all PCIe ports */
> >  static bool pci_bridge_d3_force;
> >
> >  static int __init pcie_port_pm_setup(char *str)
> > @@ -2966,14 +2966,11 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
> >         { }
> >  };
> >
> > -/**
> > - * pci_bridge_d3_allowed - Is it allowed to put the bridge into D3
> > - * @bridge: Bridge to check
> > - *
> > - * This function checks if the bridge is allowed to move to D3.
> > - * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
> > +/*
> > + * Helper function to check whether it is allowed to put the bridge into D3
> > + * states (D3Hot and D3Cold).
> >   */
> > -bool pci_bridge_d3_allowed(struct pci_dev *bridge)
> > +static bool pci_bridge_d3_allowed(struct pci_dev *bridge, pci_power_t state)
> >  {
> >         if (!pci_is_pcie(bridge))
> >                 return false;
> > @@ -3026,6 +3023,32 @@ bool pci_bridge_d3_allowed(struct pci_dev *bridge)
> >         return false;
> >  }
> >
> > +/**
> > + * pci_bridge_d3cold_allowed - Is it allowed to put the bridge into D3Cold
> > + * @bridge: Bridge to check
> > + *
> > + * This function checks if the bridge is allowed to move to D3Cold.
> > + * Currently we only allow D3Cold for recent enough PCIe ports on ACPI based
> > + * platforms and Thunderbolt.
> > + */
> > +bool pci_bridge_d3cold_allowed(struct pci_dev *bridge)
> > +{
> > +       return pci_bridge_d3_allowed(bridge, PCI_D3cold);
> > +}
> > +
> > +/**
> > + * pci_bridge_d3cold_allowed - Is it allowed to put the bridge into D3Hot
> 
> typo? pci_bridge_d3hot_allowed.
> 

Yep, nice catch!

> > + * @bridge: Bridge to check
> > + *
> > + * This function checks if the bridge is allowed to move to D3Hot.
> > + * Currently we only allow D3Hot for recent enough PCIe ports on ACPI based
> > + * platforms and Thunderbolt.
> > + */
> > +bool pci_bridge_d3hot_allowed(struct pci_dev *bridge)
> > +{
> > +       return pci_bridge_d3_allowed(bridge, PCI_D3hot);
> > +}
> > +
> >  static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
> >  {
> >         bool *d3cold_ok = data;
> > @@ -3046,55 +3069,55 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
> >  }
> >
> >  /*
> > - * pci_bridge_d3_update - Update bridge D3 capabilities
> > + * pci_bridge_d3cold_update - Update bridge D3Cold capabilities
> >   * @dev: PCI device which is changed
> >   *
> >   * Update upstream bridge PM capabilities accordingly depending on if the
> >   * device PM configuration was changed or the device is being removed.  The
> >   * change is also propagated upstream.
> >   */
> > -void pci_bridge_d3_update(struct pci_dev *dev)
> > +void pci_bridge_d3cold_update(struct pci_dev *dev)
> >  {
> >         bool remove = !device_is_registered(&dev->dev);
> >         struct pci_dev *bridge;
> >         bool d3cold_ok = true;
> >
> >         bridge = pci_upstream_bridge(dev);
> > -       if (!bridge || !pci_bridge_d3_allowed(bridge))
> > +       if (!bridge || !pci_bridge_d3cold_allowed(bridge))
> >                 return;
> >
> >         /*
> > -        * If D3 is currently allowed for the bridge, removing one of its
> > +        * If D3Cold is currently allowed for the bridge, removing one of its
> >          * children won't change that.
> >          */
> > -       if (remove && bridge->bridge_d3_allowed)
> > +       if (remove && bridge->bridge_d3cold_allowed)
> >                 return;
> >
> >         /*
> > -        * If D3 is currently allowed for the bridge and a child is added or
> > -        * changed, disallowance of D3 can only be caused by that child, so
> > +        * If D3Cold is currently allowed for the bridge and a child is added or
> > +        * changed, disallowance of D3Cold can only be caused by that child, so
> >          * we only need to check that single device, not any of its siblings.
> >          *
> > -        * If D3 is currently not allowed for the bridge, checking the device
> > -        * first may allow us to skip checking its siblings.
> > +        * If D3Cold is currently not allowed for the bridge, checking the
> > +        * device first may allow us to skip checking its siblings.
> >          */
> >         if (!remove)
> >                 pci_dev_check_d3cold(dev, &d3cold_ok);
> >
> >         /*
> > -        * If D3 is currently not allowed for the bridge, this may be caused
> > +        * If D3Cold is currently not allowed for the bridge, this may be caused
> >          * either by the device being changed/removed or any of its siblings,
> >          * so we need to go through all children to find out if one of them
> > -        * continues to block D3.
> > +        * continues to block D3Cold.
> >          */
> > -       if (d3cold_ok && !bridge->bridge_d3_allowed)
> > +       if (d3cold_ok && !bridge->bridge_d3cold_allowed)
> >                 pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
> >                              &d3cold_ok);
> >
> > -       if (bridge->bridge_d3_allowed != d3cold_ok) {
> > -               bridge->bridge_d3_allowed = d3cold_ok;
> > +       if (bridge->bridge_d3cold_allowed != d3cold_ok) {
> > +               bridge->bridge_d3cold_allowed = d3cold_ok;
> >                 /* Propagate change to upstream bridges */
> > -               pci_bridge_d3_update(bridge);
> > +               pci_bridge_d3cold_update(bridge);
> >         }
> >  }
> >
> > @@ -3110,7 +3133,7 @@ void pci_d3cold_enable(struct pci_dev *dev)
> >  {
> >         if (dev->no_d3cold) {
> >                 dev->no_d3cold = false;
> > -               pci_bridge_d3_update(dev);
> > +               pci_bridge_d3cold_update(dev);
> >         }
> >  }
> >  EXPORT_SYMBOL_GPL(pci_d3cold_enable);
> > @@ -3127,7 +3150,7 @@ void pci_d3cold_disable(struct pci_dev *dev)
> >  {
> >         if (!dev->no_d3cold) {
> >                 dev->no_d3cold = true;
> > -               pci_bridge_d3_update(dev);
> > +               pci_bridge_d3cold_update(dev);
> >         }
> >  }
> >  EXPORT_SYMBOL_GPL(pci_d3cold_disable);
> > @@ -3167,7 +3190,8 @@ void pci_pm_init(struct pci_dev *dev)
> >         dev->pm_cap = pm;
> >         dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
> >         dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
> > -       dev->bridge_d3_allowed = pci_bridge_d3_allowed(dev);
> > +       dev->bridge_d3cold_allowed = pci_bridge_d3cold_allowed(dev);
> > +       dev->bridge_d3hot_allowed = pci_bridge_d3hot_allowed(dev);
> >         dev->d3cold_allowed = true;
> >
> >         dev->d1_support = false;
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 53ca75639201..f819eab793fc 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -92,8 +92,9 @@ void pci_pm_init(struct pci_dev *dev);
> >  void pci_ea_init(struct pci_dev *dev);
> >  void pci_msi_init(struct pci_dev *dev);
> >  void pci_msix_init(struct pci_dev *dev);
> > -bool pci_bridge_d3_allowed(struct pci_dev *dev);
> > -void pci_bridge_d3_update(struct pci_dev *dev);
> > +bool pci_bridge_d3cold_allowed(struct pci_dev *dev);
> > +bool pci_bridge_d3hot_allowed(struct pci_dev *dev);
> > +void pci_bridge_d3cold_update(struct pci_dev *dev);
> >  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
> >
> >  static inline void pci_wakeup_event(struct pci_dev *dev)
> > @@ -111,9 +112,12 @@ static inline bool pci_power_manageable(struct pci_dev *pci_dev)
> >  {
> >         /*
> >          * Currently we allow normal PCI devices and PCI bridges transition
> > -        * into D3 if their bridge_d3 is set.
> > +        * into D3 states if both bridge_d3cold_allowed and bridge_d3hot_allowed
> > +        * are set.
> >          */
> 
> If pm requires both D3hot and D3cold, can we add a flag for DT to
> support D3cold? Otherwise during suspend, pcieport still stays at D0.
> 

You mean D3hot?

> [   42.202016] mt7921e 0000:01:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x300 @ 77, parent: 0000:00:00.0
> [   42.231681] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot

Here I can see that the port entered D3hot

> [   42.238048] mt7921e 0000:01:00.0: PM:
> pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26583 usecs
> [   42.247083] pcieport 0000:00:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x300 @ 3196, parent: pci0000:00
> [   42.296325] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0

And resuming with D0.

Problem with D3Cold is, it is a power off state. If a driver wants a device/port
to enter D3Cold, then it needs to know the power supply. Otherwise, techinically
the driver cannot put the device into D3Cold. And there is no power supply
exposed in DT for most of the rootports/bridges.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

