Return-Path: <linux-kernel+bounces-558784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105CA5EB15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79DF189CF5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AA58635C;
	Thu, 13 Mar 2025 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHhMC3v0"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538321F91C8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843282; cv=none; b=mD6DDHQkegV9vHd8ERnEij2BGVIuGVwUU5HGn4JS7zndQUVqy7a3BUlOGBcnvIc6M+8qqquHD7VhGWz7jLWg5yBDL9u2PxWw0wuTHWOjX/1yzFe+zpqjAkaLQpSXVPc81amwfqBSiapo6fr5f6wtyKyS/t/r3+yHHAkcU9e3kfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843282; c=relaxed/simple;
	bh=gFwffsQzb/cJfYSzSS8hPanR8ty88+Ggwv5m6optr2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVfV5mzMUofpvXCKM5BFh4BF8PtqebBv9mO3WF7aHxkSvJ+SfDwQ5XxbdubOihz1ROawuBxaAPZnjh5lTs3PFNQdQXl5/5JpZxqeyRfg70nnphiV7Z2O8XF7t3v37izuGdRespQ16rz2ayl+jYWcLlyC/djAwSFHyD/IYiQYHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZHhMC3v0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2feb91a2492so1058693a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741843279; x=1742448079; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8yNqvLt5oEQHYkK1eOTExajEl3vcVdor7sMMhH7Zdg=;
        b=ZHhMC3v0rCPbpkFCr1fcIqpbfeHCzMKhelTEpGxRosQ1eFP94x983tj0Ls4Binf6RO
         leTjMfwwUdaZU4goqXK3qX11Sr8Y4V1ijHuho4weSK7qCLQmlY/1QUOBgHroe+hNKH6Y
         lg32ZKxwyOXHwMuj5dhgZEoMgjNnEpdP0r+yiP5sF0wf3Xjo5TdtlnyLiO9Q2b/z3FjE
         U77yR/EcOwLQz2u4elrnWlEpKoECpGOQs0s73Gj/TF1MRqD9TRa4PpEthNjhtV6a6D7k
         y0cHMNhbWpf4b+hO2ohmrH2mL+QDobK6gkjt91bG3/iXNVl+f+HZsYWi+Gtezp1NJ6N6
         WSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741843279; x=1742448079;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8yNqvLt5oEQHYkK1eOTExajEl3vcVdor7sMMhH7Zdg=;
        b=E4B/fZiY1acNapZviFaQMJ+EaHDBL4Do97z+hZgdZd0wKGoWbLG0HJoVQdzRAWHPdM
         eSkUUq7L3fXTnCOWI/TxO0GtCWxvp11q7v9xNj6AutUOzDZT+YbP+KILnS4VC81c0gDD
         ixoXVXpNJuhagbUg5SWmTR408e0ZJq7FF7rdB+I4Xfvc+8YiuFbDN4UybfAsqHZTwico
         Vvqix+qWqkR5e4PDcGFroImhT3q9FwD6DU2R8roG1PYl9zFwXp9WtJtxID8iESABB4Z/
         1Rx0pNJn0nA7M8VPq0MDeqfrSNYLApCG8yKx0dsjLK+NL5pFAWnigLwTulYJo2IzOU65
         xmdw==
X-Forwarded-Encrypted: i=1; AJvYcCUZG2G9Mz4S6KFVFaGgstMBTTFh2QcLYWMcNe/Y+A+xps1kZJ9K7Kx3WA9bWm3PIay2XqxOXu35etwOl6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IAj37OGl6HTzX9e72j6TwZhyfsawqcvwQ4RkSHXl0AjQ0Gws
	55fcs1KrEFI+RXQGn5NcyKTiitQm2nk/22tzMbYgq7KUl6zQiZIY47MbKnGqiw==
X-Gm-Gg: ASbGncsKdNRhFngV/BN8EU83BRtawT8JKZ1XLonQJ4r8xay+qhVsbrNPMUVMBpDzvje
	DqMDZTEyuNxB7HLg9ghPi2Cu0E8LDULlVa6NAmgCYAPmr9u+s02uuijmBVPfkrY7ZfNRZ2WFmm1
	fO+fXU3eRxP+C7drGAYp3TiRYPxmk9LI6c2pM7YpnuvwqipCFXms9KtA+XOnrBHEKnkQtgP8Ux7
	x/pgNfRqUi1YcftzhYfu0XQec/CNlnCnciP+nv9HJ44wSLD+Sw2Gqa7WiJ1b50Oxsx9DL60EMTr
	jwyvCYknh42vDBlC1nWVcpUAKVM8sKSQH9VWTSmcaU2at9IkqrKmAnjfKdU0XE/U
X-Google-Smtp-Source: AGHT+IGJv+yVy6DjWbU63JeAOolaCz8Rmjdu6FwGn4BuJFg1ddJT5+2ll86BAu15CdYhaEnIqui/ng==
X-Received: by 2002:a17:90b:2782:b0:2f4:4500:bb4d with SMTP id 98e67ed59e1d1-2ff7ce8b5f4mr34904885a91.20.1741843279457;
        Wed, 12 Mar 2025 22:21:19 -0700 (PDT)
Received: from thinkpad ([120.60.60.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd7bb4sm4729245ad.237.2025.03.12.22.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 22:21:18 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:51:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <20250313052113.zk5yuz5e76uinbq5@thinkpad>
References: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
 <20250228174509.GA58365@bhelgaas>
 <Z8IC_WDmix3YjOkv@google.com>
 <CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com>

On Wed, Mar 05, 2025 at 02:41:26PM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 28, 2025 at 7:40 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > Hi Bjorn,
> >
> > On Fri, Feb 28, 2025 at 11:45:09AM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 26, 2024 at 03:17:11PM -0800, Brian Norris wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >
> > > > Unlike ACPI based platforms, there are no known issues with D3Hot for
> > > > the PCI bridges in Device Tree based platforms.
> > >
> > > Can we elaborate on this a little bit?  Referring to "known issues
> > > with ACPI-based platforms" depends on a lot of domain-specific history
> > > that most readers (including me) don't know.
> >
> > Well, to me, the background here is simply the surrounding code context,
> > and the past discussions that I linked:
> >
> > https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/
> >
> > The whole reason we need this patch is that:
> > (a) there's some vaguely specified reason this function (which prevents
> >     standard-specified behavior) exists; and
> > (b) that function includes a condition that allows all systems with a
> >     DMI/BIOS newer than year 2015 to use this feature.
> >
> > Digging a bit further, it seems like maybe the only reason this feature
> > is prevented on DT systems is from commit ("9d26d3a8f1b0 PCI: Put PCIe
> > ports into D3 during suspend"), where the subtext is that it was written
> > by and for Intel in 2016, with an arbitrary time-based cutoff ("year
> > this was being developed") that only works for DMI systems. DT systems
> > do not tend to support DMI.
> >
> > If any of this is what you're looking for, I can try to
> > copy/paste/summarize a few more of those bits, if it helps.
> >
> > > I don't think "ACPI-based" or "devicetree-based" are good
> > > justifications for changing the behavior because they don't identify
> > > any specific reasons.  It's like saying "we can enable this feature
> > > because the platform spec is written in French."
> >
> > AIUI, It's involved because of the general strategy of this function
> > (per its comments, "recent enough PCIe ports"). So far, it sounds like
> > that reason (presumably, old BIOS with poor power management code)
> > doesn't really apply to a system based on device tree, where the power
> > management code is mostly/entirely in the OS.
> 
> No, it was about PCIe hardware failing to handle PM correctly on ports.
> 
> > But really, the original commit doesn't actually state reasons, so maybe
> > the "known issues" phrasing could be weakened a bit, to avoid implying
> > there were any stated reasons.
> 
> There were hardware issues related to PM on x86 platforms predating
> the introduction of Connected Standby in Windows.  For instance,
> programming a port into D3hot by writing to its PMCSR might cause the
> PCIe link behind it to go down and the only way to revive it was to
> power cycle the Root Complex.  And similar.
> 
> Also, PM has never really worked correctly on PCI (non-PCIe) bridges
> and there is this case where the platform firmware handles hotplug and
> doesn't want the OS to get in the way (the bridge->is_hotplug_bridge
> && !pciehp_is_native(bridge) check in pci_bridge_d3_possible()).
> 
> The DMI check at the end of pci_bridge_d3_possible() is really
> something to the effect of "there is no particular reason to prevent
> this bridge from going into D3, but try to avoid platforms where it
> may not work".
> 

Thanks for sharing the background. This could go in the commit message IMO.

> Basically, as far as I'm concerned, this check can be changed into
> something like
> 
> if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
>         return true;
> 
> which also requires updating the comment above it accordingly.
> 
> This would have been better than the check added by the $subject patch IMV.

Looks good to me. Brian, could you please respin incorporating the comments?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

