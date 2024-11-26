Return-Path: <linux-kernel+bounces-422391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB869D9903
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5CBB28EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95201D515E;
	Tue, 26 Nov 2024 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m6ijNUAH"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA211D5AA0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629549; cv=none; b=V3Z5qnPBU22dPXvDCi15heORBsOY5CJGwrVWHnso4NzzklftJiwEsiGhtyLROeFS3/qJtvQk7JhCG5wOweS+8HWvpicQ1JpLLuXY4mGT7k7pVUAprv5nIYSlZfc07C1alDwj5FbwrGVXt6AD68a1lJNQRuWcswJ//HBNuB2Jdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629549; c=relaxed/simple;
	bh=in6tCZLiGGYH2wiuo1Z96rJXvL3VxDFDS1yUbJRzmFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8WslaWnqNeXyK7aYr2wkoQK6FRUfudKjoB6/CFue1IipBKJNBtQXSYMjX6NE0QvhSHCjYnC2h19SXs/GZO7RKGDM/WTtIK2REFNxul9OEY4vvrjpnHgkwEAPQaarwvqWPAI7obX0fl1/CwSJPrN85x9QUAefC29BbsVwiWS7cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m6ijNUAH; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732629538; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V3EDpDIeXyZzgE1BbXULSvRPuqiFRBBquHe3vOCN26U=;
	b=m6ijNUAHfFT6MRPfOfyXcO7uHXfH5Mgb11kafgZuNkRXwYCKmvjCSAxHvVFHA0lxVqZlFHR1GxO8JUWXr5905DKUZOsaVUy0/cPhoqdsuf5WU8Wwdb4bJOK5y5RrZcbTL7ZSSbWjA+bpEvpyQqA37O535NuAw6AiXDn+NkZ59lA=
Received: from 30.0.139.21(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKJJuQq_1732629536 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 21:58:57 +0800
Message-ID: <510ac095-89c5-4c3d-b5b7-015d028f7ed2@linux.alibaba.com>
Date: Tue, 26 Nov 2024 21:58:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Removed unused argument vma from migrate_misplaced_folio
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20241125075731.176573-1-donettom@linux.ibm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241125075731.176573-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/25 15:57, Donet Tom wrote:
> Commit ee86814b0562 ("mm/migrate: move NUMA hinting fault folio
> isolation + checks under PTL") removed the code that had used
> the vma argument in migrate_misplaced_folio.
> 
> Since the vma argument was no longer used in migrate_misplaced_folio,
> this patch removed it.
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Better to add 'mm:' prefix for the subject line to identify the 
subsytem, otherwise look good to me.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

