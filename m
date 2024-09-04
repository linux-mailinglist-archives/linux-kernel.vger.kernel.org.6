Return-Path: <linux-kernel+bounces-315900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D7D96C855
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577AFB22AC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7841482F6;
	Wed,  4 Sep 2024 20:24:58 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB911448E4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481498; cv=none; b=Ct/V1LHxQtPkpl60CxSZOr85TmIeIguEHM6XNDsLM7gVAWANnklNJ1/xFlxz/U74g8XYR9KImXa2AR9sIRTad5LvmqbuIQ+UfaX3sbHWpMwYGoA6JU5SFxTf0ZfFAOdVwT6YPfW91cttCoMJJ8uuaJ1KpbAiS4APfLGq3HYqzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481498; c=relaxed/simple;
	bh=iGneDPgEDlQeqkQPamzvDWY3vvyWNku/XjBXEJT2th8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRduZXfxtRsTqPifaAmXFEcWvd2P/qeHt5c710GLvGEtNF0cOjicdIuyhuIpd//BdkTqFTcBTp0jh6nwiqNjO3ozPNLom8YoQ87+TvCchsTFQRVtKQKJWRC+oFHUMAzseQX/II8v33ROC+62GymV9SZoHTc/fp2SJBDfbYCLeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id be5d3e32-6afb-11ef-825d-005056bdfda7;
	Wed, 04 Sep 2024 23:24:53 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 23:24:53 +0300
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
References: <20240725120729.59788-2-pstanner@redhat.com>
 <20240903094431.63551744.alex.williamson@redhat.com>
 <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
 <24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
 <dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
 <20240904120721.25626da9.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904120721.25626da9.alex.williamson@redhat.com>

Wed, Sep 04, 2024 at 12:07:21PM -0600, Alex Williamson kirjoitti:
> On Wed, 04 Sep 2024 15:37:25 +0200
> Philipp Stanner <pstanner@redhat.com> wrote:
> > On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:

...

> > If vfio-pci can get rid of pci_intx() alltogether, that might be a good
> > thing. As far as I understood Andy Shevchenko, pci_intx() is outdated.
> > There's only a hand full of users anyways.
> 
> What's the alternative?

From API perspective the pci_alloc_irq_vectors() & Co should be used.

> vfio-pci has a potentially unique requirement
> here, we don't know how to handle the device interrupt, we only forward
> it to the userspace driver.  As a level triggered interrupt, INTx will
> continue to assert until that userspace driver handles the device.
> That's obviously unacceptable from a host perspective, so INTx is
> masked at the device via pci_intx() where available, or at the
> interrupt controller otherwise.  The API with the userspace driver
> requires that driver to unmask the interrupt, again resulting in a call
> to pci_intx() or unmasking the interrupt controller, in order to receive
> further interrupts from the device.  Thanks,

I briefly read the discussion and if I understand it correctly the problem here
is in the flow: when the above mentioned API is being called. Hence it's design
(or architectural) level of issue and changing call from foo() to bar() won't
magically make problem go away. But I might be mistaken.

-- 
With Best Regards,
Andy Shevchenko



