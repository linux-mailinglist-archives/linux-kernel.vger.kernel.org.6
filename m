Return-Path: <linux-kernel+bounces-295657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09E9959FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F401D1C22532
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7121B1D74;
	Wed, 21 Aug 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyGZ335i"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D691B1D5A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250274; cv=none; b=BGl6/wfm5cEiHfVV4D39fPROLHGK6GovIYxSylyywn3AlvTVot3hmkK7mmFvHRRhfq2c6ATnmAL3A+pkXL/FjX/Z3WdJxiaA1zs+E3Dz8bhYcWoPThDaOcMh/+ebmVYTTCbki/Rxqku133fMwv3UVbUQxktFfVV+xz2lhiXP9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250274; c=relaxed/simple;
	bh=ib15mE7gR3AV6rGoFlk5p0Mq36ez/RjRdvH1o/oeTng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeMTee0DXK4XEIUPIZDdIobwPm3rP2pLn095TjTuoJcwtf1b0HesgijSvGt4H4wMI9bQCdjUpGVnQv4eeBYTiSoTjnMq3xsTCymamBxkhGdIU4wJVTQ6juGmEEkykbSM7UqOV2w9cIh5o/tJbGlh6k+Ew4J/OgpAeeQJmXdAbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NyGZ335i; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428243f928cso54788645e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724250271; x=1724855071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xc8CEKkOslOtSRX1dxAXhq5rMzqfmxuGPTRl5HrpY4o=;
        b=NyGZ335iJ12qKO/OrGSVux9FIT5v5BtyVS1NKyOCgq3i1CmbK1GGI5W8Fijhnz38UB
         iYJI64wp/ZU4snId0epuMPmyLrus8yVOVQSdPVSLbwr/Ej2dZfM5SfdRBAdBgk2vZPQ+
         F1+0Q6FG5Z4IE/WScQx6i1uNzx5vrWanfZ7thQDcwA5WvbxZkW4md5757tRtCDUgGg5w
         Ui5fGs9glPLDvSteWmA1UMMI2U5aYz/krsw05FFkcoC4uSbypORjaidcqdWrwVFuDLIb
         expa1lZUJR8Zdrly0D4Mn2qOyx+nUTT0NHfz2q5lpt6uKxx1oNFFj9bThzUvEpzce5Rk
         LEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250271; x=1724855071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc8CEKkOslOtSRX1dxAXhq5rMzqfmxuGPTRl5HrpY4o=;
        b=xVDPil3mmXoTqpuMNMRj/tpnsQ3HoBygkiKoLMwJAHRqi99fYJE58b1m6p3X5b7IEl
         9dmZUhJNMMGCUGYV4IWI0SGjj3HYW/teYTVwhZQH6M1IipdCfLK90nMFxba2y48flfhR
         1L+EwPpas+a76zn9mhSaFuFMYKyg8Z/U63iwskEtg6emNHUTO+dKT3WGasu7NOR9JayJ
         3iglDeKASAPhJfccxXl4A7z6MkcVE3oG4iFexNr7qFhorpFk76+Oh2mnmFwHVkgUbQRF
         f3tHYxqQrsG656c4xNuIPSe4sgF+L9tcWanXB+7ra/6K+VzWn1sQ1fnjVHf1o0jh2dVJ
         3NAg==
X-Gm-Message-State: AOJu0Yyd9VY20Z+n3D/ghaEVg6gdTiZpYQQdnLjuMBkRlAgWn0wKAyvc
	PcSXHxAoYMyNMUqv2AAZSCqeSpm5c+DSrVQtODKd/aNp0XH+ALe9/pzgn7Lu1Awn5LuVpk8jOEK
	+
X-Google-Smtp-Source: AGHT+IFRd55aV2LWhmp5zJNxxzHywSRe67KTtuQrwfGag/ObyJFmysOTVA4uabICwmAheuRJvqpJ8Q==
X-Received: by 2002:a05:600c:1f86:b0:426:6416:aa73 with SMTP id 5b1f17b1804b1-42abf0580efmr18455595e9.12.1724250271096;
        Wed, 21 Aug 2024 07:24:31 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-371898aabe9sm15860757f8f.92.2024.08.21.07.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 07:24:30 -0700 (PDT)
Message-ID: <71eaf5b1-8305-421e-ae2a-f4b9ac748dc6@linaro.org>
Date: Wed, 21 Aug 2024 16:24:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] thermal: core: Drop unused bind/unbind functions
 and callbacks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <4251116.1IzOArtZ34@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4251116.1IzOArtZ34@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are no more callers of thermal_zone_bind_cooling_device() and
> thermal_zone_unbind_cooling_device(), so drop them along with all of
> the corresponding headers, code and documentation.
> 
> Moreover, because the .bind() and .unbind() thermal zone callbacks would
> only be used when the above functions, respectively, were called, drop
> them as well along with all of the code related to them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

