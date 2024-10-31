Return-Path: <linux-kernel+bounces-390408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1699B7975
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A631C2087C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F9219AA43;
	Thu, 31 Oct 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4zTwhbo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745C199936
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373292; cv=none; b=ZgkGw499WlFhfAYCo6JTPsO8mxDO159JVaHpyny09iZqnz3Prr+MJ9hFZPG1DdCH2eZpAsKmufeJpfCwIRDXDYO9tyJn100X9vOfDkuhdLqSY/hAYDfmoFOaiDnaGzXXbdv7NW6k0FcGsVoVo7hVIgKg1I6otxklziKm8d/pGf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373292; c=relaxed/simple;
	bh=i5KsGLfkIQ1st1XLL8Kk1hexPW/9WP4R/osKjHtqkKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2Mhy1J7J1l7awc/zm5blx2+9LN3gPyhMZ23PHAKdLRZrAEIJTycfdtW9hpnTE6kPsftpL0/Wm67pLEovmU9wbafVTJvrrm2mdh2S9Lyg/PKiaOiRw4K2HYmCbXethng+4EvSCdM2ImrJHgqMyM3Ydb2ZH4j1l3zmCdVcfUlLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4zTwhbo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4319399a411so6962885e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730373289; x=1730978089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PozbzDh8fynP/sDrQGC3kD4ausHypQY0l1L7spYdSv4=;
        b=D4zTwhbozES3+5qr34DOatjSlZZoeIm/C1f7zbSAo3GX4e/xMp8feK6aeo90/LaPTK
         VXuhFX74is2chVall5PU1gdAmL1Ac90hIonC9jZJgTlpZfPVFE+zRM/i0cTEPECDSWBb
         rxoypLKU9yGJeIQoJ7X++TQF5YT33/ADGYY+72QOWI1/iNNFPfen07YOAzyTwynCkYPd
         S4+kEfrfFeT5xT86nWVYPd3xMluTiZIn00b5QgtrGZRknw8GU5gZnwiUM+9jD1BjCeCs
         xvt8/lGmZpIyOHjCl+ZcaSga36kOu+m5ATAdH2lcfqT/PU5XlabGN6tYAeEIvy/DYAod
         ISaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730373289; x=1730978089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PozbzDh8fynP/sDrQGC3kD4ausHypQY0l1L7spYdSv4=;
        b=Xiqb6CpqqnklS1s713pOF1BDdHCxvNVh6nkPyQh5C7CvtTLwLBX3OYjXTjRuZKE4/9
         pBbRWN3FE8wqA9tN975E9PSZwvyqFPniRM/Q4t7bFe69Ap3Yr/6kEY4HMd5Z747GnyLU
         V2fhpRMd5rX5ynEwedYpCueWWYsbV07fKCoyyHF3cgF1NQ9Vb0vVg6zimAErjNyLCmqp
         wzVy10dAbwdkAdDCwuwhp8vlgDC7ib4CPspaKohluhG9XflpPA+GleQN9hZI9q0Nw0fn
         bK/ao+JlmSKUKPzga/ZlywRL1YokzJSdj6AD3EJrzLGWNecSIXjsRK7G3A8IqwTk6/1j
         dgdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMiAsKXnV93DYFFXmyAR3ZWu4FtMXoBNmt5WDT/mYhqfVDLRz0pOXq77qy88/6FLQ86yMJkUUGPbv/0tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWBxpHqpWT1BD656mfHeZwIYHEq7otAx6ahTM6UCt/GWcVU6b
	giTj3ycHZXkN9yk6HVbNA/wvqSq4YvKuND3sw/JfCUKs2dTKZ3f7
X-Google-Smtp-Source: AGHT+IGfEhgylwo9HDbgpkO/tkKXN2QtV74TWAjukaY+u8rp50OfYjIiD1MnYUAdd0nzH218OKjcjg==
X-Received: by 2002:a05:600c:3b9c:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-4319ac70754mr181762525e9.1.1730373288597;
        Thu, 31 Oct 2024 04:14:48 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:d7b9:afdb:c541:d023? (2a02-8389-41cf-e200-d7b9-afdb-c541-d023.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7b9:afdb:c541:d023])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca8eesm52772575e9.43.2024.10.31.04.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 04:14:48 -0700 (PDT)
Message-ID: <99b12dee-43c3-4007-9c55-e2a884fc662b@gmail.com>
Date: Thu, 31 Oct 2024 12:14:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: soc: atmel: use automatic cleanup for
 device_node in atmel_soc_device_init()
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241030-soc-atmel-soc-cleanup-v1-0-32b9e0773b14@gmail.com>
 <20241030-soc-atmel-soc-cleanup-v1-2-32b9e0773b14@gmail.com>
 <dfa83464-4632-45cf-a257-b9d9739d37e2@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <dfa83464-4632-45cf-a257-b9d9739d37e2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2024 12:07, Krzysztof Kozlowski wrote:
> On 30/10/2024 18:10, Javier Carrasco wrote:
>> Switch to a more robust approach to automatically release the node when
>> it goes out of scope, dropping the need for explicit calls to
>> of_node_put().
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> There is never a "drivers" prefix. Especially not first (because as
> middle appears for FEW subsystems, not for SoC though).
> 

Thanks, I added that by mistake. I will fix that for v2.

>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  drivers/soc/atmel/soc.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
>> index 64b1ad063073..298b542dd1c0 100644
>> --- a/drivers/soc/atmel/soc.c
>> +++ b/drivers/soc/atmel/soc.c
>> @@ -399,15 +399,12 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
>>  
>>  static int __init atmel_soc_device_init(void)
>>  {
>> -	struct device_node *np = of_find_node_by_path("/");
>> +	struct device_node *np __free(device_node) = of_find_node_by_path("/");
>>  
>> -	if (!of_match_node(at91_soc_allowed_list, np)) {
>> -		of_node_put(np);
> 
> You just added this code. Don't add code which immediately you remove.
> Squash two patches.
> 
> Best regards,
> Krzysztof
> 


As I said in another thread, I split the solution into a first one to be
applied to stable kernels, and a second one that uses a more robust
approach that is not supported by all stable kernels.

Best regards,
Javier Carrasco

