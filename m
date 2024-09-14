Return-Path: <linux-kernel+bounces-329368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE8979074
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D541C21A39
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5691CF2B0;
	Sat, 14 Sep 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaHvuxG1"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07026154BE0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313306; cv=none; b=Sa1llhrjY7qaQvFzeEcCSqgl+Axl8NHjHr7zFuBl6yT1nQ26Z+BgFOjpFFdAiRrV/mnreIbFNU+QrwVgettVpo/9n7V4/f0GPYJaYlfkfMQ1NKY78h85s38Sp/Y0gHa/Y5uSKVNb/9fX6jmxCfB22muziiuduAWf1egGRl10Df8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313306; c=relaxed/simple;
	bh=DVthTNXBidsvfHX1H+YgQLGwM1v1LRPnDciPq23nnLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWnwWajD+SGVLnlOYAhKNlFoATRomYZlclWr8A4F1ulfnytRzGN9syCSLnVhikzNAeKsg8GmqqE0NCo1W5tcSputIqA3OIW6cPYFMC4CiJjUEtkJSoRRvHJcqkoy28STf231ghpc+28odK6h5391KiCMpzipHh77EJ6RMm2loBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaHvuxG1; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82aef2c1e5fso63628239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726313304; x=1726918104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PAVjeaAIlz54nRRU+R00d7cGt2iVae2/gffgn/qC9ZU=;
        b=ZaHvuxG1OqrwbKEW3hF3tlj28WCL7VO3IpVC4ugjjQygLcS4AdAWwjeRqc2hqj2/GQ
         wzVc/UCq6FGpunSIGWQ6pXbTiHJBKAXS3CLN1QsuP+J6XD/xUpDtznfGHk0T2bzOJ2N2
         rRDnn6+/Sn1MCPOEHfZHPceAFlL3a7tugiQ+plCS2ZB7UjIe+7IYXahSsNVE1NHcu3x6
         bVAoZb/ersm+gPXNWrPu0HsghGTu2zXrUIPsYZS46dRYb2LBDtoQ7p71PKefY3xwTmBt
         COjYZq+wz/j6F0ACbbOAfuJQNWmChYFEPifb9HQNNgaaZ5iz3PUf0C7XrLkf9+ubWhFF
         1OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726313304; x=1726918104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAVjeaAIlz54nRRU+R00d7cGt2iVae2/gffgn/qC9ZU=;
        b=BbCW3ehjhuA2gJI02PpgPjpq/HIfKYUaC+yXNmeAiO+wroJH1SlENlOMsTZX9M5ViY
         CccRhRDwVl+GeXHoYgzLwMJ3N0ojmJ2SO+rORAuSx/jzgvOboGYlm2xOkdS8CqRP7p+Z
         BNXQGVm9mND9tFpiswO0u7oj0gydkcKsoOUi8ru3LmPZTu8A/9nwasx52KEmlXUw9kgz
         QUEyVtzYAXUX3vLsr5mG81QdQboixIQaN8OEe4jB9SfidjB4hv5Pcqw/YA0IBwNg5MxP
         dWoGlqJwwyvVAVffVeRmVqXtFDi5Tcyt/NdlpSx7il5XEqDpxsgYAWPhhlwoYuNWh+pe
         /4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrjOVLZvsJTGjKSCFhlZt7oWoagPnWT+ylAXob/hBsTRya5ycEwQmDxk71gaqT4jEmYS5elzdAPiGtIO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcFseNZb41r0i51/uslngw4gGrBJYF7Br1+AKxzXpauuvK3Qf4
	oZb29iSHM6hhVNMfuCgo617yEoFLJ4cTFciWBU1nqaqxR6U68UvV
X-Google-Smtp-Source: AGHT+IGorVJHU4xMZQfYjHd7AVJc43hrhdZ2GAS9mpcJ7RW+2UJfZzUdqy5mPL2kG2NZqWjMjN8aCQ==
X-Received: by 2002:a92:c567:0:b0:39d:25d8:43a9 with SMTP id e9e14a558f8ab-3a08b65fec5mr55199625ab.0.1726313303906;
        Sat, 14 Sep 2024 04:28:23 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed35572sm350307173.131.2024.09.14.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 04:28:23 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com,
	linux-imx@nxp.com,
	festevam@gmail.com,
	frieder.schrempf@kontron.de,
	aford@beaconembedded.com,
	Sandor.yu@nxp.com,
	neil.armstrong@linaro.org,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 0/5] phy: freescale: fsl-samsung-hdmi: Expand phy clock options
Date: Sat, 14 Sep 2024 06:27:44 -0500
Message-ID: <20240914112816.520224-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there is a look-up-table to describe all the clock options the HDMI PHY
can use.  Some of these entries in the LUT are using a fractional divider which does
not have a well documented algorithm for determinging values, but the the integer
divider can use an algorithm to calculate the integer divder values dynamically
beyond those listed in the LUT and also duplicates some of the entries.

The first two patches do not do anything functionally other than simplify
some of the register accesses and de-duplicates some of the register look-ups.

The third patch adds support for the integer divider and uses it whenever the
clock request is an exact match.  Otherwise, it will use the LUT as before.
The rouding is still based on the LUT if the integer clock isn't an exact match.

The forth patch updates thes set_rate and round_rate functions to use either
the fractional clock LUT or the the integer divder mechanism to determine
which ever clock rate might be closest match.

The last patch removes the integer divider entries from the LUT since by then
it'll be comparing both the integer divider calculator and the closest value
in the LUT.

In my testing with a AOC 4K monitor, I was able to add 4 entries in my modetest
table.  I do not have an HDMI analyzer, so I just used my monitor to determine
if this series worked.

Adam Ford (5):
  phy: freescale: fsl-samsung-hdmi: Replace register defines with macro
  phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
  phy: freescale: fsl-samsung-hdmi: Support dynamic integer
  phy: freescale: fsl-samsung-hdmi: Use closest divider
  phy: freescale: fsl-samsung-hdmi: Remove unnecessary LUT entries

 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 604 ++++++++++---------
 1 file changed, 325 insertions(+), 279 deletions(-)

-- 
2.43.0


