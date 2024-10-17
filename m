Return-Path: <linux-kernel+bounces-369303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA29A1B80
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C34BCB238F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD317965E;
	Thu, 17 Oct 2024 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNwdsoig"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00D191F9A;
	Thu, 17 Oct 2024 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149456; cv=none; b=tQzZFHJypETtJPvgwvkHJvxGSfqT4pGbOe4q8AJJfp0I/c/vmPhvvwKrDHFnCY43FSlWcZ+WZ7DIEMjXsJTpl1ZACdB/jIW/k34IuP5toPfNjFoUrQgcLBo3UneSKbawE9FyKLh1KGWLSCUZBXaJFhEJ1Il35icJRVVhSzz0okQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149456; c=relaxed/simple;
	bh=KJE72V+2eRnMQvQBnilDC2fN6pl15XAvG6FslAjyIC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mh0EwxCBxwokPZW6OU4sRzAtvv52eXcsdumxlVHAfPfX5U1coRvr1ku7IvDCQ4oaDOn341UDcovXfvJr8aOnPxzrt8nACxDdalJfOs4Sl0DM5g3id2HdEh3pXaUjxIHCr2XJZm0ii0cCtlYDtTw+a+pc981iEaLqcPNoTWahPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNwdsoig; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb587d0436so6676261fa.2;
        Thu, 17 Oct 2024 00:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729149451; x=1729754251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPNLPgog+vbCNk0LoFWcYy/EHFJxqj69cSg/nXPsFdU=;
        b=HNwdsoig3G5ivCaBygmyK+FajcTHolBCZsr98p7Ps6guLnnevwitBQVVfAWds7WLBL
         gVk+F/RLGK/e9Wna0eF42CkxvZ7uUx7pHNorlfUi1zyChLNOELPdajFhBKrS2m2uIwH/
         b9ufZmM2vfqR2XTjpLyqxnoTudAzQCKFB5RzPggNGY5vs0MnMPiMWP2d4WgXildZ53OH
         IQRhAi+JbKvMgZqofmqJWJJRRRaGrfJAhKwSDplG+KpLE6FjKFHWDXFKdqK5v/66TeXK
         31Qt3yAp/lMblZ8NBG5203OL8okG+sa3ogm3tqPjCTqGQMGtGWOOERLU2AxEl/8k4caO
         nmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729149451; x=1729754251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPNLPgog+vbCNk0LoFWcYy/EHFJxqj69cSg/nXPsFdU=;
        b=nEujSxhViGfeMpkYSJJCodK0LLnCTMo6ATmxQNa+TZw8Aw8DQ2ts44KYF7oPjXlgLB
         WUEV9wa8q2spaGVxyUVDe7yoxJBGXn7ZEkPniBUGM+e5TzmAiPnlJmOjFOI0gjJe3Tzw
         bnPBFDjgr7uBqocUBSJh7PhvVxiEZ1Ll+wsP+zON2hZ8rGKkzFLgzCJk1qqgRcZM35af
         GnOqSnwGrARe6Pg/EQhSO29fdgYo9WkgPQtMqo+KVw0oHBI/NT9mJ//IjMK1cVd0+0i+
         niVpVN5NrB2ACi8xU0xJh4Jj9VINmt1heFfy74IzyCr97ZM0X2+08EXlEQAd0DCxh0Xl
         N7XA==
X-Forwarded-Encrypted: i=1; AJvYcCWVTNjoOeXMtnjUnhNLTfR3sudeI5TdU6lwRrQgTskRPerT54vhwBoKWeDlRHVj7egghZBC8pOIxsF7@vger.kernel.org, AJvYcCXLpV4WtsfjATvHb7cz0XIC/V8bxRIpkYUN1i/rPf4rs3P6xk0fIUD3L9GNerJnnQ2B+bRVtB2U9Sjm/8ly@vger.kernel.org, AJvYcCXhN5BpdOcwEHtU9lWjjN70p5nnq6DlqyjehN78lreJTjsLSdWC3vOTDkVPeutCnl/OGYP+EzO+r4ku@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WXSQlWkhwvGH2TPOa/i/TrSKpTwYbdbKMUnrt3w6luqFpM/A
	HvKIMW6z14BpGXldfRI2hFRDDEDlCBdN745RYmF0tPwcWhcMYsHh
X-Google-Smtp-Source: AGHT+IE0e+JRuUmErjYZCGI8T82wUui0287djy2ICfp5vPfucLeYv+FrmzFELL6uAEWUR9QgzHH5LQ==
X-Received: by 2002:a2e:b88f:0:b0:2fb:3c44:7f8b with SMTP id 38308e7fff4ca-2fb3f2e8e69mr88977821fa.43.1729149450347;
        Thu, 17 Oct 2024 00:17:30 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d778266sm2392174a12.70.2024.10.17.00.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 00:17:29 -0700 (PDT)
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
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 0/2] MediaTek MT6735 main clock and reset drivers
Date: Thu, 17 Oct 2024 10:17:04 +0300
Message-ID: <20241017071708.38663-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.47.0
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

Changes since v6:
- Change .remove_new to .remove in platform driver structs.
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
2.47.0


