Return-Path: <linux-kernel+bounces-299545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037A95D614
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5D61F23F24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B419258B;
	Fri, 23 Aug 2024 19:32:54 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86D112D20D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724441574; cv=none; b=F+wxXguU/ey+k83xugGt/wiCGDkjfK5mWfOQYX7fEbjm2oks24KRw+YJ4MLjhqI2r16/kkpP7ppI2f2AkGwLRHRRqyQgNHxS48B6LW9KowfoF1iME+xDAiKyl3rw+DdglwiHpBbzveHgHA6k5jlF3lKaJRxJqXtVxGjlLQe5a6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724441574; c=relaxed/simple;
	bh=I676zDKpX5ZaKhUFB+HusC2WSbWJmgxldqHAjOGfPt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyZ8OyTkbWBo8up/8YhsIAZdBfuGkh9X8DBT/VzLQPqsRrCtIYy68MYWSyTebGbiQm4wnTxkshbaBe0V6PI3wvgDD3AWGEnswGqz+Sfm1oFUIlKRDGctECD/ja5Cm/1IPNAyGeAxe2vuxAfwlKs9iRnUgi/FFRS8sCtl3FzOHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47NJLSlM032341;
	Fri, 23 Aug 2024 14:21:49 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 47NJJp0F032203;
	Fri, 23 Aug 2024 14:19:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 23 Aug 2024 14:19:24 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
        Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Stan Johnson <userm57@yahoo.com>, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in kernel mode
Message-ID: <20240823191924.GK28254@gate.crashing.org>
References: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu> <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de> <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com> <20240822053238.GA2028@lst.de> <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com> <20240823130600.GI28254@gate.crashing.org> <20240823135459.GA28487@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823135459.GA28487@lst.de>
User-Agent: Mutt/1.4.2.3i

Hi!

On Fri, Aug 23, 2024 at 03:54:59PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 23, 2024 at 08:06:00AM -0500, Segher Boessenkool wrote:
> > What does "uncached memory" even mean here?  Literally it would be
> > I=1 memory (uncachEABLE memory), but more likely you want M=0 memory
> > here ("non-memory memory", "not well-behaved memory", MMIO often).
> 
> Regular kernel memory vmapped with pgprot_noncached().

So, I=1 (and G=1).  Caching inhibited and guarded.  But M=1 (memory
coherence required) as with any other real memory :-)

> > If memset() is expected to be used with M=0, you cannot do any serious
> > optimisations to it at all.  If memset() is expected to be used with I=1
> > it should use a separate code path for it, probably the caller should
> > make the distinction.
> 
> DMA coherent memory which uses uncached memory for platforms that
> do not provide hardware dma coherence can end up just about anywhere
> in the kernel.  We could use special routines for a few places in
> the DMA subsystem, but there might be plenty of others.

Yeah.  It will just be plenty slow, as we see here, that's what the
warning is for; but it works just fine :-)

The memset() code itself could chech for the storage attributes, but
that is probably more expensive than just assuming the happy case.
Maybe someone could try it out though!


Segher

