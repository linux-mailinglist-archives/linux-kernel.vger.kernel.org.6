Return-Path: <linux-kernel+bounces-250983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC9C92FF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EE21F23533
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C3E178CEC;
	Fri, 12 Jul 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IB5B9ht1"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3B17624C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804188; cv=none; b=ocuWrbMAGjJPokwCqAMBUwUy5ek8ZlrjdVT/UKF3pyYyVB2SVkdjxnKcUbyo/v+D922w23i6Ze8AtN9WPRLpZklXI+rY4vZYsn8aOSrXDipa0sId+zaeV91aGGhjIrDlsN3lGn5cZRmcBLKJ6ET1pyClnM7OuECAElsZshs7UNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804188; c=relaxed/simple;
	bh=IvYiOk43NNLFvoIso1SMpTkb2IyLTMaSDdcgZBde4sM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rXYS7XHGyFenJsRSGmR6dFtApxJxppCjmMk/F0OhPAkL/cIfQ0Jl8RQ+WABRkkYHzbFRaSKB0TwpI4gGqzPeTxxwTlrFA69yFVTei1gbZuuNrbw7Rdli7cQrJe7v/pdq7Tm3DdfoWH02oO/siY9h/hd7WJaqYELCpodJ0/m0J0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IB5B9ht1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso272500466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720804184; x=1721408984; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fnhm523hS4IDFhkj8U4RWRolcD19Piba7MrN9aiVgQE=;
        b=IB5B9ht1UpjPgaKNp3hX4EaNj7ilkCF7om9IWRRprM5l97yh1/wzDcybyGnY+/TQcj
         i1Xeygq7aP6FHHfYTh+ohhvEeOlqU/PgcvIL0px24xIvmQiW3YwNGdfxFdZexld85Yf5
         ATsWIkksb1zfsFyyRTTVCUHMxvlhw6Wn/K0fQaLj+jhMsuhGPc0rH7G4VRjwCTrSCmeT
         6n3izTnz6zA46Leeeg6JKYEL42IJHFz7K8090HdhU/OvMGBrazWiLQRhlAeh4SfSsIV4
         LjMCguGW8Z+8lVsfYK5MLhv1bWszm0tbLxzvg5ZGm4in5NCkE1BAn0fl0gfxGF7kaW6D
         eKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720804184; x=1721408984;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fnhm523hS4IDFhkj8U4RWRolcD19Piba7MrN9aiVgQE=;
        b=H7PxEbdEA3rv3rgy7afHUg8Ou57bmuiWGqKczQh9MUyzM90XUzPS+2WarWvkZFpo94
         G8MZJv8J6G5NwDtku6n4vFzRFdU7bi0vlVXmy6HT0YXiQ/8dJ3pIXznyAJRrBFOQ/rxe
         FK7Cf2RsZmvA0hI+V0Sk0DVQ7prObv7W0PZ2YYzbKoHhKpxwunpSQ/ifhZTcfLIITqKn
         D+VQkX4y/H5dGcxQSfvcGWgYb3+Us29XzhhfyG2sIDqqR+ybeVkdvSC//padnBC8YtAb
         Y5OubRGZE20uz01m8Q+D3bfagh+kmG2rCl5yPvgtfV/cRQY3Bx10OBqhQdQbh/rRzALT
         DpCg==
X-Forwarded-Encrypted: i=1; AJvYcCUvGjwO1F6fKQMHQFRviX9NuVzV0FDdIQ3qQ7iIVvRmqG+RUntgXSzhhz4q4Tg7T3lwLhd/tmtZQAbNjg9Q2ZkDE3YHLb1gKD/rOBuU
X-Gm-Message-State: AOJu0Yyyxt01+ksrjl1BXGGmFcNHNA99roYXybAW7AKnNe2oZZirBnb9
	ZQ18ONNdJeTXhHh5RHOcphfYxiemw8hpUYQpI/qhIGdMVGfOPOCtLMN4fr+Jwx4=
X-Google-Smtp-Source: AGHT+IG4TH6RpE92PDuHakkWNmOybXTmwNcx+nqarKFaRp+ljxkRFFwn0hjm78OZrfbRQp1qxbfQAw==
X-Received: by 2002:a17:907:3f12:b0:a72:7736:9e03 with SMTP id a640c23a62f3a-a780b881c7cmr1089046766b.52.1720804184549;
        Fri, 12 Jul 2024 10:09:44 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a871f0esm363750466b.194.2024.07.12.10.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 10:09:44 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v4 0/2] gs101 oriole: UART clock fixes
Date: Fri, 12 Jul 2024 18:09:42 +0100
Message-Id: <20240712-gs101-non-essential-clocks-2-v4-0-310aee0de46e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFdjkWYC/4XOsW7CMBCA4VdBnnvRnW0gZeI9KgZjXxKL1EZ3U
 dQW5d0JMLRbx3/59N+MsmRWc9jcjPCcNdeyhn/bmDiE0jPktLaxaD16h9ArIUGpBViVy5TDCHG
 s8aJgYRecbbELdObWrMRVuMtfT/7jtHYn9ROmQTj8ouQQ311LtqG9323JAkEoSbhJEvQnX45jL
 kFqU6V/mEPWqcr383h2D/nl7OmfudkBwjbFc5vQY6L4Fz4ty3IHts1uLA0BAAA=
To: Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Hi,

This series fixes a long-standing issue in the gs101 clocking / uart
handling.

We can now disable clocks that had previously been marked critical, and
still get a working earlycon.

There is a preparatory patch, and then a patch to drop an incorrect clock
counting work-around. That 2nd patch is essentially the last remaining patch
[1] with all review comments addressed, from the series [2] that was sent
earlier this year, see lore links below.

Patch 2 can not come before or without patch 1.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

[1] https://lore.kernel.org/all/20240130093812.1746512-6-andre.draszik@linaro.org/
[2] https://lore.kernel.org/all/20240130093812.1746512-1-andre.draszik@linaro.org/
[3] https://lore.kernel.org/all/d45de3b2bb6b48653842cf1f74e58889ed6783ae.camel@linaro.org/

Changes in v4:
- new patch "clk: samsung: gs101: allow earlycon to work unconditionally"
- update commit message for patch 2
- Link to v3: https://lore.kernel.org/r/20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org

---
André Draszik (2):
      clk: samsung: gs101: allow earlycon to work unconditionally
      clk: samsung: gs101: don't mark non-essential (UART) clocks critical

 drivers/clk/samsung/clk-gs101.c | 106 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)
---
base-commit: 523b23f0bee3014a7a752c9bb9f5c54f0eddae88
change-id: 20240430-gs101-non-essential-clocks-2-6a3280fa1be8

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


