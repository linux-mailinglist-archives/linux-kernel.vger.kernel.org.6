Return-Path: <linux-kernel+bounces-573799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99AA6DC95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D8D7A3187
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C244C7C;
	Mon, 24 Mar 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cskc8iNO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959121EDA31
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825254; cv=none; b=qEUVt/vmyPin+GrpjHaLQI2pa5GAO7TETlmdXjhvUfdQDyFs8EDqduZ8bcVcAn/1Pb7zo50uD9ZeMNxsXmbfacYgmJyXHmyzS4HVgFLx6G2yL7MzLJZRNMv+SLP/3UYm8po7VVq02OePP+49ROXWXRRHV0smChI7zypIl2LbAnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825254; c=relaxed/simple;
	bh=9ts/+W19OfEqb+su2V7RPw2oWOzTqR9GO67Y3MbTXPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFRRfsJx3rWJFA+ZwIuXv6qMgFK/8PCjJCGABuGXTV+Az8iKyGxzyFXfAp4yYi9d+ijmSLic9eDUdm4ajMO9esQzmdRosCQemBWpzRvxeFN0cyl4KShZbEH9HeCstRqwR2p5afMvSj6t6nflooim1x2qVRY7LZMofIvFLDTDSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cskc8iNO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742825252; x=1774361252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9ts/+W19OfEqb+su2V7RPw2oWOzTqR9GO67Y3MbTXPY=;
  b=Cskc8iNOXv6ERKBKp5tktqY59DcG6OIKpyVBLofNeeIZQSGVTRwsK/Rf
   T1/6mTWhz/U/N+rrbgwZkwaPouRD4LILeUnE4ABL9+OFipW66kJ21NR2k
   Ir3giCSsD71oHig4USDgZJD5s4DBq5Wc0ywOiDHYxo4+hVT4QrS8qLHRR
   0IQcJlVW/j9IYzuKf5jDzYG1wME26TpKDC8NgugWRkxzkJe22+eEAXDGl
   Wkq3XLfgr96eAfGiu58tjIaKXJRCg7cR7TRSzLDu5lzv2qCbENIs/omZE
   86gbE0rAWXXj+2Tf54pXPHzQOZy2NmeVVbxoyJ7QcDbhoCjw3QvTNfD88
   A==;
X-CSE-ConnectionGUID: 1tqCVXK1RxiE5vEmycF5IQ==
X-CSE-MsgGUID: 5xCMREDaSNeuyG9JgwD5Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="46775562"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="46775562"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:07:31 -0700
X-CSE-ConnectionGUID: N3g8cNo4TOK7+/nPFd2s1A==
X-CSE-MsgGUID: Q3a3mJ04RCCn9a1cI+T/dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="128749764"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:07:31 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D778920B5736;
	Mon, 24 Mar 2025 07:07:29 -0700 (PDT)
Message-ID: <65ef0526-b613-4db5-bd27-d572299284b6@linux.intel.com>
Date: Mon, 24 Mar 2025 10:07:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 1/7] perf: Save PMU specific data in task_struct
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20250314172700.438923-1-kan.liang@linux.intel.com>
 <20250317111045.GA36386@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250317111045.GA36386@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Sorry for the late response. I was on vacation last week.
> 
> Kan, can you please do a patch failing perf_pmu_register() is there's
> more than one pmu with one of the kmem_cache things on?
> 
> Because the current thing very much cannot deal with that case.

Sure, I will do more tests with register failing cases and report back.

Thanks,
Kan


