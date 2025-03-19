Return-Path: <linux-kernel+bounces-568163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCEDA68EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1113B4609A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4571C5F3F;
	Wed, 19 Mar 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LwQC/n9C"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D70155753;
	Wed, 19 Mar 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394070; cv=none; b=Av0/PvNAKGc6XSUUfdz8Avhq9cCuEsTSh+5VyEIF8OQ7+P1ODjizYMSru9OtwhhNUvvYmaFwf5PRJdA28csvGgovEThofKp/LSrYLuCTdPte6n/m9or63XvF4sukolcezjE/DfBA1WlR88ZxYjbWGRxdjscRiGwfFn4wXKVmkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394070; c=relaxed/simple;
	bh=LqYxkHdnu94BkDatbzc2SOdiZroP5pdS8NxG4IzR3lM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OMaLTjCDYzo+Qj+At+b7WWVBH9IFHDEYMwO93M+YMHinauhukkGu87TO3H1hKAkzssS+EDecfX5bAckiopQJ0+3AFvlfLhNC6PALDQu4f5jFVIU/U5I9jBmEImNZisSCLU7MtlUGZQ4kZPHc170YmAU0wwBYtcQfiXHAxkBPLYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LwQC/n9C; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 5A5322351B;
	Wed, 19 Mar 2025 15:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742394064;
	bh=rRmb6u1+UKFsEYd0+93uDGfvsAhDbHIh6rWpE1YlSF8=; h=From:To:Subject;
	b=LwQC/n9C/khDqIU6Iv/+gTHolzdleHijWwOVy+k9H1tZW17ixi6mou5LwngQ39mVz
	 CpAHHrX+6f1tZk20jjSw7AcGy58lhqT+f22kWw1VGnFcOVSUyZqCnLDun0YjwVAoFQ
	 wK3yvewoUWVBUriBGOUt4ewtRHA2oHu7pX1irMdaDwF03mZSkh4f5ERRskvO+3gK81
	 qpwrjssux79ZxwD6PDZClzorvCQgugHrIK5cORwBSXb4qANjXRRcdQH4Xap//JMZPd
	 LIax5oafD3sYPhiPBRkcJRN+GxA9qXeLuIKR/Xq56Pei7LnMbPFrNoHq9shQYRgWvH
	 fLw3lWIzxo5Vw==
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
Subject: [PATCH v4 0/5] ASoC: wm8904: Add DMIC and DRC support
Date: Wed, 19 Mar 2025 15:20:54 +0100
Message-Id: <20250319142059.46692-1-francesco@dolcini.it>
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

v4:
 * Renamed "wlf,mic-cfg" to "wlf,micbias-cfg" to be more in line with the
   wm8994 binding.
 * Changed type of "wlf,drc-cfg-regs" and "wlf,retune-mobile-cfg-regs" to
   "uint16-matrix" instead of "uint16-array". Also edited the example to
   properly itemize the "wlf,retune-mobile-cfg-regs" matrix according to the
   style guide.
 * Itemized "wlf,gpio-cfg" and "wlf,retune-mobile-cfg-hz" properly in the
   example.
 * Expanded the commit message of "ASoC: dt-bindings: wm8904: Add DMIC, GPIO,
   MIC and EQ support" to clarify some things.

v3: https://lore.kernel.org/all/20250307135244.100443-1-francesco@dolcini.it/
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

 .../devicetree/bindings/sound/wlf,wm8904.yaml | 129 +++++++
 drivers/of/property.c                         |  33 ++
 include/linux/of.h                            |   9 +
 include/sound/wm8904.h                        |   3 +
 sound/soc/codecs/wm8904.c                     | 317 +++++++++++++++++-
 5 files changed, 484 insertions(+), 7 deletions(-)

-- 
2.39.5


