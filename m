Return-Path: <linux-kernel+bounces-274124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38CE9473B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 665D3B210DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0513D524;
	Mon,  5 Aug 2024 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQhJIpoy"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58814812;
	Mon,  5 Aug 2024 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722827043; cv=none; b=VPSXL7MSAhAyC6ubgt+fiNZ5yg24dhuDmy9LDB0Gp4rd+XGBn8M9eeGq2TOrhJ/mYKOdPTm9ENlzA6KjNIYrMhaIWYz4+O4U8U91nYXjDgzQticvtAvamWAYO9gqquZNCmVBwXer2egV24r2N//VJJkEuIzgPjNEMxb85HL/ihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722827043; c=relaxed/simple;
	bh=UHxHQInyvlJoF+1bRD7criOe4CLl+X9P1bII5c/QdXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Co2kigu83nWIQVw3wBqzV76rRzH3+hGaBGRGdVYwsYuBQ49sr6Gqbfxj1/sg8rEM/mcoGccqMyHa6X/twGpa6447PNTiBqJ3raW7VoX5xnaFStosEyQp4NRCUrFtbsnua/8gP6Ug1J+bFZeq9uVIAa86HXg4Wp2yAHl8+qlEeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQhJIpoy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d150e8153so3353611b3a.0;
        Sun, 04 Aug 2024 20:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722827042; x=1723431842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dfjUCpZ3Zeoi/Y8m9mARD2xm2PJPEWw2qGGhgWcumzw=;
        b=JQhJIpoyaKEo/0HmUJJXFAJugMmYwzhtFNndr6PhV1pBcScaG4w/CUxVBkqleOShl6
         L5lIlzPTEPXUlGcam6pJh8CKJj6XQ5DyiJqjwaNr/4DgA5vdTLbJ8XhmkDDvBBfTopWi
         WJ7e7lNA6He3J53invPdBo8khR3xXeXmnpE+rYaLH+n3fllnrC3AwdoGfP8klIkYF4uf
         bDNDPTzUxpgvkmWuKTzxO0OFzC0uhvv7JE5Wob+lD0U9S4zxJkKkRo56k9k1iq1iiGQf
         Hfo4/s2IX78Ex0Tz9ow1tBCmcDQ6bfd2sp0XDiTevWMg/81yYMNjadAHHoP4eaT8d5kz
         /0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722827042; x=1723431842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfjUCpZ3Zeoi/Y8m9mARD2xm2PJPEWw2qGGhgWcumzw=;
        b=Rq75KNSjjcVFUCNJLSzl2uUsobcIlKyL1J4vXNO+Yv8VEM/tUBCMrIiDo2vRVZ0Kxk
         Xoa5CpVex+05E/lxR5KD90tLqqqi8sdvlFp3fHDcV+rP5zPk6kh7v4S9u3MNszM+Bw1a
         gPjUUzaQ8SelWiRnz8kFPS8riQY1xWgMYPrd9s9vHrTMnTvrNYnheVzubGHNbqwRXbvd
         dqEWqfDt91MI0q9PNOHY7rpuYHJL7dDxJFGr7tOZDvJTTbin1vj4cNQQ7deodqPsecjl
         4jC/7dYqUoPfGyJ5OTUewaPaovU7cKhupQs3PaziEdMT2kheFebQ2HNDVHTsOWf2e6az
         8vHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtCTlQC8hbq02FZ57ys/XQn//YOFJZsiZYsP+RBDCNABMEe/JzgOorCjGOtZ7vbq1bCx54sMKak4c7aSQ4@vger.kernel.org, AJvYcCVD5YcCdFyaY24KqwTHXx1kuyReFUi7b12GX56dkTsonmVQ3QxIYhQe4K9oK8FRDrDTipYBXZujPc1A@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv9rxYB6hfMBoKQnsQ5cPoNSmHdJxsHavUKQWVgKHMDit9ZIm+
	UGqDShsCc8UEnjD+w3L4Rc8sEPpFUrW/2/BpTEo4SQcxNK/REEC/DKIzjg==
X-Google-Smtp-Source: AGHT+IFhCUHNZPfe1fqJ3PZ3Ngk9ynsPXbv2x+Ddc9yCddZJfg9RtJLhh7Eu5/OySxn6RqXoAtE0fw==
X-Received: by 2002:a05:6a00:92a0:b0:70e:cf2a:4503 with SMTP id d2e1a72fcca58-71065f1e257mr23009434b3a.11.1722827041477;
        Sun, 04 Aug 2024 20:04:01 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9c2dasm3823210a12.8.2024.08.04.20.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 20:04:01 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add support for nuvoton ma35 usb2 phy
Date: Mon,  5 Aug 2024 03:03:54 +0000
Message-Id: <20240805030356.14565-1-hpchen0nvt@gmail.com>
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

v4:
  - Update ma35d1 usb2 phy driver
    - Update the 'readl_poll_timeout' to 'regmap_read_poll_timeout'.
    - Update MODULE_AUTHOR name.


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
 drivers/phy/nuvoton/phy-ma35d1-usb2.c         | 143 ++++++++++++++++++
 6 files changed, 206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml
 create mode 100644 drivers/phy/nuvoton/Kconfig
 create mode 100644 drivers/phy/nuvoton/Makefile
 create mode 100644 drivers/phy/nuvoton/phy-ma35d1-usb2.c

-- 
2.25.1


