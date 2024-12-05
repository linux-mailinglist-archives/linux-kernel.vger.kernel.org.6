Return-Path: <linux-kernel+bounces-432617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EB29E4DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5253E18813CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CBA1AA78E;
	Thu,  5 Dec 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PawPcNZx"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6819342D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381421; cv=none; b=qX/hoKf6YsSxNr6XYQx/UyeT1Rvm9+TkTU+Irp7U6i+nbiX4JwDqNiRMxMIMr5Vt/I4WZP2oxR1rrhOJU6ze5rutt0jMd9ukxjNZhJIX+fBxmnRRct63xLImTwdJYTHRud2PD+mOpz3a2cCcPvf2FYZWZt7WYD035hDGUtnIs2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381421; c=relaxed/simple;
	bh=C7E1SKyRyPmVMCbb6mf4aN6dMgtnZd3bIQwyDvskf/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrjrsZJrBWveaSYgoFqYJkIy1V3iAZMM/Muj507HrYcGJi2Her3of0f3pGyc/Emw7DrZB+7nUSf6q7HzviVXucFR+cbF0GG+RD5z4/zIfCasaXq8P6teeJomPDbL708zxoRM5sTRWzEe5brnLcvjaS7Lj8+LqIkpwVkBYhkueXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PawPcNZx; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733381416; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=T6mHsMiu1ngXUZZ8XsIizZ75Pq7HYldFMfXbIXzmoWQ=;
	b=PawPcNZxVx0Zg1KfAeDfi8HczZKZfwEhYFLKl+DD/CFYRzOShgI1INJ7Pu/7RWLHayqql9G/77Eoa0TiXvpoHE0JNpU77D+DRA+M2v2Ao2E7xmI1PjjsmHB7GIdx7Fg7mQPlxSNZCkyAcIMOzeEmwReUKba3C3BXKGiqJQT20AU=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKsFV69_1733381415 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 14:50:16 +0800
Message-ID: <6896a7ab-b6f6-4b2f-944a-c1c3f731bead@linux.alibaba.com>
Date: Thu, 5 Dec 2024 14:50:15 +0800
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
 <48fe508d-ecb9-4607-aab6-cc18b4bc78e9@linux.alibaba.com>
 <CAGsJ_4xZDrCSjv5NA7T_yDyjKbCB8XsADPQxCnq2qRO8gU=VaA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xZDrCSjv5NA7T_yDyjKbCB8XsADPQxCnq2qRO8gU=VaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/5 14:33, Barry Song wrote:
> On Thu, Dec 5, 2024 at 7:06 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/12/5 13:00, Barry Song wrote:
>>> On Thu, Dec 5, 2024 at 4:54 PM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>> Commit 5d65c8d758f2 ("mm: count the number of anonymous THPs per size") adds
>>>> a new anonymous counter per THP size, however, when folio_mapping() is not NULL
>>>> during folio migration, it means this is not an anonymous folio, so remove the
>>>> redundant anonymous statistics in this case.
>>>
>>> why? Are you sure anon folios won't call __folio_migrate_mapping()?
>>> folio->mapping is PAGE_MAPPING_ANON for anon folios.
>>>
>>> static __always_inline bool folio_test_anon(const struct folio *folio)
>>> {
>>>           return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
>>> }
>>
>> Ah, sorry for noise. This just caught my eyes when reading the code, and
>> I did not think about it deeply before sending a quick patch. Thanks to
>> Barry and Ying for the reminder.
> 
> No worries. I recall encountering a negative count during the development of
> the original patch and eventually realizing it was due to forgetting
> to increment
> the migrated anon folios. Your patch seems to reintroduce the bug I encountered
> back then :-)

Right. I was blind and need a cup of coffee:)

