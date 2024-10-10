Return-Path: <linux-kernel+bounces-359024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D1998673
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C834B242D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004961C688A;
	Thu, 10 Oct 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmtfawSj"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28D1C0DFB;
	Thu, 10 Oct 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564381; cv=none; b=GTxmvRiSAarvAsIUU8l3o88M1BRh9Ms2J6MsF2DOboiiF9Hu7QhzPJVjx4dRBf6fUwKo7MrvUp2VOyWLeWV77s903vOUK6JLzOmetimtUVuqBKJiBm0aybO7UH9x21F5fayNTyfCFooM/Gd0+1anVaIeq3jnc68nF63wxuaY2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564381; c=relaxed/simple;
	bh=6DMpKg7iF1InRHiX8ahI4jSd/sYlueiuWuoyrkLxwtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMwnexQ78qPKEmVVjqyLc9vTkO0sITsL7LfGES1SyQdwmGFHkKXeXdiQE8ag00rHaFV8wFSWv8Agnm5l9P0ydzbP8c4MsRTuse3HKJ9FYSx9rJaxVxW7UE3J40JDsIP24sOea82G4AUgF5GY2fYqA9TshGHLKleu/HCw8AfYcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmtfawSj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398b589032so1464173e87.1;
        Thu, 10 Oct 2024 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728564377; x=1729169177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVuj12UX8GIeD8p86YEe3fDqEXjeGtON8zAuREJZOWw=;
        b=XmtfawSj1AcVEbDP33D19xRXRIMYS1z3bfA1gBA6X5aJ+/MZYcLJmOvi9WFGG7BwBR
         1b7DI07dCC3+JDbg2BX9RzKVcYQRRuZYhIBXyM82vqRclVheYxitEAMgd3k9Vy1KhGm2
         g2mnZDPbImOpQ6ykPMClSXEtDurKnY61IdfJxou0dokqzEtIhNeyOtjpX91hXjlX7KnZ
         4iGpNzKzOl5wqpkImtS+pWj32EEN9yOGCv80Ug7lkX8WMIvkpUstce2LEEDJKL6vSIwA
         zw0wQ61LvBgyqNazV2CnNQwf19lPodxHicTNv+vXUTNJWRkWBqnBODOhqtG9RdHApFHb
         3XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564377; x=1729169177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVuj12UX8GIeD8p86YEe3fDqEXjeGtON8zAuREJZOWw=;
        b=RDI2VGyqFRqP4XPu8v6Bv4gKS2z8jyOU/PMRk0ofvPXBwNsFTesM26sEKHXp0TLwR8
         wD/pOm/WgPdqNHADIT5liTnFB5DJWdkHAs6yKLSubWJU2KIr4J5/y+IVVmewYDFPtKwt
         cKI4FBLHH4gEwKzWt267TyiNYCytJlGSrlBRytIw8bi0ZCWB59RZMJ8ErmkUVYxQTnpx
         t9ePCXSeawv/FZo0iJN/oLLKIzR4pPtx0Rq3TltX04ifci47XqzZ3mtdnsCvDAm5onT2
         jRhjtSRgju10cmOyhhMocggphK1vKZzpWtvPQaTCCAkmLAzSKWjkJswcL5gBB6MWMC4l
         c/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUZTp0ky94SLuZgISzR8defM/IBUxSNsO1jZ9+zAhc1YYiuMHs3uoUASK1oCLKt/pAEDuRqsgOBxe6j@vger.kernel.org, AJvYcCUfR+z7rOEx5+dzJUWcVALsPNpYeA2QXmZfubikGDRJZUiqNWmBOo0ikaKyNrUD5VXlNxrnnvxkCz+8@vger.kernel.org, AJvYcCXTNrP8hQw6q8ZG+L3AuoDZ2RHaXYeBjA9aJMZ/D40lCMv8prj5IemgoHjMdW1dbmCQ5KqsvlVpPdstMIOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzbsrpSzARPVkO2DT0NJiTEhpZQBpNsSQfnYxYkaRzre58AVs0+
	n6nj/sktI3g4Exf10KYLZ9DtjXZDR7JruT2W+XkmJK+mk9pyERkO
X-Google-Smtp-Source: AGHT+IG7c8Gke500MkQ4N2XCsbVSvFBBm3FK9CEdZEpbJJ7bFRkUTR6oAYq+eQ62P0q0phLlsaoFiQ==
X-Received: by 2002:a05:6512:3b8c:b0:539:9720:99dc with SMTP id 2adb3069b0e04-539c4953507mr5116745e87.46.1728564376238;
        Thu, 10 Oct 2024 05:46:16 -0700 (PDT)
Received: from zenbook.agu.edu.tr (89-38-97-199.hosted-by-worldstream.net. [89.38.97.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dc5easm85654466b.170.2024.10.10.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:46:15 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/2] MediaTek MT6735 main clock and reset drivers
Date: Thu, 10 Oct 2024 15:45:24 +0300
Message-ID: <20241010124529.78460-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

These patches are part of a larger effort to support the MT6735 SoC family in
mainline Linux. More patches (unsent or sent and pending review or revision) can
be found here[1].

This series adds support for the main clock and reset controllers on the
Mediatek MT6735 SoC:
- apmixedsys (global PLLs)
- topckgen (global divisors and muxes)
- infracfg (gates and resets for infrastructure blocks)
- pericfg (gates and resets for peripherals)

MT6735 has other more specialized clock/reset controllers, support for which is
not included in this series:
- mfgcfg (GPU)
- imgsys (camera)
- mmsys (display)
- vdecsys (video decoder)
- vencsys (video encoder)
- audsys (audio)

Changes since v4:
- Follow naming convention for DT bindings
- Add reset map
Changes since v3:
- Squash DT binding patches.
- Use mtk_clk_simple_probe/mtk_clk_simple_remove for topckgen.
- Add MODULE_DEVICE_TABLE in all drivers.
Changes since v2:
- Add "CLK_" prefix to infracfg and pericfg clock definitions to avoid possible
  clashes with reset bindings.
- Replace "_RST" suffix with "RST_" prefix to maintain consistency with clock
  bindings.
- Use macros to define clocks.
- Abandon mtk_clk_simple_probe/mtk_clk_simple_remove in favor of custom
  functions in apmixedsys and topckgen drivers for the time being. 
- Capitalize T in MediaTek in MODULE_DESCRIPTION.
Changes since v1:
- Rebase on some pending patches.
- Move common clock improvements to a separate series.
- Use mtk_clk_simple_probe/remove after making them support several clock types
  in said series.
- Combine all 4 drivers into one patch, and use one Kconfig symbol for all
  following a conversation seen on a different series[2].
- Correct APLL2 registers in apmixedsys driver (were offset backwards by 0x4).
- Make irtx clock name lower case to match the other clocks.

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging
[2] https://lore.kernel.org/linux-mediatek/CAGXv+5H4gF5GXzfk8mjkG4Kry8uCs1CQbKoViBuc9LC+XdHH=A@mail.gmail.com/

Yassine Oudjana (2):
  dt-bindings: clock: Add MediaTek MT6735 clock and reset bindings
  clk: mediatek: Add drivers for MediaTek MT6735 main clock and reset
    drivers

 .../bindings/clock/mediatek,apmixedsys.yaml   |   4 +-
 .../bindings/clock/mediatek,infracfg.yaml     |   8 +-
 .../bindings/clock/mediatek,pericfg.yaml      |   1 +
 .../bindings/clock/mediatek,topckgen.yaml     |   4 +-
 MAINTAINERS                                   |  16 +
 drivers/clk/mediatek/Kconfig                  |   9 +
 drivers/clk/mediatek/Makefile                 |   1 +
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c  | 138 ++++++
 drivers/clk/mediatek/clk-mt6735-infracfg.c    | 107 +++++
 drivers/clk/mediatek/clk-mt6735-pericfg.c     | 124 ++++++
 drivers/clk/mediatek/clk-mt6735-topckgen.c    | 394 ++++++++++++++++++
 .../clock/mediatek,mt6735-apmixedsys.h        |  16 +
 .../clock/mediatek,mt6735-infracfg.h          |  25 ++
 .../clock/mediatek,mt6735-pericfg.h           |  37 ++
 .../clock/mediatek,mt6735-topckgen.h          |  79 ++++
 .../reset/mediatek,mt6735-infracfg.h          |  27 ++
 .../reset/mediatek,mt6735-pericfg.h           |  31 ++
 17 files changed, 1016 insertions(+), 5 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-pericfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-topckgen.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h

-- 
2.46.2


