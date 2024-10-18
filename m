Return-Path: <linux-kernel+bounces-371643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5429A3DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F26B24834
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B8F18EAB;
	Fri, 18 Oct 2024 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sv80lZZ8"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04114AD39
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252992; cv=none; b=CDjaueeAkn3u8UfKgjbT2yMpRXNEmeh9Ra1ozweqT6Ix+tBhTSvfAKVjkZKEYrsLJWBxSh6z0ZG8JAwlyb81fEdiv5aUN12npy+rIW5CIW6MJJuLsPeZ/5SaQogYN1E27iXvGnHsrY41N6IM+pQhJC9o+qzc+ydsUjYkEdS+uTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252992; c=relaxed/simple;
	bh=y0DkIOesMdKvN8Z/QA+Qc6yTmJECLlRxko6tosmD8iM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ow2Zfxh1CJWobOV87kbSnHax4z511IwlxnlMjcv8//bSPoIwrRg9ESRgx9R1ADzPd4itONw0j0LX8DyiX9pZUaUdBr4ZA7/mELWfOsodzMk5ZhGbbFL8rtlh26uyIgL6uVL5miaLhMHzTF7VpzJx+S7inoI0b2uKlU2LPiTJUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sv80lZZ8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e6d988ecfso1575942b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729252990; x=1729857790; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CDJu6fBQb2bDc0BqYl/x7X5JBsqu58Z2M+kmfTvKKyw=;
        b=Sv80lZZ87g2vQlP/CNSmfnaUyKlYlaTA9u0hJ/xrbKyF7SsJp5SRssJS0ZKRmxJBuo
         LqgQWKFHvR8os3ecbCvSL1vRg6IuIosm5ueC+gYMTZKHszJdSNSrL5rllRG30xAlS4wl
         myA/0EulehoG9zaeTtWNVyO3Dxqmhe7DRb+3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729252990; x=1729857790;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDJu6fBQb2bDc0BqYl/x7X5JBsqu58Z2M+kmfTvKKyw=;
        b=U3c8YF9a7eEm0VpHZV5KpLOQWaWQypi9GaS+Y889CNu8rbGmTB9c7gaLu2ThWfSKze
         gwiicuRt/ik5HqJJWb4hjTit6tsmQEbKKBU3vf++QCJYt0HYpNUIJzZIottCV9i2Zp05
         4xpxV80uHSTqhjiOtYeM6EZyFGqFqmQMg40UayjDpj/sO8bBNhWo0JJXwILaJYEtYZHv
         kxwp3WCprZIzTDCb4I1XaXG4tUP9HLAXIkxonlhZLiS8gXTRZym9J6/vMD+6Ls09Oja4
         PcCbxAOSjBei6e3tF5oIvH/SqaddTXXsAefU1Xu6YNshD81C0ngpUXSx0u88qreyLzUG
         A4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUIHiE2H3RdYpj0s/22fhs6nFdTjVpTiGrL2aZ9hTKJqC+s+YV8w+/lr83FGr+i2qbc2JqlP4o2Za3SMFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+lqPJ3JEBqy7Ef/nD9dFsssYqhKvU2POBOuqHdChxOzYUq0D
	pau47ilKuqflurzBTJm75f3Y2IiHBpuJjaxQwGT9ibhdqiaqWHCtzvwNo6K77A==
X-Google-Smtp-Source: AGHT+IFKICDT9+F2pT3sRCMfvCwNLuczhwS1bTZfHyCZaslXhQZFrv1ZJCb8b0gWYMEy9tdZtcu1bg==
X-Received: by 2002:a05:6a00:1ad2:b0:71e:693c:107c with SMTP id d2e1a72fcca58-71ea31ae9a9mr2758478b3a.11.1729252990124;
        Fri, 18 Oct 2024 05:03:10 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34ae672sm1274014b3a.204.2024.10.18.05.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:03:09 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH 0/2] Using i2c-hid-of-elan driver instead of i2c-hid-of
 driver
Date: Fri, 18 Oct 2024 12:03:03 +0000
Message-Id: <20241018-post-reset-v1-0-5aadb7550037@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHhOEmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0ML3YL84hLdotTi1BLdxGQzsyQDY1NDM0NjJaCGgqLUtMwKsGHRsbW
 1AKoyNcNcAAAA
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

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Hsin-Te Yuan (2):
      arm64: dts: mediatek: mt8183: Fix race condition of pinctrl
      arm64: dts: mediatek: mt8183: Switch to Elan touchscreen driver

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


