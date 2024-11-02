Return-Path: <linux-kernel+bounces-393097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0934B9B9BD4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60611C20CA9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C391A32C8E;
	Sat,  2 Nov 2024 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpDjCSJi"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61A8493;
	Sat,  2 Nov 2024 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730509838; cv=none; b=I5fav64TjhHqk58AlIbzfdS4EkV2ithXiCnLI0CxKflOM9rXkRHPNx3yprEElPoZti45qUJnckaM58Fsk7L08cJ8ZIxaPtMQHNWGIKrzia+h1x7a0o7F5l4d0DCXbo3SVkwTv67fTtcr/7kytUUagBOEBAu3t2dw5YMluWDeUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730509838; c=relaxed/simple;
	bh=nOZEpYLWODo6wCvNazjMs6r9inyyUKqd57/QStZot3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwBodmHfRIVhHNC2/UTD/+GE3Fi/lPQckDD+/1v2EPVCWe/KB6beAbBLkr+aZ+NNyePEqCal4ayXPqyY6bfsUCJFIw/GZO7fGmqMnTv/XPZLdsNW8VS0nhVfgi+DGn/gfvBJ2nrKS9KOArgGhYo9XDMLGAIc+NyvQp6IwHgqu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpDjCSJi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e5130832aso2030228b3a.0;
        Fri, 01 Nov 2024 18:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730509836; x=1731114636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMoIS/YJD9sh9c73w4cs+pas2HnFmm3Lw2P98QNL9Pk=;
        b=DpDjCSJiAIbR2xc8Rblsiar5CGhuttYClueS+h4BraffjKIZYS05jkFmZFSEKCnnCh
         glg086ciTXD9wpRGjZw22oZ2P5HQBhJM1x/ugbnoWQICXDX1u+MQWkne/C+nssJZNt88
         QbIFWP6VJ4XHcZJ7/mBb5sjFGs6AT9ndT9RC5M46H68OePPqHMtR6xQ2t36eRMxCu84K
         Jl/ccUlnrbNLcXn/kQxFg6cEq2G+AHzJ9PkBn4ar9p2Vd+wycTka1fabZ/QoTDS28NbU
         OpMnnQsPK4ouQmIMWU4gsvwo3z73Xdso+IfgqnMIp2aHjsVsSDxnRF2DWegkbIBOZwb2
         5oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730509836; x=1731114636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMoIS/YJD9sh9c73w4cs+pas2HnFmm3Lw2P98QNL9Pk=;
        b=iHcQ/3hp8DvPvol/Mmv1mGB4bPEfv+R3ovVnMwROg+OgHyfE2+5iQHZcgTNpSXIVFL
         LuETf94vW+RFVBqrrc/sWkNWEvpvVgQxx6QczmirqesgT9FWDvXoQ3StDx9yA4CX8V97
         /jrrHE2XhpXFDDrKmJJRFPXgEY3jD7LZ7qjJX+JO8nA9UaMzAG1PSlmA6Ar3KqvhKiNw
         kh6+vINXucV4jGSK04E7iWoDniHG+xTG9OPIo/Vt1LKipxCk19m6wzviDB9u4g6kT1Nt
         2ssfc3FSLuzIzhQFjeW93Ai9g7DVc3h8Kg4hjoeGVr/rywDVGU4xAJGH81+oYDKk6+ut
         eC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOXW354HnQNs55bqSJILlm2eZx0qDhArY/mt2mGja9Qisvv1uRPfj+pdIsn3DUb9LTPSv8u2axXTB6@vger.kernel.org, AJvYcCW5V0kLAQPV45p8qmQ3+5tYKFjWnDiga40yftAy7fX0Sp5rsyPMmRGEQKBBUqv1ULUKD1GT3r7wJbGvobfT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkfd/DAtEUN4rv+RPxZ5Lq/HzR7olb6lq0IXV4g0zsHdaeGQ3r
	C08fnlabQN9ihsalxdX3phYPQK5RWKgJpUiPsXRauTsl8c+yW1bi
X-Google-Smtp-Source: AGHT+IEpMR9EC8+eszT/o70QjUzgjmv2oXMMW1IPjKItDvh9v599rjOcDiZyLNgjd+IOFJOO/cBK0A==
X-Received: by 2002:a05:6a00:1490:b0:71d:eb7d:20ed with SMTP id d2e1a72fcca58-720c98adb50mr8357982b3a.12.1730509835843;
        Fri, 01 Nov 2024 18:10:35 -0700 (PDT)
Received: from localhost.localdomain ([49.130.42.137])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc2c38adsm3287708b3a.133.2024.11.01.18.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 18:10:35 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 00/10] Add PMGR nodes for Apple A7-A11 SoCs
Date: Sat,  2 Nov 2024 09:08:22 +0800
Message-ID: <20241102011004.59339-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the PMGR nodes and all known power state subnodes for
Apple A7-A11 SoCs, along with the associated dt-bindings.

Changes since v1:
- Removed "framebuffer0" dt aliases. It is not standard and not needed.

Link to v1: https://lore.kernel.org/asahi/20241029010526.42052-1-towinchenmi@gmail.com
---

Nick Chan (10):
  dt-bindings: arm: apple: apple,pmgr: Add A7-A11 compatibles
  dt-bindings: arm: apple: apple,pmgr-pwrstate: Add A7-A11 compatibles
  arm64: dts: apple: s5l8960x: Add PMGR node
  arm64: dts: apple: t7000: Add PMGR node
  arm64: dts: apple: t7001: Add PMGR node
  arm64: dts: apple: s8000: Add PMGR nodes
  arm64: dts: apple: s8001: Add PMGR nodes
  arm64: dts: apple: t8010: Add PMGR nodes
  arm64: dts: apple: t8011: Add PMGR nodes
  arm64: dts: apple: t8015: Add PMGR nodes

 .../bindings/arm/apple/apple,pmgr.yaml        |   5 +
 .../bindings/power/apple,pmgr-pwrstate.yaml   |   5 +
 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi    |   4 +
 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi  |   4 +
 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi |   4 +
 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi  | 610 ++++++++++++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi       |  13 +
 arch/arm64/boot/dts/apple/s8000-pmgr.dtsi     | 757 ++++++++++++++
 arch/arm64/boot/dts/apple/s8000.dtsi          |  22 +
 arch/arm64/boot/dts/apple/s8001-common.dtsi   |   1 +
 .../arm64/boot/dts/apple/s8001-j98a-j99a.dtsi |  26 +
 arch/arm64/boot/dts/apple/s8001-j98a.dts      |   1 +
 arch/arm64/boot/dts/apple/s8001-j99a.dts      |   1 +
 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi     | 823 ++++++++++++++++
 arch/arm64/boot/dts/apple/s8001.dtsi          |  22 +
 arch/arm64/boot/dts/apple/s800x-6s.dtsi       |   4 +
 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi    |   4 +
 arch/arm64/boot/dts/apple/s800x-se.dtsi       |   4 +
 arch/arm64/boot/dts/apple/t7000-6.dtsi        |   4 +
 arch/arm64/boot/dts/apple/t7000-j42d.dts      |   1 +
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi    |   4 +
 arch/arm64/boot/dts/apple/t7000-n102.dts      |   4 +
 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi     | 641 ++++++++++++
 arch/arm64/boot/dts/apple/t7000.dtsi          |  14 +
 arch/arm64/boot/dts/apple/t7001-air2.dtsi     |   1 +
 arch/arm64/boot/dts/apple/t7001-pmgr.dtsi     | 650 ++++++++++++
 arch/arm64/boot/dts/apple/t7001.dtsi          |  13 +
 arch/arm64/boot/dts/apple/t8010-7.dtsi        |   4 +
 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi    |   4 +
 arch/arm64/boot/dts/apple/t8010-n112.dts      |   4 +
 arch/arm64/boot/dts/apple/t8010-pmgr.dtsi     | 772 +++++++++++++++
 arch/arm64/boot/dts/apple/t8010.dtsi          |  22 +
 arch/arm64/boot/dts/apple/t8011-common.dtsi   |   1 +
 arch/arm64/boot/dts/apple/t8011-pmgr.dtsi     | 807 +++++++++++++++
 arch/arm64/boot/dts/apple/t8011-pro2.dtsi     |   8 +
 arch/arm64/boot/dts/apple/t8011.dtsi          |  22 +
 arch/arm64/boot/dts/apple/t8015-common.dtsi   |   1 +
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi     | 931 ++++++++++++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi          |  21 +
 39 files changed, 6239 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8000-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi


base-commit: 5c9de6f45db36b8a74c12e448cf9db87c97bf1e5
-- 
2.47.0


