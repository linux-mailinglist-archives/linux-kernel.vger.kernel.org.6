Return-Path: <linux-kernel+bounces-432913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5529C9E51EB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07571673C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1020B219;
	Thu,  5 Dec 2024 09:59:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA36820ADD2;
	Thu,  5 Dec 2024 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392753; cv=none; b=RmsI47Tf9EYSo3rVemv4T88bS824pDLNFNIRonss2atTWKYcYvASXMOZERxBYU+ZyQq+zR0YHmS/QY2dT8usAHuwBJIcw/b6idW4gqbnHnsH5fmDexh3tZksuWIeVPGJdrXgqulyZiyfoWIdUQNluLE+Pbm3QEzYqKn3Wvi+8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392753; c=relaxed/simple;
	bh=H/OuEMnsAyLfA919I/SNsIvUApAWXvOYm38Ic1B9zaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmPEX4fx/3V87Xj/p2xnkJLvhcs7hTjxlDKmwVXhd0l9wXapYiBdMGiErCHveoOZIogVTQIxm29rebauw2Hb1rZZO7b5PVGKw+bHqyVKd7sPA25oReNgueKVf9RJQq46+BXY6hgURaWBsLPU70Buu5DlnWhrNKX0iqn2iftwzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC77BFEC;
	Thu,  5 Dec 2024 01:59:37 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 338E03F5A1;
	Thu,  5 Dec 2024 01:59:08 -0800 (PST)
Date: Thu, 5 Dec 2024 09:59:05 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: fvp: Update bus-range property
Message-ID: <Z1F5aeNT-0KFOVHf@bogus>
References: <20241128152543.1821878-1-aneesh.kumar@kernel.org>
 <Z1CwGaAh714XfILz@e110455-lin.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1CwGaAh714XfILz@e110455-lin.cambridge.arm.com>

On Wed, Dec 04, 2024 at 07:40:09PM +0000, Liviu Dudau wrote:
> On Thu, Nov 28, 2024 at 08:55:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > These days, the Fixed Virtual Platforms(FVP) Base RevC model supports
> > more PCI devices. Update the max bus number so that Linux can enumerate
> > them correctly. Without this, the kernel throws the below error while
> > booting with the default hierarchy
> > 
> > pci_bus 0000:01: busn_res: [bus 01] end is updated to 01
> > pci_bus 0000:02: busn_res: can not insert [bus 02-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > pci_bus 0000:02: busn_res: [bus 02-01] end is updated to 02
> > pci_bus 0000:02: busn_res: can not insert [bus 02] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > pci_bus 0000:03: busn_res: can not insert [bus 03-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > pci_bus 0000:03: busn_res: [bus 03-01] end is updated to 03
> > pci_bus 0000:03: busn_res: can not insert [bus 03] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > pci_bus 0000:04: busn_res: can not insert [bus 04-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > pci_bus 0000:04: busn_res: [bus 04-01] end is updated to 04
> > pci_bus 0000:04: busn_res: can not insert [bus 04] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > pci 0000:00:01.0: BAR 14: assigned [mem 0x50000000-0x500fffff]
> > 
> > The change is using 0xff as max bus nr because the ECAM window is 256MB in size.
> > 
> > pci-host-generic 40000000.pci: ECAM at [mem 0x40000000-0x4fffffff] for [bus 00-01]
> > 
> > lspci output with and without the change
> > without fix:
> > 00:00.0 Host bridge: ARM Device 00ba (rev 01)
> > 00:01.0 PCI bridge: ARM Device 0def
> > 00:02.0 PCI bridge: ARM Device 0def
> > 00:03.0 PCI bridge: ARM Device 0def
> > 00:04.0 PCI bridge: ARM Device 0def
> > 00:1e.0 Unassigned class [ff00]: ARM Device ff80
> > 00:1e.1 Unassigned class [ff00]: ARM Device ff80
> > 00:1f.0 SATA controller: Device 0abc:aced (rev 01)
> > 01:00.0 SATA controller: Device 0abc:aced (rev 01)
> > 
> > with fix:
> > 00:00.0 Host bridge: ARM Device 00ba (rev 01)
> > 00:01.0 PCI bridge: ARM Device 0def
> > 00:02.0 PCI bridge: ARM Device 0def
> > 00:03.0 PCI bridge: ARM Device 0def
> > 00:04.0 PCI bridge: ARM Device 0def
> > 00:1e.0 Unassigned class [ff00]: ARM Device ff80
> > 00:1e.1 Unassigned class [ff00]: ARM Device ff80
> > 00:1f.0 SATA controller: Device 0abc:aced (rev 01)
> > 01:00.0 SATA controller: Device 0abc:aced (rev 01)
> > 02:00.0 Unassigned class [ff00]: ARM Device ff80
> > 02:00.4 Unassigned class [ff00]: ARM Device ff80
> > 03:00.0 PCI bridge: ARM Device 0def
> > 04:00.0 PCI bridge: ARM Device 0def
> > 04:01.0 PCI bridge: ARM Device 0def
> > 04:02.0 PCI bridge: ARM Device 0def
> > 05:00.0 SATA controller: Device 0abc:aced (rev 01)
> > 06:00.0 Unassigned class [ff00]: ARM Device ff80
> > 06:00.7 Unassigned class [ff00]: ARM Device ff80
> > 07:00.0 Unassigned class [ff00]: ARM Device ff80
> > 07:00.3 Unassigned class [ff00]: ARM Device ff80
> > 08:00.0 Unassigned class [ff00]: ARM Device ff80
> > 08:00.1 Unassigned class [ff00]: ARM Device ff80
> > 
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Sudeep, can you please take this patch through your tree?
>

I have already queued and must be in -next, just didn't get to a point to
respond as applied yet. I will update with your tags. Thanks!

-- 
Regards,
Sudeep

