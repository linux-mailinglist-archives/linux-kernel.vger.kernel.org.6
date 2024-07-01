Return-Path: <linux-kernel+bounces-236489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F0D91E2F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C331F223ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39F216C864;
	Mon,  1 Jul 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpSlIb1c"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632B16C6A9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845807; cv=none; b=MtAmryhrUhJDl88y09hoa9paiFiyQmgqUcXCiZQf6jOhKnvKDtjnRlbnoLTe57ahv23zc0/NpfDf6s+waToXNQVzHASj8yfzYD+MIMFG0dxT7BnlPOgA1eilxXB5vpA6r4XtiLsUil9fxnE0rR9oGiVrtpGiZN7T/AJF6/b597M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845807; c=relaxed/simple;
	bh=ie6t/Dw3PLvgkVooVZPx0kxNGFUcRLEa00W1zc7iT5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QPlgNdJMnZffYYZ4382ZYhvWUXfxzkvPTu5w0GIyRk3Q7/PCRc2Pk3YaayArTUVnaGXLAJ7youL4nRpsZuiZNO8Kn1eo9IkhWAIxkgGuHEFJ/uV27U+AfXwxHtQKS5tnthoH8wLfL/GujEQn+1K1DpH4DaoIkbUK5ehyGd/9f5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UpSlIb1c; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4255fa23f7bso22407975e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719845803; x=1720450603; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg3hDzp/KJVBDuQzV31kkQuzyuxk3ddum27jQvcCpXM=;
        b=UpSlIb1cxU2dNTSCCG9sowrqB8wv0hTbISuVfY0iVdeVYGHV+Qd5RDV4sXkDV4maBW
         0umFXywvPjE1y7bWp3wNGizPgXrlOD+oUawPlctskL/mZY/CT1mXTGOHAnmAI+0pyF/k
         RQjfUb7bYh0rlqWAnAMuL5XdMSKuC2t5FnGZ1gPI+tfgx23I9E1bqW71JKmVNyEkMNFq
         S2DlDFkZLDRhUvPwDzRtFKYlJyUkKhRXu6eCZOaNrsWA/DC/VKHeLWM8SsOttFJexDb8
         ltDOD+9EJe0xzprcmqcffOZg+gzbjY8XtjAnd9TNfS2VgtDxzCHJt9u1yDxsM6mKjp+t
         kd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719845803; x=1720450603;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jg3hDzp/KJVBDuQzV31kkQuzyuxk3ddum27jQvcCpXM=;
        b=pGm84vHvEbFtoKEgzdlfggJhL0KK9v+7qSdGo7gDtaep8R/oXeDKkqLv6xh3RG2YMG
         DBD+Qv3wMlKHB6RU0vcD66lOQEvFfXSpMIPAwU9z0AC8Mzj2MUUQtsnZEHTkHZ0i/cFo
         tyP+ZwPkHttl7E73je54v9sVaE0Nr6MliXJoQuHUPH2aU8V3yT6PHMiEOvYz0A59voxY
         FKsbcXRf+8Tq8VnZfv6sQYDUeevGaet1erf83dp15KWWPC4nodi+NKLmMI7PF3kB3Qi2
         tDSxA3Yu1RelUKW+LSTxY/TJrHxz5rx66jnp/VCTHeeRRAsXjOi7PXJEtKyns+35LJKr
         2FYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpOGJRvvrhEGrR7QIPkbr7c1zmlDDWtmLL0TDHbgDEJGsWf/lxgLwMW1Mf8s5+iqOSt5nJSxhNyaDbjg74PHyrjzhst+bFxA7hQMDh
X-Gm-Message-State: AOJu0YwdRs8CIHJTe9AQKYByLlXfvT8IPzB9P0k+teFIZOGaZoDF/RaI
	AHTtAx1wIqe/ci23of74Dm+5Zi3ew94E+6n36s0EPlQmLlYdm6J6xoCFFXw6QbL0c+fkcIsYc4b
	G
X-Google-Smtp-Source: AGHT+IHPQk1x0qUNQNuouhiX6X42SipUjswQCCzSV2UJ6phXBYVvw2f41FZLjEnkNeHolYU6zTZ2bA==
X-Received: by 2002:a05:600c:6b0f:b0:425:63a9:f96e with SMTP id 5b1f17b1804b1-4257a02f20emr41873955e9.36.1719845803146;
        Mon, 01 Jul 2024 07:56:43 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f99sm160062915e9.41.2024.07.01.07.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:56:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/7] ARM: dts: marvell: orion / kirkwood: few cleanups
Date: Mon, 01 Jul 2024 16:56:33 +0200
Message-Id: <20240701-dts-marvell-cleanup-v1-0-4773bd20691a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKHDgmYC/x3MQQqAIBBA0avErBvQiqKuEi3ExhowCy0JxLsnL
 d/i/wSBPFOAqUrgKXLg0xXIugK9K7cR8loMjWg6MQiJ6x3wUD6StagtKfdcKPVotOkVde0Ipbw
 8GX7/67zk/AE+/pzVZQAAAA==
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4031;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ie6t/Dw3PLvgkVooVZPx0kxNGFUcRLEa00W1zc7iT5s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmgsOiZ2PLfqaRRQu8WeXoaK4H21upICh/vyItu
 rY1qJSLKI+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoLDogAKCRDBN2bmhouD
 13MFD/9NY7o/hp+C+kah6u1wVVd4ffvcaP7lLNTv+1I+qG0/D6pusj8DD7vfYe7oxwxEQJxPOUH
 MoQ8dH4G0QYmWH6iaVR7xeK9VusjDXBQk+ySz0y7CBZTlmcSd0beTntKxUoFX/RukNYOt3n5xA4
 5i9RAI0/bWoVqC2x1WSVxWH+IuL3illi3u14dYc74vGTUmuRA7Jrkbt4US2SgunXNq72JnvzDyU
 Bt+La6LEKxVnYRWeEDDbzX14yiZx3khbH7zR8fJqeflS3wYty757MPRrVX9ShoLWOs+vK21u3kL
 eudxYu/MjL73kGgZRXAllgM3iWK4pT6/dlufWBLjsLt8vcV64n8HiLSU10v7+5ZsHC75tBSkctf
 hcus/im1NFnaBIcu2YPcGYoP1Lt41h4Imhnru62alGI1jm3XzMzUPJplpF+r5pZ32aIUnHHGrAg
 5pWIXc15hn6pCwBfOgyzojqMqPB792nr3t5wSGMQOSUQEMhX5BhpE5kXNaxQLEdZbb1H1VxAyZZ
 qF8vhXP4kYNcP3x4fzHULo70t8iJj+NaPt6GGnQsQsyQh0UDCvXYrZ1EUefU7GrXagyTZoKxyMD
 ngVrYQFP2vJvMUea9YpmxFQhVoeDobpRvvraeZrb6ObBztNjHeGX4g27ven9L68UlfakssEbns2
 /JzKb69/Ruqn7HQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Few cleanups reported by dtbs_check.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (7):
      ARM: dts: marvell: kirkwood: align GPIO keys node name with bindings
      ARM: dts: marvell: kirkwood: drop incorrect address/size-cells in GPIO keys
      ARM: dts: marvell: kirkwood: align LED node name with bindings
      ARM: dts: marvell: orion: align GPIO keys node name with bindings
      ARM: dts: marvell: orion: drop incorrect address/size-cells in GPIO keys
      ARM: dts: marvell: orion5x-lswsgl: use 'gpios' property for LEDs
      ARM: dts: marvell: orion: align LED node name with bindings

 .../dts/marvell/kirkwood-blackarmor-nas220.dts     |  6 +--
 arch/arm/boot/dts/marvell/kirkwood-c200-v1.dts     |  8 +--
 arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts    |  8 ++-
 arch/arm/boot/dts/marvell/kirkwood-d2net.dts       |  2 +-
 arch/arm/boot/dts/marvell/kirkwood-dir665.dts      | 22 ++++----
 arch/arm/boot/dts/marvell/kirkwood-dns320.dts      | 10 ++--
 arch/arm/boot/dts/marvell/kirkwood-dns325.dts      | 10 ++--
 arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi      |  8 ++-
 arch/arm/boot/dts/marvell/kirkwood-dockstar.dts    |  4 +-
 arch/arm/boot/dts/marvell/kirkwood-dreamplug.dts   |  6 +--
 arch/arm/boot/dts/marvell/kirkwood-goflexnet.dts   | 20 ++++----
 .../dts/marvell/kirkwood-guruplug-server-plus.dts  |  8 +--
 arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts      | 12 ++---
 arch/arm/boot/dts/marvell/kirkwood-iconnect.dts    | 20 ++++----
 .../boot/dts/marvell/kirkwood-iomega_ix2_200.dts   | 16 +++---
 arch/arm/boot/dts/marvell/kirkwood-l-50.dts        | 20 ++++----
 arch/arm/boot/dts/marvell/kirkwood-laplug.dts      |  6 +--
 .../arm/boot/dts/marvell/kirkwood-linkstation.dtsi |  2 -
 .../boot/dts/marvell/kirkwood-linksys-viper.dts    | 10 ++--
 arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi       | 18 +++----
 arch/arm/boot/dts/marvell/kirkwood-mplcec4.dts     | 12 ++---
 .../boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts  | 12 ++---
 arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi    |  8 ++-
 arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi |  6 +--
 arch/arm/boot/dts/marvell/kirkwood-ns2lite.dts     |  2 +-
 arch/arm/boot/dts/marvell/kirkwood-nsa310.dts      | 20 ++++----
 arch/arm/boot/dts/marvell/kirkwood-nsa310a.dts     | 18 +++----
 arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts     |  8 ++-
 arch/arm/boot/dts/marvell/kirkwood-nsa320.dts      | 18 +++----
 arch/arm/boot/dts/marvell/kirkwood-nsa325.dts      | 18 +++----
 .../boot/dts/marvell/kirkwood-nsa3x0-common.dtsi   |  8 ++-
 .../boot/dts/marvell/kirkwood-openblocks_a6.dts    |  4 +-
 .../boot/dts/marvell/kirkwood-openblocks_a7.dts    |  2 -
 arch/arm/boot/dts/marvell/kirkwood-pogo_e02.dts    |  4 +-
 .../dts/marvell/kirkwood-pogoplug-series-4.dts     |  8 ++-
 .../boot/dts/marvell/kirkwood-sheevaplug-esata.dts |  2 +-
 arch/arm/boot/dts/marvell/kirkwood-sheevaplug.dts  |  4 +-
 arch/arm/boot/dts/marvell/kirkwood-synology.dtsi   | 58 +++++++++++-----------
 arch/arm/boot/dts/marvell/kirkwood-t5325.dts       |  4 +-
 arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts  |  6 +--
 arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts  |  6 +--
 arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi      |  6 +--
 .../dts/marvell/mvebu-linkstation-gpio-simple.dtsi |  2 -
 .../boot/dts/marvell/orion5x-lacie-d2-network.dts  |  9 ++--
 .../orion5x-lacie-ethernet-disk-mini-v2.dts        |  7 ++-
 .../boot/dts/marvell/orion5x-linkstation-lschl.dts |  4 +-
 arch/arm/boot/dts/marvell/orion5x-lswsgl.dts       | 25 +++++-----
 .../marvell/orion5x-maxtor-shared-storage-2.dts    |  7 ++-
 .../boot/dts/marvell/orion5x-netgear-wnr854t.dts   |  2 +-
 .../arm/boot/dts/marvell/orion5x-rd88f5182-nas.dts |  2 +-
 50 files changed, 230 insertions(+), 278 deletions(-)
---
base-commit: 9c9a5aa3a60dc9e1e2448c29f346385914052642
change-id: 20240701-dts-marvell-cleanup-1c9fcf6ae439

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


