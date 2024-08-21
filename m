Return-Path: <linux-kernel+bounces-295981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437295A3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E71F240DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B341B2EC5;
	Wed, 21 Aug 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qbtm5Ucs"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949814E2CB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261476; cv=none; b=ER0y6VKAckT1Fn9Z0SwjIFZtBwaO19BnwEjDvQLUtxxq2UFLQCsDcWOdseg1+Tt0CvJhodburAeKmN4LKXF8hKTOUAOpCI+xEbvcS7sWKFmJdu480FXwvowBClzGngu3p9EL4F4TZTFyPUr9tFVKQGTDvSLpz9H+eaNBLSBgnEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261476; c=relaxed/simple;
	bh=51DHwqWB03gpSaC7LN3sMMxph3rS0NYNBdAVa4D5lb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzEmSv24K54uwjjmOUmRABai6pGjOHprbhe5NAWmjRz6kO51CvRjCDhgQdZk58Ys67yl7qZt9fewjiafyHKbN85Hf9X754fz2ENAL7/vIu6bqsLbG4wWVSbUh3ZAJ39vmr/Q/pUqMVoZp3aw7OtQanH9Xy8wRAEXqcJqUXiyeAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qbtm5Ucs; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Aug 2024 10:31:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724261471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fmhPfPS2wR24xvWIaGUu60egFoItd/BdRJla7+wqJg=;
	b=Qbtm5UcspDSy5jmloHcKmH0Zz2HUggblhp0xHPKF7sKqbBWNyIxXVb68x2dDA4AQKc9Fzx
	KaZyPatyC30dmp+uggflhyaL1Fy7zlCAE1wc7+xA5RCMt5q0+cuajGzACla34g1lHPTkJQ
	NRCCBiorl+7QWfXVQXoBotwjnXjAhj4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: hanchuanhua@oppo.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, 
	ryan.roberts@arm.com, senozhatsky@chromium.org, shy828301@gmail.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, hch@infradead.org, ryncsn@gmail.com
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io
 devices
Message-ID: <qim6ug5d3ibrn6mgrk7oybml7qatgw654y2t6wlc25pnpddr2i@yniwf64alx23>
References: <20240821074541.516249-1-hanchuanhua@oppo.com>
 <20240821074541.516249-3-hanchuanhua@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821074541.516249-3-hanchuanhua@oppo.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 21, 2024 at 03:45:40PM GMT, hanchuanhua@oppo.com wrote:
> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> 
> 3. With both mTHP swap-out and swap-in supported, we offer the option to enable
>    zsmalloc compression/decompression with larger granularity[2]. The upcoming
>    optimization in zsmalloc will significantly increase swap speed and improve
>    compression efficiency. Tested by running 100 iterations of swapping 100MiB
>    of anon memory, the swap speed improved dramatically:
>                 time consumption of swapin(ms)   time consumption of swapout(ms)
>      lz4 4k                  45274                    90540
>      lz4 64k                 22942                    55667
>      zstdn 4k                85035                    186585
>      zstdn 64k               46558                    118533

Are the above number with the patch series at [2] or without? Also can
you explain your experiment setup or how can someone reproduce these?

> [2] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/

