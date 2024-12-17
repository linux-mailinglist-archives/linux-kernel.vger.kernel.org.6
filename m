Return-Path: <linux-kernel+bounces-448553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695BC9F41B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F0C7A40EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491091474A0;
	Tue, 17 Dec 2024 04:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5izOBbt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F020EB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409460; cv=none; b=nlkS+P4wzJBKEw+I/GD/yNbzLToH1N7wAZANInvu8V0iAv2vPJWMzE2qm/qyGxBMYpvX/Q9NpeFaCchD27D+XbrizEgpxpAdOQUA/7VYo34D2p2Ts/KT296ZE5Xs8dnLXmt9w1rS6LhwdfULF7xaWbfcH9YSfxLPPbIHkHsrWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409460; c=relaxed/simple;
	bh=yCFQ5kWHY8froD96LAwUgIlcVS9jQ8pv1EaHQmxl//8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMkIC+loGFhekhiYh58KcPFFDidiUmkV9pDLq0f9svFNks0g19MbqIwh+gHN3LPSE9WpYPEp5L2OYeLr8ml79WSLcYyUuo6YXGbtgOM87gmiM8Im0sjSGrWA9AG6oa1RwSnjf7lzAKP62XVVodYHzsOyfAgqDhufxm9Kjg6yGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g5izOBbt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S3sdy9COIHMptZ2rmncZFjXh5RjrlQ79/mrtvG0Hyvg=; b=g5izOBbtdijfpIFwg8hEsTMghG
	3UI5TPekXE1ElVCTZgZOYo2eRQQJuNwz9mY2jvJQkyyj6JVUxC7RehRLWGyEnlXyet3sxmVoe33IV
	DDbfBrkxw1LrbRE48FCDXOP8++n7c5/slsXv04STbDk7d0up4c5JUdBUYkjePw3g0AstYLxzabSBM
	ggHPKKl4+pbhfWn+HLHuq7TwcmZ0mMxkojoEdBdktkhpVDWZefMkIL+UXFIV7B0R1S6WjDJmV7jgE
	UPmeXnIx11qzFegEkAAqClTRgWfuGeZaTmzZK0zviEqub4I/1W2x7UY4cCOcG8dFmVKmAiDSTxc+X
	pbfi7Rbg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNP7x-00000004n7A-1Ehl;
	Tue, 17 Dec 2024 04:24:09 +0000
Date: Tue, 17 Dec 2024 04:24:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
	kirill.shutemov@linux.intel.com, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
	jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
	hughd@google.com, aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com,
	wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com,
	surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com,
	zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/12] khugepaged: Generalize
 __collapse_huge_page_swapin()
Message-ID: <Z2D86Nl41ZNvNSnJ@casper.infradead.org>
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-5-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216165105.56185-5-dev.jain@arm.com>

On Mon, Dec 16, 2024 at 10:20:57PM +0530, Dev Jain wrote:
> -	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
> +	unsigned long address, end = addr + ((1UL << order) * PAGE_SIZE);

addr + (PAGE_SIZE << order);  


