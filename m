Return-Path: <linux-kernel+bounces-539911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB1A4AABB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE95166224
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F6A1DE4E3;
	Sat,  1 Mar 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKAZzmvE"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED01DE8A2
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829427; cv=none; b=oP3XsBF4cpoies10Q2G/P5dVmn3suwY3PZ++Uzr4FBntV+HI32fP0aZeBL1S2DrqfAwfRL3xNNiB7dI70QQuux66MEKBSffKmbLBBzkhU3Cs8jcZyfeySyo85nREuhTHRqwVkkyDiJK0/3SxkCHijHQqH0MhuYLV/ecEsyIKQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829427; c=relaxed/simple;
	bh=evUvX4RMBfKC8FqkgyOYIu49UpyYWqsRchzfwT3wFVE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hnP1IjmZzw4vkhleJh1CVMQfuINNZ/5mGdUN5cL02kkbfzmSXCISlUJJjYc3lD+NZyvBq6+7BR8dqeAv1ICJSG1bgsrYOVTAv2mcEQz53peZYwzgvifLoePJkAzs4KeEsosy4/P+s4N8qm6FQFX2I9/MycvOTg4fvcyExxdYwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BKAZzmvE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390dc0a7605so1583182f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 03:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740829423; x=1741434223; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZbaxd2WRcoQQt1caRaFSEAx+9Lny/NjRCBroTTZogk=;
        b=BKAZzmvEnRwuhsv9v4/KVlBMZnCpKTqe54ZB754nB34LVLjvwh9yquL6RlB1ZlWf0r
         F5Fem34fjyR8qWVS9AzF0tjVl3pv0RTfcoatq3z0ORs2iax9g2u/1Ybn9CcJJtvwfsuS
         q8gTMSyS2C0mcpmuU8I9ZlW4yWcm2RHFef96B0nVLLVnwAJ81ZtKTosArCZLlGxQhGux
         rkjlkdLAcQUP+wSTE/8PzfkoRTa4aE6tndAn+N1QNJynh5EODK05MxWZMzjSA7sbr6dr
         KPPpcnj0VvO8TAMH+m5W2WPmOmK+s4aPxqbyVzznxQ7nv7lJdHfYZlB9dBfcoXAgTKYa
         nlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740829423; x=1741434223;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZbaxd2WRcoQQt1caRaFSEAx+9Lny/NjRCBroTTZogk=;
        b=f2mlGlf3bX02qmqkm6eKJagtMcU6KNykilFwu4MmE7jmrYKGa+HP34IDq6pqxkluqK
         EDdZtzP6xZFH5J8bxLrBr3SJj2tenyJy/wVEPpCq3HhrNPwIl2Z6FTfe8ImkQvtqvgsD
         rg+dOE58lOcdCOrvu1TQBwsMa7SOXaKoPBcH4IgkHzSyo5SV2CfR6YJ1pOZJGD9+DPEj
         pnUd/KOGrEakpKIF4UcSv3dXbg6tvYQJIJPI9HwwiVX/E6yTu4XY9PH4/fIR3zBHcF07
         Woz2d+ccy/mBqYnrqyafzgwyChuq67btp41i/IfAfuQtRLkfU2bwbmsHxFYUIpIuSN9j
         GtgA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Mks7/JbtPp84TsOgnY3IbSWGXDUjHA28LdiyADP8pP5UzgZH0R6uiOhZZAApVdSyhAqmr9G82457RXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxr12lrJ2hCPM8TxGox6QSI3iDKmWziqZiGUI8mCqUJgI1TGBQ
	0yzCigB9PpBy+Z3KUdb1/rFvu5FUZwwptqqT7x5pTLo9JZPpJDYsPUH7Un11FTQ=
X-Gm-Gg: ASbGnctPXOcIi8dZkyeIkvVYQShyu+pgOQv4LkWcHryHXHTwgIywA/+J8j8EHNOvLwx
	zvERjEv86ODgIy9QgZvfwiQdTPFvc3Pr62rLTj04FYyDJcP7zlEmROMxk3y27x6q9H6wiznxP0H
	YXnEwPzsAAK3vA+yeWOQsZ8j/CpOSoeUqyXV/KilxeujLaF6srUo1rf3KFgEg7RpYVBJVFUPbDV
	lHe74YCTpBJUQi6o5N68EBhiHPBZK7TrIJJOCPqR1VzjJFm7ePerQ1yTA76MamfWCHWAQWk1BhJ
	GrkL14/Rg0UPkX5XWAeq5JBrrTb//AH3L+yutBHLaNR0dLDPGWr7Qsu11ZH1hFUdVHVs6/WXo7k
	=
X-Google-Smtp-Source: AGHT+IHj61UYuOocbWw/qWMpr+RAho3zm2+puTeioLvnRLnuw4Nm2xW7pb1mJ8SKDz4411HtZ7isXQ==
X-Received: by 2002:a05:6000:1a86:b0:38d:dc4d:3473 with SMTP id ffacd0b85a97d-390eca384b1mr5985832f8f.51.1740829423579;
        Sat, 01 Mar 2025 03:43:43 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796600sm8002871f8f.20.2025.03.01.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 03:43:43 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 0/4] samsung: pinctrl: Add support for
 eint_fltcon_offset and filter selection on gs101
Date: Sat, 01 Mar 2025 11:43:18 +0000
Message-Id: <20250301-pinctrl-fltcon-suspend-v2-0-a7eef9bb443b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfywmcC/4WNTQ6CMBBGr0Jm7Zj+QFBX3sOwqGWASUhLpkg0p
 He3cgGX7yXf+3ZIJEwJbtUOQhsnjqGAOVXgJxdGQu4Lg1GmUdooXDj4VWYc5tXHgOmVFgo9Gmu
 t07b1dV9DGS9CA7+P8KMrPHFao3yOn03/7N/kplEhte1Vqadxl6a+zxycxHOUEbqc8xc35uC0v
 QAAAA==
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, tudor.ambarus@linaro.org, willmcvicker@google.com, 
 semen.protsenko@linaro.org, kernel-team@android.com, 
 jaewon02.kim@samsung.com, Peter Griffin <peter.griffin@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2738;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=evUvX4RMBfKC8FqkgyOYIu49UpyYWqsRchzfwT3wFVE=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnwvLngUxy+MXzTvUcVPQf/Vn4XqYkl8kM3dwFf
 DmYVxaFXSaJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ8Ly5wAKCRDO6LjWAjRy
 ur9qEACDSxzR9tumJKwuhzgEo08hXMNwYrOiJWy/GhOTxgmk29YjAovMmjaayFfJqUgF7V6beFA
 RS8OXsLqcO17SXY0d8+7nvES0yXgElnsfTy5oWlfypPngGZBMH+Biq/7EvmLugypVzKweBk1eQL
 iRIFYE2ni3ce+dpFxDC5nTUXJ0B11DYR9t6EIP8Dct0YsYZ4NaCR9MWefbPleW80/Tk95sAaRdg
 kbOPiWLJbRUC6OMqxC4wv9KlsjaHY2QnUfMhbX3bekG2kSoZW3pr7oEB5wr1ZQfvzV4BF4rpJWy
 w/gz8M1oJe+mW43GReWWF1qlsMcmKbVFTbwSGOlnRZlrC7H6XA7MEm73BoNnV/dm4ujVKqez6KA
 tNTQbdaQz5/Arem/o4eNCTdcR7bAixbuhs59y5uF+iIL2ShlzZGtjYTfhHK3XpvmcS5Clwfws1J
 PKbznYWGc1YodbsuGi3reJJAAsT8vLDmSWc6HBTpWchXnF4OTcU5aDkMKwJSEvd2KlbNNQac021
 Xd+aKXq0mvd9gUZZUCUeUrC7itF/yLQNy3yHdDNVR4VJihubXy94XNjCiX58Phmy3rMgSq976Kj
 M5h01vqEECANqtD0xLX/F6NP9ybFg+t7xohWnoLPZGokCX5v/EcMtf5UFUh5VxBM33oUaPSV+zK
 CfwOuaI8VtCo3lw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Hi folks,

This series fixes support for correctly saving and restoring fltcon0
and fltcon1 registers on gs101 for non-alive banks where the fltcon
register offset is not at a fixed offset (unlike previous SoCs).
This is done by adding a eint_fltcon_offset and providing GS101
specific pin macros that take an additional parameter (similar to
how exynosautov920 handles it's eint_con_offset).

Additionally the SoC specific suspend and resume callbacks are
re-factored so that each SoC variant has it's own callback containing
the peculiarities for that SoC.

Finally support for filter selection on alive banks is added, this is
currently only enabled for gs101. The code path can be excercised using
`echo mem > /sys/power/state`

regards,

Peter

To: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: Alim Akhtar <alim.akhtar@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: andre.draszik@linaro.org
Cc: tudor.ambarus@linaro.org
Cc: willmcvicker@google.com
Cc: semen.protsenko@linaro.org
Cc: kernel-team@android.com
Cc: jaewon02.kim@samsung.com

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v2:
- Remove eint_flt_selectable bool as it can be deduced from EINT_TYPE_WKUP (Peter)
- Move filter config register comment to header file (Andre)
- Rename EXYNOS_FLTCON_DELAY to EXYNOS_FLTCON_ANALOG (Andre)
- Remove misleading old comment (Andre)
- Refactor exynos_eint_update_flt_reg() into a loop (Andre)
- Split refactor of suspend/resume callbacks & gs101 parts into separate patches (Andre)
- Link to v1: https://lore.kernel.org/r/20250120-pinctrl-fltcon-suspend-v1-0-e77900b2a854@linaro.org

---
Peter Griffin (4):
      pinctrl: samsung: add support for eint_fltcon_offset
      pinctrl: samsung: add dedicated SoC eint suspend/resume callbacks
      pinctrl: samsung: add gs101 specific eint suspend/resume callbacks
      pinctrl: samsung: Add filter selection support for alive bank on gs101

 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 150 ++++++-------
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 293 +++++++++++++++----------
 drivers/pinctrl/samsung/pinctrl-exynos.h       |  51 ++++-
 drivers/pinctrl/samsung/pinctrl-samsung.c      |  12 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h      |  12 +-
 5 files changed, 321 insertions(+), 197 deletions(-)
---
base-commit: f7da3699c901aea6a009d38116d24c67a4c9662e
change-id: 20250120-pinctrl-fltcon-suspend-2333a137c4d4

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


