Return-Path: <linux-kernel+bounces-310909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FD39682BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B5F1F2145F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16880185B62;
	Mon,  2 Sep 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzmXD6eK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01413959D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268207; cv=none; b=XPb/r/1AuX0v9nRnqKzHZKMu/p3zHsatnsmB/RTX991Y8vmbwfs21iwfulEUIwt4FJpZxQqiRqF0zx9HiNxIHnhNbbgam2Ks2ECcMIC4HK33Hr5BMXnetjpeE3ECRTV8LRB0szCG6A14dsNF//r+qcumtf71p4cztXtJAR92mq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268207; c=relaxed/simple;
	bh=v5euEe+rJMCIX9UHXX6xuyAik+QZK50h2XfTy5sQQEE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=psKDavPyjtgtpX2rpKosvkh/B5Jd95IhWYSj1qzQtChoZUaCPeI8fghHYEyivNyHUNrqr4cLw4R/R5yF8jnFDSQ8NgyK3LrX4CwdWZUUnc71dfxbi9T1WCKnO5hkJu2EcB9q1MMGoYMBoAXDYMw0gr2JqfXrS5WAcEklCjhl8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OzmXD6eK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so5198315e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725268204; x=1725873004; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhybQgAVMwKm5GS6Z02/yMIXzZ3WBbLihAGlE4BQLSg=;
        b=OzmXD6eKQ50DTegniYJ6AkLP7gnRKquMrf7ugULQH/edEV0TIQV9p3KKtjJ6md4dLs
         GfokPq3nke8Jz16PzL5gzz550vsbtUyp4getd7Z08EVpqoYJ73uHqw8O/Mht4dpkxsFd
         S4fQG7U2DlA3NN70Ad9T3z2+fggpKPka8PKra5D6KJ5zROXliuXoEARJTvOYbCnOjyeD
         pCkexSDTjIwNmbS89HN0bqN8moX8/qfCOul1eoKsFDODuElKYZ0icfKVPECpMR9zbv//
         CjbEduHIM6IIzB4ECERLMSBNwRowCJ1c5a9eQz1fKX+CjmdEqcdtB/G939GNrYmp+mVM
         pazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268204; x=1725873004;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nhybQgAVMwKm5GS6Z02/yMIXzZ3WBbLihAGlE4BQLSg=;
        b=dyxKij1AnNaghuuOpEWUPBhQZqxYSchzp5319/YDhSM+CkISVoIFbyFTcNKWayOZFy
         3q7+9KtP6tE45RUtvDJiT1oqbiHOXRpRdN03+LHfclqxAEwDJi3A1Ti6J9yiQlXNahk6
         vc1CsO4akLNVBRKfPQRa7++qftaehC4JsK3+ELbdti1YWU7ynx10QtgysT6Ldeo8Cvv7
         RNXFIdXcCC1BWdkDmmqK/LC5xuX62OryNOtrhwLc3YZoLZ0FM/hOBtXCrz034qjQida1
         2EJ8PaPU/vNAV+ILj1DCN+v1CdIhADexNfrLU6HS4m2zAPks615VanmWFnnuOXfqbuHE
         vLpA==
X-Forwarded-Encrypted: i=1; AJvYcCXC4eI2jLlkwam1k+b3c8pRvYDvYw0zZBVxS3lLGo6RaLPM2qtRWJE01KR1EDSDnwPIuhVz0jQVdUsv1yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPM+3oF0lGOHRetUkBtfiTSSr/MRdG91Bh3p3py1WNMg1kWDxI
	j+lulp6sq2nvEBmIffaEZYlqNMl19yS3geDSOdG+i9pelhTK5nXkXNTKMYMu+0nNAZlY3E8tdNu
	W
X-Google-Smtp-Source: AGHT+IG8dSjg/mLorSe0/YPcDqL0XAAgiVfEMR1uoiiOpAd3Fxg0siARti2JnZO7tgjyY1BzEd5BBA==
X-Received: by 2002:a05:6512:2245:b0:532:ec7d:9c58 with SMTP id 2adb3069b0e04-53546bc1e63mr5928931e87.56.1725268203470;
        Mon, 02 Sep 2024 02:10:03 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb01d300csm141376725e9.15.2024.09.02.02.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:10:02 -0700 (PDT)
Message-ID: <d0e93dbd-b796-4726-b38c-089b685591c9@linaro.org>
Date: Mon, 2 Sep 2024 11:10:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jacky Bai <ping.bai@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers fixes for v6.11-rc7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

please consider pulling the following changes since commit 
431c1646e1f86b949fa3685efc50b660a364c2b6:

   Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.11-rc7

for you to fetch changes up to 3d5c2f8e75a55cfb11a85086c71996af0354a1fb:

   clocksource/drivers/imx-tpm: Fix next event not taking effect 
sometime (2024-09-02 10:04:15 +0200)

----------------------------------------------------------------
- Remove percpu irq related code in the timer-of initialization
   routine as it is broken but also unused (Daniel Lezcano)

- Fix return -ETIME when delta exceeds INT_MAX and the next event not
   taking effect sometimes (Jacky Bai)

----------------------------------------------------------------
Daniel Lezcano (1):
       clocksource/drivers/timer-of: Remove percpu irq related code

Jacky Bai (2):
       clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds 
INT_MAX
       clocksource/drivers/imx-tpm: Fix next event not taking effect 
sometime

  drivers/clocksource/timer-imx-tpm.c | 16 ++++++++++++----
  drivers/clocksource/timer-of.c      | 17 ++++-------------
  drivers/clocksource/timer-of.h      |  1 -
  3 files changed, 16 insertions(+), 18 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


