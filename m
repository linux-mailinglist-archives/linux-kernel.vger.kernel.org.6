Return-Path: <linux-kernel+bounces-568432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E4DA69563
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7831417734A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4481E231F;
	Wed, 19 Mar 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUc/lwHl"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37F1DF248;
	Wed, 19 Mar 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402993; cv=none; b=nYxAZkVLn+O6RJWAVfGLOXX0EwdS75S3x2yO5hOBGjT+9LtvcQDgopm0GjnR4z9yre5nxSzJ/Iks9IIui21mnds1q2eML53dSBP47p9KztW9C00FBaL0gO39VONJniVBuqpjnLsBvCP9FkF01tx2TGf7/XIGBnD2Bko60IefrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402993; c=relaxed/simple;
	bh=ltDzPnx9DrYQLZ42Mpq+ze7mXFl9npW/CfLcWJZUc+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LC7u3vCWL6TBMhzEHb8fECgtvqjhUKYrYrx5873gri50PsTdrb7DRw1Epk8ZlMstGUHIk37NwlnydTtfLUUiGwia8ySbiPqXvR9lxPhL4RhpDqdYWUNoPCP6IGRsaml+LFzlqCbfD4jXoJzSJHq5sbrS9Trv64XL8ZrQZZNJDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUc/lwHl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fb0f619dso124442685ad.1;
        Wed, 19 Mar 2025 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402991; x=1743007791; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=otdawq32D6/5bERzoT5Rk23HrOvjEoRzM0gTHt/o2Nk=;
        b=bUc/lwHluyU/aCqOIfi1d5tp6FjMc7vfUti+YBzL+8Ol2/RokgGpIIeYzr0mpihcWR
         KjHA26XrV4blVmiDywsdsxEwQyZaExJh2SpSs+k5OIuzv6PpJpsoBZMu4Kpr9TdVMvF/
         Q4/0Mv9x0L1vO+XvMrcVOEEJOwlelLus85s1RKR4WiC2Pm8L/W5gBeVnaWThVTnFmd4v
         N4CHhrRXXWcA8DNABtRAbvw0tqS20WvY5sdhiyDrVrB0CffgwazIIEVzDJQsm7e6onCV
         81ud3NUuYchLS4TbD5xoH7+jDKiwbBNwxfqGx6v5ZUAlZ/V7E0MFv6MlcvlSf08z9nNu
         OvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402991; x=1743007791;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otdawq32D6/5bERzoT5Rk23HrOvjEoRzM0gTHt/o2Nk=;
        b=hjsCVlKxUXKuRLzJqHI1oitC2AGinSJT7OthKJ2jNlQjOW8+W74uESmZkRsuJn+pkP
         X23iUByJNBL7A6ReOvd8WiujUyFe2cki60eEYrCPRN7M9PCkR09S5MqLg2Y5ziPbqTXo
         fkGKlbpBGpeG9AyvunZzo7IzQOQ6KSi7zv27HkyQRVm9QDJjb3vFLgVtaZoRHhqJQkeO
         Sj+Bvp14fUGkkmgLDijF8e1ZxWx7qU/nSir/6B3CFnEgobzE6hmDARNqodXXwuoxFBoa
         ktLxCv2ZXlUlXQJdyokehdwJYrRW+pQcBLdEa0cNds7TpusGpztatl2JwxLuKeOjYkAD
         uTHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV8aHsw2NB5Ovp7Ppdt0JswI+A9vqSXzVtRvnuEvUmsQ+ik+u+2tC+uZiMAq5dcU+0m0EUNGNkRE5m9Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykW2im57cgnFxtGhw34BRyPH/jbNoXd0Fd0GmobT93AwcxnXMc
	UbAFVPXFpunvuxs5rpPayp9RDxBm4MscYYwBLXYNfw9hqweSecqk
X-Gm-Gg: ASbGncsBcPT5nLuAc+d87xhLhbKs4VK/JBybel0ihdVAWVj+YLF3dw1pICoahP7QXhI
	zPwHq4zmZR/aTGsvuiDdZqh0867etL4sVhqxE2tZBEvaT5SlkyV1f8urt+NBR4ltVLmdX75C5Di
	1PSKfn02jAIGT49Crh1EiO0s/v3our+q9J/GiAMTpg43/9gbHgT9E/OCC+y9+e520g70jnNq2kK
	3oZurCMOXuuzaJ0CtFv3cJ/kEFZqAZwUt8ro9kDKPk3TPXdFonv1NkSJU0mzZw58sAkUHDMAHxo
	XspJYlY9mMPxZq9C7LeZbLm+U9pmmo3wNS+5yDW0hz5gphfjmWF7mJ3trMAl3GXc1PFBeORF2Df
	HILBCUqOv1MumSyLr9rEwAA==
X-Google-Smtp-Source: AGHT+IFWe5EGmpUjldgNs4K1HGGbn7yVxSWR9yHkVqi89+su3KAenSmxurHklNjkpkjyUU7So5s1SA==
X-Received: by 2002:a17:90b:4a10:b0:2fe:a336:fe65 with SMTP id 98e67ed59e1d1-301bde5816fmr5014331a91.10.1742402990848;
        Wed, 19 Mar 2025 09:49:50 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:49:50 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v4 0/8] ARM: dts: aspeed: catalina: Update DTS to support
 Catalina PVT hardware
Date: Thu, 20 Mar 2025 00:47:21 +0800
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABn12mcC/43NQQqDMBCF4atI1k3JxGi0q96jdDHRqANWxaTSI
 t69UWiRrlz+w/C9mTk7knXsEs1stBM56rsQ6hSxosGutpzK0EwKmQgQkg+9p44X6LGlDnnpHX8
 OJXrLfy85KCNSVKY0yAI0jLai1zZyu4duyPl+fG+bE6zXLx8f4SfgwI0wGhMZF3maXesHUnsu+
 gdb+UnuSDhGykCClgmArqzG/J+M96Q6RMYrqfIMtFJGVnZPLsvyAZAJFuB6AQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=1684;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=ltDzPnx9DrYQLZ42Mpq+ze7mXFl9npW/CfLcWJZUc+A=;
 b=h9W1GzNDRP1ipPJnnPG4uywIzZY/IGU5ILv0VsAds08ZDU+V1HSp+fdDPVblhY2OxMh1OFhxX
 7AfuI8FFiVuC3b0Lw9OpX+U3yF11FTPUZn8Hj7nxYAz6fZ9Iin/gMVV
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the DTS file for the Catalina platform based on the PVT hardware
changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
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
Potin Lai (8):
      ARM: dts: aspeed: catalina: Add IO Mezz board thermal sensor nodes
      ARM: dts: aspeed: catalina: Add Front IO board remote thermal sensor
      ARM: dts: aspeed: catalina: Add MP5990 power sensor node
      ARM: dts: aspeed: catalina: Add fan controller support
      ARM: dts: aspeed: catalina: Add second source fan controller support
      ARM: dts: aspeed: catalina: Add second source HSC node support
      ARM: dts: aspeed: catalina: Remove INA238 and INA230 nodes
      ARM: dts: aspeed: catalina: Enable multi-master on additional I2C buses

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 172 +++++++++++++++------
 1 file changed, 128 insertions(+), 44 deletions(-)
---
base-commit: becaccc292bfbd12df81148746043c5221e49da8
change-id: 20250102-potin-catalina-dts-update-20250102-914b06a4bdba

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


