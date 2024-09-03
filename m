Return-Path: <linux-kernel+bounces-312016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A709690F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DAA28364F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9C13D51C;
	Tue,  3 Sep 2024 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxPxVE3/"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F83209
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327087; cv=none; b=HwybPdsnHL45ceJrq9G5x+WONEAcxSvP1/8TX+S3TQHhIyN5ZEgcJ6b7C1qM8W59NUAdvZfUE/zMexpW1lTkudcGDn2bZgOaMtdB+ic+CRbX+q3m9CSYtUbN1URZM//wkzJRbrr1xvaRfHxhVkrj5orWMif6fv0QLsesVk0636U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327087; c=relaxed/simple;
	bh=6N9IMqONhc8ovVa/I+bRuEjxo0eqJD/jmXxi89rGuF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJH0A8tpAXmr9PQIXiPKSRrFWQX26PZApMoJjDGGCw/OhIXFG/m0eUO0Vv3O/ruSxYAck4PD/m//eAg57KJCj82+FgV8MkWMqnxfmKml/HDwZL6nHlGpvtXtmhmbTC5222LKRkJ/DYbRcXiDuWXeCgRA+6olnKwblKBoqPlN9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxPxVE3/; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39f539a83e0so7104835ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725327085; x=1725931885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ri20ZOYkB6yhJ6cFc5B/D/pVjfJR6mNPKrohtebri3s=;
        b=CxPxVE3/tJOWlxD5UrBTki2TagT1CptUPGBFTvIp2CedBt4qR+3xOOABHjv1C8IKf9
         oR352Kt+rZMHXuES7j/G8IAxz5uf18pg7wAZODOJbca765FYcU/30n9gEoS8YymhaK8X
         d4mblwdNLANV2ldDQIUmx1OZcX9YWqq1TeB594ANbYEH/nQBWVPtFBduR3CBSZsEzk/6
         hCuNjswvxYuwPqevwW+yw+O0En8sb0oOEN2mJlwIwwx6Rf14IOVbZ3kRO0kzLtcinQs+
         xIw2flEeYDw7fQJSm5aJB0oPYUiO6uDiV0MZcj2BQDcFNHsTggR7kaP4nxnM903R/6Mm
         24UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725327085; x=1725931885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri20ZOYkB6yhJ6cFc5B/D/pVjfJR6mNPKrohtebri3s=;
        b=qUgivoYBYgXMzE0YmvdCC4XD8WuyV9LP/R4WS5bIUgqIVNARJR5FCESXQczX201Wo5
         Y2lNDhCxXT8kuiOq2jKm26PqcBOVJHNocACpVZAEBbSfQZkhJxocg1fbE/N3sV2vAw4Y
         xWip6Tyt5IsfIO7nNbiK8jZF7iMx6hLtuJL7nu7+g/qGmaVoDUKDsE+NKeAED+drLP0p
         MoxKwRW9DnXfpt+OTk4BcFrroOtliqvAl1OrnUbs29lOHUx8ndjXnHj10iefC3dE4E7N
         GVr0XiA4IlosJo8/wZPlcfSPwa8AflOt4Nn8MwVXNJnEqzVF9PvFdAWtcCaqOSV7GP5R
         2kmg==
X-Forwarded-Encrypted: i=1; AJvYcCWnT4y2DO9TdyIc3IrXjqoxLBE7PlGWdlG3rwewUkhC8xi9R/+R1H+k6DCl7aVbmINP9EqyvVzozsLC7b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyx+K6g3bukfr5VkJLTz0ZLTJ7o7hGyk/9qtoKuQ4JOk40kDvD
	NWj1/HRoyecfcViMIgzXYrVRPC3qzLrqrAXZLSannulM8LtQHNzV
X-Google-Smtp-Source: AGHT+IFIfhrL+8F5pUB/1ZWQVwcOphee+yoon27dy0Y1M3N/0zhMlC9OjINpNwWzDme7omhpCnFoXA==
X-Received: by 2002:a05:6e02:18c5:b0:39d:41e7:e093 with SMTP id e9e14a558f8ab-39f4e1293c4mr100508905ab.25.1725327084965;
        Mon, 02 Sep 2024 18:31:24 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b059c32sm28466715ab.75.2024.09.02.18.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:31:24 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com,
	linux-imx@nxp.com,
	festevam@gmail.com,
	frieder.schrempf@kontron.de,
	aford@beaconembedded.com,
	Sandor.yu@nxp.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/5] phy: freescale: fsl-samsung-hdmi: Expand phy clock options
Date: Mon,  2 Sep 2024 20:30:42 -0500
Message-ID: <20240903013113.139698-1-aford173@gmail.com>
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
  phy: freescale: fsl-samsung-hdmi:  Use closest divider
  phy: freescale: fsl-samsung-hdmi:  Remove unnecessary LUT entries

 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 575 ++++++++++---------
 1 file changed, 291 insertions(+), 284 deletions(-)

-- 
2.43.0


