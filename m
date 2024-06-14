Return-Path: <linux-kernel+bounces-214348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA41908325
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487421F22917
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F401474B2;
	Fri, 14 Jun 2024 05:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JlpOopHK"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5713CF9E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341422; cv=none; b=pAxfpWdlgRJWMFMpAZkF+wVKjE2er6A4qUO9cSXwsAvEINPDSAIzHesKPz5JwV2JvgZpdaYB/Qw5TXtIH+cUiorMVEMgttJWSX3ZsVo0+9vMnTCIVTO2G13qnCVY+jFyH4c0FX2LlfPUUIUCwUBjZMzh2wpGpa04LFIMQ+4KTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341422; c=relaxed/simple;
	bh=gzvlcPNZRXxsDB5LT29ch3OrbR0P2jmitQfMhGPzIt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4b6n/sfkzqCkM9mYesHXKhokrL1VHkc+62DoR8j97jWgJDZ9ShwoZvQoKk3z7eZj9B5TuNqVG+x46QrJiZb0MHR6D8OTKu11wm6SfxCzx4d6dRYFhOhZ2oC8JTqPXBbe3bAyuidOqCk/k0wq6UyeXXUnDJNtNkCctyMmxMYlwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JlpOopHK; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718341410; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mQK9TcRk5CAg8ht/5H2KpfQR0Jq0zPNlh/9xoAZV1ak=;
	b=JlpOopHKZ/RXRTp2lAaH/b+SPjlEkxqtNKi/9AxUTmfrK4me/T6umtPqakrd6cXf5kl3dRR06LOZe6coUCvOFnbHHOnpLB9aS2emNKeIEFiSAwTBpDHqS2HmoHDsAZlMcr4LU/Ajx9MqwXc+w2amb9E7Lnr0ghYtasyAmESmAwU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W8Q.rcN_1718341408;
Received: from 30.97.56.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8Q.rcN_1718341408)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 13:03:29 +0800
Message-ID: <58681eb0-cf36-4aa2-906e-a1a8daa2b969@linux.alibaba.com>
Date: Fri, 14 Jun 2024 13:03:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shmem: fix getting incorrect lruvec when replacing
 a shmem folio
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hughd@google.com, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 hannes@cmpxchg.org, nphamcs@gmail.com, yosryahmed@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <5ab860d8ee987955e917748f9d6da525d3b52690.1718326003.git.baolin.wang@linux.alibaba.com>
 <Zmu3YVFfUA6_uToA@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zmu3YVFfUA6_uToA@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/14 11:22, Matthew Wilcox wrote:
> On Fri, Jun 14, 2024 at 08:49:13AM +0800, Baolin Wang wrote:
>>    * Charge @new as a replacement folio for @old. @old will
>> - * be uncharged upon free. This is only used by the page cache
>> - * (in replace_page_cache_folio()).
>> + * be uncharged upon free. This is used by the page cache
>> + * and shmem (in replace_page_cache_folio() and
>> + * shmem_replace_folio()).
> 
> Please just delete this sentence.  Functions do not keep track of who
> their callers are.

Sure. This sentence seems less helpful. Will do in v3.

