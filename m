Return-Path: <linux-kernel+bounces-341238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB91987D16
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB0D1C2263A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF616C451;
	Fri, 27 Sep 2024 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ecW4kGMt"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E86158203
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727404612; cv=none; b=ra+A1Kg76W/RzlV/Ky2gsj7RaNxit6Xd8+wBt692Pz9gjqvbs3duLQZBJEr3tt3itRey0JXSJXQMYWPGMWqw8vMk9QQnuMADJTh8BrqYyevzqDiFLnTU3UNqSxG6v42OKqkRZwIbtZssIUoGytAWhukxS147II2qLP/CEpiF2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727404612; c=relaxed/simple;
	bh=o7Dgn1kutRKWMQL6mmv0xxwdYBsCLP4Ydnd1NbMwJWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAXJuznSIPytnNkwkejqqWnGDYi6YYuk6LiCejYbSE/+O+Z7wdBMTHV9J7F/XpOZUllGAiuowDFRbn3axBXoxRFI9VbtpL93vCr7k4wbv+7boyg/CCNQVDO9TJAp+uQNV6XJKRjHHP6LNoSG/BRQgzDbexPrhfaS227/Ahi/jLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ecW4kGMt; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727404602; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3DirFBBLsGZoR5mffHo1eYqOeuH3dk7sCjq7ZC7LMd8=;
	b=ecW4kGMtPu5068ABu5MuJEittEB8cp3VW1QKObG/ZR8X4+dNfm9GG3+VkjAFHwy5jo48Z3WIIZPFmSpVeBVqUTLhsGyU/cczYAsg9oz6nV5qdVQo/7W8mvPUIuACqfUnXVVjBFGNWgm2eXpz6wNSQ6m4eh1QgiIXzlXRAfMGhOE=
Received: from 30.74.144.105(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFooSAm_1727404600)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 10:36:41 +0800
Message-ID: <300de9ce-7a3d-4495-a232-c7cb419289a5@linux.alibaba.com>
Date: Fri, 27 Sep 2024 10:36:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] Support large folios for tmpfs
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 wangkefeng.wang@huawei.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 ioworker0@gmail.com, da.gomez@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1727338549.git.baolin.wang@linux.alibaba.com>
 <ZvVRiJYfaXD645Nh@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZvVRiJYfaXD645Nh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/26 20:20, Matthew Wilcox wrote:
> On Thu, Sep 26, 2024 at 04:27:25PM +0800, Baolin Wang wrote:
>> This RFC patch series attempts to support large folios for tmpfs. The first
>> patch is based on Daniel's previous patches in [1], mainly using the length
>> in the write and fallocate paths to get a highest order hint for large
>> order allocation. The last patch adds mTHP filter control for tmpfs if mTHP
>> is set for the following reasons:
>>
>> 1. Maintain backward compatibility for the control interface. Tmpfs already
>> has a global 'huge=' mount option and '/sys/kernel/mm/transparent_hugepage/shmem_enabled'
>> interface to control large order allocations. mTHP extends this capability to a
>> per-size basis while maintaining good interface compatibility.
> 
> ... it's confusing as hell to anyone who tries to understand it and
> you've made it more complicated.  Well done.
> 
>> 2. For the large order allocation of writable mmap() faults in tmpfs, we need
>> something like the mTHP interfaces to control large orders, as well as ensuring
>> consistent interfaces with shmem.
> 
> tmpfs and shmem do NOT need to be consistent!  I don't know why anyone
> thinks this is a goal.  tmpfs should be consistent with OTHER FILE
> SYSTEMS.  shmem should do the right thing for the shared anon use case.
> 
>> 3. Ryan pointed out that large order allocations based on write length could
>> lead to memory fragmentation issue. Just quoting Ryan's comment [2]:
>> "And it's possible (likely even, in my opinion) that allocating lots of different
>> folio sizes will exacerbate memory fragmentation, leading to more order-0
>> fallbacks, which would hurt the overall system performance in the long run, vs
>> restricting to a couple of folio sizes."
> 
> I disagree with this.  It's a buddy allocator; it's resistant to this
> kind of fragmentation.

Fine. Thanks for sharing your opinion. So far, I can drop patch 2 to 
stop adding mTHP interfaces for tmpfs.

