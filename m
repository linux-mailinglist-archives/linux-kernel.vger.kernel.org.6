Return-Path: <linux-kernel+bounces-371215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154769A380A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE7E286321
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7453018C00B;
	Fri, 18 Oct 2024 08:08:03 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B218BC19
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238883; cv=none; b=rT7rVnAVbeq3jz55wkTw59QqOSP5c8FLwi/XGa8t2vcsjfXQJHYnJXLuJkwJz9QYCUnzJXqbGjBY7RfgObIN5vjYwGGC9YjEz2oUlriv+kyUGsYr9p6YuFy7Eih5bFt1arh0w5zmTT0/h0O3Xbhk0dFNAJ9Z0OhkVd8Vdwpj8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238883; c=relaxed/simple;
	bh=g6siRwcwCmhj1ZzwpNdy1wzO35nL/T4h+ZbgwJ0mK3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VF0b3wx2Is/JXX3wgyrVsl2TA/9zQ3ZokdY0Hd0zMQAG7oM5O2gIO9EWxxVUtPcjK+1HqOHuBfUkYBAWG33+XB3T9rvPOg+rZl6JOTg760RaEJRVYg9/plVD1jFfJk7m9Fg3PCX+bcnO/vOsm0Znw7QxmixBGGyQ3U210oArLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XVHNt360wzQrqK;
	Fri, 18 Oct 2024 16:07:10 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id D232914010D;
	Fri, 18 Oct 2024 16:07:56 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 16:07:55 +0800
Message-ID: <d88a55fe-742c-30f6-bc79-fcfd2b24a347@huawei.com>
Date: Fri, 18 Oct 2024 16:07:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 0/4] drm/tests: Fix some memory leaks
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
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241018-gigantic-meticulous-pug-06ec1b@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/10/18 15:55, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Oct 17, 2024 at 02:31:21PM GMT, Jinjie Ruan wrote:
>> Fix some memory leaks in drm tests.
>>
>> Changes in v3:
>> - Adjust drm/drm_edid.h header to drm_kunit_helpers.c.
>> - Drop the "helper" in the helper name.
>> - s/fllowing/following/
>> - Add Acked-by.
> 
> This creates build failures since drm_display_mode were const before,
> and can't anymore.

Let me fix it, thank you!

> 
> Maxime

