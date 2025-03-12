Return-Path: <linux-kernel+bounces-558016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02388A5E06F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2EC3AA370
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275AF24CEFD;
	Wed, 12 Mar 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmDrcLxS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76686349
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793675; cv=none; b=baxnb5WD/+ADX25TI53pSRPkdhdKQoeciuBy7YLxnJDtCbVNsOrdnjx3nkmYRNEzu/mXbaKzsB/dtzKqRVVwqZ2QgY3lvBUnpnu043c1AqHfdUJqgb5S1EsHEbfXGax1p4jcACoB0fOq1rZI1gkkqxC+D8CcnoAxQaTJAIciD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793675; c=relaxed/simple;
	bh=0nkw7Z2I1Ugurl7EHYlKvwJDrQZP1fkJSv3MUsYV9Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxtpT76csHqw27OD4R6AJNyLeQm5F70QVZAcoJUuOlhhKCBHWHLnVCe+HFYKyHzt7Xp5+wuLGhDHkiIeNZ7JP4An0Ejx9897cdjSE884r11BsyMK8g3bf4nQdOw7K3Aoh1tlmmffpUuAy3X2SVR4qQCaJnau/hmvmnkViFggCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmDrcLxS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741793674; x=1773329674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0nkw7Z2I1Ugurl7EHYlKvwJDrQZP1fkJSv3MUsYV9Vo=;
  b=UmDrcLxSD0GFUX3o0WL7e8e7OwlYLQbCc9Yh5tF63wzgymYDm7NtkXNZ
   VQlce6P3H/dHD3C19168NPJQn6/PMUh8nzLUaI30gUnIvQ02DTyLaJcfo
   tERYTXuoyhGwtf6iDdPf85Eq9dwf+SgEUIsC3D36g4CzjiNeazUdVcNHH
   cnudeYbJEj4xiQRX9yiMj/pNp2H2PzevmC+vZPfhiTkZCxRCBhtbsupBw
   u5FGM2+N4Nn2lmjHAlcB/WezLYIgjJn8Vt2HETRbuLCPkfU16+QgTYqL2
   fTDh482b42rPQW/xuisCwXuXM15G/iqKQM7vJUEG0E0AUIdBhWesK9Ht5
   Q==;
X-CSE-ConnectionGUID: MLP77wJpRo6WxTq+DG25cg==
X-CSE-MsgGUID: Ak/v8QneTSm31LeUMV2LcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42755509"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42755509"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:34:33 -0700
X-CSE-ConnectionGUID: NHloVZboSIiRKrgni6PYjQ==
X-CSE-MsgGUID: JYTDTW8fQsGDM8wN1bosxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125557150"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:34:33 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 84AA620B5736;
	Wed, 12 Mar 2025 08:34:31 -0700 (PDT)
Message-ID: <8303cd57-cbc3-4d36-b544-d894f59e1535@linux.intel.com>
Date: Wed, 12 Mar 2025 11:34:30 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/6] perf: Save PMU specific data in task_struct
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20250312130424.3863916-1-kan.liang@linux.intel.com>
 <20250312135423.GM19424@noisy.programming.kicks-ass.net>
 <20250312135749.GD9968@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250312135749.GD9968@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-12 9:57 a.m., Peter Zijlstra wrote:
> On Wed, Mar 12, 2025 at 02:54:23PM +0100, Peter Zijlstra wrote:
>>> The whole patch set was posted several years ago. But it's buried in the
>>> LKML without merging. I've received several requests recently to fix the
>>> LBR issue with system-wide events. Rebase and repost it.
>>>
>>> - Rebase on top of Peter's perf/core branch.
>>
>> That branch is older than tip/perf/core, as such things don't apply
>> anymore :/
> 
> I've pushed out a new queue/perf/core, based on tip/perf/core + your
> patch from yesterday.
> 

Thanks. I will rebase the patch set.

Thanks,
Kan


