Return-Path: <linux-kernel+bounces-320752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1523A970FD6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D88B21BFF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEC21B1429;
	Mon,  9 Sep 2024 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ftN7+ztR"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED241B1415
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866951; cv=none; b=q1o/3d3KUfieTdL4bgdOxj271dLfE5QGw5kSZLmWquOTjceFQrcI5X5jlYnvYh5o8DX0BqAlk7SkY8TNfGzOtwRgoCK3Ic/BgqpUak9wSIVfnu1/gtvIOnRRm3uCy8No+x4zHyiNdZRl1YGk1+ayBOAaPzl9UgMSo2w2KTNWPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866951; c=relaxed/simple;
	bh=B4u0FoiKzS4geGQpljMFZtO6reAEyDwhU97YzqbrFGc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s965+aHVjdFpSvVgJ0+8cBi1/SpOtZAMlwBI080GWHLGIPP6cKhz/9fUZdtdQ/+faXuj4L/Pjp2/zwVbs7YXmoJCKLZwScayCUgmzvirmFW6ndin+uSoK62eAUT2wY6qzAMz4Xsj+5Gr9Sf9tat11PW5W8R661haVUQrb3YbQiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ftN7+ztR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d7a9200947so1038045a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725866949; x=1726471749; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVFOmtfgNYZTMylGXkVJ1SESCtmEefxlCEbYo1wTLz0=;
        b=ftN7+ztRnDOVqwurDTTDg0762Qch+2ZG6myjYFRPPkswcTfcQp0075eIY/Z0D7AaxN
         KT0itXVUuvTI93hibvDQM2expsjkkSzVuFp7+2Fwt9Fu/TGi5URnCRP8kHLg9uWdyaLH
         ED80UjKLxK+XvTkb55SAEnQL5BwpklxArH93k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866949; x=1726471749;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVFOmtfgNYZTMylGXkVJ1SESCtmEefxlCEbYo1wTLz0=;
        b=AJ4qAQdGcKL6j/8pzw0I7rytUIGuFj+40fMOxHHw88Wos+W+RhRehakmYsofT6JjJj
         pEIERys2eXNZaRv5pLS5kA1u4UJ5iNkESQ9NCRA+3FF/cyU40btq0onBIRHjgQr8qAfs
         7PCy5g6pqHqHOQao3csuRyRAKAYB69a4rVEPBjRAD8qgJV13/+okXo92fkfTQdCWVZZL
         cyfROFWN4HBZZKIYg6nJ2CGErFezcuQWwInTTNI5R16DQ8MRI9uz9aG4hrMuC6nLHLPp
         zbCzxZ3zY16wqiRHrKSPincHDAsDGHxnyO20o1TAcafrmWP1LSIVzcnnSBO/NU24GzZJ
         iJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCVuDp17YzSkZLBFeAC9v9BpUFcnRRBWUHuqNg/WxuV2PlAepgFBELaxLIZHTmTTBfhHLJwBcpsr2BF2SL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk6ONNnVcKuQm19qbeueCWWSxQD4/aazFEBS9tVQ+Pt6eMAtpl
	61UhsPVUmJ74PxAHK+hAfNLLj/5OkL5HGK59XGtCtjgWWuzSEXzHbyy58Vxigw==
X-Google-Smtp-Source: AGHT+IH5sLd+IkfBZnv7xdaGZ/tdqLmxM4M42CSvGfTJj9yeZEZWbHzCNvQ/4Occt7qYqQn7yQJusQ==
X-Received: by 2002:a17:90a:e651:b0:2d8:f99d:48d2 with SMTP id 98e67ed59e1d1-2dad50fcd09mr8435397a91.29.1725866948695;
        Mon, 09 Sep 2024 00:29:08 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (30.191.80.34.bc.googleusercontent.com. [34.80.191.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c3c51sm3841065a91.21.2024.09.09.00.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:29:08 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH 0/4] arm64: dts: mt8183: Add i2c-scl-internal-delay-ns
Date: Mon, 09 Sep 2024 07:29:02 +0000
Message-Id: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL6j3mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNL3UyjZN2U1JzESl2zFKCgpaFFaqpBmhJQfUFRalpmBdis6NjaWgD
 vuKmQWwAAAA==
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
X-Mailer: b4 0.15-dev-7be4f

Add i2c-scl-internal-delay-ns for each device.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
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
base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
change-id: 20240909-i2c-delay-6d202918ee0f

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


