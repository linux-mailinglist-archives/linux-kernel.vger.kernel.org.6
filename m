Return-Path: <linux-kernel+bounces-192682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED4E8D209A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53CABB22238
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E882171656;
	Tue, 28 May 2024 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYccBPkb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA8616C456;
	Tue, 28 May 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910864; cv=none; b=TMKQ5nbHf/immTRCC29RrFnPV5Zy0ReN/JwhiYt1DkembcN4ZstffhNtu1Xbaflof/+DdPfiby8/rWEVNcAfXS2MZBVRIrxVVNuwc75vDptaZSYsj5rKoKyZdMPukOvziXussoePzeod7gwR3kFvK1q/1AkEWggWDq0t/8nh9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910864; c=relaxed/simple;
	bh=GVjbv65YNJoDuQAJCKR21C5IvkBqp4L9LKrnLr6NVkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Czs8K/j22gKrKUEtOXiU0YbUr5jEgARo6Mj8earJiILae638SoxUhxGTX5xV5kKEm4x5eTJ/zHkzlQtJxFc/ENPlOKJCYJIcNAhbj+r4co4jYMZmvEiyebzf74rRifkD1+DQdq/YyaviYTcvJGVcVcc9wjeIrJihwuLVjer7+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYccBPkb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716910862; x=1748446862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GVjbv65YNJoDuQAJCKR21C5IvkBqp4L9LKrnLr6NVkw=;
  b=WYccBPkbBItro1d08L708B/1QDC9zPwBADqmWcCM4uDiTih5GE7SBPx9
   JKPbwwNu0o66GxihH8P/d8/ksYpImq2yDy+erHXNgAmOsmFO3TsAF1Ryl
   sf3EuzFvxEQXNrcwBB5ZonMoRGGlvT/FCqZzmxdecImhHjkofwv6Ze4xf
   hVBQ7h9vMk2/4ofh3TFbGzr84lPQhpM0q8cj9SOV1QdahfLIg2M7h87Iw
   ckrAd/G0dO/gP3HmkFLrRw7PFb55eEMn3OQG+EF1nnLTwVj61c+QwWkEt
   mHmMVHcEVj7v7nShZZ7xAjix3v6//hlVOJVIOHKDThRxgOo84ZlD8sBcj
   A==;
X-CSE-ConnectionGUID: w2W/+0mZQuK10GM3Y81sEw==
X-CSE-MsgGUID: FUd/xwpJSGaq9592xy7Yaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23820821"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="23820821"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 08:41:02 -0700
X-CSE-ConnectionGUID: ecUxvXzqTTatJ6tfwYl4Ng==
X-CSE-MsgGUID: qXKXv5P+T/m7mdMmtpI7qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35727960"
Received: from unknown (HELO [10.125.110.237]) ([10.125.110.237])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 08:41:02 -0700
Message-ID: <9d5f2625-f3e7-4212-8c9a-c22f137f39d9@linux.intel.com>
Date: Tue, 28 May 2024 10:41:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] soundwire: fix usages of
 device_get_named_child_node()
To: Markus Elfring <Markus.Elfring@web.de>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, linux-sound@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bard Liao <bard.liao@intel.com>,
 Vinod Koul <vinod.koul@linaro.org>
References: <20240528063533.26723-1-yung-chuan.liao@linux.intel.com>
 <0080bd18-58e1-4e82-96e0-e64d2fa978c9@web.de>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <0080bd18-58e1-4e82-96e0-e64d2fa978c9@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/24 10:19, Markus Elfring wrote:
>> Add fwnode_handle_put() to avoid leaked references.
> 
> Are you going to respond also to my previous patch review
> in more constructive ways?
> https://lore.kernel.org/lkml/eb15ab0a-e416-4ae9-98bb-610fdc04492c@web.de/
> https://lkml.org/lkml/2024/4/29/493

Sorry about that, both Bard and I missed your comments.

On the Fixes tag: I made a deliberate choice to add all the fixes in one
patch, to show that the usage was copy-pasted and done 'wrong' in
multiple places. That makes it really hard to add a Fixes tag since the
different uses were added in a time interval of about 5 years.
We could split and have multiple patches if that was desired, but I
would still not include a Fixes tag since the leaked references are not
that bad, we read the Manager properties on probe, and the peripheral
properties are generally not used by codec drivers, so it's unlikely
that any user will ever see a problem that requires a backport in
linux-stable. This problem was found by reading the documentation while
adding new things, not by any user report or test failure.

The error flow was revisited and hardened in a follow-up patchset which
also adds new properties for MIPI DisCo 2.1 spec [1], we'll share the
patches in this kernel cycle.

[1] https://github.com/thesofproject/linux/pull/4857

