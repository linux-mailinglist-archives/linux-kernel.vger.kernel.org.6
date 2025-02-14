Return-Path: <linux-kernel+bounces-515390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4AA3643C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED873B15B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE7264FA7;
	Fri, 14 Feb 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWqKzPoO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850447E0ED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553469; cv=none; b=SUEYyzmblUmm3zdTvSn2k+NqzY+u7JDW6qjsvXT/EJ53I6fvB6h5Yw8bnZuW9nKxvQ0yg9VNq6NtD2FWrjNC5vuRP0Y3bIx4FbL0oWXsJHP8IzAqd2QS+xTbUElL5F0mzHeHOCvCvtL5+OUOuWZKbG8rFiAvE1Rox42ODr2z5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553469; c=relaxed/simple;
	bh=mbtek7G6QX8aERqHrVmfWL6b3yFQDL+ffEFAs64qKXY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oF+vKM97NurPm7lqoY0+lSf40YzXMb4Ykkj48NNrRKhiQ1idXPAj2pbSfrZXh1wzxy2yrxDgKChcH40BU3/I3tgdmtmISy2iafZxbh6vZdCofG45vif2CswBbE4hcx0HOdQoo88rWTDXB6OclMMhD40/gaoGIIFO/kBHlKT4FJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWqKzPoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96A6C4CED1;
	Fri, 14 Feb 2025 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739553469;
	bh=mbtek7G6QX8aERqHrVmfWL6b3yFQDL+ffEFAs64qKXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eWqKzPoOhomeHVcODhh3qVSpJ7vmTP7HfK3zdrl/hd/Yz7gti8ZhA/UygjfYpXIRJ
	 ItzDBpPNkA/O1NfOw2vS5ew8JOmhcxFsauoQEHLlxujCcmnvHV+ZA3BUgIbwo95UIN
	 5ndlqdGPRpJ6GskQlVbl0X2S24xb+7NqpAsMUfJDuQC7Hz2pDr2Cx9OSys0S/JEXTa
	 WGu/p1nzDRQqHSYTTh43ESxmL8Rt1vrRtIqW5U4XW/68rZv0xWDAH9yJ77EBgc0tY4
	 KqeFC7o4sVywJki0AyY7yyd4MmUjCdNeBeoR83Bn2BuTApj8I7HLWaQJntYJIgo8S3
	 abnPRy9JRat2Q==
Date: Fri, 14 Feb 2025 11:17:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roger Pau Monne <roger.pau@citrix.com>, Juergen Gross <jgross@suse.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH v2 0/3] xen: fix usage of devices behind a VMD bridge
Message-ID: <20250214171745.GA157045@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114103315.51328-1-roger.pau@citrix.com>

[+to Juergen, Nirmal, +cc Jonathan]

On Tue, Jan 14, 2025 at 11:33:10AM +0100, Roger Pau Monne wrote:
> Hello,
> 
> The following series should fix the usage of devices behind a VMD bridge
> when running Linux as a Xen PV hardware domain (dom0).  I've only been
> able to test PV. I think PVH should also work but I don't have hardware
> capable of testing it right now.
> 
> I don't expect the first two patches to be problematic, the last patch
> is likely to be more controversial.  I've tested it internally and
> didn't see any issues, but my testing of PV mode is mostly limited to
> dom0.
> 
> Thanks, Roger.
> 
> Roger Pau Monne (3):
>   xen/pci: do not register devices with segments >= 0x10000
>   vmd: disable MSI remapping bypass under Xen
>   pci/msi: remove pci_msi_ignore_mask
> 
>  arch/x86/pci/xen.c           |  8 ++------
>  drivers/pci/controller/vmd.c | 19 ++++++++++++++++++
>  drivers/pci/msi/msi.c        | 37 ++++++++++++++++++++----------------
>  drivers/xen/pci.c            | 19 ++++++++++++++++++
>  include/linux/msi.h          |  3 ++-
>  kernel/irq/msi.c             |  2 +-
>  6 files changed, 64 insertions(+), 24 deletions(-)

We got an ack from Thomas, so I'm fine with this from a PCI
perspective.  How should it be merged?  Via Xen or PCI?  I'm happy to
merge via PCI, but would also want acks from Juergen for the Xen
piece and Nirmal for the VMD piece.

I have a couple more trivial comments, will respond to those patches.

