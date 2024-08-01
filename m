Return-Path: <linux-kernel+bounces-271550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE2944FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CEF289648
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80991B3F0E;
	Thu,  1 Aug 2024 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVmqklSj"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B41B32A1;
	Thu,  1 Aug 2024 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528222; cv=none; b=lvqD20G2etq93i14ixIFs+ULSbE9HmdOMHLXT1CXeTGbAmLkazCfeE4nZ062L1aFR2g3LcDDFkN38HdW1f1UeLnoG6YC6x81ivhuTRtwSxQyn2Ke3K+8XSlAxRP6IYkNnzosSBDJOBEIJh78GmdNmV31hWx0WsrB7j4yMH6jxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528222; c=relaxed/simple;
	bh=bMbK+hf4V3sZvepCrjo7Ca3mwfDxkI3s3sXfVeCM6YY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Oq73VIaq5bOXl4LVW4S5cenm1hvFo3KDUWHwl3NlIXzAfWNTGHswa6xaL7cPksPPuyIgoSvnyLNCE17NOSAYsyZkjhIjcF57a+pGSA3ZBitAQ4wPiK6Ea2lxHYmr6Nl2ZR8G1KzooeNv93ZA+H2X5G+Yobive7RMwPnYSzTCYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVmqklSj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so1857575a12.0;
        Thu, 01 Aug 2024 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528220; x=1723133020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0iSQx0LSYPKW7iNUhjHvQF3N3bFEk4OBEBVOYBRn8CE=;
        b=XVmqklSjwZ+7CNFYk2/Iw4J8hvBhqr7DrUG1EonN/qUt1jnNh9PgAD+Gr90EH5UtV7
         d5o4PBviHBvOsSIlHlW+No1iJm5Ix0dr3+VuUnXzVyQHpgz7PwLB+MLpFBtRFhEawkOZ
         klhg4JAjek1WRaQQwPZZzBQxdvtzD62EBrOLHEgoL+ABTTbtkyeYPHh036fALhVqN5hU
         fFakzSn5vNUqqK6KDdA/TcudVJwz16BUKgPMhJhsd+0nqUSv3Ny/QpVLZ3Y3E5JW7qS4
         OidmZKjForW4IT+eE60QLiQh/pHqmnwxqNz12v54WqzR0XK9v+pr10FWOT3E4tuXM58m
         IFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528220; x=1723133020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iSQx0LSYPKW7iNUhjHvQF3N3bFEk4OBEBVOYBRn8CE=;
        b=QxNvhVwm7JoVm7zeW1FTwVUfXSFr0aG8iR28SpzHWAy47M1h9sm5qMMHOznGAtC2sQ
         hHDjHG07ywgZW7BOPw5/djvnt8Df4GnhTMBKRYldGgc/F4J3bhfWWoYC3Ytsc1XuEO9t
         K4aN0cXGRabmMzeKC2e776hVH7E3WDPVxpIpgXg4k35Y937WW7ynO9iPiWtvUFobeZyL
         GFkbqkeee7eHh8nKYa3Hnmx4Blgw0kW4kDtODfnCtCs+/O8BO9muyli42ZI6PUcofYkE
         HZeD1l/nJMaiPEZyW6xDmYbLXL8+uiqZHUMrvSb6+nGtt5lx1OEGbJutkn2nsFg5FTjU
         QKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNVS4ii1SDfDqMQtDry9+sowQDqA3pUBlZHxix0V/s7lfYIlmICRv7VGIiyQogSjzXzfE/Rqj6Lz4KRszXZ5Vm3xp0fqgEoNW6V47xJtSkPbXbD85EWZdXRYjNDAZ63dhHu7JFIKYT/Q==
X-Gm-Message-State: AOJu0Yzx/jKj6P7odSW/eXY2Koe1l8uikqrB3pYiBaItxBOB6zjyat9C
	N8tK3bm3ONA+/WGyt8FIbgUGgZcPwT6vRJdx28LAg7LrYuyHvjfB
X-Google-Smtp-Source: AGHT+IG2Zy3wE3OxHJ4u0hL4iPjkRZIx0Jv+V/YUEvEBrtQkeXj/vL6XWFNEWkD/3SCKi/rDwudx9A==
X-Received: by 2002:a17:90a:62c1:b0:2c2:4109:9466 with SMTP id 98e67ed59e1d1-2cff0934873mr2727019a91.8.1722528219906;
        Thu, 01 Aug 2024 09:03:39 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:03:39 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Fri,  2 Aug 2024 00:01:24 +0800
Message-Id: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
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
v2 -> v3
  - fixed dtb_check warning base on https://lore.kernel.org/all/20240801153429.1277378-1-peteryin.openbmc@gmail.com/
  - Patch 0011 - remove pca9546 from i2c9

v1 -> v2
  - Patch 0007  - add fru device
  - Patch 0008  - add temperature device
  - Patch 0009  - enable mctp controller
  - Patch 0010 - fixed dtb_check warning

v1
  - Patch 0001 - revise hsc chip
  - Patch 0002 - add VR device
  - Patch 0003 - add sgpio name
  - Patch 0004 - add ina238
  - Patch 0005 - add power monitor xdp710
  - Patch 0006 - remove multi-host property
  - Patch 0007 - remove pca9546

Peter Yin (11):
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
  ARM: dts: aspeed: Harma: remove pca9546

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 177 +++++++++++++-----
 1 file changed, 132 insertions(+), 45 deletions(-)

-- 
2.25.1


