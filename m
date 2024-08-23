Return-Path: <linux-kernel+bounces-298375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C939895C668
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25949B25600
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078C12C484;
	Fri, 23 Aug 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHqMEpQv"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0E1F94D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397467; cv=none; b=Vbf6AEqQSHnKLxMpWBGqU+xjSUr+20XJehk0lpxxo5p0BidESI3rHFe6aG/pFGDTNSeIWIL5WeiiAMe1xsHivIJdYoOnQ74s4jsBtqEOz0+JW3lyARQRtIGx+qRLl98Sa09TZqlkeP/W+PNX3sbMf8N0z2C0nfmlBVAOI7q7tWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397467; c=relaxed/simple;
	bh=LJ0KJvMFyuvw8bV7vipXkuvUrD+xaAKMYI3SnUDG7GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eqn0tzioT1yrqR8DvimLd3rvn4uqmmxlBSDSoiWiMccB8KngDFpTeUo+KasGW7XalGSiJ0qxjn+km/rIcs1ODZmsQHo6m2RbW4we41nZ/ItW4gbP8eUBJNak7eozTrw2/kPgHIk55bBDTIdCSgZ1jTxETegn9ZkcXRhUXVOUx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FHqMEpQv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428243f928cso12541075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724397464; x=1725002264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZVKzUZkaZNCPxzRfFzdPnaeJ1DHoiKq0SGUFi/n2eQ=;
        b=FHqMEpQvHHu2UqoNUWcPKyhVmjcrkZjLOKKqYQiikSdKLpSWFPLj8HzBj+ahMJdvlV
         GxuxUoWfn15+wFWrq6HN9SBCdBCi9L8tPEO5KBaKH8KRqYY6/MOyRZoZiFxVG8JV8R4w
         BHjmKRvF+OEgEkOltOIoxyuFQmUNPd97WHz/Hb27JyATapSE2eZRWbNAXaJq5zwZddf2
         Exp9AvYElqjo2i/vyta9hoRuDVbXZbn2bjVGKw6X0iElfkg79sq54NXDO+smeZ5WJdyo
         FXPbidL2L8Z4yH4rrC3E83Q/QZWmiwROD9zh09c3j+cx8i/ow0OndkS7jmbdIhLkWzPT
         1mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724397464; x=1725002264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZVKzUZkaZNCPxzRfFzdPnaeJ1DHoiKq0SGUFi/n2eQ=;
        b=Rtg1jHcGvl69Tp56ovcEJ+H5QjrPje0zCxGQB4K505ZEtKlRsfr7oB16fPPMQ6Hzmt
         xGQ/ffIBLhDiX2mtBroHQlqHsCbsf0OO93sWhz+JoSyg5TfqmMKKZa+7oC5EJd6o5JSP
         GAlw/PrUZljH6X2LyHr/57qKX3ifo+TsGkxqKkkMtCWMWd0Jw6VQfQ15l7c7m+6aydsY
         T/LYD/E0EBBktNf/uwWTG0kOrXmeguiudxG8a19rN+Ls974apGKsRpFe5tVigvjQjsPn
         uKHNEG9zR/omda2ngpfbq9kHiT+rhfCoXKgTOIs1yeHv/A3fK7RqE8aVzLao9Qty+p3Z
         Hu/A==
X-Gm-Message-State: AOJu0YyE7BUHDcyEJjVRHpS949YOn7tO6MlNSbLi4CF5w4BrJNjGnxBI
	gIeG/jM9JGWTD6am0DftlSmWqRUE8AR3NgWDvo9Ja9IfOPXppGiOxxrg1WSpePY=
X-Google-Smtp-Source: AGHT+IFiJTaKGwfcLGJNOi9ZNAmc7yJAixc9OfrYq8lKMC0x6ZszpF9QXeEbB0rdWls6DHaRpnd5Yw==
X-Received: by 2002:a05:6000:142:b0:367:f281:260e with SMTP id ffacd0b85a97d-373118878demr844589f8f.3.1724397463770;
        Fri, 23 Aug 2024 00:17:43 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3730826196bsm3439871f8f.102.2024.08.23.00.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 00:17:43 -0700 (PDT)
Message-ID: <9a90bbe1-bf05-44a7-8e7b-4ff5d968056d@linaro.org>
Date: Fri, 23 Aug 2024 09:17:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] thermal: core: Drop tz field from struct
 thermal_instance
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>, Huisong Li <lihuisong@huawei.com>
References: <12516814.O9o76ZdvQC@rjwysocki.net>
 <4934182.GXAFRqVoOG@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4934182.GXAFRqVoOG@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 21:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent changes, it is only used for printing a debug message
> in __thermal_cdev_update() which arguably is not worth preserving.
> 
> Drop it along with the dev_dbg() statement using it.
> 
> Link: https://lore.kernel.org/linux-pm/4a8d8f5a-122d-4c26-b8d6-76a65e42216b@linaro.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

