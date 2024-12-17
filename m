Return-Path: <linux-kernel+bounces-448549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19FE9F41A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D836188BFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4366146A72;
	Tue, 17 Dec 2024 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QhlTsbOy"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3B13D25E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409139; cv=none; b=K7WtR1SEyIZfvLJ19DASInv4+K15VCrFfrvhyWIUoFY8mh6ykxhs1A6K/zxWDcxL8BAtUzD7WCYdMNQzs457MN48hnWYdzkIYaQoZlHcr7b5tBsjUeHFkyrfX/x5sYOY9itKxMUoAIhFhqzD1FDkNTsvSn0gBhW/3Z3e3S8mUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409139; c=relaxed/simple;
	bh=JKfcMQFKanOL382OEtXsFpWgzlx/VQtBtNbeHdHhIoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2fuLDppKFMhdfefx4cdSMTNc9p31Lh84cW3ihCupFq79H7e4+MfWH867Tr0dO3H37hVWm3RKvja6gHPbLbEBk6z+PY2otz7ls61xF/a6tJmSTOw0ZFwzg1gTQQ+/aLQxxRiF1fU4my3laHMhBUnLX+2TcPTDVU1afhw7pb/OnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QhlTsbOy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1D+XKhJk9ymqV5sTmoJI6P/Mt0BSO+u7JfRP7/qbYs0=; b=QhlTsbOynmb5xT3IMKisXJfVNh
	kROikzhwdr/QeverW/9/Pki0Qu+iv72RmGqc/RPk4Yjr4xk88Xk5d5whWW/BUhFVfQEnJntazObdn
	SJjuseuZM5L7CMLS4EFib9Be9jOBjmqxJfBuFYsniIsC7PMsVINgexqs1pAtAaXRn+jpICS0oWQtq
	mOSiqSvNzjbREnEGdx3+gppJOWeZBhCi1XbX31oOGwUCDBpBuS5+F0aWjDUk+wt1p05Xb7EwtWI8G
	1GrufdwR6B059A8SAzY3vO8SX6lKJV26NaokyFiJwo4ChNQpmzBVpyRbybiWw6dxl/QZoM6CGC+mM
	suY5qoBw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNP2l-00000004ljY-0z2L;
	Tue, 17 Dec 2024 04:18:47 +0000
Date: Tue, 17 Dec 2024 04:18:46 +0000
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
Subject: Re: [RFC PATCH 01/12] khugepaged: Rename hpage_collapse_scan_pmd()
 -> ptes()
Message-ID: <Z2D7pi1Gl4Bq-ln2@casper.infradead.org>
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-2-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216165105.56185-2-dev.jain@arm.com>

On Mon, Dec 16, 2024 at 10:20:54PM +0530, Dev Jain wrote:
> -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> +static int hpage_collapse_scan_ptes(struct mm_struct *mm,

i don't think this is necessary at all.  you're scanning a pmd.
you might not be scanning in order to collapse to a pmd, but pmd
is the level you're scanning at.


