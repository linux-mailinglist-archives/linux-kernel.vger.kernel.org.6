Return-Path: <linux-kernel+bounces-196628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B279E8D5EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B5E1C2177C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEF213DDC0;
	Fri, 31 May 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oB+bI8iA"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24C1CD35
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149203; cv=none; b=B7gkEIMenMStpMI8ArEvJZQQR/anJVkXjAWhSpv5L5lWoB809OOpzkZIrXsYMyeUgPMoQod2HvtKolr1vI2KX9KFCb7y/Zew2401V2YTkPMX/pk2RghWCW94s+ho6kZf+GIoadtwLT3XKQCKtpcjipXQNYpbyNgnbsDNZ7rzhoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149203; c=relaxed/simple;
	bh=oRIVIkZ0ebtoc1O1429qaCAf+Ahsm96mCmkpSWqk38s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+Jo4QoeG25OJ1p9KemJBElnuCNIKS2Ae7LN78pO7kN+wqpaFGCKRbk1RLXDzB85xS/z6pfsz0pXZfQwb9J296f/UXEQ/lUe6WWyr5mzovkXEiK9lXgXZRu5v5nuA1wLhXdEa5tgyULlD8Qb9eF3HGWJPQPa3T5alCoRogABZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oB+bI8iA; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717149202; x=1748685202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SvV+wfdiyed0NjS6BbmnQhnYNOMz/ot76ixvTxO5D5Y=;
  b=oB+bI8iAcrLFeayKeqUt8WENU2d4TK2u/6rJkTiJtNM3J8B5diWE9+UM
   F2cm59bCtMMayDWbR7jAaPUMBiyGoPUnmIFN7f9HReiRusuOo+kNRp42N
   P5IbvCoN3EQBNoKNMN5ECAnCV9oku1dbUXNsYaCgvwTItGKiiPF5JVyHH
   o=;
X-IronPort-AV: E=Sophos;i="6.08,203,1712620800"; 
   d="scan'208";a="208745106"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:53:20 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:64404]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.198:2525] with esmtp (Farcaster)
 id 7e16ca48-ed3d-44b8-8e25-f136d3b9f137; Fri, 31 May 2024 09:53:19 +0000 (UTC)
X-Farcaster-Flow-ID: 7e16ca48-ed3d-44b8-8e25-f136d3b9f137
Received: from EX19D008EUA001.ant.amazon.com (10.252.50.34) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 09:53:19 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008EUA001.ant.amazon.com (10.252.50.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 09:53:19 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 31 May 2024 09:53:19
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id B859620BED; Fri, 31 May 2024 09:53:18 +0000 (UTC)
Date: Fri, 31 May 2024 09:53:18 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Marc Zyngier <maz@kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>,
	Thomas Gleixner <tglx@linutronix.de>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<hagarhem@amazon.de>
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Fix potential race condition in
 its_vlpi_prop_update()
Message-ID: <20240531095318.GA5556@amazon.com>
References: <20240531074302.30563-1-hagarhem@amazon.com>
 <86ttiel4bb.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86ttiel4bb.wl-maz@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, May 31, 2024 at 10:27:04AM +0100, Marc Zyngier wrote:
> On Fri, 31 May 2024 08:43:02 +0100,
> Hagar Hemdan <hagarhem@amazon.com> wrote:
> > 
> > its_vlpi_prop_update() calls lpi_write_config() which obtains the
> > mapping information for a VLPI without lock held. So it could race
> > with its_vlpi_unmap().
> > Since all calls from its_irq_set_vcpu_affinity() require the same
> > lock to be held. So instead of peppering the locking all over the
> > place, we hoist the locking into its_irq_set_vcpu_affinity().
> > 
> > This bug was discovered and resolved using Coverity Static Analysis
> > Security Testing (SAST) by Synopsys, Inc.
> > 
> > Fixes: 015ec0386ab6 ("irqchip/gic-v3-its: Add VLPI configuration handling")
> > Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> 
> Given that you have lifted both my proposed patch and part of my
> reply as a commit message, you may at least credit me with a
> Suggested-by: tag. Not to mention that the blatant advertising doesn't
> really apply in this case.

ok, I will add this tag in rev3 and we need to add that disclaimer as it is a
commercial tool. thanks!
> 
> > ---
> > v2: moved the lock to its_irq_set_vcpu_affinity().
> > Only compile-tested, no access to HW.
> 
> Was the initial patch tested at all?
No, the initial one was only compile tested, forgot to add that hint in the first
patch.
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

