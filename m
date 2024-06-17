Return-Path: <linux-kernel+bounces-218043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2B090B876
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39FC284AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0E918EFF2;
	Mon, 17 Jun 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5m7xFwj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23310A2B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646693; cv=none; b=B3xXsVojinePmC1tfBJj1gclRTLBvjLlnbue5rwltpDSKnhthKTT9mbHyjQC9Vd69GkD0Wu/+ozLVHtG7Z62STt9W7ds37zrrdxyzblsCJvpLm+YzMOG6MXAwCk1gboRgtsSuJMmX/ea9zkV0wvLKnKKKghn7wm1/QK5obBLDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646693; c=relaxed/simple;
	bh=3EayStFr7ThfnMXMquv7JRy0d3+fefhNzkY77XemP0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2og+fcrjy8Vz3+j82nX8alf5SNZMhxVEpX7eOFY+LtUipE7uTxq0ZPald/S+H8fpLVPi2t014f0PeVLCkKP9ltihlxcKHxmheIZltnF/N4CaQi+I++TfMR0r9mBhf1R5VYqnwrVeK4Q6aKnwu/fJetOuVCgh8tfy3r9XNUcDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5m7xFwj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718646692; x=1750182692;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3EayStFr7ThfnMXMquv7JRy0d3+fefhNzkY77XemP0k=;
  b=P5m7xFwjpGtpgPcW5yr57c2j1+JHNZZmUWslovGNpQ3Zbg/xgEPrtR9Y
   MCdLcJoKIJiMKkyDFqkA2GGFfzzBgH+ut6wBBeCyRhidPR+THmRokSWgy
   XOaioEVLCDg0UuAGwnqi25xDqolJX3zx4vz1dFSFCkkTLA+M6tzcuAAXp
   1hioJ6rZ2MIMaYQM1lA3N6tntjGnhVG3PRX8ngrYd3/4OOrIDKxp2f+Ay
   2c8EZPIlTBdXjwHpS2h9mdzEg+lI9RPnPxKt3D3y8j17HU92LlqXNLd05
   HniGGVr3FFojv+TN+yoQATNJZZJEvlvK4CtdOVl+7TewPjv9IXlyCYaQn
   A==;
X-CSE-ConnectionGUID: kxU2KQHBQBCdAbFQUWdwQg==
X-CSE-MsgGUID: hEpj6euGR5e4VV1wxHYugg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15616172"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15616172"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:51:32 -0700
X-CSE-ConnectionGUID: ally0yvCRHe9s5HvSIchUw==
X-CSE-MsgGUID: QUgQJymcScWXccpLHi8xUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41972252"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:51:31 -0700
Received: from [10.212.91.105] (kliang2-mobl1.ccr.corp.intel.com [10.212.91.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C5B4720B5703;
	Mon, 17 Jun 2024 10:51:29 -0700 (PDT)
Message-ID: <996eb980-ae88-4f02-bee3-cca511afcbd8@linux.intel.com>
Date: Mon, 17 Jun 2024 13:51:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/8] perf/x86/uncore: Save the unit control address of
 all units
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, eranian@google.com,
 ak@linux.intel.com, yunying.sun@intel.com, tim.c.chen@linux.intel.com
References: <20240614134631.1092359-1-kan.liang@linux.intel.com>
 <20240614134631.1092359-2-kan.liang@linux.intel.com>
 <20240617155027.GX8774@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240617155027.GX8774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-17 11:50 a.m., Peter Zijlstra wrote:
> On Fri, Jun 14, 2024 at 06:46:24AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The unit control address of some CXL units may be wrongly calculated
>> under some configuration on a EMR machine.
>>
>> The current implementation only saves the unit control address of the
>> units from the first die, and the first unit of the rest of dies. Perf
>> assumed that the units from the other dies have the same offset as the
>> first die. So the unit control address of the rest of the units can be
>> calculated. However, the assumption is wrong, especially for the CXL
>> units.
> 
> Oh gawd, that's terrible. Was this actually specified, or are we hacking
> around a firmware fail?

Not a workaround for a firmware fail. The the CXL discovery units depend
on the stacks and CXL devices present on each socket. So different
number of CXL devices on each socket is a valid combination.
SW cannot calculate the address of the devices on the other sockets via
the first socket. Full addresses have to be used.

Thanks,
Kan

