Return-Path: <linux-kernel+bounces-433446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C120A9E587E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA17E18854A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4507321A44B;
	Thu,  5 Dec 2024 14:27:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AADA217F50;
	Thu,  5 Dec 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408849; cv=none; b=Nmu3CtI2Dz6M4Z3prFD34/joONDHdO6gDB6acPKPnK0ZC0ZYluQyKq5gdVLqo4MJjCqOmumEudCqFOiTc8W/mcXs4msaWm6IAXpNq7DLUY9PupUGuKelCuBBssV7ALvFo1LdywoqTq+fixmTWjwNEmGD9Mp9pVgQNwc0G0TTdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408849; c=relaxed/simple;
	bh=6jvY1TGlZAQLgaOJ/U1KDMJOJn103xAHj0ddui9cQNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlP2vT+AXoM3G0SSbFGeLn+H8aeVgSJRBI1//nH+TKvcyBG46wSSwvHyt67G+1XdwKUkiXWzIaBmActB0AZpeBvEBMOalXxjq99uJm8rwFicQ+k6nBEbHPaDdcdH+MvtCnmyreHGo4qguAcQ3wO61NEVfELhkmru5oZyC1SXC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A45661063;
	Thu,  5 Dec 2024 06:27:55 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 659BF3F5A1;
	Thu,  5 Dec 2024 06:27:26 -0800 (PST)
Date: Thu, 5 Dec 2024 14:27:24 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: fvp: Update bus-range property
Message-ID: <Z1G4TCY9ekezAc8Y@bogus>
References: <20241128152543.1821878-1-aneesh.kumar@kernel.org>
 <173339457335.691023.1334271427632194234.b4-ty@arm.com>
 <Z1GxQHY1XkQcPFc0@e110455-lin.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1GxQHY1XkQcPFc0@e110455-lin.cambridge.arm.com>

On Thu, Dec 05, 2024 at 01:57:20PM +0000, Liviu Dudau wrote:
> On Thu, Dec 05, 2024 at 10:31:03AM +0000, Sudeep Holla wrote:
> > On Thu, 28 Nov 2024 20:55:43 +0530, Aneesh Kumar K.V (Arm) wrote:
> > > These days, the Fixed Virtual Platforms(FVP) Base RevC model supports
> > > more PCI devices. Update the max bus number so that Linux can enumerate
> > > them correctly. Without this, the kernel throws the below error while
> > > booting with the default hierarchy
> > >
> > > pci_bus 0000:01: busn_res: [bus 01] end is updated to 01
> > > pci_bus 0000:02: busn_res: can not insert [bus 02-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > > pci_bus 0000:02: busn_res: [bus 02-01] end is updated to 02
> > > pci_bus 0000:02: busn_res: can not insert [bus 02] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > > pci_bus 0000:03: busn_res: can not insert [bus 03-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > > pci_bus 0000:03: busn_res: [bus 03-01] end is updated to 03
> > > pci_bus 0000:03: busn_res: can not insert [bus 03] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > > pci_bus 0000:04: busn_res: can not insert [bus 04-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > > pci_bus 0000:04: busn_res: [bus 04-01] end is updated to 04
> > > pci_bus 0000:04: busn_res: can not insert [bus 04] under [bus 00-01] (conflicts with (null) [bus 00-01])
> > > pci 0000:00:01.0: BAR 14: assigned [mem 0x50000000-0x500fffff]
> > >
> > > [...]
> > 
> > Applied to sudeep.holla/linux (for-next/juno/fixes), thanks!
> > 
> > [1/1] arm64: dts: fvp: Update bus-range property
> >       https://git.kernel.org/sudeep.holla/c/4f776d81bf92
> 
> Thanks for the quick response. TBH, I did not receive your initial review
> email, that's why I've messaged thinking it got lost.

No I hadn't responded on the list yet. I queue and wait for a day for the
kbuild bot or any other bots to report no failures before I officially respond
as applied as I wouldn't have tried all build configs in general but it
doesn't apply for DT files though 😉.

--
Regards,
Sudeep

