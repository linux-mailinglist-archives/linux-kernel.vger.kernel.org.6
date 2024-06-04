Return-Path: <linux-kernel+bounces-200930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3068FB6AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9832C282695
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4C213D533;
	Tue,  4 Jun 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxpV0Ufu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C924C91
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513945; cv=none; b=Obqr0u7DPuLoyr+yMjyNWitjtAmSjVdIeyNcBfGzUmmBlbW+G3x4CtHPxYnJJBMimDBKao4KYx0pY5srp0xof85AGMEg6kddQA2gQaz2r8/8TNEJN4fi5IjU5Wlod6dVil84gaKF2ArbjpDjE/4Fr+IKLf6lRQ/Lj+hjchtlI2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513945; c=relaxed/simple;
	bh=WI66YXFhtMtD9v7S0j/6cTY9ceJOboCB3afTlXQhJXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJhp0SZnvm886npzGGT5MyXCvkowPWlF4LcCpuPfa676VmJTM40TnTlA95zodFJpAlE10K6ziaIUAcgzZd3hP+DY0lFOxVsoDSu4KkfBolLYgTj4F9Sh7myRFxq2pRN1WPiZ00f4ZeuCXtPHXd6aSB+0uvbsNSR0h0h3ylPEGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxpV0Ufu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717513944; x=1749049944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WI66YXFhtMtD9v7S0j/6cTY9ceJOboCB3afTlXQhJXI=;
  b=QxpV0UfukzWfNwhfrdYg3C0EjxrY5utGwSYu/8yHRxgHKY0r027+H9Or
   Jg4Y/5PWHARtVjXcNlbXfpUSVDAAVUxYkZMBBTzAPaN2oADSke1Ce59e7
   EFBCnxmLXdAYc7i6mn+Eg98weLIEUxCZZif1iDCxTtgloRWRrvOaVYQDG
   DGAdWlQJIEb2/pmN1Ab4C4aRtt/Jit/4MUtw1TRLVnCSrPKZD19lj7SCJ
   vXFUA4JRbv6oEfG6mp3DpBd6jSuF4UkDot0d4bmaJLj2Eolbu5QEGdfNj
   edk6V9NnaUtD1GRR+5LUz4tAY4ya46JtRhGVF8L5IwfLi6RUJjFjRCC70
   w==;
X-CSE-ConnectionGUID: TfwOX+/7SeW8MV6KlREK5Q==
X-CSE-MsgGUID: fuNnVbq5QsOkPg79kYu71A==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31602488"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="31602488"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:12:06 -0700
X-CSE-ConnectionGUID: ISWGZxwKQBW4ys7I1KD4VA==
X-CSE-MsgGUID: XTj7vXuSQGWxND4FIYegeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37139624"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.246.143]) ([10.245.246.143])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:12:04 -0700
Message-ID: <60a99290-b71e-41e4-844b-f46d8f959c81@linux.intel.com>
Date: Tue, 4 Jun 2024 15:29:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] soundwire: bus: suppress probe deferral errors
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-2-johan+linaro@kernel.org>
 <c5ecc0cd-c2ba-4f71-ac2a-9a81793a8f0c@linux.intel.com>
 <Zl7ZyEkmm8kHeRvL@hovoldconsulting.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Zl7ZyEkmm8kHeRvL@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 11:09, Johan Hovold wrote:
> On Tue, Jun 04, 2024 at 10:30:21AM +0200, Pierre-Louis Bossart wrote:
>> On 6/4/24 02:52, Johan Hovold wrote:
>>> Soundwire driver probe errors are currently being logged both by the bus
>>> code and driver core:
>>>
>>> 	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -12
>>> 	wsa884x-codec sdw:4:0:0217:0204:00:0: probe with driver wsa884x-codec failed with error -12
>>>
>>> Drop the redundant bus error message, which is also incorrectly being
>>> logged on probe deferral:
>>
>> It's only redundant in the QCOM case... This would remove all error logs
>> for other codecs, e.g. see
>>
>> rt711_sdca_sdw_probe
>> cs35l56_sdw_probe
>> wcd9390_probe
>>
>> Looks like the wsa884x-codec is the chatty driver, others are just fine
>> with the existing code.
> 
> I believe you misunderstood this patch. The error messages above are not
> printed by the wsa884x-codec driver, but by the soundwire bus code and
> driver core, so the redundant error message will be printed for all
> codecs on probe failures.
> 
> And specifically, driver core will still log probe failures after this
> change.

Ah yes, you're right I read 'driver core' sideways, my bad. That's fine
then.

