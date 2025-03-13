Return-Path: <linux-kernel+bounces-559500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFE9A5F49D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4C41894AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F02676D1;
	Thu, 13 Mar 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ih6ck80Y"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FBD26773F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869144; cv=none; b=HOAWi/VpQLtHpB7OKVV2XMAMV1CPL89qRZbOOH27u4Vg+uM2mVClrzUQqvq1taHvM4jEQBkkVn7bLTC9vO0ZXvaYtcXVB8CzaeGPOVT9+BMRYmuMUp/uX6HwYSXyRGeEPH8oegv5tkzkFYUXhtnPR5f1Nhm2UZiJBQAosrEv5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869144; c=relaxed/simple;
	bh=ZgEPulKBm/ZpVRoQL7qKZMmIIIu+u3FVz8IAYkTPMhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIMDTlcK6fTYk3aVfsieqZ4/lqF944l0vcbQDQ/7qWqWK7wxyTbzm0mohfMlYvD5e55vk4nB4/gtmfcXVncSNIt/evQF+DBjgoZZWLi7tXW8cIsU5Ic00iFqkClQkd6DLpjR/HM19bdTfV4asME3VoLVVkbnP4NMUH1uiYO1pZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ih6ck80Y; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741869131; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3WDK/Qfa9S1cCBkG0hM40846x6GSEdu8RcSL8OPjHcs=;
	b=Ih6ck80Yb1U2TGdnhcYr8ijRW/PQYDWgkB7hGHivty5qvFFGhN+U/EFSICuwfys9VuMTxy2H2d3TAC9dfZ95Eanuxd8SkRrQGSdPxnuxw9R9iVAbW7r3FoCYkmnU5E7wArJx4Pksqvp8LczGr8mee3DtYmkL0Eh7jCImLUcWuMA=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRGv2EA_1741869130 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Mar 2025 20:32:10 +0800
Message-ID: <751a34e5-5305-4c7f-9568-57cb6931c51b@linux.alibaba.com>
Date: Thu, 13 Mar 2025 20:32:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] erofs: 48-bit layout support
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
 <695b5311-d0bb-422c-9a96-52cfcc72afb4@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <695b5311-d0bb-422c-9a96-52cfcc72afb4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/3/13 20:06, Chao Yu wrote:
> On 2025/3/10 17:54, Gao Xiang wrote:
>> Hi folks,
>>
>> The current 32-bit block addressing limits EROFS to a 16TiB maximum
>> volume size with 4KiB blocks.  However, several new use cases now
>> require larger capacity support:
>>   - Massive datasets for model training to boost random sampling
>>     performance for each epoch;
>>   - Object storage clients using EROFS direct passthrough.
>>
>> This extends core on-disk structures to support 48-bit block addressing,
>> such as inodes, device slots, and inode chunks.
>>
>> In addition, it introduces an mtime field to 32-byte compact inodes for
>> basic timestamp support, as well as expands the superblock root NID to
>> an 8-byte rootnid_8b for out-of-place update incremental builds.
>>
>> In order to support larger images beyond 32-bit block addressing and
>> efficient indexing of large compression units for compressed data, and
>> to better support popular compression algorithms (mainly Zstd) that
>> still lack native fixed-sized output compression support, introduce
>> byte-oriented encoded extents, so that these compressors are allowed
>> to retain their current methods.
>>
>> Therefore, it speeds up Zstd image building a lot by using:
>> Processor: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz * 96
>> Dataset: enwik9
>> Build time Size Type Command Line
>> 3m52.339s 266653696 FO -C524288 -zzstd,22
>> 3m48.549s 266174464 FO -E48bit -C524288 -zzstd,22
>> 0m12.821s 272134144 FI -E48bit -C1048576 --max-extent-bytes=1048576 -zzstd,22
>>
>> It has been stress-tested on my local setup for a while without any
>> strange happens.
> 
> Cool, good work! For this serial,
> 
> Acked-by: Chao Yu <chao@kernel.org>
> 
> Hoping to grab continuous free slots to check the details, then we can
> change it to rvb status before merge window. :)

Thanks, I don't find any issue so far and users would like to
get 48-bit addressing and quick Zstd compression. It's not a
complex update anyway.

Thanks,
Gao Xiang

