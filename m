Return-Path: <linux-kernel+bounces-551215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9307A56973
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE12160F56
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD12821ABBD;
	Fri,  7 Mar 2025 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="V4QIcte+"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E821ABA6;
	Fri,  7 Mar 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355579; cv=none; b=kIaNtR8rw2VEFW9XGnyDr4Y9G2MYJsH5m5+TBKGdfWfSbp/rO5EioRRfUXS7+t9ByfRShhDLap3xG6D0NYICDl0c+obSTH3hVYZZvLDplbLg8plsNTDCEJdoRU2yRJLaQyKwam17Bao9uUdGINJGXYGEECGhzzlVisB8SaLiNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355579; c=relaxed/simple;
	bh=O7Wl/QJmeufCW8/KBuYCP7hJKBM5Bs/OWab/pCxh8is=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MoIe392EX8MjGfBpMdrEgpmaySLfnlL6H79chOsLxpEkn94lYG9eS/LeP/o2FG3B6p8tZCubTyHDqSBYPms3LRfX67fRHAdiLJJ80N/bCmstPtSYeM1muGqOUgmQXJ378Z0pjHFKSTPCsFJPFepdEPAtx067//WtIGalph/kTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=V4QIcte+; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0D15E1F91C;
	Fri,  7 Mar 2025 14:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741355568;
	bh=SYSgGzv3Y/Vggc6YYeKPxI6ae5Adem+OvWetoQaX484=; h=From:To:Subject;
	b=V4QIcte+z9iErOEUsA30NKkv40xe+yLdKiwHbHmuKhVhPHKJbl8Ff636iwhMGpIBI
	 XdgpkdRpaA8hV0NOeSd1RY2Oa4Q4fIt5eTL/q4Z9TUaE7GwSKpeOAl32lb9FyHNpQb
	 oZmI1Od8/eqDH9M/wRxIdR80fB0/g3ducwdUsmR9tXtFnRfBpbutkb1V9qRbBgqWsJ
	 cLptVcE0WsUt/vl4E7f8QqHLEaHAqUVhVLajqAxQruj2mAgl+oyh435NbraU50I4/W
	 3DGvNat+8hnHmJwsGma2xoLYA8TtVB55ymxMBhytDTvr6/I/TTfA37D4Gbq6U7bNbK
	 VQBvYUn/V4zIw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] ASoC: wm8904: Add DMIC and DRC support
Date: Fri,  7 Mar 2025 14:52:39 +0100
Message-Id: <20250307135244.100443-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This patch series adds DMIC and DRC support to the WM8904 driver, a new
of_ helper is added to simplify the driver code.

DRC functionality is added in the same patch series to provide the
necessary dynamic range control to make DMIC support useful.

The WM8904 supports digital microphones on two of its inputs:
IN1L/DMICDAT1 and IN1R/DMICDAT2. These two inputs can either be
connected to an ADC or to the DMIC system. There is an ADC for each
line, and only one DMIC block. This DMIC block is either connected to
DMICDAT1 or to DMICDAT2. One DMIC data line supports two digital
microphones via time multiplexing.

The pin's functionality is decided during hardware design (IN1L vs
DMICDAT1 and IN1R vs DMICDAT2). This is reflected in the Device Tree.

If one line is analog and one is DMIC, we need to be able to switch
between ADC and DMIC at runtime. The DMIC source is known from the
Device Tree. If both are DMIC inputs, we need to be able to switch the
DMIC source. There is no need to switch between ADC and DMIC at runtime.

Therefore, kcontrols are dynamically added by the driver depending on
its Device Tree configuration.

This is a heavy rework of a previous patch series provided by Alifer
Moraes and Pierluigi Passaro,
https://lore.kernel.org/lkml/20220307141041.27538-1-alifer.m@variscite.com.

v3:
 * Fixed DT binding to conform to the DT schema properly.
 * Renamed "wlf,retune-mobile-cfg-rates" to "wlf,retune-mobile-cfg-hz", it is now a standard unit suffix property.

v2: https://lore.kernel.org/all/20250224155500.52462-1-francesco@dolcini.it/
 * Fixed a bug in wm8904_parse_retune_cfg_from_of()
 * Added full usage example of the three ReTune Mobile config properties in the
   DT binding.
 * Improved the DAPM routing:
   * Only add IN1L/IN1R routes to ADCL/ADCR conditionally depending on which
     DMIC is in use.
   * Do not connect PGAs to ADC when they are not needed.
   * Keep the mux between ADC/DMIC even when two DMICs are used, as the IN1
     pins share a mux with IN2 and IN3 and the ADC could still be used for
     them.

v1: https://lore.kernel.org/all/20250206163152.423199-1-francesco@dolcini.it/

Ernest Van Hoecke (5):
  of: Add of_property_read_u16_index
  ASoC: wm8904: Don't touch GPIO configs set to 0xFFFF
  ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC and EQ support
  ASoC: wm8904: get platform data from DT
  ASoC: wm8904: add DMIC support

 .../devicetree/bindings/sound/wlf,wm8904.yaml | 116 +++++++
 drivers/of/property.c                         |  33 ++
 include/linux/of.h                            |   9 +
 include/sound/wm8904.h                        |   3 +
 sound/soc/codecs/wm8904.c                     | 317 +++++++++++++++++-
 5 files changed, 471 insertions(+), 7 deletions(-)

-- 
2.39.5


