Return-Path: <linux-kernel+bounces-385481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E29B37AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C492A1F23FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0521DF276;
	Mon, 28 Oct 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgIYAjas"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A901DE4D1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136698; cv=none; b=qiigrcIKMz/EE1HlG2tj+ybIGWGvzurDiVcqXt2966hkf3Ffy6HJgey0QtIme7mD+Gq0lsAFArZh9RxMwB2+lYRb9JLGBOTOlXtnSNK73tcBiAl9NMvpITihug2UeVmKx/efpxM22TkUh7CibVcAC71iaQv6livFLmUABkJfrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136698; c=relaxed/simple;
	bh=rfxuY3krSdeJD90i0XiLhAYyM3TlscAhrdX2CtNW5MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3dbZP7jp5grq1SKQf1euhOdKb4F8kwUDYPNMLkdSpX67ThFQxiHCV93U/+Z60L6VQpcZROYvHZguMDSNSPdxXrObjv5urj0HclAR+QLs1D+DDsF6DybKzmUrtyknHorgsaj1syd0jwNzR55Cuem+j5gZdKSv8oV5RCGQ/KV4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgIYAjas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B73BC4CEC3;
	Mon, 28 Oct 2024 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730136698;
	bh=rfxuY3krSdeJD90i0XiLhAYyM3TlscAhrdX2CtNW5MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pgIYAjasd25IPDv/s+zTfTP1EaLE2Qh/RBgGP3qf6/4CbqnQhf4Qa0XOVqqI3HVoF
	 UcJVGXk/l7Wopyg3wUarOugqabCgF1EtqRVdOSqO1K5HdqhYjDq55U/Z89ptaQGBO6
	 HrYclKKJ47pqSHBqTBU8MlkTuqRtsqLtNFOPwOkjXXt/xAIG20rh1wTu9NKcvh83Qk
	 xGsYdZBBaKvPmt1fbONqNedP43EzsaA4xvdEHk5qzw+f+Gqe3Re5XketKexZpRNBoy
	 rWGmaEWscGfqZUpgVfXMZp6WfsrSaK7mj+xPdIv8j1IV98qOtKaa9ZGtBeq7F5g0cg
	 5eNsJgFXcIwWQ==
Date: Mon, 28 Oct 2024 17:31:34 +0000
From: Will Deacon <will@kernel.org>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/dwc_pcie: Load DesignWare PCIe PMU driver
 automatically on Ampere SoCs
Message-ID: <20241028173132.GC2871@willie-the-truck>
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
 <20241008231824.5102-3-ilkka@os.amperecomputing.com>
 <20241024113201.GA30270@willie-the-truck>
 <617bffb7-9dee-6139-53d5-524ba03197f6@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617bffb7-9dee-6139-53d5-524ba03197f6@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 24, 2024 at 03:19:17PM -0700, Ilkka Koskinen wrote:
> 
> Hi Will,
> 
> On Thu, 24 Oct 2024, Will Deacon wrote:
> > On Tue, Oct 08, 2024 at 11:18:23PM +0000, Ilkka Koskinen wrote:
> > > Load DesignWare PCIe PMU driver automatically if the system has a PCI
> > > bridge by Ampere.
> > > 
> > > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > ---
> > >  drivers/perf/dwc_pcie_pmu.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > > index 3581d916d851..d752168733cf 100644
> > > --- a/drivers/perf/dwc_pcie_pmu.c
> > > +++ b/drivers/perf/dwc_pcie_pmu.c
> > > @@ -782,6 +782,16 @@ static void __exit dwc_pcie_pmu_exit(void)
> > >  module_init(dwc_pcie_pmu_init);
> > >  module_exit(dwc_pcie_pmu_exit);
> > > 
> > > +static const struct pci_device_id dwc_pcie_pmu_table[] = {
> > > +	{
> > > +		PCI_DEVICE(PCI_VENDOR_ID_AMPERE, PCI_ANY_ID),
> > > +		.class		= PCI_CLASS_BRIDGE_PCI_NORMAL,
> > > +		.class_mask	= ~0,
> > > +	},
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(pci, dwc_pcie_pmu_table);
> > 
> > Hmm, won't this only work if the driver is modular? Should we be calling
> > pci_register_driver() for the builtin case?
> 
> That would be the normal case indeed. However, this driver is quite
> different: dwc_pcie_pmu_init() goes through all the pci devices looking for
> root ports with the pmu capabilities. Moreover, the probe function isn't
> bound to any specific vendor/class/device IDs. This patch simply makes sure
> the driver is loaded and the init function gets called, if the driver was
> built as module and ran on Ampere system.

Ok, but that seems like the wrong approach, no? We end up with a weird
list of vendors who want the thing to probe on their SoCs and, by
omission, everybody not on the list doesn't want that behaviour.

Will

