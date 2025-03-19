Return-Path: <linux-kernel+bounces-567669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98CA688E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEAC88464D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42BF2571C4;
	Wed, 19 Mar 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEYYUjGH"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3091C8637;
	Wed, 19 Mar 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377681; cv=none; b=H8df3lLRQDCz7yAQdR5RML/2AVjGCbe9ncRJhcg/mJ6y2AH5A5z6kO88HWk43Z+ccGilzuvYIEaRfyTg8sn7yQxro4cl067qCJnRPOKqVDcDraFjz6PNpa5ey8wbyYPMR7uwcvZg/qgBMENlY6VO9bC9bp5t8OnXL2RzBA6E97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377681; c=relaxed/simple;
	bh=PMk0c7uKIxAn+T63Z5jwhxs6lh/HmsfYncTnpawUELs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dVJPGvIFTFLm1yPXxi8Qq33G9Glk4iZ8NPCHaXyHnHEWjIuBPWpTmmqMz/LEAfctkzuqCws7VyxMLMWvxIUpD4hFA6GrBOVY2Kt47r25wvIL11YOJoDwBFtr/LH2NFTzjmzYoOQ3nhrnEinviz6C9Hm6HiRa3EI5aEBUfTZR990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEYYUjGH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2254e0b4b79so28311555ad.2;
        Wed, 19 Mar 2025 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742377679; x=1742982479; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sbZ47FHRO8GhpAC9R2csVeiqmhI0azn0pBpxkZV5e70=;
        b=mEYYUjGHrkrDDKR7SMLZOylulB1wu44sWquLErkmHZn3cb/vomW61F1rtx/3Q2uzoi
         L3+7AqAF+xMvUAr1ATxQpq0oUj9HQYsSQNr6ri9k3Blk3rwKuGdwLqzREWI24Sxor5BT
         ARWtwaoMBPMWlOzzPQbx3Jj8YWeysAQyAO9XAbIB9Q2oqvQbr8tocY7p4/cE1C5oIf9P
         joAH1vqbeTaUj13oKxXvNwhyUAKL7uWiY8dS3c1WeaHNa9ZpTCa3lHRDmcN34fn+Rhh4
         ZEZ/05Rc3fbcaycbEn/5rwUGkiP7PEnvxtZvfMQ/inbPffE9hiEN3Uj+DBzeIErlOCx3
         gHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742377679; x=1742982479;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbZ47FHRO8GhpAC9R2csVeiqmhI0azn0pBpxkZV5e70=;
        b=qLP2o4GH9qQx3QxVCsr8qTFs3j7xaVM1+MeRqZFdUQZG/ERbD8mMh+M2yQp0zllfWu
         veZlKd1Q1unJDMwbitvIcvUv7OYQj2dvv3YA4FWLkGOQ4ziXsXaiKLXIXqoJj4d333H3
         RO92VGJVWQenV49i9+A8IUlUYktaprsCZZmAiYMk8PoB8ptEBCFysMyVs0Lv4mzjde4w
         ORnamLLwbu+1RZ5AUm9NS310+BOOeHibtvNeMUUzrReJYxLVbV6xfUgtN7bILdb5Lc5j
         aqnrT8gJccAXRXCfzEREUJYqhmflXLbEZYBzvt1VZ68d/iWggXA89mVx0vlzEAIg8B1E
         TMXA==
X-Forwarded-Encrypted: i=1; AJvYcCV67vRdZfaFQtF4Zksueeg60q5mWgNwktzHmBZDU1X8qbgqbZl8pmmjiSzHKrvXvaSRuM9cSjUoZ4vwqt2D@vger.kernel.org, AJvYcCVkUUzbM8YB056AIw9PC9KAwubvoQNKjmHf5ohJ68d2Qgk/3+6Wqk+3ckUXods1WoXl605wrVDthVCn@vger.kernel.org
X-Gm-Message-State: AOJu0YytO4WZWv1uxuW6/pgF1QppH04Z96uF3G3t91ibllR+eX2JNo73
	Rf8WLSOSb1bPS/JeWANtGvDLZVJWvW4khA4rI/HvSmNSiyjyMU0Lz0Iw5g==
X-Gm-Gg: ASbGncsOvUK94dBOr0hUFeoB6xvlzDxkZMieADZn0Gfk3es/Usq00/Ykf7hsRhSmpdX
	aHbryjshmzLAajx1B4KIHqlqwo2boDjKJf6C6fcwzs7Jh+bX7TNN1HSdgdb2bYMajsP4QpMybIh
	GWvlpYiiyFQye2Jg9+Ia7HGtBZWKSpVhT7y9M9veXpAr+9T3/hpcpCnDdizsP8xw7ox7NlB9WbV
	JAu0qjHMHhYZTlYy9bBZxHp//08397VZEZ3UogBKUev+qM5fivLfYQk1Ow/rvtSgzZNEIp3V7PY
	pSqyIe6w/IEfQepZS/bxsjoThdVFX8hPeUc9eHX+Wguo+nQz5aDpIdwkcKRizBAlD1bVZ/rU2WG
	t/JePkvryneQxpEniLtkS9pz1dsz6Y349AK7GPA==
X-Google-Smtp-Source: AGHT+IHTmxf8tW2M1KZtfHI15upvypUupgDK1VnTqwzKkg65HgVFiFFIiQv7mkavRYVjgTTd8SaQag==
X-Received: by 2002:a17:90b:3d05:b0:2fe:6942:3710 with SMTP id 98e67ed59e1d1-301bde445a4mr3574609a91.3.1742377679003;
        Wed, 19 Mar 2025 02:47:59 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589bccsm1103483a91.11.2025.03.19.02.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:47:58 -0700 (PDT)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 0/3] mtd: spi-nor: introduce optional rdid-dummy-ncycles DT
 property
Date: Wed, 19 Mar 2025 18:47:42 +0900
Message-Id: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL6S2mcC/x3MQQqDQAxA0atI1gZ02mHEq4iLNknbQB0lwdJBv
 HuHLt/i/wNcTMVhbA4w+ajrmiv6tgF63fJTULkaQhdiF/orel4NjZWR92UpmKnQWxzTJaYoROk
 +MNR6M3no93+e5vP8AZ9ra9VpAAAA
X-Change-ID: 20250214-snor-rdid-dummy-ncycles-73575ecc7b8d
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bacem Daassi <Bacem.Daassi@infineon.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742377674; l=1201;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=PMk0c7uKIxAn+T63Z5jwhxs6lh/HmsfYncTnpawUELs=;
 b=Z7wgIOhMU7hQ/wL7cFqCkBQZM5QVjjiylMBcS6ZIm2nx6iFnh+p2AprMpA2RcDa7eRDWaQxQH
 3bFr85fDBDODFUIOplpDU8Jo4015PZ8B+7QSQXzdvUgV0leJNVLgVhf
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

There are infineon flashes [1] that require 8 dummy cycles for the
1-1-1 Read ID command. Since the command is not covered by JESD216
or any other standard, introduce an optional "rdid-dummy-ncycles"
DT property to allow flashes to be correctly identified.
Add support for CYRS17B512.

Link: https://www.infineon.com/dgdl/Infineon-CYRS17B512_512_MB_64_MB_SERIAL_NOR_FLASH_SPI_QSPI_3-DataSheet-v07_00-EN.pdf?fileId=8ac78c8c8fc2dd9c01900eee733d45f3 [1]

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
Takahiro Kuwano (3):
      dt-bindings: mtd: jedec,spi-nor: add optional rdid-dummy-ncycles
      mtd: spi-nor: use rdid-dummy-ncycles DT property
      mtd: spi-nor: spansion: add support for CYRS17B512

 .../devicetree/bindings/mtd/jedec,spi-nor.yaml          |  6 ++++++
 drivers/mtd/spi-nor/core.c                              |  9 ++++++++-
 drivers/mtd/spi-nor/spansion.c                          | 17 +++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250214-snor-rdid-dummy-ncycles-73575ecc7b8d

Best regards,
-- 
Takahiro Kuwano <Takahiro.Kuwano@infineon.com>


