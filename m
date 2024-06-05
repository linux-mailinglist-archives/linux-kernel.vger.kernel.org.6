Return-Path: <linux-kernel+bounces-202899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101868FD29F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966F128383B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319C153561;
	Wed,  5 Jun 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9WnGdus"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A81E89C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604169; cv=none; b=ZWs9vWu43v/zV7sSih9V6onCWRSUqDeqMhUH9L9U+LUJmCFleewgu/V13er/uGGJIaxsPQTFoaW6Osts2WTDcAsNdypEjia1U81Zbbirsoqe8jpe+SpPiWqU5yX1LCk6HJqtJoiZZHPSSrTXvXT8l5ajkS/HpHXtt+1cA/07Km8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604169; c=relaxed/simple;
	bh=yCiYjdLP/0ggbp3f8crR43qIT/LJ5VLH3f5mgkoJ3BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSoo1Qt2SHBNZJSveh43RY7zrk6Xn3Gc7QMIbKuv0v3FB7vEaFKFcOk4L9SpvPS+Y5mqYsy2oO0jJLCI+zbFSJYAyoLAflxrfVKEAaHMV5qg1NixWGWTn60ptb7KYNYRyF0pXQJ2xFsiLjm3fN7LwTJxjad2TO0d3nFJErQeaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9WnGdus; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717604164; x=1749140164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yCiYjdLP/0ggbp3f8crR43qIT/LJ5VLH3f5mgkoJ3BY=;
  b=i9WnGdus1ZKvesOWJxn0UKcTH5zDy0yPZ8DLo5eOEG+axeoBIzZXV+sJ
   njF3BxdHFylTrexk8kKBKeKlENHvj+GFMHguhSOyePpdAAe2zZ8RTfO3m
   UZQUKQVwrjTV8t2UlBJoIQkfKW2cnneLSdd781DVNOdrBM7/vx6d/s6+L
   rPx0JIsztoj4eDuF2vh4hJ5GQQiWfAuN5Scgx1rzo8nYc8GavuGmrs+As
   EDec+F8LE9OdGlp88+KMNwXZIRBMGfOGo/y9MRBIWgb6UKKT0/Z2sZP3X
   R6DoJATY2B8wsufrVylsII53Qbl+a0ulW4TZym/t9y27ajlP3r1lgYFxZ
   g==;
X-CSE-ConnectionGUID: prEAWYoAS1q3v2XKuqbEcw==
X-CSE-MsgGUID: PgzgcgRHTmuRhQfMTN07dA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="36759662"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="36759662"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:16:04 -0700
X-CSE-ConnectionGUID: TYOkIvKMQjeY7IHK4Kbjww==
X-CSE-MsgGUID: XONLBmVrSfehJOBlMRjncg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37575909"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.246.201]) ([10.245.246.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:16:01 -0700
Message-ID: <25ff111f-039d-4280-b604-ad3d2b9933fb@linux.intel.com>
Date: Wed, 5 Jun 2024 18:15:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] soundwire: bus: clean up probe warnings
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-4-johan+linaro@kernel.org>
 <8dd7cadc-138c-4ef5-b06f-7177550b1215@linux.intel.com>
 <Zl7boEkMpQaELARP@hovoldconsulting.com>
 <970501b1-09ae-4f2c-a078-2b4f23fe460e@linux.intel.com>
 <Zl8iUmOfrjw3gWVX@hovoldconsulting.com>
 <0d15954f-0158-4a56-afef-f0d043135146@linux.intel.com>
 <ZmBWBrJDRjPn6TpA@hovoldconsulting.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZmBWBrJDRjPn6TpA@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/24 14:11, Johan Hovold wrote:
> On Tue, Jun 04, 2024 at 05:07:39PM +0200, Pierre-Louis Bossart wrote:
>> \
>>>>>>> @@ -123,7 +123,7 @@ static int sdw_drv_probe(struct device *dev)
>>>>>>>  	/* init the dynamic sysfs attributes we need */
>>>>>>>  	ret = sdw_slave_sysfs_dpn_init(slave);
>>>>>>>  	if (ret < 0)
>>>>>>> -		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
>>>>>>> +		dev_warn(dev, "failed to initialise sysfs: %d\n", ret);
>>>>>>>  
>>>>>>>  	/*
>>>>>>>  	 * Check for valid clk_stop_timeout, use DisCo worst case value of
>>>>>>> @@ -147,7 +147,7 @@ static int sdw_drv_probe(struct device *dev)
>>>>>>>  	if (drv->ops && drv->ops->update_status) {
>>>>>>>  		ret = drv->ops->update_status(slave, slave->status);
>>>>>>>  		if (ret < 0)
>>>>>>> -			dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
>>>>>>> +			dev_warn(dev, "failed to update status: %d\n", ret);
>>>>>>
>>>>>> the __func__ does help IMHO, 'failed to update status' is way too general...
>>>>>
>>>>> Error messages printed with dev_warn will include the device and driver
>>>>> names so this message will be quite specific still.
>>>>
>>>> The goal isn't to be 'quite specific' but rather 'completely
>>>> straightforward'. Everyone can lookup a function name in a xref tool and
>>>>  quickly find out what happened. Doing 'git grep' on message logs isn't
>>>> great really, and over time logs tend to be copy-pasted. Just look at
>>>> the number of patches where we had to revisit the dev_err logs to make
>>>> then really unique/useful.
>>>
>>> Error message should be self-contained and give user's some idea of what
>>> went wrong and not leak implementation details like function names (and
>>> be greppable, which "%s:" is not).
>>
>> "Failed to update status" doesn't sound terribly self-contained to me.
>>
>> It's actually a great example of making the logs less clear with good
>> intentions. How many people know that the SoundWire bus exposes an
>> 'update_status' callback, and that callback can be invoked from two
>> completely different places (probe or on device attachment)?
>>
>> /* Ensure driver knows that peripheral unattached */
>> ret = sdw_update_slave_status(slave, status[i]);
>> if (ret < 0)
>> 	dev_warn(&slave->dev, "Update Slave status failed:%d\n", ret);
>>
>> You absolutely want to know which of these two cases failed, but with
>> your changes they now look rather identical except for the order of
>> words. one would be 'failed to update status' and the other 'update
>> status failed'.
>>
>> What is much better is to know WHEN this failure happens, then folks
>> looking at logs to fix a problem don't need to worry about precise
>> wording or word order.
>>
>> It's a constant battle to get meaningful messages that are useful for
>> validation/integration folks, and my take is that it's a
>> windmill-fighting endeavor. The function name is actually more useful,
>> it's not an implementation detail, it's what you're looking for when
>> reverse-engineering problematic sequences from a series of CI logs.
> 
> Just add "at probe" to differentiate the two cases if you really think
> this is an issue:
> 
> 	dev_warn(dev, "failed to update status at probe: %d\n", ret);

__func__ would provide equivalent functionality, only more precise...
I guess it's time for Vinod and Bard to chime in.

