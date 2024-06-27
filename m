Return-Path: <linux-kernel+bounces-231876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0813919FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C911F27EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E302482F6;
	Thu, 27 Jun 2024 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj/zuMFG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046947A5C;
	Thu, 27 Jun 2024 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471619; cv=none; b=q6Y+0L7l3QLhWBBPLudzam6IHTAWYTKFAhzDZ3wdDHYWNuCqFw+SQ418244a0Hyx0i95oNDhCoswZjo3vr9h4UNU4Y9fDD8eLUZA/hVJUFXiiYq9pYIZUE1UhtEKflmhMwBKYdJ2ZUuHsWhRh+LomfaXx/IH+xQWpY6y5NZZMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471619; c=relaxed/simple;
	bh=SRtWodmEQg+e4QHiATThpTlP8k39/EHMs7p61nMCxhE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=pUT/me9rqwut9R5HOcCtCXr2FIICWNfTeNSJ9SmfKzZMKvBEqHMrek/V3E7mObdOQ6gxexS/48XBqI10wQtWeF2qB2dk9BouOphgCSGFCOC9v9pJqnjsu1rBq5uZ5r/H940YU8QTwsr41zrJEgLf6jMQEK5djj1MSIqlogDie1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj/zuMFG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fa2ea1c443so37383145ad.0;
        Thu, 27 Jun 2024 00:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471618; x=1720076418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0OhsQN5t5Oh03T4naXnIdsse8TZX5DxNTBRUz9bDzw=;
        b=dj/zuMFGCK4XsncZepPp+ZJFHfviXMWrAb+FjELUZ6MjwHjuiZnCySm7F6lTiy5WD+
         Mx9DsaP4B2RTHe7egaL/qJIYa/S6SqZK7YkO3yVVOY1vqRG1jhEcKsA+NuPlpI4YbbsB
         c9K7ixH9xO6jMWcgf0ZW9gRfejHTPSllF8SXhYcNLSnbgSl14IN5p8OHBlNBT7tpLw7j
         q6qTmZX3YLWORDZeTkr0ZNaKrJgOYdoW+ATHv57K4726yrnhIkVcAkDWjpj5AI+YUL4w
         7GCTQjp8qlaB3vKuNKSOdUPcSAV9DodeM2yfo3U44GTS2iEQ0/8BGvHMIkI/FX9U0suP
         OjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471618; x=1720076418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0OhsQN5t5Oh03T4naXnIdsse8TZX5DxNTBRUz9bDzw=;
        b=IWDVAZ/kYDkHuT2spg6gc2b0/nEweqCz1drIGK4sAcDoRssAx+w6PtDW1DLXazkubB
         0sbpNlM9Ky4Ky20wStZTZibIsxqXSKvKS9UMBCz6OxCD5r2ZY/To5BUmqovw8iFc9bjk
         Gxayx35GnnNDjqJEOzCQ9AVt9SGPvEWEAZ6T+vl/GbPtvhHFvhw7YE5inGC08o+V+LWI
         PHHiu6sfgWO57/EglFm+WS6ZG21OHai+f4Bh4W7qUSLNuyHGGxzPxODtbt0AokoxgFm4
         uMRf/nHNlSOmXs6d2uG/yYREoq9hR0mISaLib+lm+8N50LOvOefHOJV/EWj7FYb1t+O/
         Yz8A==
X-Forwarded-Encrypted: i=1; AJvYcCXO8s+pr8xKJm39s1rTKTne5FAg6wPmm5sm2AHUrUg4cNeb7V2IxUcubMU7AKTgHMiwUYgmVGUUcj2bXj/zJaS0AJYEY4j6euetDYwxr6GdEmFV+42BunjVOIa0F59z1HA+F+TBkF+W8A==
X-Gm-Message-State: AOJu0Yw1L4qp9I4AsMJtrsYk4FvifE6zrKaUfkAUV1tvhQvXOmzqrafX
	FAnEAt95RZNC4WB2zbDfu+9NW2RFoL98JkCvnIcKMatXZ6blENBT
X-Google-Smtp-Source: AGHT+IE0ZWH2brv5TqLkV8Ycp8Au/v69jktjH20ef/ZyIwPB3DwXodf/6cTxKkv5xd2cJyzExt//6w==
X-Received: by 2002:a17:902:c401:b0:1f9:9a24:dc29 with SMTP id d9443c01a7336-1fa23be2439mr156075125ad.24.1719471617596;
        Thu, 27 Jun 2024 00:00:17 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:17 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	amithash@meta.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Thu, 27 Jun 2024 15:00:02 +0800
Message-Id: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on: https://lore.kernel.org/all/CAPSyxFRj0twCJG6Lr5UZpznrUHyd_L0Reo=kZSFwCw3FNQ+x+A@mail.gmail.com/

Change log:

v1 -> v2
  - Patch 0007  - add fru device
  - Patch 0008  - add temperature device
  - Patch 0009  - enable mctp controller
  - Patch 00010 - fixed dtb_check warning

v1
  - Patch 0001 - revise hsc chip
  - Patch 0002 - add VR device
  - Patch 0003 - add sgpio name
  - Patch 0004 - add ina238
  - Patch 0005 - add power monitor xdp710
  - Patch 0006 - remove multi-host property
  - Patch 0007 - remove pca9546

Peter Yin (10):
  ARM: dts: aspeed: Harma: revise hsc chip
  ARM: dts: aspeed: Harma: add VR device
  ARM: dts: aspeed: Harma: add sgpio name
  ARM: dts: aspeed: Harma: add ina238
  ARM: dts: aspeed: Harma: add power monitor xdp710
  ARM: dts: aspeed: Harma: remove multi-host property
  ARM: dts: aspeed: Harma: add fru device
  ARM: dts: aspeed: Harma: add temperature device
  ARM: dts: aspeed: Harma: enable mctp controller
  ARM: dts: aspeed: Harma: fixed dtb_check warning

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 146 ++++++++++++++++--
 1 file changed, 132 insertions(+), 14 deletions(-)

-- 
2.25.1


