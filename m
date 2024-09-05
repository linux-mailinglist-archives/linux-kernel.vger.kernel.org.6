Return-Path: <linux-kernel+bounces-317036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F9996D877
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBC01C2549E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090E619DF79;
	Thu,  5 Sep 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IbfmN4E+"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684C19DF73
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539062; cv=none; b=ZBFa/3Padx7sL71BpwSZXrcyg+AJkj+1M7f0GfSWA2AbzLogg7tQtZyhUcUareP/yX1pVtD1claEO8l/fZKeXAf99rCpBDClLIiSfRwNnlhSX9EyymbB7ccjapIxYICaxZpraIOML0/grAK0tKb88QEeEyoiFCy/pP43DtFXqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539062; c=relaxed/simple;
	bh=v6BraLcaitwDC6Anj8ptLgd36AqBEB8q7TrEpy125yA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZjpzOnIkplExkWDyoX3+gbeOSXwaK3x4Lp7ExEN+AgoeMS9YFC+/+M1tKviLXbZPNpQdMkqnCMYAM87TGaK4zQpv8c0qTv4SNRmG5oPFcw/HPQeK9n23HqJFmQvsDWRNIhdXAEQJd+Aqi2jXd3on36+Decdj3OfkpsBY9pb7ysY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IbfmN4E+; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725539058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gz1yGhbZpgLoXsIxhz2uE7McRGPNwSJIR5f5xqDCVYw=;
	b=IbfmN4E+hY5GdZdW3kzN35EwKMbO/B59nTdimCMm7n7hbuasFapv9oc/4nSaHcdtDM9AZl
	fl+4kluQcnMSAxiEJUtwokk7fx7aQyKc4TpoWLrENMSinKQ7nLlEi5VTvJw0abWcdChzYX
	0ZUBr/L4TFbDm9dAPKU4Q1+r3jTRrLg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v3 13/14] mm: pgtable: remove pte_offset_map_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240904084022.32728-14-zhengqi.arch@bytedance.com>
Date: Thu, 5 Sep 2024 20:23:44 +0800
Cc: David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 akpm@linux-foundation.org,
 rppt@kernel.org,
 vishal.moola@gmail.com,
 peterx@redhat.com,
 ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: 7bit
Message-Id: <13E28978-C156-45CA-A57B-15C4AE668C9B@linux.dev>
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-14-zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 4, 2024, at 16:40, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> Now no users are using the pte_offset_map_nolock(), remove it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


