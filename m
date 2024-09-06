Return-Path: <linux-kernel+bounces-319262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6A96F9CE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359021F2539A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5891D47CE;
	Fri,  6 Sep 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iqinmev4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172B1CBE8C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642954; cv=none; b=Y76SZl8ylmUT3np1a+qsPBZjLay/fAKzJNq8Kb3y+3pheze4hDcWFv218JfUqFhOzsxiNfSGsQeL/E9McUhrV/eOyEr41ypAx6X+udFvZUe/3wpGl+0swdzx/BacYHefN285JCqcJMcMspgUj9YGwErgTd3ztezU2EA27KoMWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642954; c=relaxed/simple;
	bh=Gm4NAXQPSdgNUn+z7bxw9q/Kz8fIbNcCedpXsJ4i1b4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=rcOS6wqTMqIooDl2VTvj3ThSlhApwk3Ix2wbqSpZvPWpGcz2nUMZ7xOZ7AsFblO0LPqhX9bPXanlfgg4gUMhUeisrEo7GQIsFANy6Nw0erzEFbaBcCMRMcBc9OLpWms4DTd2mZqDsIS3XT6rqFuiYBEBzZTGoPUzqpM9euSDvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iqinmev4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42c828c8863so18436365e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725642951; x=1726247751; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IawqMe/GbGXjS+X2KFd8Q1O5CtFxJX4z2H7g3oGBFqQ=;
        b=Iqinmev4hU76kvReL8PupImXomNxQ9GQ9gdTgaZz2PFgpYu8dJcgqjGuz8IyrLLqLO
         b652QpNCH0e1G1B31T1EFnVw8GA7A++vUTOGi6COIj5QRdtAa+8NVdBFJqXKyNVt0E41
         5ikJDJtk+4R5XR6l93dVMHURAXaEr8LevWKl7oTM/p3UXlI7DLBXYpTL2GBPQAnnsLd1
         ZyD1MSkHepDvPwzfl1kJDu3XPSLpSCHe03y3/Cg/SVDcLo06Mdxjd3YI07lq6hlXwBu3
         0SdBSd7KG/VjYRxHEAIZgjWU90XM8AjX6HyubIyjjZJvWc1Ki7pPaGkeTOSCTae8+DP6
         3G4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725642951; x=1726247751;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IawqMe/GbGXjS+X2KFd8Q1O5CtFxJX4z2H7g3oGBFqQ=;
        b=Ma7/W08OwxFxYcLgFY3cm5cSde0o0+54mYYCWb02XnhOY9jAYcHE8GeZlBRuL9hdL+
         v99oPDaIkEp+LSwZsVvOmpjgpcSB5mjm/Yf6cHXNQ5Ddi9gbjBDNWBokAIixbkEZJDXO
         euXmJwJDvIHYkTMf40iS0IB5UYs4TBsb+rRpphDzW0hajdP9IlXUfQHbCTeHSRTMgSZ/
         FxUR9z8D1D4Qal3gBALqJTinJknDpdKGRAnNMR/NqMPmXSC76GJL/l09mmjG+BpL+jhB
         7dKi+jopiq0/mbc79oetJ6q+YYK4hPg2W678HkeXK7Dt0ySxqNxHO8rI/MlmhhkCTbEv
         I6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9+TrbkDzH69DbUeshfHjgOsz/UZvEBRN3WqZXoHXd+caznL2nKFLPXl1l4s951YHb0bIxiPGzUFT7KOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypOOqTdh+BY5aJHSftsv3WWinfSRkf1Kv9IsOv68n6ZmAl6t9v
	aO7kxKT53XmHMxbJjykBg1dq4YYsEaIEkEwumrGpELWQms+kFUTg4w9jAFwwx/A=
X-Google-Smtp-Source: AGHT+IFXcie6JWDnnZRnhGgH5Z6nsMxiZSEXTUHOubNLWIZVdCKzi4JkEzYod5+Q4AqL9HxmmeeLQg==
X-Received: by 2002:a05:600c:4715:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-42c9f9d6e77mr19856295e9.27.1725642950456;
        Fri, 06 Sep 2024 10:15:50 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ca0600651sm26552385e9.32.2024.09.06.10.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 10:15:50 -0700 (PDT)
Message-ID: <6054852d-975f-4e83-850e-815f263a40c5@linaro.org>
Date: Fri, 6 Sep 2024 19:15:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ankit Agrawal <agrawal.ag.ankit@gmail.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Gaosheng Cui <cuigaosheng1@huawei.com>, Marek Maslanka
 <mmaslanka@google.com>, Uros Bizjak <ubizjak@gmail.com>,
 Zhang Zekun <zhangzekun11@huawei.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timer drivers material for v6.12-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,

please consider pulling the new timer drivers material. This cycle 
mainly provided a few changes related to fixes and devm_* variant.

The following changes since commit 79f8b28e85f83563c86f528b91eff19c0c4d1177:

   timers: Annotate possible non critical data race of next_expiry 
(2024-09-04 11:57:56 +0200)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.12-rc1

for you to fetch changes up to 2376d871f8552aadea19f5bc0b1370db54a3a5f2:

   platform/x86:intel/pmc: Fix comment for the 
pmc_core_acpi_pm_timer_suspend_resume function (2024-09-06 14:49:21 +0200)

----------------------------------------------------------------
- Add the DT binding for the rk3576 compatible (Detlev Casanova)

- Use for_each_available_child_of_node_scoped() to remove the
   of_node_put() calls in the loop (Zhang Zekun)

- Add the ability to register external callbacks for suspend/resume on
   ACPI PM driver and enable to turn it off when suspended (Marek
   Maslanka)

- Use the devm_clk_get_enabled() variant on the ingenic timer (Huan
   Yang)

- Add missing iounmap() on errors in msm_dt_timer_init() (Ankit
   Agrawal)

- Add missing clk_disable_unprepare() in init routine error code path
   on the asm9260 and the cadence_ttc timers (Gaosheng Cui)

- Use request_percpu_irq() instead of request_irq() in order to fix a
   wrong address space access reported by sparse (Uros Bizjak)

- Fix comment format for the pmc_core_acpi_pm_timer_suspend_resume()
   function (Marek Maslanka)

----------------------------------------------------------------
Ankit Agrawal (1):
       clocksource/drivers/qcom: Add missing iounmap() on errors in 
msm_dt_timer_init()

Detlev Casanova (1):
       dt-bindings: timer: rockchip: Add rk3576 compatible

Gaosheng Cui (2):
       clocksource/drivers/asm9260: Add missing clk_disable_unprepare in 
asm9260_timer_init
       clocksource/drivers/cadence-ttc: Add missing 
clk_disable_unprepare in ttc_setup_clockevent

Huan Yang (1):
       clocksource/drivers/ingenic: Use devm_clk_get_enabled() helpers

Marek Maslanka (3):
       clocksource: acpi_pm: Add external callback for suspend/resume
       platform/x86:intel/pmc: Enable the ACPI PM Timer to be turned off 
when suspended
       platform/x86:intel/pmc: Fix comment for the 
pmc_core_acpi_pm_timer_suspend_resume function

Uros Bizjak (1):
       clocksource/drivers/jcore: Use request_percpu_irq()

Zhang Zekun (1):
       clocksource/drivers/arm_arch_timer: Using 
for_each_available_child_of_node_scoped()

  .../bindings/timer/rockchip,rk-timer.yaml          |  1 +
  drivers/clocksource/acpi_pm.c                      | 32 +++++++++++++++
  drivers/clocksource/arm_arch_timer.c               | 11 ++----
  drivers/clocksource/asm9260_timer.c                |  1 +
  drivers/clocksource/ingenic-ost.c                  |  7 +---
  drivers/clocksource/jcore-pit.c                    |  7 ++--
  drivers/clocksource/timer-cadence-ttc.c            |  6 ++-
  drivers/clocksource/timer-qcom.c                   |  7 +++-
  drivers/platform/x86/intel/pmc/adl.c               |  2 +
  drivers/platform/x86/intel/pmc/cnp.c               |  2 +
  drivers/platform/x86/intel/pmc/core.c              | 45 
++++++++++++++++++++++
  drivers/platform/x86/intel/pmc/core.h              |  8 ++++
  drivers/platform/x86/intel/pmc/icl.c               |  2 +
  drivers/platform/x86/intel/pmc/mtl.c               |  2 +
  drivers/platform/x86/intel/pmc/spt.c               |  2 +
  drivers/platform/x86/intel/pmc/tgl.c               |  2 +
  include/linux/acpi_pmtmr.h                         | 13 +++++++
  17 files changed, 129 insertions(+), 21 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

