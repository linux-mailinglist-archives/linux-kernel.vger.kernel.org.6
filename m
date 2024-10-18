Return-Path: <linux-kernel+bounces-371724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D6B9A3F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1FD28384F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794FC1F947;
	Fri, 18 Oct 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c5heL++I"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040C18E351
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257230; cv=none; b=Ji/gjoSMXjeV4YY7uSkN3Y/H0onoDYqROF0KGbB9eUMHYv9PXGGy9LUT33H9ZNkqxr6kp2phAOWmYH9GYHXmUjSs12MTLnByHLLO6OQNuQsc9IwCTsulwReTFKQCKA4ivvghM+AD+4RtLCkrbkIYhXHvL58feB/C8j669L8WSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257230; c=relaxed/simple;
	bh=XJsufPU8oDUNT2IVUxN0YngUgeNFIQN/QtzNcOQLQoA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oD6PZOmneTXIdL6C9yII8P9AJLuJ+KvVP9B8hNpkQMUL5I+7kZ9P1072ixTqVnYwecXnOeS/azutE7y4+Kc7h4NPlJraz7upxBBiRL5zC/TxTgf1he7uFfftWpeD80xqqyGayRPj1hSgVsfVS2OW+SgZQKZpsP+LTUw5SBd4czM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c5heL++I; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b450320aso7750815ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729257228; x=1729862028; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/IpCOxbbfuWTu34K+8DA6jyFkd8ceqHknAK97seFFAo=;
        b=c5heL++IqhWwPQME0+13DvayfGUO2s+tcYutI+VRn4hLUb70WdqfS5rn0905UK39RI
         H9ZqbGXvW9o3jjNk7skn6foF3O2hsLHTnpusknuv31lOQVi0lWfT8/mpadjudGX8oblN
         xEmm8e0Fc6IIU6woXLXB0UmwZMc0vn48OEosw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257228; x=1729862028;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IpCOxbbfuWTu34K+8DA6jyFkd8ceqHknAK97seFFAo=;
        b=pNAs2gD7nxG/cA8hGsmZ2texBljkbE9oHrSfUIbIdaJjeCaJGzIhzWEgo+3ZBowdJF
         SKZkZ5xc7gRcGxsaEgYnO8nFeUyPuWuGq8fuy7XiNUIBxeLpnvP0K/oFX52SAjUQz+zn
         YBgKHopAHQts/O7vV+tnc1jbQRDyZ/0aTT8lkLQzoZKet7STAF5LR0MZAN98GgzJo40s
         nT+2tLiePKO3MlzT+5YyBCRZH454knLgxGWMzh5mFHWnf1ersz/Kutr1kjTKYrXBBieZ
         IIYiNSuDmmOpaGgkN1BdZ6wyPmBQBNwmHoWo2skRbRYqfc9FJGYpIY49nyGXY2FnAzxD
         HY5w==
X-Forwarded-Encrypted: i=1; AJvYcCU9JYdpmK6YX2R/TTPCqQD+t/KcPQMe71FKmQ6k0NixDo5xBTG8Yaarcj6nsYVATr48tR7EFylQW3FSG/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0BBu6GiV1zeK135y+9NGW7W8IQgRtMwAajT0beL8KfYkbw0Y
	wQ8Y3CGbedNVnTXbTO4BaHZ+TRjxe3EphysR/eATOWbzPzFKskQbVdL+T4Da3w==
X-Google-Smtp-Source: AGHT+IFBfEFVY3g0oM2/BGGdZ3Q6Mpfn3MSyJk6cOSoXomUIoUgVnQhq517tPvH61wPvt73sh3wORw==
X-Received: by 2002:a05:6e02:1389:b0:3a0:ac0d:22b9 with SMTP id e9e14a558f8ab-3a3f4058abamr22270665ab.6.1729257227812;
        Fri, 18 Oct 2024 06:13:47 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc256cc8sm1120222a12.56.2024.10.18.06.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:13:47 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH v2 0/4] Using i2c-hid-of-elan driver instead of i2c-hid-of
 driver
Date: Fri, 18 Oct 2024 13:13:40 +0000
Message-Id: <20241018-post-reset-v2-0-28d539d79e18@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAARfEmcC/23MQQ6CMBCF4auQWVvTobYYV97DsChlhFlAyRSJh
 vTuVtYu/5e8b4dEwpTgVu0gtHHiOJeoTxWE0c8DKe5LQ63rC2q8qiWmVQklWpUPznXaWHRooBw
 WoSe/D+zRlh45rVE+h73hb/3LbKi0st73XWOt1qa5h1HixK/pHGWANuf8Bb7o+m2nAAAA
X-Change-ID: 20241018-post-reset-ac66b0351613
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

After commit 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to
i2c-hid-of"), i2c-hid-of driver resets the touchscreen without having
proper post-reset delay on OF platform.  From the commit message of that
commit, not to decribe poset-reset delay in device tree is intended.
Instead, describing the delay in platform data and changing to use
specialized driver is more preferable solution.

Also workaround the race condition of pinctrl used by touchscreen and
trackpad in this series to avoid merge conflict.

Adding other second source touchscreen used by some mt8183 devices in
this series since this should be based on the workaround of pinctrl
issue.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v2:
- Add second source touchscreen patches since they should based on the
  first patch of this series.
- Link to v1: https://lore.kernel.org/r/20241018-post-reset-v1-0-5aadb7550037@chromium.org

---
Hsin-Te Yuan (4):
      arm64: dts: mediatek: mt8183: Fix race condition of pinctrl
      arm64: dts: mediatek: mt8183: Switch to Elan touchscreen driver
      arm64: dts: mediatek: mt8183: kenzo: Support second source touchscreen
      arm64: dts: mediatek: mt8183: willow: Support second source touchscreen

 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts |  2 --
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts  |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts   | 12 +++---------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts   | 11 ++---------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts   | 11 ++---------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts   | 11 ++---------
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi |  3 ---
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi      |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts   |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts  |  3 ---
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi |  3 ---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi       | 10 +++-------
 12 files changed, 12 insertions(+), 63 deletions(-)
---
base-commit: eca631b8fe808748d7585059c4307005ca5c5820
change-id: 20241018-post-reset-ac66b0351613

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


