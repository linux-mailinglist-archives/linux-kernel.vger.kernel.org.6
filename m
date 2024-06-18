Return-Path: <linux-kernel+bounces-219175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8A990CAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910351F23341
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B4D14B94E;
	Tue, 18 Jun 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ0I393C"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79214A63C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711664; cv=none; b=KDiBvjzJsC4Hotpwokj9/rhq5Ble0E7BjEGLXoiqAq7I9rl9JGzNweu/SNdPyH8s3L+J9hsrc1SubMAjK1FNGA7BmqtRkNbkMSLCH0hJKi2nFz4IzJQC+S1jCpW1DNDEIr95Cs5bsjeSf8CUhZRkvvC8tBrbtpaJsyGLKb1yJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711664; c=relaxed/simple;
	bh=tQD4ff6ktLJrvZ/66IISclkVUp2YanL/GUK31rKsItE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aWMS97fM01s0Ld0rRyogps0v1HlTHBpUsRNLu60qItTUv8kvJRMZgopT1RdmdexKMczhf0to8BR7OQUrNURrzC/4OAewH26GaJ/+VTsKs4Sv/gZdS+de1TWhE8IOOltppLUaatq+mNoU5DO9yzOMwG90Ta+/hfKnXNlq2vkQT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ0I393C; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4217926991fso47850215e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718711661; x=1719316461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QT0LJCKK8ZmuRtEf/e5DyLzGmwVU96dxmjGMHMBhQGY=;
        b=QJ0I393Czev65+cP6U6OvnlPH52rYMTzQpPjMi7WmRIwYS90iMLNc2s0OSHyfdf4Ax
         Ei0vRplye/uChKVKe0/EDwqJ5Kx/TgO2ehXYqXWBMSIr72yFgJzaCL8YT11LuN24RYEi
         FVIMBd1dzv/un4JQ0h4kBZM/Vw+W1IqFraAxrD9is9xZii38H/ZZ8JM3GqeqlH3btICG
         dI0tdig0Y/Ym1AShXb4tmiD8A1m4gsk/5EZl9xgZeJGSKBw13rAdFhXw9vPnSRs3/JXI
         HVuGjT2gN5FbQbN7gokqalaeCfufgwyDvL0AYZLaWttb5rHPwCKT3yxAv2PXrWb64YR5
         TQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718711661; x=1719316461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QT0LJCKK8ZmuRtEf/e5DyLzGmwVU96dxmjGMHMBhQGY=;
        b=h2QIAnExKSvHi8QiRWPlRKcS4UL9+x7NOjzus1weEqtcRRbqQpRH/Y05XiqzoXNDwT
         gHml7yuaf46NK0gFi0axVWPgQlIlZcb/iN8p1qarZm+omiuhe/NCUDgrb03KdHdYxzTE
         jqiVZEtTXccQ+FUZBUbhRZkEKp7iE4xREdWk/Blou1hw4cS0fEvqMQaJwfNIfJDIkg66
         5TEemh6KuaQnJtTKmEGG9VbtOlnK9qr4K5JgV2NN4IEbvX2XorsNKyMWRirfUc21wa78
         biebPcMuDlkpdr9kyuFy/Rw2iZNUziMYRUBhEn2gJ8TkkC+723LBtiQg1co37NJAIh4Y
         B7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL8xeAaJTuVCfB6Ojbnde9Z6EPFkv7R79hX2FM3HIzmh+8Tl0nTNlgX2fllgkknCsqSJL82VGF14LLVxeFbpnKrP+pVeNdTgdt9xi7
X-Gm-Message-State: AOJu0YwSlL93ftt0ljiFO3KAYmDm9t2nSflsikVEaJhcsLFzRPwX1H1Y
	eu18Z/rNrHbbvEwYKn/FI6zEVFTzqJjAhTfztyAIEYQ9GZ7b6vhj
X-Google-Smtp-Source: AGHT+IExl6Spt8ZEYzfZOVdhdG/OIMY9uR58n88wMu+PjSjgmwo1TdIZpjxjd0NKyBjFHGqsPwpang==
X-Received: by 2002:a7b:c44e:0:b0:41b:fc3a:f1ef with SMTP id 5b1f17b1804b1-42304858447mr99461865e9.33.1718711660373;
        Tue, 18 Jun 2024 04:54:20 -0700 (PDT)
Received: from [192.168.1.161] ([185.77.198.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602feb0sm183234765e9.20.2024.06.18.04.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:54:16 -0700 (PDT)
Message-ID: <715bd3c4-6793-4c43-80e1-3956e03de017@gmail.com>
Date: Tue, 18 Jun 2024 13:54:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vc4: remove all usages of of_node_put()
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240427134044.38910-1-amer.shanawany@gmail.com>
 <df115f89-2979-42a5-b521-4bc4f8f4a335@gmail.com>
Content-Language: en-US
In-Reply-To: <df115f89-2979-42a5-b521-4bc4f8f4a335@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/22/24 16:48, Amer Al Shanawany wrote:
> On 27/04/2024 15.40, Amer Al Shanawany wrote:
>> Use the scope-based cleanup feature to clean up 'struct device_node *'
>> when they go out of scope, and remove all instances of of_node_put()
>> within the same scope, to simplify function exit and avoid potential
>> memory leaks.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
>> ---
>>   drivers/gpu/drm/vc4/vc4_drv.c  | 14 ++++++--------
>>   drivers/gpu/drm/vc4/vc4_hdmi.c |  4 +---
>>   drivers/gpu/drm/vc4/vc4_hvs.c  |  4 +---
>>   3 files changed, 8 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
>> index c133e96b8aca..bb0bb052e595 100644
>> --- a/drivers/gpu/drm/vc4/vc4_drv.c
>> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
>> @@ -289,7 +289,6 @@ static int vc4_drm_bind(struct device *dev)
>>       struct rpi_firmware *firmware = NULL;
>>       struct drm_device *drm;
>>       struct vc4_dev *vc4;
>> -    struct device_node *node;
>>       struct drm_crtc *crtc;
>>       bool is_vc5;
>>       int ret = 0;
>> @@ -302,11 +301,10 @@ static int vc4_drm_bind(struct device *dev)
>>       else
>>           driver = &vc4_drm_driver;
>>   -    node = of_find_matching_node_and_match(NULL, vc4_dma_range_matches,
>> -                           NULL);
>> +    struct device_node *node __free(device_node) =
>> +        of_find_matching_node_and_match(NULL, vc4_dma_range_matches, NULL);
>>       if (node) {
>>           ret = of_dma_configure(dev, node, true);
>> -        of_node_put(node);
>>             if (ret)
>>               return ret;
>> @@ -341,10 +339,10 @@ static int vc4_drm_bind(struct device *dev)
>>               goto err;
>>       }
>>   -    node = of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
>> -    if (node) {
>> -        firmware = rpi_firmware_get(node);
>> -        of_node_put(node);
>> +    struct device_node *np __free(device_node) =
>> +        of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
>> +    if (np) {
>> +        firmware = rpi_firmware_get(np);
>>             if (!firmware) {
>>               ret = -EPROBE_DEFER;
>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> index d30f8e8e8967..915e8da3f41a 100644
>> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> @@ -3661,7 +3661,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>>       struct drm_device *drm = dev_get_drvdata(master);
>>       struct vc4_hdmi *vc4_hdmi;
>>       struct drm_encoder *encoder;
>> -    struct device_node *ddc_node;
>>       int ret;
>>         vc4_hdmi = drmm_kzalloc(drm, sizeof(*vc4_hdmi), GFP_KERNEL);
>> @@ -3699,14 +3698,13 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>>       if (ret)
>>           return ret;
>>   -    ddc_node = of_parse_phandle(dev->of_node, "ddc", 0);
>> +    struct device_node *ddc_node __free(device_node) = of_parse_phandle(dev->of_node, "ddc", 0);
>>       if (!ddc_node) {
>>           DRM_ERROR("Failed to find ddc node in device tree\n");
>>           return -ENODEV;
>>       }
>>         vc4_hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
>> -    of_node_put(ddc_node);
>>       if (!vc4_hdmi->ddc) {
>>           DRM_DEBUG("Failed to get ddc i2c adapter by node\n");
>>           return -EPROBE_DEFER;
>> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
>> index 04af672caacb..6e3613e06e09 100644
>> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
>> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
>> @@ -845,15 +845,13 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>>         if (vc4->is_vc5) {
>>           struct rpi_firmware *firmware;
>> -        struct device_node *node;
>> +        struct device_node *node __free(device_node) = rpi_firmware_find_node();
>>           unsigned int max_rate;
>>   -        node = rpi_firmware_find_node();
>>           if (!node)
>>               return -EINVAL;
>>             firmware = rpi_firmware_get(node);
>> -        of_node_put(node);
>>           if (!firmware)
>>               return -EPROBE_DEFER;
>>   
> Hi,
>
> This patch is marked as new/archived on patchwork[1], however it didn't receive any feedback, and a similar patch has been already merged [2].
>
>
> [1]: https://patchwork.kernel.org/project/dri-devel/patch/20240427134044.38910-1-amer.shanawany@gmail.com/
>
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d65bfb9546eb627e3c578336355c5b81797f2255
>
> Thank you
>
> Amer
>
Hello,

Could anyone kindly provide some feedback on this patch?

Thank you

Amer

