Return-Path: <linux-kernel+bounces-206769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1033900D76
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72CE1C2150E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E973B782;
	Fri,  7 Jun 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kVWh+fXJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E874204F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795315; cv=none; b=AOdXcd4M974SBBpBG/Gajtp8TWRAFGEz9AZxO+UkccqN5+sT7dzKaREoI+H0Qv3/8lZbeeLdYzEhQQq6XiX+/urb1NxSH7MF9z/8ycqoC7VYJ8uxc+kRDizM6xvCyJDzaiK39BCjfZxmKYhlMjCzgvUk0YjuYsp5zjUmILFcfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795315; c=relaxed/simple;
	bh=niTAMUGF7k/DXZw+eMEI5mOMYLMUkkEXdjowDG1fQ8w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Dn+kAybjtcc3Q76cF9RZ4P+eTlXpJ5m18G/tf2cIoSKe9MsJ7JgJp97J4yKa5YZQTYiZujSgFRdXE78qrwIDZ+aNpyPbhoC7qfvIvUvQ6s6IruNWn1zp7ZA3nNu1K1/UCrM63y2FAJMPt/hH2fRdeOMQOwfUqzUn6M73fCAGaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kVWh+fXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A32C2BBFC;
	Fri,  7 Jun 2024 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717795314;
	bh=niTAMUGF7k/DXZw+eMEI5mOMYLMUkkEXdjowDG1fQ8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kVWh+fXJCRkU06HQ1AEAyWPlDVLDyblp/dDq3Z0MzjYRcrIeC5lFiVeel6tz8K6DR
	 oK3kuTs7OdPeWLMHPZtFDCPaffGfBlaRdQfdzoYJ/UBCKyg+DaZzIqgWrK68VHTbOp
	 YIkhPn5+zlNK7NrVfE7YJDPYH0YeJiripgi5quyE=
Date: Fri, 7 Jun 2024 14:21:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: <xu.xin16@zte.com.cn>
Cc: <david@redhat.com>, <ziy@nvidia.com>, <v-songbaohua@oppo.com>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mhocko@kernel.org>,
 <yang.yang29@zte.com.cn>, <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH linux-next v3] mm: huge_memory: fix misused
 =?ISO-8859-1?Q?mapping=5Flarge=5Ffolio=5Fsupport()=A0?= for anon folios
Message-Id: <20240607142153.5cc922f1f2c96989dc809cd3@linux-foundation.org>
In-Reply-To: <202406071740485174hcFl7jRxncsHDtI-Pz-o@zte.com.cn>
References: <202406071740485174hcFl7jRxncsHDtI-Pz-o@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 17:40:48 +0800 (CST) <xu.xin16@zte.com.cn> wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> When I did a large folios split test, a WARNING
> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> was triggered. But the test cases are only for anonmous folios.
> while mapping_large_folio_support() is only reasonable for page
> cache folios.
> 
> In split_huge_page_to_list_to_order(), the folio passed to
> mapping_large_folio_support() maybe anonmous folio. The
> folio_test_anon() check is missing. So the split of the anonmous THP
> is failed. This is also the same for shmem_mapping(). We'd better add
> a check for both. But the shmem_mapping() in __split_huge_page() is
> not involved, as for anonmous folios, the end parameter is set to -1, so
> (head[i].index >= end) is always false. shmem_mapping() is not called.
> 
> Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
> for anon mapping, So we can detect the wrong use more easily.
> 
> THP folios maybe exist in the pagecache even the file system doesn't
> support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
> is enabled, khugepaged will try to collapse read-only file-backed pages
> to THP. But the mapping does not actually support multi order
> large folios properly.
> 
> Using /sys/kernel/debug/split_huge_pages to verify this, with this
> patch, large anon THP is successfully split and the warning is ceased.
> 

Can we pleae identify a Fixes: target for this?  Is it c010d47f107f
("mm: thp: split huge page to any lower order pages")?

It would be good to add a selftest which would have caught this.


