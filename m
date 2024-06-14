Return-Path: <linux-kernel+bounces-215233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D57F90901C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510201C20EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234E181B91;
	Fri, 14 Jun 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxVrvtT5"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE49616B751
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382252; cv=none; b=MlY3Dm1vNLgTrM2Pvlbl4Wiys9wgSWRO5GQzziq+ay8xJn+VpPKloEwK1pcI08Xe1lenOT2Gl3wM6qDphLRirs5Lqy7mJwLof18fE0S8YLYf8wYcWAxSKpgiows0sD5apyqwwGlJVYHzX2KcNkR0WxJVXxgwLuyw5/q6yhtOGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382252; c=relaxed/simple;
	bh=sS9FsJVE243d0WeteqT/1ZGnFSB10RXVtcZOuky7qhI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hEh145d0lxJwwqVbAlnxKyx9HzK/UPUFIF8w1T3SNzFX395M0pp7qCDp4Ub9wrUtpcfnEIUQhCqmXQD0xCHycq2gyEnZT+Z6lxu9SWMd6ZGLKjJaw3UbM+Nstsp7oCqtZMe58tIIYHWeAwxDRmkpJT1No//50q2kAaQ51gigpcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FxVrvtT5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f1c209842so1827273f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718382248; x=1718987048; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=put13URUC593SztdFC6LSEgjQ2u1ih6bSw5FHdIqhSg=;
        b=FxVrvtT5/24MA6CfBmF2RWozEMF9B88N3Hd+6dH84C5TzB6r5LX5sBr7Z8UujiooLl
         kNZk6yqNZ7j1OtxtpXv8u+usrI0BYtMXL8eC3tmcO0Qsoktp4Xhfs1CYXo6sHAxs4hiu
         4vreQdvG2ln9G5ZUKTaIHb7NkqVrhqC3wJNzl2TzXc3kVGafKZFO9/TgOomf8eWFn6jF
         k82pVlqG7RGPt6F05m+XiNAJuqvRKqIL1NBzyQMPV3a+NQzZ/FlieDNTKY57XiBmWJX9
         vKg6PnQb//JHoQ/8nV+txFBPzYdE9RGKrK9wz9J2NrNdq+aILDSuUnA9ga+tLWJNVnP5
         k5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382248; x=1718987048;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=put13URUC593SztdFC6LSEgjQ2u1ih6bSw5FHdIqhSg=;
        b=plhIxvQzbLy7MuzXoav8rsDWUH1uuOeeUaMlKFALKggxujRTLdHpyD1VqGhs3kp5Gt
         y8mYxtnD85HG14eONAVeXY1CYVvqrj8ZkgHg7hnrExNq88DXpa9sKvjiopLt9OSnXUjC
         c8gyKNb4VbVh6bBuxLxP8Nppwnn620KHACLm4D4PRW57DpL3b7BtO/2SlzjPza5nKM/L
         APR+kw20EwOFdXPynviCCuWybBJCesVRvGcz/43Lwmq6d55MffokjVa3v1/bgEZ9ARAC
         vQyYz2O1fuUVks1KZjZ1nIQPcd6TRYP0UhyTOC9+VLN2nr4XYR7ktXLDA/4V5sJTy8PF
         Sfnw==
X-Forwarded-Encrypted: i=1; AJvYcCWZqPoDSwcpLjHygNb+v2we9O9Fgr5upPwJwgSy3XKxl8ZaR8Hc+SrzGGiisgxBWx21a3N54+i9YBDIYmwNA2UMhTo7VNS9GxfQ3jJL
X-Gm-Message-State: AOJu0YzUkIZqwF7viHTCoo8U8RYezlfArGvM9XtlfoO8izesOZx9Q0Z6
	yq0NPuqumtkhmC8G3edf+clMS9PA3OKkUKfx9caEHakcaF5N79oT1gHT9pMUDjg=
X-Google-Smtp-Source: AGHT+IGMFRVbIiEZo+RBebjVEl7ueTmXDg735LDtznnpXDovGqgeT6L/jaYzgZuAW+s/dO7labznUg==
X-Received: by 2002:a5d:5187:0:b0:35f:1f23:691d with SMTP id ffacd0b85a97d-3607a780dfcmr2520291f8f.61.1718382247778;
        Fri, 14 Jun 2024 09:24:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36074e0e5adsm4931165f8f.0.2024.06.14.09.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:24:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFC 0/3] ASoC: dt-bindings: amlogic-sound-cards: document
 clocks and clock-names
Date: Fri, 14 Jun 2024 18:24:00 +0200
Message-Id: <20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-0-9f57d9e01834@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBubGYC/x2MQQrCQAwAv1JyNtAuSw9eBR/gVTysSVwDdrds2
 iKU/t3gaRgYZgeTpmJw7nZosqlpLS7DqQN6p5IFld0h9CH24xBxqbMSpulTs3OdbWmSJnxqYS3
 Z8KVfMUwra0UrjJQaY6AxBiJ2Cvh6bvLv/HyH2/UCj+P4AfjpwlOLAAAA
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5357;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sS9FsJVE243d0WeteqT/1ZGnFSB10RXVtcZOuky7qhI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmbG6lSLFDzo9pAh0PJ4DgWo/c5jJ2/VmjIS/DLHYZ
 5xoXzd+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmxupQAKCRB33NvayMhJ0XUiD/
 sFiFA1YgFp0/JZkEYOqbL3rvO5Ws8p5jo26BTDPI3abVKhJ8E2pvYLkHQ7pEsDdSqIZsbRkxYVODd8
 j1k/Nllu1Nil/h53HBA5l7BIAr0GOOy6huIrFZrIFCUI5YMBupf7eenYc1swD1F9ljt/aixxyFFZo+
 iU5iaG6wcY9PEUMC/RATkdnue29TYMTkOwiSAYOOQHhE1wZm2zfGUTlO+MIgXPxsiRbbVIE3M/mF0v
 hcziJDFbG18tEUFoSFbsjY5VUu1pXNp6HwZabdqohCjagdm3jZrRyJX0r2rpeMXhLvGhEIeqliNa/l
 6L9Sn+pRXJ2qONmsd6eo1L//s1F3CC72bpG82oWIpDa1CKYOoQp1nfaAvGesI7czBcTrY2rVxe9tNB
 fLNEhLsbochDN3GrJ5JEBaw8h22vvDzpBp37nXxSD6EMSBh6zQwdFwfmFpvbpxQN9l1z/M8LV3eumf
 kEW99rNM0vUFhVMkeM78RRYjU3xxu5f2nYpBi4paPihxzGxQ2jHqq9f65MyXvJtIf6UClcilYVNXFZ
 5tSP/QSpE9b0syvfZSvfbxS3l2BinUfU0Hq4Dv0IVRoj0O/AJwoimDg45qIIDlnhmR8/Ky9Buyi4Zm
 8JjtT+8HFX0VpoHmIoFx5H0v+UMi7MZxNRY/WCaMfsiojsmLWD5jcWLR5pLg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Following an off-list discution with Jerome about fixing the following
DTBs check errors:
    sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
        from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-sound-card.yaml#
    sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
        from schema $id: http://devicetree.org/schemas/sound/amlogic,gx-sound-card.yaml#
    sound: 'anyOf' conditional failed, one must be fixed:
        'clocks' is a required property
        '#clock-cells' is a required property
        from schema $id: http://devicetree.org/schemas/clock/clock.yaml#

It has been agreed documenting the clock and clock-names in the sound card
is a better solution than moveing them to a random clock controller
or consumer node which is not related to the actual meaning of those
root frequencies.

The patchset adds the clocks and clocks-names to the bindings and
finally adds the properties to the DT files.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      ASoC: dt-bindings: amlogic,axg-sound-card: document clocks and clock-names
      ASoC: dt-bindings: amlogic,gx-sound-card: document clocks and clock-names
      arm64: dts: amlogic: add clock and clock-names to sound cards

 .../devicetree/bindings/sound/amlogic,axg-sound-card.yaml    | 12 ++++++++++++
 .../devicetree/bindings/sound/amlogic,gx-sound-card.yaml     | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts               |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts            |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts        |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts            |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts              |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts           |  4 ++++
 .../arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts |  4 ++++
 .../boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi         |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts          |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts        |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts            |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts   |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi        |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts        |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts       |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts         |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi       |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts           |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts         |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts       |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts          |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts              |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts              |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi         |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts         |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts       |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts         |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   |  4 ++++
 .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts     |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts         |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts          |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts           |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi           |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi  |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts    |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts         |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts    |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts        |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts            |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi            |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts             |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts       |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts            |  4 ++++
 50 files changed, 216 insertions(+)
---
base-commit: 2ceb903a0c515872bb0ca0156bc4e568651f1eb4
change-id: 20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-2c642ccd2c6e

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


