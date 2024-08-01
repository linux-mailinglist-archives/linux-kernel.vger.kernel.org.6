Return-Path: <linux-kernel+bounces-270644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783099442BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A20B21771
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B78149003;
	Thu,  1 Aug 2024 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5STmm4e"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95E2744E;
	Thu,  1 Aug 2024 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722490671; cv=none; b=CWkbG3Gr/pLrnFF9FO1F8LeX2hTeU3JcPYwXgj5AMhvy6hRxfvQYBTJNT4hCfamwWWgBuvpWsjmPo5ktL9DdYcBCbbsfEYPgHRL2qXSnBvSlb5cALfU7zHreEv5R3WhPmusmbDRqYp+qUdKtc3WXdDKQt8SLixjMIeBwiPHybho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722490671; c=relaxed/simple;
	bh=43gGnQm+EZafvVQqODfIhZJ8inmf3mvRcqGiSYbmGtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aYLbv4tQxMM8rOfWGF0xV9brOdK+F8V4Ujy+F/cb9Vo/PuerdWTLZLxCLCb+y0R0pDcgKamX/+V6joXja4brROdU7lAEI49lQt5Xvsr9jcHFGaRFYtBltkPikGnNbahivEipy/oRBNCBryyAnMeaXk1na666ftUprbc4ifCxkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5STmm4e; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so5784242b3a.1;
        Wed, 31 Jul 2024 22:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722490669; x=1723095469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rP7kB86ul/PcFVSAaxx7ceabaGdXw7owjoCpBSOG71A=;
        b=Q5STmm4egjUYiHiJ2ITiW5Hx6XK/mqTqtv25iFfmo1BcEhu94+1w14KcXgXvEUWvAd
         o8BYgUhhv3myA9upAfIEoM+UIL91N5dPwFm+vDc/iu9J1d+o7BZN9yYBxK91U3i6AkzH
         CUR22FNahjhDQ6whpwj6YLcyDSATk1FDqxSY+wJ3pRzg0O8jJoESz6RbgFqGCH6vkj/v
         dVTwrDNxgP1INq4YFrGRC2SVLA+hg3jAJIkf/CSLTsP+blg39PEIcsPaoBiLSny5/8m8
         ib1bjWSP3UkhohMuzSWxUPgmWGa0uGKV64tKFWSRzQqiSJwJAy8Li0dWKp+tVGJM9fAH
         rolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722490669; x=1723095469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rP7kB86ul/PcFVSAaxx7ceabaGdXw7owjoCpBSOG71A=;
        b=FJKB5jXeq3EFhZHCP1SlCzMkYYA9vd7diBZHMyWyt8ja1VxMWuLqxCaMSZc38hrANO
         lj+qDqiijJJ7k2C01osWOUA1A/t3kBvRHU8gN+HinV3ixLYO6dyrfV0uUVNPRR813jzW
         u7cT5Y0mzmkGAlwfKrFUxlUQzEIS/gCy0xPrcdkqXkbglHJu8X/M16cdsi8CiIRXC7ES
         CvgKr/YxfGNZB/rw7sCL0pnvybfFho+6luE45tgQWux17GmPoW31w03iSeOnzESjgYC3
         /Qaye6k26MulrPV+cjs2bHZXVYZy9diPKRHH1tgqt9o2MuF/21dBPY//1wo/jhHYR3Ix
         HoyA==
X-Forwarded-Encrypted: i=1; AJvYcCXe9ZkH7VDA/uZdLtBpaKDSsJAWeAx4a6/YUauofweHnMfNPMjlxBm0y+oZ8p2IHD62tnh2RwOZm1DFfi6FmBzonqRiGJeJ8Sl3e28sfGAomwvseqOI2epauaW+28XmDxuliTk3/4O6og==
X-Gm-Message-State: AOJu0YzhwyLp2RspqDS7ZLVc5nE4LPSV9lWslgXhSisQrYHqY4d6C+3W
	8KYoht82FLs9NOIZqTM/CgcuG7wBwSqn+FOsdDkF5tIXNQNuZBYELiN/bQ==
X-Google-Smtp-Source: AGHT+IFp5hTrwS65AqU/9trFX4Tz4W1sMCzo9JgNShTU0C2wTw+AmFV2NvsaaC+syk01WyylMut2lw==
X-Received: by 2002:a05:6a20:a129:b0:1c2:8dcf:1b8f with SMTP id adf61e73a8af0-1c68ce9f023mr2474971637.7.1722490669452;
        Wed, 31 Jul 2024 22:37:49 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72b89csm11106876b3a.94.2024.07.31.22.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:37:49 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Add support for nuvoton ma35 usb2 phy
Date: Thu,  1 Aug 2024 05:37:42 +0000
Message-Id: <20240801053744.807884-1-hpchen0nvt@gmail.com>
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

v3:
  - Update nuvoton,ma35d1-usb2-phy.yaml
    - Update the syscon usage description.


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

 .../bindings/phy/nuvoton,ma35d1-usb2-phy.yaml |  45 ++++++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/nuvoton/Kconfig                   |  13 ++
 drivers/phy/nuvoton/Makefile                  |   3 +
 drivers/phy/nuvoton/phy-ma35d1-usb2.c         | 146 ++++++++++++++++++
 6 files changed, 209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml
 create mode 100644 drivers/phy/nuvoton/Kconfig
 create mode 100644 drivers/phy/nuvoton/Makefile
 create mode 100644 drivers/phy/nuvoton/phy-ma35d1-usb2.c

-- 
2.25.1


