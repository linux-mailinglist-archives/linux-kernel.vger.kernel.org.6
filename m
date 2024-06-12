Return-Path: <linux-kernel+bounces-211122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB505904D72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F56E1F23211
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5413816D4CC;
	Wed, 12 Jun 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MoeWCxca"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56CD358A7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179341; cv=none; b=hkC/K5sBMhrRQWY48AuDn/vhfYJErRnfj/Xkm2k3LPHjI2rqCAwM1qrIewLLara2i9gPdaXsTFvGlfWb9iyT/czESv9qQk4UWPADALpq4VvCoOH7BowCyilgCmtDsQAHhC7E6AYVWDh1FhR77zT/uBZIBItZaK+05ZhtaMcpcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179341; c=relaxed/simple;
	bh=s3mfIsukRZmgouUhCyn9Wd/i7okI8+3DBaijsAj2WU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3BHhIiDnlDfwFUvOMnqc2pLDIrgLl3dog2xjJ2ioglVEBLHIpWe4WscWvjeGaYsm+38NEO9ENzRGbkmbbULzJosYsdY5i9I3ajb+Skcw1q4Avxi0w7gy6i5kf+mUwBNzs9e8xl07/TrP2dGAAurcr0X/7C1BNkHquGGXec3Nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MoeWCxca; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35f1691b18fso3459627f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718179337; x=1718784137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ksBSyA+j9QPSkEsVDee/zoG9hDnAPGUv/QuDtN8Vy0=;
        b=MoeWCxcaJfh4knync7Fc5ivflDbf+9FUEE4rB9Ur7qKbL8a94cOa+R9bXm5ThhCHJO
         gCCH9S+Z9MK+HaXEqOQ5yHiwlN1P6itZ/HCXwFWuZISe9hz8k2MYUE9NZbvOlxBvpFgk
         4hTdEom3Tts/IGl/qct4vm7zZyaeC2khtddA4LoOdDjRr2rIvkjd0rwHGALNTkO60e8D
         S7301X071GmGv2MQGLP8xMty8r4p/PadhvwT+J103O0s6gSHECateWf07JHyJqB4RZ0q
         wYhIk7ZL3cMCjYvZ/X/C58tEJA3Ndaa6/kFXlksEzBjgrxoEnfz3vmRyzYnySSHSf796
         1QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179337; x=1718784137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ksBSyA+j9QPSkEsVDee/zoG9hDnAPGUv/QuDtN8Vy0=;
        b=Cu5O7sJyKNE6p9jPwrT6dQdNZEYrpUkXIjVMOFVoUc6swIh2vVznOT4s4YlRvhOPRu
         s8ty1xCEp/A509J0z70Q/9G0BxYDw98KbSIoJNCyUjGt3gsePQplw3vR82TvF5IKSiEz
         5pxwamtX62+KIEmCCvdJ9HEOCYEDu6QvsdEZoZaARJRkptrNu4bBQs5VMlRLWdS+Q6cI
         FMLMHBEthkrC0cyLHbYEoSIA7YPlVJRV9g4GphRnrofDniRly+6SU9Lq6kuRkVpOUCs+
         3dZUI/gKc0cybvxfuvsX/5Ng7yAaS/V7koDsa4/EL4LUhimNLPvTN/TZbZKVMQTIWSeU
         AZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOYUkHpbSph7Q9aCHTxsY12D6Q03yM0ZsnF55OCsamLTtfSFTeDRn95DtHfgLKFJ/9B3yDA2qtO4nrvcm6uPvzfGk2lcC2c60dt388
X-Gm-Message-State: AOJu0YyJd5xyF5mPWb5u6d+AFZhJHleVqKB+bK8J9jzOujY17De4XWKs
	uJC9SbAsjJWdmG+waYuha/Gfm06Dib8CFhQDlFko1rk1t6WOj5MA6LzNVTONyy8=
X-Google-Smtp-Source: AGHT+IFXYFUX0JPIwmj9Dya04E+MPasUBHNXYfyKZZbDpuWUHf5YESL4MGY5Xiz2kjIyRyPElOx9vw==
X-Received: by 2002:a5d:6a8c:0:b0:35f:1cbe:2e2f with SMTP id ffacd0b85a97d-35fe8917f56mr730173f8f.47.1718179336991;
        Wed, 12 Jun 2024 01:02:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f24c7a9c8sm7452585f8f.78.2024.06.12.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:02:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 0/2] Bluetooth: qca: use the power sequencing subsystem in hci_qca
Date: Wed, 12 Jun 2024 10:01:48 +0200
Message-ID: <20240612080150.18375-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are the dt-bindings and the hci_qca patches split out of the larger
power sequencing series. They target the Bluetooth subsystem but depend
on the following immutable tag:

    https://lore.kernel.org/lkml/20240612075829.18241-1-brgl@bgdev.pl/

Please consider picking them up into your tree, they were reviewed and
thoroughly tested.

Changelog:

Since v8:
- split out the Bluetooth patches into their own series
- Link to v8: https://lore.kernel.org/r/20240528-pwrseq-v8-0-d354d52b763c@linaro.org

Since v7:
- added DTS changes for sm8650-hdk
- added circular dependency detection for pwrseq units
- fixed a KASAN reported use-after-free error in remove path
- improve Kconfig descriptions
- fix typos in bindings and Kconfig
- fixed issues reported by smatch
- fix the unbind path in PCI pwrctl
- lots of minor improvements to the pwrseq core

Since v6:
- kernel doc fixes
- drop myself from the DT bindings maintainers list for ath12k
- wait until the PCI bridge device is fully added before creating the
  PCI pwrctl platform devices for its sub-nodes, otherwise we may see
  sysfs and procfs attribute failures (due to duplication, we're
  basically trying to probe the same device twice at the same time)
- I kept the regulators for QCA6390's ath11k as required as they only
  apply to this specific Qualcomm package

Since v5:
- unify the approach to modelling the WCN WLAN/BT chips by always exposing
  the PMU node on the device tree and making the WLAN and BT nodes become
  consumers of its power outputs; this includes a major rework of the DT
  sources, bindings and driver code; there's no more a separate PCI
  pwrctl driver for WCN7850, instead its power-up sequence was moved
  into the pwrseq driver common for all WCN chips
- don't set load_uA from new regulator consumers
- fix reported kerneldoc issues
- drop voltage ranges for PMU outputs from DT
- many minor tweaks and reworks

v1: Original RFC:

https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/

v2: First real patch series (should have been PATCH v2) adding what I
    referred to back then as PCI power sequencing:

https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/

v3: RFC for the DT representation of the PMU supplying the WLAN and BT
    modules inside the QCA6391 package (was largely separate from the
    series but probably should have been called PATCH or RFC v3):

https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/

v4: Second attempt at the full series with changed scope (introduction of
    the pwrseq subsystem, should have been RFC v4)

https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/

v5: Two different ways of handling QCA6390 and WCN7850:

https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/

Bartosz Golaszewski (2):
  dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
  Bluetooth: qca: use the power sequencer for QCA6390

 .../net/bluetooth/qualcomm-bluetooth.yaml     | 17 +++++
 drivers/bluetooth/hci_qca.c                   | 74 +++++++++++++++----
 2 files changed, 76 insertions(+), 15 deletions(-)

-- 
2.40.1


