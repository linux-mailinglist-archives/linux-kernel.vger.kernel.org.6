Return-Path: <linux-kernel+bounces-279577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ECE94BF36
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6092A2873B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118B218E02D;
	Thu,  8 Aug 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXEuY1x5"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435418CBE0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126280; cv=none; b=CohP+IvaQcHQPKYYNqrGYiPQh4BjgLderko3QOfqf0mINbzzXWrzY3xF5Ar+n+uomKrLCik7eRsxSOI7twFlWuUEzJCCqQ/PVkAW3+WdmIqK1x5tC96+zat1VRf66Wo1xO+9icTn+TrD8Mt7b01CqwhD4Wuym0O0Ls42fmAtaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126280; c=relaxed/simple;
	bh=95AlyDaddNiZMDEmIhO07GExNxqtyCYVTGs9vpQrW4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K3F9UD2lipasGSI0/BA2E/kFA4bl9eamZUbGeqWBOfSYYbEEUNWuwK/LCSYw+H/ove6qOWCH1FfGf5ZNyhcIZ/ym0Puydfh8uAcoq8aPTSZk58na22uzXhWkFU4B9hk7uk5cxZCI833z+2SV/zej4G/wwLMDG9FvwajDHnSMqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jXEuY1x5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso1044076a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126277; x=1723731077; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wieDPHjSPi1ZLsan7+O0Z+D8NjoHSP8ahDa0aetrxpk=;
        b=jXEuY1x5jqvkjYo/pjvy57/hMeQsF5QoEm2BXzXtMpl+Vhw9JyAN28KqPe8AaaO1jY
         FXCnF6O1k3psGedbj2U/ynlcMpJjInFoIL051vPDbIFnjxfuCjlTMn68BvwGId3bjT98
         MORRsSBrlS516z0wK0a4yCodInvIzEYSbIYZEmbZCX2NBFzR37ZIGvfNUL3AfBi72YWL
         ecxfpDD9JZrxd9MN96c5YY1YqozVtkkqdPlRVYsoVhIhDkbfgF/SiUpnDYeEKtl8UiXI
         5CFD1yGxEoZxXQ2KGSrfCk881CxXwJV9zrUJFP1uDrOqL2YEhPg8/mgVhY3J20PX1rsx
         KMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126277; x=1723731077;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wieDPHjSPi1ZLsan7+O0Z+D8NjoHSP8ahDa0aetrxpk=;
        b=fmaMcPWwL9fPdXsNwDMQfsmCBXQEJYXlLVCjUYYxDbKt/jOwUwYjve6SDSzy3z2Jb3
         V8i0/qYGVU0gpavU16LXDG1rDb/ukeRKiT1BWbtZ7OCgkSFheRk0xiJscc2/6VCoayDG
         DcqbV1Z1pUSXaEBGjp5flB4Igdq9ImF9g797zrgm2lgWHJCPahA0k4a2s6Wn7VDSCLu7
         JpYzLgmqhcvquHWdmGF5Mo6lqJHQrPvK1yHzloZGILUyr0OPxi5dIsc0Qfzt+4qdtB85
         7CQ2OeJVOdbpz+UOMjShsSnGmKqnysDCtWyEPB80vMkQzH/Bl1BWP9YUl4PCHpCiQQay
         wQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYFjx0eXML8hG1txI/LNIL/N9VOQTl3n8HrCrFj1xsegxjVL6LWmFGJQ04LWYlkgMg75/2IImW/Bt4MIX/10stx0V4aRuaf31P4kwH
X-Gm-Message-State: AOJu0Yy57U3wt9pEvUm4Sqbnm55L06CJgmmfKj4AR0oHTI7DZL4rL4oW
	mRDO1tjy4z5J3KnxP3dlN4NCdMlN5zqgViAfabLJCcyMSV9vH+d+SzuLR70Pl1kGej6zBJBMApx
	yoULKuQ==
X-Google-Smtp-Source: AGHT+IHdqxblFw4szqgN7ofHM/QU50Nzna/i6RgnPnDiQEz7rQf3FzXP5OyidprWJ44HWP8e2NZg+Q==
X-Received: by 2002:a05:6402:11c8:b0:5a0:f8a2:9cf4 with SMTP id 4fb4d7f45d1cf-5bbb2234eacmr1617101a12.25.1723126276628;
        Thu, 08 Aug 2024 07:11:16 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:16 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v5 00/20] clk: help OF platforms with their stdout
 (earlycon) clocks during early boot
Date: Thu, 08 Aug 2024 15:11:14 +0100
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-0-11cffef0634e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAALStGYC/4XOsU7DMBCA4VepPHPRne2koRPvgRhc+5JYDTY6R
 xFQ5d1xykCZOv7Lp/+qCkvkok6HqxJeY4k51WifDspPLo0MMdRWGrVFaxDGQkiQcgIuhdMS3Qx
 +zv5SQEPnjO5xcHTmXlXiQ3iInzf+9a32IPkdlknY/aFkEJ9NT7qho+1a0kDgUhBugrjyHS8vc
 0xOcpNl3M0pliXL1+14Nbv86xzpwdxqAKEN/twHtBjI38P73WrvNf1As1UzhI4ZA9uO/2nbtv0
 AZwaD7VsBAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Abel Vesa <abelvesa@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 imx@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Hi,

On at least two plaforms, i.MX and the Exynos-derivative gs101,
earlycon depends on the bootloader setup stdout clocks being retained.
In some cases stdout UART clocks (or their parents) can get disabled
during loading of other drivers (e.g. i2c or UART driver init) causing
earlycon to stop to work sometime into the boot, halting the whole
system, see e.g. [3].

Code exists in the i.MX clock drivers to deal with that by temporarily
bumping the reference count of the relevant stdout clocks during early
boot.

While gs101 doesn't have such code, some UART clocks had been marked
'critical' for a different reason originally, and by accident
worked-around the same problem. v4 of this series proposed addition of
similar code to gs101 to be able to drop the 'critical' flag from its
clocks, but Stephen suggested to move all this into the clk core
instead.

This series now does that:
* instead of duplicating such code to gs101, teaches the clk core to
  deal with stdout clocks during early boot, similar to the existing
  support in i.MX
  This is hooked into of_clk_add_hw_provider() and
  of_clk_add_provider()
* updates gs101 to remove the 'critical' flag from affected clocks, as
  not necessary. This is essentially the last remaining patch [1] with
  all review comments addressed, from the series [2] that was sent
  earlier this year, see lore links below.
* updates i.MX to remove the now-unnecessary platform specific code in
  its clock drivers. I believe this also plugs a memory and extra clock
  reference leak at least on imx7ulp, see below.

Note 1: For the avoidance of doubt, any of the above is relevant only
        if earlycon and OF are enabled, behaviour is based on the
        'earlycon' kernel command line parameter.
        As this is meant to also replace i.MX specific code, the
        'earlyprintk' is also supported (since it was supported on
        i.MX)

Note 2: On i.MX, at least clk-imx7ulp.c calls
        imx_register_uart_clocks() twice (once for each compatible),
        but imx_register_uart_clocks() can not handle that and will
        leak memory and clock references in that case.
        The new clk core code handles multiple invocations without such
        issues.

Note 3: I am not in a position to test any of the i.MX changes and
        would appreciate feedback. In particular with these changes
        stdout clocks are enabled when of_clk_add_hw_provider() or
        of_clk_add_provider() return, but:
        * some i.MX platforms did some reparenting or frequency changes
          in the old approach before enabling stdout clocks. I believe
          they're all unrelated to stdout, though
        * some i.MX platforms enabled stdout clocks before the call to
          of_clk_add_hw_provider() or of_clk_add_provider(). Again, I
          don't think that difference is going to be relevant.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

[1] https://lore.kernel.org/all/20240130093812.1746512-6-andre.draszik@linaro.org/
[2] https://lore.kernel.org/all/20240130093812.1746512-1-andre.draszik@linaro.org/
[3] https://lore.kernel.org/all/d45de3b2bb6b48653842cf1f74e58889ed6783ae.camel@linaro.org/

Changes in v5:
- move stdout uart clock handling from gs101 into clk core (Stephen)
- update i.MX to drop now-unnecessary code
- update series' subject due to changed scope
- Link to v4: https://lore.kernel.org/r/20240712-gs101-non-essential-clocks-2-v4-0-310aee0de46e@linaro.org

Changes in v4:
- new patch "clk: samsung: gs101: allow earlycon to work unconditionally"
- update commit message for patch 2
- Link to v3: https://lore.kernel.org/r/20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org

---
André Draszik (20):
      clk: bump stdout clock usage for earlycon
      clk: samsung: gs101: don't mark non-essential (UART) clocks critical
      clk: imx: imx25: drop call to imx_register_uart_clocks()
      clk: imx: imx27: drop call to imx_register_uart_clocks()
      clk: imx: imx35: drop call to imx_register_uart_clocks()
      clk: imx: imx5: drop call to imx_register_uart_clocks()
      clk: imx: imx6q: drop call to imx_register_uart_clocks()
      clk: imx: imx6sl: drop call to imx_register_uart_clocks()
      clk: imx: imx6sll: drop call to imx_register_uart_clocks()
      clk: imx: imx6sx: drop call to imx_register_uart_clocks()
      clk: imx: imx6ul: drop call to imx_register_uart_clocks()
      clk: imx: imx7d: drop call to imx_register_uart_clocks()
      clk: imx: imx7ulp: drop calls to imx_register_uart_clocks()
      clk: imx: imx8mm: drop call to imx_register_uart_clocks()
      clk: imx: imx8mn: drop call to imx_register_uart_clocks()
      clk: imx: imx8mp: drop call to imx_register_uart_clocks()
      clk: imx: imx8mq: drop call to imx_register_uart_clocks()
      clk: imx: imx8ulp: drop call to imx_register_uart_clocks()
      clk: imx: imx93: drop call to imx_register_uart_clocks()
      clk: imx: drop imx_register_uart_clocks()

 drivers/clk/clk.c               | 129 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx25.c     |   2 -
 drivers/clk/imx/clk-imx27.c     |   2 -
 drivers/clk/imx/clk-imx35.c     |   2 -
 drivers/clk/imx/clk-imx5.c      |   6 --
 drivers/clk/imx/clk-imx6q.c     |   2 -
 drivers/clk/imx/clk-imx6sl.c    |   2 -
 drivers/clk/imx/clk-imx6sll.c   |   2 -
 drivers/clk/imx/clk-imx6sx.c    |   2 -
 drivers/clk/imx/clk-imx6ul.c    |   2 -
 drivers/clk/imx/clk-imx7d.c     |   2 -
 drivers/clk/imx/clk-imx7ulp.c   |   4 --
 drivers/clk/imx/clk-imx8mm.c    |   2 -
 drivers/clk/imx/clk-imx8mn.c    |   2 -
 drivers/clk/imx/clk-imx8mp.c    |   2 -
 drivers/clk/imx/clk-imx8mq.c    |   2 -
 drivers/clk/imx/clk-imx8ulp.c   |   2 -
 drivers/clk/imx/clk-imx93.c     |   2 -
 drivers/clk/imx/clk.c           |  72 ----------------------
 drivers/clk/imx/clk.h           |   7 ---
 drivers/clk/samsung/clk-gs101.c |   7 +--
 21 files changed, 132 insertions(+), 123 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240430-gs101-non-essential-clocks-2-6a3280fa1be8

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


