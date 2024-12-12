Return-Path: <linux-kernel+bounces-442596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08C9EDF0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648B5188763D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B61714A5;
	Thu, 12 Dec 2024 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZSFTrNtt"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCF29A9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733982420; cv=none; b=GySoMR3/z4rGQd3IEBP+FbsxmJE2seCCtOTyP7kogyGzEe1pPrTcg2ubKp7IY8ZEgmNdJqbFz/BncDz3u8LuhyfbAD/Lf5S23vZ0K3XQYQb41W/uWAZNT5I2BrOlpARmc3Ygy8ZNfx4Z4t6f7zIJNbdp2N3jgFk6byLReaMoqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733982420; c=relaxed/simple;
	bh=vAsg1/tOcjagmKRe7K//OqOVvSnFtyYSN+tRVNJ+hpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dau8+5OYe6JXNAQF/uS3WVUaa/v3lIHxMNjaJiZFC449Jg1QArFIv3XuLu+R2myvBA6/gg/L9F/4TETuD4+J1GwAmtJXeZiwLKE3LH5ffq51HIBA6ZRrPOtg7VdHFBwkEEAf6e/HAE6suqgtdSitUpBgKaWGDlcmqnmiAgQru4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZSFTrNtt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YzV4kvVSP88W58d45Rn1P2/CIVICNeiP5Jr2YgR6xao=; b=ZSFTrNttEX6R8uWjV8S2O4sghy
	AzAN5Q/ZIwGgYSfKF8uw+G/RqDwClaWe9aiiFK7/oSXE+yigqvoLbwnp9Qiv+vVEXSBTpzVERknvM
	YhdgSAKU8ImH9btWN65xzUtbiCisYgTd5kmWAz1aq5UgHai2tsCj1EUENdL855chafuloWc4ba5q6
	qv+rc1Jhg/Ghv0INuCd6iwbyRPsSUTQLZh6lwIhIAYFRq4+IqWIQrk2MJWqjeV+hfjX3Y8BU28ce8
	cCEiYpAlV76XVyAZTD9fVB7UMKWg3aW3UiKCCZR+FLZuZhVITxBmjiTqXuXmdBSSFC+8ZGkpVSIZo
	Fn8Gux3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLc2I-0000000Gyev-1zIr;
	Thu, 12 Dec 2024 05:46:54 +0000
Date: Wed, 11 Dec 2024 21:46:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	dan.j.williams@intel.com, dave.hansen@linux.intel.com,
	david@redhat.com, jane.chu@oracle.com, osalvador@suse.de,
	tglx@linutronix.de
Subject: Re: [PATCH 0/4] Remove problematic include in <asm/set_memory.h>
Message-ID: <Z1p4zp1qnVyY-C2L@infradead.org>
References: <20241210184610.2080727-1-kevin.brodsky@arm.com>
 <Z1kdQyHnPd0jgIgZ@infradead.org>
 <490f7554-62eb-48a3-a45d-a65e68794b58@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490f7554-62eb-48a3-a45d-a65e68794b58@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 11, 2024 at 09:14:07AM +0100, Kevin Brodsky wrote:
> On 11/12/2024 06:04, Christoph Hellwig wrote:
> > On Tue, Dec 10, 2024 at 06:46:06PM +0000, Kevin Brodsky wrote:
> >> The need for this series arose from a completely unrelated series [1].
> >> Long story short, that series causes <linux/mm.h> to include
> >> <linux/set_memory.h>, which doesn't feel too unreasonable.
> > It is entirely unreasoable. <linux/mm.h> is inclued just about
> > everywhere and should not grow more fringe includes.
> 
> Understood, I did wonder about that. Then I suppose the best course of
> action for the problematic patch in that other series [3] is to move
> pagetable_{alloc,free} out of linux/mm.h.

Yes, adding a new header for the page table helpers only used by arch
code is probably a good idea. Or maybe they can actually fit into
asm-generic/pgalloc.h?  


