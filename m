Return-Path: <linux-kernel+bounces-369532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAAC9A1E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1811C20CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E5F1D8E01;
	Thu, 17 Oct 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="im/q6anU"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC612DD8A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157664; cv=none; b=oWEp3moyAc5o3nVE8JTsZZJ9G3CBAFpbVvQo1Jh8jbZl8mWL+RMrZbnQ8FW35SPGvfSIP9YyRcYPSQdLIBLSD4GHb01nH97c7n7xQTmMW7LI0ACQHB5OVbLYI2pgWuS/ii/3yJ/VDE1xFkl56fLIa4WPIFJJg/7j+lHKoZ9LQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157664; c=relaxed/simple;
	bh=8DiJ116WBvHLJaZn6Sk2ag6W5eqEa6BwsSJn3pyW+B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVNz0JSPUHdRinfWjxTA9+U1g0v7GrYZdtYlfLUSQIqGNRbKL0VuwNPtw8HteuDxfSWf1fCRo5I3rOBgJd46c+kZq5Jj9m0omwd0bYThUDWZ8gRZ/CmvCfmQc3V3n5k4ZDGtER3ehTvmaJk4y0gjZCbr+25XRwshnrvw2rMPMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=im/q6anU; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729157658; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RUqGXU3RkHzyvCYbooGPW1iKMjc3Qe6ArGx8XaGP3HI=;
	b=im/q6anU85F6wppsleZ47LLswk3XOH1B4QE6tYXEt/WasMssgLiZVlNK7/5VInXc9NqYRcUhzm/v5gET0r8pAauw1QwTJLSZGULT3ihR5sNVBXexjH0n2BSnwUBNqN0cCt7SBkKhjUvcbvg1659bi5dSXID01ZXO0o8Mc+I5pTY=
Received: from 30.74.144.140(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHKPiJ2_1729157655 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 17:34:16 +0800
Message-ID: <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
Date: Thu, 17 Oct 2024 17:34:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 wangkefeng.wang@huawei.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 ioworker0@gmail.com, da.gomez@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zw_IT136rxW_KuhU@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+ Kirill

On 2024/10/16 22:06, Matthew Wilcox wrote:
> On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
>> Considering that tmpfs already has the 'huge=' option to control the THP
>> allocation, it is necessary to maintain compatibility with the 'huge='
>> option, as well as considering the 'deny' and 'force' option controlled
>> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
> 
> No, it's not.  No other filesystem honours these settings.  tmpfs would
> not have had these settings if it were written today.  It should simply
> ignore them, the way that NFS ignores the "intr" mount option now that
> we have a better solution to the original problem.
> 
> To reiterate my position:
> 
>   - When using tmpfs as a filesystem, it should behave like other
>     filesystems.
>   - When using tmpfs to implement MAP_ANONYMOUS | MAP_SHARED, it should
>     behave like anonymous memory.

I do agree with your point to some extent, but the ‘huge=’ option has 
existed for nearly 8 years, and the huge orders based on write size may 
not achieve the performance of PMD-sized THP in some scenarios, such as 
when the write length is consistently 4K. So, I am still concerned that 
ignoring the 'huge' option could lead to compatibility issues.

Another possible choice is to make the huge pages allocation based on 
write size as the *default* behavior for tmpfs, while marking the 
'huge=' option as deprecated and gradually removing it if there are no 
user complaints about performance issues.

Let's also see what Hugh and Kirill think.

Hugh, Kirill, do you have any inputs?

