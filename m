Return-Path: <linux-kernel+bounces-268596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153879426F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460861C20E33
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADB816849F;
	Wed, 31 Jul 2024 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OcKuX1lo"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BAE1667CD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407202; cv=none; b=GtCiXu7z5c1K5NyviiHujD6rGC1VD4o2RxY6o8jU69xRApukWvFPEKEtwGU/EuysnEyaXP8XhFjR1uO2ub8lmWXNeaQWJbaZkGLDVXFYwAR1ga3kn/05CokqJ4LNyoE6s/Yu3waPPn0Gu6sgJr4O4qkdQUi5hRNZbE7VJW3Tj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407202; c=relaxed/simple;
	bh=xHOXR57tM13mW8DJK12gNSjM5gTo6ipjJoZ1S02HhWM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gWw9SnhKH+HUt2hM7zt4F3DTVDp4E0tgwXM7/9FGLEd/p+K2BbLaMg8orPJ19k4wQrKKDbCjFj5g1fgzMBi3cCv+DvmMV3AyQ+lD+qMqmpOZmoj3QPuFr9IutwP3/aBw6AS3D348dqGhpoCvOoSJ6CTrAg6mKJQmHpUir3WzVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OcKuX1lo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70eec5f2401so2851352b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722407201; x=1723012001; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqhIkk3YfCSp6KaZ4R+MmsXcqdQVHrJDoQsTmhCdvZs=;
        b=OcKuX1lom2ne8qIngEy4Roxiau63mqS4VYT89O2DBYc7cw3VDx0TiJaVAPPyj65CwC
         1zsXteYTQ9UPL3JQmVyV2SaE984AsKrCFdxCcijWbSdA/cZ1AOB2y0JodYzgwscVXn0f
         j8UZVISwdbud1J1Ng14KxeofgbuVCd/d/xoUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722407201; x=1723012001;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqhIkk3YfCSp6KaZ4R+MmsXcqdQVHrJDoQsTmhCdvZs=;
        b=j5qWBtary06QUaa8xknBCrjh3f7SzoQWCCjq6HPX2rsNlq5vSNupl088hyVflmZp6h
         YqfOKujIIn9F/V4I9YcpTo+GBLwPClWsHfCOTOqlPPForPwfwUY4FFWADaCgvVAjqnd1
         32XbKosbKmM5fm+Wu2VCFGsOdlBsfJYDCPRhb49umUykGl0abJJuE4bi5nkT17W+J+DL
         Jj8cRCTwtwotolT0q5lJoO7UeBDAp3besThOWpBFBP6b7dTIkDtjy/pKrSEoxi00Fekv
         ktM5wXv/tqCD9xZoYOwhukxoodixOG6c7++xZ01q2I2EvNYt7XoJ93lW474FYbNOP4e7
         B6TA==
X-Forwarded-Encrypted: i=1; AJvYcCUX+ExNq9ziDivo0Rj2Kc2d3AKlthZaBcwnxkhHyVUoDhGpHQdYkFZHmQtR/FqZCyIzAUUSVGGJ8YF3cAVQ6UKyyHHgtNQPoCuS+UMJ
X-Gm-Message-State: AOJu0YxAUThmwu117bHD5AOKgI67D6diSTFOZ8iVKCbnPpw2sCl5B5bs
	mV3FlKnZij5wrYRFwoXFfW/j5LDbn24Ud9LO59eD4t+W5OgWAkyTRTn2yEkQNA==
X-Google-Smtp-Source: AGHT+IEiQW+a8M7q5lz39PWzZTOdWXj45ufGNGatcB448aoDc9BWYb8bX/VGTeoj1YB0vyVoO4r7SA==
X-Received: by 2002:a05:6a00:14c1:b0:704:2563:5079 with SMTP id d2e1a72fcca58-70ecedbce2cmr17889294b3a.27.1722407200632;
        Tue, 30 Jul 2024 23:26:40 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (46.165.189.35.bc.googleusercontent.com. [35.189.165.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e1084sm9322308b3a.25.2024.07.30.23.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 23:26:40 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH v2 0/2] Add kukui-jacuzzi-cerise and kukui-jacuzzi-stern DT
 and dt-binding
Date: Wed, 31 Jul 2024 06:26:34 +0000
Message-Id: <20240731-jacuzzi_dt-v2-0-4995335daa30@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABrZqWYC/23MQQ6CMBCF4auQWVvTDkWDK+9hiIF2oGMCJS0Qh
 XB3K2uX/0vet0GkwBThlm0QaOHIfkiBpwyMq4eOBNvUgBK1vGIuXrWZ15WfdhLyYqxsWltoREi
 HMVDL7wN7VKkdx8mHz2Ev6rf+ZRYllMipLHWNTUGo78YF3/Pcn33ooNr3/QudoUFFpwAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.13.0

Cerise is known as ASUS Chromebook CZ1.
Stern is known as ASUS Chromebook Flip CZ1.
    
They are almost identical. The only difference is that Cerise is a
clamshell device without touchscreen and Stern is a convertible device.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
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


