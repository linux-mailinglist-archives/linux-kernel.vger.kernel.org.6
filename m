Return-Path: <linux-kernel+bounces-435311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D089E75FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810D216C3FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B551F4E36;
	Fri,  6 Dec 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNZ0Dq4P"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625421F18DE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502666; cv=none; b=IJ3YDK20OyGA7AYAn8r0M1w76pq/hyjIr1KbHUSnXJzq5/8NKkc9BGIUkcBscmTOzFND3loeZ847Psut6PP1/SZsmribgU5bDNUvnAbHnF4pCAMVf+Ab4e+mnN5yw7NNcD3WBrqgFxNLu3FUFpzFz6DQXiT9fp8WmPJVA66a/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502666; c=relaxed/simple;
	bh=GtJoFybvFh6AbrC9O+Fzs8cMuNJZ+3NTaYZfoyrNIV4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JDIYuuP5K8/eq+V9hJ4uesR6HLGi62QpHCeJ00nOaMMsSaLVyiigtzzH98nByPkyT6jVAzNEyM4SomJsm16NMl8kbhBLLAgS/JqhuI5WU+5u9RWgqLqyhjBkhWCJSfSHVxzM5EaOPiIWR0n+98bUFo6b74hEs/nWFiW3Gw5yzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NNZ0Dq4P; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa5325af6a0so356917866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733502662; x=1734107462; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7nSjvUx63MADVpt7oEUea+FY7rhNfLzD9bh4ADhfVg=;
        b=NNZ0Dq4PBde1CYREkSzdmPUnZQ9apG3wAr/aao1jt4wjCWpeswCYV4MtwK1CeBrViT
         QqUVCYgRmYQIvjIOZlYpOdYmUViD5AI4tYE79H7KE787Y0gUmrG+Qm5aJ3O30Rj3IzxS
         AP9JHHtcR/fJVucgV+kqighH5mvgQzXucKOArA+FbY9HRN4YN4JH1CpH38jaYhypFMgR
         yVyoStUdytZExi1I4A95TZfIj39twV6FUosh1S/nyKytQcWw2vngHc91LmpzXC0LQbpr
         KfQft6ZiaJYohfblszXb/L81nizKpk8lJ+DAnBHeEPfINPqZuME+6TE0t6BBExqQWQw4
         H6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502662; x=1734107462;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7nSjvUx63MADVpt7oEUea+FY7rhNfLzD9bh4ADhfVg=;
        b=WBwO1R0AHJDjMPDIO5g9/TH35i264xi/HGzdmbtoVCGy2RJ9M5cJPZau3vLaf0Xzis
         rTzw1MhjBjtXTTtrUe9Lxu7V+D4xW+iDukjsusAj5TmZX4aDnMDL5IL+CcRrgF5fUshf
         CCmwLJ/Rko5867m0dW8OwM/xaKJU7HxnWM//dg2LhG20NFfdwF8udb3Ai+YyZt8RhSz4
         K8/UvaJGuoEpAXoPyiqGNOn3tvY0UvfyRl9EM90cgI7IJFQ2iLqjsV9RdtKEaXwHCN6Q
         HL2CyzxS6V6is5ll8tOdw7LdjWOJN3Y7QPTJDv3DhFUxwtRY3up8iRayuTY9/MBjT9S8
         8IFg==
X-Forwarded-Encrypted: i=1; AJvYcCXUUTdyHizCGcVM6ITnjrypeElO8ZYzQNXmnnLpT0nBXHN+F4zwS/I7rQuNH+3MaDbe8zQyrdp9LDlFQ5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKUDPaBOsbB6VUkVz4c0mB/Qa0lJtqx/iH0Lf28RgTDOdkRV+
	xAC/6B8qa/i3Xw6GQOF7xyd7j8vbilCpn8uCq+R+6amo2jm1jY1tIMKvBXNYvsY=
X-Gm-Gg: ASbGncu9lqdeN5LejmDgkGY36ceXDgqDO79xOi64rYT0tvQHRWt0Tvz8ji24cE1gfyk
	4F0WxBGu2GIi3Eok6lF8Wg1U1psgFDD01ncRAwaDsz95l/NbGsFF8u2qXAqRzSLHnP1VGcXne+q
	xOQ3VOAN/R2JoWGwCrXd603KShN4B2zdWMAtqkiY19IWKQwsoEX+WLDvTZ6GEOc1w3qeAQLVq4O
	vNNDrsIXW63I9EVfMBu4ShrBbIr01ITZD7ZjAGmdCN3rO4znZa3E3sKs+cuIK3vNjgmjCCnrbrz
	Mi9vcf1hsbt/3pSU2EOladyVAMmqiG8iXQ==
X-Google-Smtp-Source: AGHT+IG5YohV/4iJ4GCzEmX7QvPbyvRE1dHLvIsPCNB971me4/Bxko7NAtS9jjY0kEtDTyMZljoJ8A==
X-Received: by 2002:a17:907:770d:b0:aa6:23ba:d8c4 with SMTP id a640c23a62f3a-aa639fb1a24mr339321566b.4.1733502661682;
        Fri, 06 Dec 2024 08:31:01 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e8af8sm257710266b.191.2024.12.06.08.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:31:01 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v4 0/7] USB31DRD phy updates for Google Tensor gs101
 (orientation & DWC3 rpm)
Date: Fri, 06 Dec 2024 16:31:00 +0000
Message-Id: <20241206-gs101-phy-lanes-orientation-phy-v4-0-f5961268b149@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMQmU2cC/43NQQ6CMBQE0KuYrq3p/1QqrryHcQG0hSakJS0hE
 sLd/bBR4wKXM8m8mVky0ZnEroeZRTO65IKnII8HVrelbwx3mjJDgRIAFW8SCOB9O/Gu9CbxQHM
 /lAPtthYLjaLO9UVqZKT00Vj33B7uD8qtS0OI03Y4wtr+b4/ABYdK2dqgLHJR3TrnyxhOITZsx
 Ud8gyiyfRAJlELXltRcCf0DZp/geR/MCMzQKoTKaITiC1yW5QUJoFYgcQEAAA==
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Changes in v4:
- separate out patch 5 'phy: exynos5-usbdrd: gs101: ensure power is
  gated to SS phy in phy_exit()' from this series, as a stable patch
  shouldn't be buried inside a series like this (Greg)
  Link: https://lore.kernel.org/all/20241205-gs101-usb-phy-fix-v4-1-0278809fb810@linaro.org/
- Link to v3: https://lore.kernel.org/r/20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org

Changes in v3:
- patches 1 & 2: update as per Rob's suggestions
- patch 7 & 8: drop init to -1 of phy_drd->orientation (Vinod)
- patch 7: avoid an #ifdef 
- Link to v2: https://lore.kernel.org/r/20241203-gs101-phy-lanes-orientation-phy-v2-0-40dcf1b7670d@linaro.org

Changes in v2:
- squash patches #2 and #3 from v1 to actually disallow
  orientation-switch on !gs101 (not just optional) (Conor)
- update bindings commit message to clarify that the intention for the
  driver is to work with old and new DTS (Conor)
- add cc-stable and fixes tags to power gating patch (Krzysztof)
- fix an #include and typo (Peter)
- Link to v1: https://lore.kernel.org/r/20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org

---
André Draszik (7):
      dt-bindings: phy: samsung,usb3-drd-phy: add blank lines between DT properties
      dt-bindings: phy: samsung,usb3-drd-phy: gs101: require Type-C properties
      phy: exynos5-usbdrd: convert to dev_err_probe
      phy: exynos5-usbdrd: fix EDS distribution tuning (gs101)
      phy: exynos5-usbdrd: gs101: configure SS lanes based on orientation
      phy: exynos5-usbdrd: subscribe to orientation notifier if required
      phy: exynos5-usbdrd: allow DWC3 runtime suspend with UDC bound (E850+)

 .../bindings/phy/samsung,usb3-drd-phy.yaml         |  21 ++-
 drivers/phy/samsung/Kconfig                        |   1 +
 drivers/phy/samsung/phy-exynos5-usbdrd.c           | 202 ++++++++++++++++-----
 3 files changed, 182 insertions(+), 42 deletions(-)
---
base-commit: c245a7a79602ccbee780c004c1e4abcda66aec32
change-id: 20241127-gs101-phy-lanes-orientation-phy-29d20c6d84d2

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


