Return-Path: <linux-kernel+bounces-251412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0A09304A2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C292831A8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC8482DB;
	Sat, 13 Jul 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad1G+BEu"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC03FBAD
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720861337; cv=none; b=D3+xkZfKKIYTpaCo7rlqSxgNoDzdesoDphzzXJydiZk2j5x1dzUN9SobR31kupUjYJ6wwGTkJIhLcWzTPZvYrKfs+eWSggeyzBwrc0GuenAkF98U0+0TXUCBmQ/7IRAiAc4ylAqASI5NMlmjq0862+Zqb8xMOUUWQkklMogqJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720861337; c=relaxed/simple;
	bh=4CDmPtuUcoueTWif6LLavrc/h3BgkOcojjaCL2iSJ18=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cl7FUS09FblEFbAbBV9s/i3KOWihgb+IJRORIsdfG3Hb4xHg42iMRs/vhnUTG0XHmycqaAtToUm94GfvnSNR40+hfZtin7R2WRThnSEjk9Jo0QHqoOkw7ywrQYfmJXPNu6wk6EwrUL3SarDH32879+YOn9nxidJ4LFqVtiGHYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ad1G+BEu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so18274145e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720861334; x=1721466134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L/Z6ytgjYkJABiQN+tZhinfMJrsYsvW2kyUNVwhF20Y=;
        b=ad1G+BEun1BPbI4bxarFhp5JaudZJbhlPC74mLnrH9JDmNPMbB7OLG53nG/oCNlGTa
         lZSF3A7O1/2wD6oYv+6JiZnzNklClwhhvQb1mzksMlAmMVrFGHryY0SCbgMmA+GZlVpR
         6mmIECUeTH9Ub7kgPlPsP12Jq2q37sUqnFbEpO1ujB+LWKq8fsD4rcBYbNIgv7mfTKMf
         yQDl3PPnQPN/Gf7tEY9eKeb5RB9O1em/RKbCgrgrZPGOpVOF1Jp2MkReAQIOYf3bh9gl
         Q05D1SjgJ5ML28+6/mrRmq4Z9i3ankQjgmUFauQmtTN0TbK47gbDdgK7mDqn6yWRl+m7
         3Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720861334; x=1721466134;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/Z6ytgjYkJABiQN+tZhinfMJrsYsvW2kyUNVwhF20Y=;
        b=aKVQjDwJU+UcMsbKf7WvHhQuD7TYRGN3OredVpjALqfgLOjGSZ7Kbl33ZRGRXqEi8M
         3Djc+yJWv3fJ+QBsFaIrfmfm2n4N1TRuQ9ahSEoi9703scoAKLjZTxQVbauGeeiVZk2s
         NZLWBfIQUFmM4OzxF0VmTFFHXmFkNOi2tGRg/b8UlbrKSLBOGL6wKZUNoqgdsDfcYQae
         EyoGUrVMSJlVF3DacU+6JTFBp69d9TsMKX5uC+BlHdCyqZEgTTBUEDMy1EFKg+A5yV6h
         SUGEByZ2BxWrgFNyh0C067TbPSJmLczODES6uxVQqUj1OgQi0N9JLoMJQylFf5cKoiNB
         NSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk3IrF/VZEUF3WxASIUPPuW/P1lIJH2kZjOb7xrwiL2ZURppO5Tihvdzc6d+2CSyrACmlWSQ5AFypVXhd3ymuu1hyCitQSE24sQvN+
X-Gm-Message-State: AOJu0Yyg/pKwcM8obuTookadS9MBQUPVBZTY5kfPq8iyEI5/adJh0rQu
	xtClHlSRgw/pV9TfQlpSmwxMX1wPfUpFPmWJz6L8vwn9dTzCLRQU
X-Google-Smtp-Source: AGHT+IGL48OLIIxEavtVxiIkgMpDGnO6kxhOMNhGZFFOo7OXMnJWU8AHx4QpRv5VAW57z8PWQRM3Rw==
X-Received: by 2002:a05:600c:2184:b0:426:61e8:fb35 with SMTP id 5b1f17b1804b1-426707cc03dmr96399955e9.4.1720861333543;
        Sat, 13 Jul 2024 02:02:13 -0700 (PDT)
Received: from [192.168.1.127] ([185.77.198.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef3256sm13194205e9.39.2024.07.13.02.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 02:02:13 -0700 (PDT)
Message-ID: <833f19dc-a12f-4d31-a6a0-c3bfda7272c0@gmail.com>
Date: Sat, 13 Jul 2024 11:02:11 +0200
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
 <715bd3c4-6793-4c43-80e1-3956e03de017@gmail.com>
Content-Language: en-US
In-Reply-To: <715bd3c4-6793-4c43-80e1-3956e03de017@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/06/2024 13.54, Amer Al Shanawany wrote:
> On 5/22/24 16:48, Amer Al Shanawany wrote:
>> On 27/04/2024 15.40, Amer Al Shanawany wrote:
>>> Use the scope-based cleanup feature to clean up 'struct device_node *'
>>> when they go out of scope, and remove all instances of of_node_put()
>>> within the same scope, to simplify function exit and avoid potential
>>> memory leaks.
>>>
>>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>>> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
>>> ---
>>>    drivers/gpu/drm/vc4/vc4_drv.c  | 14 ++++++--------
>>>    drivers/gpu/drm/vc4/vc4_hdmi.c |  4 +---
>>>    drivers/gpu/drm/vc4/vc4_hvs.c  |  4 +---
>>>    3 files changed, 8 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
>>> index c133e96b8aca..bb0bb052e595 100644
>>> --- a/drivers/gpu/drm/vc4/vc4_drv.c
>>> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
>>> @@ -289,7 +289,6 @@ static int vc4_drm_bind(struct device *dev)
>>>        struct rpi_firmware *firmware = NULL;
>>>        struct drm_device *drm;
>>>        struct vc4_dev *vc4;
>>> -    struct device_node *node;
>>>        struct drm_crtc *crtc;
>>>        bool is_vc5;
>>>        int ret = 0;
>>> @@ -302,11 +301,10 @@ static int vc4_drm_bind(struct device *dev)
>>>        else
>>>            driver = &vc4_drm_driver;
>>>    -    node = of_find_matching_node_and_match(NULL, vc4_dma_range_matches,
>>> -                           NULL);
>>> +    struct device_node *node __free(device_node) =
>>> +        of_find_matching_node_and_match(NULL, vc4_dma_range_matches, NULL);
>>>        if (node) {
>>>            ret = of_dma_configure(dev, node, true);
>>> -        of_node_put(node);
>>>              if (ret)
>>>                return ret;
>>> @@ -341,10 +339,10 @@ static int vc4_drm_bind(struct device *dev)
>>>                goto err;
>>>        }
>>>    -    node = of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
>>> -    if (node) {
>>> -        firmware = rpi_firmware_get(node);
>>> -        of_node_put(node);
>>> +    struct device_node *np __free(device_node) =
>>> +        of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
>>> +    if (np) {
>>> +        firmware = rpi_firmware_get(np);
>>>              if (!firmware) {
>>>                ret = -EPROBE_DEFER;
>>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
>>> index d30f8e8e8967..915e8da3f41a 100644
>>> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
>>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
>>> @@ -3661,7 +3661,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>>>        struct drm_device *drm = dev_get_drvdata(master);
>>>        struct vc4_hdmi *vc4_hdmi;
>>>        struct drm_encoder *encoder;
>>> -    struct device_node *ddc_node;
>>>        int ret;
>>>          vc4_hdmi = drmm_kzalloc(drm, sizeof(*vc4_hdmi), GFP_KERNEL);
>>> @@ -3699,14 +3698,13 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>>>        if (ret)
>>>            return ret;
>>>    -    ddc_node = of_parse_phandle(dev->of_node, "ddc", 0);
>>> +    struct device_node *ddc_node __free(device_node) = of_parse_phandle(dev->of_node, "ddc", 0);
>>>        if (!ddc_node) {
>>>            DRM_ERROR("Failed to find ddc node in device tree\n");
>>>            return -ENODEV;
>>>        }
>>>          vc4_hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
>>> -    of_node_put(ddc_node);
>>>        if (!vc4_hdmi->ddc) {
>>>            DRM_DEBUG("Failed to get ddc i2c adapter by node\n");
>>>            return -EPROBE_DEFER;
>>> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
>>> index 04af672caacb..6e3613e06e09 100644
>>> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
>>> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
>>> @@ -845,15 +845,13 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>>>          if (vc4->is_vc5) {
>>>            struct rpi_firmware *firmware;
>>> -        struct device_node *node;
>>> +        struct device_node *node __free(device_node) = rpi_firmware_find_node();
>>>            unsigned int max_rate;
>>>    -        node = rpi_firmware_find_node();
>>>            if (!node)
>>>                return -EINVAL;
>>>              firmware = rpi_firmware_get(node);
>>> -        of_node_put(node);
>>>            if (!firmware)
>>>                return -EPROBE_DEFER;
>>>    
>> Hi,
>>
>> This patch is marked as new/archived on patchwork[1], however it didn't receive any feedback, and a similar patch has been already merged [2].
>>
>>
>> [1]: https://patchwork.kernel.org/project/dri-devel/patch/20240427134044.38910-1-amer.shanawany@gmail.com/
>>
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d65bfb9546eb627e3c578336355c5b81797f2255
>>
>> Thank you
>>
>> Amer
>>
> Hello,
> 
> Could anyone kindly provide some feedback on this patch?
> 
> Thank you
> 
> Amer
Hello all,

I have come to realize that unsubscribing from the mailing list shortly 
after sending this patch prevented me from receiving any feedback. My 
apologies for this oversight.

Thank you

Amer

