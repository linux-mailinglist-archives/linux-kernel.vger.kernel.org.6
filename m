Return-Path: <linux-kernel+bounces-381514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F09B0067
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE3E1C21A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3831F1EF096;
	Fri, 25 Oct 2024 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kniwZhWZ"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CA18BC0B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853162; cv=none; b=ha75XYl+qExRDmbmyGrA503l2DmVz+YO8BsJPaKa4R1O0fhCiWDsZPN+QmxB8ojFxuADwvseiA76YOJHcRP5w8aG1vpwgZBBEpCb+XDFRk7VZSBAM86aSW8JYFu4WKfJ0qI7IjajaVM2SB6yeMxBwar/+37tINzvtK5XXIhKj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853162; c=relaxed/simple;
	bh=glzZvvtMnrNVA3ZU2o91oo33HmV5OMU7rrTm5EWNvBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMY7pMw7H6PJb+AdbbZU9/mp0x7pyOPvC5GQwFjmH7NCoY6g79r1OsfQPqPd1/3PTsrqs+hZJQmoHr7pjfkdvtO8uClirDP+IWXkTkr1wbr4tSpU1oq7+AQ1F3tB309LMUdVmQmQvlVM2NqHW+qIQhTG+4bkn/eKTcqVNhDLBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kniwZhWZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7163489149eso1309596a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729853159; x=1730457959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qYdMoYNHEEjU8R4jRwxYNDvg+V+aPZxty5Pm7LhAwc=;
        b=kniwZhWZtx5HQPxo4BPTHhrVzAuBNflyupyvwRpGTa2tMpQH6Bo6Yzu9lp7xHBmorS
         CcjHKxA7UyUAAamb7ZVqWqK0zPhctY5CQTqhKI5UNI6MlBeeiuJtI08dQHilqOSd4RNC
         Nb5finrktQM3ZV1d6DhqUm7D8vS5lHzgzVp6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853159; x=1730457959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qYdMoYNHEEjU8R4jRwxYNDvg+V+aPZxty5Pm7LhAwc=;
        b=hxW/OvOqOI0jJs7PJLTB7Q4awOf+/za3sWyyOe2bJ/vMag2mas2oGst4UZDAeVcI/X
         EQZzRmvFnQeulW36Ou3Zrge7ROo2BY592vH9aa2WH9Qx7V9sqETjhwTlzwmvcCodBrI0
         BrpDbdtiiKUNS8n/8GN0PA3h/NMtOPFGDUwXdKmdPPoT89QGkOr+IDCKHDzK7rYgXJgq
         Mws1oiEwpuROpxtDHH67Tcq/ZAxFyTenQcWaZ6xvCewL5yGojNmGjrqjVsiSQklHAoj6
         S5lxGkRM+KTu+BgLAmA5M6ULAXbKqQYvhHbvfKd04dFu8YcPxcFHtCtmwQBqEvvWyycX
         tXYA==
X-Forwarded-Encrypted: i=1; AJvYcCWL23Kw71gfAQWzP7C1kZWW8Xr6GJw43qxMXe/698QhtEMHAOLIL/uARsYCi1iR4pA2nEdMUuhTNOJkcaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwAHKFTSidtUR2SsScaDeTRfE2QcCezy5qsrK3law/YyJoE9d
	Tq63xAw4a30kQOZjuT0Sr+9ubwvTR4SmwFd+GzpUNHWGrTu1lk5DL9aKdwPI8A==
X-Google-Smtp-Source: AGHT+IE/jF3qeEh2sSM6HPYBIUpFWAzndUsngpMsqXOHaVXBbGKPEsKfMjMtDshVaZr1AnM6b0wOrw==
X-Received: by 2002:a05:6a21:31c8:b0:1d8:b962:6087 with SMTP id adf61e73a8af0-1d978ad70efmr11190210637.10.1729853158931;
        Fri, 25 Oct 2024 03:45:58 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ebe1:dd63:343d:8a4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d089sm829548b3a.99.2024.10.25.03.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:45:58 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Steve Lee <steves.lee@maximintegrated.com>,
	Trevor Wu <trevor.wu@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 0/4] Update properties in two ASoC DT bindings
Date: Fri, 25 Oct 2024 18:44:40 +0800
Message-ID: <20241025104548.1220076-1-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi maintainers,

This series includes four patches to update two ASoC DT bindings. The
goal is to fix dtbs_check warnings found with DAI links and audio
routing configuration on some MediaTek SoCs (MT8195 and MT8188).

This series doesn't introduce new properties - all are either commonly
described in existing bindings or are available but undocumented.

Patches 1 and 2 focus on mediatek,mt8188-mt6359.yaml, adding two
vendor-specific properties and updating the DAI link pattern to be more
generic.

Patches 3 and 4 focus on maxim,max98390.yaml, referencing
dai-common.yaml and documenting a hidden vendor-specific property.

Regards,
Fei


Fei Shao (4):
  ASoC: dt-bindings: mediatek,mt8188-mt6359: Add adsp and dai-link
    properties
  ASoC: dt-bindings: mediatek,mt8188-mt6359: Update DAI link node
    pattern
  ASoC: dt-bindings: maxim,max98390: Refernce common DAI properties
  ASoC: dt-bindings: maxim,max98390: Document maxim,dsm_param_name
    property

 .../devicetree/bindings/sound/maxim,max98390.yaml  |  9 ++++++++-
 .../bindings/sound/mediatek,mt8188-mt6359.yaml     | 14 ++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


