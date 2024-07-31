Return-Path: <linux-kernel+bounces-269015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B90942C52
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F711C209BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1811AC434;
	Wed, 31 Jul 2024 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NY5QOId+"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57679190473
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422851; cv=none; b=Zx1+vxbV7EomUtUBj8+C0N6OS2YUIAFiFkpx+UCc1WMOXseqOtwKK6FT+2wYFvLXNawnjITHeVvujbmL9OgSs3dNBe63+IYrOkWHDiMVjT2HC21lbgKCblhz1Sw3FAa9gYquZEQIHyWtpfmQY68eSDIV1wjel0GmhQgAgHl6jk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422851; c=relaxed/simple;
	bh=bZYli5vmgtFKdt6I++BJc2BNRWZSPqgsIhrgAy/h8v0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dvntJt2gd/82IGAzvPHR7GD9xTQwdOoUEAPH3087sYQf9j4TftiUhHuSlk/fRAS4xGPm005eJRiquj+lNC+2PPOguJvjlLK8x7ZVF7Nia/uPTAkJcBAuGpLUaqVvxcOBNmjOIUNX4Ug596SOuy7edl/4OYRGeWDnpxXL6z8nhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NY5QOId+; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-816d9285ebdso229367839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722422849; x=1723027649; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yqftJYgpsdpuaB39a0qAl3cbMgdLrQIYW98lIkiY1Y=;
        b=NY5QOId+XA6r8Zal2o1fc5SwSx9d2Ay0mrE4tZwcOHx+9tKrPz7GXaehDJyr1bwCXl
         3AZr4Wg+GbjY8WFH41nLzWPBffPoIvVpgkCVWWmfS95EPWKU4XqFvgnJ7jbhGtUAfnLN
         XD+tmcUGoldN9LlG7s7mbV6WVMkiix8YvLCbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422849; x=1723027649;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yqftJYgpsdpuaB39a0qAl3cbMgdLrQIYW98lIkiY1Y=;
        b=IUryxHtzqqMG/7/diLE1yY1gqAQ2xQk+IPzoMezOl0aIVbWVLoZ9llYfJtDT9JssSZ
         OagM8DJ4GWFID1uPNT4t3bU8lFYyNzowuYxuWO7ecAtxuk3kmFvrh0V0mVqDI53q7jrk
         ue2efAKSSyZ7QBwRJPuDFZlI8iztvJcCzOW784qAZadEIRj35cEnEkej1hLbGiayy6KU
         f7ZCJERJMzyAsGlu+nFKFN03bLfW3xR/HgXlB+J7e5dCmbE5+fXvy0HsJEND7ZeEwvSO
         aPXm51h90AvwFO/kFxwsShe79MUUKypdsi6rqZ6WCjSZki+LShwKi062x5CmxiqiqLAB
         lBBw==
X-Forwarded-Encrypted: i=1; AJvYcCXiLx2xEpxMcI7QNjJKQqGMh1DooDOjaOAtr2eddYyqhBDlUGoJCWQuYF2VMrip/+/gGeyPQtwbTc7rQoBOEg5atYw2n358J+l05AnC
X-Gm-Message-State: AOJu0YzEa1c0WVzqjma6LKbYel6fxx/h8pVFiAxSgF2I3ARxQfCLdjvd
	8RyRomNte97mmOTSiXOQsGV+90vYn1dSoAoFkyzb1typcCPcr7bzTmhvcu76B6H6Itj4X2sVHeU
	=
X-Google-Smtp-Source: AGHT+IG77YhthMCyuU0rdCq1IohoSnJWamFfjuvhA+obGGesvdGPDyHrZg7NqXHZD1C0uIDW5pvANw==
X-Received: by 2002:a05:6e02:216e:b0:397:70e7:143b with SMTP id e9e14a558f8ab-39aec2eae11mr179360445ab.14.1722422849317;
        Wed, 31 Jul 2024 03:47:29 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (46.165.189.35.bc.googleusercontent.com. [35.189.165.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa5a0bcesm8788400a12.89.2024.07.31.03.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:47:28 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH v3 0/2] Add kukui-jacuzzi-cerise and kukui-jacuzzi-stern DT
 and dt-binding
Date: Wed, 31 Jul 2024 10:47:24 +0000
Message-Id: <20240731-jacuzzi_dt-v3-0-1c4314e8962f@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADwWqmYC/22M0Q6CIBRAf8XxHA0uUKOn/qO1hoB629QGykrnv
 4c+VevxnO2cmUQf0EdyKmYSfMKIfZdB7ApiG9PVnqLLTICBZEcQ9G7sOE14cwNlB+tYWTklAUg
 OHsFX+Nxml2vmBuPQh9f2Tny1fzeJU06F11oaKJUHebZN6Fsc230farKeEnzUgn/VQBmVWishl
 DNGsJ96WZY3CZsmO+UAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-a9570

Cerise is known as ASUS Chromebook CZ1.
Stern is known as ASUS Chromebook Flip CZ1.
    
They are almost identical. The only difference is that Cerise is a
clamshell device without touchscreen and Stern is a convertible device.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v3:
- Add explanation about the compatible string of Stern.
- Replace MTK_DRIVE_6mA with 6.
- Link to v2: https://lore.kernel.org/r/20240731-jacuzzi_dt-v2-0-4995335daa30@chromium.org

Changes in v2:
- Add more SKUs.
- Remove unnecessary property.
- Specify classis-type in the dts files.
- Add dt-bindings for these devices.
- Include these dts file in Makefile.
- Link to v1: https://lore.kernel.org/r/20240723-jacuzzi_dt-v1-1-3e994a2b5e24@chromium.org

---
Hsin-Te Yuan (2):
      arm64: dts: mt8183: Add kukui-jacuzzi-cerise series boards
      dt-bindings: arm64: mediatek: Add kukui-jacuzzi-cerise board

 .../devicetree/bindings/arm/mediatek.yaml          | 14 +++++++++++
 arch/arm64/boot/dts/mediatek/Makefile              |  4 +++
 .../mediatek/mt8183-kukui-jacuzzi-cerise-rev3.dts  | 26 +++++++++++++++++++
 .../dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts   | 26 +++++++++++++++++++
 .../dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi  | 21 ++++++++++++++++
 .../mediatek/mt8183-kukui-jacuzzi-stern-rev3.dts   | 29 ++++++++++++++++++++++
 .../dts/mediatek/mt8183-kukui-jacuzzi-stern.dts    | 29 ++++++++++++++++++++++
 7 files changed, 149 insertions(+)
---
base-commit: 66ebbdfdeb093e097399b1883390079cd4c3022b
change-id: 20240723-jacuzzi_dt-06cd0bfd5422

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


