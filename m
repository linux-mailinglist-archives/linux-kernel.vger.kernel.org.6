Return-Path: <linux-kernel+bounces-198926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7728D7F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB041F21851
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9388185935;
	Mon,  3 Jun 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXTNN9Xy"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C585659
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407718; cv=none; b=g1dxvpQKdsHZUMvJXUyr+mclLLn0cAMyLcsno5okg+g9yS+24dXLPcsNhH+lWqePwj0cBuOofDLr6+bRNfFVnNMPYjnxuOrOjf11if2dVwVOXRmDd1yZojkNfo8AxreNsY6ZFvAX70adoiDerppf9uxanX2uzHj9cdduFEATlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407718; c=relaxed/simple;
	bh=QJ6kgVVjNLPyIWId444QEP06eFv2VCq6GqbBgggugSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRXtJiyZusUNuxqRKprGHgmnuaxtONh10h8VI4y+h3pOJIux3EiBlsQL7JJLpGWeXaH3yzC7MQNGeQr6aZ4Ym5UYajGU9dlE08kgEzFuh3/JkbX4KzC1R0rjOAbEYzx5+bFZZUhSJyuIuQypskvU8SQQ8hLnsYmo84/z8cYLyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXTNN9Xy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35dce6102f4so2788830f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717407716; x=1718012516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USghCbUyJIkAuxV2+T41xHD5g1W2QLSW25YefyWhIG8=;
        b=DXTNN9Xy14IrP3ySeI92IIy1CHwidwujTpBp9t7m+0qmjquM88/mrYxoCkRdfxz1Bi
         szYoddKdThGHxM8k3RiiL7MzqjwpxZuIhtjzdHwkYYTyvlJI+5LT0g2bPUYx00v7zhEN
         2v5ENsqvxF2jN1u+51bGfe6VMHm52evSoGE2uKoumSRHI8un4xLskb7OsFZ5Jf24TTfm
         CaNXvI9sn5b921P/QXr7/8h4oxJUl9yE5X7V4kFo5dgKVJ0DS++WZ9agy/xXj8UEzfwy
         gUbfIMrujdMmDPvgnZc5IAjyINaDQSS9EfreKy1M4fB2jUpLXUyK7hCo9Bxg7fmiQSx4
         cRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717407716; x=1718012516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USghCbUyJIkAuxV2+T41xHD5g1W2QLSW25YefyWhIG8=;
        b=OkegKeREezGBUsJOSSLVdNnxSDPF3IWcUu03UdAV5CHLPEIMOdJpEz8z6JD8vM26zA
         VuYxiicYT+4KODXUd2QvKnkSSd67Mm4cM1v2rZKnx0FaTpvl9gK9MAaX/xm8xTH+ZTKJ
         ctn9gd26R597634empdgsmmIg8McvZOT9xGXLb1etmHRzs1Jp1Frr0WJ491/PeI/NGp2
         pmw0BuFcUilH7sMP4WtiD2IrHh8ppnNAuR+K6XcRdwgJySIrwoMbYzt3Wtpvlnnk/dn5
         G9zE7pFyGY08y2WHyFlflmqhx1MQulCRgpv9g5W2NY55IZK3K/YF1nrLRv5Z3AlUDJci
         Lsog==
X-Forwarded-Encrypted: i=1; AJvYcCW/43mtkJTgYEQdQvrCbWAn1oi+JyBACrD8O+3wEDEaCgVGQnFcEZYGpHjFI1U0g1zLcHCMTjhWfH9uST7R0x4M2hWvzjjux318jRb5
X-Gm-Message-State: AOJu0YwsRW2Om+8mP7AjSyOHaCwy0TlLw8ciN8SOUPs2apDwUp/QR7dz
	Cjhoy+IWpGyMZLVSolOJlYfrhu3WQlPVE16alvuEHSXqY9d+jn7X66AqDfgLEI8=
X-Google-Smtp-Source: AGHT+IFRL8KKMxdcv97FZ7PweTJ8gpznKd+SdAWL8QlXQFsqHC59CsFCSxjI6m4NoXkXyzHpjA2y7A==
X-Received: by 2002:a5d:4406:0:b0:35d:c106:2db8 with SMTP id ffacd0b85a97d-35e0f32dc68mr6062943f8f.57.1717407715564;
        Mon, 03 Jun 2024 02:41:55 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:430e:1334:2eb3:2b19? ([2a05:6e02:1041:c10:430e:1334:2eb3:2b19])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35e5047f75esm5160133f8f.35.2024.06.03.02.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:41:55 -0700 (PDT)
Message-ID: <854d1b7b-074a-4bfb-8dec-5432a832e221@linaro.org>
Date: Mon, 3 Jun 2024 11:41:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
To: Thomas Richard <thomas.richard@bootlin.com>, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com, u-kumar1@ti.com,
 j-keerthy@ti.com
References: <20240425153238.498750-1-thomas.richard@bootlin.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240425153238.498750-1-thomas.richard@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/04/2024 17:32, Thomas Richard wrote:
> From: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> This add suspend-to-ram support.
> 
> The derived_table is kept-as is, so the resume is only about
> pm_runtime_* calls and restoring the same registers as the probe.
> 
> Extract the hardware initialization procedure to a function called at
> both probe-time & resume-time.
> 
> The probe-time loop is split in two to ensure doing the hardware
> initialization before registering thermal zones. That ensures our
> callbacks cannot be called while in bad state.
> 
> The 100ms delay in the hardware initialization sequence was removed.
> It was initially added to be sure the thresholds are programmed before
> enabling the interrupt, but in fact it's not needed (tested on J7200
> platform).
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Acked-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---

Applied, sorry for the delay

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


