Return-Path: <linux-kernel+bounces-321831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F70F972012
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF961C235C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282D816C852;
	Mon,  9 Sep 2024 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEZivm//"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567D4D8DA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901865; cv=none; b=EghnnBFzOiWrWALgBuzqWVn+MrF48SkjpIKxWCaIQ043390KQTHHdpY0+cldv87yIqGo2kIVaGG4UkeosP2bI+fCvy0dBwUi//2pNfNe6M8XQVTqz7pXn+DEdRHcI7llgrZB4BP5fTCs738mWBbC9sbiQer23LI/bQgqtwoZtmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901865; c=relaxed/simple;
	bh=8UPbGsidd1axff78F7nxJdZ5HnQLyKQvMeR0vup2U64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHfFVZvqxiY2/Ahibw28nCc6VUsxd17AV1S3b5tME0qFxnQ7nH/KR97geZSjzS9rEB1J/Tte42OAkb5In9dRDbF4gggnxq1kPFlyqmBvmtdgSMeKhZ7z24fkZxMp51Uve+J4TrwMiCf6Nni/WqgDBgiUQFTQRvTa3zrV04amy44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEZivm//; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725901864; x=1757437864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8UPbGsidd1axff78F7nxJdZ5HnQLyKQvMeR0vup2U64=;
  b=dEZivm//0OAHU9DGOldvRvIW3Lv+NbfS+oG9D7WbiAAHiHTBFg+Apw5V
   rDIw2n0McmtwUC4c07lrwnoHCwIsjyUVMAmh/cerpB7iTtZVUd9XJsk9f
   m9j+MBDJQ04HfS6/Eq71flCcBKINYp1wJ9z0eRI1WfxjKmUUfgyjGuHzB
   gUAqN8u4fYqfsFiRDxjMenwABgx5z7CyGayRvUnp58KuctX6hJscnsJcE
   ZvzYgAX8V3NXtXHcoCKTzbiIHMGF8iwbrdFq1qZMuym4k4ab9D9r6J/R6
   LG5Nvo/L4+71AE9Yg2b8OJk1H5VvNYlZ7tSAaO3hA91/Toped8W3fSA16
   w==;
X-CSE-ConnectionGUID: 15tp+x/+T/qWiSASx6aYWA==
X-CSE-MsgGUID: uMTnK7EnRTSnXCK05OeDNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="50023477"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="50023477"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 10:11:03 -0700
X-CSE-ConnectionGUID: 05fqzdBdRG6sWGu5q12pqQ==
X-CSE-MsgGUID: lJhxHhpoTm6N2W/zPkXRyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="71144434"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 10:11:03 -0700
Received: from [10.212.55.50] (kliang2-mobl1.ccr.corp.intel.com [10.212.55.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B5D2520CFED7;
	Mon,  9 Sep 2024 10:11:01 -0700 (PDT)
Message-ID: <8c09633c-5bf2-48a2-91a6-a0af9b9f2e8c@linux.intel.com>
Date: Mon, 9 Sep 2024 13:11:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] perf/x86/rapl: Move the pmu allocation out of CPU
 hotplug
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 linux-kernel@vger.kernel.org
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-7-kan.liang@linux.intel.com>
 <88fa2064-c054-4833-872c-0cf5ff1e3609@amd.com>
 <b9893f4f-c91e-4c83-b785-ad78dc2f67f5@linux.intel.com>
 <20240909132409.GC4723@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240909132409.GC4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-09 9:24 a.m., Peter Zijlstra wrote:
> On Mon, Sep 09, 2024 at 09:02:56AM -0400, Liang, Kan wrote:
> 
>> The patch set has been merged into Peter's perf/core branch. Do you want
>> to post a fix patch to address the issue?
> 
> I've not yet pushed out to tip, so I can readily rebase. Send me a delta
> and indicate what patch it should go into and I'll make it happen.
> 

Thanks Peter. Please fold the below patch into commit 90942140bb6c
("perf/x86/rapl: Move the pmu allocation out of CPU hotplug").

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b70ad880c5bc..1b38f8771488 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -631,8 +632,6 @@ static int __init init_rapl_pmus(void)
 	if (!rapl_pmus)
 		return -ENOMEM;

-	init_rapl_pmu();
-
 	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
 	rapl_pmus->pmu.attr_update	= rapl_attr_update;
@@ -646,6 +645,9 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.scope		= PERF_PMU_SCOPE_DIE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+
+	init_rapl_pmu();
+
 	return 0;
 }

Thanks,
Kan

