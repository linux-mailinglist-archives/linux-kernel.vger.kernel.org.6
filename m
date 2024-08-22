Return-Path: <linux-kernel+bounces-297610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6897195BB69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5C21F2418B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791821CCED5;
	Thu, 22 Aug 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wC/2Iep0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86F1CB300
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343044; cv=none; b=bqARGA6dPiXU57/mwPSrL0VJbmGuRbvspOez5pia6wllvDlqfESpz0iR8hPd6LzibbzMqtgqmbzF8xYACMXC74H8O6EAgSICFMCjRQz67YTnR+I8x7R27cvoTDOuCovxgro8Tz7LFGuDa5+FhqsloCfVKSPE3Y5BWiXfkbqid/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343044; c=relaxed/simple;
	bh=oTVnwnxoi3MwR+fT4MSoMLg39Y4GQfy4UfuGydIln/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpzZuBWodiG/X6gBgTZUKUy6sq6QPb7fSiWvBc8jpSO1mklu/dTgiXGD/BePbfuX87MXkKWbvjWGfPhLrhezlZCXaVZwyZV+xx502yzFQppULMXbTvv9grrcsFcoF7riYCIk3o0Ou/ZFIh6x+mtB4lXdqDEagGUicsTTVKg4AbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wC/2Iep0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428119da952so7732815e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724343042; x=1724947842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghU7bGQfCH6VMs7XeQb7I+ZFRK+m6U/I472i0hWudlY=;
        b=wC/2Iep0M0IEKgTPpYzAOntqPZRcTH8+Crcnc5mpjAoy7eiT1E7gjvhZBTadltxUG2
         UoaICx2j2/wK3ubd0Quv+fJXDdxWDne2xXocjwTWmQZ3GdNvYNqm5SiEbleZtVnSaeAN
         LBS5zkznBnRRMjiwmDC6SiYdxbAuP1hqf6XYjt+3z+nX6f9J8ka2xHP3VjkCUq74liva
         imjIg7ARB3OBSxl0egIeyXIi4pg+u9rPGu1TVuoF61Vj/0SRHiOurZD9Fet1CUxNY6Vp
         nwboLI2MCMsm0TNuFBN6g4tvR+nDtB1nENMmkqSGIl3NZct1DJU5pXrQKr9E+2AhxqZ9
         jxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724343042; x=1724947842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghU7bGQfCH6VMs7XeQb7I+ZFRK+m6U/I472i0hWudlY=;
        b=sS20ZSThK+2u33HoQkzDHUrVR1LG0jLkxWsQ0/IhxDmxXOtpL7vzWOrbcCafgySbAg
         vxx5azpP58EgnOaO/yh6gpfIQOFUsaY4mPK3f5Ts6VXM2l/GNKQaCnTxVcftdVNLh9aL
         WGfbxUfaVN/XACQ7vFiiA8A0hd10ymKYBUYp+QEt7PsNb4gxvnpvzlt+TzuHfIVEyqBC
         j6N9Y56p5S+G0LLposb7GRvnnF6QIaE0hxixYpYWoKs4g0ePdhoM8Xp0YuAAT1cRTHCS
         2PDb5iO+ryB/1cD+a24608b38mvPj620n0G9S6US8+rMZU2id7dIOKcSqNUXggOF+V93
         2BQg==
X-Forwarded-Encrypted: i=1; AJvYcCXvtYtamkHgV+x5fl3MkSBn1pnTAWI26zcK7h2lhgX0P2CDxfIisbQEsAV2wjatAJv9Ww03agKOodC6F2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmm0T/j4uRTIRPkavnI86J770H0Fct/x9eqojofmLaoF31VIt
	2Gqy4MtpqfsAT4jCgdjM3TpNtOneyj0pzljiPk0uEWF2mmpFedd9K48xqqUhRu8=
X-Google-Smtp-Source: AGHT+IFbeUlcYW7rVjFtPeB/keXD1uOdpULEogsJaEXgMJoh81iXZzt7Lg0xKqgNI513crPHQS93Ng==
X-Received: by 2002:a05:600c:c8d:b0:427:d72a:6c26 with SMTP id 5b1f17b1804b1-42abf048b3dmr42289485e9.6.1724343041166;
        Thu, 22 Aug 2024 09:10:41 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ac500e119sm29671935e9.0.2024.08.22.09.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:10:40 -0700 (PDT)
Message-ID: <133ea087-a5e9-48ca-bb89-33f41220276f@linaro.org>
Date: Thu, 22 Aug 2024 18:10:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] thermal: of: Fix OF node leak in
 thermal_of_zone_register()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <20240814195823.437597-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240814195823.437597-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
> thermal_of_zone_register() calls of_thermal_zone_find() which will
> iterate over OF nodes with for_each_available_child_of_node() to find
> matching thermal zone node.  When it finds such, it exits the loop and
> returns the node.  Prematurely ending for_each_available_child_of_node()
> loops requires dropping OF node reference, thus success of
> of_thermal_zone_find() means that caller must drop the reference.
> 
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

