Return-Path: <linux-kernel+bounces-200931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF928FB6B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625621F2320E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301CA143C59;
	Tue,  4 Jun 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyvVE81X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E7513D2B6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513947; cv=none; b=b6wEGbr2eAPCc7YyQQpvApj3iYeO7wRGAVP008zvvib09TX/NgvD1kQOwemW24H9kce+zZ0+T5VJmBAmmUVwhH2N9Zzn16z0TAroBT0nh1ej/hw2wsBqEuKqpNVHiePzC9qEE/rEjsy4upe4uq4v4yTZBNH6KtfqsL+wmyojzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513947; c=relaxed/simple;
	bh=hSqtnWWeq83bRrdJrf3MfAQNHnxLuRaoyE2ioCIEo0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFp4neJ94pRss67IoVYinQaQHJIEn/JztOuCcEK7GrYbTIPg9WIe7NUV1jf8xhYmW8+wZUGaP+vK+P3p7baxQgr94wE+JlmNjPY7J0rs35I/mPwh05Y1KmCQk9EtpxPgvYyVDZFZFX0170Zlt93PeiCCG6KLPQZcM63PXJ8n5lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyvVE81X; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717513946; x=1749049946;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hSqtnWWeq83bRrdJrf3MfAQNHnxLuRaoyE2ioCIEo0M=;
  b=SyvVE81XOtCj6TxF2mkahSd5qG92jMZRm9+00sgSfysp6PAY7OUBqRKg
   d/KXoFuIWvdl2SvLjednOevMv7HXrce0Cs/6VWN6cIbIedV8cXlcx2eeI
   4obPZI/RzEz5dshgKtiegfSSed4BBxg2LBisqOtUNg9SdRxeZS7HD+3Cs
   Bfa1CfhwPOx4MYWM/L70OGU6jEbO/s9wWgFqE40Zh4HynaJkeSfeP+/XB
   sxPe3N6l1g5byce37yJKTbB3OaksthEubkEJrmzS4siWmHf+BrX5+UW1x
   RUOyHBAH9cxf+WFrYFLWpT872uFL0fL7yZfRU9FWRRoC3Xf+aErL2wCmf
   w==;
X-CSE-ConnectionGUID: QQQ3GMxhRYOERbYZxXPsLg==
X-CSE-MsgGUID: 7Ed8jU12S8irzdRk4YTQ5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31602499"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="31602499"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:12:09 -0700
X-CSE-ConnectionGUID: XIeU217HRTuXyOfBAck/OQ==
X-CSE-MsgGUID: Oe+hRJJRQT+iPoQlktO7RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37139630"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.246.143]) ([10.245.246.143])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:12:07 -0700
Message-ID: <0d15954f-0158-4a56-afef-f0d043135146@linux.intel.com>
Date: Tue, 4 Jun 2024 17:07:39 +0200
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
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Zl8iUmOfrjw3gWVX@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

\
>>>>> @@ -123,7 +123,7 @@ static int sdw_drv_probe(struct device *dev)
>>>>>  	/* init the dynamic sysfs attributes we need */
>>>>>  	ret = sdw_slave_sysfs_dpn_init(slave);
>>>>>  	if (ret < 0)
>>>>> -		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
>>>>> +		dev_warn(dev, "failed to initialise sysfs: %d\n", ret);
>>>>>  
>>>>>  	/*
>>>>>  	 * Check for valid clk_stop_timeout, use DisCo worst case value of
>>>>> @@ -147,7 +147,7 @@ static int sdw_drv_probe(struct device *dev)
>>>>>  	if (drv->ops && drv->ops->update_status) {
>>>>>  		ret = drv->ops->update_status(slave, slave->status);
>>>>>  		if (ret < 0)
>>>>> -			dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
>>>>> +			dev_warn(dev, "failed to update status: %d\n", ret);
>>>>
>>>> the __func__ does help IMHO, 'failed to update status' is way too general...
>>>
>>> Error messages printed with dev_warn will include the device and driver
>>> names so this message will be quite specific still.
>>
>> The goal isn't to be 'quite specific' but rather 'completely
>> straightforward'. Everyone can lookup a function name in a xref tool and
>>  quickly find out what happened. Doing 'git grep' on message logs isn't
>> great really, and over time logs tend to be copy-pasted. Just look at
>> the number of patches where we had to revisit the dev_err logs to make
>> then really unique/useful.
> 
> Error message should be self-contained and give user's some idea of what
> went wrong and not leak implementation details like function names (and
> be greppable, which "%s:" is not).

"Failed to update status" doesn't sound terribly self-contained to me.

It's actually a great example of making the logs less clear with good
intentions. How many people know that the SoundWire bus exposes an
'update_status' callback, and that callback can be invoked from two
completely different places (probe or on device attachment)?

/* Ensure driver knows that peripheral unattached */
ret = sdw_update_slave_status(slave, status[i]);
if (ret < 0)
	dev_warn(&slave->dev, "Update Slave status failed:%d\n", ret);

You absolutely want to know which of these two cases failed, but with
your changes they now look rather identical except for the order of
words. one would be 'failed to update status' and the other 'update
status failed'.

What is much better is to know WHEN this failure happens, then folks
looking at logs to fix a problem don't need to worry about precise
wording or word order.

It's a constant battle to get meaningful messages that are useful for
validation/integration folks, and my take is that it's a
windmill-fighting endeavor. The function name is actually more useful,
it's not an implementation detail, it's what you're looking for when
reverse-engineering problematic sequences from a series of CI logs.

>>>> Replacing 'with status' by ":" is fine, but do we really care about 10
>>>> chars in a log?
>>>
>>> It's not primarily about the numbers of characters but about consistency.
>>
>> I am advocating for inclusion of __func__ everywhere...It's simpler for
>> remote support and bug chasing.

I meant everywhere in SoundWire. Other subsystems may have different
views and different observability tools, that's fine.

> A quick grep seems to suggest you're in a small minority here with some
> 5k of 65k dev_err() including __func__.
> 
> [ And there's only 55 out of 750 dev_err() like that in
> drivers/soundwire, which is inconsistent at best. ]

As you mentioned yourself, the asynchronous nature of the SoundWire
probe/attachment/interrupts makes it difficult to reverse-engineer, and
we want to err on the side of MORE information.

Also not all dev_err() are equal, most are part of paranoid checks and
never used. An example above is the sysfs log, we've never seen it happen.

That's different to changes that impact probe and interrupts which will
fail at some point on new platforms. It's not an academic statement,
I've spent most of my day chasing two such issues.

