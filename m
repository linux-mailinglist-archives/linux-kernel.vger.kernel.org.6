Return-Path: <linux-kernel+bounces-319188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40396F917
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6258E28625F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249C1D31B4;
	Fri,  6 Sep 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dKpQmzXc"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CA1D3192
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639312; cv=none; b=u2kf22PVr6hpuIJVelI0eicxIwXUvMo8MATmfWu+3fdx4JgGsiVdN0ADox7ZWvOypSTN58X/R3c1bHxEJkfRZKprc6u7DZ5t55OYadhzTeBrHSf5abik1w8ANaQSMD+3DgRMYDojDU75fvQnnhaS9NkGE59jLqJQJwxZePbS4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639312; c=relaxed/simple;
	bh=22yU5CB3XbloUlWmjfe5a8u2Ymnn+CEopQkapNyGFjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rSWs8ccVdMJMiaRPPJ7H4z7nhgZ4L6k9hK3yDAxkgdda8lwpX6mJGdRqtYHeRdiPpqaeEPnbc4O757LleCFOltACQjg7p+p62VJ0YsHXld1XDzvHCwl6dhBrkEdlhjazp3evlCymzr87yq+v/WPAsaPET92wBYn36xIlJD8TYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dKpQmzXc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718816be6cbso1114558b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725639309; x=1726244109; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wn2UpEZi41nSQjInl6SrXLXpD6o8knFu4d9yCjfYxLY=;
        b=dKpQmzXc+koKdjaXMdGrYiNhtYDA/CCci+E1qwKKKdja26sX7Ud8rbhs+rTqceVs4z
         fctZPwiEI7YojwVJJyobUY6lW3kob8nUlh+YtU/SJd8SxZuwKHeug3nT2V0t9nopJPcr
         Kr6dWkA67YOwjM+rTEeEeDP8ypFUj/wctztNKm9cVpNQpRgBtwewqEqVKUf0NO8Gg/M0
         wgM6vx2zd1zKwZKkYLsYQD2+dQs56M09bj3Dukb3dBh2OfrbcrDO9vSMijlq7L1jJvaM
         0GYPLG/Q4AltMEpixO5freBDwhu4StZGh6gt9Kf+6RoHTM0Od2RkH80e9ZIuvJw8CwSF
         d7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639309; x=1726244109;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn2UpEZi41nSQjInl6SrXLXpD6o8knFu4d9yCjfYxLY=;
        b=eEkEJPJTRE07mYgk0/qTgKBdv7408IaTrOBl5xBhC+G711W7ljMdrAwN0EldX7TZ+7
         qbATJtZ3SnonW/rbc68FQuz/2kDIJqWVPofMdJ4P5Eca/+FjCbguNYj+sCYdnZ09rmij
         y+rJjzwx2rH3J43KTZRAgqJiBWH4St5D507y7URT34YCBceILs3l9HXUOzF2YFu4wIiy
         pdtas4T8+Sk0KLDqw6VOxygc4DZxcJciSLMZ5i0T5F5cwEJRzXWAy4qWzNXx+GpjbMm5
         LyyFK+CJj+a9+5J0bF+IHR06pvxLKDOIR2Wuh1xqvjH7CnxnhIvUBV05Qck1OBRwwNuT
         gVRw==
X-Forwarded-Encrypted: i=1; AJvYcCXV6WVNjoFp4QOWcfSU3MDcTEkZi/BLj+31hWlIhhm5IDjatwmJkvn5OELsOu00vvU6rGK7eOXEVM5XdKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+5jzOGNrrHuaVVqoDhrPo1CmI5UawoANQKm+6vc+/3oskIrE
	bwtaVnGtFYDGPZgQ8idj4yvyCmgX5rSiJ1MF7t4k5IEvbRiNqO/fL3VsWYWcCI4=
X-Google-Smtp-Source: AGHT+IGXiEjqpuXYP+ZXwcYudJb6roUqkR2/hbNZu8SceDTTB9vrlPg/xfywsr+XXuBErr/nLwzJrg==
X-Received: by 2002:a05:6a20:6f05:b0:1c6:fa64:e5bc with SMTP id adf61e73a8af0-1cce10ab0e1mr32688520637.34.1725639308743;
        Fri, 06 Sep 2024 09:15:08 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778521026sm5207535b3a.18.2024.09.06.09.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:15:08 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v4 0/3] pmdomain: ti_sci: collect and send low-power mode
 constraints
Date: Fri, 06 Sep 2024 09:14:48 -0700
Message-Id: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkq22YC/43P22rEIBAG4FcJXtfgKaKhlL5H6YXGSVdYk1Std
 Fny7nXdQg8UtneOMN//zxkliB4SGrszilB88utSB3HXoelglhfA3tUZMcIEUYTh4xZwkZgSPK1
 LytH4JSe8BbeG+sQz524eDMxCaFSRLcLs31vA0/N1jvD6VnPy9RNZk6BaIfg8dkX2lOI40ctug
 JRMazB2962AJoJqwZjuKdFK1Ro4pO3RmtPR2wh9ZR7QJebgU17jqZ1VaMv5vGC4dUGhmGBHlbR
 SOXBi+sE3vbBvItU3RVZFISlng5GEqPkPkX+J+h8deRWBD3qylms5iF/ivu8fmmsmJNoBAAA=
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3633; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=22yU5CB3XbloUlWmjfe5a8u2Ymnn+CEopQkapNyGFjE=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBm2yqLb1vrc1X5+SfRllnnVJ1eiLSPj1yDIjuww
 OgmoHMsb9mJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZtsqiwAKCRBZNxia0/vG
 ZVYKD/42q/r8/QcPQxtIyUr9BU7QOZz1u88iEQbhvPbBomHdzAKnCIFIawoUzvkpThwNZfd1b6W
 q8u+uZIz5s4nPPbXAWXOu8mGIyHal7/G3MQL3jXICwNMq3L7Z7eA3uPYuFiMM1dVRVZJA/X5FY4
 lPPZ0309eB22ZpZKnE15rW4K+T+PQ2fhXvH1lBsEol1pVsZEHaMmxsZBEhGcUrruWnWb4Lvyuue
 WyimL6rJTVq2PDb9HiqEvpy3pCItmOdOfBOklm6Su78UZJq0THLo2CphvoZsl5RL9XSp6w2bWP0
 ZB39ptNHEdj4+AX3CyrVazicMssQIIq7NnBwJkKOg71+M2XaonHNvqoC+6kqILNHAs1N/fUt+DY
 kzM69bEUQX0PSsA8TOaBXOClutwaD09xZ5YBoHwNv3nd/GF6k/by/MZznYbouf2QrD5qq0J02w0
 bxVktpLVR5ZVc9PAURyFwyo2O65I7A6UZ08lAv2hOlCrBDn+h8/F+UKdzkLcC4wIDcTsk/9VuyF
 FtBKuuXQjCCJbv+MxoN2++0qDVICxv97/3B88dCb6wmaPZ7dPg7yRTmXtYVNTzP/7/mhvpMzbW7
 BOKLvXuUZivIBw7nYJ/pHtK8mKeOksym6waKi/DuhNA2hmyFZElVebXcU1m6N6m1wdvN/sNGetP
 EY3T095dAhW9wYQ==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

The latest (10.x) version of the firmware for the PM co-processor (aka
device manager, or DM) adds support for a "managed" mode, where the DM
firmware will select the specific low power state which is entered
when Linux requests a system-wide suspend.

In this mode, the DM will always attempt the deepest low-power state
available for the SoC.

However, Linux (or OSes running on other cores) may want to constrain
the DM for certain use cases.  For example, the deepest state may have
a wakeup/resume latency that is too long for certain use cases.  Or,
some wakeup-capable devices may potentially be powered off in deep
low-power states, but if one of those devices is enabled as a wakeup
source, it should not be powered off.

These kinds of constraints are are already known in Linux by the use
of existing APIs such as per-device PM QoS and device wakeup APIs, but
now we need to communicate these constraints to the DM.

For TI SoCs with TI SCI support, all DM-managed devices will be
connected to a TI SCI PM domain.  So the goal of this series is to use
the PM domain driver for TI SCI devices to collect constraints, and
communicate them to the DM via the new TI SCI APIs.

This is all managed by TI SCI PM domain code.  No new APIs are needed
by Linux drivers.  Any device that is managed by TI SCI will be
checked for QoS constraints or wakeup capability and the constraints
will be collected and sent to the DM.

This series depends on the support for the new TI SCI APIs (v10) and
was also tested with this series to update 8250_omap serial support
for AM62x[2].

[1] https://lore.kernel.org/all/20240801195422.2296347-1-msp@baylibre.com
[2] https://lore.kernel.org/all/20240807141227.1093006-1-msp@baylibre.com/

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Changes in v4:
- fixed missing return in wakeirq error path
- updated trailers with reviewed & tested tags
- Link to v3: https://lore.kernel.org/r/20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com

Changes in v3:
- change latency set functions to static void
- Link to v2: https://lore.kernel.org/r/20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com

Changes in v2:

- To simplify this version a bit, drop the pmdomain ->power_off()
  changes.  Constraints only sent during ->suspend() path.  The pmdomain
  path was an optimization that may be added back later.
- With the above simplification, drop the extra state variables that
  had been added to keep track of constraint status.
- Link to v1: https://lore.kernel.org/r/20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com

---
Kevin Hilman (3):
      pmdomain: ti_sci: add per-device latency constraint management
      pmdomain: ti_sci: add wakeup constraint management
      pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
---
base-commit: ad7eb1b6b92ee0c959a0a6ae846ddadd7a79ea64
change-id: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449
prerequisite-message-id: <20240904194229.109886-1-msp@baylibre.com>
prerequisite-patch-id: a0efbf22e69d23dba8bb96db4032ca644935709b
prerequisite-patch-id: a9b6a17956ff6a09a6ed19c35df9018e28b5059b
prerequisite-patch-id: 2999da190c1ba63aabecc55fae501d442e4e0d7b
prerequisite-patch-id: 69a741b9c81d7990937483fc481aafa70e67669d
prerequisite-patch-id: 945b15416a011cb40007c5d95561786c1776bb98

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


