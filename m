Return-Path: <linux-kernel+bounces-200254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DF28FADB4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B67A282758
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03591428E5;
	Tue,  4 Jun 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pr5jbsb6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE4140391
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490276; cv=none; b=A+Ic4UGTFNe/mLIoC04dQ1ooL4yiJZ/BjBSxvyEpa6z6d4eGuHW0Y5au3hc5WuV0LpCaeMi8ARUhKnf6qcmq4A7CZ9+NltWT7NpJALhe5tIMZXTp2KH7cxCzpuM3ZCJtuUv9wZx/Fqxqq6hnKZI+vCpOMlsWNBw40nxYFl8cpSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490276; c=relaxed/simple;
	bh=9Pomqts/Pt3XLTeQ+wcHCwmRtL3bWzsgNN6TTXHmXuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCgFGJVxDAJJQA70T5KLqP8IfNsHO/LfPP2f5qDPgmOsofzYyEQaBl0hrqOVofM40jA5kcKZ6GtDKEfd4oKfRzykSu9nt28Uk2KSad79V2qiJigdwdIge3o5gQBsPQDOahvY2+Z1fSy/w1ObR2djJ1MEGNinGzuowUMzjmZ1EqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pr5jbsb6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717490275; x=1749026275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Pomqts/Pt3XLTeQ+wcHCwmRtL3bWzsgNN6TTXHmXuI=;
  b=Pr5jbsb66aBalzOv0wAYqVHw7jqbe34RvWNWSf9y1a9YAzbp5Lh8vlYU
   SIoV2WrqWqnEp6IhRe/V5WjdKrxubx+k+Ec2YUsL9ttLAtbejSjUdRMbs
   46wCkvmaQ2hOz4XrwHlBEAWX3WcnLfX6b3OBlgJbZ4ziFLbz20B8ZsSSh
   rIb2GCPNzq6tJ9NZMQ3EiKAk2srtzhOObUIVJeI+RNiHCdGyQk5e6Yj4A
   ucM4dWFcv4Lq6lhVg0ew5Bo1QhiD/G/bxZ/YsL7EO1u6YmOPem34kiId9
   qJiA7Vjq5w/WuM41qKTM7cZW4dwmYUXeGoz+bHIF785KVSxjDEey595YB
   Q==;
X-CSE-ConnectionGUID: Pj99jobAS8O4deKCfCScUw==
X-CSE-MsgGUID: ebalrNolSYWYYbSCqpQqxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17809379"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="17809379"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 01:37:54 -0700
X-CSE-ConnectionGUID: w2rWr0ilSTamxblJ/0p2gw==
X-CSE-MsgGUID: jJaY21gHQ1Sncq3lV065JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37638029"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.246.105]) ([10.245.246.105])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 01:37:52 -0700
Message-ID: <c5ecc0cd-c2ba-4f71-ac2a-9a81793a8f0c@linux.intel.com>
Date: Tue, 4 Jun 2024 10:30:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] soundwire: bus: suppress probe deferral errors
To: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240604075213.20815-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 02:52, Johan Hovold wrote:
> Soundwire driver probe errors are currently being logged both by the bus
> code and driver core:
> 
> 	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -12
> 	wsa884x-codec sdw:4:0:0217:0204:00:0: probe with driver wsa884x-codec failed with error -12
> 
> Drop the redundant bus error message, which is also incorrectly being
> logged on probe deferral:

It's only redundant in the QCOM case... This would remove all error logs
for other codecs, e.g. see

rt711_sdca_sdw_probe
cs35l56_sdw_probe
wcd9390_probe

Looks like the wsa884x-codec is the chatty driver, others are just fine
with the existing code.

