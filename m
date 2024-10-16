Return-Path: <linux-kernel+bounces-367700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E99A058B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97EBA1C26736
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E79205E0F;
	Wed, 16 Oct 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b9yMIeNv"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA51B6D13
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070973; cv=none; b=W+gadCXix/eOMbakReOTaLx617ymUxWNCqsyQQos+8kTs95b+xn+JgqlD1wwvz4wQytE2fzTdcXmNrmo8gJOR4ZKT3sj2lGSbcc3+kGoduysmgtJefv6rbp3VKBuooFmkxGkHXTo2X2OCspnPp14BJofZIjleoRYC/D2wXe+XxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070973; c=relaxed/simple;
	bh=oNPDzVSl+xBfjTRQ3rIqVpLAXnRB+TMqhgrj7f7/HI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgKxx9qb7/B5MJWG5/H9bVjLAxPnW4AJZAf2j1yozKdvuNd5stfgDVtiQAQkJaDgRB/ZvBxSbWrDbBsL8XwF6zVE0P3hukwVem0LnJ/vtPWMgR4RzdfjMFUjY6N0zYhsxFduodov2FCJTeTArTbf+PyC+ze8Rh9eYovdlQomByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b9yMIeNv; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729070962; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xxFxERcJvuRvYGMsAAdT7h/9R3PvKzVYz/k10k5qIRM=;
	b=b9yMIeNvgTgLlDM2zQLcYU2G84+Oc6/MoXrso1U3WMFtCFbIqJO3TQJML22uae+lyY4nZHh3e+BeBsnMcgWjv5DZz6KzWB2c3fIRZZkd9uAtyrjPYc206oQrbeRJ6GKXDi6NJPHz1gQ/P0uapPcec3fbih6rvrpxvldTd0owaLw=
Received: from 30.74.144.157(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHGvQyY_1729070960 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 17:29:20 +0800
Message-ID: <584662fb-cb1f-4b2c-9075-f70d31473c9d@linux.alibaba.com>
Date: Wed, 16 Oct 2024 17:29:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <007880ac-d73f-4eef-9978-a4f844338522@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <007880ac-d73f-4eef-9978-a4f844338522@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/16 15:49, Kefeng Wang wrote:
> 
> 
> On 2024/10/10 17:58, Baolin Wang wrote:
>> Hi,
>>
>> This RFC patch series attempts to support large folios for tmpfs.
>>
>> Considering that tmpfs already has the 'huge=' option to control the THP
>> allocation, it is necessary to maintain compatibility with the 'huge='
>> option, as well as considering the 'deny' and 'force' option controlled
>> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>
>> Add a new huge option 'write_size' to support large folio allocation 
>> based
>> on the write size for tmpfs write and fallocate paths. So the huge pages
>> allocation strategy for tmpfs is that, if the 'huge=' option
>> (huge=always/within_size/advise) is enabled or the 'shmem_enabled' option
>> is 'force', it need just allow PMD sized THP to keep backward 
>> compatibility
>> for tmpfs. While 'huge=' option is disabled (huge=never) or the 
>> 'shmem_enabled'
>> option is 'deny', it will still disable any large folio allocations. Only
>> when the 'huge=' option is 'write_size', it will allow allocating large
>> folios based on the write size.
>>
>> And I think the 'huge=write_size' option should be the default behavior
>> for tmpfs in future.
> 
> Could we avoid new huge= option for tmpfs, maybe support other orders
> for both read/write/fallocate if mount with huge?

Um, I am afraid not, as that would break the 'huge=' compatibility. That 
is to say, users still want PMD-sized huge pages if 'huge=always'.

