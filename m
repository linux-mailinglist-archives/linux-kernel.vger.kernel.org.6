Return-Path: <linux-kernel+bounces-359111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F599879D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6371F248F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002FE1C9EB0;
	Thu, 10 Oct 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGA7O4pp"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC31C9B89;
	Thu, 10 Oct 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566843; cv=none; b=KQ09p0zH7NOw/3LQrqch2R5IVXuLE0hKNRDcWNM4E+qcCl5DCgO8bm4yVdTRuDWDLNv5D76NW4+6oEu/aPnjWZhz2QDgn1+3AO1nUfRojmVpMRkkS87CwmUiP4yQj7zzdXiWxsujhda2yuucione/T/0uiPoLuZum9vJElyXnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566843; c=relaxed/simple;
	bh=CpniOZBDwHYlE0ORY6RafhnLtuDDWso9Qh2+JIxlAPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDtoX2leoGPOyJZgp4gg/j2wJpZ8twhhbbx0hJDkxWqMqGNrBq1P/97Lv48M1NqpeTEu2ymzEUDCGH5hMEV23+N55FlNemJAMYnH9iU8s9OTLz7lDKaP+wCLLlqFRdW1PDgNOFDfCrF3W/rUiTqg8kFROrJaMSucG3TRfJih9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGA7O4pp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c91a7141b8so1122745a12.1;
        Thu, 10 Oct 2024 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728566840; x=1729171640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+Y0UnqSCJyK4JfiDtNuNdtFaFzWSU45KXZfcE1fxFk=;
        b=XGA7O4ppMlI1uWX8JeIxKeCQ+DI+eNFwE4101uopSPCk/hSRGjgPai7bRHQrtd0Neq
         KHdfigj3ko0afbzMUJsg75C6MZPOJOJNXL5/TciJw1tOm/mxhU8pHZIu698QsceqNuRI
         f1Id6tq5MRjo5ZVxmmzVmhUUR+N/7SAhG+g8187cDcqcvEa5E7R12W57OdB9PCogBt54
         DGxAWXhEsR0P8AVctZXg/nCG6wZVeqq3QH7OdvqBtry9pyp/fZieyzND6k6UFSCwBTtp
         GvzrYIp6P3Q2JoQ1CSR0UBcNB8YN3fWCKT/Ox8NP3nN+2tkhfA60maBaXA0DXU5IZoJO
         Cp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566840; x=1729171640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+Y0UnqSCJyK4JfiDtNuNdtFaFzWSU45KXZfcE1fxFk=;
        b=eO4CH/AP7sRT2DpMwlQJuvsJjp9s5JATCLRlIUhXbahSd1kiNsz/1Zip7pQSMJUwEs
         mO9U6IElcoLL00RpOrqmrbCZK9Xl1uIGaC1PBQqbX4U3A8CRfQc6lCEZlageK4T9Hwyu
         XNYy5UUxcgJOUGlkfSHMpyVXCkN8XJg3erZqwKs55H9R07jVJi5M6MYz3BVVJbCGnY6g
         No+Cmw4kriVtFDTw0qJNdJsK2KYmquAknrt9YOUnm8EfhYomuJcj2DSINfFDEAiGC9K9
         e3qoar/XUNeZPIZge7pEUUQOWVzzVYQ0uBEFqG3D8c/hwzwerqayvz09cACFnRy8fcug
         V1YA==
X-Forwarded-Encrypted: i=1; AJvYcCU4FnSYziY/Sky4PAzruE5IhwoD6juioHf8zR+Gjioct3ZX2AYCnESjsXHjGixVbAzeLPRhS5OmoMPQ@vger.kernel.org, AJvYcCVNoGdiy6tjxzCbU/7g4HBDRVqO45DFvCG08CruOhqCg44aE66DIYIvlT4ExNYyL7ROKj0scf03mHvDZvpr@vger.kernel.org, AJvYcCXwf4qOksTVEextvxXT1pJRxbPGUmX2yaG9E7K6+AMyNLUg1bGUgYn7PRDH5JbeJlxL5B6tVHcrhIyr@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHX3nf7MKgqnRZfCKOo0dqHUBdqBJJZr1/QmwX/NqGC2qZJ5v
	GijLcdK4uweRz8gsM2PfmydXEUcblS8wgv9/gxlubLzaDNnJE+jB
X-Google-Smtp-Source: AGHT+IEW8/apmqrpk1UObsIY0s6nDJHzLk8B90zHTPRtOwBtMiwpp6Ft3UHhYVu8O/D/2w1tW631aA==
X-Received: by 2002:a05:6402:42ca:b0:5c8:8fe7:73a8 with SMTP id 4fb4d7f45d1cf-5c91d538500mr5344625a12.7.1728566839821;
        Thu, 10 Oct 2024 06:27:19 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.31])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937260a9asm765198a12.67.2024.10.10.06.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:27:19 -0700 (PDT)
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
Subject: [PATCH v6 0/2] MediaTek MT6735 main clock and reset drivers
Date: Thu, 10 Oct 2024 16:26:55 +0300
Message-ID: <20241010132659.81606-1-y.oudjana@protonmail.com>
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

Changes since v5:
- Fixed typos in driver source.
Changes since v4:
- Follow naming convention for DT bindings.
- Add reset map.
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


