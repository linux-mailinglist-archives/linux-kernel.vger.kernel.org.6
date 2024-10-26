Return-Path: <linux-kernel+bounces-382887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42869B147F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850501F22B7B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7244D146A69;
	Sat, 26 Oct 2024 04:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ITIxwkFU"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF8E13CA93
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729915273; cv=none; b=cq2j9sR282d41BRYrc/bIsIQKRKOWbM5BByLegADoJRgxXTo5SqCdfs98ktY4lWwmKxeaNy5jBf7axECE1OSDzhnWcP0VeZzY4B7a2qMC/OoIe3ONmrD5/G5UprVXzDnXA3bA0zVDFBUSQOiJSPNSXIpmcwhqNKk7KeRZyYevbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729915273; c=relaxed/simple;
	bh=4EZ3d1UlteexM+K+BBK+MaKCU/DLwbA3xw7TmAIU27M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6zXrEJ33TK6x1bY6sVGjYyN5H0rXxpfcjBneuczWQwf6cu0WM8jcj3vu/ohNvqXSHvZx9Ap//ETP5l+9yX7Ov2SITr8qqyP87c3MqJ5/mOCBNAIf0B5M1JjsECTZJOWu4COUZTVyQ3MsVc0l6zxIi32a0h/l9DCLNGOlkHTa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ITIxwkFU; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729915266; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=94xNPQ7reY27xXutMfor02Xwq25M9OnrXWxLpCbP0ak=;
	b=ITIxwkFUR89cjBGGLHNjd3Ok3WFaqLEbDxrjsVLduQd2LSNXjIp0dwwM3CGGLmlPndGnOzet3zHZHFE+DXoMdo5A8V+WbEGHW8mWfZTZAcpJA7viVyQ4bvn+MQSggUrQ6T65Z/ImIpsVVBFXbieG7Chtl1LH9v3KCNJik2DRgkk=
Received: from 192.168.0.100(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHu3gJ3_1729915265 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 26 Oct 2024 12:01:06 +0800
Message-ID: <37c82981-42bd-4208-88bc-5de234e6db13@linux.alibaba.com>
Date: Sat, 26 Oct 2024 12:01:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fallback to page size splice if large folio
 has poisoned subpages
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, hughd@google.com, david@redhat.com,
 wangkefeng.wang@huawei.com, shy828301@gmail.com, dhowells@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <fd3893f318493a3720dc1a4b1c33f0f692ddf125.1729825743.git.baolin.wang@linux.alibaba.com>
 <ZxsRCyBSO-C27Uzn@casper.infradead.org>
 <01423085-1622-41ed-a882-64291f3e97ab@linux.alibaba.com>
 <20241025154527.31873b55fb75d778c431f5ef@linux-foundation.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241025154527.31873b55fb75d778c431f5ef@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/26 06:45, Andrew Morton wrote:
> On Fri, 25 Oct 2024 11:41:28 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>>
>>
>> On 2024/10/25 11:31, Matthew Wilcox wrote:
>>> On Fri, Oct 25, 2024 at 11:26:39AM +0800, Baolin Wang wrote:
>>>> The tmpfs has already supported the PMD-sized large folios, and splice()
>>>> can not read any subpages if the large folio has a poisoned subpage,
>>>> which is not good as we discussed in previous mail[1].
>>>
>>> folios do not have subpages.  folios have pages.  do not use the term
>>> "subpage" anywhere.  ever.
>>
>> OK. This is my previous habit of naming it. Will change 'subpages' to
>> 'pages' for folios.
> 
> While at it, please try to avoid depending upon references to previous
> email discussions.  The links may be bad 10 years from now, and it's
> laborious for readers to trawl through the online discussion archives
> to extract the information they need.
> 
> Including the link is fine, and potentially useful.  But please also
> include the relevant information right here in the changelog.

Sure. Will do in v2.

