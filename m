Return-Path: <linux-kernel+bounces-193478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B42728D2CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03935B2420C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02F915CD66;
	Wed, 29 May 2024 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VMewratf"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD015A865
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962285; cv=none; b=KZeFLjE/WaNS4mftjcWlRBn/5t5X2+Q9rSzQApaLZ5PnKYyudsPo7hV2umUshUHgqezIYa8zPC1ZoeUAkYlCKD2Mj0Ux7eeCfjjyCeDsn+Wy8qTlPMnAyZhd/qRCBW7wZ4+reP4E8MklYwahord5Wi2gwY3qQ5gIOMPEYL37Kuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962285; c=relaxed/simple;
	bh=gD/PJ6MuVDFwyaeynPCnoxOi6c4HUNfJeNMrEukphYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nG5HKlsDAGRVxDrXX9HDSYqpIPWVKSkDAI/1zR3h3ZP76bPZ0BM4lDVTLh29cJvLalTntI9Z8dOaapeL73H6WmdT2hPxjwqCKccBcxFd6OHRXTkBdJ+jMZrut83aHzANUNVJxrlWcMyicEYMyWpZZ0pcU8qNfa2MjyPd9ss4O04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VMewratf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-420180b58c5so14526445e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716962282; x=1717567082; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hppWw3qKG50anKzk4FPv6N0n8i7i4RwwGHwsQsP3nDM=;
        b=VMewratfRq6JS2iYhkQjeHu8LHFoQA6xS+dIBzn2SLMNbeNEjP/vQDqcK79fkx54f7
         4k+JiduoJxFD55ylpHBfauQLFnAHEV2nfTY/dcB6g8CLFuTJEoaJE/cUKNUkrtmP4mFi
         4NYM8FY1XKfyR0BCMYgielC4ojJiMFHM+qpJBxFO1Ha9H7ysGOXRIXjS8vmVp+o72QxN
         Rkx2qQmobPop8hRDJLp7eo48XY2wpgoQsC6mBMYCB/OUUu21Lq6rhn33drJIDBsLkSPg
         JF5HWb54jUrxEzycTow5PXhMG2nMuDsGU6SMJXbbIJL7c1lRIcQzAtzQWszDK+nRKoE8
         AA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716962282; x=1717567082;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hppWw3qKG50anKzk4FPv6N0n8i7i4RwwGHwsQsP3nDM=;
        b=iG5UUiRxL+yIC48/Rp1mUVQTtvVJwNTSR9AQgMkWCXP2DvCdbfa1MyXYVQvcKkgSm6
         WJkhREisejEHw5/o/reQiSHanLK8Tw0w9epG5ZFtdEaeJscqboeaSAVErBeyjxFGjgX9
         QAtO+iV4v7+bInW0cI/k42jCJVLoh/CjmBDch71D0MkoLcHk6RXiAm/shXgqj7ELW3ey
         fgOQWL4epaieOVUTall6CECkTPAAfJNmUq4AfsCx4d6xO6OwIjWr7IVRF/w5wCZP8u//
         ISgH6hngZtWddP8lWWbJ+jV5AxWyrn3V+1kP8Ot8LhRSW/D4C3D1NCqK0tRRKeIWFJRp
         iQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiW/6NhOOAezL7OFO5aG+3Ad5nkEn2tYvfIvGH5ZR4+rJAF/VSQQKZ9QtGOFPRiq4PBixxhNOJnjMbTV9aP/naK6dD0reArOZGRj1a
X-Gm-Message-State: AOJu0YxlfYkRFhCVzxfPohowaX+H/wDQxeaHGZ5DNLwQtNzXtDBcPcnN
	+3AdttGYWQm2T0ZB5N+Q8P32tg6TpjdOYdyStYwueF3cl2MplJDJ39z1L9mzGDM=
X-Google-Smtp-Source: AGHT+IHVRqh3fwdmfS9SnJtxUCheN0eF6Bwow3iBM+UuBhpaZuRXURaYXNel/mNlFRK2OrKtThAnvw==
X-Received: by 2002:a7b:cbd0:0:b0:420:1284:475 with SMTP id 5b1f17b1804b1-421089cd413mr115076715e9.12.1716962281574;
        Tue, 28 May 2024 22:58:01 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896676bsm169075435e9.4.2024.05.28.22.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 22:58:00 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v6 0/6] Mediatek thermal sensor driver support for MT8186
 and MT8188
Date: Wed, 29 May 2024 07:57:55 +0200
Message-Id: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPDVmYC/3XNSwrDIBCA4asE17WoVWO66j1KF2omjTSPoiIJI
 XevCRRKIbv5B+abBQXwDgK6FgvykFxw45BDngpkWz08Abs6N2KEcSIYwX184diC73WXZ0XVhOs
 YHAarL6VqKiM1Qfn67aFx0y7fH7lbF+Lo5/1R4tv2a9JDM3FMsKkogCwVp9TejJ47Zzyc7dijj
 U3il+LHlMiUkI0SZaUYgfKPWtf1A0PIaroMAQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716962279; l=3802;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=gD/PJ6MuVDFwyaeynPCnoxOi6c4HUNfJeNMrEukphYE=;
 b=nDzYAwEDpx0c9hRfOAq5XwkrlJuGVpfcUvab8uKv4mHH58zFeLfseR8VqQZo5+m+Ka74jj+1U
 EYdwrnFQnIVC+aFnqGH7Z8WQzMSEdG8wIApOliIJ+TgtQK3LeEjUtYF
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This is a bunch of patches to support the MT8186 and MT8188 thermal
sensor configurations.

Since the patches of v3 were applied except those related to the SoC
device trees, this series includes mainly patches for 'mt8186.dtsi'
and 'mt8188.dtsi'. Due to some thermal zone renaming in these 2 device
trees, the related definitions were also renamed in the dt-bindings and
in the driver.

Because of the GPU thermal zone, this series must be applied on top of [1].

[1] https://lore.kernel.org/all/20240527093908.97574-1-angelogioacchino.delregno@collabora.com/

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Nicolas Pitre <npitre@baylibre.com>
To: Rafael J. Wysocki <rafael@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Julien Panis <jpanis@baylibre.com>

Changes in v6:
- Reorganize patches related to thermal zone renaming (dt-bindings + driver).
- Add cooling-cells property to GPU node in 'mt8188.dtsi'
- Link to v5: https://lore.kernel.org/r/20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com

Changes in v5:
- Rename some thermal zones
  (mfg -> gpu / soc1 -> adsp / soc2 -> vdo / soc3 -> infra).
- Add cooling-device for GPUs.
- Link to v4: https://lore.kernel.org/r/20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com

Changes in v4:
- Fix wrong thermal zone names.
- Lower 'polling-delay-passive' values.
- Set 'hysteresis' value to 0 for 'critical' trips.
- Add a 'hot' trip point in between 'passive' and 'critical' trips.
- Link to v3: https://lore.kernel.org/all/20240402032729.2736685-1-nico@fluxnic.net/

Changes in v3:
- use meaningful name for binding index definitions
- reuse LVTS_COEFF_*_MT7988 on MT8186 per reviewer request
- do similarly for MT8188 that now reuses LVTS_COEFF_*_MT8195
- use thermal zone names the svs driver wants
- adjust some DT node names and iospace length
- remove variable .hw_tshut_temp as it is constant across all SOCs
- Link to v2: https://lore.kernel.org/all/20240318212428.3843952-1-nico@fluxnic.net/

Changes in v2:
- renamed CPU cluster thermal zones in DT
- fixed logic to cope with empty controller slots at the beginning
- isolated bindings to their own patches
- added MT8188 default thermal zones
- Link to v1: https://lore.kernel.org/all/20240111223020.3593558-1-nico@fluxnic.net/T/

---
Julien Panis (2):
      dt-bindings: thermal: mediatek: Fix thermal zone definition for MT8186
      dt-bindings: thermal: mediatek: Fix thermal zone definitions for MT8188

Nicolas Pitre (4):
      arm64: dts: mediatek: mt8186: add lvts definitions
      arm64: dts: mediatek: mt8186: add default thermal zones
      arm64: dts: mediatek: mt8188: add lvts definitions
      arm64: dts: mediatek: mt8188: add default thermal zones

 arch/arm64/boot/dts/mediatek/mt8186.dtsi           | 316 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi           | 482 +++++++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c            |  12 +-
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  12 +-
 4 files changed, 810 insertions(+), 12 deletions(-)
---
base-commit: b321abd919e22b240d53329cd726ea7afa8aca98
change-id: 20240520-mtk-thermal-mt818x-dtsi-eca378f9b6a0

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


