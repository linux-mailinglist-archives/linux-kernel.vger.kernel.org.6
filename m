Return-Path: <linux-kernel+bounces-570313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E351A6AEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB83980FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DE7228CBE;
	Thu, 20 Mar 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="WigfZVxa"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AC229B07
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499896; cv=none; b=XcSDW5Q5IGmIR4jZjl06bQmDn1hxlBodE1l3DetJc/7xdy6uiFRqZOeWNCKKA11axNEoHj1UamPbFfnx2aGS+eHGt5dtNOk1d6k7LAxP/B1p0W7mLefuuI1vCdyZ2Ep81Sbmnioack2LBcCzLVH2Ktc6f0EPKkWJKrFW2DJCmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499896; c=relaxed/simple;
	bh=zrHP/gmG47t4vvKq7gzmaxI06hPKcdUhZERfPB/kMcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Legdrq8qjWNUTqJL3i/X5cOceCk2ucihRRnrz9P6nuWicR1n9C6uoGcu+cyAL7w2FhaGh0eMJEuNsatqJFFKH7OIldE5h99KoSFCn/D+va9jEMZB+DExKfmSnxWOcOc6s9zi6q2V6bSnHiAb1xRJuGhMUF+alZ+TkVo8Wz7ZLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=WigfZVxa; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so107145339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742499893; x=1743104693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AW49rekhn13ov0fYjoV+6+dgXQ3GIdWnPfM3LeEAqlk=;
        b=WigfZVxa+Sc2C6oPQnyhmefRACIjgmVqwXmNJkP/WM6DR3pZx+dOBi66PcaL9reWZn
         Mdb+iOSMW10iLZ/2ZX/oTHU/oeoto9bmWOsv0Im0gaPpgLYfceZs4SxD1a/plAxR2bpt
         amz9FLyqlw36EVZxbkS4OwyCNHf8Tv9C/x4CSIHrlv11p8OHN7CLNdGUCPB7ZWivSNqI
         nmxja7/cQ4Z9eXvxEdyus4Ei+49JnAbczdnzoXknEjqodCHp9YHF8h17F6gplYvRteHv
         OaJT4i/230EI/fzmYsHdE7tALvLYo9xBkr29UuNY5NDRtg78TeT6eYp39SoP/AAvjIEl
         Dmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499893; x=1743104693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AW49rekhn13ov0fYjoV+6+dgXQ3GIdWnPfM3LeEAqlk=;
        b=Dx+XPX4wRDH3x5p623sDyVieOlWJHXVbOU674cGsdNBFEV9FbRwtmOQrD+WWDBnuJ7
         Oefnicmpe/zzBTjOvjte2hulV8Fnazhc7GHR/rASJf3xuUu19Fi0JzuzPslk4PCmssWK
         BuKGMVqTgThARlbTmNUME/4dTif4ue0ifChZXXHe577MgmiSiyJxAskuz5b9AugE+jCy
         pu+7+6/bUbwUeLTt7UpcwDtTJjGg8N8vsT+LIh3+Tj1zlUBmFspHn15FylYAemU0V3vC
         XIznqLX40KPUZG+sWVyZeBESL//KLcxaiCKoLoFftp06qkMTVTzPQ/k6Wd4MCT0Qcytu
         JbOA==
X-Forwarded-Encrypted: i=1; AJvYcCVVz+TURb1fcWJLBoY/2yGaK99pWjvZRi8NId0hwM4XAVknAdbouESy03Fx3vlh0LPAWfnObDwIV6QkP2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgSRb54tLE9beBVGW6mwlF6Xa+oN8qRXzz7jYCP/y0sFs9zfRx
	nPNAKjifShpw4AjKJj/TlkPbF3Z7CVRhTHzB/vytMCai82cAbcFyhBXbCm9gOQENDPlEd+jUi7f
	krGufPg==
X-Gm-Gg: ASbGncvl3JeUY5Pww211eZ++pm1tCfQoL5d8NRfuGfBKvz0uFldUFIjItDajpVHh9i2
	Rke1WltTIt2bNWtWFkseg2GHbW8upmhSZHTvz6ZMI2RiPktHzYqhIUw3SP+MDQstl9PO38htppX
	Zxf8qI2LZAHVnJ8vLOvBw8KD0ScHfYpFWAuOwnmcZ38qmZFzUlXfcQOT8oxnWHbz/e3ZWXk7Fv+
	p2CY9SL9M14xcZlmBoDFSbqLZKnBcZWs6YynD4XyK9D6lpHMOMsIm+vQaBoOVHaPier2Oe9pw4H
	pRDfl0o3TZz/pW+P5Lf/mg3XvmU+liReE2NWM1Jj5Syya/RE93MxJOtdO0bV2DuKMPEL6FKGdkt
	Ox4p2Yi07o9EXL1z00vnsPIIv
X-Google-Smtp-Source: AGHT+IFltPpVI0ACnzJTqj+VKPKw57T57QohZSAekfF3yS1ZRlpAvC4mmTtGWHjmmF2YmyCcadc1NQ==
X-Received: by 2002:a05:6602:4c83:b0:85b:3827:ecef with SMTP id ca18e2360f4ac-85e2cc5ebefmr62134439f.12.1742499893623;
        Thu, 20 Mar 2025 12:44:53 -0700 (PDT)
Received: from zoltan.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bd8c40fsm8341439f.32.2025.03.20.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:44:53 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: p.zabel@pengutronix.de,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org
Cc: heylenay@4d2.org,
	guodong@riscstar.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] clk: spacemit: add K1 reset support
Date: Thu, 20 Mar 2025 14:44:41 -0500
Message-ID: <20250320194449.510569-1-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds reset controller support for the SpacemiT K1 SoC.
It is based on Linux v6.14-rc1.

It is built upon the clock controller driver that Haylen Chu
currently has out for review (currently at v5):
  https://lore.kernel.org/lkml/20250306175750.22480-2-heylenay@4d2.org/

It also depends on two commits that will land in v6.15: 5728c92ae1123
("mfd: syscon: Restore device_node_to_regmap() for non-syscon nodes")
and 7ff4faba63571 ("pinctrl: spacemit: enable config option").

The first patch adds three more system controller CCU nodes to those
implemented by the SpacemiT K1.  The second updates the existing clock
driver with a structure used for OF match data, allowing both clocks
and resets to be specified.  The third provides code that implements
reset functionality.  The fourth defines groups of reset controls
implemented by the CCUs that have alraady been defined.  The fifth
makes it possible for a CCU to be defined with resets but no clocks.
The sixth defines three new CCUs which define only resets.  And the
last patch defines these additional syscon nodes in "k1.dtsi".

All of these patches are available here:
  https://github.com/riscstar/linux/tree/outgoing/reset-v1

					-Alex

Alex Elder (7):
  dt-bindings: soc: spacemit: define spacemit,k1-ccu resets
  clk: spacemit: define struct k1_ccu_data
  clk: spacemit: add reset controller support
  clk: spacemit: define existing syscon resets
  clk: spacemit: make clocks optional
  clk: spacemit: define new syscons with only resets
  riscv: dts: spacemit: add reset support for the K1 SoC

 .../soc/spacemit/spacemit,k1-syscon.yaml      |  13 +-
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  18 +
 drivers/clk/spacemit/ccu-k1.c                 | 393 +++++++++++++++++-
 include/dt-bindings/clock/spacemit,k1-ccu.h   | 134 ++++++
 4 files changed, 539 insertions(+), 19 deletions(-)

-- 
2.43.0


