Return-Path: <linux-kernel+bounces-268402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885694243B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498691F243DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3044AC8FF;
	Wed, 31 Jul 2024 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHxnza5p"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA0C2ED;
	Wed, 31 Jul 2024 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390199; cv=none; b=HfI2DRK4gfmR/BRUzVDppMYs2Et49eHLkAPEDZ0Ok6I4YQeLO3UptOzx8Ta7OOx9NVgfscIyIdkbi41H/T/NAvhQ7ueDq8XTgsGv7Mj8IADpQ5cukorQSBJMpehblTsV2mcei53N7CNWSBqHte3iQ1e4+oqjWCdTXh+vuizo1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390199; c=relaxed/simple;
	bh=fQjwx58jaL9QFBkaY8Y8Fn/SF8GLxru5rT4IZJSzmLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PbMThj2QNsUsAH+/GUViqiLu5YUWjcIilyu67iQKYqJyNTcWJ6TnKuVwZmvCAv8G6hB+zJaDlawuBG1KdOCV4/HtfNPzqDyA6cUD4z5Dk0EnHp0+koDC4Y+W/IBD1YUDiTk5ykUE4Yn9OnsA6Duz93U/pGr0K7pSmSCCRvxlrhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHxnza5p; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d18112b60so384109b3a.1;
        Tue, 30 Jul 2024 18:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722390197; x=1722994997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/en+lkIxC1dsuLuhNmN5BGywFgSuVRz1KCq0xfBNjdg=;
        b=AHxnza5pn0AyoYV7Kw/i3LGV8mPOdcgipy9DAC1ZAb+uLWJLr+Cd14oI7sGIFohVlO
         B0vgWHBSsRa5qsM2pueFdPeKCQ58+YQR65wRHXTRXYCjqvF9aN6z7o87+F5zVvQVDJyl
         fsj0S8z4nTEwOjydN8fqj9njcs6xDHRsWY2nL70Bc+Lqj5R/ac0uot/T+OLiId/R1yyH
         78SiIXeYUuUZm7Zvpbkv/iaCDX+CFO4pkYaHo5+BNyeGZtljfzxnSmbqpuMmlcWeo1No
         KQwSwRLfioHB3af8qHA5Ml03q6U3TgsMMcFY10LjL8cL+mZH2DdTlaGl8jyoZmkYFt+J
         p4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722390197; x=1722994997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/en+lkIxC1dsuLuhNmN5BGywFgSuVRz1KCq0xfBNjdg=;
        b=GrorWgHFSF0rIR8VPjUWxXW5yuv0nMwBmm82H19x8oiQ7hZ6bRyvxf0E/2yGfu5rYb
         geaK2P9bGiTFFN1Ti6bvPCJzDBwYl0pIRZ2dH8M2n77g360UDwYcc+TEdIth+K3k8D18
         sI+m07AH6xrjbXh0xzu8TvN0z4HGO8jEAyx6gzFteavH+scUxJgpooWyhCX1FXIJSh3l
         rNsLTyEWtAYcy2xkIrxULVLsD1ClraOJPRFWqAyrG/dWqzAs6/eRZ63dsRjoOaoYvUsh
         hlupwKIryNfIFD9BwOMzkXSOLAz71z40TUQxFH3nMwSTuugVZy58qrUb1zLheooLihxY
         p46w==
X-Forwarded-Encrypted: i=1; AJvYcCUtpU+XVJfLKtTwe3pGBYu2w01UFF2J4oiEgaVFsNABSGfPrZTnBpWkvr+5eeR/8yjelJCrAIAk6PBjIliHvwiK/UsBxGP34IG8tVBO21X7ZWnAkdRpX8QRDcjv2ChV+A2/qS+3x0sJXg==
X-Gm-Message-State: AOJu0YynKcgy2+dLYF17xtzMmicOT3DLs3KBdn4s451rKTSr++BEi3//
	S80ngQeuF4RWjFp6awiZUuplP0qpVKYfifskU70CrOAYLjDnY752
X-Google-Smtp-Source: AGHT+IEO9+FJ9UEbKhXdX40ya/ca18BX8ZeAK/q6Tyj7eDOB0qtDQ/hVhInszN2CuvNXMCa3Xlc+Gg==
X-Received: by 2002:a05:6a20:8424:b0:1c0:e1a5:9588 with SMTP id adf61e73a8af0-1c4e473c57cmr6425606637.2.1722390197351;
        Tue, 30 Jul 2024 18:43:17 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a48aasm9003534b3a.196.2024.07.30.18.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 18:43:17 -0700 (PDT)
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui-Ping Chen <hpchen0nvt@gmail.com>
Subject: [PATCH v2 0/2] Add support for nuvoton ma35 usb2 phy
Date: Wed, 31 Jul 2024 01:43:11 +0000
Message-Id: <20240731014313.113417-1-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds the usb2 phy driver for the nuvoton ma35 ARMv8 SoC.
It includes DT binding documentation and the ma35 usb2 phy driver.

v2:
  - Update nuvoton,ma35d1-usb2-phy.yaml
    - Update the 'nuvoton,ma35-usb2-phy' to 'nuvoton,ma35d1-usb2-phy'.
    - Remove unnecessary descriptions. 
    - Add explanations related to SYS.
  - Update ma35d1 usb2 phy driver
    - Update the 'nuvoton,ma35-usb2-phy' to 'nuvoton,ma35d1-usb2-phy'.
    - Use readl_poll_timeout() to make the system more efficient and the 
      code more streamlined.
    - Use the same variable name. Update the 'p_phy->dev' to 'pdev->dev'.


Hui-Ping Chen (2):
  dt-bindings: phy: nuvoton,ma35-usb2-phy: add new bindings
  phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY

 .../bindings/phy/nuvoton,ma35d1-usb2-phy.yaml |  47 ++++++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/nuvoton/Kconfig                   |  13 ++
 drivers/phy/nuvoton/Makefile                  |   3 +
 drivers/phy/nuvoton/phy-ma35d1-usb2.c         | 146 ++++++++++++++++++
 6 files changed, 211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml
 create mode 100644 drivers/phy/nuvoton/Kconfig
 create mode 100644 drivers/phy/nuvoton/Makefile
 create mode 100644 drivers/phy/nuvoton/phy-ma35d1-usb2.c

-- 
2.25.1


