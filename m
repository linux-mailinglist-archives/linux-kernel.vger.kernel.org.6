Return-Path: <linux-kernel+bounces-386130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE079B3F76
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC94F1F22F58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D2C22338;
	Tue, 29 Oct 2024 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR0e8lgb"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4EDDBE;
	Tue, 29 Oct 2024 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163979; cv=none; b=DOE/61umJMx8MUb6vDRxoLHi6XJLBr3VOicmHphIZXZEBZIvPdgkYiaMZ6zL8RjQbUUcpgeDv3pXYxzyFNlMLNDOKmICcLR+gqJJtyubf0JlZYARhePGx/VDcHb9UJ0S+UWldQCxNhPLRIKTFm7IHG9RyR+oIXQC7E9vDEX9tns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163979; c=relaxed/simple;
	bh=va9+w+Y+AxYHcFoDkr3/FAmROlEOkdPrgxr1Tr7QqsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8vcSByudfAkPaoPuWJQc85ZOr4bDuINz94eB2n1IZA1jZRAhp5+IzrQmP4AQ13vqkmjgYaMxuI8ReRGC/E4YHNRk+kvaus+YJVHKTEuXLN2SDzOeLBV2ab+ZZtOq3zZqc1CuDRKqoIjDBuXsSrrAG/QY9iJNagT3qr7yevtk+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR0e8lgb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c803787abso39184725ad.0;
        Mon, 28 Oct 2024 18:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730163977; x=1730768777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QZuqlncHnASFQSfQcw4aMTWgJLEaZN0b1kh9Wmj6pk=;
        b=XR0e8lgb32Nudrm40KHeBV8F/7p1MnnOEu0NIx90t6Nuzvxy4HCiTBs6Wv9Fip3TTl
         IVQDoqRGhJqHbzTtn7j1fFO4X+rOnIFNSUbYvW7UBR1ZsZEkJ1zt4DHdNXqPC3lxg/UE
         PzfzBikcjzGsv1y2+rN24D7yyxc0lO0I04jqtA/QJotJMrfqJcBKFJVyHOMN+Lox10/I
         5hHA+gXXJi5ZW/J9cavNrF31hunY2rvM64vwYgvB5xcT5bBhSXWRqhHnYQDFtomxVWyI
         UbDU7qozJJMQ28Z5Q+LNnkusqFMKwqELrrsxXXEyabaaBMFdasOOLPqtQAB7uj4Udfu2
         my2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730163977; x=1730768777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QZuqlncHnASFQSfQcw4aMTWgJLEaZN0b1kh9Wmj6pk=;
        b=tdX4LUbB01TsIalSIL0KFjXECoEILhLsXX7ub2xzBP8jgPAZWyUgo5JrTCLWsbsFF3
         ZMSRIiSt8X9G2VOcrCwxZB/mYMjLjZDWI4HrU45Vfq+Jxbo1/4KnAMBalohbdU5thos8
         v+bo1r1slz1/VMFtRCO5IVqXmJeX2mjnZKn4HhERgE7YsSnUU0LaoBd5q5zPS5x1d1+E
         jcYqtJI2OfoEya+HADirgGbmvC93Q1xRH3ULy3HDtrbBjGX43vGzn5p9GrHbnhnQFFmH
         Wg5z9TAB42qU2p7d72s7B+ykrv4HoyuL7cOwDYEWS+ErPENUMRMTayjlRtTy/dn5HITk
         yR3w==
X-Forwarded-Encrypted: i=1; AJvYcCUUdUGBOicwE4YhKV2LvOQUVi8d0E5LUCU4XPYWUJPYmL8lTFxheIZUkc2ziEjxA3ahFhX+LawfGu2T@vger.kernel.org, AJvYcCXNTn5vptgPKa/w05/6c4doFOVHHtuBIDbGHvloyAbnuE2x4daFXQ436U+ixHuvqvgGxw/yR/BQoK0zjDqT@vger.kernel.org
X-Gm-Message-State: AOJu0YyNttmFWYA2P7WjGq2NLsNosZcmpvC8cjeq+E3gZ5HD9jZppGgf
	DqA67z6MMUo25zGo3JCzynTGPGjN8zSJhlRUuL7Fauvgl5LhjlgFUnN1iSEm
X-Google-Smtp-Source: AGHT+IHXmpqlNME9SpK/s72If+aWe6wFxCuZu7NIgnm7bl3z3OsIfdfVuVaBDQuhav9xcbuN7m8D2Q==
X-Received: by 2002:a17:902:e811:b0:205:7007:84fa with SMTP id d9443c01a7336-210ed46b161mr5094555ad.28.1730163976746;
        Mon, 28 Oct 2024 18:06:16 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-210bc02efb1sm56306225ad.221.2024.10.28.18.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 18:06:16 -0700 (PDT)
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
Subject: [PATCH asahi-soc/dt 00/10] Add PMGR nodes for Apple A7-A11 SoCs
Date: Tue, 29 Oct 2024 09:03:58 +0800
Message-ID: <20241029010526.42052-1-towinchenmi@gmail.com>
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
 .../arm64/boot/dts/apple/s5l8960x-common.dtsi |   1 +
 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi |   4 +
 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi  | 610 ++++++++++++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi       |  13 +
 .../arm64/boot/dts/apple/s800-0-3-common.dtsi |   1 +
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
 arch/arm64/boot/dts/apple/t7000-handheld.dtsi |   4 +
 arch/arm64/boot/dts/apple/t7000-j42d.dts      |   1 +
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi    |   4 +
 arch/arm64/boot/dts/apple/t7000-n102.dts      |   4 +
 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi     | 641 ++++++++++++
 arch/arm64/boot/dts/apple/t7000.dtsi          |  14 +
 arch/arm64/boot/dts/apple/t7001-air2.dtsi     |   1 +
 arch/arm64/boot/dts/apple/t7001-pmgr.dtsi     | 650 ++++++++++++
 arch/arm64/boot/dts/apple/t7001.dtsi          |  13 +
 arch/arm64/boot/dts/apple/t8010-7.dtsi        |   4 +
 arch/arm64/boot/dts/apple/t8010-common.dtsi   |   1 +
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
 43 files changed, 6246 insertions(+)
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


