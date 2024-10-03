Return-Path: <linux-kernel+bounces-348875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB09898ECF5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C41D2829D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7CA149C6F;
	Thu,  3 Oct 2024 10:30:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8ED136338
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951410; cv=none; b=HKaVQ3C1nkbyFPWzibST15uVVYcdGtzNO19DNTp++R5LcjdNjzKjLjFM9EAh70RzS6HBtOXzrRQrZHlMuWQLTsAqzwOzuRg5ePueC8S9uMlSqdkKo42fHjmNh0brzb7d6dFlEciePLqsUAZFmeuOxwbMnUYzeDsp/yYWBggIpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951410; c=relaxed/simple;
	bh=Z8R3etoXxtOld6K/4IgMmkxQn05YSElJHj7sp77GacA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgctv/HEolMrFWmSjmHULhmEjX6LxCJDrfkXexocjm96xo3I2m8VVtAFy9qz0lC/0kQeHlXmSuXo6AAC66JEPj2SDkfQ2kb2k6Hjj1tB2re4pAXAjNA24XkyYMqUvFfmqnNgG8W/ymv9lQE9kiokSKiGsSz6lwA6P75wy/PudWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 834C7339;
	Thu,  3 Oct 2024 03:30:30 -0700 (PDT)
Received: from [10.1.39.32] (e122027.cambridge.arm.com [10.1.39.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3225F3F64C;
	Thu,  3 Oct 2024 03:29:58 -0700 (PDT)
Message-ID: <4c8cf37c-1576-4633-9f75-01e26e95f6c2@arm.com>
Date: Thu, 3 Oct 2024 11:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Add missing OPP table refcnt decremental
To: Boris Brezillon <boris.brezillon@collabora.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241003002603.3177741-1-adrian.larumbe@collabora.com>
 <20241003091740.4e610f21@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241003091740.4e610f21@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/10/2024 08:17, Boris Brezillon wrote:
> On Thu,  3 Oct 2024 01:25:37 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
>> Commit f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
>> retrieves the OPP for the maximum device clock frequency, but forgets to
>> keep the reference count balanced by putting the returned OPP object. This
>> eventually leads to an OPP core warning when removing the device.
>>
>> Fix it by putting OPP objects as many times as they're retrieved.
>> Also remove an unnecessary whitespace.
>>
>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>> Fixes: f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
> 
> Reviewed-by: 

I assume that tag shouldn't be there ;)

>> ---
>>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>> index 2d30da38c2c3..c7d3f980f1e5 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
>> @@ -38,7 +38,7 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
>>  		return PTR_ERR(opp);
>>  	dev_pm_opp_put(opp);
>>  
>> -	err =  dev_pm_opp_set_rate(dev, *freq);
>> +	err = dev_pm_opp_set_rate(dev, *freq);
>>  	if (!err)
>>  		ptdev->pfdevfreq.current_frequency = *freq;
>>  
>> @@ -177,6 +177,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>>  	 */
>>  	pfdevfreq->current_frequency = cur_freq;
>>  
>> +	dev_pm_opp_put(opp);
>> +
> 
> Shouldn't this be moved after the dev_pm_opp_set_opp() that's
> following?

I agree.

I'm not sure what the devfreq maintainers would think, but there's now a
few drivers that basically want find_available_max_freq() exported - if
you're interested in a wider cleanup then it might be worth looking at.

Steve

>>  	/*
>>  	 * Set the recommend OPP this will enable and configure the regulator
>>  	 * if any and will avoid a switch off by regulator_late_cleanup()
> 


