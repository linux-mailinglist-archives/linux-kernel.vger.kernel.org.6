Return-Path: <linux-kernel+bounces-377192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB729ABB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B1A284912
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A3134CC4;
	Wed, 23 Oct 2024 01:36:07 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7402D2FA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647367; cv=none; b=fN4qvb7jExsZehKCMJ34Zr98ohNcaaCJ5/whBW9hTueDjmWk/3ucjjx/e+OGfKMNnYRK8MLAbAUMAUpfGFLd+2FocXpsKPRckBDGQziIv1MPx27xV07CvH23NIe0NxSKizlf0wlu30fkVSSvgnKEfMfH2A5OAaUcwFBX3JGuH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647367; c=relaxed/simple;
	bh=Sdbe3OfWd0oBNONVMXtq6ky8FHMHcJ6/1bLaa0ECN/A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=DsSj3l1AskKXDrq9ro/f2zJdMPpgWI4WrxTwASuPNhjuwMcJzN/dL6nb8sj5Tc5uRkfCHDUr763j1foP+aO90b7u8LJerq/b7wF2ftIRa9lEE9erMbL0Pk55rNhYnGjKyZDERNuKDHH6vGxzMVlF8/Ol+cTvLK/Uaa/za+Kp41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYBQv70yxz10Npx;
	Wed, 23 Oct 2024 09:33:59 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 68F7B180087;
	Wed, 23 Oct 2024 09:36:01 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 09:36:00 +0800
Message-ID: <80114de7-19c0-d860-c888-35e535915f78@huawei.com>
Date: Wed, 23 Oct 2024 09:35:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 0/4] drm/tests: Fix some memory leaks
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: Maxime Ripard <mripard@kernel.org>
CC: <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <christian.koenig@amd.com>,
	<ray.huang@amd.com>, <dmitry.baryshkov@linaro.org>,
	<dave.stevenson@raspberrypi.com>, <quic_jjohnson@quicinc.com>,
	<mcanal@igalia.com>, <davidgow@google.com>, <skhan@linuxfoundation.org>,
	<karolina.stolarek@intel.com>, <Arunpravin.PaneerSelvam@amd.com>,
	<thomas.hellstrom@linux.intel.com>, <asomalap@amd.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20241017063125.3080347-1-ruanjinjie@huawei.com>
 <20241018-gigantic-meticulous-pug-06ec1b@houat>
 <f7519595-8080-44c5-0477-e1281266b80b@huawei.com>
In-Reply-To: <f7519595-8080-44c5-0477-e1281266b80b@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/10/18 16:12, Jinjie Ruan wrote:
> 
> 
> On 2024/10/18 15:55, Maxime Ripard wrote:
>> Hi,
>>
>> On Thu, Oct 17, 2024 at 02:31:21PM GMT, Jinjie Ruan wrote:
>>> Fix some memory leaks in drm tests.
>>>
>>> Changes in v3:
>>> - Adjust drm/drm_edid.h header to drm_kunit_helpers.c.
>>> - Drop the "helper" in the helper name.
>>> - s/fllowing/following/
>>> - Add Acked-by.
>>
>> This creates build failures since drm_display_mode were const before,
>> and can't anymore.
> 
> It seems it came from bellowing v1, and this v3 has not reported the
> issue yet.
> 
> https://lore.kernel.org/all/202410180830.oitxTsOv-lkp@intel.com/

Hi, Maxime,

Should this series send again? The issue seems not related to this version.

> 
>>
>> Maxime
> 
> 

