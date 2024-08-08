Return-Path: <linux-kernel+bounces-279637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130E094BFDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0802852F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8818FC63;
	Thu,  8 Aug 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yhiv9G1K"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF018E77E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128172; cv=none; b=ipym6Gi9RFluRQb0KNWqMSiBvfwlfgnB0gstTmntw9kr5os8D/RmMzbLZVtoCS8ljzdU+YfFWUhnT7JsF94nL6lM3TCWzZennOzkWRfpTDH3W5k85GKVXnViqNpFgQWSfk75iM7NRe+yDVzKRCbK0YvT+SI1ZE7Wavqfeu7rb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128172; c=relaxed/simple;
	bh=9nTuNa+ZoP53IinLlZDXlzgyFHvBbNjGNsuxv0yinBM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m+CGrCAVo5XCi3/CHeoGdm/mhzfkWOGZc1WHvpAlCLTEa+2GpwQgHkm1vDXaTi9ixj1DtqBN4e+Z14pjuyOYO4g2p/P2KEyRLuS0sE1xijWntJWKAx+cPE3Gvpsun/3FnuDhzxENv59S2tU71MQD5wSlnqRtFmVgQoxJmygp/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yhiv9G1K; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so122558666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128168; x=1723732968; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QqlFumWj11SFbqn7rghR1MsiiuQhB4WbP4/WopFjRvU=;
        b=Yhiv9G1KDBGKcJJly0WBx0Va6lCx+SxAo0Aepx1YiKfZ6OykyawFWBK3PyJVafpZPY
         jBKcuCLUfx1KYUQfNs713GjrSbufawU3wkfR7BWM9BnVkSjS+tISwkIRJ4yTW/IZS53a
         TEL2Mak45+qk/G6srD5DJrtUUBTo/+WmxvHdVlA9/an5JJf1Z8VdOAW1oOU1L2PxruyL
         03ZF6prRCN0CPxVBSGwPYoRIZAqS+F3zNqjN9kJXmjAB720HBpKBpZD8LOnv59ayGIxn
         4Kv7Xs4C9j8VZxOog63DhGuScHTXp8pOPqpwK/+BRdryF4V2Ax6g7YzIE2kPdBey5qtj
         ypRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128168; x=1723732968;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqlFumWj11SFbqn7rghR1MsiiuQhB4WbP4/WopFjRvU=;
        b=FwgKb828EyTT1KEcmKI09puV51+kzbHvSqCT54wVGnMlBHCXOQ6Ov3Ulb4jatpsHtN
         54pStliLQACeg38cqgDOiiO2a2azBm1vCl4O+CG/adqKUDMe4Y3av9Ld+6xev+5vxsFA
         M/4DItyGv9UbSQspaATXmYXgUMoqKTFyaiYNOxCP9rOvxGzHIsXMMevnMLOsWvoF8LQR
         S+CfXMN32LjkSuwVpYl7P2PMu8gKA58jMu4wdGf1KzswlSMaB2MFcb6Volf082poVGLo
         V9FKjQyJqxZyXM7DaGzli/79zTYMhs5+8fLWG8+4NeS0whiRkhxy/VpV6yNb2y7Ilx3N
         NOwg==
X-Forwarded-Encrypted: i=1; AJvYcCVq8evMM15+Up4KmnUO94UqeeWHryJloREvYspvWFQZFpE9tV1rV1NPuP8hM74FrTXCtDjpN3wNoYlT2OtwkCXSUXQmBEH66dQ1cHMZ
X-Gm-Message-State: AOJu0YwoL58VyHXCqpvz/RXeay8k7bH8+DqOTT+iy7Vxf/Yk//tUBHeN
	IGa2tSMxThyUM55ZfxYw6s9559QGmiZ3OmJVTQBwbBXwwKxM3eP2rwQaGxeVGaw=
X-Google-Smtp-Source: AGHT+IFR7bYGBnaMOhaFH4f94Vv7JZow/txFeQW64yeEZpKk5E2SBtyJawrOgHNhrqWB2DxlDwtasQ==
X-Received: by 2002:a17:907:f1a6:b0:a7a:ba59:3164 with SMTP id a640c23a62f3a-a8090e9e288mr181745366b.53.1723128167728;
        Thu, 08 Aug 2024 07:42:47 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:47 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v6 00/20] clk: help OF platforms with their stdout
 (earlycon) clocks during early boot
Date: Thu, 08 Aug 2024 15:42:41 +0100
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-0-e91c537acedc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGLZtGYC/4XOsU7DMBCA4VepPHPRne2kphPvgRhc+5JYDTayo
 wio8u44ZWgRQ8Z/+fRfReEcuIjT4SoyL6GEFGt0TwfhRhsHhuBrC4lSo1YIQyEkiCkCl8JxDnY
 CNyV3KSChs0oa7C2d2YhKfGTuw+eNf32r3ef0DvOY2d5RUojPypBs6Ki7liQQ2OgzNz7b8h0uL
 1OINqcm5WEzx1DmlL9ux4va5F/nSDtziwKE1ruz8ajRk3uEt7tFP2pyR9NVU4SWGT3rjv9p7V0
 zaHa0tmpEru+5x07pv9q6rj+WKm4kqQEAAA==
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

Changes in v6:
- drop a stray #include from drivers/clk/samsung/clk-gs101.c
- Link to v5: https://lore.kernel.org/r/20240808-gs101-non-essential-clocks-2-v5-0-11cffef0634e@linaro.org

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
 drivers/clk/samsung/clk-gs101.c |   6 +-
 21 files changed, 131 insertions(+), 123 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240430-gs101-non-essential-clocks-2-6a3280fa1be8

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


