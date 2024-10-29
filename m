Return-Path: <linux-kernel+bounces-387227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1C39B4E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CE6282908
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42679194A63;
	Tue, 29 Oct 2024 15:39:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AA2BAF9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216384; cv=none; b=b07imjAjTkD2/jJT7CviMmGnRGw9qmZ6H4XWpfGk9/Gnd0HsWAVhSr5r0/N7fdTT0p/HQpUoi9rlRejImYTCDDOU8MyP111eEI4vYzR81Lh3pRq5g5lL3kfF0dbpPWqA6lgbbvQwoRa3fPsPZSQ5PQvAaufEn0pYX9t5uhfJ5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216384; c=relaxed/simple;
	bh=qjhe3wVVZfsbSrhZcWJPZ5Cy722qDtJMC74PgpZq/SE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYwaHx+MclYDOEejCInj1V7njb8lkkTQKNvSK96OdSWp5fWY/mqHY7qcJcLk1vRuDtOOo/GJLqJaNbILk4MKVI08hRUuhcwQSRRSPYZQrv+jFxNXCl01kOpYAuOZN1w3jdV4IIANCrwxK+DApP7j6Ib/1PEfFkaRQbiQQFGZm10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdDtR2nVrz6D8YT;
	Tue, 29 Oct 2024 23:38:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 078B7140393;
	Tue, 29 Oct 2024 23:39:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Oct
 2024 16:39:38 +0100
Date: Tue, 29 Oct 2024 15:39:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Will Deacon <will@kernel.org>
CC: Ilkka Koskinen <ilkka@os.amperecomputing.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, "Mark
 Rutland" <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] perf/dwc_pcie: Load DesignWare PCIe PMU driver
 automatically on Ampere SoCs
Message-ID: <20241029153936.00004d59@Huawei.com>
In-Reply-To: <20241029130014.GC4241@willie-the-truck>
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
	<20241008231824.5102-3-ilkka@os.amperecomputing.com>
	<20241024113201.GA30270@willie-the-truck>
	<617bffb7-9dee-6139-53d5-524ba03197f6@os.amperecomputing.com>
	<20241028173132.GC2871@willie-the-truck>
	<722266ba-1572-2c2b-87d6-dc4f8ec9a274@os.amperecomputing.com>
	<20241029130014.GC4241@willie-the-truck>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Oct 2024 13:00:15 +0000
Will Deacon <will@kernel.org> wrote:

> On Mon, Oct 28, 2024 at 08:27:27PM -0700, Ilkka Koskinen wrote:
> > 
> > On Mon, 28 Oct 2024, Will Deacon wrote:  
> > > On Thu, Oct 24, 2024 at 03:19:17PM -0700, Ilkka Koskinen wrote:  
> > > > 
> > > > Hi Will,
> > > > 
> > > > On Thu, 24 Oct 2024, Will Deacon wrote:  
> > > > > On Tue, Oct 08, 2024 at 11:18:23PM +0000, Ilkka Koskinen wrote:  
> > > > > > Load DesignWare PCIe PMU driver automatically if the system has a PCI
> > > > > > bridge by Ampere.
> > > > > > 
> > > > > > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > > > > ---
> > > > > >  drivers/perf/dwc_pcie_pmu.c | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > > > > > index 3581d916d851..d752168733cf 100644
> > > > > > --- a/drivers/perf/dwc_pcie_pmu.c
> > > > > > +++ b/drivers/perf/dwc_pcie_pmu.c
> > > > > > @@ -782,6 +782,16 @@ static void __exit dwc_pcie_pmu_exit(void)
> > > > > >  module_init(dwc_pcie_pmu_init);
> > > > > >  module_exit(dwc_pcie_pmu_exit);
> > > > > > 
> > > > > > +static const struct pci_device_id dwc_pcie_pmu_table[] = {
> > > > > > +	{
> > > > > > +		PCI_DEVICE(PCI_VENDOR_ID_AMPERE, PCI_ANY_ID),
> > > > > > +		.class		= PCI_CLASS_BRIDGE_PCI_NORMAL,
> > > > > > +		.class_mask	= ~0,
> > > > > > +	},
> > > > > > +	{ }
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(pci, dwc_pcie_pmu_table);  
> > > > > 
> > > > > Hmm, won't this only work if the driver is modular? Should we be calling
> > > > > pci_register_driver() for the builtin case?  
> > > > 
> > > > That would be the normal case indeed. However, this driver is quite
> > > > different: dwc_pcie_pmu_init() goes through all the pci devices looking for
> > > > root ports with the pmu capabilities. Moreover, the probe function isn't
> > > > bound to any specific vendor/class/device IDs. This patch simply makes sure
> > > > the driver is loaded and the init function gets called, if the driver was
> > > > built as module and ran on Ampere system.  
> > > 
> > > Ok, but that seems like the wrong approach, no? We end up with a weird
> > > list of vendors who want the thing to probe on their SoCs and, by
> > > omission, everybody not on the list doesn't want that behaviour.  
> > 
> > Ideally, dwc pmu driver would claim the supported root ports but I think the
> > PCIe driver is doing that. How about if we simply drop the auto loading
> > patch and let users to manually load the driver as they have been doing so
> > far?  

Yup. The PCIe portdrv binds to the port.  Lots of work needed to clean that
up and make it extensible. Maybe we can then kick this PMU driver off from
there once it's done.

Jonathan

> 
> Sure, I'll pick the other two up. Thanks!
> 
> Will
> 


