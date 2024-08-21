Return-Path: <linux-kernel+bounces-295581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD5959E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F57B2418D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD238199955;
	Wed, 21 Aug 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfrDonly"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79FC15C147
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246556; cv=none; b=E3bnQlHCkSt6xig6OEjvPdsvmmYq8WO6zDhoZEEtk/+75oZQvMiGr0yKLgIgY+9dDSjhi/7h4M8DwntWHF7OnmthEaiQAz3Y9/ilDrLrOn7CCfygB+bbcNv1o854Sm7KeRvDohLNodhoC6KnkuUHBZ2QQe3EcySSmql7Mpdt4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246556; c=relaxed/simple;
	bh=TPIZRcu+1FDUv3Ul2N3eIPWOpU5oGmTbG9vbLHMbQqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUbeDca2Agcc5Cs3ckGvjtlMeYnw2PPzOdgkK55hc7s6RjPV5Vx9eDIK2r+Q1adwedq8H5fR0olY+PVlyr2F0jgyFrVA0N4ptgmNs91fhgbcGw/5p1mBFlfSDVPkiyD7rWs3wSVPgiuf5rrXRuK8fEnqFMWUj0F9AZqk6vDITbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UfrDonly; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37198a6da58so4170196f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724246552; x=1724851352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49UiUbvVhlmPKCF9ngIeL/BHGCxk0mo/GSe6nh6O9fI=;
        b=UfrDonlyk9pxMLMmamwNf6LwjcY9Dmv7pRr3A7wPM8pQ2W4TywLx6T4IWS7gis1T0E
         E6Cw4uOCrMBDPm9zYsiH+3rh/FadoxKDFtI569SuH/n1ldVJaTIoUMOTJvmCqWe/X49i
         qi35ONJnSuFPUsn0K7sQT1bRqPYOWLUqfIexO6IBrfy0UZo2eTtYlTvXHt6SWSIzbOyr
         vsfPoRGF6QPRoBRy8m7U/iZB9W4Zj+p25F5QhR+aetsZRnqA5Zn/tbIBIPvfDP1TEwG5
         vRgSPM4rO0UkHBy7ULJebEIoQyvWOXetUa8xj0uhstkBobOCcL15aPqFel0ZOPEzJIfo
         s/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246552; x=1724851352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49UiUbvVhlmPKCF9ngIeL/BHGCxk0mo/GSe6nh6O9fI=;
        b=HOe/H3/qXTiYQgVQVZpY+eSojhrLXQrORcHZof45Qd7rth0+RwU+XgES+8KNzuAbtI
         4Wbjd7I9O++9uhaddD679/NtiN+so+fL15PlASAYhHF1a7B4YL0wLfgsDtmXvmp5EZDG
         HoK+23s6DC5+FGqRitCMRIq896GpPWm+zT6fHMKEQJyk2qmY6L5P9rECPq+42kw6MR72
         wL/PZpXvLwX2F+j4RG43xZGkmXlahl5z83XQbuDjWX/AHsLHCQAKvDnk/dpuYil9xgzx
         aCnh3pLnvpFHTEqksHZoi/EGS1HjXy1bVX/0TGWzD0BsiMCF+dVHaPfKuBZjXTeHYHil
         xnEA==
X-Gm-Message-State: AOJu0YzG+Z8SgdKS/jqxBXAYVPa7RX4ZCKx58wuAYjarQDVHRPHTODYK
	uBP4A0NT13KFaYC7eGHYekzXJN3TAvN8BbJ5LwN1BpHzU3f8X87i1aDi+mpj/D4=
X-Google-Smtp-Source: AGHT+IHG7+vM9Jjhm+SZ59KowPRMF+Lu0+jqEwVmKXC+1BaBKyuHAHW4qDwd2+EqRcY9Jrb4XySpHA==
X-Received: by 2002:adf:e387:0:b0:368:6f64:307c with SMTP id ffacd0b85a97d-372fd590e6dmr1905547f8f.15.1724246551577;
        Wed, 21 Aug 2024 06:22:31 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718985d9d6sm15682828f8f.64.2024.08.21.06.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:22:30 -0700 (PDT)
Message-ID: <6e8b9166-c1bb-4adc-92f8-ecc06d838c72@linaro.org>
Date: Wed, 21 Aug 2024 15:22:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] thermal: ACPI: Use the .should_bind() thermal
 zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <1812827.VLH7GnMWUR@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1812827.VLH7GnMWUR@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the ACPI thermal zone driver use the .should_bind() thermal zone
> callback to provide the thermal core with the information on whether or
> not to bind the given cooling device to the given trip point in the
> given thermal zone.  If it returns 'true', the thermal core will bind
> the cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> This replaces the .bind() and .unbind() thermal zone callbacks which
> allows the code to be simplified quite significantly while providing
> the same functionality.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Nice !

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

