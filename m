Return-Path: <linux-kernel+bounces-279196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A0494BA44
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F121C21CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18588189BAF;
	Thu,  8 Aug 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G0aAoGpv"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AEC18785E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111186; cv=none; b=KTIo6DxO2SVcaC/2wxL+K37ucOhhWhCWUBliWV/ZCMVSCIMu59xhuWds4HIasKZRof2ehHDFCSmCbBSFQSAB+p9mS/mcIxZKA4O9tVSQ0/JwVSiurWhYHC/6fh8dpZAeCDo64/8No392s806iIbjpA2aGIUuQR112/A2BDaeY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111186; c=relaxed/simple;
	bh=QU08o06YhKl9u3uziXHacRY1RON1taT1AXWAXMjvZ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+LK7g4tYsp/b8qEBEunrv43HQ5IEkZmi62jcaNMeHzdOZ0h0GyQbR1IKdhKWOCGmJ7fn6tZCtOMLL3mXpTyjOBIO1YEwhj/iHPouNybgtX+UapcL7bvPcfGWUPSus9WxaEZ4oopfIzsCIFi+UNkAfjX1kFOPNyoG5suQk8UM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G0aAoGpv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710ce81bf7dso210696b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723111184; x=1723715984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NP++nqGZtSUGI7J35b2VGOlDWErcjczjXqKgEtz1Owk=;
        b=G0aAoGpvdUmZvRZa5w3jvjoDRCcOiXI9MFpd4E4HJV4u8/KUTFfSUwMlwnovIGOuoC
         lONJ+BaIIsS/sAwCKcco+K0CIaq538g2sQAVLgVapLcJZDjgLIHyOhpznLxFAepjLUG5
         4MShquT4aj+i3gevtxmpcu9vGJcgglRfV+pHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723111184; x=1723715984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NP++nqGZtSUGI7J35b2VGOlDWErcjczjXqKgEtz1Owk=;
        b=FemIG7rPllyCGmhunuyL3UgzBDtesXSfTlrZsbzHl4zEhDUJj9/Xx+vyOdPk5cZJa4
         fdI5jRGvRT1Twd4cu3/r/nEEr9s8FCvQMSx46ZQdousiXVJY9+/T0mTnLYBKS+Kfnr85
         qUxlpQVVD9+Qd5wrZR/LJRZawqMqu/8nYKeVU72uk8q72nEmnPZ05AkrbAOLSfU0B/iQ
         is5AKfofxsCwniOTyjfSCfOY4x2RVwtY6ft+VysfhaIUp+hK8d7KSQ9Md8zqbg6B1S6M
         gr1vJMLQFyFH8sM8CAaFnpyUrKBMOEbELyeXNRoZtsV5n2Lf15UhDe9mKVdRN3TaiffN
         ZNDg==
X-Forwarded-Encrypted: i=1; AJvYcCUNk7G0iJKmtsmuTcMyFI9iHYmF2kz2SuuhDBIoZ8jfdX6R6s1FwhvwESN3lpanjUn6TiLc87kS43rXz0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmHYCigxRdSw4XpwEqx5J77UhoUsBRuUnzIvtRoeE0hdTcrxn
	dF0xyeP9MU2E4a/ODrcBsGFIf91rMWF6PcuTeUswfHMe7XPjE7Rc98o6sAmPLw==
X-Google-Smtp-Source: AGHT+IHL9rv4DJSde7oadJWdI89Iu3rNnn3lai1eI+TVJJMzKxFKeEkjOe+alrLCoEqFD84PVNfHgw==
X-Received: by 2002:a05:6a20:3945:b0:1c3:ba3d:3ec3 with SMTP id adf61e73a8af0-1c6fcf8133amr1257186637.36.1723111183924;
        Thu, 08 Aug 2024 02:59:43 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8b53:87e6:914:a00d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297707sm120784985ad.254.2024.08.08.02.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:59:43 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v4 0/6] platform/chrome: Introduce DT hardware prober
Date: Thu,  8 Aug 2024 17:59:23 +0800
Message-ID: <20240808095931.2649657-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v4 of my "of: Introduce hardware prober driver" [1] series.
v4 mainly adds regulator and GPIO support. This part was separately
tested on a MT8186 Voltorb device with a slightly device tree and
an extra entry in the ChromeOS hardware prober.

v2 continued Doug's "of: device: Support 2nd sources of probeable but
undiscoverable devices" [2] series, but follows the scheme suggested by
Rob, marking all second source component device nodes as "fail-needs-probe",
and having a hardware prober driver enable the one of them.

This time I trimmed down the Cc list.

Changes since v3:
- Patch 1 "of: dynamic: Add of_changeset_update_prop_string"
  - Use new __of_prop_free() helper (helper was added by Rob in 2024/04)
  - Add new line before header declaration
- Patch 2 "regulator: Add regulator_of_get_optional() for pure DT"
  - New patch
- Patch 3 "i2c: Introduce OF component probe function"
  - Complete kernel-doc
  - Return different error if I2C controller is disabled
  - Expand comment to explain assumptions and constraints
  - Split for-loop finding target node and operations on target node
  - Add missing i2c_put_adapter()
  - Move prober code to separate file
- Patch 4 "i2c: of-prober: Add GPIO and regulator support"
  - New patch
- Patch 5 "platform/chrome: Introduce device tree hardware prober"
  - Include linux/init.h
  - Rewrite for loop in driver probe function as suggested by Andy
  - Make prober driver buildable as module
  - Ignore prober errors other than probe deferral
- Patch 6 "arm64: dts: mediatek: mt8173-elm-hana: Mark touchscreens and trackpads as fail"
  - Rebased

Patch "arm64: dts: mediatek: mt8173-elm-hana: Add G2touch G7500 touchscreen"
was merged separately and thus removed from this series.

Changes since v2:
- Added of_changeset_update_prop_string()
- Moved generic I2C code to the I2C core
- Moved remaining platform specific code to platform/chrome/
- Switched to of_node_is_available() to check if node is enabled.
- Switched to OF changeset API to update status property
- I2C probe helper function now accepts "struct device *dev" instead to
  reduce line length and dereferences
- Moved "ret = 0" to just before for_each_child_of_node(i2c_node, node)
- Depend on rather than select CONFIG_I2C
- Copied machine check to driver init function
- Explicitly mentioned "device tree" or OF in driver name, description
  and Kconfig symbol
- Dropped filename from inside the file
- Made loop variable size_t (instead of unsigned int as Andy asked)
- Switched to PLATFORM_DEVID_NONE instead of raw -1
- Switched to standard goto error path pattern in hw_prober_driver_init()
- Dropped device class from status property

Patches removed from v3 and saved for later:
- of: base: Add of_device_is_fail
- of: hw_prober: Support Chromebook SKU ID based component selection
- dt-bindings: arm: mediatek: Remove SKU specific compatibles for Google Krane
- arm64: dts: mediatek: mt8183-kukui: Merge Krane device trees

For the I2C component (touchscreens and trackpads) case from the
original series, the hardware prober driver finds the particular
class of device in the device tree, gets its parent I2C adapter,
and tries to initiate a simple I2C read for each device under that
I2C bus. When it finds one that responds, it considers that one
present, marks it as "okay", and returns, letting the driver core
actually probe the device.

This works fine in most cases since these components are connected
via a ribbon cable and always have the same resources. The prober
will also grab these resources and enable them.

The other case, selecting a display panel to use based on the SKU ID
from the firmware, hit a bit of an issue with fixing the OF graph.
It has been left out since v3.

Patch 1 adds of_changeset_update_prop_string(), as requested by Rob.

Patch 2 adds a function for retrieving regulator supplies solely
using device tree nodes.

Patch 3 implements probing the I2C bus for presence of components as
a helper function in the I2C core.

Patch 4 implements regulator supply and GPIO support for the I2C
component prober.

Patch 5 adds a ChromeOS specific DT hardware prober. This initial
version targets the Hana Chromebooks, probing its I2C trackpads and
touchscreens.

Patch 6 modifies the Hana device tree and marks the touchscreens
and trackpads as "fail-needs-probe", ready for the driver to probe.


Assuming this is acceptable to folks, because there are compile
time dependencies, I think it would be easier for the code bits
(patches 1 through 4) to go through either the OF tree or I2C
tree. Patches 5 and 6 can go through the soc tree via the mediatek
tree.


Thanks
ChenYu

Chen-Yu Tsai (6):
  of: dynamic: Add of_changeset_update_prop_string
  regulator: Add regulator_of_get_optional() for pure DT regulator
    lookup
  i2c: Introduce OF component probe function
  i2c: of-prober: Add GPIO and regulator support
  platform/chrome: Introduce device tree hardware prober
  arm64: dts: mediatek: mt8173-elm-hana: Mark touchscreens and trackpads
    as fail

 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |  13 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  |   4 +-
 drivers/i2c/Makefile                          |   1 +
 drivers/i2c/i2c-core-of-prober.c              | 425 ++++++++++++++++++
 drivers/of/dynamic.c                          |  44 ++
 drivers/platform/chrome/Kconfig               |  11 +
 drivers/platform/chrome/Makefile              |   1 +
 .../platform/chrome/chromeos_of_hw_prober.c   | 107 +++++
 drivers/regulator/core.c                      |  81 +++-
 drivers/regulator/devres.c                    |   2 +-
 drivers/regulator/internal.h                  |   2 +-
 include/linux/i2c.h                           |   4 +
 include/linux/of.h                            |   4 +
 include/linux/regulator/consumer.h            |   8 +
 14 files changed, 681 insertions(+), 26 deletions(-)
 create mode 100644 drivers/i2c/i2c-core-of-prober.c
 create mode 100644 drivers/platform/chrome/chromeos_of_hw_prober.c

-- 
2.46.0.rc2.264.g509ed76dc8-goog


