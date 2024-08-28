Return-Path: <linux-kernel+bounces-304796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F348996250A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823762828E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABAD16BE04;
	Wed, 28 Aug 2024 10:35:14 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A4158DC2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841314; cv=none; b=G29tGJ4lhBoVbSU+QkIpLkvqvKZeUpIm8+tCLRK0DRrf1Qpgd5nLsXu6P6G3ZsvflVJd5mcLeXAAad3dFQ5rxOBlqvYg8I1rRO2CtfBjqvTrrtJVtybKSlAWBQfwC9gmtNypAYnghgwkBs0w1cxdl1HBxEo37BUbiTaaDcqJxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841314; c=relaxed/simple;
	bh=T16fsUPl550numgCq3KQn3gR+JJ17P7o5/vVVn5Y3uA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E0mf6pRc5UC6Sc+kiV4pVZoLVP2P6Hm1Fcw7smvrjShmbctnD5umXAdFeB1H4ujV9aZFaMwig48tSLuWjQFxcBNKttnldXUyZEzKvXwirRs4iahmXJX4r44VYlZ0zA6a5QdKUgJVMSSL9AC5NJgvtAibmt9v03iNB/r5YSD2vhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 86CA092009C; Wed, 28 Aug 2024 12:35:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7FF1592009B;
	Wed, 28 Aug 2024 11:35:02 +0100 (BST)
Date: Wed, 28 Aug 2024 11:35:02 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Christoph Hellwig <hch@infradead.org>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Rick Edgecombe <rick.p.edgecombe@intel.com>, 
    Isaku Yamahata <isaku.yamahata@intel.com>, 
    Kevin Loughlin <kevinloughlin@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/EISA: Use memremap() to probe for the EISA BIOS
 signature
In-Reply-To: <Zs7PlOqxdz9xGCIo@infradead.org>
Message-ID: <alpine.DEB.2.21.2408281109550.33652@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408261015270.30766@angie.orcam.me.uk> <Zs7PlOqxdz9xGCIo@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Aug 2024, Christoph Hellwig wrote:

> > +	if (p && *p == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
> 
> Should this simply use strcmp now?

 It's not an ASCIIZ string, so I guess memcmp() instead.  I can see there 
is still no clarity as to whether memremap() is enough here (though it 
escapes me why it wouldn't, given that early_memremap() analogously works 
for the MP-table with the scenarios in question), so I'll let things 
settle and look into an update once I'm back from my holiday next week.

 NB sparse chokes on some headers' contents here, so it seems I can't 
really make use of it without figuring out what's wrong first.

  Maciej

