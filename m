Return-Path: <linux-kernel+bounces-221938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449B90FADF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC02E2832F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C810A1C;
	Thu, 20 Jun 2024 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1eJH+ko"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26077803
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718846738; cv=none; b=qPUqkXM/lKSYFRoiZuIFOaugD3U9e3pNOOIRZ3KnLaoOSrLKrKSaC7h+LDhNMmHKoISp7l23hHW4Z7/1Oc2KC1dNzZh4WkFuUWre7ZRM4rrg9dON3Pqtw8UbV/zYPR8Y9Zyz4gnJ0GIUXtp3oMSKQxQO4cfaGoGKYeGKUZqqatg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718846738; c=relaxed/simple;
	bh=UcBVFMZSJqd2jYOVzXRQ44DWDio1IXQh/wpSEqyH9Ow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RZL2/+nCE2qbz4tGSmx/uFXwJj9bTy42GuxI1U+CnYVtaYMN8iSIvWWWfkcKlV7gqbXh5tkwHsv4IAxz6YKjfn+IH7bqw8wHivWWLDBp5SF3azrSqJ0cJpRq4o+DoJwTANHDZz50L4IJaoMeeTVW+KTOwyOEmIw8u0AOr2a9iik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1eJH+ko; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718846737; x=1750382737;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UcBVFMZSJqd2jYOVzXRQ44DWDio1IXQh/wpSEqyH9Ow=;
  b=S1eJH+koEWBbW6cttApW3oFldD1QT2pHVT+hn9buMjs1//EpkciZM7SH
   B8LF0nZtseUAZQPcQwsJsp+VqDvOId+rl2/yo58yMX8z98zpADdtfNLuq
   VmhKX11zEJ31EJnutCPD50enb4Jo1tUizvQUdRgdRVHNrxJEdIO5ZKQMQ
   iv6JLlNOmciNinTfdA+22Aa4s85TusrlR2GiMP5p7Dszj9qImjVN6i3R5
   xoY7aYjeytqE3zBtBR1ah9i+ZJheYzZ0pdI6nZqGke2MxKSiwLnbdmsJA
   6JcvBmcS7XTGxZeZ6ovOZC1qxKVXRhkwcHRlF6iW9KI3+xbNZlrWDcAS7
   Q==;
X-CSE-ConnectionGUID: HFgBxi4pRCSfQ0xmw4gb1A==
X-CSE-MsgGUID: 6/wtw0FrROS1mCLgCM2z2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15944753"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15944753"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 18:25:36 -0700
X-CSE-ConnectionGUID: /q/ponmQTBStiVBH+ujPZQ==
X-CSE-MsgGUID: kgNcYnp/TGCxtcljvJcHrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42772346"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 18:25:34 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Hugh Dickins
 <hughd@google.com>,  <linux-mm@kvack.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Yang Shi <shy828301@gmail.com>,  David Hildenbrand
 <david@redhat.com>,  Yin Fengwei <fengwei.yin@intel.com>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/migrate: make migrate_pages_batch() stats consistent.
In-Reply-To: <9D1249AF-CBF9-4283-B1E4-6AF7890C23E0@nvidia.com> (Zi Yan's
	message of "Wed, 19 Jun 2024 14:13:02 -0400")
References: <20240618134151.29214-1-zi.yan@sent.com>
	<87plsd4co5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<9D1249AF-CBF9-4283-B1E4-6AF7890C23E0@nvidia.com>
Date: Thu, 20 Jun 2024 09:23:42 +0800
Message-ID: <87cyoc4db5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <ziy@nvidia.com> writes:

> On 19 Jun 2024, at 3:25, Huang, Ying wrote:
>
>> Zi Yan <zi.yan@sent.com> writes:
>>
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> As Ying pointed out in [1], stats->nr_thp_failed needs to be updated to
>>> avoid stats inconsistency between MIGRATE_SYNC and MIGRATE_ASYNC when
>>> calling migrate_pages_batch().
>
> Because if not, when migrate_pages_batch() is called via
> migrate_pages(MIGRATE_ASYNC), nr_thp_failed will not be increased and
> when migrate_pages_batch() is called via migrate_pages(MIGRATE_SYNC*),
> nr_thp_failed will be increase in migrate_pages_sync() by
> stats->nr_thp_failed += astats.nr_thp_split.
>
>>>
>>> [1] https://lore.kernel.org/linux-mm/87msnq7key.fsf@yhuang6-desk2.ccr.corp.intel.com/
>>
>> IMHO, we shouldn't ask people to use link to understand the patch
>> description or commit message.  If so, we can make the link less
>> outstanding and maybe add more words about the issue.
>
> I summarized your explanation from the link. You think the summary is not
> enough? I can add more text. Let me know if the above text looks
> good to you, then I can resend the patch. Thanks.

It looks good to me, Thanks!

--
Best Regards,
Huang, Ying

