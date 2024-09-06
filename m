Return-Path: <linux-kernel+bounces-319135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FB96F82E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE05B22B07
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B4C1D2F63;
	Fri,  6 Sep 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+KNZf/Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5C1A2C39
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636653; cv=none; b=BxyREdY+x0kpeXdm4451o2fUDrsu5CRavNfSWy/w30H2Tap3BNadCLctpOPyLz/BehFjTmi9lSH/Iyw8fAHGRtvGugc5gaJyyEO2ZLyd7fQOELWUYAHbMn/DMJ88DYDzw6ZKuRpQFYMcjxHYklRu0wQxzdGZXPONeRMVtywlpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636653; c=relaxed/simple;
	bh=NM4cYB/gkWYZrmcXhLgeRFbsxl4UGImhW6EadNKVMfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZFnwqqmyhUGHVVWzpxIML47E7xUn8Ec4SRdkPcbTuMMpF5E9gGdffYJcmvE1hMh+h1iIzZKvrII1f+bYFuurJ/+fcbhteTUlpkTUpKnaxgAs0tdmGifT665yWAahCPsr8eYN6jAjOqRwAR6yXCggv3KAHhXYYbkFAtTq9b7oTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+KNZf/Y; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725636652; x=1757172652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NM4cYB/gkWYZrmcXhLgeRFbsxl4UGImhW6EadNKVMfg=;
  b=X+KNZf/YmYZjJ9arNYxgFRcnpQvZDiOz2VIvyo710THTFYhbRBMicWI9
   ZB3A72sADCqTnWpmRrW+x7+YdX0Hm8o5XNYD8nTxpX5At4UgHGeGMAV6d
   3CQkFbz7fmwnhUHR7dtq6KSps5WUYVDYkF0L+P7m7vkRLUUM6kiVwOlt8
   Rf0NMIYw9PWONJluT6EsVtkMgAh6O//4JFDyrlweVeL2QTvWKKiwejMp2
   LHYh1gAFLUkZQcJlp2aomLf+AZeCi42g62JOUzfnHID0uYRi1EsRn1qIp
   4e2xKTukIoGXYdCCfuIM20b9AWmsAicKsc9jSV5/GfR6PRNPKfvh8QlwB
   w==;
X-CSE-ConnectionGUID: yX0TVJlxSCOCHbpPzc5fcw==
X-CSE-MsgGUID: wu/KERS9QYWpyVO+PeTdQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="23958682"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="23958682"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:30:51 -0700
X-CSE-ConnectionGUID: Q4WoUR+9Qe+8c5I+4AKcfQ==
X-CSE-MsgGUID: xqTBH8eiR4S+IyF/nBGVHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="65673727"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:30:51 -0700
Received: from [10.212.119.23] (kliang2-mobl1.ccr.corp.intel.com [10.212.119.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6322220B5782;
	Fri,  6 Sep 2024 08:30:50 -0700 (PDT)
Message-ID: <5032b967-f1d8-4808-a101-e5c32ab6fd61@linux.intel.com>
Date: Fri, 6 Sep 2024 11:30:49 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Generic hotplug support for a PMU with a scope
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-kernel@vger.kernel.org
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <b97ab074-3889-47ae-a66f-46a2f8a99005@linux.intel.com>
 <20240906151716.GZ4723@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240906151716.GZ4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-06 11:17 a.m., Peter Zijlstra wrote:
> On Wed, Sep 04, 2024 at 08:44:47AM -0400, Liang, Kan wrote:
>> Hi Peter,
>>
>> Gentle ping.
>>
>> The patch set provides a generic hotplug support to facilitate various
>> specific PMU drivers. Could you please take a look?
> 
> Seems nice, still applied, so I've queued it up for the robots to pass
> judgement.

Thanks!

Kan

