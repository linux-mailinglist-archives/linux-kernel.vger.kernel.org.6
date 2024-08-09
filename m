Return-Path: <linux-kernel+bounces-280599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFF394CCAB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9761C21177
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3F118F2F2;
	Fri,  9 Aug 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r93xRSeY"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27A18DF90
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193389; cv=none; b=F1mmn3ktMTSBioKeZQpUuAlM2AZnQZuieajO+y3UOPscCLC05bI/l6gu20a1bHJwWj0E/j4V2yrouBK4FP5UldbA1fGgBDBXm3OOaPBeNTsoAbq2FfJSCL/VzvWHKa94AVoPyp8zyiLXk/6hfjaxj3zBxPm7HlXw0WT2dAavD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193389; c=relaxed/simple;
	bh=kfluqN47HEtbxIJWy2POyylc52Yt7u6LsH0dEZwM80I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9Z6dOIS/dRQttLKh7DgWu4F88KMmtJxV2I9seUlTp2dScWX+n3vmPVlNHezbIfNH07GyBqRiaZkRcbrW20a/yOLtw8yB7F2tfM+d6oAGVRSan745kuqTrUkuyCY3hPNYGf3UZHARkRO0zDAvjv0obSYjiqRo7aCpMRQ9XTDJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r93xRSeY; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723193378; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v735RVctRBsqjVupaGoWDIxDgHTs5L6iQ8ikKwU0ucM=;
	b=r93xRSeYKkrXwruE335ABvSdacQo2r63pY+sPVIjfxdR65PedFFWsPCcYF93jUMkj0/VlNgNMRtuyekC6YExyggtHCr65uD0HYhflbMsX7+DoDYXJNaaK8minT6hu0DXFCxryNeDgxO36tfeJeZ+Am/elIXo5GV4lMd511TdS+A=
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCPbjOA_1723193375)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 16:49:36 +0800
Message-ID: <190cd7eb-6881-4e6b-9d6b-e7921404ebcf@linux.alibaba.com>
Date: Fri, 9 Aug 2024 16:49:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240808101700.571701-1-ryan.roberts@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240808101700.571701-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/8 18:16, Ryan Roberts wrote:
> Add thp_anon= cmdline parameter to allow specifying the default
> enablement of each supported anon THP size. The parameter accepts the
> following format and can be provided multiple times to configure each
> size:
> 
> thp_anon=<size>[KMG]:<value>
> 
> See Documentation/admin-guide/mm/transhuge.rst for more details.
> 
> Configuring the defaults at boot time is useful to allow early user
> space to take advantage of mTHP before its been configured through
> sysfs.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Make sense to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

