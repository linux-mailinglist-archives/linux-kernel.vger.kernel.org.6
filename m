Return-Path: <linux-kernel+bounces-274944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5625A947E92
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C14285B8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459224CDE0;
	Mon,  5 Aug 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLDnXm6H"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41941746;
	Mon,  5 Aug 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872943; cv=none; b=PSxuH1k2H5jT/0jDsx+IblN7OIrAVMuKjjdh3CGjbBgqrlm4kKlg2IChqDGHr+TmlZ3cqoMUMJHsXQVE8k1LA6auQdGkBzKJ+Dle/c+rfXY/0rZhPXjbrqwOUzLCYVJbcb80rE2dzPbWgGDMRC8zKt5xL9tkyCWEIsSmYaYbRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872943; c=relaxed/simple;
	bh=3CsJgkR0mUZo4A/DQ7qYKhVfPLpEdxnVGjuyWySSv24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jjOZgvmfF0zxdkA2AoVSZRTFTBLTG0V9mTk5bRJ/BF42viIOIq6GxHdWNs1KT1Gdee8fb2bEx3GdBiaoAi7yUQ6juRaQN2rlfS00DrFYUN6j8kVJfLG1k2ezli5aID2uuthUzl+H/4F2IPg5uujAZVR+grmzSSe14MAYPdnT9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLDnXm6H; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ff4fa918afso29482895ad.1;
        Mon, 05 Aug 2024 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722872941; x=1723477741; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oFO+CKVP+ZX8YgWMyMZP5spz1xTqtwC+2nMhN7tO4+8=;
        b=iLDnXm6H0kWccHy1qBhh2VPEaaht/odosvLPdXEswPv32+t54ne59WfL4Poskzny3/
         1xM0SsA5KqoPY9E3S050LXL537YkM8VcUSKFyQWkpPhzm2QluWIO4EyWeJzikw9nXiJu
         +BCS5/dsqzfmov83gUNifsoVXCxKxN1FI80yFOZGTuPOYaoiRc9Y6hcWSQDZRmo1CP5t
         kmOvuGZGA4XXQXKvEgbRiVj7jEi7GIADfO/93qqUhOxS6hDcxDMNkCcHQgdTVwQIFrp8
         fhbrD03WANTi/hGAGsXZWmHpUCYzMWHme7YsafcgT2HnWnFbRBVCN/Punnu94/q19gqu
         E2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872941; x=1723477741;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFO+CKVP+ZX8YgWMyMZP5spz1xTqtwC+2nMhN7tO4+8=;
        b=N24Edh+++xOSgZl6xluwyzsRWozPL4GEv6L2PlmRvzzSUBlaF4XSgQ/bbKk/rPPwyU
         ufrLwUQZ0ouipKJ9yA6XNL2HarPMQB17ajP0O+pVuH6RM1gR/qJzFNfHGNGfiw7zWWgB
         +zRDCZ1UYq6VFAAbwemcZdGOE03AVx/uFOk5Gu8cB3eWZAUBv53j+/XYA/NDL62mUGlE
         VMo32G1N7WRxgx/vDxSQtmDjvbTc0rtak94PFUcyPeRgFoaXkA0M0ksEmE5ghneeKIle
         oVd5BoM2w/kyN8xCeukjrEG3+dbTncC15NGr7vDUJQ15B9FHFzgcz5gQuLbR3u2jl0h0
         Rrqg==
X-Forwarded-Encrypted: i=1; AJvYcCV03sV52DSEjVKdZSiRf3x2sWMMeHGX9ljtfFDHGQ6JoK5sclaOIZtL4PuXQ2KEblar6dWSK7OBSrhS3jJouM7Y/j9QnZT58j8ajlkc
X-Gm-Message-State: AOJu0Yx8g67+7gTUdi6ORxpFE7ihC5PMHjycOpFN5Yrv9PHXVJIZidkW
	qXrPhjh9wqtzZOJywLSR3X9khrsPyZcwBEfJwLPQxpL8mQzzNA5AzcqSSQ==
X-Google-Smtp-Source: AGHT+IFUAoOQv4oNDH8dPTJXHH3Zd1dU9RwQngBtYbSARcD+2Cq1wpgUNTOasLPOg0N3L133YCmqDQ==
X-Received: by 2002:a17:902:d502:b0:1fb:d335:b0bf with SMTP id d9443c01a7336-1ff57296a09mr129426075ad.25.1722872940983;
        Mon, 05 Aug 2024 08:49:00 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929ad84sm69478215ad.270.2024.08.05.08.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:49:00 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v7 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
Date: Mon, 05 Aug 2024 23:46:26 +0800
Message-Id: <20240805-potin-catalina-dts-v7-0-286bfd2ab93b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANLzsGYC/4XOy2rDQAwF0F8Js+6UseaZrPofpQvNKxEkdvAY0
 xL871WyaWpMu7xC90g30cpIpYnD7ibGMlOjoefgX3YinbA/FkmZswAFRnkw8jpM1MuEE56pR5m
 nJmvGrqCGvY+d4OJ1LJU+H+j7B+cTtWkYvx43ZrhP/+RmkEpGDNl4m3hLvx0vSOfXNFzEnZv1M
 2E3Cc2ERhtt3heXY1oT5n/CMIHoKmiLUHxYE/aZcJuEZSJUBVpZrBb8mnA/RFCwSTgmVAzVdTE
 oF359sSzLNyViZwPAAQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai.pt@gmail.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722872938; l=2314;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=3CsJgkR0mUZo4A/DQ7qYKhVfPLpEdxnVGjuyWySSv24=;
 b=hausdzOF2/7qQgGbyl3yV2SIasHUc/BC1QZewv+iiwnk3n6vIPa0TdfQkFWGU66hh7LGuWPwK
 eHwqG70SMmxD1ytwN016DVSlkDhZ4xDfcGEMEUtTSat5pc3tnOjIHXx
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Linux device tree entry related to Meta(Facebook) Catalina specific
devices connected to BMC(AST2600) SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v7:
- drop 'pinctrl-names' in gpio0 node
- change 'vref' to 'vref-supply' in adc0 & adc1 nodes
- add p1v8_bmc_aux & p2v5_bmc_aux nodes
- change Signed-off tag email as same as sender.
- Link to v6: https://lore.kernel.org/r/20240802-potin-catalina-dts-v6-0-0b8f61b80688@gmail.com

Changes in v6:
- move i2c-mux@70 node from 33-0070 to 30-0070 due to bus change
- fix wrong gpio-line-names in io_expander6
- remove all max31790 nodes
- remove all raa228004 nodes
- remove ipmb-dev node
- remove unused mdio0 node
- Link to v5: https://lore.kernel.org/r/20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com

Changes in v5:
- fix spi1_gpio node name and properties
- remove undefind properties in mac3, i2c7 & i2c11
- Link to v4: https://lore.kernel.org/r/20240725-potin-catalina-dts-v4-0-aa6f235a2e78@gmail.com

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

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 979 +++++++++++++++++++++
 3 files changed, 981 insertions(+)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240724-potin-catalina-dts-fda1ea3297b1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


