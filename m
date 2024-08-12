Return-Path: <linux-kernel+bounces-282502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B594E4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BC61F2328D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4232B67A0D;
	Mon, 12 Aug 2024 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AT1qE1Y3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D933C7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429437; cv=none; b=Q0vW9CZ/rVPjMB/UDe6Y7TE+xtrLm7UOzM1WbkLoDaAB41fHqmj5+47ONro+ptiVR21KHnsV8MeNrKhBeyOml4MPzly1HAFcOuiC7YUyXD8vX4BAfaUixG/wdI11bwTdLfCJ4b5EuZvFI4Ot7b5wJNnbdzHdu+bCwwysO67F2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429437; c=relaxed/simple;
	bh=97r3q4G7hJL2mOvZM1v/Mk/LoCU2r7TX511e4FaldzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PHiB0mbRrOTenhAKvt6aTjbpWwYSlLLD3pFFMcCwAXEEXB84bXV5qzJ2OTubstAiXpvDsHEAdR6l3RJo4ukss7v+Ns5v6IsVbrm8UyYm8JHI15EHsjSUWYVNmF639ezjc9nBOGeYvAFOiBKewPz4R3tlwcps2PMSK6un0pim5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AT1qE1Y3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723429435; x=1754965435;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=97r3q4G7hJL2mOvZM1v/Mk/LoCU2r7TX511e4FaldzU=;
  b=AT1qE1Y3iGR5s4/jyP+c5lYcvjCwflVgVaXXjGE/3bj1u4rC3shE+hE3
   Vb/NOGlKay7LDDlYzdqGFpkJ2TpKT2dmT98DkN8jhCNLfq3kM6YAvWicP
   QLS/2sWyChE0VBd6Dg+vJSa/rEu/31Z8v9/lVFq9glOzLlBlq02P2+goS
   SFwVLPvnwq7M5+MP7KIOTEemARC52oN3JBLWU9lpe02mFbd2+uV+Rl7WX
   rV55gD1V1AsbVCGu3B0d4uJRBuzZp/ZX17v/u3lV2oycYAJB/l/PWGgY4
   221itn6OhH8w/9BggkedF+fCvaxQkHG3/fGZOeyJQ9m6heOGiOwqlXFDv
   w==;
X-CSE-ConnectionGUID: O7tn1sclQIKMObmtDafUNw==
X-CSE-MsgGUID: /AcP5ZC2RlOJ2CTTlZ8R/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21496103"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21496103"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 19:23:53 -0700
X-CSE-ConnectionGUID: 0+XGaZU1RAKCA/bMzzYiVA==
X-CSE-MsgGUID: rXIcx2LURg6rI0VjN9Vz2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="62769652"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 19:23:52 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>,  linux-mm@kvack.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Yang Shi
 <shy828301@gmail.com>,  Mel Gorman <mgorman@suse.de>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm/migrate: move common code to
 numa_migrate_check (was numa_migrate_prep)
In-Reply-To: <17597d58-7da8-4555-b583-1997d78be018@redhat.com> (David
	Hildenbrand's message of "Fri, 9 Aug 2024 17:32:43 +0200")
References: <20240809145906.1513458-1-ziy@nvidia.com>
	<20240809145906.1513458-4-ziy@nvidia.com>
	<17597d58-7da8-4555-b583-1997d78be018@redhat.com>
Date: Mon, 12 Aug 2024 10:20:18 +0800
Message-ID: <87msliv5wd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 09.08.24 16:59, Zi Yan wrote:
>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
>> reduce redundancy, move common code to numa_migrate_prep() and rename
>> the function to numa_migrate_check() to reflect its functionality.
>> Now do_huge_pmd_numa_page() also checks shared folios to set
>> TNF_SHARED flag.
>
> Yeah, I was also wondering why we didn't check that in the PMD case.

IIUC, before commit 728be28fae8c ("mm: migrate: remove THP mapcount
check in numamigrate_isolate_page()"), we don't allow to migrate THP
with mapcount > 1.  So, it's unnecessary to set TNF_SHARED flag at that
time.  However, after that commit, we need to do it.

--
Best Regards,
Huang, Ying


