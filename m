Return-Path: <linux-kernel+bounces-170272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE50C8BD452
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B291C2194F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8815885C;
	Mon,  6 May 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/HcReJ7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F31586C3;
	Mon,  6 May 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018555; cv=none; b=e0CQUBG6CkRYVuMRMFqZQZRAA2boNcjXhs9MuWETZFCGTa0EDOW3dimgcU0jRIu1MJ8TBuS4JlhcrU7ecl1U4Iusz7+YWr6fWJqainKARVoU0WO5zTTT8+uIy4xeFEKsIgf6cFK32DfYFCyHFXTRnlPejp2M9hqbLg/UHS9YDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018555; c=relaxed/simple;
	bh=9aXi0tuTKrFYaJqHfgKGm2SRMReUBj3+c/ghseieE0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qd3IaPf+emBVrvHbqf0rGJzG7IGyVeNXHpYF+bAHs+q9riZfmEomuB5Gs2A5uXmZvNBj7iotXiFGNc7bYh0L9ETjoUrYWoBtWwSOK7Z4CyC1ht6cWUyiZDz0a1w7ZoIvKD+s8+5o4C3O/n4ZC72wzXJ8YMszXcoNKQzp7Gog9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/HcReJ7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715018554; x=1746554554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9aXi0tuTKrFYaJqHfgKGm2SRMReUBj3+c/ghseieE0o=;
  b=V/HcReJ7N3U2SyFA39Tv7F8n4XdGp6pBZ+FyNMvqmmIcHpZrX6NLuJIc
   vdUispJRzXwVbK3P6T0ryK2cJEq3GFJCaKRe//LMPISjqbh4WS7LfvvGv
   fOIOcPqVtkzqAIIwGhrB5HN6J0t396A9ppG1OOnessKgHpsg8aPDTk2ow
   csGd717GHK3SxOa5z5N1NHOmekO0R6mPyr2kAtu4Lt7f6Cen46ZRI8bCB
   ZRb5ayCcaBrU23sJpf8ppynoh16LvcXxld8jR11qNoSH3gH+Ct8vwCc+x
   HRp0COeXR8IKoo58hJlKt3CoDR0OPZrcjqeshSYTt2jaMovf5+5innN1J
   w==;
X-CSE-ConnectionGUID: OgIW23kYQ3q6BjaTN4lDNg==
X-CSE-MsgGUID: FcI2magzSY+0fcefRplRAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21452711"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="21452711"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 11:02:33 -0700
X-CSE-ConnectionGUID: TEz8+TNCTqucgM7Eg9eaZA==
X-CSE-MsgGUID: niETRehvSEO8j/BcNYKL5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="51425516"
Received: from mkuebler-mobl1.amr.corp.intel.com (HELO [10.209.133.42]) ([10.209.133.42])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 11:02:32 -0700
Message-ID: <b2375610-4044-49e6-86e9-5c172abb2ffa@linux.intel.com>
Date: Mon, 6 May 2024 13:02:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk
 detection
To: Allen Ballway <ballway@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Brady Norander <bradynorander@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 linux-sound@vger.kernel.org, Mark Hasemeyer <markhas@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <20240430212838.1.I77b0636d5df17c275042fd66cfa028de8ad43532@changeid>
 <83e218f9-29f5-4f35-bd0c-b298e3bb9e8c@linux.intel.com>
 <CAEs41JC-vJaMHj6fzmNO=-bu5oURRA-u565sN2=yzBeVtKb=4g@mail.gmail.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAEs41JC-vJaMHj6fzmNO=-bu5oURRA-u565sN2=yzBeVtKb=4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




> Unfortunately the above patch didn't fix the issue, nor did I see any
> of the change logs in dmesg.
> Are there other alternative solutions or information I could gather to
> make a more general solution?

File an issue here: https://github.com/thesofproject/linux/issues

and attach the NHLT table:

sudo cat /sys/firmware/acpi/tables/NHLT > nhtl.dat; gzip nhlt.dat

as well as the results of alsa-info.

