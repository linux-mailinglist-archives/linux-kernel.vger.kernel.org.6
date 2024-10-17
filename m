Return-Path: <linux-kernel+bounces-369425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 541459A1D26
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F62B264AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25B199944;
	Thu, 17 Oct 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NiFWWN61"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE125776
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153536; cv=none; b=UAG/aejVNdXQEWqvvM6q0OmNm86L8BIVgVpjonoWCswMGHm372BuDOa/1bwNAcZ6j2+Dcwk6AefD1ZOqCoS/bntMQGvGMu7dLtaNtP+c7d5t6Dbs2I18+LEfHl2rSGTDYHuwveGtl7Tj4baHCsfeCdqQJtyAOuwOKrQUJUdL7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153536; c=relaxed/simple;
	bh=Q2+ZoTS4ssNjsj+JyK3Y4jaHPJcRMinM6P+uR0CYaeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg02rwTLnIKFJkS8kLl5zEcRCsfMIgqJx3FNfHt5Q1IsRKn92s8daUzE204H8S4+kamUrg8iOa2PvyKLCmRorL4rDLw24BluU8POEDeCPR71qn9lSvaMwPgVA2u6ijPGmt1+vS4cfPcZwYlwfyKLDfT+VViwCA/b5ps1bV5j5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NiFWWN61; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea9739647bso460459a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729153534; x=1729758334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RfegGKBoecFVjtOzqWqQcwcILhYUApF5JxrsUzGthNA=;
        b=NiFWWN61KO8plJr4YiiMBofmWRk/hNeJUGVMXLIcxrU/7JCyxLaIeDIexM0zZvB/Tf
         4ZPvX8dd9JOPGQVBMVfy4w2U8eIVKZKqlRGxc4pEbF8irG6RV0i/wvn4RsiCJh2EVDZr
         BDe/FAZ5f8rYsaXfizQa5bXyDl4QnN1vc52CMo/OBiAuAqYozpbjkbYLLz4u0I661XbF
         opriEvbN523YBW/0opumxjDEQ+WKnPS1GjvCFaVh/iKVXITgAbfDMNGjUQSjjYQ+ExXa
         X6XPjdFTc76gxiL80BmWpl9lh+XITU1xcxEsNc4aKdBjvHz6jqKbZT3uwJuBp6q2fEru
         Qr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729153534; x=1729758334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfegGKBoecFVjtOzqWqQcwcILhYUApF5JxrsUzGthNA=;
        b=gE+tHCGJBdYR6hOtQxtF/hxzoe5eWBX6m2zZm5DCueMQLhXVIMkM4xLC8G4IcZRl9A
         LM3Pqa0Exo5N773SLtOv0MrocPNuMRf8YWBrzMx25Sf39ok/VI2ygapT+gbMLKGGZrIz
         vIjnrUd0ZcKVK8beQFtXoFYTdVdH0SHUxuUFi1CMJ2QzDlqGlt2I7Df4Bkqh7rqTgq1f
         Wc2wGqdVyNbY6TcDLCIbeVkwQO+bCU1Il3q/blCGb72oqRpiQ53RZC9hOGCqaDNDnK4X
         qHlsWGQgLcJXNJr4SlARqJJhdbYR2N2BkWC0BncAr0ETx+vW348IbWeM4XQ+ELwvKsvE
         /2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXyzQYO9UxNuEJLOR3RC6ylt6Yrt48cWEuVXxnDKs8Q1g+uGkdTDSeNvkbcA7cf7ApY/ZgHYjOOIUH1TkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdTK6Tlh+KSnUPCSE+MLvYAWOKejds/ZjMrE/E2BB82MQEIzvV
	ZtjztWQNhSf0n83ozmcOmCLK4eUZqRvKC1zorgKOcUkNQEf2G2mmn+us1nuFMg==
X-Google-Smtp-Source: AGHT+IEO9+tIUsEddFQAyCxB73U5Kj3+f+ZjXM97ALdj+hz3qgqTbB3BRr7EbU5X4y3sB9bJQiDr7Q==
X-Received: by 2002:a05:6a21:918c:b0:1d9:61:e779 with SMTP id adf61e73a8af0-1d905ea1d9amr9300508637.4.1729153534008;
        Thu, 17 Oct 2024 01:25:34 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08d0807sm1268081a91.16.2024.10.17.01.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:25:33 -0700 (PDT)
Date: Thu, 17 Oct 2024 13:55:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Ley Foon Tan <ley.foon.tan@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <20241017082526.ppoz7ynxas5nlht5@thinkpad>
References: <Yt+6azfwd/LuMzoG@hovoldconsulting.com>
 <20220727195716.GA220011@bhelgaas>
 <YuJ+PZIhg8mDrdlX@hovoldconsulting.com>
 <20241017052335.iue4jhvk5q4efigv@thinkpad>
 <86v7xr418s.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86v7xr418s.wl-maz@kernel.org>

On Thu, Oct 17, 2024 at 08:50:11AM +0100, Marc Zyngier wrote:
> On Thu, 17 Oct 2024 06:23:35 +0100,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > On Thu, Jul 28, 2022 at 02:17:01PM +0200, Johan Hovold wrote:
> > > On Wed, Jul 27, 2022 at 02:57:16PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Jul 26, 2022 at 11:56:59AM +0200, Johan Hovold wrote:
> > > > > On Mon, Jul 25, 2022 at 06:35:27PM +0100, Marc Zyngier wrote:
> > > > > > On Mon, 25 Jul 2022 16:18:48 +0100,
> > > > > > Johan Hovold <johan@kernel.org> wrote:
> > > > > 
> > > > > > > Since when is unloading modules something that is expected to
> > > > > > > work perfectly? I keep hearing "well, don't do that then" when
> > > > > > > someone complains about unloading this module while doing this
> > > > > > > or that broke something. (And it's only root that can unload
> > > > > > > modules in the first place.)
> > > > > > 
> > > > > > Well, maybe I have higher standards. For the stuff I maintain, I
> > > > > > now point-blank refuse to support module unloading if this can
> > > > > > result in a crash. Or worse.
> > > > > 
> > > > > That makes sense for regular interrupt controllers where its hard to
> > > > > tell that all consumers are gone, but I don't think that should
> > > > > limit the usefulness of having modular PCI controller drivers where
> > > > > we know that the consumers are gone after deregistering the bus
> > > > > (i.e. the consumers are descendants of the controller in the device
> > > > > tree).
> > > > 
> > > > Those consumers are endpoint drivers, so I think this depends on those
> > > > drivers correctly unmapping the interrupts they use, right?
> > > 
> > > Right. For MSI this means that pci_alloc_irq_vectors() in probe should
> > > be matched by pci_free_irq_vectors() on remove.
> > > 
> > > For legacy interrupts, which can be shared, the mapping is created by
> > > PCI core when binding to the first device and can only be disposed by
> > > the host-bridge driver once all descendants have been removed.
> > > 
> > > The endpoint drivers still need to disable their interrupts of course.
> > > 
> > > Buggy endpoint-driver remove implementations can lead to all sorts of
> > > crashes (e.g. after failing to deregister a class device), and if that's
> > > a worry then don't unload modules (and possibly disable it completely
> > > using CONFIG_MODULE_UNLOAD).
> > > 
> > > > > > > It's useful for developers, but use it at your own risk.
> > > > > > > 
> > > > > > > That said, I agree that if something is next to impossible to
> > > > > > > get right, as may be the case with interrupt controllers
> > > > > > > generally, then fine, let's disable module unloading for that
> > > > > > > class of drivers.
> > > > > > > 
> > > > > > > And this would mean disabling driver unbind for the 20+ driver
> > > > > > > PCI drivers that currently implement it to some degree.
> > > > > > 
> > > > > > That would be Bjorn's and Lorenzo's call.
> > > > > 
> > > > > Sure, but I think it would be the wrong decision here. Especially,
> > > > > since the end result will likely just be that more drivers will
> > > > > become always compiled-in.
> > > > 
> > > > Can you elaborate on this?  I think Marc is suggesting that these PCI
> > > > controller drivers be modular but not removable.  Why would that cause
> > > > more of them to be compiled-in?
> > > 
> > > As mentioned earlier in this thread, we only appear to have some 60
> > > drivers in the entire tree that bother to try to implement that. I fear
> > > that blocking the use of modules (including being able to unload them)
> > > will just make people submit drivers that can only be built in.
> > > 
> > > Not everyone cares about Android's GKI, but being able to unload a
> > > module during development is very useful (and keeping that out-of-tree
> > > prevents sharing the implementation and make it susceptible to even
> > > further bit rot).
> > > 
> > > So continuing to supporting modules properly is a win for everyone (e.g.
> > > GKI and developers).
> > >  
> > > > > > > > > Turns out the pcie-qcom driver does not support legacy
> > > > > > > > > interrupts so there's no risk of there being any lingering
> > > > > > > > > mappings if I understand things correctly.
> > > > > > > > 
> > > > > > > > It still does MSIs, thanks to dw_pcie_host_init(). If you can
> > > > > > > > remove the driver while devices are up and running with MSIs
> > > > > > > > allocated, things may get ugly if things align the wrong way
> > > > > > > > (if a driver still has a reference to an irq_desc or irq_data,
> > > > > > > > for example).
> > > > > > > 
> > > > > > > That is precisely the way I've been testing it and everything
> > > > > > > appears to be tore down as it should.
> > > > > > >
> > > > > > > And a PCI driver that has been unbound should have released its
> > > > > > > resources, or that's a driver bug. Right?
> > > > > > 
> > > > > > But that's the thing: you can easily remove part of the
> > > > > > infrastructure without the endpoint driver even noticing. It may
> > > > > > not happen in your particular case if removing the RC driver will
> > > > > > also nuke the endpoints in the process, but I can't see this is an
> > > > > > absolute guarantee. The crash pointed to by an earlier email is
> > > > > > symptomatic of it.
> > > > > 
> > > > > But that was arguably due to a driver bug, which we know how to fix.
> > > > > For MSIs the endpoint driver will free its interrupts and all is
> > > > > good.
> > > > > 
> > > > > The key observation is that the driver model will make sure that any
> > > > > endpoint drivers have been unbound before the bus is deregistered.
> > > > > 
> > > > > That means there are no longer any consumers of the interrupts,
> > > > > which can be disposed. For MSI this is handled by
> > > > > pci_free_irq_vectors() when unbinding the endpoint drivers. For
> > > > > legacy interrupts, which can be shared, the PCIe RC driver needs to
> > > > > manage this itself after the consumers are gone.
> > > > 
> > > > The driver model ensures that endpoint drivers have been unbound. But
> > > > doesn't the interrupt disposal depend on the correct functioning of
> > > > those endpoint drivers?  So if a buggy endpoint driver failed to
> > > > dispose of them, we're still vulnerable?
> > > 
> > > Just as you are if an endpoint-driver fails to clean up after itself in
> > > some other way (e.g. leaves the interrupt enabled).
> > >
> > 
> > The IRQ disposal issue should hopefully fixed by this series:
> > https://lore.kernel.org/linux-pci/20240715114854.4792-3-kabel@kernel.org/
> > 
> > Then if the dwc driver calls pci_remove_irq_domain() instead of
> > irq_domain_remove(), we can be sure that all the IRQs are disposed during the
> > driver remove.
> > 
> > So can we proceed with the series making Qcom driver modular?
> 
> Who is volunteering to fix the drivers that will invariably explode
> once we allow this?
> 

Why should anyone volunteer first up? If the issue gets reported for a driver
blowing up, then the driver has to be fixed by the maintainer or someone, just
like any other bug.

From reading the thread, the major concern was disposing the IRQs before
removing the domain and that is now taken care of. If you are worrying about a
specific issue, please say so.

As a Qcom PCIe driver maintainer, I'd like to provide users/developers the
flexibility to remove the driver for development purposes.

- Mani

> Because if the outcome is that we let things bitrot even more than
> they already are, I don't think this is going in the correct direction
> -- as in *the direction of correctness*.
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

-- 
மணிவண்ணன் சதாசிவம்

