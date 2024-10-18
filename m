Return-Path: <linux-kernel+bounces-371229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB109A3844
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E9C287B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDC218C92E;
	Fri, 18 Oct 2024 08:12:50 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7B18C91F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239170; cv=none; b=bPx/p25OklC5/IDoCZ70uz/Z0lJ5wCTUq3POUJXGR7R6efVKF3TYd4m+4HzVnMOFGv8erH+VpmdBzSaOklcpUK0N9O4mgi89jZXfGDaUK+bViXiLi/X0UWoEf3ybsW5z7B0289fJDOJ1H8MzP9IBvMik79UNtOKtegM+YSJwwWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239170; c=relaxed/simple;
	bh=XdaO+rUMHK4cxy75peSGr+VRvxxhqK0vBc/um4vJkeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QKlC8gExtzI+9je8eS/St3QJ2/UZXEA3dppibh++pXcm4eYtk0Adtk+ZYZQyrRCgSBB9xxOy6zb8Uwz8oTQuSuIwvZTok/kKyBD5+NCRVtEqlE3VAZBMGc99hT46TKlAbiNfuAdxh0dyAbisczv8NXRXSiglDJb2KvRClau5TbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XVHTg22Dvz1jB9H;
	Fri, 18 Oct 2024 16:11:19 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id B545E14022D;
	Fri, 18 Oct 2024 16:12:35 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 16:12:34 +0800
Message-ID: <f7519595-8080-44c5-0477-e1281266b80b@huawei.com>
Date: Fri, 18 Oct 2024 16:12:34 +0800
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
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241018-gigantic-meticulous-pug-06ec1b@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

It seems it came from bellowing v1, and this v3 has not reported the
issue yet.

https://lore.kernel.org/all/202410180830.oitxTsOv-lkp@intel.com/

> 
> Maxime

