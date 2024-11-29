Return-Path: <linux-kernel+bounces-425248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6C79DBF5C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 06:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE76163B58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3474156991;
	Fri, 29 Nov 2024 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eRALDRZJ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89340BA4B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732859849; cv=none; b=mFaZ2IKl363QMp0SKEunA9nN8dD6WoZEsm1jw4UiX0ZGM0AjZ+vusoCwcbm/Iby86mqDd5wiCiiBZSj5CxEqRoe9U/eE4dFixZVcHDzwD/0QaFQfHQgI+LZAKxocKX+WauJC+mlxOg5SEoQS1XrB20CUnQu57yURZNTO/zf/Fuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732859849; c=relaxed/simple;
	bh=2d22fSXH3xHtYPQeuQ5/HB+WWNcQefsX3YBG8H/58B0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLODSkRmZ6C7dTAGQiU6qH11er6ssfq1SZGwi/YoQmKLpEHAJI2L4SjOLL/aZ25cmdoBjHKIcXOlVbJQYCiM8lzfbZbEFWVr3eXrphqaeV0MAXcKM6wdnUo2Ut8i7MK81+z928X/3Iowr6prkudCHgnxY2V2kf5D7xmYe8zVtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eRALDRZJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53de79c2be4so1732810e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 21:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732859845; x=1733464645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w9WF3O3Q9CqJ+jQNAGLBDdeZMuKGc8yveqCJFxa21hM=;
        b=eRALDRZJ2l8B6Rq+/V+W7pr8hF/WSwCihJ6xVRx0OrPiBI8Ce3g56K3Q8mpXNPCdhu
         Gy8PbyvE5/nkWmPvW0YiOjw3azQQm8Ca/lwM8qwLdd7qhe5omRio40B79BXpy1DqE2cU
         iSBoEn7Fqykwbg16NIiPpsxtXcwEZZPUh7R2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732859845; x=1733464645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9WF3O3Q9CqJ+jQNAGLBDdeZMuKGc8yveqCJFxa21hM=;
        b=lXxlnstNjQILVcgFjfcMxsnZ6ENLq67cFhwLqb/co+aBe8G21MgK9BLp/haWIOUZK8
         QPAtOQb3hDEgiblDMHUwCsoOotAqX0CgHinf6XcqiV/uKmSn3Lagwsf296Xs3AeZT6D1
         w85HpBhNsAiZ31aqrWxpZ/1/GhX5xbzGLThfL46ugXtrYbeZ4DK7og5e0HDKHkFKoRd5
         V8K7m2AykSdXMFmLfbmyXA/mJ6xNKfsH/KeaaxlUzvD4zgb9XATsMbVATGZFpuM33Bnc
         CmZCOrCd3aRTmvI7cKE/cbNPdpJfS913kgB3LiL0QeC5UEqcU3dPLe9qLIG/oZ+XqeIg
         U0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHdJIKDzrnHSTfsOTAlEquTUZPeZSkFetBDEqo1if2aItX9xCt8fwVnyGJsNv0vTHoXLsjjA6sE7E0Y+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gDkB+KNfZ4SL0AUW1GYOqbMw+LnDISaS+H9goOzBm5RYZLcp
	Yv+WXQ0ggZn8jd6lmuKIN7aMnkz1uT7yQn9ooSHQfy8p02/6o6sb2dtd35uH1Q==
X-Gm-Gg: ASbGncst5qY3Q1vUhsutQJ9QEErx1DnMHwAU8iaFI2qrpweo1173SNz6E0Z7ZQqZdUa
	HPjASbMc7dPU2Ny548BxD3q6e5ijADEyGEx0QPmboraz51ulHVaMyMF7425Gh5MyANDXmNogC5J
	JuN2Li6gc68uvbz+kHh0XKZSDIz6lsNOh/+fYMGKsTDeFACo+/972JvC8FpP5VDJaJ9i+KRFbQG
	mFP2Z+6IMmST8ZjLwC3mw50q+GfhnHXd5HpnbM+xlBLGRg252yzdVuFdM7IDTdFPE4dhHYRSKGc
	PN8cbYU7
X-Google-Smtp-Source: AGHT+IE65JzRNArxxc+ToexNBzoPm9HjhpdDJXXa/EKqSE7i98HFux8rxp92UCOg27WO0Cy7mDBO/w==
X-Received: by 2002:a05:6512:2355:b0:53d:e41a:c182 with SMTP id 2adb3069b0e04-53df00dc9afmr5377517e87.31.1732859844507;
        Thu, 28 Nov 2024 21:57:24 -0800 (PST)
Received: from localhost (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aa599955662sm136615766b.190.2024.11.28.21.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 21:57:23 -0800 (PST)
From: Wojciech Macek <wmacek@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Rafal Milecki <rafal@milecki.pl>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Wojciech Macek <wmacek@chromium.org>
Subject: [PATCH v4 0/2] Add support for Starmie Chromebooks
Date: Fri, 29 Nov 2024 05:57:18 +0000
Message-ID: <20241129055720.3328681-1-wmacek@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the MT8186 based Starmie Chromebooks, also known as the
ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
a tablet style chromebook.

Wojciech Macek (2):
  dt-bindings: arm: mediatek: Add MT8186 Starmie Chromebooks
  arm64: dts: mediatek: mt8186: Add Starmie device

 .../devicetree/bindings/arm/mediatek.yaml     |  13 +
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt8186-corsola-starmie-sku0.dts  |  31 ++
 .../mediatek/mt8186-corsola-starmie-sku1.dts  |  31 ++
 .../dts/mediatek/mt8186-corsola-starmie.dtsi  | 465 ++++++++++++++++++
 5 files changed, 542 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi

-- 
2.47.0.338.g60cca15819-goog


