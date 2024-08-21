Return-Path: <linux-kernel+bounces-295084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2641F959671
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33ED0B23889
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3101ACDF7;
	Wed, 21 Aug 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsuvvHzz"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65891C4EFC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227029; cv=none; b=Ig2YfFXgwZ50UdFNV7Y8fmR7GvgXgyBLlKcw2keD/vWSKQR4091IN/o//2R6N3P+IcHjJBvew5Q9+aBl4cqkoZbKrd0VR6+gsjRRZXuNhwjSOBx8fQFutI4Lc/CRRspt6k8Rf29I1ivWY/OwqdeOh86s64SuS/btfCNr0AsyLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227029; c=relaxed/simple;
	bh=I+Sk7rzN6bKZfOhoWqfhZTQXFrwxODAV7Zj+f+VxKuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCRySCgDIegs1M4g9nLur7UPWYfUJQBwmA4xnd2n31pXfds5Rmo+FuIFavmHrqEqu/UURDagQuVfL26l0lxFnE7GU6rxqj0w629hwQIXYPEOzZz9R2CCIix2wJihmWT3klaXUEUKHCVMmGFlsHHHYNHHKI7XrDR7+lnMyiEHqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NsuvvHzz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428fb103724so2500355e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724227025; x=1724831825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hHhuCWz2yguQ8Cont7KNQfFc4rp2L7+lsdkVawErtQ=;
        b=NsuvvHzznKv3/M/nmDNznOLH3C+NKUbBFZdRB+8PVqgcKYbBnYZ/I4k68mom+X/iDx
         1F4okAqe+MkJ1ooFPBLU08jKq2j9GTzhvwUGQhpqLs/AD06iXdUTTenjY7XwXFpmmrfG
         lxhge4wmgTkYIJu5/lkho0X0qezOMcw/smH2Xi1WyTTfT9kqvKUnE6drsoOZy+U8kiVD
         9YxFLJsk4MtdGkZ5leizggmOaWIUEzS/f35Zrvko+hpkiDGpX3goir5SENUHZkMYI15V
         YCowJpRbE2beNgVT/fR0QJaVg4VeYLbgdzhwcV8idbk6zDQHOs17felj5Mp1EIzh0jz9
         iovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724227025; x=1724831825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hHhuCWz2yguQ8Cont7KNQfFc4rp2L7+lsdkVawErtQ=;
        b=RLJPWYXJzeHKmbAfmtwyf6lnuHXrxUA5GUiIpWse2dtM2BHkfYjaJsyxa9vTmS/iLx
         gd3ErlGu3QhL+s0tJhZ3QYP55lCtwtCKao4ka+d3astge+qs1y92lWnA/FSd/v4SNdiR
         wfcOjg2eXPXjPymhhqWau3ONb0N1CMO1tIB1+hZPR080h7cD6ud/JRsVp4mqSMAjrcS1
         uFyf9uxDNMBIYoYOKSBtI7QzH+zrfQw01/fjJ7aH+mw46hbMx3Gd1+c1Ny9fDKCGkpU/
         p9NlNjGuVlwNJl9j3c8cnp7k4vpSlpHM0PFlB2ZwXZmvbSboWfJypFTSRYFzl0qsl08g
         sccg==
X-Gm-Message-State: AOJu0YyrPh5/K79Lz+6gVbbN3jHx2zvgok6GFpNkEDsVfdvC2PKt9obN
	Nci/8EQYKraMOgKQd/jzKwyNqkn9iRLUUzEK1jXebQ+bHoSurxlwpw5BBBs+0+R3u+SZnXSdbVk
	M
X-Google-Smtp-Source: AGHT+IEyvnU1ZsLtBik2T1MKLIyDtzHAUvyEpY5Q5iToTp/S21Ph4wAq81S0hl+3j/S/baOB2ggvbg==
X-Received: by 2002:adf:e748:0:b0:367:8e52:3bb9 with SMTP id ffacd0b85a97d-372fde0fd4fmr658417f8f.22.1724227024479;
        Wed, 21 Aug 2024 00:57:04 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37195650163sm12963684f8f.98.2024.08.21.00.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 00:57:04 -0700 (PDT)
Message-ID: <6d7cce54-f22d-4810-b13d-68061eaea5b4@linaro.org>
Date: Wed, 21 Aug 2024 09:57:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] thermal: core: Fold two functions into their
 respective callers
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <2962184.e9J7NaK4W3@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2962184.e9J7NaK4W3@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 17:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fold bind_cdev() into __thermal_cooling_device_register() and bind_tz()
> into thermal_zone_device_register_with_trips() to reduce code bloat and
> make it somewhat easier to follow the code flow.

I don't fully agree with the description but anyway I understand it will 
be more relevant with the next changes

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

