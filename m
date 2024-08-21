Return-Path: <linux-kernel+bounces-295233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7009598E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FEF284155
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973DB1F3774;
	Wed, 21 Aug 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/MFktln"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED01F3742
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232758; cv=none; b=f+7qzT5qCqSmCX4QrCdB6MBkO+GhYwX+zhNKiZC00hgRRujNzhnG4uL7bfjFt740GivqhyBzaxIFh4PK+Ztz8sS6xrykzBRSyi40h2muZ5ZNQ6cT3BjMbvLFkJs1ywS0XRTL32NVKVdly8xxyfZs8504d+yFWjYpmFtaX2z3h4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232758; c=relaxed/simple;
	bh=m4FbkAx7v5EUwGK5Pg47fSnJDHHw9WPN5bt92a1OXbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKMyqaC8P3FlBUGaE9WPgUnyTrTGVMnu4Z6sDF/8wJvcZu9MUkOFqm5fn5kWDC69Q+E9p3WmbKhMTbop4QwfMa6JVp2fAygm7/SXojGl5+yK0tcTWq2dLVCc1tr3sH+o+Y+IibFpdPJQ/jwBYrLrdj1fLjHd0hTesfY0LQblgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X/MFktln; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37186c2278bso317730f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724232755; x=1724837555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtW0leC2Dw32/lkesLtRzDO2WQQOzasED8SlJGa2yWo=;
        b=X/MFktlnPU530vpkW+DKmYtxZnB1NN8O83cn82uJ4PVAf7kc4OD4m3lHsvYd8Nbsis
         jNFjExt8aCDJ/xw3LulSl9fyb3bnwCsxq8aTjNNZSyBvf00sVCrXbgNBePDupAL0INQB
         T/9ZeMUHxIdNnh4UcFMQ2L2/qlgBdchXCQK11hGx0JRLCx7h93FmclJVLD83WHQqWxbu
         6GqsqromsYCF9lL//HW7hXk2FlfXyT97Pu4LHyI8bAGdprlRhVZPygpptLb9/LltKqOE
         Fl1/Sn808nhJu2TcY5KagXUO62C1NW7HenvTutjcRkR2s7epcamGGR7YYa6pcBe4/Lxa
         AKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232755; x=1724837555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtW0leC2Dw32/lkesLtRzDO2WQQOzasED8SlJGa2yWo=;
        b=FXDTiLPLHH+M9qd2GUU+J345CDvfgwYPVLPqqLTVCnV8h1+3d65zFRpn3ao8FOsYJM
         lVTaMK/oG9H3CS0bQxgqOzOUzp4iEVF6dSlLJH4pctOH7cf1iIjC8XK/jAG/IPouC9IE
         rfdOlR64btBhMmQURsMbIF0KAItgd22rLZpRNg++ztKc7VuQvzuvR/JPy22Zenw6KEy9
         rtEErMfiGjVA/A4tNdNaKzrOhWA9WqWCnKkPFfS8PETDjgvuKCuKqZ0SJWCgIMRhjMxI
         ZumaIdyS3BVLAhOFjZ22+4IX70RwP6dIHaKmU0DLIX0XQhIySfuYtkEHFQgyupZwH8Ma
         kQ+A==
X-Gm-Message-State: AOJu0Yxg2scE88P6TCPItKuW9YBWZm1RyswqeXrdUFtJLiG9BOymzFeF
	r+wfOXARIHiZD4MlnOG/PLM0ypva+3wDtONi0gZStbVCzXm0fFQ5atZ+r1stLNo=
X-Google-Smtp-Source: AGHT+IHRIrFfky0Sc1rurltGhfdewiFAC0lajLizHyBq/KheWqYA21VK4dur3rH3z+H8eRRkUFoaeg==
X-Received: by 2002:adf:a344:0:b0:366:ea4a:17ec with SMTP id ffacd0b85a97d-372fdd840demr823919f8f.2.1724232755022;
        Wed, 21 Aug 2024 02:32:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abef97f7asm18744355e9.22.2024.08.21.02.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:32:34 -0700 (PDT)
Message-ID: <c01ed2d7-964d-4b75-9a8e-8325d4cc9269@linaro.org>
Date: Wed, 21 Aug 2024 11:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] thermal: core: Drop redundant thermal instance
 checks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <10527734.nUPlyArG6x@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <10527734.nUPlyArG6x@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 17:52, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because the trip and cdev pointers are sufficient to identify a thermal
> instance holding them unambiguously, drop the additional thermal zone
> checks from two loops walking the list of thermal instances in a
> thermal zone.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I'm wondering if the thermal_instance 'tz' field could be removed too ?

> ---
> 
> v1 -> v3: No changes
> 
> ---
>   drivers/thermal/thermal_core.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -850,7 +850,7 @@ int thermal_bind_cdev_to_trip(struct the
>   	mutex_lock(&tz->lock);
>   	mutex_lock(&cdev->lock);
>   	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> -		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
> +		if (pos->trip == trip && pos->cdev == cdev) {
>   			result = -EEXIST;
>   			break;
>   		}
> @@ -915,7 +915,7 @@ int thermal_unbind_cdev_from_trip(struct
>   	mutex_lock(&tz->lock);
>   	mutex_lock(&cdev->lock);
>   	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
> -		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
> +		if (pos->trip == trip && pos->cdev == cdev) {
>   			list_del(&pos->tz_node);
>   			list_del(&pos->cdev_node);
>   
> 
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

