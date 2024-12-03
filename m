Return-Path: <linux-kernel+bounces-429406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEFE9E1E08
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F602B282C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B191E47DE;
	Tue,  3 Dec 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJaBU//F"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCCC1E47C2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228034; cv=none; b=ca3MdK/t4AMiw1q0ysW7dc8+TWOkfLjdLxlN0Ao0aIdBJufyqQGXTxRh3Vqojw2d7gNpFYeGiFsbRFJIxts96WaB7KbXThNv48HZxFvfQ2xVcdaDExTCZ8jq4AFvRM9mJrsBc1viWvj/HKxmhcF8DSs5dOYKLMNCWQC2eGmoCgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228034; c=relaxed/simple;
	bh=ACKWQL0UkQUS7cOWEjRNwI1FfFj12bO7OxDuhVTv4KE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZWeRscKqQYtzWBvmKGaYkM0P+B3OfBzxceHLSDv5kxZOW9jlEnBY9W8O+89YAvsyEAOhUYWBTLMM0+L9iJQHVHt2ej+HgYP1m0kr2dVscM+qPtz+exi6qVNC1qVsRULuZhDnOhZDA+QoDM+cex9wCR66EZ4NOQx6ee+XOoikeNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iJaBU//F; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso900809566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733228031; x=1733832831; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+D27OUR16Cl4TWEJRos/7LAnM8aBb1wRGjF74GArkfA=;
        b=iJaBU//FeDPXTTN/bLEC/FYuS4UdJNU9LBIInxQ2hL9/uIPfaEEbPe6nrQSVsyxQzN
         S1CrogAScPi0v5ZoFgCNPO8qna9dHoSmu090XDuCyRuVuAvsPaXsnOqZTx1nJ2xEGavV
         p9XR0sQLmNscztj39ZcYPGDh8J7SLGmiUDbILRNxwID9qTSJeCxKA7QILxzbqzhbqb+k
         8U47/FRcBEP7pEFRfSUjDWCD9lEwl5gy7pxMZuM+869WnJY06gy7SX3M7bwxYzkXzUdi
         x5khK2CtaQdj8/AW7jXF4/yBZK44Cg52q31l+BrMdxEoKRIEQ9Q7j2nym+bspyJRophE
         JjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733228031; x=1733832831;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+D27OUR16Cl4TWEJRos/7LAnM8aBb1wRGjF74GArkfA=;
        b=kymN6jyC05WiKdJ7DpbxFDlyKPbBvJw5udR6cbo9K9cQuTIb/kIjDidILF5Ui1X1J9
         M+5KR4zfNfkYTTbpPPj4Vt4Wbgzk4+gSRSrcB9jyk6ndl262VTFzsdThRChsRKd1OKaY
         LC6g9b9SLM9OHC4OtehZ0kw80i8t8VsjZSRrNr2jlXF/Qk66HQw0J59jIJhrWqJWUJzc
         P10WRcjvjmmlZt8e3t5zBUNW4WcKHujWZJqMpFfTrb2lI72mmSqit60SsQWrmqi8/qrd
         D54EsbsJXtm2V+218l1CrBV8Wt2eXUfu+Ox+Ysh/GmL7ucGiEFp/M6TMLKKdNCGCAzQZ
         PNEg==
X-Forwarded-Encrypted: i=1; AJvYcCW+qX4xEjnJIbwr+1f3PRjF8zL4xYERSAJCjfPjpE55i5I/FCLav7JYoyDKupFzaNCMlhPtlG34gZMDY2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwYx8BbXxgJ/choq8FBj5OesAcX/U3IWBcP3KImS/E8mDHLrN
	U7rXsFFuBIuFfi5qvJXV07AmplC1nLNNBbDTtdKYXMz9ackts4bVYEeMtLZqhgI=
X-Gm-Gg: ASbGncs3Lyf2EluCackjuyTSISdZWPhT2i2APkGcQaLzTN6dCwSwKsi2nOqFAsJXt0T
	JBTe9j0UPzXR0U4XhDVwDowF2/lhVBTm0PoOvmS27uyjcyPnb/JHJTDQmxCuiWWiUIOpt2QlbVf
	6qEc9rMBd1bkcBg/gXzDKA48/3zLJAuVopRCQG1wNzNJTv7C2SUVzAp7NZwxZeLTHmVb3hhH3+q
	lkKhDFnFzVFlytxPeBqSW1bxppaS+ZJcmAt3NAdTk8XwV4GYj/kpJie0yKTXnbrkWZOCJgvKaiT
	A9Ac9NqYZLnXKWxhGVkxP7Y98lSMVAUnvw==
X-Google-Smtp-Source: AGHT+IG/LNiQRH1H/AD37FJTCdb/ukxG6+4AcIb4aIX7NrDNY7ETqg4yetmoSzQOoqOa1fQIjvYgLw==
X-Received: by 2002:a17:906:1daa:b0:aa5:1661:1949 with SMTP id a640c23a62f3a-aa5f7f2413dmr188219066b.40.1733228030629;
        Tue, 03 Dec 2024 04:13:50 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c245bsm607603766b.8.2024.12.03.04.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:13:50 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/8] USB31DRD phy updates for Google Tensor gs101
 (orientation & DWC3 rpm)
Date: Tue, 03 Dec 2024 12:13:48 +0000
Message-Id: <20241203-gs101-phy-lanes-orientation-phy-v2-0-40dcf1b7670d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPz1TmcC/42NQQqDMBBFryKz7pTMIFq76j2Ki2hGHZBEEpGKe
 PemnqDL9+H9d0CSqJLgWRwQZdOkwWfgWwH9ZP0oqC4zsOGSiGscExnCZdpxtl4Shqz71a7Zu1Z
 uHJu+co/SMeSXJcqgn6vwbjNPmtYQ9yu40W/9/3sjNEhdPfTCZVOZ7jWrtzHcQxyhPc/zC6gJ1
 QTPAAAA
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 stable@vger.kernel.org
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
Changes in v2:
- squash patches #2 and #3 from v1 to actually disallow
  orientation-switch on !gs101 (not just optional) (Conor)
- update bindings commit message to clarify that the intention for the
  driver is to work with old and new DTS (Conor)
- add cc-stable and fixes tags to power gating patch (Krzysztof)
- fix an #include and typo (Peter)
- Link to v1: https://lore.kernel.org/r/20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org

---
André Draszik (8):
      dt-bindings: phy: samsung,usb3-drd-phy: align to universal style
      dt-bindings: phy: samsung,usb3-drd-phy: gs101: require Type-C properties
      phy: exynos5-usbdrd: convert to dev_err_probe
      phy: exynos5-usbdrd: fix EDS distribution tuning (gs101)
      phy: exynos5-usbdrd: gs101: ensure power is gated to SS phy in phy_exit()
      phy: exynos5-usbdrd: gs101: configure SS lanes based on orientation
      phy: exynos5-usbdrd: subscribe to orientation notifier if required
      phy: exynos5-usbdrd: allow DWC3 runtime suspend with UDC bound (E850+)

 .../bindings/phy/samsung,usb3-drd-phy.yaml         |  24 +++
 drivers/phy/samsung/Kconfig                        |   1 +
 drivers/phy/samsung/phy-exynos5-usbdrd.c           | 223 ++++++++++++++++-----
 3 files changed, 202 insertions(+), 46 deletions(-)
---
base-commit: ed9a4ad6e5bd3a443e81446476718abebee47e82
change-id: 20241127-gs101-phy-lanes-orientation-phy-29d20c6d84d2

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


