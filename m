Return-Path: <linux-kernel+bounces-324725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EA097502F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2291C22513
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2BC153BC7;
	Wed, 11 Sep 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kI4n3q5H"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB55186E2C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051924; cv=none; b=neTs7UyqX3rpmdGEVjwGRfqdnfNX9y/CBwAHMIA/EqgRKFTa7bPAom4MvMuOWAIGMy0F0R9LqjEDB7eVbdMdlPPqzJ6TnAxtRxD4st26ZAEEUh5k/Pjes9V6GyX6oW/XbC+V7ysyX2jC3ueViI3zfSoDY7uOXUH2sUzLfdRru8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051924; c=relaxed/simple;
	bh=65thc9tzDm6H7x+WM+O90px7JCOHuD7dDIpYweu1nhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7PyZ+Vi/Br4UVSEoQ5MV3I71ZVljGhk9861NJGYlnUhet/jPEFdVEmHuFYSGjf1DjenYTMwJ3f8aR+zU3cJdsGxQYL1NufetYUBijoaXJ4+vXz96YBkWDWqdu023Aq+fhco0yt3nRmvKRr2vmEPP5tcuf+k2rHM44yrkWgHYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kI4n3q5H; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so1708821b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726051922; x=1726656722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bntFV8pZ39/vd/ElxPtsnTHwc8+5+H7FcNeX9IYOSIo=;
        b=kI4n3q5HtCu9s1kGTEqUoqH8qr+eZ1mBAfbk4ThueJ5DIWYHWwxjn7zB8aw1TbJ3W2
         aUYXBIWqtzBHywfgy6wV9guQbVDxwh0ukA0f1MWOnxpjTZ/ZqZS5LLfu4L7fQxYXnb0b
         kUb/rBbApv1SiDAh4mj5537QVTt2Fh3wQu/l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051922; x=1726656722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bntFV8pZ39/vd/ElxPtsnTHwc8+5+H7FcNeX9IYOSIo=;
        b=BBMe5dPkAeg9RbY/4fNr4LriB7BHNxtRebk0/GOUIbyFMSfLQticHaEc6wbAHC0MXj
         4IbBZ1EqgGzB8etwa5dgIoqDA6PGnHMfZBefECwc3CWoKsFjM4d1Up7Xq8Mh51VIry0E
         /5vMqpbcUgs5QpzlwnI7xARx0fPDt6hhWN1LFGvXEmssE5mBB4BiV9AAeVo4jcxZDxlV
         Q/fnMCL4nR8YcjYLIE3Bvo5QYuC90EBfifQZ6aZt4wsykR7ae4GGzzxUyy7Jw8T52Izu
         R6L2PK6KweXudJaXojD5Tw22oWwr1IPcvh4xuFcIcciXN/KwWFzRkbu39ghIs8t2r6Dj
         vGKg==
X-Forwarded-Encrypted: i=1; AJvYcCWsTZr7l94pO8LNyVsKBCQDnDX1hGj10IAMpx+VdC3lgmWW1WekW295u48UeiUk7JZHBcd5yRYn3xIFs1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0FO4pCU9fzFgh/ymOLN0UtF7GLHX/KgtYe8yhoQsuWH6/AYJ
	zl7HPYUmu3UoKyBwCIyC1lVAagipdLai81E5kg1J470W5bvsyqm9m3o4ckN1Xg==
X-Google-Smtp-Source: AGHT+IF0o/eQIkWaTGkC08fE/boVNtrfPBZgXbaJDeqLRKBeyA2VebJ72Ic2BKlFFjweXCqeEJZ52A==
X-Received: by 2002:a05:6a00:9484:b0:718:d7de:3be2 with SMTP id d2e1a72fcca58-71916df1f89mr3252259b3a.14.1726051922429;
        Wed, 11 Sep 2024 03:52:02 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8242b3d13sm7147352a12.52.2024.09.11.03.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:52:01 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/8] Add platform supports to MediaTek MT8188 SoC
Date: Wed, 11 Sep 2024 18:51:05 +0800
Message-ID: <20240911105131.4094027-1-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series is a subset of the previous series[1], focusing on enabling few
platform functionalities on MediaTek MT8188 SoC, including:
- CPU performance controller
- IOMMU / SMI / LARB
- PWM for display backlight
- SPMI for PMIC control
- audio
- socinfo

along with the corresponding binding changes (acked in the previous series).

[1]: https://lore.kernel.org/all/20240909111535.528624-1-fshao@chromium.org/

Regards,
Fei

Changes in v2:
- Replace hardcoded AFE reset ID with correct definition
- Added socinfo nodes in v2

Fei Shao (8):
  dt-bindings: spmi: spmi-mtk-pmif: Add compatible for MT8188
  dt-bindings: mailbox: mtk,adsp-mbox: Add compatible for MT8188
  arm64: dts: mediatek: mt8188: Add CPU performance controller for
    CPUFreq
  arm64: dts: mediatek: mt8188: Add SMI/LARB/IOMMU support
  arm64: dts: mediatek: mt8188: Add PWM nodes for display backlight
  arm64: dts: mediatek: mt8188: Add SPMI support for PMIC control
  arm64: dts: mediatek: mt8188: Add audio support
  arm64: dts: mediatek: mt8188: Add socinfo nodes

 .../bindings/mailbox/mtk,adsp-mbox.yaml       |  12 +-
 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      |   1 +
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 321 ++++++++++++++++++
 3 files changed, 331 insertions(+), 3 deletions(-)

-- 
2.46.0.598.g6f2099f65c-goog


