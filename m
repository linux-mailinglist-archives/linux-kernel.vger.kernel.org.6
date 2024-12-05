Return-Path: <linux-kernel+bounces-432597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151159E4D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4247285279
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5901940B3;
	Thu,  5 Dec 2024 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="doC4ohtx"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60E84A22
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733378817; cv=none; b=Z7vLlY+OqIIjwpbT9vOhHdPt7zP7Zv73r91YITGgY/hlUbGchLinE3h06gjZXam6OjlPSpSaMNa3tJOfC2K9PPMZR1ZtkSShuTm6Xy/CMa8dFVo38F4WIKgMdjgDJeb5YhgHpavYrZ9H6AcKQEhJ36awagRWLJlT0FyJuC/kWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733378817; c=relaxed/simple;
	bh=AZUs3vqgXldkqJCTm/lh/AuQSAonN5zQSXqe8CCP3dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQGwaZO9MZ9bIgPIlIJiSuRRejczYjpWtazaUOnNVEb9TiyjcwkxrFtX4uHDdVjWw0UonZfqA5xaHLOQCXHP+7p3O1mOkp6sqzxInE12tFbroLEGAUJxb+Y1Xw14Xqenc5/DcWUA7TG38X3gSoqxxXrZaQPiEA6ymgXVXbNSegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=doC4ohtx; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733378801; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kD4rn40nhpvirtRKZO/QK7bvfQH5Z7bhcn9RVOygKrw=;
	b=doC4ohtxRXzJebp7XR8r9vwoX36HrIolqo+OcIIHuA5ljAp7eZ1BlIwQB1u//i+kIp6IvJ7sWo2NoWU5er2LZD/KzlITQYqYNtIeF6emNqgINvka2CpjtnviLDKmElxT4VBIp8WrI3e2f/CRO4QmA7ekYo3Tsd4wI3vg6RUowIY=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKsJ0CH_1733378800 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 14:06:41 +0800
Message-ID: <48fe508d-ecb9-4607-aab6-cc18b4bc78e9@linux.alibaba.com>
Date: Thu, 5 Dec 2024 14:06:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: migrate: drop redundant anonymous statistics for file
 folios migration
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <d5e191ae02c2ab63c70cdf44877fe14fc69f5ae8.1733368611.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4x53qO1r=6=gjkZQWvc2xYR8V-t4d3t4V4o9qFobqW2-Q@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4x53qO1r=6=gjkZQWvc2xYR8V-t4d3t4V4o9qFobqW2-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/5 13:00, Barry Song wrote:
> On Thu, Dec 5, 2024 at 4:54 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Commit 5d65c8d758f2 ("mm: count the number of anonymous THPs per size") adds
>> a new anonymous counter per THP size, however, when folio_mapping() is not NULL
>> during folio migration, it means this is not an anonymous folio, so remove the
>> redundant anonymous statistics in this case.
> 
> why? Are you sure anon folios won't call __folio_migrate_mapping()?
> folio->mapping is PAGE_MAPPING_ANON for anon folios.
> 
> static __always_inline bool folio_test_anon(const struct folio *folio)
> {
>          return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
> }

Ah, sorry for noise. This just caught my eyes when reading the code, and 
I did not think about it deeply before sending a quick patch. Thanks to 
Barry and Ying for the reminder.

Andrew, please drop this quick patch. Sorry for the trouble.


