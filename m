Return-Path: <linux-kernel+bounces-519659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747EFA3A051
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F28189AE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931F26E177;
	Tue, 18 Feb 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzS9Jomi"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8726AA98
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889628; cv=none; b=BNk/IVSP2K6He0zxjN5aPRHt6BlrXu58NCN7nT/4Mpj/m4tPolzsAeeD0hDgO4NhuOG4EtFxniqwD9TPXY5XN7j40zQihwUL7AdtOfqaCv+LiJTNqwClM/wpR2DNuQkUYX32j6/r2o+cxw3S5sECxDO3SqylYJVGCRMP5fTeA08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889628; c=relaxed/simple;
	bh=mr+2Jhhmfhv+3seL9n1mB+VOznYBvn3lX+NZfQylTqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=St0RUHjBgUhE1AI2jK70xXOvnfsNFluIbmcOlZd6U12BVu29wDp3ewb3YB14irdWqqdaYssWXAc5YNX4nqKgq8sdMnHFfDAnduNNxzLfsRSMseE54fRg1qp1fewJsH2GGlVpjlJfBvvZ3WPKsNVdeiC3ECMx9iDd3/9RaKD0pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yzS9Jomi; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e587cca1e47so5006139276.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739889624; x=1740494424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2wkeEEWV1t+jTfGMDjVEd0UQWJSursxJ+qu65t0oVks=;
        b=yzS9JomiL+1VCRq5xGA/LVJBda1hD0LHa+tIsrOwo+8YCI4bbA8FZadK/V/4waPQQH
         9aFpqNh/ia1C10WgvRzuB5wF2U66/lYcRX0QP2L1I3eQBf6yiuSOHZmFx2d7MpQ/D7zY
         U4ZFcDr7s9T1qxzTzHpwAigz1L8lTWxIO0rcZsWkoNBRq0D4NxcLBiCyVoniZJywJJ7s
         xsWKhTGX/urMFShw+xctToQ4jo4bUdGFKRL2aGJPp513TUp5dN5+B1OYXD4C9f+yFbaw
         RGlT0VlSjnEtn1qTEGgF0XzOGk/xU6ENK+5wByLpc0RPumM9RquuK4enTt/nGOnnii8s
         FbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889624; x=1740494424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wkeEEWV1t+jTfGMDjVEd0UQWJSursxJ+qu65t0oVks=;
        b=VRNMitzCJwsEkjk6OCZ5QTgrD/GMr25TF6UetSe2BEF26K7ikK/RHPE74CVZeFrnNR
         zUvD/hWtZwUVJkJjkkJbPYpDH3p8di9jG5rrJiTBIDKQpNSmD/Ik3LKWDJVS2yOfVenA
         zZMgnorv2XT0v1/zl7OZnlu3FtezcxW0BLaolU0AE/ZWs0vCL9yAIVmsdcYe7EGcoDk6
         LK7IM+B/x35zjusSGcV0qAdbzDgect9Ew7JZEB4AZoeRrkWlWiPIToDFNw/warKdTOe9
         poTuTGQUTQ8YsiYF2UX85UyvbjJPtR5Jh6VeSKIskHTcBWe0OfyHkE+5ohU4fEdb76kf
         W+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWySJdSstIPwcGuCzdV4kaM4jxxwwcTiz+kA3LJSOsNLYE27gh/AeWAnjQbg6/hsSARl8M1k0TKaBSujwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2nenSrD1GVfTzYzr6nwHuKi7+tEx43lG844bX354uhEhGaXG
	XpqKi6QTkwuVwCha6qtupzwB9LoTkqcHUCY0BxZDTyA6hiCEkPfwrvmN9W5+Are8D4pz7qdNjOP
	NBjfwZzu1gUPwtw/MRGz9rXBzO1kye849Q6hcAg==
X-Gm-Gg: ASbGncvuLpm+Uj4SD137uEKebSzsd1XDwTGIurz/Swqo6KkJl1hrCi8QCbdw0i9uwFm
	wjxMr0U6jry+jKUPPtO2vKThALa77dWdB5vYUopT6KynCoXFOuR+45L5GR6+rQfx6jU9Yz1A7Hg
	==
X-Google-Smtp-Source: AGHT+IGc7tsTon1APxRniRGgusdip7zanYIlI5kyK12K1ApVdClP0yClUsQd8ZYL07bK78dVmjWR+9yq+z6BP2esIog=
X-Received: by 2002:a05:6902:15c4:b0:e20:25bb:7893 with SMTP id
 3f1490d57ef6-e5dc9305520mr9687881276.46.1739889623851; Tue, 18 Feb 2025
 06:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4966939.GXAFRqVoOG@rjwysocki.net> <2000822.PYKUYFuaPT@rjwysocki.net>
 <CAPDyKFoB0fQCabahYpx=A_Ns7vJgWYdK=rxuHk+XHVv35cFvWQ@mail.gmail.com> <CAJZ5v0iHsOw4_UbEWGk_-jPpc3q2K3fUXBs4T3JCooPGV10CHQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iHsOw4_UbEWGk_-jPpc3q2K3fUXBs4T3JCooPGV10CHQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Feb 2025 15:39:47 +0100
X-Gm-Features: AWEUYZkUeOWjKpfEpylPzwUgMmhW5JCtP7D9lSJ8wjRrv-WgzsAF82ls-gYur34
Message-ID: <CAPDyKFqshaVNzHPe0KL3HRTpiuzyKVJ-LuDsaAne5PawFLMJow@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> > >
> > > +static void device_prepare_smart_suspend(struct device *dev)
> > > +{
> > > +       struct device_link *link;
> > > +       int idx;
> > > +
> > > +       /*
> > > +        * The "smart suspend" feature is enabled for devices whose drivers ask
> > > +        * for it and for devices without PM callbacks unless runtime PM is
> > > +        * disabled and enabling it is blocked for them.
> > > +        *
> > > +        * However, if "smart suspend" is not enabled for the device's parent
> > > +        * or any of its suppliers that take runtime PM into account, it cannot
> > > +        * be enabled for the device either.
> > > +        */
> > > +       dev->power.smart_suspend = (dev->power.no_pm_callbacks ||
> > > +               dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) &&
> > > +               !pm_runtime_blocked(dev);
> > > +
> > > +       if (!dev->power.smart_suspend)
> > > +               return;
> > > +
> > > +       if (dev->parent && !pm_runtime_blocked(dev->parent) &&
> > > +           !dev->parent->power.ignore_children && !dev->parent->power.smart_suspend) {
> > > +               dev->power.smart_suspend = false;
> > > +               return;
> > > +       }
> > > +
> > > +       idx = device_links_read_lock();
> > > +
> > > +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
> > > +               if (!(link->flags | DL_FLAG_PM_RUNTIME))
> > > +                       continue;
> > > +
> > > +               if (!pm_runtime_blocked(link->supplier) &&
> > > +                   !link->supplier->power.smart_suspend) {
> >
> > This requires device_prepare() for all suppliers to be run before its
> > consumer. Is that always the case?
>
> Yes, it is by design.

Okay! I was worried that fw_devlink could mess this up.

>
> > > +                       dev->power.smart_suspend = false;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       device_links_read_unlock(idx);
> >
> > From an execution overhead point of view, did you check if the above
> > code had some measurable impact on the latency for dpm_prepare()?
>
> It didn't on my systems.
>
> For the vast majority of devices the overhead is just checking
> power.no_pm_callbacks and DPM_FLAG_SMART_SUSPEND.  For some,
> pm_runtime_blocked() needs to be called which requires grabbing a
> spinlock and there are only a few with power.smart_suspend set to
> start with.
>
> I'm wondering why you didn't have this concern regarding other changes
> that involved walking suppliers or consumers, though.

Well, the concern is mostly generic from my side. When introducing
code that potentially could impact latency during system
suspend/resume, we should at least check it.

That said, I think the approach makes sense, so no objections from my side!

Feel free to add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

