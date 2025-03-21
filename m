Return-Path: <linux-kernel+bounces-570817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0727A6B4F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD3D17759E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457D1EDA09;
	Fri, 21 Mar 2025 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9LQAanN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA991E5707;
	Fri, 21 Mar 2025 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542108; cv=none; b=cPWZGQx6O1fv8CFX83JXRTQKHXdekotSRpjbs6Txjtl6wy+LK1khxShpaRLUIm9YQS2Dipl+AZ7Z4jtUJdCXKKrxEpOWrpTh9eN/1CRLT2GISOv1AmPYVqtzan+MF6kHwPiM8q8NQZnwsfx/g8cF/a1O1ehNtCT5XTh0iirm4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542108; c=relaxed/simple;
	bh=Nj94npq6q1wguoTxPUR60r+bZgVts+q6TMPv2OWz25Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uEBAC4et9d1bpzV63CeaCMr34TbrqgkNpxmY6utEzUQ9g+aMe58Eqz0dhrEMaewnLtzQAPxag6t2zrylAKoMz0ZcQ/B4lmq2fpo4QXF0K6E+9Pfja8hDUMWwfkAs0hUel4aa3Zz8NomCclb5awVRN+PfDfxBAF9MN6mAHY2Nwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9LQAanN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22403cbb47fso30817875ad.0;
        Fri, 21 Mar 2025 00:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542106; x=1743146906; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB8kiE+qcLLJcoLITaaDs20vORJvN1XQTZkEg+RWu78=;
        b=f9LQAanNo5hXxXU24D5ua/xjokFB8/yUo6wIdKeNVk7KzA8bl8cc7mIk52hDlEGOXV
         8mbhUYXW2+rsR16s7Z8TUJSrU3k3y9zloVkh3w8O7dyf6ZlTkkvf36hMK5jp0fhVIYQf
         1Y5ztXuiNbXVvZ/+hVo2M6/kfggvAH5MGt14T0AGjxNxeK0wX9OoN7sF96quVSBlFpbG
         tQgSp6CHPqrOkoO/lCbbYQ0T/jmllGYcp64MQx4F+fEZHEYksFkxIdC+3TzNsOU94N5x
         G2OYxVa7zkApw5IKTUr3yXJXNQkXFiPQO5fufYM6BplovVfHkEGGB/HMldvwkd4VRb7i
         kfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542106; x=1743146906;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZB8kiE+qcLLJcoLITaaDs20vORJvN1XQTZkEg+RWu78=;
        b=BBycZLE6HpmWi9FsSk7elEQaWoemJX2kzph99hQ1/xp+cJ6wLtqWAV3XqdWESVQaLJ
         j9eVhXshrH/GFzUIwl4hTCtU2wMqScOEBNLHIDLmmV43MiiNOKmytkU0JvJcoqTMPcNw
         AWu5tiru1EAYFgMaAPtxaVZgSiS6ecw9BD1KmBheuPGFQBFp3b3bWvDGF2VtyhSIN525
         AZBLlDS5qs2OneTch0OWgmANAtecp76LILmMky2VSnRKQ6rMlJxX8qUTrqprnaJPN/P5
         YVSv2ml0lE9DGz8Fpmk6jeHeUQ2EPHKTRLInS31cH1Pw1UMkC5GzYwSNz1oEDti06zeA
         p9cg==
X-Forwarded-Encrypted: i=1; AJvYcCVzXcbLbVBlzhbDbxHCmrbNEcb4xtdtW6GxXo0mmMEOByWM/KwnRx+wuTnNmN8puvatRI2afSrMz11XgsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpeBkj+AiYApoLoiZVNw1zn3B4j+8Z5sbir8C8Upv6zPUDMkK
	htGJyP7MJnfyksIglpQvcodHHU+7Pq9LNtpifmhG6iyvYnCHa9DG
X-Gm-Gg: ASbGncvu+LPvxcj8iaaAwt7SEnDx1NnJyhHsMWS6TQkLWEby6g1GtPQiYNPZ+mHbBdP
	yb5O1D1ekooVY4vzmmUcz579A7K2NPvWHpGOGjf/TUMZh4uSvjjHSBpAHewIx8MGIkE/m8ajwLs
	f4kSnkNX7X6JV0hbOCTQvRVDYt5c0z61144EVr8OuGUkVc2f2it7dfvRnn70rRyt0RIqYhGIYfR
	YtZSKS05HU7qS63LEXcNOATWAofZwMV9uWBY6XFvmeljDpeORDV63eB9JnEEml9ibrq9teBoLdK
	yS50WgxwAcZNXlp0dwU3YIgIWBx9/3+o5eMFBhE/vg0TFtvWVaT7bdvSaXR6q9uuw2wl1pfTZP6
	Bq0OE70oNpgtGxsoGtsiKBQ==
X-Google-Smtp-Source: AGHT+IHlSEk8vePnKOkamFFIpfHyaA1m+UQS95Ubg2HRN1Dlu1q58w71hmeoIXSixkljxSV8yVTYSg==
X-Received: by 2002:a17:902:e884:b0:21f:8453:7484 with SMTP id d9443c01a7336-22780dae109mr29510195ad.30.1742542106449;
        Fri, 21 Mar 2025 00:28:26 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:26 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v6 00/10] ARM: dts: aspeed: catalina: Update DTS to support
 Catalina PVT hardware
Date: Fri, 21 Mar 2025 15:26:01 +0800
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIkU3WcC/5XNTWrDMBCG4asEraui0a/VVe9RuhjJ40SQ2MZST
 Uvw3SsH2hqv3OU7DM93Z5mmRJm9nO5sojnlNPQ17NOJxQv2Z+Kprc2kkEaAkHwcSup5xILX1CN
 vS+YfY4uF+O+LBx2ERR3agKxC40Rd+nyMvL3XvqRchunrsTnDev3h1RF+Bg48iODQSBW9bV7PN
 0zX5zjc2MrPckPCMVJWEpw0AK4jh35Pqi2pD5FqJbVvwGkdZEd7Uv+RSopDpOaCu6h0aEB5AXp
 Pmv+TppIEFgJZ0yh0W3JZlm+PDpfaIAIAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=2266;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=Nj94npq6q1wguoTxPUR60r+bZgVts+q6TMPv2OWz25Q=;
 b=O/AOrrLZgeC/5rmjqrKCnMKUbnnQpINPRqSIVmrM7UpVxmhshmQJ+PP052IxOx5ip+tGzT9l9
 JvIg8Q2vxwbAnO6gEvkWg8UYp1hBTjnq8UV9sZBTkW7igHFNpyMmbOw
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the DTS file for the Catalina platform based on the PVT hardware
changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v6:
- Rename the fan controller nodes with appropriate name
- Link to v5: https://lore.kernel.org/r/20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com

Changes in v5:
- Revise CBC FRU eeprom i2c bus and address
- Add MCTP support for backend NIC monitoring via PLDM over MCTP
- Link to v4: https://lore.kernel.org/r/20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com

Changes in v4:
- Split a single commit into multiple smaller commits to reduce complexity.
- Add `multi-master` into i2c12 & i2c13  
- Link to v3: https://lore.kernel.org/r/20250114-potin-catalina-dts-update-20250102-v3-1-14981744b2fe@gmail.com

Changes in v3:
- Remove delta_brick nodes due to compatible string not supported
- Link to v2: https://lore.kernel.org/r/20250113-potin-catalina-dts-update-20250102-v2-1-1725117fe7a9@gmail.com

Changes in v2:
- Add delta_brick nodes to support PDB brick board
- Link to v1: https://lore.kernel.org/r/20250103-potin-catalina-dts-update-20250102-v1-1-b0b7a523c968@gmail.com

---
Potin Lai (10):
      ARM: dts: aspeed: catalina: Add IO Mezz board thermal sensor nodes
      ARM: dts: aspeed: catalina: Add Front IO board remote thermal sensor
      ARM: dts: aspeed: catalina: Add MP5990 power sensor node
      ARM: dts: aspeed: catalina: Add fan controller support
      ARM: dts: aspeed: catalina: Add second source fan controller support
      ARM: dts: aspeed: catalina: Add second source HSC node support
      ARM: dts: aspeed: catalina: Remove INA238 and INA230 nodes
      ARM: dts: aspeed: catalina: Enable multi-master on additional I2C buses
      ARM: dts: aspeed: catalina: Update CBC FRU EEPROM I2C bus and address
      ARM: dts: aspeed: catalina: Enable MCTP support for NIC management

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 197 +++++++++++++++------
 1 file changed, 144 insertions(+), 53 deletions(-)
---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250102-potin-catalina-dts-update-20250102-914b06a4bdba

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


