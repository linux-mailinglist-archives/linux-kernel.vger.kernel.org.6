Return-Path: <linux-kernel+bounces-514409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E565A356BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD571890BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EA51DD88B;
	Fri, 14 Feb 2025 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkRaTZ3w"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6C1DC9BB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513385; cv=none; b=c/KbDVSEv2bDdEgkYml6a6xMFEO4pxFgkIeNPXFt9P2A16ysG/B629oDsVjv76QbZyDTbjlVa/Ue4g+AvCTimOa2QlRZSI7yVLFnx65W+SpOVBvZ1ZBobd1ptV/aZB5xt8yYfbbSGk4BG1Q4MuwQyNh3ay9PPFxiP6olCCXAcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513385; c=relaxed/simple;
	bh=gslqCHxXuliK3k42oXZWCxQ/0azTZyYkThTDVb/Huws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbim6k22YQGVEP7Iy7eE3gnJINiq0tybCzgtOQN4c2nlWUACl7VFg1EhS/T5xoVUOmc/T4kUUElpEUtgssNSsRwT+FWW3O5R9j+htRXLL7SNShR2OfoDZT/0xVCdcqI28ki77SL9yPLbLMzzPWJFgCnVNb0YPCg8f9cG0V3Wdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fkRaTZ3w; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso355371a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739513382; x=1740118182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qvr3z8yXwbqcPQYudFZGi2O6Yo/lZbNexZYPGGJGKds=;
        b=fkRaTZ3w9zDI9tzKrpxo1hsDDxwiw7FHKHfX3XCeT6gi97VuF7yunzRjt76xiip445
         uBDXWt44VnJH9lHKm+boridLB7EmfKsQTEijoeQC4mRtjjkS3T1C220nGj4rrQKW2tXA
         OhQTKkAoxFfuaFE9He4LsIgmGLAjBlm6BzAD3uw0VtUVqjb3TXvyIQYOnz3iDXAqeWZW
         et8wsE95g+tf5tW13JLa2NVjOiHa6gXWXO0aobCKpV+o7SDMV20dBcZtO/OMOIGMVE5O
         c1I4SE1Ejvt+Q8+BHpwdiSHsov4/AXbdGUa4GmGC7wDQQwxbyhxhPXlvZBiDVFOw9BnL
         GUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739513382; x=1740118182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qvr3z8yXwbqcPQYudFZGi2O6Yo/lZbNexZYPGGJGKds=;
        b=O9GNfhFmLDicpSPTjBNbfgCWc5C5Oi1wKP4AZVdrO/X8/jQYMjyJPCwjhLz0cfUZAw
         XhvrDvFiTSVpOwBCq5nrvvm+orGz/kLXD4YnfrVrrrCfVBtCEr2XCQQ8SJ55G+tYs5cU
         KRgv/VVzM87AeCPnmHBzoQ0HxyXfAw8q1G4mjJeuvbtkGfOGHFb5uq3RizsuZ3LjeA5x
         ooAz/2rFKGxMtpDfit42P5xdBzDvH+37t48YpAipZpxUsjUw8JJqhehQbFDtuxLCS6v5
         SHLKyBbiU690RmjZMKqeVi3weMkJSAWPQdAkEEdOoYrH2CwOSIWBzbwnVvuaegWsUg2d
         Tevg==
X-Forwarded-Encrypted: i=1; AJvYcCVZzfrCY4D51C1nBInKhW7rjhGmAcY+8+/gkLRWpdPl47KWEykbCk4L677SUIUBGTABSz6S83z2Lx9qWcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BVkZcH4AU6SfcfBnQ4y7So6WTA+WiDxATBixescS49N1A4Tn
	0F2Bw0hJ1rnsd2DC9suLxZYymV5StCNROh/HsfFIMVp8g3ypKklkVn3WzOan+FelLKH4ovsbK5M
	=
X-Gm-Gg: ASbGncvHCpk4BjieDReLSkR5t+57CCleihSv/tZe65q7sfO6FNOELOnF6M5zaRhr1Yw
	sMvC7egu54jgLpRrf1+oRoSV6ogBWHVnUsCG5cYB6u6QSNzahYWvi0VqeBLm9UGHQA9YYb5kphe
	QJaR0CSHEi8ObhRwavsX/t66Pu9256lZkvqnFU4G+sGL7k1tqLKrNZZV+7w2WUTanQ137LJ5fve
	rE/hRIyMxNoWH5DwTYwl6UPlSwyIIWvxm8d7Q7o5WZtEZoqoLeA9yRTDfjgjZDbBA/bT62UoNBk
	23BrDcIV3afKhUQSt/D8s3iiGJgT5dQ=
X-Google-Smtp-Source: AGHT+IGJ3PDtM/43vWXCC0cF5aeFBeRUcz79hhv9m7sp4Xsbx/Vh9naI+GxiQ5/c5A05umj2CLzzHA==
X-Received: by 2002:a17:90b:2743:b0:2fa:17dd:6afa with SMTP id 98e67ed59e1d1-2fbf5c0f614mr17644772a91.17.1739513382401;
        Thu, 13 Feb 2025 22:09:42 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:8cb7:72db:3a5e:1287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad7c62sm2228797a91.29.2025.02.13.22.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 22:09:41 -0800 (PST)
Date: Fri, 14 Feb 2025 11:39:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	"open list:PCIE DRIVER FOR STARFIVE JH71x0" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: starfive: Fix kmemleak in StarFive PCIe driver's
 IRQ handling
Message-ID: <20250214060935.cgnc436upawnfzn6@thinkpad>
References: <20250208140110.2389-1-linux.amoon@gmail.com>
 <20250210174400.b63bhmtkuqhktb57@thinkpad>
 <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgQ20ANRh9wJ3E-T9yNi=g1g129mXq3cZYvPnK1bMx+w7g@mail.gmail.com>

On Tue, Feb 11, 2025 at 01:09:04AM +0530, Anand Moon wrote:
> Hi Manivannan
> 
> On Mon, 10 Feb 2025 at 23:14, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Sat, Feb 08, 2025 at 07:31:08PM +0530, Anand Moon wrote:
> > > kmemleak reported following debug log
> > >
> > > $ sudo cat /sys/kernel/debug/kmemleak
> > > unreferenced object 0xffffffd6c47c2600 (size 128):
> > >   comm "kworker/u16:2", pid 38, jiffies 4294942263
> > >   hex dump (first 32 bytes):
> > >     cc 7c 5a 8d ff ff ff ff 40 b0 47 c8 d6 ff ff ff  .|Z.....@.G.....
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >   backtrace (crc 4f07ff07):
> > >     __create_object+0x2a/0xfc
> > >     kmemleak_alloc+0x38/0x98
> > >     __kmalloc_cache_noprof+0x296/0x444
> > >     request_threaded_irq+0x168/0x284
> > >     devm_request_threaded_irq+0xa8/0x13c
> > >     plda_init_interrupts+0x46e/0x858
> > >     plda_pcie_host_init+0x356/0x468
> > >     starfive_pcie_probe+0x2f6/0x398
> > >     platform_probe+0x106/0x150
> > >     really_probe+0x30e/0x746
> > >     __driver_probe_device+0x11c/0x2c2
> > >     driver_probe_device+0x5e/0x316
> > >     __device_attach_driver+0x296/0x3a4
> > >     bus_for_each_drv+0x1d0/0x260
> > >     __device_attach+0x1fa/0x2d6
> > >     device_initial_probe+0x14/0x28
> > > unreferenced object 0xffffffd6c47c2900 (size 128):
> > >   comm "kworker/u16:2", pid 38, jiffies 4294942281
> > >
> > > This patch addresses a kmemleak reported during StarFive PCIe driver
> > > initialization. The leak was observed with kmemleak reporting
> > > unreferenced objects related to IRQ handling. The backtrace pointed
> > > to the `request_threaded_irq` and related functions within the
> > > `plda_init_interrupts` path, indicating that some allocated memory
> > > related to IRQs was not being properly freed.
> > >
> > > The issue was that while the driver requested IRQs, it wasn't
> > > correctly handling the lifecycle of the associated resources.
> >
> > What resources?
> >
> The Microchip PCIe host driver [1] handles  PCI, SEC, DEBUG, and LOCAL
> hardware events
> through a dedicated framework [2]. This framework allows the core driver [3]
> to monitor and wait for these specific events.
> 

Microchip driver also has its own 'event_ops' and 'event_irq_chip', so defining
'request_event_irq()' callback makes sense to me.

> [1]: https://github.com/torvalds/linux/blob/master/drivers/pci/controller/plda/pcie-microchip-host.c#L90-L292
> [2]: https://github.com/torvalds/linux/blob/master/drivers/pci/controller/plda/pcie-microchip-host.c#L374-L499
> [3]: https://github.com/torvalds/linux/blob/master/drivers/pci/controller/plda/pcie-plda-host.c#L448-L466
> 
> StarFive PCIe driver currently lacks the necessary `request_event_irq`
> implementation
> to integrate with this event-handling mechanism, which prevents the core driver
> from properly responding to these events on StarFive platforms.
> 
> static const struct plda_event mc_event = {
> .  request_event_irq = mc_request_event_irq,
>   .intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
>   .msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
> };
> 
> This patch implements dummy `request_event_irq` for the StarFive PCIe driver,
> Since the core [3] driver is monitoring for these events
> 

This still doesn't make sense to me. Under what condition you observed the
kmemleak? Since it points to devm_request_irq(), I can understand that the
memory allocated for the IRQ is not freed. But when does it happen?

> > > This patch introduces an event IRQ handler and the necessary
> > > infrastructure to manage these IRQs, preventing the memory leak.
> > >
> >
> > These handles appear pointless to me. What purpose are they serving?
> >
> Yes, you are correct, the core event monitoring framework [3] triggered a
> kernel memory leak. This patch adds a dummy IRQ callback as a
> placeholder for proper event handling, which can be implemented in a
> future patch.
> 

The dummy request_event_irq() callback is not supposed to be needed in the first
place. So clearly, this patch is not fixing the actual memory leak but trying to
cover it up.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

