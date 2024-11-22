Return-Path: <linux-kernel+bounces-418054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046319D5C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6EA1F228B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E41D6DD1;
	Fri, 22 Nov 2024 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2BfhWSc"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925C15AAD9;
	Fri, 22 Nov 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269278; cv=none; b=LkxPsXXXYBkK/iHiGs9QDcewLgTLr/hnP7RvxzqNypq/m0c7IhNl056JrahBpdK2q92F3VN1/GveDW4Bz0rC39MXJJ+IX9loMo8eTSBSL+2llNP3t1RuGxaqReJzKkibx+nMeW3fZYAv1PS92fvj3xkZeKSLKTlLykaUxSDoLqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269278; c=relaxed/simple;
	bh=4r/AQaOmKgXOK7Xpqvsxu30yzczQ3+695c7PBSnrjUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htXbuaED93MRzClltmYCCiYFbE1Xhn5oCfDshxamF/pfPSZ1ARITVQu3v3Hf6cO46rn6bwfJi0X0ynjHsx/1C85b0EXvahOQ27i9OIEKLHy91JH1hdWCwCHoyAPC3yXtwQXTiMKV2MfgQ/OFfyvjYLSxIoYCKzHIxeHk9jpkkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2BfhWSc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so422141b3a.0;
        Fri, 22 Nov 2024 01:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732269275; x=1732874075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jMwyC39icc4IvLpJGYFqdt3FBTe+CoSHG8g9XwWwf/M=;
        b=e2BfhWScEYInykT8I5cW0cF8jlh6QmYfGvdisV6Od66AQHpz7ziehWLDR7JB07atjH
         ilb7iVpQQJN3oQDGsT7ne0ml1k1mXpnAKAa3tNLuABJ6sSAHVFAF43IXkWwyLMm9PwxV
         mTNJEQJ3mpn+HJTLFzIHM44HgihqUDsq5bNkVpES/CAjdV8m8dewSvtd3xrHW4T/Hp+H
         2IAAVluAlTcQzCTQfuMIOtNzM2q+hjHKRQzXV4tQ8IdpjUpx9h4C1uDdtWIczBdPdnMc
         hDRoSkwuyWi5cQsuDGjlQ+CyO0cOyf2YoXeaf7n7mmrQqSSHM87rf9leY5JKpskgpG5H
         hTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732269275; x=1732874075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMwyC39icc4IvLpJGYFqdt3FBTe+CoSHG8g9XwWwf/M=;
        b=U0gj+3SbNW+w/546xJinbeuGCcIYuQe59mnbn2jX9YNvHsA1L8sdU3iyUpL+BMI1eR
         cc0L6IHZvgXDaCGAZnD4HMteKYUZ9LhIOKcTV51TLCK4cMDWwe+CRANkGipO/wuQVT3y
         ATDrJfM54oqoU2jYa4xK3AKpeCSOFBSle30LSbOJ6QC2lpC9Jl2B8P+evvAtfzz09VJX
         ApfvBXGrzOmALSXLo/NAyFEN0dO7jx7zA/8bYIrnhAcfmwwn2Cz9eW2iB5T3b6UcodCM
         kTjsaVnL+s6xTMTfUg4c5BSwv8M0iDSNxVTWOMbDVUIl4q8yzlCB2eiUtP+v2tuC0b/U
         vGBg==
X-Forwarded-Encrypted: i=1; AJvYcCUgAuHoKM/65/95AW9cRksAcToCXtS+hx6P5OCwgbgwhtdmfqxzJsENJMhuAwvGLUNFs6JM/GNZov9r2CSS@vger.kernel.org, AJvYcCV5QWg9Qrelp5pqSZ5Y34FeptbUpUlREVAVktKchWnDPNVEYbmpHZ9CQnSgi6/nnSnc4lcDB0YE6VFp@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZtegi4GfBTOreJXdnSWIwI4gUia4E3ImCm72lAzEGy3QCjM0
	K80iQHEvhcIAS0GyWwYPLcj1TjDq3XPIMM2XKhPP5fuIVOm89e+f
X-Gm-Gg: ASbGncvDgN5U5KVu3efvYENqrIpQfbANxrscjybr1JFTFnqBDz6YClaZSxd24ianf6H
	n1jt9ewnAAq2MUXD13+m15nzMo1CJw9m7N3R4J2oYy1YeqlEI2xa1sKzNY0XXRpDUeiu/vzovbc
	YGC6ItVlZElN6Z2uAXD0DnNxUg9c+YIQgBDxAUYCZp2x5tzjqXngS8UzAmRLBL9YPy8TZDvzy+T
	DOzQS4Dv0CQqfiAmB0U9ECF73/Ggbcxe2S/0MmxiLpb+1MaGQqW59NreykH0F58oEw=
X-Google-Smtp-Source: AGHT+IEjVX8VWWWGoeSVP64ft86gsom9aoLkVu92O9mQT+9mQ+XFMKlDJE5V2OCvy3SC3WAbz6IS8Q==
X-Received: by 2002:a05:6a00:c81:b0:71e:cc7:c511 with SMTP id d2e1a72fcca58-724df68f1a3mr2932208b3a.23.1732269275199;
        Fri, 22 Nov 2024 01:54:35 -0800 (PST)
Received: from localhost.localdomain ([182.152.110.125])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7fbcc218a87sm1236332a12.39.2024.11.22.01.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:54:34 -0800 (PST)
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
Subject: [PATCH v3 RESEND 00/10] Add PMGR nodes for Apple A7-A11 SoCs
Date: Fri, 22 Nov 2024 17:50:29 +0800
Message-ID: <20241122095136.35046-1-towinchenmi@gmail.com>
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

Changes since v2:
- Removed "apple,always-on" property from "ps_pmp" from s8001, t8011,
t8015 power domains. It is not on at boot. (Mixed up with ps_pms which
is required to be on)
- Add asahi-soc/dt back into the subject prefix, missing from v2.

Link to v2: https://lore.kernel.org/asahi/20241102011004.59339-1-towinchenmi@gmail.com

Changes since v1:
- Removed "framebuffer0" dt aliases. It is not standard and not needed.

Link to v1: https://lore.kernel.org/asahi/20241029010526.42052-1-towinchenmi@gmail.com

Nick Chan

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
 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi     | 822 ++++++++++++++++
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
 arch/arm64/boot/dts/apple/t8011-pmgr.dtsi     | 806 +++++++++++++++
 arch/arm64/boot/dts/apple/t8011-pro2.dtsi     |   8 +
 arch/arm64/boot/dts/apple/t8011.dtsi          |  22 +
 arch/arm64/boot/dts/apple/t8015-common.dtsi   |   1 +
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi     | 930 ++++++++++++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi          |  21 +
 39 files changed, 6236 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8000-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi


base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
-- 
2.47.0


