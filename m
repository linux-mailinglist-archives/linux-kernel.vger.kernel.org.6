Return-Path: <linux-kernel+bounces-224210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9243911EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0321C21DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD116D4C8;
	Fri, 21 Jun 2024 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTpDm6RI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481218E20;
	Fri, 21 Jun 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958939; cv=none; b=u2KM90WSWwRHFoPHByyB6S7z/vpNE+l9sxtZDSiQSs/EppS9Ab/kAxVjdqGXGYF9GloVRmoYIqzc4N6eQikWwh3JTWuNjOrpzHVIF/qKqltaNy5uRsFgv/6LRDcoHMC6SJxASkcEuICBE1PLCNuodn9jkbVEuMWs1X66VrpRz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958939; c=relaxed/simple;
	bh=YLBSukhcfbAfabPDZHRw1bCjlUJ36aIXiF01yEIM0pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsTIN7TCY9Cc7emjuWiwEUwFcnEneb3lcKRtY3LAkVtJFjaDPmryINgxPORTuQ9FvihNF8XDlrPyTvCJBhJO2xVVeUxTjkqjt5oRKAPVo8V4OjAbFfmzC4oOVAeBKQrnaxLlDswgNrsszq/YumlOSnLoFf6Po8gL1DY80XVWSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTpDm6RI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718958938; x=1750494938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YLBSukhcfbAfabPDZHRw1bCjlUJ36aIXiF01yEIM0pw=;
  b=RTpDm6RI5EO2eHPtOoQShcUY4yuIp9ek1ckm06Dr6NZ6Qb6T4RJe90SP
   mWfpD6L+sF8Azys+XmdqJhfgLiUeFGjQkyyu9A5HpbtP7U4O9+n8VSfpT
   UAScG1JbyHJ88u4EzNhwahALc8gYPQNRVys1SVFPOni5jPYNtGwA8tQNe
   9/4pp+Wj8LIc1cVGUfZ+09qdKricYrnnExHy+vyrr2uEbtlolkCTzqmiy
   cl6/Ut7WWbjWT5FQo4QDgur8KzgS8oApvZGC4i0MSx3kd1jf1Q6gBsO0P
   X/yaesrlGKqKVSwdniE6LYRDEHghziumB+Gs1WKGVf74TWJBEiwMrWbvf
   g==;
X-CSE-ConnectionGUID: U6u2V0s6SUuACwT3COtvcA==
X-CSE-MsgGUID: tEPAbQEJRWuEbdNchZ1UdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="19864960"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="19864960"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 01:35:37 -0700
X-CSE-ConnectionGUID: Dmwuj3wQTl2M99wX+YLFVQ==
X-CSE-MsgGUID: zXuWW/W/QCaCd/dFJhqKpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="73738528"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.246.142]) ([10.245.246.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 01:35:33 -0700
Message-ID: <3d9ef693-75e9-4be0-b1c0-488d3e2d41c5@linux.intel.com>
Date: Fri, 21 Jun 2024 10:35:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk
 detection
To: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Allen Ballway <ballway@chromium.org>
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
 <3d44c749-6c81-4c11-9409-b01815fe1a91@linux.intel.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <3d44c749-6c81-4c11-9409-b01815fe1a91@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/21/24 08:15, Amadeusz Sławiński wrote:
> On 6/20/2024 9:27 PM, Allen Ballway wrote:
>> I filed a bug and after sharing the requested information it looks
>> like this device won't work on SOF without vendor support. Given this,
>> would the original patch returning this device to using HDAudio be
>> reasonable, or is there an preferred alternative to force this device
>> into using HDAudio?
>>
> 
> And can you share link to the issue on mailing list, so someone reading
> this thread in the future doesn't have to guess where it is? ;)

https://github.com/thesofproject/linux/issues/4981

I don't know what to do with this configuration.
We added a quirk to force SOF to be used for ES8336 devices. It worked
for some, but not for others. Now we have quite a few ES8336-based
platforms that are broken with zero support from the vendor, with
obscure I2C/GPIO/clk issues.
Are we going to tag each one of them and say 'not supported, use HDMI only'?
That's pushing a bit the notion of quirk...It would generate an endless
stream of patches. The alternative is to do nothing and ask that those
platforms revert to HDMI audio only with a kernel parameter. That latter
alternative has my vote.


