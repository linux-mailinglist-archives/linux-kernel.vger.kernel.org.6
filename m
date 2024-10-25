Return-Path: <linux-kernel+bounces-381204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2399AFBED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4418F1F243F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088111C7612;
	Fri, 25 Oct 2024 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sm/6RqlU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FE1CACC0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843434; cv=none; b=fYpk3Au5ZzyowIIbunInfS4MyRhOHWPyMNUZQJkc94eE1spxBHiedL4Rcjz1jRF6Dv5hd+vW6nq8qYI3hqYH52hjQNs5unh8frUXclGqNkvR+PaaeySCeawnral1BPlrAxWbyQk1oCUGYOv7SegUBxti/9PiVYJGnuU8ZhfaXgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843434; c=relaxed/simple;
	bh=Vd5ZJMYgt+siPRttC3L85GxVr7ife3eRKgQvs9zCIUU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GPNOXy5sW4a/Oqrv7Rs4/zft109sL1Qu+xMqOPYcSLtMqPy9aLj4BiiHth6Y69ay0WnMdxKOvP93ytciIP8fLUN/awOF7qIltVl1fKrMqwmA0p+evtCaep8XiKytCqyVH0jFnLPoT0YaBIR3N/CVDAM0Si+qiOmKneEUPtXlEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sm/6RqlU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20caccadbeeso17235695ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729843432; x=1730448232; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XBC4RSh8TfpYO7N1cJ3hGiE9IZ5JY14wIot0+OdLjw=;
        b=Sm/6RqlUXR5ehjU4rGJxV9/U8T0PrAtjbtGSrglGw4rR50UMPdC+3MyuINme2LYRMO
         fRkJg0vlc00QMc0LcE//8Q4xgjc5quUcmAIBmtQK1v6ntC/9KkZ18sZIc3kqStIvaA/i
         bbaCC46Y2l+qivB+TAqeY2i513LOUShwajCMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843432; x=1730448232;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XBC4RSh8TfpYO7N1cJ3hGiE9IZ5JY14wIot0+OdLjw=;
        b=d9oxTNf2nSq22W/02vXemJahbBtTFoHcUdPauAZ4DCK02PrRWO6DojZPuvK+aoB7+0
         hWdT9TZn8B7dxEU3Vd1vqmmGtzBkKmLnkBymlSuDyLX6KMUKq4U3kOax/ytpqeT8jVR2
         JJCVF6LoO9Ahfc7HSW4+6UEZ0lft3vUZeVsW1GjdSBBdhN3i2vtx3IyaxUQHxiMTfeua
         ZOajcoIrz3kXsXjF2RCFuOFs+cbZgZH5CYx7wFpH+7T6V+f5vTupHUJR6ijN55CHK+VN
         qa4vuA/MWWDbNgqiIWFnl4ljSDW/bpsR8dRflkjCiMOHzBiOOMmYWX/1QDUheoxX9hw0
         4/6w==
X-Forwarded-Encrypted: i=1; AJvYcCX86sDq/ZV0aWLZbzSBvY9vqTQmSRrpbN97ZTOrp6M9QksU+43Uuij5qDDu89N90l6BHzb0sVWPr/doQBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNa3MIuvLpzYeaJSZ5SF+Qzx1YvE6fk61TzRAkHeu9dM5HPqG8
	Sd5r9pzl+pWrbn4xLQe9khXZHgi4ZcYjlDB8lJRqvjTjSLZFHUk08f2CrzurQw==
X-Google-Smtp-Source: AGHT+IGn2s+chrglz5njxh1erJWL0JkpBhiVbjoyPn5g8eTfhQo4rJVyhvThXay1WwGBJaAL6fX6dg==
X-Received: by 2002:a05:6a21:3984:b0:1d9:275b:4ee9 with SMTP id adf61e73a8af0-1d978af6913mr10351102637.15.1729843431913;
        Fri, 25 Oct 2024 01:03:51 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:5a9f:16cc:8d5a:55e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d025sm558120b3a.101.2024.10.25.01.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:03:51 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH v2 0/4] arm64: dts: mt8183: Add i2c-scl-internal-delay-ns
Date: Fri, 25 Oct 2024 16:03:47 +0800
Message-Id: <20241025-i2c-delay-v2-0-9be1bcaf35e0@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAONQG2cC/1XMQQ7CIBCF4as0sxbDEK3iqvcwXTQwlElsMaDEp
 uHuIjuX/8vLt0OiyJTg1u0QKXPisNZQhw6Mn9aZBNvaoKQ6SS21YGWEpce0id7WUeOVSDqo/2c
 kx59m3cfantMrxK3RGX9rU1D+KRmFFL1xZ31RaNDiYHwMC7+XY4gzjKWULx3Szs+lAAAA
X-Change-ID: 20240909-i2c-delay-6d202918ee0f
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>, 
 Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
X-Mailer: b4 0.15-dev-2a633

Add i2c-scl-internal-delay-ns for each device.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v2:
- Add missing Signed-off-by tag
- Link to v1: https://lore.kernel.org/r/20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org/

---
Daolong Zhu (4):
      arm64: dts: mt8183: fennel: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: burnet: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: cozmo: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: Damu: add i2c2's i2c-scl-internal-delay-ns

 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts  | 3 +++
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts   | 2 ++
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts    | 3 +++
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi | 3 +++
 4 files changed, 11 insertions(+)
---
base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
change-id: 20240909-i2c-delay-6d202918ee0f

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


