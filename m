Return-Path: <linux-kernel+bounces-196939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F168D63EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CE41F26698
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F282515B106;
	Fri, 31 May 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BEmMZTXQ"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600C155C8E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164223; cv=none; b=RZbXG1X8c7cdEjuZJ0dUdocuwyGCWCkR82WNG8IFx9xVYIQ9aorG/gE1YYIJdpSNsVemRq1UB9XDuOpWiBXmNjFvT2Zr34Ea6L77c2aJV0gEtmKe7WDPkk7Vt2O2i+G4m17Jf6dHwaoSyIdYGGPEJtxt+/j550ZxqOYkKJJKoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164223; c=relaxed/simple;
	bh=KRdjPOiSmKhnbpqLsAUL50Sh5xQVBDWcZuPxhkr37Hg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lps/CTAulYPCxNWTZlOVtxbbCHNslaxVVfLOXJu1hfG4xSVwCTPyjY7WqMJ28qwKHQH7hsTtpz4I8YYdf4GkxHk6DKJ/S7LE11zgVKRLnQ7ku27IAfEThIxZRCfGL0PCM7Bn6knBxadXqj8hTNgLKlemdu+H/1WWdX3NQ94pUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BEmMZTXQ; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717164222; x=1748700222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FHDVmJVmJipFUzztrcQUetQex5rFg7uI0/X/xngjWQQ=;
  b=BEmMZTXQhIbvTnk2WrnjhuB3G3rxnCN9ii+7n8sAcw4kxfSaoR/fn8sX
   QHSpLXuYhfAxSAGwQbs/ejWhlTsrgdbOpu6ZPyUoJolQtOl1Od1Ez75BU
   ZeZ6NMxzbe/lU5SrMv/1KbSEVIB2eLBx0jRWYXrIvZDiwM+Zxi3dp5W6/
   0=;
X-IronPort-AV: E=Sophos;i="6.08,204,1712620800"; 
   d="scan'208";a="300045662"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 14:03:39 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:63734]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.97:2525] with esmtp (Farcaster)
 id fe2e9d2c-9cd6-4ea6-9f94-22312cbd41d6; Fri, 31 May 2024 14:03:37 +0000 (UTC)
X-Farcaster-Flow-ID: fe2e9d2c-9cd6-4ea6-9f94-22312cbd41d6
Received: from EX19D008EUA004.ant.amazon.com (10.252.50.158) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 14:03:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D008EUA004.ant.amazon.com (10.252.50.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 14:03:37 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 31 May 2024 14:03:36
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 3002320BED; Fri, 31 May 2024 14:03:36 +0000 (UTC)
Date: Fri, 31 May 2024 14:03:36 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Marc Zyngier <maz@kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>,
	Thomas Gleixner <tglx@linutronix.de>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<hagarhem@amazon.de>
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Fix potential race condition in
 its_vlpi_prop_update()
Message-ID: <20240531140336.GA4911@amazon.com>
References: <20240531074302.30563-1-hagarhem@amazon.com>
 <86ttiel4bb.wl-maz@kernel.org>
 <20240531095318.GA5556@amazon.com>
 <87mso62rz0.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87mso62rz0.wl-maz@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, May 31, 2024 at 11:30:59AM +0100, Marc Zyngier wrote:
> On Fri, 31 May 2024 10:53:18 +0100,
> Hagar Hemdan <hagarhem@amazon.com> wrote:
> > 
> > On Fri, May 31, 2024 at 10:27:04AM +0100, Marc Zyngier wrote:
> > > On Fri, 31 May 2024 08:43:02 +0100,
> > > Hagar Hemdan <hagarhem@amazon.com> wrote:
> > > > 
> > > > its_vlpi_prop_update() calls lpi_write_config() which obtains the
> > > > mapping information for a VLPI without lock held. So it could race
> > > > with its_vlpi_unmap().
> > > > Since all calls from its_irq_set_vcpu_affinity() require the same
> > > > lock to be held. So instead of peppering the locking all over the
> > > > place, we hoist the locking into its_irq_set_vcpu_affinity().
> > > > 
> > > > This bug was discovered and resolved using Coverity Static Analysis
> > > > Security Testing (SAST) by Synopsys, Inc.
> > > > 
> > > > Fixes: 015ec0386ab6 ("irqchip/gic-v3-its: Add VLPI configuration handling")
> > > > Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> > > 
> > > Given that you have lifted both my proposed patch and part of my
> > > reply as a commit message, you may at least credit me with a
> > > Suggested-by: tag. Not to mention that the blatant advertising doesn't
> > > really apply in this case.
> > 
> > ok, I will add this tag in rev3 and we need to add that disclaimer
> > as it is a commercial tool. thanks!
> 
> Sorry, but I'm not bound by this requirement. I'm happy to credit
> *you* for reporting a defect, but certainly not a tool that hasn't
> "resolved" anything, despite what the message says.

Ok, I will drop the resolved part as the modified fix is suggested by
you. Is it ok?
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

