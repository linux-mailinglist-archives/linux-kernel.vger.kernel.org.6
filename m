Return-Path: <linux-kernel+bounces-408869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BD29C8478
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CAD284FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B29A1F7551;
	Thu, 14 Nov 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7MJA6qU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5F1F472D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571299; cv=none; b=V9NHs6ftdOI0hVGkhw8aeHBm8jQBJMYD5K8Eeci4D9Wn70Q/V5amkegef3p3ZAiq7ZYH5HxmEPJzWF4rfWcNusrSCpdilW6ynBXaytn7Q+jyKWfEHVS+iaPXBzKIskkoI/XSnC3fqjTVSP7FnER7B39/gYvJQglT3JGOq/S17tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571299; c=relaxed/simple;
	bh=Qka/a3kZTQ8Mhjjbyc+iyeYQhIQ3WxkT3FKtU/EMAC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJAVv4NwmQU9WU6nd4zuALYkdIDjirN5Uz/MOo9yW273prwDBZLUsAx/TVqAiZMofpnq6g6V6oZQfUjb6Q2hLdUX6eY5qUG7rHvif5j/8/ZKua9UD7B359DDOCE4urBQ1SQiGpTMHe44TEYA9VC1F+WhK3XQDJTi6a6/U41VdfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7MJA6qU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571297; x=1763107297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qka/a3kZTQ8Mhjjbyc+iyeYQhIQ3WxkT3FKtU/EMAC0=;
  b=R7MJA6qUp6tbSsYH+iKgufshdRWXr6LuXS7dKNpswQ6oKfGo/Ctn1gsd
   h45ebbtAwHYI0qjCOlEettJP95qrdBnMxOJeiuKx7e61RwpIn2XK08MGc
   1O0GCDgovNnscSRHEGAz56ilhBE4A8iQAzgv7D/Wd+9xDNwdPZpmHKEKn
   H8L5O17Wra8c9XzPmrIdfeLG9SfkY/YfokkN8D6NZy7nqFwonCO6cTfGX
   iiVowtW2jto1oXbuIJsD7AgROU9Joevilg6yDH7ageGjua+7meUx5cizv
   LNmgwq4K8gSycLnnqyImE3kuZeRoLcnPDNbUPl6oOoiZ9bIaqne4Sh1fF
   w==;
X-CSE-ConnectionGUID: P21K6D/yRciYEUBmLVdtwQ==
X-CSE-MsgGUID: 64qhusjXQdiHOPdqi6dVXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="35291042"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="35291042"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:01:37 -0800
X-CSE-ConnectionGUID: RSjFbsgUSK2aiPm6Jz9sow==
X-CSE-MsgGUID: 29njlxtzRhaNQOaN1ECwEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="118942742"
Received: from unknown (HELO [10.237.72.151]) ([10.237.72.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Nov 2024 00:01:36 -0800
Message-ID: <6d3f1fd0-1ead-4a01-bb2d-8482f8c1799f@linux.intel.com>
Date: Thu, 14 Nov 2024 10:01:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] i3c: dw: Add quirk to address OD/PP timing issue
 on AMD platform
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-6-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20241108073323.523805-6-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 9:33 AM, Shyam Sundar S K wrote:
> The AMD Legacy I3C is having a problem with its IP, specifically with the
> push-pull and open-drain pull-up registers. These registers need to be
> manually programmed for every CCC submission to align with the duty cycle.
> Therefore, add a quirk to address this issue.
> 
> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/dw-i3c-master.c | 29 ++++++++++++++++++++++++++++-
>   drivers/i3c/master/dw-i3c-master.h |  1 +
>   2 files changed, 29 insertions(+), 1 deletion(-)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

