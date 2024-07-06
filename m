Return-Path: <linux-kernel+bounces-243286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF9929405
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BAF1F222AE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6897139D00;
	Sat,  6 Jul 2024 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1ftEqmz"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7412F373
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720275841; cv=none; b=IROj2XruxZA6RZN9XOJV3pienWj0ZuTcIwhjg1ifbMlLq1CNeuHJS1yKmdSuqwfM4Hx+GbJWCWebCpM6x4cHFU2yqEDoRM+E3LQMdqpki8EgZnA0WrkdvAEpHO7Yldfp7+0sG72+r82Eg2Xju0ukKbRwxdxMwJuHUSGUSKg9pQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720275841; c=relaxed/simple;
	bh=5yTgALKeZ76fdbq3u+Yz7W/eWNPyh3ZsQrQPYUpXS90=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z0s8W2r2UJtyfenAB/0HjhGdZiDyMNSQtqtgzVUQT6XiYxOJlkw9di0DE2dQuOaMju1A+uvsxK35w74yN6ZVS/iX3wuOw1bB2gXITQjhBCH9a/ue3qGcormrA704F4y/dZ3mvyNFdPvvAAb4Fp1MBBG2+xOzNTk2kEJ5rHT11yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1ftEqmz; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e9901f858so253993e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720275837; x=1720880637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUMwLV6505BsBECdLQNLbzOn9+IIGo72PKN55IPpokk=;
        b=D1ftEqmz2PcOpGtiByxK+jDrSYFsT9K6ZUqWTc+DM3+B3yRXt6Ar0Rhwj2w4G4XzGh
         ituTDNhcC4e8RFzTJ3PEkBiI+xSaYXZVLww6c/qzBHyheBhv3L6dDWLzlhW9HDVJmwwp
         zmUzTWxxRIEbyupyB99To92lOYbuNZnLJ+DSV4/U29Mf5zByZxGc8WIqJMo/qhztuSlP
         jOnplW8ZIPD/5tYlxFykqE41kXE4Hf42ZdXylsrwa5G5VC9MzbnK4wBpO92SGZs04+Q9
         59Z6hzGUItfz8Jh8NuypIHMQVxIIrYu1W2NRKXFD5+nz7LARzfLyBSlM6KCsbUjb+QVn
         S0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720275837; x=1720880637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUMwLV6505BsBECdLQNLbzOn9+IIGo72PKN55IPpokk=;
        b=XrYqOYo/ZN9iNsVyyDf4XM74QHCaQK+NksyZemdFteUSAzMX+W05jrO2IHUcOBwXCU
         zE0ziEahiUw9EKdxa8Mq+ceSJIpAuCxtll1kYR6GFuHMzXkXlM5Z+KiqM8BinYUCvgIs
         2fu2GOFmyJA1Ui1qmw38gTZcvweWE4Ip/YNB+h0LlxxoFYAEUEqwVAh+6Rx6sUw8ewZB
         B1oiZQFbWZdS9SMH6QqCzi0UOgO0SIVEKk5x/OYI6JaLSi89nhFh8tlhL2+/y27drzoA
         7AbpROYVKonvF3f42cC/UR0YxnjV0TQZw7qIGVEsehj3rZ8M9IAyCCmb0FSP9UmA7QJz
         7ZRg==
X-Forwarded-Encrypted: i=1; AJvYcCUTa0n7vmz57qA3hX4NMwAFnvXp7AXXaL8oTU6EAf1+GyVAXDmWUTy/4OMA7g1BUzW7WTA8M+kAEDCdKIiYwjpuCcckKrMJD+zRiAwZ
X-Gm-Message-State: AOJu0Yxb/+TZ6z6QaYjT3S8iSyiWPd/avMxkodR7MpkOeEga1kKZpUrr
	ilKwuA7iNSQTQtmmR958T0i5xrJ9eg7gD3McwfG9nngNBhsNqFll
X-Google-Smtp-Source: AGHT+IG+tHfLWWvemqMxOQPTvsTq+iJgAu8efvK/eJQhTgLidV+4gtztplGVeQeVkV07268jtc8uxw==
X-Received: by 2002:a2e:8710:0:b0:2ee:7e6c:34d7 with SMTP id 38308e7fff4ca-2ee8eda939cmr46691171fa.1.1720275837026;
        Sat, 06 Jul 2024 07:23:57 -0700 (PDT)
Received: from [192.168.0.101] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1dd5dfsm97633825e9.11.2024.07.06.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 07:23:56 -0700 (PDT)
Message-ID: <bf57e119-d957-484b-be23-ea43811f30e3@gmail.com>
Date: Sat, 6 Jul 2024 16:23:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: ks7010: Remove unneeded check in
 ks_wlan_get_range()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Aleksandr Mishin <amishin@t-argos.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Zhang Shurong <zhang_shurong@foxmail.com>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240705204434.10541-1-amishin@t-argos.ru>
 <ZolRoeaPETSmJMGJ@shikoro>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZolRoeaPETSmJMGJ@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/24 16:16, Wolfram Sang wrote:
> On Fri, Jul 05, 2024 at 11:44:34PM +0300, Aleksandr Mishin wrote:
>> In ks_wlan_get_range() variable 'i' which value is always 12, is compared
>> to 2. This check is unneeded and should be removed.
>>
>> Remove unneeded check to clean up the code.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 13a9930d15b4 ("staging: ks7010: add driver from Nanonote extra-repository")
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> 
> I thought this driver was to be removed[1]? Phillip (CCed), what is the
> current status? If you are busy, I can remove it as well...
> 
> [1] https://lore.kernel.org/all/igi27iwrzg3ovgj3sym4gsi45timpkt4vkl5ss5dbftdzat6p4@ctxcjocvunpt/
> 


Hi Wolfram,

no the driver is not removed yet. Planned to do this on the next cycle. 
I did remove two others and wanted to wait some time to see if any 
complains arise. I am a bit scared.

Please always consider: If you do not use the driver, it does not mean 
that anybody else is also not using it.

But may be you are right. I am a bit slow and to hesitant.

I plan to send deletion in 3 weeks.

Bye Philipp

