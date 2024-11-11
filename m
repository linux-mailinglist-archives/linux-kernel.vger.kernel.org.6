Return-Path: <linux-kernel+bounces-404339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEC49C4294
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CF2284F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23C91A3A80;
	Mon, 11 Nov 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbnriPVJ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD61A256B;
	Mon, 11 Nov 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342331; cv=none; b=Lrzc+18JFgVBdcMwu4vjouxI8DBz4qYJeiyfyZQh93zwZCoD0QeBJzoiitWXh0KsSisXFwHfV2I1g0OFShI3VfBjKVLZQheDBh50sWdsi+9yabqX05rqnR/k2K7+5bO+LRHIw7qR0ZhgFXI4cvBk1L0BsuWfQmrWWVyrQYHZ+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342331; c=relaxed/simple;
	bh=CbXbbC4z+ofdaBIwJk70SKQ1fdSjyYqQJZfqnVZbHW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxL2Wa/mHV9eoJYozEnL/Ibyz0rX38Bok20hYu2zFajJ70VnsjY7QQcQ+kNNHeiAxYOpO+Q/KbSfzT4WBfDo07zzyd0Q0ndf4feD4O2XmZBKKf0bUMB8yfI34S55Hbh6yzmYlFkPlwO+DWL88W3xQBayRu6egyGaeChxkVuaQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbnriPVJ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e13375d3so5443355e87.3;
        Mon, 11 Nov 2024 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731342327; x=1731947127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u7uGQSXY7j8g596c+PHmEhLMGV2dxdcfbU5o0lzJ1EA=;
        b=bbnriPVJzRhs0aJy2zZKrAKjtv/0fJOfPbIy1EXKcYbVYsEh/X4xrh73Un1YC+2jSc
         MTZYCSNSwgsCOeMOsx71ObzJe5eWJGcSosk6jsu4+5w0R2wFY/rKWrLc5va5K2cMXUI+
         /SbBQD7wvaI4zkVjYID8xlNuBjQn3hdAXa7+nr0CAADAA8VCcntS6x8kIluhiP8VOrqo
         ontruW0eNxcbOjhNwqzR0rlrtryjfIhh3ZrpnfYnH5UAj+Kipib33cx9jXCwbNGhGs1c
         8St8QcwXTXRV+ejDu52MKmi84zT2B6H9hBcgLHNnCnHxxwpBjCdbr4blwsdEX65btPKx
         R1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731342327; x=1731947127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7uGQSXY7j8g596c+PHmEhLMGV2dxdcfbU5o0lzJ1EA=;
        b=jxYUsM59z0EGqpcchnlwAp1jUWFbWLrl+drt5OXFLOotaSOG9zZSoSIqK4aLvu8kON
         7toQMbzRgTP2W9MyDGwzT3p3ZgGPynB487AFWCdFkCyJoIP3nDhygZ2h+nWA2t5sCFGN
         P5X2bPsRyXA8ZwLM4LzDDXNYYxVQK58ZB8AG11F54GBnEvC8lqFOJemaOWV5f5y2LYKP
         oBn0pyAL7fW7/gsTGCV1VMVeDeYZbunoyN3DOfWhhds/0BR9eiPG1knhzvwUa0xNbHJo
         OHZ5xIlwJvRrpjVGWN2orWD0Yh6C6ype/qcrHNplxarlHCvvFXDQ45yvS+SvkunwTi8T
         bXRg==
X-Forwarded-Encrypted: i=1; AJvYcCUCme0R2g724zCfxpXc2m3zRcOjfIVCnAcxtnl+hDd5gfetr8f1rV6Lx3ES0sK/t550BG8bx4sigUWn@vger.kernel.org, AJvYcCUI4rsm1SlQUnrjQfAowXlpvdGdmXoft6zlFBHRh8IdCVLuf1j78Oi1u6dV6qJq1ADt6vEfURUMB8YvBJIOY/OSSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTkDUegkx67pIQ6KEjV3WtUR03Xy6prUiqG6kk/mPWWifq2mBQ
	pDdCFRphItOKEap3+nWWcq4TgVCA/wMpI5f4U5UxSh6tkqAcO1AQIbLAOR5Q
X-Google-Smtp-Source: AGHT+IEwJZXunlyKUejm4iWMJ0VGAjHoH3Rb8MSXFF/rOZ2Yc5x8WVvvL3bT+8Zu01TGRZ1b6kh3yw==
X-Received: by 2002:a05:6512:159e:b0:533:4689:973c with SMTP id 2adb3069b0e04-53d862324c4mr5685506e87.23.1731342326593;
        Mon, 11 Nov 2024 08:25:26 -0800 (PST)
Received: from localhost.localdomain (c90-142-33-119.bredband.tele2.se. [90.142.33.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826786acsm1622926e87.30.2024.11.11.08.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:25:25 -0800 (PST)
From: codekipper@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	andre.przywara@arm.com,
	wens@csie.org,
	macromorgan@hotmail.com,
	jszhang@kernel.org,
	uwu@icenowy.me,
	ryan@testtoast.com,
	dsimic@manjaro.org,
	mripard@kernel.org,
	Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH 0/2] arm64: dts: allwinner: Add X96Q Pro support
Date: Mon, 11 Nov 2024 17:25:04 +0100
Message-ID: <20241111162524.46812-1-codekipper@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcus Cooper <codekipper@gmail.com>

Hi All,
The X96Q-Pro is an STB based on the Allwinner H313 SoC with a SD
slot, 2 USB-2 ports, a 10/100M ethernet port using the SoC's
integrated PHY, Wifi via an sdio wifi chip, HDMI, an IR receiver,
a blue LED display, an audio video connector and an digital S/PDIF
connector.
Further information can be found on the sunxi wiki
https://linux-sunxi.org/X96QPro and the vendors site
https://x96mini.com/products/android-10-x96q-pro-smart-tv-box

Thanks in advance for the reviews,
CK

Marcus Cooper (2):
  dt-bindings: arm: sunxi: Add the X96Q Pro board name
  arm64: dts: allwinner: Add initial support for the X96Q-Pro STB

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h313-x96q-pro.dts    | 176 ++++++++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h313-x96q-pro.dts

-- 
2.47.0


