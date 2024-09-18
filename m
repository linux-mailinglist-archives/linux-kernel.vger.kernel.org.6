Return-Path: <linux-kernel+bounces-332554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F9797BB26
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5A31F24DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1805184114;
	Wed, 18 Sep 2024 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cubQ4nhU"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72C158522
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656977; cv=none; b=mYiJas5zn/Klpyy87dpuR6Kqvh1Q9PMqIVVah71RTIB97GiNyw7RNFCODLlcH+I5y4R8E/quEMPFXV9UUAt5FbBTpsg1yNY5zD812zzvfSN7ye7NfLJsIhBeqp5N95lIqUFvcKVNkLFehMFuS7364V5zja7QalndtcdkcgcfMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656977; c=relaxed/simple;
	bh=1GAnHGD26ccjCUphmCxybd5/3JfQEutdlYE5pfnKPlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKKRDZfQ92/v0WFtD0qL7u5ubM8MB9GbFzcqrZ0F8WsOrIEZidYE3PHvrzED4sNmw0dTbvzh04Cj1zEaZZ9KJ41T8O0TfcXahxHLAgXuaeFOO6Te25+rmSAWzhiIp5wEQsFFwFsranO/c79sO+r6Tbm3s7k1/wWkxXN46qFJ1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cubQ4nhU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7191fb54147so4768500b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726656975; x=1727261775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p41HDdPJ9Xqsou/GrXV93VQCKVWaaOB67+1yPY3lbP0=;
        b=cubQ4nhU/9ePBV9bQev71WQY6TVXsUKLFKEDaJ0IJUgWCLt0i9xDV4uut6eO07vV1O
         a/+26YmFpK9j65DZKfTF7UW5L9GOfnWVrQMUZQQzoQ6FNn9ENXqYAtjz6Ig+3q7opinf
         eXquHoDhsSNeivfs/+c8qVVP37hhihhYFN/P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726656975; x=1727261775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p41HDdPJ9Xqsou/GrXV93VQCKVWaaOB67+1yPY3lbP0=;
        b=gYAArWUjr5fGHadUU3b69BQsIoJIw8RL7I/9k9gv5TAhE1GYil1H9Q8PN7cMqt4CY5
         l7ZKAnnhAxsfsornlgSMRMr0cMz7SoUy+TOlmjhLI+8WGip0aEWfyhf6x+C88iKn7Yzt
         kpBBuZ1PMh3dSatsjC8JXdO4MRykiuYjS/QAnhA9ZeK/rgJPPTwtMjMIGAbmYB3/eXNR
         EOacJqvFHSj9RqjeHNDkT+uMavC3kvfCYhDadR9YNaEIrVycXV4ilphvofXyjf28U96F
         zzymjjY9v8fWGJYUV15uoz2Gw1W2YFioqEpeB5Fp4+QN7NXyL6wTc2WJ3Lh/gUSYevXG
         o82A==
X-Forwarded-Encrypted: i=1; AJvYcCXnqA0uuV9OkpjyOQjx8iLsBrFrH8qH3YDPBGxf8cbIqJtZZUizbrdAafmF8zcDDVJ/FQsvMNpITdBaxak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8LfpaHpBs2t46KAqNPgWc0XevYoO6BJLMfS+KpHVIrP3u9UW
	MOu3On9xJA5QFZHxkxt78/Ed5u4cO6gatDVgsidegr6fJj7e9aB7Xe28rQ8LLg==
X-Google-Smtp-Source: AGHT+IFhMb15QzWlbO320Kzkgs8u2zWlJt0MSXq3KFswpzmoxO8x4jWlVrgugevSX5yLlMwZDNzRXw==
X-Received: by 2002:a05:6a00:1906:b0:70d:2621:5808 with SMTP id d2e1a72fcca58-7192607fcb9mr33427847b3a.9.1726656974863;
        Wed, 18 Sep 2024 03:56:14 -0700 (PDT)
Received: from [192.168.0.103] ([103.163.98.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b754sm6505848b3a.105.2024.09.18.03.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 03:56:14 -0700 (PDT)
Message-ID: <110f6583-f76d-4c7c-bd77-cdeb21b78704@chromium.org>
Date: Wed, 18 Sep 2024 16:26:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: mediatek: dpi: Add power domain for
 MT8195 DP_INTF
To: Rob Herring <robh@kernel.org>
Cc: chunkuang.hu@kernel.org, krzk+dt@kernel.org, ck.hu@mediatek.com,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel test robot <lkp@intel.com>
References: <20240911071722.558960-1-rohiagar@chromium.org>
 <20240916171107.GA605353-robh@kernel.org>
Content-Language: en-US
From: Rohit Agarwal <rohiagar@chromium.org>
In-Reply-To: <20240916171107.GA605353-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 16/09/24 10:41 PM, Rob Herring wrote:
> On Wed, Sep 11, 2024 at 07:17:21AM +0000, Rohit Agarwal wrote:
>> Add power domain binding for MT8195 DP_INTF that resolves the following
>> error and many more similar ones:
>>
>> arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: dp-intf@1c113000:
>> power-domains: False schema does not allow [[55, 18]]
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202409102119.AYvaTjUi-lkp@intel.com/
> Fixes?
Will add in the next version.
>
>> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
>> ---
>>   .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> index 3a82aec9021c..07acc8a76bfc 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> @@ -89,6 +89,7 @@ allOf:
>>                   - mediatek,mt6795-dpi
>>                   - mediatek,mt8173-dpi
>>                   - mediatek,mt8186-dpi
>> +                - mediatek,mt8195-dp-intf
> mt8183 is also missing. There's a patch[1] to fix it, but it's wrong
> given the recent changes. It would be best to fix both in one
> patch/series as 2 separate patches will have conflicts.
>
> Rob
>
>
> [1] https://lore.kernel.org/all/20240912144430.3161717-2-treapking@chromium.org/

Ok, Sure will have a new (separate) patch added here to include the 
compatible strings. Thanks for pointing out.

Thanks,
Rohit.



