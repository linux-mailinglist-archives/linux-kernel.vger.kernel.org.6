Return-Path: <linux-kernel+bounces-219198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CB090CB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A630F1C223D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16813A27D;
	Tue, 18 Jun 2024 12:09:09 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AD1386C9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712549; cv=none; b=OClSFRXSw9/KNPcrNmdj2iDtCUAdsDb+Poy/i3AWqKdZekvkpv8Gl6BE70bdILK3GnEspPdeVjhLsvRazjVHHM4zkAISV43hqOpMZk6Vm4crwi31VKbKzhyepZB8NKzmYeQ3nHSPNhcI95vckXF1joP4WTc7dQPMfpo2oQbyJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712549; c=relaxed/simple;
	bh=T5BlkluzCY39G6xm3uG+/79deLiNnDVhfgpi8DyGRFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCKxh+hitdggJ/Dw6oNsmntB6kMYKI6Z7SMhzNqYN0vpU6xuJQ9mVSjyChnfZ/wOIvOi4GP0MU5yrMMMgLUYPjq9pfgf27BqsibJk8rt4gwV5OprCJUWTA0yxetuUVuC8eoet5gETdiRect4tgKFKaoVZwCvSw1nouWysYc55iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTP id 45IC8uhb092424;
	Tue, 18 Jun 2024 20:08:56 +0800 (+08)
	(envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 20:08:55 +0800
Date: Tue, 18 Jun 2024 20:08:52 +0800
From: Leo Liang <ycliang@andestech.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "patrick@andestech.com"
	<patrick@andestech.com>
Subject: Re: [RFC PATCH 1/1] mm/vmalloc: Modify permission reset procedure to
 avoid invalid access
Message-ID: <ZnF41EAK06FYog27@swlinux02>
References: <20240611131301.2988047-1-ycliang@andestech.com>
 <5e603eedf9e8fbd6efe1d118706dd82666e54251.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e603eedf9e8fbd6efe1d118706dd82666e54251.camel@intel.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 45IC8uhb092424

On Tue, Jun 11, 2024 at 02:21:42PM +0000, Edgecombe, Rick P wrote:
> [EXTERNAL MAIL]
> 
> On Tue, 2024-06-11 at 21:13 +0800, Leo Yu-Chi Liang wrote:
> > The previous reset procedure is
> > 1. Set direct map attribute to invalid
> > 2. Flush TLB
> > 3. Reset direct map attribute to default
> >
> > It is possible that kernel forks another process
> > on another core that access the invalid mappings after
> > sync_kernel_mappings.
> >
> > We could reproduce this scenario by running LTP/bpf_prog
> > multiple times on RV32 kernel on QEMU.
> >
> > Therefore, the following procedure is proposed
> > to avoid mappings being invalid.
> > 1. Reset direct map attribute to default
> > 2. Flush TLB
> 
> Can you explain more about what is happening in this scenario? Looking briefly,
> riscv is doing something unique around sync_kernel_mappings(). If a RO mapping
> is copied instead of a NP/invalid mapping, how is the problem avoided?

Hi Edgecombe,

Sorry for the late reply and thank you for taking a look.

What we are seeing at first is that running LTP bpf_prog03 test fails randomly
on RV32 SMP QEMU with kernel 6.1 and the failed cause is a load page fault.

After a bit of inspection, we found that the faulting page is a part of
kernel's page table and the valid bit of that page's PTE is cleared due to this reset procedure.

The scenario of this fault is suspected to be the following:
1. Running bpf_prog03: Creates kernel pages with elevated 'X' permission so that bpf program can be executed.
2. Finishing bpf_prog03: vfree code path to reset permission to default: 
	a. Set the pages to invalid first
	b. Unmap the pages and flush TLB
	c. Reset them to default permission
3. Other core forkes new processes: sync_kernel_mappings copies the kernel page table.

If the 3rd step happens during 2a, then we get a kernel mapping with invalid PTE permission,
Therefore, if the invalid page is accessed, we'd get a page fault exception and the kernel panics.

But despite all of the above conjecture,
we still are wondering if setting the mappings to be invalid first is necessary.
IMHO, "set to invalid --> unmap & flush TLB --> set to default" is identical to "set to default --> unmap & flush TLB".
Could we not just reset them to default first and then flush TLB & free memory?

Best regards,
Leo

