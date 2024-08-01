Return-Path: <linux-kernel+bounces-270008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 821AF9439E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B46EB231FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A962E83F;
	Thu,  1 Aug 2024 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DCOktUAy"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C4DDC3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470829; cv=none; b=IoVZqjXUy054Dt5n8iTQT9Ad0KC7bG6xVvC9AXCErspWApLPP5oWoY2qQkx0O6SW46fABE7Ojst0nSXmAmvQX9DX8sJxrTSkdHNhGMJkymT8od5DELuNqlEa1DkQrOOpBb6lWqTwVOrFExnlGFqYFLyBrI8k/NCGYMbbb1iUmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470829; c=relaxed/simple;
	bh=tGhE7dHx7wNSxwaE5IX+q/jUitxSG0qURNcG11gK3Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqhvNCKv6JGAXVWlh8WA+XZEannssskPCK46hWZ07h70DNUCQlWvj2xsKA08e60ZCNRRyGSyy2Z7m4fNtEbrhFSElNz6iErYBSTWEr7u1yYwMFPxLdq+ydF5QIADIWt1AC2l7CtNGdfUYRSXQv3trX8Bg8ex519FGt56Q/uOuJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DCOktUAy; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722470823; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/igXvqw18qVF2zmotZohpJGkkEEriAFTOJ3JtjdZ20g=;
	b=DCOktUAy8eBq9ZYz8Chm/nHAZw8lSP/iZsUcJd6vB1qSIPxMzeZQXdArzUckO1CbnoipSUyzfH/Z8sBMbIrpXfrnyw61FGUI1wtkMytF+a1YkLeiGx0B+n9cKmbP+GbLeoPjWPPrM2TzNsGNSD9iH9AdkYYh/TON1+bNnazESZo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WBkjv0N_1722470820;
Received: from 192.168.0.100(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBkjv0N_1722470820)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 08:07:01 +0800
Message-ID: <bf97923f-b59a-4d91-95b5-67e555fb4cd3@linux.alibaba.com>
Date: Thu, 1 Aug 2024 08:06:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than
 MAX_PAGECACHE_ORDER for shmem
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 hughd@google.com, willy@infradead.org, david@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, gshan@redhat.com, ioworker0@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xmHY06VAKzXxCFcovPkrR0WOR28jXbaeD5VyUBHWzn_w@mail.gmail.com>
 <c55d7ef7-78aa-4ed6-b897-c3e03a3f3ab7@linux.alibaba.com>
 <87769ae8-b6c6-4454-925d-1864364af9c8@huawei.com>
 <ba3e3dfa-d019-4991-9e3a-d73ffa83bb36@linux.alibaba.com>
 <20240731134802.00541e78813997f3c59df36c@linux-foundation.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240731134802.00541e78813997f3c59df36c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/1 04:48, Andrew Morton wrote:
> On Wed, 31 Jul 2024 18:22:17 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> (Hope Andrew can help to squash these changes :))
> 
> I'm seeing some rejects against, amongst other things, your own "Some
> cleanups for shmem" series.
> 
> So... v2, please?

These two bugfix patches are based on the mm-hotfixes-unstable branch 
and need to be merged into 6.11-rcX, so they should be queued first.

For the 'Some cleanups for shmem' series, I can send a new V4 version to 
you after resolving conflicts with the shmem bugfix patches. Sorry for 
the inconvenience.

