Return-Path: <linux-kernel+bounces-280268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04C994C7EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68726B22600
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6BE33D1;
	Fri,  9 Aug 2024 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uq9CdXRD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0089C8C7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166007; cv=none; b=u2MbXdiF4cFFFZ6ssoFVp6RzVMker7aqsqV9KhVSumBbCycfycikLVVnvNp0zMW4fNViMgojkYHnM9b9HjODpBvv6zkkejky+KV6xdKVQuN2o2GjFrg5ki8qkPoJuDiJEdoDgXL1v6vvItn2DJu3DgpqfGsxrZidLXoEoxfc17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166007; c=relaxed/simple;
	bh=b/8PDvmN5Xe1hyA5jCvd+DP8DbZVcpAzH+OIpOcJjRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BebEpIeCBkz9+Ljsr4GbxEcqUrQOVyxXCvE6pqGOO0qUG2ufrezketf7DPHtfcbVvY6IRv09jjGBhrT5AwY+lBjafcgIxg1UMHRV0NYtQpGqYb/mxvi0e8bFUutXquR0uzHsrR+dSrzx4h7vY28GZRkS1eqNq3DkW2uYQQBfMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uq9CdXRD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723166005; x=1754702005;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=b/8PDvmN5Xe1hyA5jCvd+DP8DbZVcpAzH+OIpOcJjRs=;
  b=Uq9CdXRDPGv6z0rOnItdog/LlzR96AhWYzrR8PkmhT3VtqIhUQQe3i/c
   DMXc9iXwD9dNA9xgq0UbYw2q8xaxH6QwjFbK9Ca+rH0CKG2Ku6yblNb6w
   AY3SxR2MZhh35kuSqYZJn6fMw+rlCDvH2P106bia+LJghmihSfwQSUoGL
   QUUk99aQp7qqf3bHY8gmLFFKiX7VvBtiTywhVJiUI+uKGOgChdRpIN3Nt
   PGwnGaX8r3LkgSoyR1mAG8sVRGkW9J3DAyQGnRvIz5b77wXY5Q8F1GVyD
   0Jh/LJ9yuAJ90qyxiW3AxHtjj729rpaOclzkP/iDK6f1v2Q+mKvHeTqvW
   A==;
X-CSE-ConnectionGUID: H/Y060nmR3iM+1ycW+Pe1g==
X-CSE-MsgGUID: Xdrz6gmnTtGyKA6dNnfG+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="20890959"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="20890959"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 18:13:25 -0700
X-CSE-ConnectionGUID: BRPClLLHSOS4qeCu8qwPzg==
X-CSE-MsgGUID: Gm5uafUSSqW/nOgT7Oqqpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57283865"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 18:13:23 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: <linux-mm@kvack.org>,  Andrew Morton <akpm@linux-foundation.org>,  David
 Hildenbrand <david@redhat.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/migrate: move common code to numa_migrate_check
 (was numa_migrate_prep)
In-Reply-To: <20240808233728.1477034-1-ziy@nvidia.com> (Zi Yan's message of
	"Thu, 8 Aug 2024 19:37:28 -0400")
References: <20240808233728.1477034-1-ziy@nvidia.com>
Date: Fri, 09 Aug 2024 09:09:49 +0800
Message-ID: <87h6buzele.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <ziy@nvidia.com> writes:

> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
> reduce redundancy, move common code to numa_migrate_prep() and rename
> the function to numa_migrate_check() to reflect its functionality.
>
> Now do_huge_pmd_numa_page() also checks shared folios to set TNF_SHARED
> flag.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

[snip]

