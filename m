Return-Path: <linux-kernel+bounces-226970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5EA914689
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1712858F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B621131BDD;
	Mon, 24 Jun 2024 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rIou4O5c"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C32F855
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221868; cv=none; b=DSBsCtnEzam8UBnvsXoQyLL6IOrAGVymEHty7hZL7D7nefp5j5Urxr1G0PRcINZDniUaiRPqnwueKQjrH7PNx527mfbXgYc5ASxZQW7+YZEITkcT9l8iHI7vO/t/kifrSGN6vF79qhWD+4GmibXhHWOYlpPDDHUsgbcmHZd0eWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221868; c=relaxed/simple;
	bh=C30TTx8TB8ZJvp0bhoEXvvKaEFpZQlguB0Jo89wFZkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UpeEAuTWJVJpvSoVYZ9vq5F8UBMmDfS18Z/wlguFJhsAFsaHLydQ/kimIsLMzr7p299AeIlEAKCMOO8wDlc35YbPydhbupVcPO1T+YUn2HZh3phZB7nL5LNYPRTybUE14GjOhXfgTshUYEHwG8UWTUZRZRrToz9YwIoFabLyMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rIou4O5c; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45O9bHLS122303;
	Mon, 24 Jun 2024 04:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719221837;
	bh=AaQ/LR+ijOFw/32g30wGsqN1roPhH5PfleRQKeSPeFI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rIou4O5cVwEEL0B+cca8fEERw21p16TACAysALVnGvcLF76ccx2HGUF0wiWNuUSUI
	 c2klSQFv+VEdBrOpGhA3AF+EFXUfoMGTT7elO5HqXJhtmY3ML06NFjweZ40brJ29S2
	 EYC0e/b9wt5+eKylJ/zBLALVubW9V9ire81Peax0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45O9bHNL030245
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Jun 2024 04:37:17 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 04:37:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jun 2024 04:37:16 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45O9bBlQ058858;
	Mon, 24 Jun 2024 04:37:11 -0500
Message-ID: <b221c978-2ce0-4d31-8146-ab43a9f86a1f@ti.com>
Date: Mon, 24 Jun 2024 15:07:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR case
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jan Kiszka
	<jan.kiszka@siemens.com>, Marek Vasut <marex@denx.de>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman
	<jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg
	<sam@ravnborg.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com>
 <f6af46e0-aadb-450a-9349-eec1337ea870@ti.com>
 <2f3bb86b-6f8c-4807-985e-344a0c47864c@siemens.com>
 <3277848.aeNJFYEL58@steina-w>
 <b2052bc9-b2da-489b-9e5b-3c9b4f6c1c99@ideasonboard.com>
 <bc96c6b5-a7f8-4ef3-a89b-bf577943f11c@denx.de>
 <36ef53b6-57a3-42e4-95ef-a10eef4ca1c9@siemens.com>
 <o4bwopeuyxm6344oqqm3e7p3xcx76aw2trsiuhhfyhel2e7po7@sz2jaj6i7kqd>
 <71e809fa-b471-4bb3-8f7d-e497397c0de4@ti.com>
 <bebvl4vycvpkdqjlz3xi33t7qtb4oj7mriywxmahfemyee3uxk@m3nbraynomg2>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <bebvl4vycvpkdqjlz3xi33t7qtb4oj7mriywxmahfemyee3uxk@m3nbraynomg2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 22/06/24 17:49, Dmitry Baryshkov wrote:
> On Sat, Jun 22, 2024 at 05:16:58PM GMT, Aradhya Bhatia wrote:
>>
>>
>> On 17-Jun-24 13:41, Dmitry Baryshkov wrote:
>>> On Mon, Jun 17, 2024 at 07:40:32AM GMT, Jan Kiszka wrote:
>>>> On 16.02.24 15:57, Marek Vasut wrote:
>>>>> On 2/16/24 10:10, Tomi Valkeinen wrote:
>>>>>> Ok. Does anyone have a worry that these patches make the situation
>>>>>> worse for the DSI case than it was before? Afaics, if the DSI lanes
>>>>>> are not set up early enough by the DSI host, the driver would break
>>>>>> with and without these patches.
>>>>>>
>>>>>> These do fix the driver for DRM_BRIDGE_ATTACH_NO_CONNECTOR and DPI, so
>>>>>> I'd like to merge these unless these cause a regression with the DSI
>>>>>> case.
>>>>>
>>>>> 1/2 looks good to me, go ahead and apply .
>>
>> Isn't there any way for the second patch to move forward as well though?
>> The bridge device (under DPI to (e)DP mode) cannot really work without
>> it, and the patches have been pending idle for a long time. =)
>>
>>>>
>>>> My local patches still apply on top of 6.10-rc4, so I don't think this
>>>> ever happened. What's still holding up this long-pending fix (at least
>>>> for our devices)?
>>>
>>> Neither of the patches contains Fixes tags. If the first patch fixes an
>>> issue in previous kernels, please consider following the stable process.
>>>
>>> If we are unsure about the second patch, please send the first patch
>>> separately, adding proper tags.
>>>
>>
>> Thanks Dmitry! I can send the patches again with the required fixes
>> tags (or just patch-1 if we cannot do anything about patch-2).
> 
> The problem with the second patch is that it get mixed reviews. I can
> ack the first patch, but for the second one I'd need a confirmation from
> somebody else. I'll go on and apply the first patch later today.
> 

Thanks Dmitry!

However, would it be okay if I instead add another patch that makes 2
versions of the "tc_edp_bridge_funcs", say "tc_dpi_edp_bridge_funcs" and
"tc_dsi_edp_bridge_funcs", that have all the same function hooks except
for the .edid_read()?

The dsi edid_read() will remain the same, and Tomi's patch - patch 2/2 -
will only fix the dpi version of the edid_read()?

The bridge already has the capability to distinguish a DSI input from a
DPI input. This can be leveraged to decide which set of functions need
to be used without any major changes.


Regards
Aradhya

