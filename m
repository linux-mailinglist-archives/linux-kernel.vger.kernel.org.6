Return-Path: <linux-kernel+bounces-224781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E389126D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF679289578
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5EAEAC8;
	Fri, 21 Jun 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6eVmksC"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BDA8C1E;
	Fri, 21 Jun 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977236; cv=none; b=LEts7f/Mb39Ni71Qp/IL/oZ/Y4ZZX6Jv21zmf0m8zrrAqwUasXxc4rZd0PSlIePIiuYFocK/Gsam6YaXUwhYTGg94wBzldDJrbtl4OMKoUeQBR5o6d0tY5vsTk8xVk5SQO2pScOXuwWdE+26lWFFmdA821TthqbzslI552y5/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977236; c=relaxed/simple;
	bh=1pCCmT9VpDArttJzHDtZHFGh1LKBiui5mFNG1hrtDLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u9C3YB+8HoANoamI/1o+TcQtb5LZAwOZ0xGywCVOproCb6956xLP0YvHWf58l+1K0Ub3AxC/laU/14O3v5hVZpR7NKnKR1OB8T/dsey7h2uvMOmcVl8WEIbAKcdtu6RLH2XhqNzQYY0OrNMpX2spc2v1Uj4FAt2SXYOLAPe39dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6eVmksC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so234868a12.1;
        Fri, 21 Jun 2024 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718977233; x=1719582033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HO8YbNgusDOc+w+m1b18tvlpjQ6nHTLOVFIcczCcZXE=;
        b=H6eVmksCroy/2lzSUAEIGnAF/Wt00nQ4cq1ZpBdC1GUUWm4k9wGMI8RUsok5CEr/z3
         VCapYvIrqgv2RCE5fvlfuIwReMn86YFWnDdz3wuPYVX4NLu26zat61kbM//nTwjEOU2W
         SbvtVlHV1aM+4mvHDoytrowSU7rFAxjVjGe67A8UJZYjtXqgo+1QeH1Hj/cP2XO84/Gh
         IkuLfzmuK8hleTDtr3LAHujrpcjjTejN9Q7xQnMzHPTvZ8gnqEAyX21MpVzcD2uswMTG
         ka/Ox4BLILRBfOwdy24hrAEcVvKixuHPEx0l5zY32jB1kCzaNguTI3/jMIGF3pdRfwrG
         TseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977233; x=1719582033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO8YbNgusDOc+w+m1b18tvlpjQ6nHTLOVFIcczCcZXE=;
        b=Kn1OKpB5dwhr6GmBcU2NMigRWC/rhU9x/jATo9/S4hRTKHTxmH6p18g84QDZdPDvHq
         kxbctfxWx44nfS7WSWbURjAIX1shywAG90WyN1YM1MvacSF+cpJB0/XTCWEs/ydKs/DZ
         eTyYILqpYPM+KHEKEHfnfUzS3ov0b2e1OSHZK0MmBZiKvZZl3W4NzDOwm0Xbduo3HYHI
         MD8oWEfkgi64lnEPmeuvsNsW7FMcOI37kXXdU6ih7BkGn/010yxzOmGCiHZ8RBTCgyXF
         hoZGcV1b1uQPNMzcgIV2AWZsdtzD7BP6Eh/F/sbMeh+elkrfoktF0ELGms/0SJGpZM0C
         9bOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWonTHCxgvr+yPxdJ1MKIsFwnxKIhD+cI0zeoZ8MqUjiO6JczbcyZDnmGf8YKmaMi6bmJo7V4kyzdEVzlQvi3hwp7rAp8Zwj/nehAx5
X-Gm-Message-State: AOJu0Yyyy8AqROzIp5qm8orjOYLwOkHurgV6ud6BgkVfc3Um9FEjUZki
	7aAVkH2eMOus3ver3FgX+MTYMThDJKdIFQEkmC3FvFMWS+vHRYp6gg2e
X-Google-Smtp-Source: AGHT+IF80rrq09Pob3DPsGOTdKXgb+35KYXWIJaGBuqcU9+0ap2q4ps0fkqx4Pp0KMSYOl1t91xmdA==
X-Received: by 2002:a50:9359:0:b0:57c:c41c:c0cd with SMTP id 4fb4d7f45d1cf-57d069af610mr5811498a12.4.1718977233052;
        Fri, 21 Jun 2024 06:40:33 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1b6a:5399:9a4f:7217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562cb6sm962059a12.83.2024.06.21.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:40:32 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 0/4] Add LBA3368 board
Date: Fri, 21 Jun 2024 15:40:26 +0200
Message-ID: <20240621134030.243646-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series aims to add support for RK3368 based LBA3368 industrial board
form Neardi. The device tree currently only contains entries for which both
bindings and linux driver exists and is expected to be exended in future.

NB: checkpatch throws me a warning that no venddor-prefix for "usb5e3"
exists - which is true - but "usb5e3,610" has a valid binding.


Alex Bee (4):
  dt-bindings: vendor-prefixes: Add Neardi Technology
  dt-bindings: arm: rockchip: Add Neardi LBA3368
  arm64: dts: rockchip: Add sound-dai-cells for RK3368
  arm64: dts: rockchip: Add Neardi LBA3368 board

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3368-lba3368.dts      | 666 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      |   3 +
 5 files changed, 677 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts

-- 
2.45.2


