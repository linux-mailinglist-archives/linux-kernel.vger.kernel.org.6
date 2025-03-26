Return-Path: <linux-kernel+bounces-576734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D00FA713BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7467A2902
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA221ACED5;
	Wed, 26 Mar 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDZU6qyB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3A19D8BC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981552; cv=none; b=VYPtD/iaJft1v2+s66lWNoJ2om/DgjGW9QONGdedzjFrWOPYatG0wYAIYEanUqRzsE6P/rkbp2Y1WbYtYZpTPVmKJfPrboEWkp/EGZfsWH5yt6Qs7NBmqoq7LSg1yz1LbXMBZT9kKLLrrtlO18mEmWOACUrsuhn+OwSJfoxS/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981552; c=relaxed/simple;
	bh=1HeaFRCuWpC2z81MjaUmAtlo+dMaip5uOptA/vYYllA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lVRq3YTPj6tODqhlb+P91Cp5aOXLO4KWvWBdjk62xvoPyiRAnELa05Q6IyTuB3z/g8zYuGEX61CBkSzLmUnqolYyXJLWbCbLf1MVDgPaiJphSTOHeWyNIwzDr8JaA0yXTrod3SDUL8czUfVfgim3OXFj1FRyED5GVUU2j42okWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDZU6qyB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742981551; x=1774517551;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1HeaFRCuWpC2z81MjaUmAtlo+dMaip5uOptA/vYYllA=;
  b=LDZU6qyBwEJLS8FFohL+aHCmLlUV5Xs7tnCHtg5gsiIiHsnB1Ws+uowD
   UfJ1Xgl94Jhzss+9Yk5voWxQnBQLmxCHYQeBnYWoe0thywcpqi4InN3CQ
   l3+UynYV/vMb4X2+ZlPQmieeoHX5rL21xtMuz/PBirTZpMBx0bYWqs12A
   nfGRQM5br1AtbdJpX4s61ShcSDOK5Ra9zFMaZMMu5pAZVoGudBq2v/SZk
   kIPxE9XSOAn1UB+Hfc+ko+z06DoFIpwZAPdcziv9XzrLdIfhYAz00MIOH
   lqjqo9FAIoEZBDEUsEbjHSfv6yC6grjFfnopvk8yRUa8CzpEN400jx9BJ
   w==;
X-CSE-ConnectionGUID: MCgASzHoQlGxo3LzMtke7g==
X-CSE-MsgGUID: U4b8RauxQEyYT8Fey4QiCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55253999"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="55253999"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 02:32:30 -0700
X-CSE-ConnectionGUID: lSaBGxSJTXakxwy9+HRwnA==
X-CSE-MsgGUID: UHUInTtKRqydZAYSkK+ydw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="124497744"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.210])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 02:32:24 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yongbang Shi <shiyongbang@huawei.com>, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, lidongming5@huawei.com,
 libaihan@huawei.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 shiyongbang@huawei.com
Subject: Re: [PATCH v7 drm-dp 5/9] drm/hisilicon/hibmc: Getting connector
 info and EDID by using AUX channel
In-Reply-To: <8ee961ca-0d3c-487d-a672-82714ee56743@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250319032435.1119469-1-shiyongbang@huawei.com>
 <20250319032435.1119469-6-shiyongbang@huawei.com>
 <87frj8c9ol.fsf@intel.com>
 <ff11c8ac-7eb4-42cb-86d3-ad9924c9374b@huawei.com>
 <87jz8ea6zq.fsf@intel.com>
 <8ee961ca-0d3c-487d-a672-82714ee56743@huawei.com>
Date: Wed, 26 Mar 2025 11:32:21 +0200
Message-ID: <875xjw87dm.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 25 Mar 2025, Yongbang Shi <shiyongbang@huawei.com> wrote:
>> On Mon, 24 Mar 2025, Yongbang Shi <shiyongbang@huawei.com> wrote:
>>>> On Wed, 19 Mar 2025, Yongbang Shi <shiyongbang@huawei.com> wrote:
>>>>> From: Baihan Li <libaihan@huawei.com>
>>>>>
>>>>> Add registering drm_aux and use it to get connector edid with drm
>>>>> functions. Add ddc channel in connector initialization to put drm_aux
>>>>> in drm_connector.
>>>>>
>>>>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>>>>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> ---
>>>>> ChangeLog:
>>>>> v6 -> v7:
>>>>>     - add if statement about drm aux in hibmc_dp_connector_get_modes(), suggested by Jani Nikula
>>>> I don't understand this, and I did not suggest such a thing.
>>>>
>>>> BR,
>>>> Jani.
>>>>
>>> Hi Jani,
>>>
>>> Is the modification of v8 correct?
>> I never received that for whatever reason.
>
> Here's the link: https://lore.kernel.org/all/20250320101455.2538835-1-shiyongbang@huawei.com/

Thanks.

The EDID handling looks fine.

AFAICT you leak dp->aux.name though.


BR,
Jani.



-- 
Jani Nikula, Intel

