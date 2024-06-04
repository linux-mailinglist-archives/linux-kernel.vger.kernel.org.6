Return-Path: <linux-kernel+bounces-200735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F898FB429
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FB12817AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA54F145A15;
	Tue,  4 Jun 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHTPGKRX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F20146A8C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508633; cv=none; b=L1azhHQH6a5XcLNFwtXXirQee9B7Nsepmio10hGngerJ5bE7msHrgh+7oEe4zGAqbhI1tG1QAYImhv2vB6BaExdp3JkZ4GKxL8KwcycsxEHwBGO1/vS9d6ufrq+WidAhWgCNNR4sJyK+NBG/ab8LelWVz7RfndDiq1tC3m3vMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508633; c=relaxed/simple;
	bh=73TacqsCpBZ+SAUPu6XyT+doqzn3pkKU04z3oNydmok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxZJ7wL3uoRrxr0Cs6pfnQq+x9gjpXqPtAdGagJc6vMKE8G8koDiavzbKa2bfJBFvvu5BuAaAvEFO1Fn/uAkyt2OGWGN4fek/ARo9fK+UBS4MrbOODWbHeOkdMbH0cRwKkJ+GPJklWTtLUwIUkcbsSkAxGkS47V5me4O0khneWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHTPGKRX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717508631; x=1749044631;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=73TacqsCpBZ+SAUPu6XyT+doqzn3pkKU04z3oNydmok=;
  b=WHTPGKRX/f7VzNypXPul4JfLlowd5h/F7SAUfCxezSUySmNKA/wdEM7r
   dC027YJua2qZj8+SzZdctX0zZQwfg6jYVVwEUNul6H4ePgPjEXHjkQDid
   ko0DB0TwrrXxbz4fJeeUK0XsBCCdwwd9sCqrSTtIbXyQady85onyPbKmz
   Rlbrrkp+pYF3wQmNPRj9Oz/tRRZLGM7u4OJdRr8hJzKFOEpczVWneoct4
   b03DVeopCcAaLfZ1+UEBNa0/cjtaTv3gpMgwqiGdBQKl1A7KlYAvBsPPM
   +NV48oSOIh8Pzq14f0FE++K9N2hk0J1MGAtTnZCzjnhmzDhcdt6j1QVxb
   Q==;
X-CSE-ConnectionGUID: 4IOfeBGlRqiLmwBis0p9pw==
X-CSE-MsgGUID: 69M/osSxQjaDvntGco+IaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13804621"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="13804621"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:43:51 -0700
X-CSE-ConnectionGUID: 9s6zS/BhQt67arFy2ujWnQ==
X-CSE-MsgGUID: 6auYehRnRBeQO0y66DqDhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="41793773"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.246.143]) ([10.245.246.143])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:43:50 -0700
Message-ID: <970501b1-09ae-4f2c-a078-2b4f23fe460e@linux.intel.com>
Date: Tue, 4 Jun 2024 15:43:46 +0200
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
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Zl7boEkMpQaELARP@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 11:17, Johan Hovold wrote:
> On Tue, Jun 04, 2024 at 10:33:02AM +0200, Pierre-Louis Bossart wrote:
>> On 6/4/24 02:52, Johan Hovold wrote:
>>> Clean up the probe warning messages by using a common succinct format
>>> (e.g. without __func__ and with a space after ':').
> 
>>> @@ -123,7 +123,7 @@ static int sdw_drv_probe(struct device *dev)
>>>  	/* init the dynamic sysfs attributes we need */
>>>  	ret = sdw_slave_sysfs_dpn_init(slave);
>>>  	if (ret < 0)
>>> -		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
>>> +		dev_warn(dev, "failed to initialise sysfs: %d\n", ret);
>>>  
>>>  	/*
>>>  	 * Check for valid clk_stop_timeout, use DisCo worst case value of
>>> @@ -147,7 +147,7 @@ static int sdw_drv_probe(struct device *dev)
>>>  	if (drv->ops && drv->ops->update_status) {
>>>  		ret = drv->ops->update_status(slave, slave->status);
>>>  		if (ret < 0)
>>> -			dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
>>> +			dev_warn(dev, "failed to update status: %d\n", ret);
>>
>> the __func__ does help IMHO, 'failed to update status' is way too general...
> 
> Error messages printed with dev_warn will include the device and driver
> names so this message will be quite specific still.

The goal isn't to be 'quite specific' but rather 'completely
straightforward'. Everyone can lookup a function name in a xref tool and
 quickly find out what happened. Doing 'git grep' on message logs isn't
great really, and over time logs tend to be copy-pasted. Just look at
the number of patches where we had to revisit the dev_err logs to make
then really unique/useful.

>> Replacing 'with status' by ":" is fine, but do we really care about 10
>> chars in a log?
> 
> It's not primarily about the numbers of characters but about consistency.

I am advocating for inclusion of __func__ everywhere...It's simpler for
remote support and bug chasing.

The exception to the rule would be dev_dbg where you can get the
function name with module options.

