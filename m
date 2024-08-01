Return-Path: <linux-kernel+bounces-271894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05514945490
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1021F22E82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FFA14B941;
	Thu,  1 Aug 2024 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EJo0agEs"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081C38DD6;
	Thu,  1 Aug 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722551959; cv=none; b=j66Q8oe4QgjUkIDXcReJhTqkUCmc7fzHfZqI6uCv3/9Eu+t1IO4HA6hQFbrS1vhzu9BtyNS5UAQ54qdxHD5USjfVLcNIeF7cah1GMOtssLzTcvLgvF3q6hGy5dUKNinI/x5OBXVMhR4rmH2jewFb6g+tt4t61Vfbr+MHoIh3mdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722551959; c=relaxed/simple;
	bh=/4isdzAb9LbuZ+Bj/X23RxdmkVGkL9cB0N8hv37DtN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWhABtmevrv9WR/mXrHm8vTu0VT42MBVtWkE93f4FuJA0GRUX4jbZ2olC+njKku2Wzh/fkvItD1OqaBQrk+JUfeuQIZJS54AisW/2/SfmjxLKQBZu+8w3evx+CbP8DG+U/b+yaoRbfySUDTa0P3FL2ZqOOn0F+ggElsqzUZYXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EJo0agEs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rs60foqmM4vSIN2IoIAjWC3FQ7KsUgwgRo39yiV4cPg=; b=EJo0agEs7S9v/G1tmCqqqCVwcq
	hOSuH6jxsm/rhhaymwRqmW7fPOXUjw8+ut2R9F97rRVDPwHCQlVF/XYMgN7YSiRVp+bSDmF5rd9Ez
	Jf1ROG3RF4LnHrhKnweMpeX5glIAhpi4Ec+pTEmdF/0Ldio67PWy4aRX7lql+w29LUTkANX5Gwo/4
	QOMhTrRDaTE/g+9xU+cKuOn9u+r+u10p5le9uyVp+A2/RP+cwmiJOqA0VUBRE12lH68RrvkRBZd/P
	Cde0t++EQwcugnOeChU480VKx7kceQKnJzJ4JpbaPok0gXzqCHTIpsYQANF+e9JYnFHkTvw0SpUC+
	bNA9Zjfw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZeRz-00000000NHO-2X9H;
	Thu, 01 Aug 2024 22:39:11 +0000
Date: Thu, 1 Aug 2024 23:39:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Paluri, PavanKumar" <papaluri@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Giani, Dhaval" <Dhaval.Giani@amd.com>
Subject: Re: [PATCH 0/2] "nosnp" sev command line support
Message-ID: <ZqwOjxRAfhjNw5Vs@casper.infradead.org>
References: <20240801205638.6603-1-papaluri@amd.com>
 <Zqv2_wQbCLN_AOfy@casper.infradead.org>
 <12829169-2484-8e98-c489-570dade578bd@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12829169-2484-8e98-c489-570dade578bd@amd.com>

On Thu, Aug 01, 2024 at 05:23:29PM -0500, Paluri, PavanKumar wrote:
> Hi Matthew,
> 
> On 8/1/2024 3:58 PM, Matthew Wilcox wrote:
> > On Thu, Aug 01, 2024 at 03:56:36PM -0500, Pavan Kumar Paluri wrote:
> >> Provide "nosnp" boot option via "sev=nosnp" kernel command line to
> >> prevent SNP-capable host kernel from enabling SEV-SNP and initializing
> >> RMP table.
> > 
> > Congratulations on using three acronyms multiple times and defining none
> > of them.
> 
> I apologize for not defining the acronyms, I had wrongly assumed they
> were well understood by the reviewers/maintainers. I can fix that up
> going forward. In the meantime:

You cc'd linux-doc.  That's going to people who have no idea what
specialist part of the kernel you're working on.

> RMP: Reverse Map Table
> SEV: Secure Encrypted Virtualization
> SNP: Secure Nested Paging
> 
> These definitions are also available in AMD-APM vol 2: Chapter 15 [1]
> 
> [1]:
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
> 
> Thanks,
> Pavan

