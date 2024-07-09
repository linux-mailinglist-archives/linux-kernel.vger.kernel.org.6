Return-Path: <linux-kernel+bounces-246240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6C92BF7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACE71C235CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B3619D8B2;
	Tue,  9 Jul 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRpjf3zB"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55BB19CD11
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541745; cv=none; b=MX8MikDMPcEKR+t3p92JnTDgIqe/YXOAAlDAJ5dumdriUwB/NAKO2LZwK2kSo+A2NfA0ZLfkGXtAEXZRdykmfSmXOUk1GcyPZUbsJlwDAJGAhDp+2yfIoLceXjOE4EqTxxFjXshSth95aVYyUVO7mYo7n2Q0eK6qMLMjcS28pQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541745; c=relaxed/simple;
	bh=5l36OQ1K9hQ2dxHxeGd44oq8T9kdsyNePCBNzm9ieAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3z33SpivI8361GPEaBRpyLuX9ZCx6xYDu6CDruDGtb5mf3RrpZnarikofL+euSwMUG//MDxsJlWspCXFTuTUtEdg+sMhs2KfIu1r+03wE37sqrgaSFwXyPqsTosk06JCwjqnXKSzwPH3B1DjIeBXrF2Klr4UtTXR+8tFF/HYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KRpjf3zB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so56458551fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720541742; x=1721146542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mmzHYcsrbq/WzadmZBrEv0IGke8Kg4qTQXnrPrl/hk=;
        b=KRpjf3zB06xOiQkWdB2GssiO9R8aNaO5aLEF8CjNsGC5P8rusKCgR6GeF+mE0UVU6W
         A09WBETGQ62X2gPm3ceXH4oHPoBiiV2PviQIKqLvB0HeTvcHwrzbGR560hmiHKTBq/Sg
         8v3CZ64U89PorhqrB7JsU5zIWgijnQo9acNDbKfSoo2MR26J2Jny8WMbR8guBWaATYcB
         JDP8kVttR2GHDBKNrsK4lcRm+YHDbJ/7d14DzpfYK/OWwvPkWeEnd9teJSbUaVQOPCXL
         ZJNvpu1/3AlLoIp3GKH44dC3ZW+veSEdxeOBQ5laWDvksn7r+jXegf0Nxig38jU6h+5a
         B1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720541742; x=1721146542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mmzHYcsrbq/WzadmZBrEv0IGke8Kg4qTQXnrPrl/hk=;
        b=NqUs7DTNNh2BEzrsyj9+cbI+aLusWXxLcjHGtYaTFXYFY6k1livs6MJ+HzIh5jVgFX
         w9eqZMMoTNxTPTAT7zVDvOHSeDb/u5ofBS3q9dz8YWh0p/kbmDjAR50YeOdVsiH0q+kS
         6nRadZEQPlbMq4UhgeOIJ0rbagut3T7gV4ydjp2swhlg8DC8JzftglYy5NFM6Q+bFcNq
         nzFfthy7beh/UTy+OD/7LT+f7Wam+4MHRrwQswXkR7TLMOAOY1rTg3QOcSljmeXQ8N5X
         s9ODjrkftrjYsJ9nZ5hzfMoL5FD8zz0Uh4kMlGbur/cPYABn6VUZX7aFCBLjHHTVkmO6
         kq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCULcygt+r6B4CFdVZbVtMrscCbrDVqEQyiVdXv+CYGtPYUdzuSehC5UpCH1gWxWiaOI3lQ+vIZ8qdIEAB1ziQ10DkpOKFr6gUzGIDQr
X-Gm-Message-State: AOJu0Yzi95Dl+HEZHHsk1DgF3HoTIi3Dg+xM7PSHt4D35w8QJfEM30+r
	hUPZXjH5k0Ocbe2Lf5/ZQEhhlRPnSaP7WRh4Q62lFQaviE8jH56v9QSAcaeIgS0=
X-Google-Smtp-Source: AGHT+IEzXFlniImG/MtXKk3DCbQfzXjVjTAPnBQm4R1NlkNg4Akwf+zffKFhwFSImt1CnEXQreVDBQ==
X-Received: by 2002:a2e:a415:0:b0:2ee:8ce9:3075 with SMTP id 38308e7fff4ca-2eeb3197a5fmr18174151fa.49.1720541742014;
        Tue, 09 Jul 2024 09:15:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6932:abde:fac8:217d? ([2a05:6e02:1041:c10:6932:abde:fac8:217d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-367cde891cesm2972937f8f.62.2024.07.09.09.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 09:15:41 -0700 (PDT)
Message-ID: <11c5de84-21f0-45de-81e0-dc765a391123@linaro.org>
Date: Tue, 9 Jul 2024 18:15:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: sp804: Make user selectable
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 David Abdurachmanov <david.abdurachmanov@gmail.com>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ross Burton <ross.burton@arm.com>
References: <20240529-arm64-vexpress-sp804-v2-1-c542a80af33a@kernel.org>
 <2b946a68-dcdd-4a1e-b7c3-416725033c2e@linaro.org>
 <ddfc867d-2431-44d2-9753-b577e8f5ddea@sirena.org.uk>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ddfc867d-2431-44d2-9753-b577e8f5ddea@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/07/2024 19:44, Mark Brown wrote:
> On Mon, Jul 08, 2024 at 06:49:38PM +0200, Daniel Lezcano wrote:
>> On 29/05/2024 21:48, Mark Brown wrote:
> 
>>> The sp804 is currently only user selectable if COMPILE_TEST, this was
>>> done by commit dfc82faad725 ("clocksource/drivers/sp804: Add
>>> COMPILE_TEST to CONFIG_ARM_TIMER_SP804") in order to avoid it being
>>> spuriously offered on platforms that won't have the hardware since it's
>>> generally only seen on Arm based platforms.  This config is overly
>>> restrictive, while platforms that rely on the SP804 do select it in
>>> their Kconfig there are others such as the Arm fast models which have a
>>> SP804 available but currently unused by Linux.  Relax the dependency to
>>> allow it to be user selectable on arm and arm64 to avoid surprises and
>>> in case someone comes up with a use for extra timer hardware.
> 
>> Would it make sense to add the option in the platform so it selects the
>> timer ?
> 
> As the commit log says far as I'm aware all the platforms that rely on
> the sp804 timer already select it (they wouldn't otherwise be able to
> work unless COMPILE_TEST was enabled).  The Arm models and possibly
> other platforms have the sp804 but it will currently be ignored by Linux
> and the architected timers used instead so it would be wasteful to force
> it on for them.

The policy of the Kconfig is we should keep the option silent.

My suggestion was to provide the option in the platforms Kconfig and 
[un]select the ARM_TIMER_SP804 from there


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


