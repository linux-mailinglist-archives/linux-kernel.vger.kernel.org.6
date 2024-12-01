Return-Path: <linux-kernel+bounces-426656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990FB9DF651
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509C5162BE0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455261D63CD;
	Sun,  1 Dec 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceAkaDoC"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270321863E;
	Sun,  1 Dec 2024 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733068844; cv=none; b=VVzEpsdSIF4Q2UfP2OKTUsVMY/9HUYBsfsQkr3kWhaWW5U75XVAFTPqn30YG+3LTPuTiqCtJmAL6p6K3Dty2tbXHuGRrralxb7dsuFaj6NR5MFvXdeU0XSQ/cN5qPXiiSjapJBnokwcfSn+oapri10DEO0eROF6ZpbwGl9Cjcho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733068844; c=relaxed/simple;
	bh=yt9X+1PBEQfF2AmldoMT5luhhth2c6LUe3IRgSiyEvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4An7TXMVG1iXr5Ycp9HzyTzUjqxjPXpVgVTCpJw5hROVhZZq19stzZYDgL2h0bXwCZGLGV5LkA8utArsajOWaao/dQdS8f0JZA9GwbRF/lpLZAbxefDzGnEF5YCrbMkk11XG3S1fD7xSW4KWqu58pP18FxdNw8a5UHdp4FcvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceAkaDoC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so1189067a91.3;
        Sun, 01 Dec 2024 08:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733068842; x=1733673642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLTw328DQY3n+nYpsFgKV/IZtfLPh9HpMEQT4J4adnI=;
        b=ceAkaDoCdr3+p3Egoqjcr5Oh3LXtKzw2Wku1OOtinzsHAK1ONzP53oPi2i0u9h2tY9
         3WXxeaEQHfci+Z/EWiZjelXFFN/pok11nu5LMU3YPHSFjajoWAJ8LAlSUgRadEbuebPt
         bQjoE4nMAwV1B2AxmFNcTuozgv5sBGsVCMUQkSy45Bk1oCb4ZfqXLgdzeL+kxOccY86R
         S/6a476Nmhrp0b1yl+FW5sV+2C90nZwSVORjekWyagDoc2FAWEsUPkgbXgQby9tt2TqL
         /7+ISBktWAL6v7UWBmRwPr3qsArxhoGM9+M1t5TA0OLr7Y7yD8w9C02KlzrUYg+uoHDj
         OFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733068842; x=1733673642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLTw328DQY3n+nYpsFgKV/IZtfLPh9HpMEQT4J4adnI=;
        b=h6FB/IHLB/Q3l8cHff5YwyOcESSrhLLeQKbw+Ab6NykZtvTDRl7nYQ52OrfSTN+R2E
         TrXHWlfkVxKeQLWaD7u1jQjw9JWIV0s1sDeVzXx2b/QBSgPhYCL6V4Ve3lgnCok3yidc
         i2SPUpgjnWrQa4YAxoJhsQ4cmkazPwNJoOhvYiukTw/vIRGSI90b5rmwdqgsz6P7cBYA
         VTv7szkE+8DuO/u8MhCdUWz+Sqm5TVwkgpJsE9n+vBhmnlHeNqdRvgIDgvacc+RUxh8I
         gs3P7vQapVmHPwiuO9v9A8liacrq45MnqA1uysisFoKacaUy1lIk6EOndskJHJl3MTsb
         tZjw==
X-Forwarded-Encrypted: i=1; AJvYcCWCok0AhwA9Krixn1jPSyfH5OAHRdMeY/Xa03lE9KwLIa4GNMm4sPqFTS4xJQDttxZraBGCoCb7k3eE@vger.kernel.org, AJvYcCX8ESIPGwhEZ3Kw6gWk8zZuVCho1Fn9TrPqJARewSpd6zSfcOVxJABXVOqn58wJhBJ2lzuhC9aoYeHYhCNY@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLUxVnuwm4NW+2Wt+OyFNyWSTI69ctGiPwIB/wqd7DWQZ7oIC
	8piLTDPAnr0cUYivBylwxwptltV78NA9ZfGtnUn+wvmTAYlwOZ40TKNVlg==
X-Gm-Gg: ASbGncswtsGCYgU1GCs8yGHjhrF6ILBf0aykPNalOtyv/dn2SkzlXUMwBGAQLnpsRAe
	L1vEUrSS/Vw8LWqTUgpXJJ3jZhiET4//7blH/FGJ/RueciKwswJi0deA/ugw0CjDscT5r+bckcc
	W2sxL1MTSL70npWhTiLj6KL4g6nQvoTEYeTrhsLviC6ZrV/XS/3zZ1QEym/ohYlyvh6CwEVJNPa
	Vbk9ubbBy4T7mZ/8YACey5NHLhry1v0i17tC30obkBq/ieXaoWBz7LajimKYKyurQ==
X-Google-Smtp-Source: AGHT+IGchtk633+rQf9MvvkRJKgrKmqU7Z/WSWsyNWH69akPMsMA/WPwo6E4IF9tYA9VQ12V1KU66A==
X-Received: by 2002:a17:90b:4a83:b0:2ee:bf84:4fe8 with SMTP id 98e67ed59e1d1-2eebf845036mr1872439a91.30.1733068840880;
        Sun, 01 Dec 2024 08:00:40 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2ee6ebc4a73sm2395173a91.0.2024.12.01.08.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 08:00:40 -0800 (PST)
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
Subject: [PATCH v4 00/10] Add PMGR nodes for Apple A7-A11 SoCs
Date: Sun,  1 Dec 2024 23:56:37 +0800
Message-ID: <20241201155820.29259-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the PMGR nodes and all known power state subnodes for
Apple A7-A11 SoCs, along with the associated dt-bindings.

Changes since v3:
- Add "apple,always-on" property to "ps_spmi" in t8015 power domains.
This is required for cpufreq to function correctly which will be added
in a later series.

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
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi     | 931 ++++++++++++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi          |  21 +
 39 files changed, 6237 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8000-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi


base-commit: 9ad55a67a788c0806b0fe23be36fae6dbfbc3fc5
-- 
2.47.1


