Return-Path: <linux-kernel+bounces-567042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567F2A6804A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDBD3B6AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B5212FB3;
	Tue, 18 Mar 2025 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tXJB/EAw"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8920FAAB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338851; cv=none; b=ZamixllQr27wfyOJL55XPHvNi7kA4QSCQzeu0VAzGWwrV9X4gf+y5whEtJURlrrOcLwlkC3ob0wSSW72p/pLY66vXUD9MQ2dWwLr/no6isHSJ5+tNGYXjb4OuT4SDB+O3Z0VaQC7ik46uwOaTXKqFwyrUdgx0SY/R3JbImcxsWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338851; c=relaxed/simple;
	bh=Ya379Ijr2ofj10+RRG61gqv1ZJJPtyVebxeOMcaN51U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aaJamqrdqiCCaYlSwU17uMimVDMJO3SW+bIuNoxEwuzCXRRRU/6BWV8n1VwMVapueScOlBzXzIDwg9CiFoN7qvfhncOaOT72Ev13whFgI3ZAvXPBLwEdWRLIj3oWN4Taa7axTNMsf+BmQzCq0lFn9F/hAavRDrkVNoHGlmKlBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tXJB/EAw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22403cbb47fso117390135ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338848; x=1742943648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYFuZAXLZfyhQ6Ofp04NHjTY3u72Upe1i27dNGQ4bgY=;
        b=tXJB/EAwlLWnvEMZ0+wcOO3OQ0yjxiGe1FiILgTu0OlX3ceTueTlTVfOifrYI7wASA
         K6tLlsOjZRn/Hx7/r13U7a1Ibm5gQbJQ0mvL54sG5X8U62CYpYS0eAX+/AwTPqBywKpr
         bKS6YixmG9xxObsnhQzNEU2zwesBpNbPnOm0GLge0uRleYGl5dRTBFJkvim7UvE5CVLC
         6EG63NvRnZ6eKBVtDgdf6Sa+uiHtN9ix4lZqOWxl3iP3jYjheNoQ3WvQDNLaTpp9gJq+
         WTik6WkiFvnvRRGTc+ikLeCK3Pbduv25FJ/81NgghjZlvD1NalrcY/OgFAkDNEE7/EcZ
         frJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338848; x=1742943648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYFuZAXLZfyhQ6Ofp04NHjTY3u72Upe1i27dNGQ4bgY=;
        b=qOxTfRSqVODXHwy+XiyKJzT7TLMiVqOaXBAd6C0RUQMZeMemxIDh21aZ0Zof3QPnbJ
         VMKfEVrHSpTkWbLPTx75T7GwQGYLLrQ5au/8Rvx/6KFXXI1z4Iq6fjFOUDK3HDO3azSf
         DQmQnXfFbM4AFpGDmbKFkSim4GoeIkf7R6FVU/KspbUhbPGobmlOw5/DS2SrARqFRRvr
         CZMNxyUhC20eDIrrXbFrmK9Vd1vWOb/Aq94Y0oKhKPI/X9uSY+D+7BUfM3sgbaTIWzS9
         9FGbNwXNooa6fIjFLKnzGHmL10w79+KkToB0WzuamwhDL5oxn9DaoRIszT6djntcqMZZ
         yYOw==
X-Forwarded-Encrypted: i=1; AJvYcCXCd/RdM6hA4sKCiDFv/5tOAUZbXOh34O4VEag/nv4uGd4/Zlgkj8Qm71uw7sF0HCwUuURihb/ygUXrvIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5wX1fxs9kDMEBPa4Nim3naecqdtbdh635ZPSh9eMUs68/g2G
	NmuX9Wfrm+Q4gIsPbAzDxQSRcCHII91f/aimbjGBEUZtim73XPqkc3z4BkWfLU4=
X-Gm-Gg: ASbGncvds2SVzsWYc/8j1Vuf6qcsQFPemVi1rlzo5M1Uo8xX/W2BAZTCBNC6eUlxCfc
	lO7dnJTghdLiUukrEL2+E0xirdbujB3fenYfKQIWPcAy+62/gk90E3RFekuUFsZh0ICpNL0XvpL
	QRSxkiEOxj80P65u8RIKhXuBUMbQa1FxkQuLC7HOO50Fq7ykMM35aP4gRQervSfEg6D+y/2I2U4
	nbAohF7cY+eqncQxdTW1iFPmdbnNCP187sOTeBJeR8uPMZFxYBCWiH+mNLTms+RB/om2ZCDX/LN
	KvhlZj0sI0OmjQGC/umLR0lgp5A5NYx7pDugZCyHEZekBmsI1x8k6OID/uLjJTYJA083UDwteqV
	ja89FdFk=
X-Google-Smtp-Source: AGHT+IFTfJJcr07mnjzLqCop80WxhC5Pssj38zY+A8XR2rKWIc2cYcEXx8f4iEqqmQsjWdqm+Dpo5Q==
X-Received: by 2002:a17:902:d2c6:b0:215:acb3:3786 with SMTP id d9443c01a7336-2264993661fmr6691435ad.19.1742338847956;
        Tue, 18 Mar 2025 16:00:47 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f14sm100739465ad.111.2025.03.18.16.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:00:47 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>,
	Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Bajjuri Praneeth <praneeth@ti.com>,
	Raghavendra Vignesh <vigneshr@ti.com>,
	Bin Liu <b-liu@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/4] PM: TI: AM335x: PM STANDBY fixes
Date: Tue, 18 Mar 2025 16:00:38 -0700
Message-Id: <20250318230042.3138542-1-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes the Power management issues on TI's am335x soc.

on AM335x, the wakeup doesn't work in the case of STANDBY.

1. Since CM3 PM FW [1](ti-v4.1.y) doesn't enable l4ls clockdomain upon
wakeup, it fails to wakeup the MPU.
To fix this, don't turn off the l4ls clk domain in the STANDBY transition
in MPU.

2. Also Per AM335x TRM [2](section 8.1.4.3 Power mode), in case of STANDBY,
PER domain should be ON. So fix PER power domain handling for 
standby. l4ls is a part of the PER domain.

Since we are not turning off the l4ls clockdomain on STANDBY in MPU,
PER power domain would remain ON. But still, explicitly handle this
to be in sync with the STANDBY requirement.

3. On am335x evm[1], UART0 - (UART1-HW) has a wakeup capability.
Set the wakeup-source property in DT for AM335x.

4. Enable PM configs for AM335x.

[1] https://git.ti.com/cgit/processor-firmware/ti-amx3-cm3-pm-firmware/
[2] https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
[3] https://www.ti.com/tool/TMDXEVM3358

Test log:
https://gist.github.com/sukrutb/bdbfd1220fe8578a9decf87d0bac6796

Sukrut Bellary (4):
  ARM: OMAP2+: Fix l4ls clk domain handling in STANDBY
  pmdomain: ti: Fix STANDBY handling of PER power domain
  ARM: dts: am335x: Set wakeup-source for UART0
  ARM: multi_v7_defconfig: Enable am335x PM configs

 arch/arm/boot/dts/ti/omap/am335x-evm.dts    |  2 +-
 arch/arm/configs/multi_v7_defconfig         |  5 +++++
 arch/arm/mach-omap2/clockdomain.h           |  1 +
 arch/arm/mach-omap2/clockdomains33xx_data.c |  2 +-
 arch/arm/mach-omap2/cm33xx.c                | 14 +++++++++++++-
 drivers/pmdomain/ti/omap_prm.c              |  8 ++++++--
 6 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.34.1


