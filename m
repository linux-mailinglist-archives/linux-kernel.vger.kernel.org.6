Return-Path: <linux-kernel+bounces-423355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F99DA649
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2EFB2245A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E0E1E0DFD;
	Wed, 27 Nov 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkeu19hm"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB401E0DD1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705095; cv=none; b=kdyC5+vntqZfZWUFiEbns3EmAfJQMD/Sqx9pTzF43KOQd5EvIOWusadCyrvveoQ/womKgqQ1TqSGVYXD19VP6Bv1LYF+tkFwjfQ3obsX9ZL/Al2sMDYpubAV3FsJsLVttr11Wgtm8Q8y2c5hBGhpK4Lcg/4LmDjyRERSeH8MimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705095; c=relaxed/simple;
	bh=+j4kL8jQakPtA0ubTOj6v20Lv2vxrklGu98FO81Id8M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Om0GH0MeN/6DBZuagQrwpqMCISYveluzjVsfI6wUKI2PnS5vD3AUrq8rp1T6wn5kv0BWDEO7w7d1U6mPEpRAVFKNd/DbmHViN1Hepa/AQ4Yz71k5Ucw0ymnNhh2Zf2p/MGYEvN9uQ09XbE+u+VvBj7pBvtb/p0j+Yxo4tn8/3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mkeu19hm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfd2978f95so9190566a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705092; x=1733309892; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FnSBghT1PQvjEoqKzE6lYaSFxfTQgIMEYx5M8qLoZaE=;
        b=mkeu19hmS+gux3BLo04TpsDfAFL0LGb4eHkl+1gW5IH4ynkT7r8geVypbIhc2ddrlF
         /tFzO6+EyBH2wekupHUIjtLNL6M28JQKV27/34Y9G3RU78ym4Izssn2DPYBohUMKcdrd
         G5iiZvkdHBejpeGD/l9nf2Gnwb7IUjtU3z7WuWuzzFUn66+xx83jqlwLLVhG4LrxJ8I5
         FGnuPJErpoB5VlZfsnz8zPeeWF9YInHDSX91yJ7K/8ZcPbQEmOHrMYXYrI8mFIRbth98
         WHzWGdZ/+dPnj/OnoczoRcLlbt4qETtBjtlZfgPTiRxJAth/CUIy+NtON5FTlXVxtOJe
         37ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705092; x=1733309892;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnSBghT1PQvjEoqKzE6lYaSFxfTQgIMEYx5M8qLoZaE=;
        b=kNE2Mupa8ayypIOO47nHwooOsuJwQmFp+j5rbVVU3Y0Vu83o5axa9RPjAoSNIRhshV
         sz5TT75oracb33vg2Y/91/+SRDVhM6JmNpj7aT5BFkkHhYcmdj3hkBudAMq13MjT+Qbo
         ZaMmODEDv1kSfoD4F4juvXxFr0BrB5X6kRYkoCWSdhO6lz0pgAGeEgCz+SmfZGociC/f
         1kcyoYVuyDSRokhk/Q6lM/DDC+BcrW5hshc/QwhCAohbGnbasS8P7G3vA4zxg4+e5eTJ
         GRlq6rxhowxQ/hEyUOL5+8QcdOzd2Jp05L+Nl0PjAVUxTCJD+sxRDv3NTzJPYLFIV+Ku
         fnDg==
X-Forwarded-Encrypted: i=1; AJvYcCV1b8ZbDHlXykMgDNm8Laso/RMKwtat9VjKZLmZ1A4+OicED+EcujgRYzpqIyij3ZxtXe0I0fvdpMrBSa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaIv0QM0AEGanLEgYVziUM9OXboMdIHVFrp2KJ23RCkaZqrhEN
	Cxiem1QB5heYSi4SM8MXHgGRL2NclHOLUh/PWvmQEr0jGL36f78zFHULKFR8f/0=
X-Gm-Gg: ASbGnctc1YNC8fY6InB1FIyK1uu5Aux17r5bMzhWiwTedniI1G+Jvexz3xZWX3ubty5
	oQ0RWGyKy2+BVPYr6Tx7sRirKHQ3c/8OS1ZF8uP6F6vOzfqBGqPGwTy2d5VpJ+rjMbWHqekuFhJ
	dwhG7F3sbj49+wEsHIwrTXVHs64QVWGQ0PgrRKLBHWlnqWo9Bx0hOruEEoY3+fqiiqF8tUQKs6Z
	pZg+EE6xb6/i4tE1jzbubbPcyEFB9vhUSb+Y8KEVMlqwU1zzF5h3RPexnnAIR/VVcU1gNBdcdIm
	z2kBukJp9oAGSoHaSm7v/+ViOS0t8tpibA==
X-Google-Smtp-Source: AGHT+IHtqYL91H6SMMvksK3ZTB/2Fzc9xaGKysfgcuXFtHMmqYC6TditIFw1AYITQuYQn85K2iSkAQ==
X-Received: by 2002:a17:906:1bb2:b0:aa2:c73:3720 with SMTP id a640c23a62f3a-aa58107846bmr200250766b.58.1732705092241;
        Wed, 27 Nov 2024 02:58:12 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54a6db906sm412183566b.41.2024.11.27.02.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:58:11 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/9] USB31DRD phy updates for Google Tensor gs101
 (orientation & DWC3 rpm)
Date: Wed, 27 Nov 2024 10:58:10 +0000
Message-Id: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEL7RmcC/x2NQQqDQAxFryJZG5iEoa1epbgYnFQDZZSJFEW8e
 4PL9+G9f4JJVTHomxOq/NR0KQ7UNjDOqUyCmp2BA0cifuJkFAjX+cBvKmK4uF62tLl3r9xlDuM
 jv2Jm8Mpa5aP7/fAerusPwzyMdXEAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Hi,

This series enables USB3 Type-C lane orientation detection and
configuration on platforms that support this (Google gs101), and it
also allows the DWC3 core to enter runtime suspend even when UDC is
active.

For lane orientation, this driver now optionally (based on DT)
subscribes to the TCPC's lane orientation notifier and remembers the
orientation to later be used during phy_init().

To enable DWC3 runtime suspend, the gadget needs to inform the core via
dwc3_gadget_interrupt() with event type == DWC3_DEVICE_EVENT_DISCONNECT
of a cable disconnect. For that to allow to happen, this driver
therefore needs to stop forcing the Vbus and bvalid signals to active
and instead change their state based on actual conditions. The same
TCPC notifier is used to detect this, and program the hardware
accordingly.

That signal state is based on advice given by Thinh in
https://lore.kernel.org/all/20240813230625.jgkatqstyhcmpezv@synopsys.com/

Both changes together now allow cable orientation detection to work, as
the DWC3 will now call phy_exit() on cable disconnect, and we can
reprogram the lane mux in phy_init().

On top of that, there are some small related cleanup patches.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (9):
      dt-bindings: phy: samsung,usb3-drd-phy: align to universal style
      dt-bindings: phy: samsung,usb3-drd-phy: add optional orientation-switch
      dt-bindings: phy: samsung,usb3-drd-phy: gs101: require Type-C properties
      phy: exynos5-usbdrd: convert to dev_err_probe
      phy: exynos5-usbdrd: fix EDS distribution tuning (gs101)
      phy: exynos5-usbdrd: gs101: ensure power is gated to SS phy in phy_exit()
      phy: exynos5-usbdrd: gs101: configure SS lanes based on orientation
      phy: exynos5-usbdrd: subscribe to orientation notifier if required
      phy: exynos5-usbdrd: allow DWC3 runtime suspend with UDC bound (E850+)

 .../bindings/phy/samsung,usb3-drd-phy.yaml         |  20 ++
 drivers/phy/samsung/Kconfig                        |   1 +
 drivers/phy/samsung/phy-exynos5-usbdrd.c           | 222 ++++++++++++++++-----
 3 files changed, 197 insertions(+), 46 deletions(-)
---
base-commit: ed9a4ad6e5bd3a443e81446476718abebee47e82
change-id: 20241127-gs101-phy-lanes-orientation-phy-29d20c6d84d2

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


