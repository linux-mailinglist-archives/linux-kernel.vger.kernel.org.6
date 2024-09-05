Return-Path: <linux-kernel+bounces-317034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A48696D873
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7D51C22B9E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76719D8A9;
	Thu,  5 Sep 2024 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qIprDKky"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215919D894
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539029; cv=none; b=OgtaNvdugjE255WajVw+0NK71oy1+zYfEez0UulJL31CvwlYXH7UINCCVK0z0uF8Fi3ctgk90stLsmFIiFZAIM9Hc38NodUc3OZkN2HVvI8cUeK+1y25B1lG5orAxFSwc6zrJHmwqzndtIL0RTWz434oKmfcGvZb35kaRD+LNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539029; c=relaxed/simple;
	bh=lNgmZ9wvfpxtqOFCCn4QeF4q00ACoBThTb81J0cvJUE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IbtZAeZsCwJn46pvg7B+Efh4w0Cmq4EoOfxUR3rWgstogRxItqIEkigJMoE/A4TP/HYPUWoJ+SWxYWxxCMOhDDCoysZdiZkrWlc4SkBNWg4N1dqAouBy7XMyHAjVydp/Q20/g546ZrTG3DJ8FVea1lvtOv/TaugRHzmDCznxRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qIprDKky; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725539026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLByLv8rw/zOL3j4lfqH8Y8PpLKTX3K0pHjcs2rvP4s=;
	b=qIprDKky84jYBcTOlWU0VsCg3PCkUABBoUNoabNnPl/kHYtmLYn6JrjyHwQZD2PlANABeN
	SWQT3EbNY1AeZs6F/KKpmrJh7OKyFFzsvYVx4NEjaerCpC5YiPojpdrWYArdGSJX3H6yJE
	rdLsViLeoTGcKRE4dGRvnpDBrtxgxck=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v3 12/14] mm: multi-gen LRU: walk_pte_range() use
 pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240904084022.32728-13-zhengqi.arch@bytedance.com>
Date: Thu, 5 Sep 2024 20:23:05 +0800
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
Message-Id: <6867F624-A83C-4A3C-947D-ECFA4925130F@linux.dev>
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-13-zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 4, 2024, at 16:40, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In walk_pte_range(), we may modify the pte entry after holding the ptl, so
> convert it to using pte_offset_map_rw_nolock(). At this time, the
> pte_same() check is not performed after the ptl held, so we should get
> pmdval and do pmd_same() check to ensure the stability of pmd entry.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


