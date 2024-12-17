Return-Path: <linux-kernel+bounces-448551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5639B9F41AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A0C7A594D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816F1459E0;
	Tue, 17 Dec 2024 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LXaekjb7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51F20EB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409294; cv=none; b=T/xiMY2vhf1mMNHBx/QmFHFMhdF5RtVhGiLxGZkUD5IxvzYApLFWxayNDAJ+g6fUTpRG2DKwU8FEk7gDJgLkn0PTq+YP1w/rBjcF3LX5MuKsLHBLsGAoQ9xw10Y4/Ywb9QBSH0RHAN7+HP41XAxrVTcwvfBHlZE1OqI+Zv1rL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409294; c=relaxed/simple;
	bh=aZ2EcQxzOb2jGPci172XXahWMiPByitIKJEBOqWDwcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kX589iWPBZgSRW/sCA0kbvTA5dgZeQfV8xfzw9ei4EltCA1YDOaEdHf3v11NLopUC7gpctso4R9MVTyELR6mnXOnAhsNoRueiSWbOf6jDhMFoqnKEtjWsUPLYOu7j2joNzNd+NU/38dXulqGBXuJax+r29V9Xm9mfX3yiuEEqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LXaekjb7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hAcL59h0GQpMGtkVhZwp0hPd9hWBhp82FhY6yshm8lI=; b=LXaekjb7Npj8yub1K2C+azHVQ/
	+TqN7sL0h5Ya6wJUNbPOslNk0UflzhZT75S/NKzapWaJt2OLS7e7xfTTw45fK8BPJn46YUNXLVsGU
	N4pt8Vitm4IE59tfdb2PrIWg6vWRBIuAgAGsCDh5xKJ3zRn0leHCa8Q9/1b+hvzUePFKHcZMIscU3
	7oSm6xKlFmQ+FLy1ybq6kt42JAOfoNGB0doixB4IxBk9EqubSARe4eZtY4Sv/lEROPYqcIIIHpTZd
	x9Fm4JJ8PiJgQ4sj4XuJWTu4tuASBp0LoQsDOM7OGFowPdPLgfgl65LbepIY5A0QFgI9bBoJUQnn4
	ULjk40aQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNP5G-00000004mKw-2WJp;
	Tue, 17 Dec 2024 04:21:22 +0000
Date: Tue, 17 Dec 2024 04:21:22 +0000
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
Subject: Re: [RFC PATCH 03/12] khugepaged: Generalize
 hugepage_vma_revalidate()
Message-ID: <Z2D8Qr44vqWpH_Om@casper.infradead.org>
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-4-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216165105.56185-4-dev.jain@arm.com>

On Mon, Dec 16, 2024 at 10:20:56PM +0530, Dev Jain wrote:
>  static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  				   bool expect_anon,
> -				   struct vm_area_struct **vmap,
> +				   struct vm_area_struct **vmap, int order,

orders are unsigned.  i'm going to stop leaving this feedback here, but
please fix the entire series for this braino.

