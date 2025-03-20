Return-Path: <linux-kernel+bounces-569929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4339A6A9C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CF44833D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C761E7C09;
	Thu, 20 Mar 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLR7EPh0"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4501175D53;
	Thu, 20 Mar 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484271; cv=none; b=MaZ+td2wy96ESGBBz2Oo/UP2EA2LA8a2ei+HyoxuaQGx8AlDdJhmBOQuYqFSN69f8vXA/R6k4fbhhfGPXxjXwUITnrBMgOD2f19kKyj6XZswiTg4M2BXeIoaWpy3BqLxfL6OYM27ZPMHRTmR2wQKblBsNpxq/o6rVP59KUJ35xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484271; c=relaxed/simple;
	bh=cJ4PKBqJ1ZUnV8+yUZvNXJkgGfWoCnqYjpX/+o7T94w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kBVN+kbIYHlKUBSfXXv8gGEIKYDpA65doMmVN+LhR5v/TVVNQ5IQXs4Aqm6VR3hax9p/p6wlEEoexaYotP+3sM4mq9iU7QU7U8edXFw/mmG37b5z0H13SsBHZaznKeT/KdzZ7lboDTK92awgSrO+IZ+z61dP67LlZUdedqFWlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLR7EPh0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2254e0b4b79so26533985ad.2;
        Thu, 20 Mar 2025 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484269; x=1743089069; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgBZ5CUSGzZQMXrNQ7iMZPeg3VKPPTQI8tLphlbuft8=;
        b=DLR7EPh0l81F1Va9tJn9Mtm+HQv9USOMJnSzZ+TwwTLzGXWJDoPGfy0V+vozTUlBu1
         CV2kkTkdoDn+OQMIFBe2K0OuVZ5XatyYiKPqnS//pGgje7/5RhXlSpT1lDhGeGnTqJSm
         y0cfAfHFJxYIHlBp1dizrrABR1ZZws7EOP3lIZTJjqLx8UhiC44AXPZ4kfD0D69pTuVm
         g/hZmqHB0+QIg3nFnACz5dflwU4fFwMtH5ejbqvCGV+2BiE2iap5SWNr71M4AIEHd7EY
         DDHuVCE0MosPDZJpVyNwGpurlnZvpPlz2qMZ68pgpmaK4shM7a3f4da0mXIaZ81OWuaS
         Vx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484269; x=1743089069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgBZ5CUSGzZQMXrNQ7iMZPeg3VKPPTQI8tLphlbuft8=;
        b=Kgn5HnL8pshTiWzveH6SfkjRYE1+eIP8917/WIX1goSub9sA8hkvGpyCikCZr7T5Ri
         LXuClVg4kUO8imc5h99k2T3/PgxWtbCwGQk0tpcxtc7CXtf7H+7+XobwHrMZj2L44Xoz
         cFdgElZaQincauCG0k5S09XIsNnw0Tl70CzLfuqXh6TyyNxulCXZpsuUI42iu6Gq6xgr
         C+mAlslxmGXrdsEn7BwttqzJxffB06QXspl530vG9PaDeFOL1GMoPNO5XYvjm5ucodTj
         fAikKqpaLlAER0j0MANqNnWgHlOGAKwfA4g2aTHmbT8xDZoXVq1mq3y7xiCBo8Fn0W4W
         5kNw==
X-Forwarded-Encrypted: i=1; AJvYcCUjdGzBv+46xzQlTWz/C5vWggnErjZqzAtb3k9XToeN3EEDvxJvCWqriV4XgKIXtlaS+CwX1dxfVxGxncA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiC5p036qGDqDwsFZV5okfFPYolFv/2IlmHIMn7GQ6nq5IFp8J
	zeCqISRu8fJwOFgfZFO7W+HslSAa8yF1q3WlwzpAup4NMIcoClYXBj/dww==
X-Gm-Gg: ASbGncsP6+oLzXM6WiKdqiBRU6aFDwk3QhngNo+oLxUqtHDl89Iqpp1rDDaeYUjyZVv
	GsJ09olS9dVSq4C8s6+zW+3Vb2qIYG/CFWd9qVCW2i3ny2DHDTPAZesg0LL3lKe6rvXuUmitsD3
	BPFYSH8rzLCimWU0XLnbf7PMJXWFdRqBiUUejdUWQs5u/3Rxwzn/NKfdAFiHsUyGZk5W/YvODrS
	C42S1DE4GqshgZtax/ZioDMk9/IusdzBRdt0R33SdV9pbV3j0WH+ao+6uTCK06VViJ5q1I/ZOFQ
	Yqy3BRmPRRdA1ExBfMP1HWcKwmItypxFU65hBOBvRH7rrsyVQaHN+dEONyL5NEvFEgGMNen1Wot
	oHbgX9zpy2llxcb5M9upkYQ==
X-Google-Smtp-Source: AGHT+IE8wgx82LSpjOoMcp7xMjse6vZ9j5z6ddnJQvCI/Fs2gOi8QJmpGG9UFax94XWc9AkTdIPv9w==
X-Received: by 2002:a17:903:2346:b0:223:5ace:eccf with SMTP id d9443c01a7336-2265ee0aedbmr64395195ad.25.1742484268680;
        Thu, 20 Mar 2025 08:24:28 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:28 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v5 00/10] ARM: dts: aspeed: catalina: Update DTS to support
 Catalina PVT hardware
Date: Thu, 20 Mar 2025 23:21:50 +0800
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI4y3GcC/43NQW7CMBCF4asgrzvIY09wzKr3qFiMHQcsQRLFb
 lSEcvc6SKURqyz/0eh7D5HCGEMSx91DjGGKKfZdiepjJ/yFu3OA2JQWSqpKolQw9Dl24DnzNXY
 MTU7wPTScA7xeLJKTBybXOBYFGsbQxp/nyNep9CWm3I/35+aEy/WP11v4CQHBSWe4UtrbQ/15v
 nG87n1/Ews/qRWJ20hVSDSqQjRtMGzfSb0maROpF5JsjYbIqTa8k/RPaiU3kQQSjNfkatRWIq3
 JeZ5/AdkRxPXNAQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=2078;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=cJ4PKBqJ1ZUnV8+yUZvNXJkgGfWoCnqYjpX/+o7T94w=;
 b=S29qvnFmgZIP8YDEgxdV9L8SWhKqk1HlSw3tWuB6SnfHRj8puN3OAuw4BqZ/y3CK9surBXICF
 qdFlkjwYr7QCHpzI9QI0C9x31DQb1Oc5lQS4+R35VLGiGuL+5jJF3Ar
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the DTS file for the Catalina platform based on the PVT hardware
changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
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


