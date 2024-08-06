Return-Path: <linux-kernel+bounces-276426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84C894937A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CFF1C217C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43EF1D54EA;
	Tue,  6 Aug 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jzitq4hf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B41C2300
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955370; cv=none; b=J0sPZJ15snWAseOgtysIAeUoTm/RubH9S68k1G69iT5J95uoROpq6AuUbEBuuxsi/YFVZmUFJKQge9maOd0igG3XqWWq/yU7y4h92qie03QySoVes8+85ObRfBwawCo3SYw7Pju9stg6/QZf4cbOhsGr6rfGXr6CM35HJ28Lwos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955370; c=relaxed/simple;
	bh=/k6UEnEQjIyqhBqwPolAnSvIJXqn1cBgKv8xQPaJUYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNEKMTWDAqKq4p205zY+da725rlLJROSkk3DUABDN+1Q6r9mI6HNIJuEI9gYYcbk9JZ+cGhAk+38FaWVVooJjliRFyFfGfOh2j/lBPgQCrLuP2qZZyjQjmyxVQAlA/Qvw1WgCfirBPU+5IFj47GQ8uGBjkDWO0GBNPKbq8xJ6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jzitq4hf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722955369; x=1754491369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/k6UEnEQjIyqhBqwPolAnSvIJXqn1cBgKv8xQPaJUYU=;
  b=Jzitq4hf8cDTNcNfG0+bUCFFyawI7bTsibPol6ZsPvpRgLyXc+d+xI8D
   w2npNEC0PjZlgTHYzY1Fo7TMeM/a00dc9jCGXxYyQo6hsOdQF5EBfAdOI
   nnk6HID6NnuDyfCIKI7fr6ifFu5rwF/fmqmcRN2ZjzStf5+1+wk62iud3
   h2QgzTBFgCpacBYR6HiGSrYvcsnmIZQK7om+7RybYEl725lJOhaFRTlTC
   nIhYv6SmzHSMeZFQWUuJjoIY5W+yi4JIVO62NI6y+IfHi/eMyuuv+3B3B
   HfrZ1vPU4noRdI5M4o4B3aT+p4ygUHQO88GQGbBzzlkcQ/lNN8twyrLeA
   g==;
X-CSE-ConnectionGUID: V4HdhkFvT1WvbVpIO6Ejlw==
X-CSE-MsgGUID: B1PdIkcsRhepEzFmcOZusw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38430123"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38430123"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:42:48 -0700
X-CSE-ConnectionGUID: zAj39YZ9TlyCjTP28vJ52A==
X-CSE-MsgGUID: 50WzpB2lRci4cW36qDtcyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56504779"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:42:48 -0700
Received: from [10.212.84.25] (kliang2-mobl1.ccr.corp.intel.com [10.212.84.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 69B2C20CFED5;
	Tue,  6 Aug 2024 07:42:46 -0700 (PDT)
Message-ID: <c634b005-c382-48cc-bf54-6f570687d5c0@linux.intel.com>
Date: Tue, 6 Aug 2024 10:42:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] perf annotate: Display the branch counter histogram
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
 adrian.hunter@intel.com, eranian@google.com,
 Tinghao Zhang <tinghao.zhang@intel.com>
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <20240703200356.852727-8-kan.liang@linux.intel.com>
 <Zq1K-YM4JoEQwov1@tassilo>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Zq1K-YM4JoEQwov1@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-02 5:09 p.m., Andi Kleen wrote:
>> Display the branch counter histogram in the annotation view.
>>
>> Press 'B' to display the branch counter's abbreviation list as well.
>>
>> Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }',
>> 4000 Hz, Event count (approx.):
>> f3  /home/sdp/test/tchain_edit [Percent: local period]
> 
> Can we output the abbreviation mappings here in the header too? 
> Otherwise it will be hard to use.

If so, the 'B' will be redundant. I will remove the 'B' and move the
abbreviation mappings in the header.

Thanks,
Kan


