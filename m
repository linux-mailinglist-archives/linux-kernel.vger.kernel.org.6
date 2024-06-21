Return-Path: <linux-kernel+bounces-223976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB5A911B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294F31F23EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4713216D4CA;
	Fri, 21 Jun 2024 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ak8YUHis"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413716C872;
	Fri, 21 Jun 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950554; cv=none; b=o6WjrOrgnLwuAX5EFGQezq3MSbalBJWa1IFTOMb9h61DrIQucnHcB7Xk5S44c//BSwFybIRKw8UqDa42kETrccSq1CIE2J0YF80RpvDOGqc4ZHKWLLSbGxvjrnGGCv25zQfLVfP2o8o9IHH5sW0gzcBL+Ryox7Tq2IoG24yvZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950554; c=relaxed/simple;
	bh=b4YFrfIx8v91klVdzfn/68zAfExp9e6qzjIqoe5lMCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7hT0midY7U0izfMQ8E6Zg0CWzDhEo83opUW5rH6QSe0nOjDhk0tU5eOr/47lC4INplV+b1KYXl7Eh49uErnIeB3ZnRaIDbyGvSHEIVc536z8+7NQOjvunsfFm/XOWt1NLtDoLzDAn72RdOhC93SzeUh/ttNPpK6Y4STiPiceIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ak8YUHis; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718950554; x=1750486554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b4YFrfIx8v91klVdzfn/68zAfExp9e6qzjIqoe5lMCA=;
  b=ak8YUHis8aiRy9YHwW9S82RpNjkvsa1uBrEXkoe4U0Vwhfh7zjekmNef
   uwn3OjL96GfgQbvdCKqwzu1RZx9icEgnRYubLUvdNxSanN23/5ZHdwznM
   EtV90JviegN/9oTyRdmlf10bZKMOoDExL6Eo+K92vpqGjq/gwgaqDs5g0
   P2DUTiNMsjVW6wuhmhFm1tfJk+/iaszB+IWBjejmr2YTmNUvVspDj1kXI
   PJV0QFw10dOYXnYy0lWGTCEr8i7/6JB6JcNdwLZNrbKz6cM4kowl5mqKC
   HG6tQEgK5WdBkOgB39xuXhuUrFQuDFAgcJ+cNv6RsthywupB6vnfgKYD7
   Q==;
X-CSE-ConnectionGUID: X+VzhjGhRYegNPj2QHEEHA==
X-CSE-MsgGUID: h5Mv2hDCQvm46XHyZo/29g==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33426454"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="33426454"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 23:15:53 -0700
X-CSE-ConnectionGUID: GE9heTFRRcatzZBud09DlQ==
X-CSE-MsgGUID: DDHedefNSbaBObOzoPaxdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="47013825"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 23:15:49 -0700
Message-ID: <3d44c749-6c81-4c11-9409-b01815fe1a91@linux.intel.com>
Date: Fri, 21 Jun 2024 08:15:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk
 detection
Content-Language: en-US
To: Allen Ballway <ballway@chromium.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Brady Norander <bradynorander@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
 Mark Hasemeyer <markhas@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <20240430212838.1.I77b0636d5df17c275042fd66cfa028de8ad43532@changeid>
 <83e218f9-29f5-4f35-bd0c-b298e3bb9e8c@linux.intel.com>
 <CAEs41JC-vJaMHj6fzmNO=-bu5oURRA-u565sN2=yzBeVtKb=4g@mail.gmail.com>
 <b2375610-4044-49e6-86e9-5c172abb2ffa@linux.intel.com>
 <CAEs41JAPPr3xRR42H6vKic5rVrtV-on4HyT5wNCXxbJtwijnCA@mail.gmail.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <CAEs41JAPPr3xRR42H6vKic5rVrtV-on4HyT5wNCXxbJtwijnCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/2024 9:27 PM, Allen Ballway wrote:
> I filed a bug and after sharing the requested information it looks
> like this device won't work on SOF without vendor support. Given this,
> would the original patch returning this device to using HDAudio be
> reasonable, or is there an preferred alternative to force this device
> into using HDAudio?
> 

And can you share link to the issue on mailing list, so someone reading 
this thread in the future doesn't have to guess where it is? ;)

Thanks,
Amadeusz

>>
>>> Unfortunately the above patch didn't fix the issue, nor did I see any
>>> of the change logs in dmesg.
>>> Are there other alternative solutions or information I could gather to
>>> make a more general solution?
>>
>> File an issue here: https://github.com/thesofproject/linux/issues
>>
>> and attach the NHLT table:
>>
>> sudo cat /sys/firmware/acpi/tables/NHLT > nhtl.dat; gzip nhlt.dat
>>
>> as well as the results of alsa-info.
> 


