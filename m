Return-Path: <linux-kernel+bounces-554858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42983A5A202
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9353ACF35
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29112F28;
	Mon, 10 Mar 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nNJIXz+C"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E5235C1B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630533; cv=none; b=RYzsUnE64TuOghw2TbdaQdJTBA7uuUEhyI0HQd5YT5djtvPbvcRAQiN13Z6U9cq/icNfBiHBdYaiFjCcZYnKfRpCoj13X6FIoH9Bqq4LCowBfURONZXjnaB74eWjFZVpgl9MATsrVFj+6WEPngJ+U5gmOoFKp+MqsVOmcwnmFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630533; c=relaxed/simple;
	bh=VBMDMcDaeNPanNhbLfuWCz5ZdQmWuAoWaVJLnBMRzt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paJ8FMfFFd0sTIQTmSJi5zKUSGP2JVfN5/OqgG9+xW3czbsptWnI87ROPeKY0y1wIzRpIf9wv6sLhL0OP+p3TYm1IfHpB/jBOgH8zkeOxCbJej+hMY0qLPlumbGDumevmSNsaDSbYVGVLYmfWqVGd2UknFD/yfGTaCax2hKcAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nNJIXz+C; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so199398fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741630530; x=1742235330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAI8ciAGS5zB0DvlZGls9s/FLbP/T+sobHPu1PwltT0=;
        b=nNJIXz+CQM1cWkei3jZCvsmDC85sN7gvCfPgT9WQC2xPbAQNHGlwIn622ZKVzrEnED
         5hBxmAFPxUwJb9slYfCPzJ8xw8QrBIByXj5v0QXUMg6KFxpBgElCtXTStDdIddLpMA8K
         KfARzDHuOaE67RZ1kQHnM4gxGM/hoqtDYYO86UuFKMMouO0FH4ESL4RZOKrxwYhbqVFz
         WJVCTbKeuwFKx0j+yst11gnss1GzqtSYc9DNRDnMEbSu4umUGsgfL+5iq2DFlE7DF5Vy
         CM9BAy62UM1vqKS+a8GtVIxCqW6ey1iz+If7shsSRsApdeWzMuUY6CVHaGOpnwis4S0r
         jIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741630530; x=1742235330;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAI8ciAGS5zB0DvlZGls9s/FLbP/T+sobHPu1PwltT0=;
        b=Hh7YmRnHrWJi44LQH5IzA25d/ljCSZKzFJfOuTr1JipZC9t9oJoXYALM4Ojt3a35ht
         sZ7uZK3oXDTOGe6MFVfmWzrEtX6xC3LpzV+KCnb3vSuxF/tgUrWAx8FQnV6ax7TAtQtB
         BoDu3/3rVejR5BZ8Wb9ve73lcL2pWN20kbwnFyxOcZ6iZBnY3IpU9xPf+V9XXAHz7E3O
         PA44TPYcvvwqncCzefRujY4TMHqaUKMD5ld2f6ycmCeODPsMEtX/soHgoKiFR4QWLyPy
         g3sqvIB5xSsk9/zFUH875zDf7kWwHW5N4SyDwb0MC25wIn4TxjHD+Ae2P/yj+0W4ZAng
         pUBA==
X-Forwarded-Encrypted: i=1; AJvYcCWbxG86KmPESN2sMMG2ztJLlEAse0bTZZkC65nvQs/GC4kEco60zRSWHUnmomF997b9cSPP7LJIIftkw6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCMB0ZGpw4DlZtmvXEYxoA0eunfchZHj1ughtppbAyIflbTPD
	sAizIaO1QlAk3L2pOoclrHLniouN3qrJg/5gvGocqKn2Y4PqUFTwtYWMCK1OMZk=
X-Gm-Gg: ASbGnctvpVDYrFODL9mU/XUFCZ88ytISyndemgyHNgmVo0UoNukPF52az0E6H1OvAdx
	bBOPiEbqRIUpAoTOA91p/5CAMIfomoowbmniXvWR8w5eqsViXFzN32hlssLEKsZxbZ4NXqE3WH6
	q0xzq8KjPE7jHBNxoX6E1bi2+QBTGXu8xAgdL3RwWY4OZL1oRVE/NF0DAcSN0R8uqun75eyjdZc
	sOHr0D28LMc2LJw+jNmFG1MySlv+Q6IDSdd9yELvoziZUxUSvwFHk8raw9KWKicI3/dx3KpTWca
	3ap2IEZ2WIp8gSeuRhSTZKWw1B3rzYCad/m4Y6hw7pGmiIm/FJ2PSdmYOLSkyzee8QoOT0ZSjcZ
	mmS22ww==
X-Google-Smtp-Source: AGHT+IFhWOlrUQlGauNsiAPR7fPPcoFbbBV+CDBh9F1smUyDI9GdLswjsb6iYSCOJNi0ClTHTURvww==
X-Received: by 2002:a05:6870:9110:b0:2c2:b9cc:afb8 with SMTP id 586e51a60fabf-2c2e8699e64mr372641fac.7.1741630530098;
        Mon, 10 Mar 2025 11:15:30 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c248d56112sm2276239fac.31.2025.03.10.11.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 11:15:29 -0700 (PDT)
Message-ID: <cf5b14f4-ac10-49a1-9f02-32cdcf62839e@baylibre.com>
Date: Mon, 10 Mar 2025 13:15:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] counter: Introduce the compare component
To: William Breathitt Gray <wbg@kernel.org>, csokas.bence@prolan.hu,
 Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250306-introduce-compare-component-v1-0-93993b3dca9c@kernel.org>
 <20250306-introduce-compare-component-v1-1-93993b3dca9c@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250306-introduce-compare-component-v1-1-93993b3dca9c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 1:05 AM, William Breathitt Gray wrote:

...

> @@ -301,6 +309,7 @@ Description:
>  
>  What:		/sys/bus/counter/devices/counterX/cascade_counts_enable_component_id
>  What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/compare_component_id

Prefer alphabetical order?

>  What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/floor_component_id

