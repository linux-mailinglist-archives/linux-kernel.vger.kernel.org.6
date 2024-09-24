Return-Path: <linux-kernel+bounces-337225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACC98473A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC8D284674
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032621AAE15;
	Tue, 24 Sep 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THcbTnr3"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF921A7AEB;
	Tue, 24 Sep 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186663; cv=none; b=OEM22w6KeXQ0tRtc8Het5xVgzJmSpHmVavJtGAPmfkSJwh9+WaK7n2M5qgrqHO/yM33fLu7uirchWCs5GjvxFp3bhjJTXxewSVwIrvG8O+4PQ6lZ3coLHSMyswKt1aeuuWwtd2pEM8jb7UNHpe+DVHc33BmKIKvLoRc/hY7RqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186663; c=relaxed/simple;
	bh=mKsYo4jtQ15nyICCycjXtycZLB7x3pg7+/Gj/R/YY68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R8M9HHZCsSyoSViwLePQYRE+uYJQkVTBg8bU+mH98nREbNJZmzCac4gK0wGGRkS/PPRKFRiGrchBUrRW/vpUH6GkgRlsgGXvoZvI57AO3/OnCJaVnUHm4yu4wQUJmSuyTPgsPO4nBi8hFH7uK+6Kv2FvTFdv2JR4dLBB9F4CDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THcbTnr3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-205909afad3so63395065ad.2;
        Tue, 24 Sep 2024 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727186661; x=1727791461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSNFlzqvdmMLt/lyyVwRlK9XJtljWCBUosXtsRFWcHY=;
        b=THcbTnr3MaoqGK8Pnvxc7Exam+HzB8d3sKOPM5vrm8jHx7qNh+xUDeJTUJrg1CN9o0
         xsZUSpMVNrNkivf+hLwHCKiYltax4O6P1U01wNh7+VXNHIqRq59pJkXgke634mi7RQuB
         aT5AdHcAcyhRJGZ2JoS5VYxuYhBUqZEJr1ieoMsE5NmeOg0x//rag7+lJzYlZ5MBQfak
         dA0fY+5sv5GXisSdrAIn/6ThP2omH+Ek0CcoQw8x1hewkyVebILe6pgt2iKeP9ihJ5Hp
         aRIukDeIQdsTGgO0DYgQVIG6W/TrGxAMsMtpq0CIwN9oOgZ2ONATsxEx2J1cNbD+qB08
         +8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727186661; x=1727791461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSNFlzqvdmMLt/lyyVwRlK9XJtljWCBUosXtsRFWcHY=;
        b=NX5LWFfei/6L3iljZtW8TuVnoFxuJwDApH5F3vKOZ7UoPe7614f4LtriNHjyWS8S1T
         b25ixdw3QwtbbZ6oPbNRliuvuOdNeeDC/2XwWUKxuoFY/oRhm8eXueFMeSJrR99ohSLD
         djT8SjzdBl/RmlCYd31IRvDwdTGTuy2SugIAAO6AkVTN+FC40OgC36eA7JFYhz9I7NaX
         Gwz/q7Sz/Hfa2D/JVBFlOIoqd+fn8Xy893L1ohtAQI5bXFbE1sEOBIOPUGqymCKHeZ70
         9WlKmSlnSzUOPWrfiQ4ltXyY9ICUQShsYWJdfHH3PJ78mC3yu/GiiCy5PzndEIpn90kz
         QSng==
X-Forwarded-Encrypted: i=1; AJvYcCUZvd0Er/QQ996NUWKginuBEClGVffFXCLNFg/IMHji1x9eGOuazKt045WdXaHh0JaF9ZGt5PO/IGCFIU15@vger.kernel.org, AJvYcCWoXZ2nLsMGbt2Jtb3HqpaDx4L7/+gwb95UqEB6LWS6Dk2PBmFJxVlMzsGc8RI89Qad5tSxBE6mztun@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKq0zaRxDayCM4PATyetnFVM58VwY1/lxqbuuos/H594J/wvO
	hyEWCLGwx3IqmGat3B1BsXD4W6vcFIzjeRLADsLT04xG/NE3caEm81kvfw==
X-Google-Smtp-Source: AGHT+IEKMCsX0ABsD3AmmZlodbc9JPGxroM9vSs3FOpEGLY+setfBLhzmzbZ6NHxMEM8yQlTxRiaPA==
X-Received: by 2002:a17:902:b489:b0:207:5d33:a1b8 with SMTP id d9443c01a7336-208d8408255mr191740725ad.38.1727186661244;
        Tue, 24 Sep 2024 07:04:21 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1821f33sm10678895ad.219.2024.09.24.07.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:04:20 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH v1 0/3] Revise Meta (Facebook) Minerva BMC (AST2600)
Date: Tue, 24 Sep 2024 22:02:12 +0800
Message-Id: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revise linux device tree entry related to Meta (Facebook) Minerva specific
devices connected to BMC (AST2600) SoC.

Yang Chen (3):
  ARM: dts: aspeed: minerva: Revise the SGPIO line name
  ARM: dts: aspeed: minerva: change the i2c mux number for FCBs
  ARM: dts: aspeed: minerva: add fru device for other blades

 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 475 +++++++++++++++---
 1 file changed, 405 insertions(+), 70 deletions(-)

-- 
2.34.1


