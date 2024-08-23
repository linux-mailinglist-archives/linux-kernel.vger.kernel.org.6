Return-Path: <linux-kernel+bounces-298971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3F995CE77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6177D1F232CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA39188593;
	Fri, 23 Aug 2024 13:55:08 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50046556
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421308; cv=none; b=PKDdC6sgXM4P2Xb2ZeCq8k8y9ykr9Hp+RJkeUZPvfGOWmJ+FUvSfvSn+az5SllJIkvkXikfiXIIgTQoW5o14ycyzN9wWW6UJardahHnUXwaPhLqMpoqLTUkkCF0byykB34nWHWtBBxqRjvkdldxrqqOENWRuLMpRpcZ5fvr7YQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421308; c=relaxed/simple;
	bh=qSqQ9GnhWGmTSapojg84oU2lB3a269KGY/hYPDUonjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZx0GbOoVkPFJL8PaTfnSGx4/Q7vR4HRA6DnzFNRs3z4g5RXJPYYzsHQnXWovP1jez9lS/KmrZPLyeFbZJGf5Fs0lvRKS9hkyDfYW8mCGqT0oWc6S4gydMDTm1sZCHE87aoF4VOx7O81NFI+RbePbMjZTBJw0G7tZuPfSLS9/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75626227A87; Fri, 23 Aug 2024 15:54:59 +0200 (CEST)
Date: Fri, 23 Aug 2024 15:54:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	Christoph Hellwig <hch@lst.de>,
	Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in
 kernel mode
Message-ID: <20240823135459.GA28487@lst.de>
References: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu> <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de> <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com> <20240822053238.GA2028@lst.de> <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com> <20240823130600.GI28254@gate.crashing.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823130600.GI28254@gate.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 23, 2024 at 08:06:00AM -0500, Segher Boessenkool wrote:
> What does "uncached memory" even mean here?  Literally it would be
> I=1 memory (uncachEABLE memory), but more likely you want M=0 memory
> here ("non-memory memory", "not well-behaved memory", MMIO often).

Regular kernel memory vmapped with pgprot_noncached().

> If memset() is expected to be used with M=0, you cannot do any serious
> optimisations to it at all.  If memset() is expected to be used with I=1
> it should use a separate code path for it, probably the caller should
> make the distinction.

DMA coherent memory which uses uncached memory for platforms that
do not provide hardware dma coherence can end up just about anywhere
in the kernel.  We could use special routines for a few places in
the DMA subsystem, but there might be plenty of others.


