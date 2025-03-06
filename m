Return-Path: <linux-kernel+bounces-548645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBAEA54775
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A8218931E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29AE202C58;
	Thu,  6 Mar 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUid9j3C"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C91FDE37
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256092; cv=none; b=PRCJi5F3dMvv0dvkXUZorGWNOMj4et8hgS5S6qtpXvdj16u5k3oVsqSy/GH4X3UemwBrwpaBR0wDgQd8IEgvxih/Aqtea2ixoBHA5eCCBCA+MjtKbeSh5eMC7KItKxdui1/gRAlvNOj3wjOkkjloiaH3VF21Ey92YN7+hOrmGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256092; c=relaxed/simple;
	bh=Eb7POQGunjSjP8253tuV8Q/qASH50C+05IivcjCHmm4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NKfS1t3XDppzcm/rYmhFdKUzxDh+kZKq69qVBY5z1w7iLkJ4vkTGPZ+s46lBLuxa0ji9OxffdGiafwTC/PujuPf0n+1/bqWw1Tw8BW76VLbC97bqIiOTn86WBhAlAQ4BfWjbmED5+2rAMOLoRgaA5gANSjP3XAy4b6nDK6lIcVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GUid9j3C; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso701571a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741256089; x=1741860889; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gea8RDhxW52XRzq4nksHK4G+nluCQdGJ7LngFtiewMU=;
        b=GUid9j3CNEGR5PKeXsIF1jHf3M53CacaM/BkJA8fOKzPaBkznlW1xdJGP8Zzad6P0f
         MEth7R5KTVrq3KmnY/GVeC8DWovh1uBga4Zvae3LB40BSgaXuyTcqcsb2J+rQW4wLt5p
         eI/4rBHnbqfyQppKe5mXCrf0GyD4hUJZEIscC24U8aAEUdUYX01sprenZO5Gaii7hjEO
         dN2+kg9thQ1yrzJ8gHCTzDV5LvtKsAw2TGeE4cPkkHNNls53Bfp2YPO2S0Kg5ICCUJYn
         z3Mgfqi4fcs5oKT9bDEfd9iaW68u8KXsQDV4/4Qdlsi4r3e2jxxZQ9tHuCKG/KmoX4e5
         Ba9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256089; x=1741860889;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gea8RDhxW52XRzq4nksHK4G+nluCQdGJ7LngFtiewMU=;
        b=SRQ0wGr8pbmPom6S2ghY7K5UR1XEVjP81yi6kRMx8XcWmuyHwt0MPzhfxizsc0FLHs
         +22R5YhRp1OGWYRPKR3zH1dEwnSYvWn7gMyWJnz1nUteV3jglMPw3js7hmnGoZO/fZbB
         E15h9jQnXFQp0lGtdoEzRtemCzZ7E16P72NurTclR3gwFXPZeMIJN3WkdGu+m/OD47JT
         GuEetDk5BaF7lRFvBeXAPwXUUSQ4qn0/T56ZcFsn8X27V7KSBeKJApfDVnoheFr4irSK
         wYKI4gLEo2VnMTdhyuwgakjIC24Hn29aTGWO8EscHhXntQ3CobyvbzI3/Mp5iCwEeUTI
         TeLg==
X-Forwarded-Encrypted: i=1; AJvYcCWBhjWvB7bsZHZyvb94mxjnbTIS4DUAu9oiiQ43rnn/Ox/vx57RGVumCI3VURsTAb9dKEsfi9soR6V5fjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8BJq6gOBH514yrNbmChg3xaxGfMi8i94Kj40XbvaBB/coAGZ
	7a4hRZHHALEGHs6AA/6Vm5E0OptKG8q9uniF3V3SXa61IwwNxzKptWqVFlrUzFM=
X-Gm-Gg: ASbGncsRjzo7CFnKREVnQsHgcNEeW5QI/gYnKBOLVCLam2/t+rMYbo50/hDHACWnBrq
	Ml7Sb3vhtll5/ypDMd0rTAP78VdokZwMD0uDfMySflAehmZWDYAOLv7gkri4BfXfs8iZEqQaq3+
	KiuN8hJRnRm31uMC1bnMnCUsyweyKjhYbO4A4JwCYydQ77xe+e8F6STFqo4iwjGbwkxO+b3Cg3O
	rY2Ikf2ebjpvNNq4cUUP25e6kX3Q0GyFoqFZbqpYSDtdpdcFQHzcAzbouBf0m4mRGlZAsVPmNDZ
	e3DLqEdTSu/qpraHxckgBVzGSruDR9WJQRgTUoM5p7MqJov5t9Td4XlXsRPxm3UGlagw2Mb4fSM
	S0VGAaHGeT0CKMCrcAHJuljOkUm/T
X-Google-Smtp-Source: AGHT+IEgLGcDGlkE6kWAXN5bUDSnAdelHUlOLrSKWe6iPW2qcxJJbof7KnLLgyUzGGWjzI7ZpD00UQ==
X-Received: by 2002:a05:6402:434a:b0:5e5:c0e7:f455 with SMTP id 4fb4d7f45d1cf-5e5c0e7f696mr2569873a12.8.1741256089115;
        Thu, 06 Mar 2025 02:14:49 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a6af7sm708972a12.33.2025.03.06.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:14:48 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/3] gs101 max77759 enablement (DT)
Date: Thu, 06 Mar 2025 10:14:45 +0000
Message-Id: <20250306-b4-max77759-mfd-dts-v1-0-9fe8b0eb8123@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJV1yWcC/x3MywqAIBBA0V+JWTdgD7X6lWiROtYseqARQvTvS
 cuzuPeBSIEpwlA8EOjmyMeeUZUF2HXeF0J22VCLWopGKDQtbnPSWsseN+/QXRG96TqjrDJOCcj
 lGchz+q/j9L4fWtwzJWUAAAA=
X-Change-ID: 20250306-b4-max77759-mfd-dts-fb88b6c6bd60
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Hi,

This series enables the recently submitted Maxim max77759 driver and
updates the DT for the Google Pixel 6 / Pro (oriole / raven) boards
accordingly.

!!! Dependency note !!!

This series depends on the corresponding driver and DT bindings
proposed in
https://lore.kernel.org/r/20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org

Note that in that series bindings and gpio driver are accepted, but mfd
and nvmem drivers are still waiting for review comments.

!!! Dependency note end !!!

This gives us some extra GPIOs, and enables NVMEM which is used to
communicate the requested boot mode to the bootloader when doing a cold
reset.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (3):
      arm64: defconfig: enable Maxim max77759 driver
      arm64: dts: exynos: gs101-pixel-common: add the MAX77759 PMIC
      arm64: dts: exynos: gs101-pixel-common: add nvmem-reboot-mode

 .../boot/dts/exynos/google/gs101-pixel-common.dtsi | 75 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 2 files changed, 76 insertions(+)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250306-b4-max77759-mfd-dts-fb88b6c6bd60

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


