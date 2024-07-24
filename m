Return-Path: <linux-kernel+bounces-261290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE9F93B541
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CA71C238EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C787715EFC0;
	Wed, 24 Jul 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW+Xst6d"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968629CA;
	Wed, 24 Jul 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839849; cv=none; b=khoFYpBKSEcuIuHYrCptrgltTIGi2+pY0wGOaegPAq/do/0IRCROyhaUpACQTWbO97TddaY2IGGb01PYy8189wa4JYpFXlxWCjjRPm07CE5THjjIufH2hQbFnUKw2k8p4DbfUBTAtm/FefspzpdSxzWYEIgjqRmsYSENSr7uQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839849; c=relaxed/simple;
	bh=Kj4gXEfEmFE9FHoCnR3Ux9n/JpJ8gwvQUKaBEqcsWCA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ls4WWrsF+UmKrW05UnVzDzL2e3yVtwMS9SUp1RAxTM7yi5HIGmVgrS4RcMe7cARvP2juiZXXZf4NpynXp29wK9TuuE/QYzJXtI9EYHLfexWNUp9mR3qgkPKQoPjbmyKFJcaK73y3QzeTqurAR6oLGBa7jALSKzw7lU7GMk+kaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW+Xst6d; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so2769398b3a.3;
        Wed, 24 Jul 2024 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721839847; x=1722444647; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+/HPmCgoLxrwovpDdzS06IFzrN+HGTkUAppXRGkfKY=;
        b=aW+Xst6dHS5WsSaGtZQbBWw8kJCpTwjPf/w6aha0htJj3uNjqUjhhtG1cROJq4Xfg1
         oOsgCWhq+9rFE+xCcBweaHGL8K0BP80QqqYhY3xgPAnCVzwsAN10bve8Q8ffinpQD+81
         /knRl7SgBhGZdUiLKF2OJbTc9SzRuUW7RKLiPHLr76nZVpDjvoPejSb55DenqVwBU/2Z
         SCgB+47q5ZXrmtwC/dD0BKVjCSvL2cDR/+Xu4dYt6p+Cxs9Qcscj/DI0Ezq9sd63YsNY
         zm/kEY1968g8i6Pgz6uR1AN51RbUFgpCJrW/4GoeXOSgTWtR+kPLB36akfzw+sXkczDu
         B0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721839847; x=1722444647;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+/HPmCgoLxrwovpDdzS06IFzrN+HGTkUAppXRGkfKY=;
        b=rZwf2uQvSXtZEuk8/3f5/QYrbqiCIovxz5T6ZhPhK3DmEGuYs/dmIGIynphtVEj73I
         IuJFfVLEgVRKhSZLLfUA8Vcr4++13hHygJzfzFn7qCLimrmTLuM7bw7u1s8fj/lcWHw8
         GKFiGx80A5ybe3PIe+rFMdvMqJI+pmIdjcVq10mZGNYbzmXVdRxIgfankV0zBYUnlww/
         oLYgyNsmBYR8VH2FfMaAP/6c48Y1p3utqjekATkC2Oj6OJnsP+MCB64BLluoWKKCK5R4
         87R0P/jjEvm+wcgmUbrXh+5km7zcv3jkw8nA3h/0+tektB/NCZ9UeDvbp0yeuVnxHx2f
         dCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU29e/OBKcbVOJEV2l83FKFd3WVKB1Uv7hwyECg3dxczIbUw9CWyDt9q5VdwiaO5kpbNZoGLPMhkN6wwYIIagDLo0SjRkcgcybGSZf3
X-Gm-Message-State: AOJu0YxT2tzMg1R3l5Q26Zo5IAmSvhgr//DYep8NvpBaJg9/8vwOISnf
	QPnxaz9fdBeZ4IpiuBvdRd1KGrT2cBvmPM10QstD5WZk5rBx3YTg
X-Google-Smtp-Source: AGHT+IH6vAVxaSujDvt9ylhpszDTk+b7h8yq8KkjfBp5RP7A7fWGtrv5T4SKL6KYjlEyfd7OpzE4hA==
X-Received: by 2002:a05:6a00:66e8:b0:70d:181f:c082 with SMTP id d2e1a72fcca58-70eaa87339cmr110765b3a.11.1721839846792;
        Wed, 24 Jul 2024 09:50:46 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2f485c5csm4579942b3a.88.2024.07.24.09.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:50:46 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v4 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
Date: Thu, 25 Jul 2024 00:48:16 +0800
Message-Id: <20240725-potin-catalina-dts-v4-0-aa6f235a2e78@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFAwoWYC/33NSw6CMBCA4auYrq2BPkRceQ/jYvoAJoGWtE2jI
 dzdwoqFcflPZr5ZSLQBbST300KCzRjRuxLifCJ6ANdbiqY0YRUTVcMEnX1CRzUkGNEBNSnSzkB
 tgbO2UTUph3OwHb539PkqPWBMPnz2H5lt079cZrSiCm5GNFKXLf7oJ8Dxov1ENi7zIyF/ErwQH
 KSSprVXo/SRWNf1C0vrWJn3AAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai.pt@gmail.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721839844; l=1472;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=Kj4gXEfEmFE9FHoCnR3Ux9n/JpJ8gwvQUKaBEqcsWCA=;
 b=Ccey9k9Owvt9IYBGKNqT1aUICCBAqm7IP4AvtrS6itHBnDtc30iEMyGcrZPH12ca/NO3R9viZ
 TNN6r4wtzUJCLotWgUsJ4wpGXepHg1GgF5cuf20KAmvfmk//zmABIQO
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Linux device tree entry related to Meta(Facebook) Catalina specific
devices connected to BMC(AST2600) SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v4:
- change back io_expanderX due to parser error, build passed in v4 version.
- Link to v3: https://lore.kernel.org/r/20240725-potin-catalina-dts-v3-0-3a5b5d9e6dbc@gmail.com

Changes in v3:
- rename tmp75 nodes to temperature-sensor
- rename tmp421 nodes to temperature-sensor
- rename ina230 nodes to power-sensor
- rename io_expanderX nodes to io-expanderX
- Link to v2: https://lore.kernel.org/r/20240724-potin-catalina-dts-v2-0-ba8d475c4073@gmail.com

Changes in v2:
- drop commented code in dts
- rename i2c-mux channel nodes as i2c1muxXchY
- rename gpio expander as io_expanderX
- use "stdout-path" instead of "bootargs"
- Link to v1: https://lore.kernel.org/all/20240722145857.2131100-1-potin.lai.pt@gmail.com/

---
Potin Lai (2):
      dt-bindings: arm: aspeed: add Meta Catalina board
      ARM: dts: aspeed: catalina: add Meta Catalina BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 1020 ++++++++++++++++++++
 3 files changed, 1022 insertions(+)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240724-potin-catalina-dts-fda1ea3297b1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


