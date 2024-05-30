Return-Path: <linux-kernel+bounces-195217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0885A8D48EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC8EB26580
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DC3155335;
	Thu, 30 May 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jNNl3YLE"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04B18396D
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062658; cv=none; b=Dt2m++9/tbeeehNKOi2TFm6iwK5/LNK5NrGsBgi4xE0vrNxcf7x/S+tsX7VpAHxoZya0o1nX0UIEJkfxOr4WtwNxPFM7VLD5le75u8s4fhXgp7BBK1qXu4NohGn3mvBh9UlHf+KCajjnStXq8Baxk0sbUs/5ExIyuEhdDQkaC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062658; c=relaxed/simple;
	bh=1sgCNFfhsLJPmuD7eeGzunJ4rWvci9DlA10mhqBH0wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HnYbbY74yCup6axv01WH/cLa+cnRiogeHJbmSmLhdMmgtSk7QiV6EV/Z5O9YYynKlAStExXsWSTsxYRj0hWJ9LWab2f3p0lWzIYspK8bGHi7vDDysk6TFnkzfnBwpGRIrZzp3v6DBwLzG482s9NFqmzQizJOL8cnS538wA2ukR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jNNl3YLE; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U9ofeI000674;
	Thu, 30 May 2024 04:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717062641;
	bh=uxW3c1qum3YvbkJyiB8ZfNCsUxF/LLwa29zaFh9WBSo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jNNl3YLEEGo1noulLDWchtMGhwcqU7HMX4oBAWoqivxTgbaVDdQjrkC1FEbSjSyEc
	 U+FNpjwRkzY0WqCFIYlhJyggeLdQaktZUp7u2GxJQCJdZSwYc2GRrX96GyNz4Y9eY8
	 CWQBpVgeHc26dww5Kkvbmnx6cw+8YHJmuqX0gjh4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U9ofST063338
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 04:50:41 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 04:50:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 04:50:41 -0500
Received: from [172.24.227.102] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U9oZbA020286;
	Thu, 30 May 2024 04:50:36 -0500
Message-ID: <d03478b9-bcfb-41e3-bdbd-7427577a70a0@ti.com>
Date: Thu, 30 May 2024 15:20:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/bridge: Add pixel clock check in atomic_check
To: Maxime Ripard <mripard@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <sam@ravnborg.org>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>,
        <dri-devel@lists.freedesktop.org>
References: <20240530092930.434026-1-j-choudhary@ti.com>
 <20240530092930.434026-3-j-choudhary@ti.com>
 <20240530-spiked-psychedelic-monkey-ddd0b0@houat>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20240530-spiked-psychedelic-monkey-ddd0b0@houat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Maxime,

On 30/05/24 15:04, Maxime Ripard wrote:
> Hi,
> 
> On Thu, May 30, 2024 at 02:59:30PM GMT, Jayesh Choudhary wrote:
>> Check the pixel clock for the mode in atomic_check and ensure that
>> it is within the range supported by the bridge.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   drivers/gpu/drm/bridge/sii902x.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>> index 6a6055a4ccf9..1bf2f14a772d 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -494,6 +494,12 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
>>   				       struct drm_crtc_state *crtc_state,
>>   				       struct drm_connector_state *conn_state)
>>   {
>> +	if (crtc_state->mode.clock < SII902X_MIN_PIXEL_CLOCK_KHZ)
>> +		return MODE_CLOCK_LOW;
>> +
>> +	if (crtc_state->mode.clock > SII902X_MAX_PIXEL_CLOCK_KHZ)
>> +		return MODE_CLOCK_HIGH;
>> +
> 
> atomic_check doesn't return drm_mode_status but regular error codes (0
> on success, negative error code on failure)

Okay.

Will club together both conditions and return -EINVAL.

Warm Regards,
Jayesh

> 
> Maxime

