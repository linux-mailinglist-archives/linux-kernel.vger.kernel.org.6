Return-Path: <linux-kernel+bounces-353826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267C099334E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F916B24C94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C991DDC9;
	Mon,  7 Oct 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="QAb3mxCe"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F81D4164
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318624; cv=none; b=VWMUZJJf9aXYVnkQ7KnuwdTsx2/g4SAHvTFpfufvkiLh3ZGEBmMOr1cRgsOxKnkGryO5TJtSBta4gFd3w6rRb5P4Xl+bnU6iB3b/aeXS0unNP3tA9kMfjtwwaf+ewnPdymsL98ejYUpCvaUlB9plUAqChN8mTL4bf62EnVMSyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318624; c=relaxed/simple;
	bh=Egyp1ASo/oii9pJ2DkFESs3h3UAA6SZYA/as0HXCYjo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H0jgl0bgZ2xYsoCBUog0gu8rROBWKeACfdgI2p+l00JmXtgLT8rt6wwbMlVxrINkR3GU+FhltXDaL43hAaGXcGp1vXobE2690EsX0m08EeZPGvqnS2oBfle0OfNp3x2Hyp2B8pEMOKwr6vlxKSCcVlxp94J32zYy9+5pNKla0LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=QAb3mxCe; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1728317958;
	bh=Egyp1ASo/oii9pJ2DkFESs3h3UAA6SZYA/as0HXCYjo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QAb3mxCe91iQ2aCSMn1fNskGErTgUM4RDxmdl7YUcHBIjN3j8WQpMUH376PbaoqD4
	 OmfZgizlw+QctYHa7ezORy0bVb2a0SA2XZjDw5Lqhw9VRVQt8WnIWpt8T8X4AMjaj0
	 iuvjNZV5B8iSOovLdvL3l5l7VAawHgmDtte3yyxo=
Received: by gentwo.org (Postfix, from userid 1003)
	id 99E6B4026D; Mon,  7 Oct 2024 09:19:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 9897740264;
	Mon,  7 Oct 2024 09:19:18 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:19:18 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc: Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
    David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, Yang Shi <shy828301@gmail.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, 
    Huang Shijie <shijie@os.amperecomputing.com>
Subject: Re: [PATCH v3] SLUB: Add support for per object memory policies
In-Reply-To: <CAB=+i9T8cOLQt4YprvUghwWZx1nOaiQ-0vV1N1zOOHWAFXza0Q@mail.gmail.com>
Message-ID: <e3d978ce-146c-36a5-3ae3-bddb80440203@gentwo.org>
References: <20241001-strict_numa-v3-1-ee31405056ee@gentwo.org> <CAB=+i9T8cOLQt4YprvUghwWZx1nOaiQ-0vV1N1zOOHWAFXza0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 6 Oct 2024, Hyeonggon Yoo wrote:

> > +                        */
> > +                       if (mpol->mode != MPOL_BIND || !slab ||
> > +                                       !node_isset(slab_nid(slab), mpol->nodes))
> > +
> > +                               node = mempolicy_slab_node();
> > +               }
>
> Is it intentional to allow the local node only (via
> mempolicy_slab_node()) in interrupt contexts?

Yes that is the general approach since the task context is generally not
valid for the interrupt which is usually from a device that is not task
specific.

