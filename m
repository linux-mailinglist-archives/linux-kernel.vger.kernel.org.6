Return-Path: <linux-kernel+bounces-363664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A5E99C565
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CF11F23E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1215534B;
	Mon, 14 Oct 2024 09:15:41 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A913146A79
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897340; cv=none; b=kYKe129ZKMkI0pXp5f+c8hoXR+MumI52uXGW7jU/2OlBPFHuhqS3AHTZ01iuQdWa7P6RYJi00jtWjXZAgdc4HzH5TQ0w/qoJmd1akAR2uZAfNqJw+vL5cGxlrsIe69Nm15SesIT0kquJ+HjNtVEiKiAKSLgr0V6xU7pGMv3iLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897340; c=relaxed/simple;
	bh=lwy4gfZO0a4PCisCMQKcQsx9nhfO5FGIY/dXCls7r5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iJxF9kjWX2D0QzFXSWXxpv2yPoqvp7hJSXRK61njOJ1nyOHBwrqQQyuyfiMxRYGW7rZUN6Q/nCK3WocXUfbARW5AxC55rIcBho2MesJioFH4msy2Z7xLsTs9R1hVSpDJGoO2iZVbejvHw0zv88fLOWfv4kZ5EDVjDaondFbUTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XRs5k70Pzz1ymtQ;
	Mon, 14 Oct 2024 17:15:38 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 814DA140158;
	Mon, 14 Oct 2024 17:15:33 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 17:15:32 +0800
Message-ID: <dbe9c1c8-6c5c-f2da-545d-73e6fa535d8a@huawei.com>
Date: Mon, 14 Oct 2024 17:15:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/3] drm/connector: hdmi: Fix memory leak in
 drm_display_mode_from_cea_vic()
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
CC: <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <christian.koenig@amd.com>,
	<ray.huang@amd.com>, <dmitry.baryshkov@linaro.org>,
	<dave.stevenson@raspberrypi.com>, <mcanal@igalia.com>,
	<quic_jjohnson@quicinc.com>, <karolina.stolarek@intel.com>,
	<Arunpravin.PaneerSelvam@amd.com>, <thomas.hellstrom@linux.intel.com>,
	<asomalap@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20241014071632.989108-1-ruanjinjie@huawei.com>
 <20241014071632.989108-2-ruanjinjie@huawei.com>
 <20241014-fervent-whimsical-oyster-b0926d@houat>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241014-fervent-whimsical-oyster-b0926d@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/10/14 17:11, Maxime Ripard wrote:
> On Mon, Oct 14, 2024 at 03:16:30PM GMT, Jinjie Ruan wrote:
>> modprobe drm_connector_test and then rmmod drm_connector_test,
>> the following memory leak occurs.
>>
>> The `mode` allocated in drm_mode_duplicate() called by
>> drm_display_mode_from_cea_vic() is not freed, which cause the memory leak:
>>
>> 	unreferenced object 0xffffff80cb0ee400 (size 128):
>> 	  comm "kunit_try_catch", pid 1948, jiffies 4294950339
>> 	  hex dump (first 32 bytes):
>> 	    14 44 02 00 80 07 d8 07 04 08 98 08 00 00 38 04  .D............8.
>> 	    3c 04 41 04 65 04 00 00 05 00 00 00 00 00 00 00  <.A.e...........
>> 	  backtrace (crc 90e9585c):
>> 	    [<00000000ec42e3d7>] kmemleak_alloc+0x34/0x40
>> 	    [<00000000d0ef055a>] __kmalloc_cache_noprof+0x26c/0x2f4
>> 	    [<00000000c2062161>] drm_mode_duplicate+0x44/0x19c
>> 	    [<00000000f96c74aa>] drm_display_mode_from_cea_vic+0x88/0x98
>> 	    [<00000000d8f2c8b4>] 0xffffffdc982a4868
>> 	    [<000000005d164dbc>] kunit_try_run_case+0x13c/0x3ac
>> 	    [<000000006fb23398>] kunit_generic_run_threadfn_adapter+0x80/0xec
>> 	    [<000000006ea56ca0>] kthread+0x2e8/0x374
>> 	    [<000000000676063f>] ret_from_fork+0x10/0x20
>> 	......
>>
>> Free `mode` by calling drm_mode_destroy() to fix it.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: abb6f74973e2 ("drm/tests: Add HDMI TDMS character rate tests")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  drivers/gpu/drm/tests/drm_connector_test.c | 24 ++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
>> index 15e36a8db685..9c94d26b3486 100644
>> --- a/drivers/gpu/drm/tests/drm_connector_test.c
>> +++ b/drivers/gpu/drm/tests/drm_connector_test.c
>> @@ -1004,6 +1004,8 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb(struct kunit *test)
>>  	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
>>  	KUNIT_ASSERT_GT(test, rate, 0);
>>  	KUNIT_EXPECT_EQ(test, mode->clock * 1000ULL, rate);
>> +
>> +	drm_mode_destroy(drm, mode);
>>  }
> 
> If KUNIT_ASSERT_GT triggers, then we would end up leaking the mode as well.
> 
> I think we should create a kunit_drm_display_mode_from_cea_vic()
> function that registers a kunit action to free the mode when the test is
> done.

You are right! That will be nice and could be used by the new KUNIT test
modules.

> 
> Maxime

