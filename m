Return-Path: <linux-kernel+bounces-382864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F229B1427
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C570DB21D26
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 02:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4113BAE7;
	Sat, 26 Oct 2024 02:02:58 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC227217F33
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729908178; cv=none; b=WRGTanHpxhN0PqvfhK67n5//5zeQMQRfbuxbuJjRPFeEWX6J5OG08PL8H9PCD8hgBXK1+Md0onCQG95qTlDv8VFDVCJuKnLnqRqSLc5CJaNqkEBxzBde6DY5P4l5yUbAxtokgUzovs4eBDjaofNJrTXhUXTDuBk1CBrNBb6p274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729908178; c=relaxed/simple;
	bh=PgxZnjR327q1pL506DhqumL4gQfsKQzWUNCwv/jcVhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YjgweyV/FXOQNc3sZFUdwRrI/I2P/dmKu1Bqlf6rMwpd/zDFVEOmjIBe29I5qx2ND6ksY93ZUU+R2oeJsRUXE+/6yvxtLl0HHoOLZJwTO8ZcQIOpKkX51e1+9RW1zkUj9KfP7SckPX7mOk/Nim6CI4KdKZoEkDmugiuDogtdjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xb2v96mq3z1SD5g;
	Sat, 26 Oct 2024 10:01:25 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 13F3C180041;
	Sat, 26 Oct 2024 10:02:53 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 10:02:52 +0800
Message-ID: <fb6c6e6d-18ad-344d-c8ad-a9b90c6c2f28@huawei.com>
Date: Sat, 26 Oct 2024 10:02:51 +0800
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
 <f7519595-8080-44c5-0477-e1281266b80b@huawei.com>
 <80114de7-19c0-d860-c888-35e535915f78@huawei.com>
 <20241025-bold-light-vicugna-c30ecf@houat>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241025-bold-light-vicugna-c30ecf@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/25 22:33, Maxime Ripard wrote:
> On Wed, Oct 23, 2024 at 09:35:59AM +0800, Jinjie Ruan wrote:
>>
>>
>> On 2024/10/18 16:12, Jinjie Ruan wrote:
>>>
>>>
>>> On 2024/10/18 15:55, Maxime Ripard wrote:
>>>> Hi,
>>>>
>>>> On Thu, Oct 17, 2024 at 02:31:21PM GMT, Jinjie Ruan wrote:
>>>>> Fix some memory leaks in drm tests.
>>>>>
>>>>> Changes in v3:
>>>>> - Adjust drm/drm_edid.h header to drm_kunit_helpers.c.
>>>>> - Drop the "helper" in the helper name.
>>>>> - s/fllowing/following/
>>>>> - Add Acked-by.
>>>>
>>>> This creates build failures since drm_display_mode were const before,
>>>> and can't anymore.
>>>
>>> It seems it came from bellowing v1, and this v3 has not reported the
>>> issue yet.
>>>
>>> https://lore.kernel.org/all/202410180830.oitxTsOv-lkp@intel.com/
>>
>> Hi, Maxime,
>>
>> Should this series send again? The issue seems not related to this version.
> 
> As far as I know, the issues reported still apply there, so yes

Hi, Maxime,

I make this version code with "C=2", there is no these build failures.

> 
> Maxime

