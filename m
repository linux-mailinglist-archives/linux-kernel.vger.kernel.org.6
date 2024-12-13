Return-Path: <linux-kernel+bounces-445198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E39F1298
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C020163C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADECA1F12E8;
	Fri, 13 Dec 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOH0KNWX"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0041E47AD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108320; cv=none; b=gYAcjXRvqPPaqrzL4zErXBiXOhVNqggT9rktn1KkoPlabfhF9nnSqN8s2/hBWiwnE9L6764gpdkMvKEJAHrPsZHFd4IqIkjnU0//kOWr90NZDns/cU/argphkJ84OPNi2JbmprlPLEsaLXoiDUGq3NKxHPuAV3Be7j76oDml1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108320; c=relaxed/simple;
	bh=2o7v5L9OD4+jL7eoS1HSAH1rlsefrFIImLxiX+uatp0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LpPWTs6FWbOlC+14Aqab5TIxYcxkBFeT+StxkiVc+WrCjqqXn1bZ5ES/747TCUaQ7UQGArPvoWiSkeYgSAO4i0zOHYfxfdk8FGrVhOrUWBY0Uh8r3jGqqZMjpEaG8XoRhFALgXwPyi6oPsDxurk/FYC6xSN0ttaz1T7inIrZWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOH0KNWX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436202dd730so14393985e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734108316; x=1734713116; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2A0DSQsBZCyHCjJuq/xQMDgQGYmtUN7RbB1oPXeNuw=;
        b=cOH0KNWXDRdECImKQsGB7lnWPKBocD9QJ41fMcP3iHKTpUJtQdKbNAr1dKznCubaGc
         GoUN/UaOO1OnlaWMA6e5kfRxTQ6K3lnJGnigu45idk2gtETEylkaKeWFJH3RC5+xBTu/
         pLI4pMI3PGZcoKfFNrNBpDkwh2nB/E3WdtVZtPLPx1Ka1DQNqI7zpcjYoegPPppFtKl5
         4d4/EafYgn1HnI6qLYME15uUH+/2TNe99r+q+CGmKxlO2c9jCxTL+qrBPl4L4zoChEFp
         /DLktYL/aQmVDMmdQj4JpIr6PkMez/XlLNZMkUBvkfygU2dy1B9eZ3tj/AuBN52agLCJ
         EqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734108316; x=1734713116;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2A0DSQsBZCyHCjJuq/xQMDgQGYmtUN7RbB1oPXeNuw=;
        b=GUTMPq9RM3MEdbE16+N/zNEpoAmVMAtNG4WIBtHXtVdjNerSptBy2dNxpuxP6Q7wEG
         T51s6M0uvaVmLahCdZ6MkFF31538VDUlcZI6j236UCHPoENpkacclr0VuYWzZg+BD6jI
         //TzN0GcaXo05sd2F/Df3UDg691uCHgyYaCR3befPxmj5DalLR7YbsCwnzmV96sSvelB
         fguSYJfa8h7pnlPEJPO4pOSXa4s+RR2XdGZnTpVUhSfq2iXAYkwn1QrL6RwgxExYr/QS
         lZIKmrpJ0p5Y7i6wzUsayBw0d8oGXWfgtfXpLDaZUkT1vh3wkcPgugl8AR6D1HuyxfCF
         E/9A==
X-Forwarded-Encrypted: i=1; AJvYcCVaw0w1LQj2rbcqRR/1Yn5N+B8PwVr3QWuHuHp2fUmC3AzBQgNKe0+5EJP5HbpUQhm+4gRHSL4FE/+Suxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHbK8GaPtpgK/giARnOk2zwH+2fZaChDM0vgZRyEc4VjRn678
	HDb5+uuT8FqOSxqLnLjWV7U9RMFb0XqicVCpfJO/Bby1+WfW+bf+4nYQ7yhboc4=
X-Gm-Gg: ASbGncuE33biwxGHErKr7A1FGNTVD/QEjJkSu2UunaGUtjlcWULznsudovQgzyAY7Xf
	jMnFKrZNkD1BiYoetw43XeFIHlxkW9h/v+UPWuJUbuwp0loyAs+pDe9MIBUL8qnvRiIYOblskdE
	No0/DP/Ih7MY+PcC2gF4PFIkvb94abVw3FFcm0PD1mKehBVZ8XTQMAUOD0AIPxJmUzBNvCkulFU
	rQ6r5FQxYWp+L3CaWwF1HE4Ezx3z3aTdYnA3oLyklFHe6z2lBitIlAeA1zC+kKmQvwOvNwU4avo
	Dw+vaUQEvQ==
X-Google-Smtp-Source: AGHT+IHZJ2di20HJpkRNIWKJIeFs0CuIRmOYxZ3U2nkyoSYzcTlosFGe1cGxVE2LTdjgH6l8IIepXw==
X-Received: by 2002:a05:600c:1907:b0:434:fbd5:2f0a with SMTP id 5b1f17b1804b1-4362aa425edmr34728655e9.9.1734108316537;
        Fri, 13 Dec 2024 08:45:16 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.66.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625550523sm53900665e9.7.2024.12.13.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 08:45:16 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 0/4] Fix Google Tensor GS101 CPU hotplug support
Date: Fri, 13 Dec 2024 16:44:37 +0000
Message-Id: <20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-0-c72978f63713@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVkXGcC/x3MQQrCMBBA0auUWTvQiSmiVxEXMZmmA5qETFOE0
 rsbunx8+DsoV2GFx7BD5U1UcuqgywB+cSkySugGMxpLhq7oc1qrvLFE9KXhktfyaRG1aeEUTHV
 fnOXHihshzTcXrLfTfSTox1L5bH34fB3HH1sgkqd9AAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=2o7v5L9OD4+jL7eoS1HSAH1rlsefrFIImLxiX+uatp0=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnXGSZfuIaCNB2a/OJnzHqAuOiyM2etUNKYbV+0
 C/C0x0YvVOJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ1xkmQAKCRDO6LjWAjRy
 utWQD/0eoK8RIO7nrEuBMHD793BwLl1lcBfzxKcA9w4q1BUI16yVBb7izZ+8E1TOcgPHzyqn3vk
 MHWJragitUXibjNIbh/tM4xdc5ko1jL7n1wBE1R5GP83D4W/2jY63oZPrFFqy88ZfcQICn2taf2
 0erNKDBTc3ZODWaBgKur/vBgXYLrooFG437jik6CrF4W6DUiEakoixuIsJZm7aIwM1IwAFRlI3z
 pXnvhqcODqJb2YkNQ/isDehKftaZ/ySujrP63gBeNaRK3yC+q93FPW5O7jDgkNifUHFra2hRpyx
 a/fHHACO7K9u0qN444AAWlHb2hsffq+rOQ41zZLjKDRqazYlczaeANiZHJAfa9dDu58vKtvTkK1
 Lpc7miIhQUtZBm7ouSPh+d8lLf/MZrmjH1fcjJWsLYmG1dG3HpiS3kS8IOwP4pe0VWUuJbqw/DR
 E3ULI6jeJJDgR30BFajfgKAjfY2hazulsFGQR0mtYWajbCiDcEPd9EqXodXGgrQJzgqHGWJ6ISe
 YfN7BJy0AcIBVl2E+2dSLASGVc2g7geepJ1p+5goRuSH/5lYCBbDxIJ4nFRGy3QZZpsksHjCZkC
 FGd7x3ogt55av0XRgo8zX+Qrk2IWfKFRj5+uTr+T/esi88NPkNKMkeLEvQcxwVyUESBgV1AiMz6
 JPYxpWDGm9hdv1w==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Hi folks,

As part of an effort to make suspend to RAM functional upstream on
Pixel 6 I noticed that CPU hotplug leads to a system hang.

After debugging and comparing with downstream drivers it became clear
that some extra register writes are required to make CPU hotplug
functional on these older devices which use the el3mon firmware.

This series adds support for programming the CPU_INFORM register hint
required by the firmware and also adds support for the pmu-intr-gen
register region. This is achieved using cpuhp_setup_state() to setup
a cpu hotplug state. This is similar to soc/xilinx/xlnx_event_manager.c
and soc/fsl/qbman/bman_portal.c drivers.

With these changes CPU hotplug is now functional :)

It can be tested with commands such as

echo 0 > /sys/devices/system/cpu/cpu6/online
echo 1 > /sys/devices/system/cpu/cpu6/online
[   15.880597][    T0] Detected PIPT I-cache on CPU6
[   15.880638][    T0] GICv3: CPU6: found redistributor 600 region 0:0x0000000010500000
[   15.880685][    T0] CPU6: Booted secondary processor 0x0000000600 [0x411fd440]

This would (prior to this series) hang the system.

Note 1: It is highly likely that similar changes are required for other
Exynos based SoCs using el3mon. For anyone following along who is
accustomed to looking at downstream Exynos based drivers this replaces
register writes defined in 

drivers/soc/<google|samsung>/cal-if/<socname>/flexpmu_cal_cpu_<socname>.h

Which are used by files in the cal-if folder and exynos-cpupm.c driver.

For the moment I've used the GS101 CPU inform register offsets directly
but these can be moved to driver data once we've established other SoCs
benefit from this.

Note 2: To ensure older DTs which don't define pmu-intr-gen register
region still work. The driver only issues a warning if the registers
can't be mapped, and the behaviour remains the same as today (system
boots, but CPU hotplug will not be functional).

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Peter Griffin (4):
      dt-bindings: soc: samsung: exynos-pmu: gs101: add pmu-intr-gen reg region
      dt-bindings: mfd: syscon: allow two reg regions for gs101-pmu
      arm64: dts: exynos: gs101: add pmu-intr-gen regs to the PMU node
      soc: samsung: exynos-pmu: enable CPU hotplug support for gs101

 .../devicetree/bindings/mfd/syscon-common.yaml     | 10 +++
 .../bindings/soc/samsung/exynos-pmu.yaml           | 29 ++++++++-
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  4 +-
 drivers/soc/samsung/exynos-pmu.c                   | 73 +++++++++++++++++++++-
 drivers/soc/samsung/exynos-pmu.h                   |  1 +
 include/linux/soc/samsung/exynos-regs-pmu.h        | 11 ++++
 6 files changed, 125 insertions(+), 3 deletions(-)
---
base-commit: ed9a4ad6e5bd3a443e81446476718abebee47e82
change-id: 20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-1f7ad4c45901

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


