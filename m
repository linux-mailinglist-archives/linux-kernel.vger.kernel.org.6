Return-Path: <linux-kernel+bounces-358680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F7699825E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3451C1F23B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40A1BF336;
	Thu, 10 Oct 2024 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INirg5Ug"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2A1BE245;
	Thu, 10 Oct 2024 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552835; cv=none; b=dapzRyWf1UFoTebdSMUqrysmanuQrOeb8+nqVEdqjckrLyzL6C9bq+Ti7ew0loxc8ZedSstsIQ1K+rd8305a/bGBeOP3akkcpzWN+Kwk4QsiHUqh+Mw4pRu8ios1aiGKEVj3Gvn1h7ef4Q43LTtcRZiI3NGop/pWg/PR+XR6dKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552835; c=relaxed/simple;
	bh=re5Q+qO/hHoNx+eKZZ1hEuECNny9DIdvg8+EGAFqVig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyMtn1WuFby4mAfPOqs6As7CcDP5mZbYl4y7l5J2xu5IwCt3d8s4/W5ToyX+b1Ytli6lAN5rsE1WaVFjMQMQh7gaNSqFN1sZFop28gfZOmPDw3U/SbBkv+IFKP9TV+fR5aDo/jw4KmyMy5mHoGTJmfkCZNhqmtexlRKQ94/k9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INirg5Ug; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728552833; x=1760088833;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=re5Q+qO/hHoNx+eKZZ1hEuECNny9DIdvg8+EGAFqVig=;
  b=INirg5Ug+4+Ch0DdJMisIg58FBycSy7vUfj9mDBi9tOuXkxC7hsCt3f2
   oU3Dhgg/6U19j7PSBr70wiGN27jtNr1BOKx3Ps9n02VVofn1mMTn+JGXt
   z8J/FKOfXknV7J3ApkleUFRGFLQi6dFrb3Q/lYEH+NV9v5oALsNn/vCno
   TvbRKvIintG4K9ZGJGzJxWHo5grXJxmADeBT1YU3ddhkxBPfCuHQMwlTk
   pie09uYhx7QGG8PdrI5W3SSZO6nk9fow3WdOkSxwNhYyIoWVOtmzQ5rgU
   GSgZjg8qHxC6SqmmAmuTgzy6q4s85LFPjm3s92cIpCo+mohkpY6OMxIvP
   A==;
X-CSE-ConnectionGUID: UgRKTbP2RVyH5++iiGp5iA==
X-CSE-MsgGUID: PZLH6j5NS/qB2R7sGeA3FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27710352"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="27710352"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 02:33:52 -0700
X-CSE-ConnectionGUID: QgsLcRwqRKuJVaJxSY/Zcw==
X-CSE-MsgGUID: SKqVmDLOQ/maIfi6mzE8lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="76143171"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa006.fm.intel.com with ESMTP; 10 Oct 2024 02:33:49 -0700
Received: from [10.245.97.255] (unknown [10.245.97.255])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E7C982876E;
	Thu, 10 Oct 2024 10:33:46 +0100 (IST)
Message-ID: <6f64b79b-391e-4c78-98ac-8741b82201b4@intel.com>
Date: Thu, 10 Oct 2024 11:33:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] drm/xe/guc: Fix dereference before NULL check
To: Dan Carpenter <dan.carpenter@linaro.org>,
 "Everest K.C." <everestkc@everestkc.com.np>
Cc: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 skhan@linuxfoundation.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241010064636.3970-1-everestkc@everestkc.com.np>
 <1a5407c4-3b0f-48a1-940a-cc6b3ff3fb12@stanley.mountain>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <1a5407c4-3b0f-48a1-940a-cc6b3ff3fb12@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10.10.2024 08:54, Dan Carpenter wrote:
> On Thu, Oct 10, 2024 at 12:46:34AM -0600, Everest K.C. wrote:
>> The pointer list->list is dereferenced before the NULL check.
>> Fix this by moving the NULL check outside the for loop, so that
>> the check is performed before the dereferencing.
>> The list->list pointer cannot be NULL so this has no effect on runtime.
>> It's just a correctness issue.
>>
>> This issue was reported by Coverity Scan.
>> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600335
>>
>> Fixes: a18c696fa5cb ("drm/xe/guc: Fix dereference before Null check")

hmm, this seems wrong, shouldn't this be:

Fixes: 0f1fdf559225 ("drm/xe/guc: Save manual engine capture into
capture list")

>> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>> ---
> 
> Perfect!  Thanks.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> regards,
> dan carpenter
> 


