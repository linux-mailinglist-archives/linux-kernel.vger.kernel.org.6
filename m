Return-Path: <linux-kernel+bounces-228787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DCC9166C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E194828CD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C8014D2B3;
	Tue, 25 Jun 2024 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="o/5UXGrD"
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619B44C9E;
	Tue, 25 Jun 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316801; cv=none; b=R233D9fGg5vTbb+lt8OyG9Yshd8BBUrW2L7e/KYgSG+tCBA5ZkJXMOHKE41uW2LGuLdkOPv1C8m/LuztaPLvtwAPug23NTTGza2g0oM2Fhyn0r8mhV2pwhsV2HewCVWcB4oyE5TEUuf9qwdsqhv5F9bmR8sBZWlaiUF5i+YF+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316801; c=relaxed/simple;
	bh=4V6xg6S/HX+wZLmul00HyyGqeoWWy7EEr0Dh7EvDybs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urccUEBISCeOD+JLIRBtXcGf3a12k9M45M6EcJ4zMAroh50Cbo3y0VvAwgh0Zr0c4RP63r/jB/2Mb1Q1Iqq8hBmGLKZnMEiggyIpPO1fHsPNoonu1aVxH9bTjLgu2K+ZHOU7jRP0jubpcGzWbEJ6AaJwN1fyVmhbLJpEKJCjoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=o/5UXGrD; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1719316800; x=1750852800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5CGaz4yBPoNZEIuBCWmd656slzdLN7LQIZfAfGhRojg=;
  b=o/5UXGrDibi0R1QZSdZ3mbx8lEB7QwZiWDL0+PsYZcDWHyJTTZckq76P
   0/nVVM5IGYXrJXvc4TRS8P6L3mpBCl+ekB4j3+7+IvdvKXaIskOO81V2N
   neVsS2sf41kvOCQ9XAaJGWB60EsIM9rONcs4qu0AlBPqwptk4jzrqzszc
   A=;
X-IronPort-AV: E=Sophos;i="6.08,264,1712620800"; 
   d="scan'208";a="7249835"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:59:58 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:7551]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.15:2525] with esmtp (Farcaster)
 id 7600a396-1a2e-4084-a235-5c5e0f28c865; Tue, 25 Jun 2024 11:59:57 +0000 (UTC)
X-Farcaster-Flow-ID: 7600a396-1a2e-4084-a235-5c5e0f28c865
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 11:59:56 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.106.82.20) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 11:59:53 +0000
Date: Tue, 25 Jun 2024 13:59:48 +0200
From: Roman Kagan <rkagan@amazon.de>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <linux-arm-kernel@lists.infradead.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<nh-open-source@amazon.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Marc
 Zyngier" <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gicv3-its: Workaround for GIC-700 erratum 2195890
Message-ID: <ZnqxNMIp/dGNY1u6@u40bc5e070a0153.ant.amazon.com>
Mail-Followup-To: Roman Kagan <rkagan@amazon.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, nh-open-source@amazon.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>
References: <20240624165541.1286227-1-rkagan@amazon.de>
 <87pls66mok.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87pls66mok.ffs@tglx>
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D033EUC004.ant.amazon.com (10.252.61.133)

On Mon, Jun 24, 2024 at 11:44:11PM +0200, Thomas Gleixner wrote:
> On Mon, Jun 24 2024 at 18:55, Roman Kagan wrote:
> > According to Arm CoreLink GIC-700 erratum 2195890, on GIC revisions
> > r0p0, r0p1, r1p0 under certain conditions LPIs may remain in the Pending
> > Table until one of a number of external events occurs.
> >
> > No LPIs are lost but they may not be delivered in a finite time.
> >
> > The workaround is to issue an INV using GICR_INVLPIR to an unused, in
> > range LPI ID to retrigger the search.
> >
> > Add this workaround to the quirk table.  When the quirk is applicable,
> > carve out one LPI ID from the available range and run periodic work to
> > do INV to it, in order to prevent GIC from stalling.
> >
> > TT: https://t.corp.amazon.com/D82032616
> 
> Can you please refrain from providing internal links?
> 
> > Signed-off-by: Elad Rosner <eladros@amazon.com>
> > Signed-off-by: Mohamed Mediouni <mediou@amazon.com>
> > Signed-off-by: Roman Kagan <rkagan@amazon.de>
> 
> That Signed-off-by chain is invalid. See Documentation/process/

ACK to all, will fix (sorry haven't posted patches for a while, muscle
memory got rusty).

Thanks,
Roman.



Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


