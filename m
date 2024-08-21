Return-Path: <linux-kernel+bounces-295584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1F4959E96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC6C1F21C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7999B199FAB;
	Wed, 21 Aug 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBH/N9EF"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E70196C86
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246753; cv=none; b=Y3h/dKok00WRxpuk9irahXZ9VNM8qAyZj7X5BX/NquFkUY2TBPH7qqzH4zjR5CeMlz6GlsYKb3pMK1Oj+g2zSuoRqEc4la/1e/O3LFvuq18mA3Scvk4dLYvE2xe1GlTY7hm5eDtl4DUFbCVx5aZUYwdCWnfA/o4L+qVnoVUVNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246753; c=relaxed/simple;
	bh=EFsAtmpxBfkmqyoFEOCZFst//LhOUbhdQqC3QFQdw/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGrEck/NKfBL0KnC9WPr8OKaCikyxk9hVGP45QtFpZKTFmBcPFfBikB5/jAc5MK/bu7IvHuWSGUch6SX1X56v4OAC0pV/fFIBvcSBJt/zuUCd94Vw1GL0uFGBK735884CtZDshRMycp0nALuDdnt6XNRudLPhkmYAtU/6KK46bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yBH/N9EF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so53060245e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724246750; x=1724851550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjLi/KAAI/PKbdExf+68AXZG/A3FesNOUEX4xlJJoCk=;
        b=yBH/N9EF5/M+vlQ/u9DoD8PdEfzIm5mX4tjyfFN/Wo8N5H/bBPk4pINFZyXAWzfaEk
         jRHYK2n0iJz7PWNLKXHGvVcqNTMItY5jmCQFk0fcCgNNt9dihGqXfI95gfG8kQncVB+D
         +yFCiR7OnuQ8jF1M11aPAcEk89P8C8Zm+XGSUTHnN5IBjF0aRcwkuG2fR1IKhigE/tiF
         MrgWAB8GN9e5Lc6qnq5V+XBvoXtgepzQkLDH5PKt6ikYxkraRXV7Ng2Vcytq79aYnjWl
         zzUVMZPukF4z7FuYtnvFcF8Fe8Qzh8dPWZxO/yzeC2R9oXV+rhOyXYEmpbGuFpELfkEo
         NRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246750; x=1724851550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjLi/KAAI/PKbdExf+68AXZG/A3FesNOUEX4xlJJoCk=;
        b=hdu2iQzjCjKxGyroXI5k8FZrG3mqZYSRUvrK+t8ibqQzLwEx3HhSnKzH6Pi1k0DG+n
         WM+ScDZ/eZvCZ4AbsYAqXkdBSW6ysanV01aZxPf703HYQo2+frdU++Ikp5cQp0CdUam9
         0TLoKtL1VAxTn3S4NPfhLyW9xipNXaX+xyDLqhLME5N72zM78wHk5utfMdDB5SevwoQo
         6//4JMhPljiua7B5tFssuW9Hjwg94GJvwL8AORr35GMpsXPU/GLkM71t58GXqb66SXUd
         DPOsEmO3aOypwmHBnPlJfgdjTYqBdTPW9MM2dG3TkHSZ1d27x3W9Yr1BPWDmVQRxvwlx
         DzKw==
X-Gm-Message-State: AOJu0Yypkv2zqW/S7UfRw9QDT5swDJdhkHlRlLxIqdptteIhKNz5gAOK
	c5iJXrQ/5i6EZH7aQh4GvHSYn0HY9PreLMYgTQjxpMRdIIEuW6A3Mdw8Id/RaejxaLelI4r1utv
	l
X-Google-Smtp-Source: AGHT+IECv4c7UUWm/smcJlWte8h7hndViQz7hioIczt5zHH/4DxCO4/6bfIo2S3t25go5OUkcOOT5Q==
X-Received: by 2002:a05:600c:3c84:b0:421:7aa1:435 with SMTP id 5b1f17b1804b1-42abd25dcb1mr16347945e9.25.1724246749515;
        Wed, 21 Aug 2024 06:25:49 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718985a347sm15750551f8f.60.2024.08.21.06.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:25:48 -0700 (PDT)
Message-ID: <43c8dade-4b6e-426b-bde7-769b50383145@linaro.org>
Date: Wed, 21 Aug 2024 15:25:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] platform/x86: acerhdf: Use the .should_bind()
 thermal zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Peter Kaestle <peter@piie.net>, platform-driver-x86@vger.kernel.org
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3779411.MHq7AAxBmi@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3779411.MHq7AAxBmi@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the acerhdf driver use the .should_bind() thermal zone
> callback to provide the thermal core with the information on whether or
> not to bind the given cooling device to the given trip point in the
> given thermal zone.  If it returns 'true', the thermal core will bind
> the cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> The previously existing acerhdf_bind() function bound cooling devices
> to thermal trip point 0 only, so the new callback needs to return 'true'
> for trip point 0.  However, it is straightforward to observe that trip
> point 0 is an active trip point and the only other trip point in the
> driver's thermal zone is a critical one, so it is sufficient to return
> 'true' from that callback if the type of the given trip point is
> THERMAL_TRIP_ACTIVE.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

