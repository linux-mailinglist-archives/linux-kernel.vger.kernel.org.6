Return-Path: <linux-kernel+bounces-432043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B089E443C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722F5286927
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053FC1C3BF0;
	Wed,  4 Dec 2024 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="re9Dh6t7"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2861A8F9A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339623; cv=none; b=EKEiFJN52Kec2wTiLQRPWxzRHq7S87/A/ln+60g/V3w1lWN/mM2sZ3mliQG5uzpMgPoKLvR8Z/sxRfEWbUyLI8+GLOnOfjyn8Ygc9P4VgKwV60gwIdKaJXfIKWOYbD3vL6XnhWdOfHUyaVQWSgCnwGV2rDcLZX12pXqNbeDaw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339623; c=relaxed/simple;
	bh=M3sbexC0sBolFfglTL9oC6racp1L2XMEuQ0UohvE8n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX6LY8ijBJV0Tbf2OFaZHbENG53rhaRInKnJXUjN/Or8d2ZrOFQTPyv/G2zApDOKi3EOKyH1p2Dlqq+ptzCslIg84XClIkhg/2BpYTKxNC55A8rXxcUEqUcjbRCXJ7mryPmCBML+8QAz2ZUNrl1o4p3fznYq8AO5lMiHG2qZgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=re9Dh6t7; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id F162F200416;
	Wed,  4 Dec 2024 20:13:30 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=re9Dh6t7;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1slEieegBiaPIUQh1k/xKAhOBxs1/JZbwlZHTKBiVqE=; b=re9Dh6t7ar/Ff0z7t8Xh2S84iH
	1g9J/UwxQPr5rLSVtQfTfIKNX1tuh9kT1s9uCCSaY66HIG7phhSbSV1GzqdoWMrbNgYOwjg8plLlj
	RCeFY8BP2AUnQ75GjbGR6mhu07lzNQj8eyJAZYBB3REmYlJdUxy8CzxdghPB3S0gkyTc=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tIuoU-0016Us-0z;
	Wed, 04 Dec 2024 20:13:30 +0100
Date: Wed, 4 Dec 2024 20:13:30 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [PATCH v1] hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <Z1Cp2t6LNf3trdNf@bender.morinfr.org>
References: <Z1Ce6j5WiBE3kaGf@bender.morinfr.org>
 <0dc516ab-b2b0-414d-868e-880bd13b5cdd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc516ab-b2b0-414d-868e-880bd13b5cdd@redhat.com>

On 04 Dec 20:01, David Hildenbrand wrote:
>
> On 04.12.24 19:26, Guillaume Morin wrote:
> 
> Patch prefix should likely be "mm/hugetlb: ..."
> 
> > FOLL_FORCE|FOLL_WRITE has never been properly supported for hugetlb
> > mappings.  Since 1d8d14641fd94, we explicitly reject it. However
> 
> "Since commit 1d8d14641fd9 ("mm/hugetlb: support write-faults in shared
> mappings") ..."

Will fix in v2.

> 
> > running software on hugetlb mappings is a useful optimization.
> > Multiple tools allow to use that such as Intel iodlr or
> > libhugetlbfs.
> 
> It would be better to link to the actual request where people ran into that
> when using PTRACE_POKETEXT
> 
> That hugetlb is getting used is rather obvious :)

Well, allow me to point out that I said running software on a hugetlb
mapping, not generally using hugetlb.

That said, which link are you referring to? The only discussion I am
aware of is off mailing lists.

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>

