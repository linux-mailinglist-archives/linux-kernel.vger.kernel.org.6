Return-Path: <linux-kernel+bounces-208232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E799022A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4B41F23902
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35305824B3;
	Mon, 10 Jun 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZOmxgHm"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B648248B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026039; cv=none; b=E+I71BH9zSqf8arpKi8XPMHPJimNFYyxKJwDT4kZTkTC4L9IR3+9II1WHIKbX0kE83TEH1b/N3c1cYL8o0xGH0UP0qxV5PEnqK16N76MSIUe0abKB57wK20pTnYtozmP3kX7bNUR7LLh7dghDWwqL8l/ANefGyfRT+Y6XQ2jjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026039; c=relaxed/simple;
	bh=tP4cMxiktUOhqc/zUuS5OIvwc0xqblZZPOTX4zoLGuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfI3HRVkFLpRTC6WBOM+stP+CSP0W0hE5mIjlyl4VQ7+yUewPkZCvKEKcz64JHpzL/lFW/RhGFH3atP4IY6/mXjzZTft0s60q6expDR6A3ma0sXUl3fSnu5i6WtGsp439M3hsoHbG9MSxhRJn3viLeRHervemHMpshHI5n2BPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tZOmxgHm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421757d217aso24615685e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718026036; x=1718630836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+zykISSn9jNpLz4ChBVpl9zCS8hteHdbqsrW3djfz4=;
        b=tZOmxgHmf4anXdBjkT8YKRH35lYOtxDzP2eTYxpkSqDAO94lccaVRqp+SWhPyYQG+t
         Nhl6c/V68nL3GZswSW4jP3spPu5jOooBJoJyqDXvcT8CI0WIx0uuvdZeZkF3ENhPe3oJ
         RaGkoDjwOQ5D5fFn+8PHrYGjvdNppiyyVntoIL1NX4R50eDhaee1JUDMZvq5uYU7Q0X8
         XzE4mx9rNKMuPSXfVVpGBo10FEiHnyN0gOoKH1oFp4NLXRAqgCM1LUj3L1ms2BNoB8m/
         1gkeip0Lduen1EsyzOusIaqEBAI2yqhB7JSiKAw89HsJzXppxIPZRxwl6EIEVBSWMFJE
         HzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718026036; x=1718630836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+zykISSn9jNpLz4ChBVpl9zCS8hteHdbqsrW3djfz4=;
        b=v6/gmSiKzQentAJ8RNpSHJsBb67kVD2P1o8UbfmvFxQfWaeLMz3YYBeot2r8jGvP40
         uEWV2eODgxbQRAiJFCO8zmq6BL2DD2OT3i+iDcG51eoDDcaQPHIfc5jFxrg9TYk8ZEwa
         Rn6h9vnNmDlSDww8M6pe3LzqOmwy009+SWjWVAfFogTloHYBtjmWgP1SXAsXMkg64oBH
         yqBmbPuvv6N3bMqNgaQ4hQJCADTwjYmLfP38n0fSOXBNTnzNCTMTSgbi/SKUAUl1r0L7
         PqtTMjx6GoZZG7cgk9xpj7OrK1U2MCfutVMOt2VOLcI+VM4kdWn/3bZtn9L6dlVELQnc
         q/dA==
X-Gm-Message-State: AOJu0YzM+HVGLV0ltIZgLpM1679D6Gs44yhR3TrQEMpuACspPI2Qz8iv
	HxzPu7pDT7fB8595CjwRRNVG/L8zL8eVQ9hZzttlgzixA8aKR5R6dGA5Ln0sgyQ=
X-Google-Smtp-Source: AGHT+IGcDbFcsNiE9xkJCyhwDgjAPzRcCOM+Tlhvr/7Wgc6AOdwO/N/aHTEyDeDhDZ1AReJuvCtrsQ==
X-Received: by 2002:a05:6000:1f84:b0:35f:204c:889f with SMTP id ffacd0b85a97d-35f204c8bb5mr3672297f8f.56.1718026036220;
        Mon, 10 Jun 2024 06:27:16 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35f231d5761sm3203497f8f.35.2024.06.10.06.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:27:15 -0700 (PDT)
Message-ID: <d497da6f-adc4-4141-87bf-5b3e2fc0e926@linaro.org>
Date: Mon, 10 Jun 2024 15:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] thermal/debugfs: Move some statements from under
 thermal_dbg->lock
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <22311651.EfDdHjke4D@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <22311651.EfDdHjke4D@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 16:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The tz_dbg local variable assignments in thermal_debug_tz_trip_up(),
> thermal_debug_tz_trip_down(), and thermal_debug_update_trip_stats()
> need not be carried out under thermal_dbg->lock, 

May be explain why ?

> so move them from
> under that lock (to avoid possible future confusion).
> 
> While at it, reorder local variable definitions in
> thermal_debug_tz_trip_up() for more clarity.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


