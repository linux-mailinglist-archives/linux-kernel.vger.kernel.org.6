Return-Path: <linux-kernel+bounces-310925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9DA9682EC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729DE1F222EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0900117CA1F;
	Mon,  2 Sep 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/90OMY7"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88079C0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268672; cv=none; b=eK/mh5oIdk9E3/iZ4+Y8KKObSJr/dNbodN5zqZG/aLUF1OHTQrb/pfIwHpxO4Nw6tNyoOTSGvRDRyGfBzhAbBXqxi2WXsbYmwIMhshjLiOHZZkU0dvCBLsm77/gwRd1m8X/WBv7CMknIhHMPoS/ze+35RvNsw+ReGppWbowKZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268672; c=relaxed/simple;
	bh=fJ/Vccq3L1vp9NQX1sHYdA1GuJCqkvPAaxOdaMxOAUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPcq/X2l6o9MQWhWCSZVLGWeZv7MyKDDTcZtV7mUdM+vOL2TmwOBdvTfVDVdxrOB25sfYqqSBn//GhCji4399g4PUn9pktdhCBeSQQfQzdpEq/PxPgYK9wTMfOCCC3HpmpTtHeOcqj+Ppxm5RnygPs9y4YcK69SbP2w0ifXg5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g/90OMY7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bac9469e8so33337135e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725268669; x=1725873469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwoP5nxSjkeJIEkV8LmHpYP4imaw8ytQRUSRNEkIyvg=;
        b=g/90OMY7zabKw52nyB01yR2mDTGwSVLpyReNS7Ur73l8R/HsQcGrHYHczFTaoeX5gb
         gGEQ04+ZvqJGu49siihAWJXM0m0ZWKkf09WbSpwWgO0hghOaiYQyx+aiutnuazEY32sY
         vDzqq7XCgdQTAisl8RMeV4FqYwsro/oEuE3tfDM5TKQEGjdvMlXV+vVmEpF5IMpijHMQ
         iYN+5NvDXEEG43s3NfCYkhro4sqkXzhx7MAgUsR+hZ8GOB7ccHVCz6VNcg6Z5i4qUiF3
         WalYltXLzLsA46PcPbavHna4hQi5FPgvo+ru+pp7F4dQWROEocyj2FRgOoRaLDqifwW/
         wmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268669; x=1725873469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwoP5nxSjkeJIEkV8LmHpYP4imaw8ytQRUSRNEkIyvg=;
        b=pPCIc3HBlb0MxFSUN2FkjKgAYaAxJplUnaOpZbBjHUneCkONMwGlkAcDW+WR3vx6vk
         56CIrQPlLYg9Lre9ukWQfo13xfn6w7FT26J7Y22pTCQHZsWUL09Mbfh6AfmYJAqPBN6a
         TDt8QQwF9oP0lvRlk2cTM1VRnQ4qdXAy/obCRK7xqXE0eXPTSPwXcH/rNxpJ6IFZnAjF
         2YTVhZhsM0fgHVD4C1pVCq0a+V2UvcW1WZHDzpP+Vm4EBLJWlWI3EQ8V+LZLnR8J3KQl
         DqLevOTbCL9zNJGaMQwbFv+Hu/X9icv+QGei7s/M8ST82tjxh869aIRUZCUEa9i2J5Wq
         jQLg==
X-Forwarded-Encrypted: i=1; AJvYcCW37VBE9OFaJ0sQOpMmq0AYcUY7xAc45n1A8qDEdxovkP0Y8KUg4TaMZ1a8U4CQGgo0qkaHqNn1WeYgkXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/1P30OC0wkBit8O+uEl1+ofm9CCmuf3trpUpX5kNM7tFv8PdN
	HCHCwDqATPu6URyr9DgMICuf0GyKAY8/3HZZ6aJlJ3ewYUpvWcuLjQVEcpuz7lo=
X-Google-Smtp-Source: AGHT+IEaaNZhUi3bcZM6UX4XQ94YSNjorOxi5KRBzzxCl69qsuQyUz/4xWXotG+fEQsQPADIPCIM4w==
X-Received: by 2002:a05:600c:46c6:b0:426:4978:65f0 with SMTP id 5b1f17b1804b1-42c82f56727mr22686845e9.18.1725268668575;
        Mon, 02 Sep 2024 02:17:48 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb6df84b9sm131172265e9.24.2024.09.02.02.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:17:48 -0700 (PDT)
Message-ID: <51c33ede-b379-41ab-88b0-71615e214853@linaro.org>
Date: Mon, 2 Sep 2024 11:17:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/jcore: Use request_percpu_irq()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>,
 linux-kernel@vger.kernel.org
References: <20240730132015.8920-1-ubizjak@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240730132015.8920-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/07/2024 15:20, Uros Bizjak wrote:
> Use request_percpu_irq() instead of request_irq() to solve
> the following sparse warning:
> 
> jcore-pit.c:173:40: warning: incorrect type in argument 5 (different address spaces)
> jcore-pit.c:173:40:    expected void *dev
> jcore-pit.c:173:40:    got struct jcore_pit [noderef] __percpu *static [assigned] [toplevel] jcore_pit_percpu
> 
> Compile tested only.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

Added Rich Felker in Cc

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

