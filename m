Return-Path: <linux-kernel+bounces-386980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D949B4A67
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81931F23711
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA367205ADB;
	Tue, 29 Oct 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thI+2tDJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B77206071
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206821; cv=none; b=HApqka/a8keW73E9Zz9fM+kCT0AB2awjw39GbqTlwVUcnbhzfcrNxCP+Pr+bTW594eVr1mNOnEMAkM8G/3lHc6p0jfDjUaqDbDyeobTfL0pKiBiTeQxmQSBKtVvpnN5WMEPd4K6W4ggddmNJwG+qT4GrWSmpenD3uj6FhjM3xGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206821; c=relaxed/simple;
	bh=zLYXpgpMQVfXCNfwLkVW2MPfK+Hfl05kXDqCsCOBpSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjrTCf5d+i/0wJn6Aus0qiaY62+ZEGBDZfkZeSz1JM8OyrURxbHWTF0jNOKY1jKSQKVACgxASBq1Jd8ZEaPdqKZed7yu04Px7JJJ3I7gt3BPKTXm4LYNNCKaulHQTUYm+5y95jd8w/yjSC/0PFR/oBXi9zh0vTvcf4xr6K6yuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thI+2tDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781BBC4CECD;
	Tue, 29 Oct 2024 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730206819;
	bh=zLYXpgpMQVfXCNfwLkVW2MPfK+Hfl05kXDqCsCOBpSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thI+2tDJHryyPY74ABSmzjllb9F6VLelDwhBcGxqZWGzVgbm2Az9z9djtx/2BmtUQ
	 yMc1n+Z3p9wt/c6fzHqpyRboyG0UTZNDqPGHW6bZbkRJAIM27jbGDSrRCLJmuHPmlW
	 Ut5cxWQ5sE6+JIRtJM2Ku40rTyNkqAXW8EtlN/YvomME9+yy/Nro+O9+rhmYTSANbB
	 mgn9QgHaPHlLRGFS7EznP6zDoGQQ7L1erUe3tow1yZoCiOV+/glc4t0471s5NbhAat
	 YeMT8ylr1Mb6u8tDHnsMCPXpTunNzFI9DNqdIpfHirrvtpxdnu7TNz19zdITfhGk9M
	 Qs4kA8ZK7vGrA==
Date: Tue, 29 Oct 2024 13:00:15 +0000
From: Will Deacon <will@kernel.org>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/dwc_pcie: Load DesignWare PCIe PMU driver
 automatically on Ampere SoCs
Message-ID: <20241029130014.GC4241@willie-the-truck>
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
 <20241008231824.5102-3-ilkka@os.amperecomputing.com>
 <20241024113201.GA30270@willie-the-truck>
 <617bffb7-9dee-6139-53d5-524ba03197f6@os.amperecomputing.com>
 <20241028173132.GC2871@willie-the-truck>
 <722266ba-1572-2c2b-87d6-dc4f8ec9a274@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722266ba-1572-2c2b-87d6-dc4f8ec9a274@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Oct 28, 2024 at 08:27:27PM -0700, Ilkka Koskinen wrote:
> 
> On Mon, 28 Oct 2024, Will Deacon wrote:
> > On Thu, Oct 24, 2024 at 03:19:17PM -0700, Ilkka Koskinen wrote:
> > > 
> > > Hi Will,
> > > 
> > > On Thu, 24 Oct 2024, Will Deacon wrote:
> > > > On Tue, Oct 08, 2024 at 11:18:23PM +0000, Ilkka Koskinen wrote:
> > > > > Load DesignWare PCIe PMU driver automatically if the system has a PCI
> > > > > bridge by Ampere.
> > > > > 
> > > > > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > > > ---
> > > > >  drivers/perf/dwc_pcie_pmu.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > > > > index 3581d916d851..d752168733cf 100644
> > > > > --- a/drivers/perf/dwc_pcie_pmu.c
> > > > > +++ b/drivers/perf/dwc_pcie_pmu.c
> > > > > @@ -782,6 +782,16 @@ static void __exit dwc_pcie_pmu_exit(void)
> > > > >  module_init(dwc_pcie_pmu_init);
> > > > >  module_exit(dwc_pcie_pmu_exit);
> > > > > 
> > > > > +static const struct pci_device_id dwc_pcie_pmu_table[] = {
> > > > > +	{
> > > > > +		PCI_DEVICE(PCI_VENDOR_ID_AMPERE, PCI_ANY_ID),
> > > > > +		.class		= PCI_CLASS_BRIDGE_PCI_NORMAL,
> > > > > +		.class_mask	= ~0,
> > > > > +	},
> > > > > +	{ }
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(pci, dwc_pcie_pmu_table);
> > > > 
> > > > Hmm, won't this only work if the driver is modular? Should we be calling
> > > > pci_register_driver() for the builtin case?
> > > 
> > > That would be the normal case indeed. However, this driver is quite
> > > different: dwc_pcie_pmu_init() goes through all the pci devices looking for
> > > root ports with the pmu capabilities. Moreover, the probe function isn't
> > > bound to any specific vendor/class/device IDs. This patch simply makes sure
> > > the driver is loaded and the init function gets called, if the driver was
> > > built as module and ran on Ampere system.
> > 
> > Ok, but that seems like the wrong approach, no? We end up with a weird
> > list of vendors who want the thing to probe on their SoCs and, by
> > omission, everybody not on the list doesn't want that behaviour.
> 
> Ideally, dwc pmu driver would claim the supported root ports but I think the
> PCIe driver is doing that. How about if we simply drop the auto loading
> patch and let users to manually load the driver as they have been doing so
> far?

Sure, I'll pick the other two up. Thanks!

Will

