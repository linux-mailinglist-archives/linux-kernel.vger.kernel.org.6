Return-Path: <linux-kernel+bounces-435377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D689E76D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC45518804BF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51881FFC53;
	Fri,  6 Dec 2024 17:13:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB781FFC44
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505192; cv=none; b=lyOtZDEScXgtwyGs+sDMnK5OtgNmLKH4pnENKtZpwhU2GPKM9jQSHVVHIt145BB/RfVPVqDKKQG9e6EcHTX7vAuKPJRrJ1xtmfIdHtG8gPFBL85fTOqyunH3mYHtqjf35MSDsuM8riEn4v5wcv0o1475BhygGIeooJbREW4r/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505192; c=relaxed/simple;
	bh=i5E4uGZPn68HqocODT9zXud8PQlt1kfBqFdbnedwPfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VE+4D4kpxtg+f+B91fnbsJ5TH5DfkvSq1Spn5RvkiuucpZqp0R077Q4mq5Lvpa80LHUSPMxT7txmKzEH8mkFTPGYAQy9Y5Afp4F1WAqnX6gplpbw0gug4/S+QYdgcJqQXzHSSJ92pAxX0fdOn1UDNHTPxxbyiMhAsqEszGMB8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9357C4CED1;
	Fri,  6 Dec 2024 17:13:09 +0000 (UTC)
Date: Fri, 6 Dec 2024 17:13:07 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
	mark.rutland@arm.com, joey.gouly@arm.com,
	dave.hansen@linux.intel.com, akpm@linux-foundation.org,
	chenfeiyang@loongson.cn, chenhuacai@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: mm: vmemmap populate to page level if not
 section aligned
Message-ID: <Z1Mwo5OajFZQYlOg@arm.com>
References: <20241121071256.487220-1-quic_zhenhuah@quicinc.com>
 <20241121071256.487220-2-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121071256.487220-2-quic_zhenhuah@quicinc.com>

On Thu, Nov 21, 2024 at 03:12:55PM +0800, Zhenhua Huang wrote:
> Commit 2045a3b8911b ("mm/sparse-vmemmap: generalise vmemmap_populate_hugepages()")
> optimizes the vmemmap to populate at the PMD section level.

Wasn't the above commit just a non-functional change making the code
generic? If there was a functional change, it needs to be spelt out. It
also implies that the code prior to the above commit needs fixing.

> However, if start
> or end is not aligned to a section boundary, such as when a subsection is hot
> added, populating the entire section is inefficient and wasteful. In such
> cases, it is more effective to populate at page granularity.

Do you have any numbers to show how inefficient it is? We trade some
memory for less TLB pressure by using huge pages for vmemmap.

> This change also addresses misalignment issues during vmemmap_free(). When
> pmd_sect() is true, the entire PMD section is cleared, even if only a
> subsection is mapped. For example, if subsections pagemap1 and pagemap2 are
> added sequentially and then pagemap1 is removed, vmemmap_free() will clear the
> entire PMD section, even though pagemap2 is still active.

What do you mean by a PMD section? The whole PAGE_SIZE *
PAGES_PER_SECTION range or a single pmd entry? I couldn't see how the
former happens in the core code but I only looked briefly. If it's just
a pmd entry, I think it's fair to require a 2MB alignment of hotplugged
memory ranges.

-- 
Catalin

