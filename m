Return-Path: <linux-kernel+bounces-334918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C742097DE49
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFB61C20C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2D4D8B9;
	Sat, 21 Sep 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyFlgGAE"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8EF3A1DB;
	Sat, 21 Sep 2024 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726943378; cv=none; b=gb3U040QSrs5VG+dkO7kvrrd1J2DMLu7T4ao4PN4Ces1xeJqVXKYzfIVE2SVnOVqjWaDH/Z6HLE1unNpEiCYm0DtT1E8o3WEH3A2AEYP6L7besooxPJnN22b/QWx00Y+CzAWIfhtnxKE5D3NFNWNBY4zJIv+2A6UkkRii7tF0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726943378; c=relaxed/simple;
	bh=h98Bq69P1zj6JwcFD4NaD58MUvifI5hIx8EsFHqzMg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgY/+weBqqBiil7x8Fe/KrvcUO8MuW7Co4uXKSbhbiE/pBhui5k88Fk8hByDIAC6Oa5c2XiO1/hKbwxH7f8KXpEPcefr6CnqFWf9AoWGczpqz4EjykgoF6sfG7QMzmelHpFsKi6Sc1aSKMhYI7WQvME5WX37HnmYUGO82GfiI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyFlgGAE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718ef6a26dbso326800b3a.1;
        Sat, 21 Sep 2024 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726943375; x=1727548175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TcNRX8wnBu48viABh6ZeaYXEnGmE6WjPDz8bISbR8g=;
        b=AyFlgGAEM/aJBsM0OeHgnarDd33OlVP2ERcvT8Bn9DZmvUQGyoTkYSmVM7I7gBB701
         WB0JnJl8ukNKq4qZHOkuAipqKsQfhZX+536v8Pqtx7svevLfRLKnhxS5dSJA1iMxwqQM
         EW8ClQPb6b4R3MAUB4CVZNC1mim5OH89nt+4+946jwkLUNQ05OICrmqy3q710lvayLq1
         mQwtK1h//cs/C8QqI04zgwK1H28AzGfG5RjUuc6gI+KmgkwlFpUwD+dmWGLTJABf2Sah
         YsUFAVASy8J0Whci/kVFOVTtNtLR5EGzx7guTCX21u+Cfhh2XuPg6VDDdx9wOTm/yngA
         K3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726943375; x=1727548175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TcNRX8wnBu48viABh6ZeaYXEnGmE6WjPDz8bISbR8g=;
        b=JE/mgEYKZ/ubheDCqu6xarNZtiISIm9BlWiT/8OylIX9YOPHCIM+oVseWsVc5f8mnj
         NCwALMQvozxSy6gQ51WiHy19nf12+mPvr2acgbHC/JD4WiUXlKe/OqmSFudjcYz15sXW
         cbRjLQZ2S4Hn1V0YhHFDxNPM/O0i+Y7zRobikanlSPZ/voJJH1zc4adxOGgY+vXBQXzC
         7GWYKm6949nxw1N1AnzVVT1lAg+a7HAT1ApBB0p+EA/YRJOkJqEty88lnW0ME9S+osmn
         VdD7TP0EHrgGFFKVYJ0KzA3sslXevJKCCInZbqq3Ftc+OKl309CWtK1mspiNZWBcQyfa
         PYGA==
X-Forwarded-Encrypted: i=1; AJvYcCWrln7tvX7UjfXwBhRSXPu9fV/uEWn0qodE8UektMrf5omoH+01Do8RPks1pVYc0ovPfI8ln2TBbgR5@vger.kernel.org, AJvYcCXkbr/sySSJcQ2AKguE+6rcSiDZ3YX2PalzXjAwQjvZYvN5null3fq+76QkvkwPBli3mxIRqxrGcH6ZBgOO@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJLb3fAm96DYlmb2JuGsLFcpBkQYyoqtt6hTT620N2YKtIQkH
	bBecw81Kicek2+wUbF5pznC6uZo0SAsqCM3f7DAAcC1J/utJGoxe
X-Google-Smtp-Source: AGHT+IF5qI6LDNQNtrOi0Q7hZlGTxrLdAfRYHAj57CP8bB/4CvbSwXv75n4YF229X24pky075M3HsQ==
X-Received: by 2002:a05:6a00:3d49:b0:710:51cd:ed43 with SMTP id d2e1a72fcca58-7199c973aa1mr4170927b3a.1.1726943375045;
        Sat, 21 Sep 2024 11:29:35 -0700 (PDT)
Received: from localhost.localdomain ([221.220.134.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4998b96csm11080441a12.59.2024.09.21.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 11:29:34 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add support for ArmSoM LM7 SoM
Date: Sun, 22 Sep 2024 02:28:52 +0800
Message-ID: <20240921182917.64756-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add support for ArmSoM RK3588 based SoM and carrier board.
Devicetree is split into .dtsi (LM7 SoM) and .dts (W3 Board).

Info of SoM and carrier board can be found at:
https://docs.armsom.org/armsom-lm7
https://docs.armsom.org/armsom-w3

Changes in v2:
- Change name of led nodes to fix underscores in node names.
- Remove property "pinctrl-names" and "pinctrl-0" from pcie2x1l0,
  pcie2x1l2 and pcie3x4. PCIE works fine without these properties.
- Link to v1: https://lore.kernel.org/all/20240918165008.169917-1-liujianfeng1994@gmail.com/

Jianfeng Liu (3):
  dt-bindings: arm: rockchip: Add ArmSoM LM7 SoM
  arm64: dts: rockchip: Add ArmSoM LM7 SoM
  arm64: dts: rockchip: Add ArmSoM W3 board

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-armsom-lm7.dtsi  | 459 ++++++++++++++++++
 .../boot/dts/rockchip/rk3588-armsom-w3.dts    | 390 +++++++++++++++
 4 files changed, 857 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts

-- 
2.43.0


