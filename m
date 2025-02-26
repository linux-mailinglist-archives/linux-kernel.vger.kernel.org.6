Return-Path: <linux-kernel+bounces-533540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86FA45BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1505F188A127
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1589E26BD8C;
	Wed, 26 Feb 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n8qlucfj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413B26A1A1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565855; cv=none; b=I3GZ/Ic/XC/0cRbGdtByeq3m6Cfnvz49w5Nd32oqoXR71FGkTzBoUCAKZqmFknV0/A6EP9hqzZAdAOE+E/pj89csfGzFDS7hWYd00dyQJdkKevmJB5KFOuc0pUR1H8sE1CDVdo79lzYLaQVGP1y0BxlGYbxQDP5djms8v9IK+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565855; c=relaxed/simple;
	bh=hpjEs9rw2eM7Obcjk/IgE5RmUTV45lgJC5V7Vis2td4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNvIfT7Xgo/2mmqCjtSoNto3K1KIpOUs35VQ09I+yYLpMyKQylHqUXvqLK39YAn4Bq6jH0V5L5ibfj9yXAzDFWknXBgpH7ua4MtBwqrPRVP9s+fsm8cdTHGgtQbzUXTjcndoxEPPzV9RixFRG1HKHBsQb6KcH8CAqF/Y831GLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n8qlucfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6A7C4CEE2;
	Wed, 26 Feb 2025 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740565855;
	bh=hpjEs9rw2eM7Obcjk/IgE5RmUTV45lgJC5V7Vis2td4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8qlucfjgHFw6oWFFrdR2HXkKU2bicUyLeLsjIvTQCpDgxTtpaix7VFRhfljw6JEM
	 1RMXMdNjoFZCItTB/+9DxI14sLMtxmORzLySTMrABADRM3gJ0ToEydIoyLG5Sseg0M
	 /MQELGasdvsW9RqX1FwoesAEby0DSVNp/KiQpIEc=
Date: Wed, 26 Feb 2025 11:05:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2022-49660: xen/arm: Fix race in RB-tree based P2M accounting
Message-ID: <2025022608-sternum-phoniness-988d@gregkh>
References: <2025022622-CVE-2022-49660-cf45@gregkh>
 <9a6223ee-cb70-4c20-9749-e5ddc5018f1b@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a6223ee-cb70-4c20-9749-e5ddc5018f1b@suse.com>

On Wed, Feb 26, 2025 at 08:01:04AM +0100, Juergen Gross wrote:
> On 26.02.25 03:23, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > xen/arm: Fix race in RB-tree based P2M accounting
> > 
> > During the PV driver life cycle the mappings are added to
> > the RB-tree by set_foreign_p2m_mapping(), which is called from
> > gnttab_map_refs() and are removed by clear_foreign_p2m_mapping()
> > which is called from gnttab_unmap_refs(). As both functions end
> > up calling __set_phys_to_machine_multi() which updates the RB-tree,
> > this function can be called concurrently.
> > 
> > There is already a "p2m_lock" to protect against concurrent accesses,
> > but the problem is that the first read of "phys_to_mach.rb_node"
> > in __set_phys_to_machine_multi() is not covered by it, so this might
> > lead to the incorrect mappings update (removing in our case) in RB-tree.
> > 
> > In my environment the related issue happens rarely and only when
> > PV net backend is running, the xen_add_phys_to_mach_entry() claims
> > that it cannot add new pfn <-> mfn mapping to the tree since it is
> > already exists which results in a failure when mapping foreign pages.
> > 
> > But there might be other bad consequences related to the non-protected
> > root reads such use-after-free, etc.
> > 
> > While at it, also fix the similar usage in __pfn_to_mfn(), so
> > initialize "struct rb_node *n" with the "p2m_lock" held in both
> > functions to avoid possible bad consequences.
> > 
> > This is CVE-2022-33744 / XSA-406.
> 
> As clearly visible in the commit message: there is already a CVE assigned.
> 
> Please revoke CVE-2022-49660.

Ugh, I thought I caught all of these in doing my reviews, sorry about
that.

And any reason why the cve.org record does NOT have this git id in it
for this CVE record?  I check them all before assigning new ids like
this (it was part of the big GSD dump that we are slowly backfilling)
and I use that to prevent duplicate ids from being created.

Also thanks for the review of all of the other xen cves, I'll go revoke
them now as well.

thanks,

greg k-h

