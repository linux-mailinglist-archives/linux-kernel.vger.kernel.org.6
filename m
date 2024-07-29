Return-Path: <linux-kernel+bounces-265139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE7993ED3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 759BBB20CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C3984A50;
	Mon, 29 Jul 2024 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiarIFb2"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8F5811A;
	Mon, 29 Jul 2024 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233717; cv=none; b=mr13+fSYoYIjZ6QKnhcGHmwKZXud+W4sv2dfq7fOGJ1sRsUgyjKU6HeO+6LouGjGd4FMThJPKGmFXdI8rxpqN3H5ofSjx6deWtQqXqSLcC8aRn8LaH1KnBbfLmrg2GSUwhdo1EqUT9z+r0A1Qs+6L3tM9zrxo02tNM2HQt/XOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233717; c=relaxed/simple;
	bh=ohdm9U8pGSb+ODDHuG64S2+tS59dP7IMxId1G9XNVx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jZJPEjpFJj9SND1eAz/1HWViIcrOQWcFcGznaqRlOtOgo1sERZ9beMwO0utgRbq4T01WEa28yxtb8LFfMRjwPoMU7x/6nKfOIZ4UUiU9MdXK1zqKRH0aYvjXbHj/s7CWJsg6oTlGTS4bqpk4Szy/kDIY9QwTBZCvNOCNQ1aDfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiarIFb2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c964f5a037so1723330a91.0;
        Sun, 28 Jul 2024 23:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722233715; x=1722838515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RkdmkH9P7FNHCqeL8cTyw/SKGQeTyqFKsGJjHolVZz4=;
        b=AiarIFb29RLrPN0GLm2MJZj5D7GVTT8ERcEgvLYrOynKVOg9/CtknSFoaI+99xV/Kp
         65kdEO1i3WgP3sXgW/IzH59B+YT+ov1PS3B3o3l1TPL37CQbWP95vegpK5GcdBsZQPkU
         8ueUqC0Emuq8/c4W2d4Gk/EBtvi0UGmsITaRZ4fhoz3g5qoyEq4Caz9Z/KMCpKEgTwit
         VDZtwuHAoMx7UUgvboGIOJCrsfDfrz8GGHVGS5ELOgwyp9jWiLzwpEdGSMON/qh+bHtY
         2Kf7xwYhQqlqOT6vwAO0nXrxk/rXrj5ychCdSj2IErqRMZ6EcpyHQdzAJOeyv5UndBYX
         +MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722233715; x=1722838515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkdmkH9P7FNHCqeL8cTyw/SKGQeTyqFKsGJjHolVZz4=;
        b=V05gQyu0CJsk9e8uvAW4lcCFzSJpBZpr+f41uWnfhRehK+NYYZYp9xLiw9OOuyCbZA
         duAWQbhbtmg7A1+rY2jkOpkTnUAV+lXuJG8weCtSTyQhN3+AS2Wai3vZzUkC3WjiHfdO
         1dtjmo4ZgCybv6VtyDzpwUzDmIXlRMQbdEaVxy9qoT+dZxnvQsj+R9bsYZz23pHsBit1
         f5PvDgaQtsxXVidEklJLxNSYPGYGyrWKW7KJnyfAy6Mup2QWiELdijkRZUfJLTcrlcnl
         3D4m8D7+6yNNOdgYe8+rph+2NcPkEerAwTBqpbz5ssqOSEkiwcOWEBsBqx3hhbczEJV9
         2U6A==
X-Forwarded-Encrypted: i=1; AJvYcCWi/xMpYwuYK0L7zvnCNbfT+diBszrRqGGm52J3zDZeFWJcpmA7fS9l3MQmKZgF3SOVCnrPPOU0Yzed2/BDp6OxBMDgTZwkjWKSQluaXFqDlzzk7qaY5BayPgfwi07o5sV9NuBprOL0mA==
X-Gm-Message-State: AOJu0Yyv3dLrXUrMBbDR8WmHT3Fe/qsF7AB/M56a40ZQaEUf47cRhig8
	4KPTgKryMJ4FQvRoudpNYUL30b/ImDjGSIdoVRk/jacoqKr/QERV
X-Google-Smtp-Source: AGHT+IGob1bEgytYJnj0SiiCG3A6boOEiSQ01nw4oqdlBVhDtz8jfOxe1az8Aj1H3fB4jZddi6ow7w==
X-Received: by 2002:a17:90a:8d0a:b0:2cb:4e14:fd5d with SMTP id 98e67ed59e1d1-2cf7e1f7f76mr4475705a91.17.1722233714943;
        Sun, 28 Jul 2024 23:15:14 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cd8cd2013fsm7951282a91.0.2024.07.28.23.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 23:15:14 -0700 (PDT)
From: hpchen0 <hpchen0nvt@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hpchen0 <hpchen0nvt@gmail.com>
Subject: [PATCH 0/2] Add support for nuvoton ma35 usb2 phy
Date: Mon, 29 Jul 2024 06:15:07 +0000
Message-Id: <20240729061509.83828-1-hpchen0nvt@gmail.com>
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

hpchen0 (2):
  dt-bindings: phy: nuvoton,ma35-usb2-phy: add new bindings
  phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY

 .../bindings/phy/nuvoton,ma35-usb2-phy.yaml   |  51 ++++++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/nuvoton/Kconfig                   |  13 ++
 drivers/phy/nuvoton/Makefile                  |   3 +
 drivers/phy/nuvoton/phy-ma35-usb2.c           | 160 ++++++++++++++++++
 6 files changed, 229 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml
 create mode 100644 drivers/phy/nuvoton/Kconfig
 create mode 100644 drivers/phy/nuvoton/Makefile
 create mode 100644 drivers/phy/nuvoton/phy-ma35-usb2.c

-- 
2.25.1


