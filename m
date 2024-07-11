Return-Path: <linux-kernel+bounces-249929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA9A92F1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CA91C22164
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B8E19FA62;
	Thu, 11 Jul 2024 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="m30wEy/W"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4B12FF6E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736377; cv=none; b=J1fNTYV17P6ELJU7IayLqGM4pK/LFCukR0zwnK9DWfaB3vWNvnn8/s5EJJheM8LnPZGlQEYfWEQIA2w0OcS87CZjbN/91vqqlEENdle739tYme7gctuwuW3XwT/KR8CoAaeHRHd0zmxOuPFk7OHDtnoqELyu2LKsuKTS1aqD9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736377; c=relaxed/simple;
	bh=I0xFXeyyipJTT/A496hnd34viJchK4bAqhfPNZ1TxHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnHNnycIR4PgmMlttWEX8H6FvGMzVtFQSbQ+rBDZmb5EQvuxmyKXpJoe7xSAH6byLAnikcYP5VNMcI8YNbf6y7oG/GGGwSRzqPiiG1XdwGTpgQ0sdR2HM6JB6qtIYNkpoRxk3JybBrBoo6MmEKG5sM7hD/4qhX1qIAbQJqUg42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=m30wEy/W; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4267345e746so9322435e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1720736373; x=1721341173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KNCS/l67ZFh8/AsWtobABnj+gHm1+P2YaXJjG8kotm4=;
        b=m30wEy/Wy/OvotfmHn7Wmwe0hbbqKqq0+iiaIXBiFh53sIRM/NtaOLNa3/hgC6C/uw
         SF08kWQWTQXF2VmYDcY4cEpupf5cHmPIu7nazvGrAcVk0rqImRJ/WnI0rc3MM0YqTAEt
         QrGOSdJMTt47S1alSvXwP35xoeGbsjWCReevM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720736373; x=1721341173;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNCS/l67ZFh8/AsWtobABnj+gHm1+P2YaXJjG8kotm4=;
        b=xQbRfYBqoq44Qbae/YK7EMgRDyJt5aaSRaKrL2WUDKuGeLwUkLVuvegr6aIjlLfO/3
         Fdqt7x/oGzy2Cb4AhYCoaXmxhzodOr7BpQyBi60kDZKasImZ/JGmKmP987YKMYwc9J7D
         UbQP0nzXgEojlg1GtIT+Wtgmalzi1k7JHFZhhwt3GB2nHZ4pE5h9FWpO6HEmiqtpugri
         pXLZNhe85tkwxkbaVnb5Ev/ysiyg+SqwHLa5NhYWjCeuvU14CWQSpd5ImAY01vXg7jS5
         R9ai++95THxYyoIyInGlqBS/GIyETZeX1OKKSTpuRIBKUlfwcyFVA/QzD4pX4wRPhJ4E
         FLbw==
X-Forwarded-Encrypted: i=1; AJvYcCXUkGQ435keWv0h2Oxqw2SIHRwD45QtYCkReGey6szDvOdQ+6RxmCiM9FsjSm2m8LQ21gwL+1Opb1loTypAzdFDtxBzGQshJRI92DHs
X-Gm-Message-State: AOJu0Yxc670SguU+GRhPniQu63+sqkkCS29QsUGoVma/Z8+HA4WcFxP6
	TIQzy0J1DbmOMXI+KJ/zo6Hr9IE5k1/gtzAA2nqimd8ImC8V6EppXTJf79lhvV8=
X-Google-Smtp-Source: AGHT+IGKz/YBt/YNmXGSMlZsyMwRV/jL0zSb83rdpYccUG4n2naQoDOcWoIUH891b61ch9E/m51DEg==
X-Received: by 2002:a05:600c:4982:b0:426:6314:3336 with SMTP id 5b1f17b1804b1-426708fa8bbmr61928035e9.36.1720736372619;
        Thu, 11 Jul 2024 15:19:32 -0700 (PDT)
Received: from [192.168.0.22] (53.1.159.89.rev.sfr.net. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde8902csm8794961f8f.51.2024.07.11.15.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 15:19:32 -0700 (PDT)
Message-ID: <f2044667-e235-4abc-924e-3615c60681f1@smile.fr>
Date: Fri, 12 Jul 2024 00:19:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: core: Set the fwnode for regulator_dev
To: Saravana Kannan <saravanak@google.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240711212514.2372780-1-yoann.congal@smile.fr>
 <CAGETcx--FNpz3o5TiZ3T6UkMHKBUjD8cwHR6eQAjM-U86=p_Eg@mail.gmail.com>
Content-Language: en-US
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <CAGETcx--FNpz3o5TiZ3T6UkMHKBUjD8cwHR6eQAjM-U86=p_Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/07/2024 à 23:29, Saravana Kannan a écrit :
> On Thu, Jul 11, 2024 at 2:25 PM Yoann Congal <yoann.congal@smile.fr> wrote:
>>
>> From: Yoann Congal <yoann.congal@smile.fr>
>>
>> After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
>> detection more robust"), fw_devlink prints an error when consumer
>> devices don't have their fwnode set. This used to be ignored silently.
>>
>> Set the fwnode in regulator_dev so fw_devlink can find them and properly
>> track their dependencies.
>>
>> This fixes errors like this:
>>   stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Failed to create device link (0x180) with 2-0033
>>
>> NB: This is similar to the commit a26cc2934331 ("drm/mipi-dsi: Set the
>> fwnode for mipi_dsi_device") applied to the regulator framework.
>>
>> Cc: Saravana Kannan <saravanak@google.com>
>> Cc: stable@vger.kernel.org # 5.13.x
>> Fixes: 63c7c9e16c8e ("regulator: core: Get and put regulator of_node")
>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> 
> The change is valid but the problem is that managed device links don't
> work correctly for "class" type devices. So, we can't merge this
> change yet.

I was totally unaware of that.

> So, for now, we shouldn't land this. Are you not seeing probing issues
> when you do this? Or significant changes/delays in probing?

I just checked my logs : No probing issue nor noticeable delay.

Thanks for your answer, I'll drop this for now.

Regards,
-- 
Yoann Congal
Smile ECS - Tech Expert

