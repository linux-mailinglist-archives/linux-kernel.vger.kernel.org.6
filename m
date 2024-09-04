Return-Path: <linux-kernel+bounces-314943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7C096BB3C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6EB1C225CE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6565E1D0DF8;
	Wed,  4 Sep 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="ez76x9vy"
Received: from mail37.out.titan.email (mail37.out.titan.email [3.65.141.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008D1D1723
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.141.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450566; cv=none; b=aN1h5N/mfFNkHJg9vqgZDwtEslurNyHReXKURr7J7d2xleawqYbNrwtVNhTgeqGmWxBctvxMiBvhrRblcAA7nHRAU6lqmeXGPnRvPihmE3rgNottzpyZzQsigj/M0CxeR3kylhcKs+JDqGQp+QtBYzApSEX4mc2iIiuYHxonIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450566; c=relaxed/simple;
	bh=2guXCsLPnDqwfSE6hAcqeEYc689QsRN3Y+3djTzxLa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgLSFaKb9EhK5t/tm/TTRVGh2mOwTXJWvo7HpcpBoff04wGQhwdRP4SDIw0tXk23kokzAtKOBr3YsQoKQKpm5yucXbEna05pbWt+ltCOG7G2KlwVyb2iLIxw+zasJhggaev3wLfOxYhfQcqJeoPgmMPnxi4WNbysa0pT9cGZRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=ez76x9vy; arc=none smtp.client-ip=3.65.141.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 09F9A100046;
	Wed,  4 Sep 2024 11:13:58 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=80jO78szL8rGtVff7vX1ygv6bi1pkmunmx83eoIVOZA=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=message-id:from:cc:subject:mime-version:in-reply-to:date:to:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1725448437; v=1;
	b=ez76x9vymY5E8I6TG6X4tM4LClVsIppLQEYqleKdwFuU8rNCt6u5N92Tt+Ha5mZPcxLPcIm1
	Eqid6JUvOOvcrIj3aovGdQ7PXIYj8bW1eLZ0uJhVRySe6C69KOth93e2IyNseg7jL91YIdSedI7
	n4KBB3/kEksGCat0Fb92jDVQ=
Received: from mail.blacknight.com (ip-84-203-196-95.broadband.digiweb.ie [84.203.196.95])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 21B99100003;
	Wed,  4 Sep 2024 11:13:57 +0000 (UTC)
Date: Wed, 4 Sep 2024 12:13:56 +0100
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Rong Qianfeng <rongqianfeng@vivo.com>
Cc: vbabka@suse.cz, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: Skip the reserved bootmem for compaction
Message-ID: <5fmd2poyeas2pomho2io5zgmqd26vnxd77czmlhqn5tapy4fv4@5tdcqamzgyj5>
References: <20240902122445.11805-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20240902122445.11805-1-rongqianfeng@vivo.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1725448437903432177.12802.4636682366867047228@prod-euc1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=beRtUvPB c=1 sm=1 tr=0 ts=66d840f5
	a=yLX2s/SMutoCvBNwHxSr4A==:117 a=yLX2s/SMutoCvBNwHxSr4A==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=1WtWmnkvAAAA:8
	a=3KhKwHYn802jk4SrU3wA:9 a=PUjeQqilurYA:10 a=zgiPjhLxNE0A:10
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Sep 02, 2024 at 08:24:43PM +0800, Rong Qianfeng wrote:
> Reserved pages are basically non-lru pages. This kind of memory can't be
> used as migration sources and targets, skip it can bring some performance
> benefits.
> 
> Because some drivers may also use PG_reserved, we just set PB_migrate_skip
> for those clustered reserved bootmem during memory initialization.
> 
> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>

I'm not convinced the savings due to skipping a few pages during the scan
would justify the additional code. There would have to be a large number
of reserved pages scattered throughout the zone to make a difference and
even that situation would be a big surprise. I'm not even sure this can be
explicitly tested unless you artifically create reserved pages throughout the
zone, which would not be convincing, or know if a driver that exhibits such
behaviour in which case my first question is -- what is that driver doing?!?

-- 
Mel Gorman
SUSE Labs

