Return-Path: <linux-kernel+bounces-572777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB1A6CE90
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01E318935D2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D6F20127D;
	Sun, 23 Mar 2025 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trUxb8yv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74635947
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742724350; cv=none; b=Qpe6VvJay8gon1sp3UntccP7DnMRAXdNhPSADruVnuzBmx2dm/qS0kL3Rl3T4Cv42MrigwYFL4WVNtqmAE5orKZKfhwgGS2+4hYXYvRFJlyNe7Ws/wY+PmMFR5hH7QPaZuxeTeWIegPU5cNC/O3kU9+y6/O13bMxpf4sL6avgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742724350; c=relaxed/simple;
	bh=IQQ0I+qf4PSj7/evqzaZNlHOwP+DZpGNr9YDG/0plq8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IPXHJqwj+lLUUup8k7LMCYzWbenEbJx+IesqTchbVV0Noas+URPkWkbOIM7Bxh20tkM/82xHBuY/lQspqQ6wX8yPd7/JZmednVNtlyc4ts4ZQcdeR/4XxgiYiB6g4NuPsqnNHVUlrYhQ31oczsIrJmTnd7+eMAek/eLQPBRDCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=trUxb8yv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0782d787so24476305e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742724347; x=1743329147; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YKAwy13p4umJXNrNfzMbmLU7PrKHlTEsB0Qn9w54qg=;
        b=trUxb8yvhzCpGMWSY1Funtf+d2+e2BWOqskE8QVFml1Oc+zZmw7VHXQb3PUxdOYMLI
         Afa3tCm3MF3GkPQKkgJTT3qnp1kk0txqBHY4yzLDHhvaElEb+Pret9L2e5KXp9cGbPMk
         UXiyGY6nP5kKSGHNrCC8ElMEqjqHCptaDPpGqVviaDoLJ0KFm72xjZQUu+blhQyX5gDX
         gWb/9Z+Py5mXCkfnjdcWiqaW6Tsb6fIwzmIyrBHlrDaE3ybCpRgpaEhsGyPN/WxBF7BT
         30P7p37NzgMb0bolz2tjaWLcsDJzeBiHLEBcCwP8m0mRYwCpLhZwXNfcH9TDNd/wklN8
         yU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742724347; x=1743329147;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0YKAwy13p4umJXNrNfzMbmLU7PrKHlTEsB0Qn9w54qg=;
        b=vUAeCmyWnamG5tsqZQZiLFo3ybi/m2CKin9Ff3FAi3y3xzub8QENcPd74UMn1TCsgm
         6pUE/LV1Rvk6rLNn4W2QFrhxTrFJqQ9ENB3PkuOg/B1e09QqBbvN3QoXKRt3obvd1K8C
         pKu6eCLFZnoRKpL3L7ZA8MEbqQSBPBMAcgybnK2ockA93dnTq57nmfEV9FMgpkZnaR/9
         K82Vx5jRkuKuRyn1V58yPXZz3w8wKVah/ocBKDW0JOQ77oIy8lkVj7IDOtoJg8XCV2vu
         zUved81Bc7PGWsZwqPAfHOMrKzOOope25fXVVqvH+za2NF7gTdl77cpy+kxnXcXBSDhe
         Amyw==
X-Gm-Message-State: AOJu0YyffFeVsvhkYsrk/S8BKBSGHgFo9JUm5k8ilDh8rhl0b1N5y9Gl
	W3oOcD1EvS1iDZk78bvFuw/+9KJgQGC64GbsNO55TMhfERrsrXoszKVlt4Aer6o=
X-Gm-Gg: ASbGncu5K/w7KUJdO0XQ/ANqMszlU737POe18enkNDLuOnsYFzR/MArGkZ3EyKRW5QE
	82ryLMOsNYwREPbfCsfviEniUzp8/nfEMdqJIv6Av6tRcMAHtmVlAofppAnJ476uoLneZxXzwc7
	bqWn0kB32j+kEOPdyt8THk2dJqz3dL/y6tiYxaM/5v0uYpSXYVBEEYq4wlsBKWT0Lt2/JHITrHM
	r+njDA2qChG9M+dS5RDFQA10PB+WssQe9Zz/sRqyNy2EfgBQuDNl7xMbCgLQe5PY6mKhQ1/tui7
	aixaDatovGYFWZnAotRG7GH85BX652yPop4vJ8Lk1FmOEiO1ZGgXz/K33ZbE62M5zkeypzkOTF3
	zZETiMwWq
X-Google-Smtp-Source: AGHT+IFGd8TnoP6TIwshaaHynSR6cSRccCs9zdMY8LP/7vGR5dVuGRXYYOYLfvN7Rl8xWmBS+pV0yA==
X-Received: by 2002:a05:600c:83cf:b0:43d:22d9:4b8e with SMTP id 5b1f17b1804b1-43d509ec3famr103268275e9.10.1742724346687;
        Sun, 23 Mar 2025 03:05:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9a345fsm7285675f8f.24.2025.03.23.03.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 03:05:46 -0700 (PDT)
Message-ID: <57f79277-72c9-4597-a40b-d14e30d14c60@linaro.org>
Date: Sun, 23 Mar 2025 11:05:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
 Anindya Sundar Gayen <anindya.sg@samsung.com>,
 Fabrice GASNIER <fabrice.gasnier@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Nick Hu <nick.hu@sifive.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers changes for v6.15-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,

please consider the following changes since commit 
7eb172143d5508b4da468ed59ee857c6e5e01da6:

   Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

   git://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.15-rc1

for you to fetch changes up to 0f920690a82cc99ae08cab08bee2e5685b62fd04:

   dt-bindings: timer: Add SiFive CLINT2 (2025-03-23 10:55:43 +0100)

----------------------------------------------------------------
- Fixed indentation and style in DTS example in the DT bindings
   (Krzysztof Kozlowski)

- Added the samsung,exynos990-mct compatible binding (Igor Belwon)

- Added the samsung,exynos2200-mct-peris compatible binding (Ivaylo
   Ivanov)

- Fixed a comment spelling error in the exynos-mct driver (Anindya
   Sundar Gayen)

- Added the support for suspend / resume in the stm32-lptimer driver
   (Fabrice Gasnier)

- Fixed use of wakeup capable instead of init wakeup in the
   stm32-lptimer driver (Alexandre Torgue)

- Add SiFive CLINT2 DT bindings (Nick Hu)

----------------------------------------------------------------
Alexandre Torgue (1):
       clocksource/drivers/stm32-lptimer: Use wakeup capable instead of 
init wakeup

Anindya Sundar Gayen (1):
       clocksource/drivers/exynos_mct: Fixed a spelling error

Fabrice Gasnier (1):
       clocksource/drivers/stm32-lptimer: Add support for suspend / resume

Igor Belwon (1):
       dt-bindings: timer: exynos4210-mct: Add samsung,exynos990-mct 
compatible

Ivaylo Ivanov (1):
       dt-bindings: timer: exynos4210-mct: add 
samsung,exynos2200-mct-peris compatible

Krzysztof Kozlowski (1):
       dt-bindings: timer: Correct indentation and style in DTS example

Nick Hu (1):
       dt-bindings: timer: Add SiFive CLINT2

  .../devicetree/bindings/timer/arm,twd-timer.yaml   |  6 +--
  .../devicetree/bindings/timer/renesas,cmt.yaml     | 44 
+++++++++++-----------
  .../devicetree/bindings/timer/renesas,em-sti.yaml  | 10 ++---
  .../devicetree/bindings/timer/renesas,mtu2.yaml    | 14 +++----
  .../devicetree/bindings/timer/renesas,ostm.yaml    | 10 ++---
  .../devicetree/bindings/timer/renesas,tmu.yaml     | 22 +++++------
  .../devicetree/bindings/timer/renesas,tpu.yaml     |  8 ++--
  .../bindings/timer/samsung,exynos4210-mct.yaml     |  4 ++
  .../devicetree/bindings/timer/sifive,clint.yaml    | 24 +++++++++++-
  drivers/clocksource/exynos_mct.c                   |  2 +-
  drivers/clocksource/timer-stm32-lp.c               | 36 +++++++++++++++---
  11 files changed, 115 insertions(+), 65 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


