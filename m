Return-Path: <linux-kernel+bounces-550879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90029A56545
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40D91896123
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64AD2101B5;
	Fri,  7 Mar 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWbceMNN"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0020C02B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343369; cv=none; b=E9+q9Mk/ewkiGN6I3vyJEkoAjo7cSfqy1ps439ERscFHJdy57xQ8zpcxP7W9U64lWTaL6wJ4UuXjaFoehJwJbc7CmK1u49oSZBKHv6ZbskytNZ7z7nalhbxdbBgtMCm/P8t9qtL1dms2BcdJxLOOaTK4lcroiBmS5jYdLVe2mEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343369; c=relaxed/simple;
	bh=iCQvNvrSUCbnUFJbDtQ5Q+slsxi7yRmUesQiJSr9k0k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bpFmvJe4Y8LZQUdcKRNb6jS5iLBtaVYaclkpsE61fcYvANnbOJYNWMsn602EDGYMjyAPSKM3DLaFMulb/VmKRMKwRbFYBU3RZSMpxFB/JLFidpEmOx3S4Ef/2A0yQ6Ij9C1+dysypkxLjsfPBiSRT6EVc2lSKqpcHiLWTDPiVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WWbceMNN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bcc85ba13so13054955e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741343364; x=1741948164; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sVCYZLL0PxN2CDTkTr7gzBPm/K6Lr1h5htb1NMheOZQ=;
        b=WWbceMNNeXOq3bHjDLRsZhWF1tijfQT6XPgxwv9x8U5XqaHrMN/VlqWjwfj7JeDiQ+
         t7Orj+QpazqS4wEopayopts/IqS8gTDf4wMu3gkDVidLNi70nhMiJIGrJYPMuMaY8PK5
         ICD+PVpCCh7vvIz2DwmKLUhdO68rF3dddmIjd0DtuTvro+ui5tTE2A/9KhdTJPKjGxUy
         0GNIra2bmCJYb83d/vkwwIJu6qgB6V/DoOm6XLmZkR+2Tma5uHTpyEKa3ZeLvMrm4E6Z
         azkCUpk44sgrg57hCPP/NR4/MRjSAKqM6/WNWG6xTmuDRjfICBe8Yd1Usw5bQ2kd3mZi
         3yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343364; x=1741948164;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVCYZLL0PxN2CDTkTr7gzBPm/K6Lr1h5htb1NMheOZQ=;
        b=cr6Zi85hAidbpzEHdY9rpo2n0Y5l0dhMlaJSlwSy7yFnoiSJaTNfOwnw5Rmrii8GFk
         1IAiAdYnAENqmfDgEEvhKvwtFnfL81Vcs/jwhjCjDAvzhHipXsbLXjJmqeUI5icW3xk/
         rbI+XfDw73Yt19QmvNnkWqOEnWxLUH2iBthQSTCABUIzRcBBCEjZfvn/hWYn8qUpUbjc
         ZpgXwmS/wKq2+WiTT4z9ZykGB3g+bKkbYkghMiVPm6l3GDX7oqVd+gb1VG4aT1UF35Xt
         LJVb8vLUq58/PLYS1KUyMb9bwrdxIi9CLWi6M+NVRikuxrX5eTkRo3/kn/eXZQN9B8dY
         tbxw==
X-Forwarded-Encrypted: i=1; AJvYcCX/dwQ2EElEzTZmKk4PKDZEjOuOBlrGIR7/YswINwWZ+tyG94NXrKcPyn6wdr1Vlr7K0tT5cklgLjObp7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzniJnZeJgIMmbzDdsO0qGiDtQfwNkrLYg1+VETfly7B8mkFl4y
	R1xAXE3AA5cc7HeHk32nUIi6ujtZ+Dq7db5vKuY7iMcgXTySrvWgW94lg2Hgksg=
X-Gm-Gg: ASbGncvtMmLbvVBrFqId1NWPELzjyVZ7V69gL/PSIGOTxECxXQAhC6jbYEinyYE/wMj
	qeWBTnLD6oyewCazKnUnD1CL2NjAjhg294t51/XkibPHUddYzz6HHkP4+iWD+99DsaTAcKT11LA
	t0zTjgohJTldgXaQKoFckBa2HAhrQ7yxV9WGzcHRhgouOOZ/snFlEKeOuSY5/ViN29uzs4PRoo1
	Jbq+8XnqNJa0KfsvQlvqXCroVdCJfzZ+ZBpak/8yxRr7ZykX75Tq6sbs5lZZ/ocZ41PgX1QQefm
	GTe5zlzuq7myGsvAg6AZDXtdGtK3QiTVruhC2iUnjE9ULjTFTtvV4evGPxVYGwNKAiF1AZkxgcI
	=
X-Google-Smtp-Source: AGHT+IEHa6kUt/xq+dn25f2syNI+XsfPksB/5LtSy2qdICevzWmT3fzjID8iFJtsA0jNgMPQs9MKwQ==
X-Received: by 2002:a05:600c:1907:b0:439:8e3d:fb58 with SMTP id 5b1f17b1804b1-43c5a5fe368mr24279375e9.11.1741343364442;
        Fri, 07 Mar 2025 02:29:24 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.90.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b0461sm49192955e9.4.2025.03.07.02.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:29:23 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v4 0/4] samsung: pinctrl: Add support for
 eint_fltcon_offset and filter selection on gs101
Date: Fri, 07 Mar 2025 10:29:04 +0000
Message-Id: <20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHDKymcC/4XNTQ6CMBCG4auQrq3pHyCuvIdx0ZYpNCEtabHRE
 O5uYaPGEJfvl8wzM4oQLER0LmYUINlovcshDgXSvXQdYNvmRoywklBG8GidnsKAzTBp73C8xxF
 cixnnXFJea9EKlI/HAMY+Nvh6y93bOPnw3P4kuq5/yUQxwVDXDSGKyVMpLoN1MvijDx1azcTeD
 id012HZkTWAaZQSgqsfh3861a7Ds2MaqYQxlWQCvpxlWV4mkrrwTQEAAA==
X-Change-ID: 20250120-pinctrl-fltcon-suspend-2333a137c4d4
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3384;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=iCQvNvrSUCbnUFJbDtQ5Q+slsxi7yRmUesQiJSr9k0k=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnysp59dcFeF8bi+BDvg8zdNdr2JC4aWKtQbXWR
 5PLmdsLeZuJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ8rKeQAKCRDO6LjWAjRy
 ukQYD/4jJs2HzQEt5K9aXtxfYKahy7nUC8bA/y7SvNveZg0ZB2LiQAzUggdvLpc0sYwaLeDyw+W
 7VgDlv9Y43Sq2LQU7DBkrqGiIz9I1zdw2Sa768dJU+t4hicZveHo+0gQi9bYnSGJeqg1cgRZPKb
 qQ60iLx6KB10oRIxiu9Kf4liE8kQYRxza3T4y5t8t9cwFKhqysbzPBbVKnBlmOXvXtx9eZ5JMPb
 zPIVMkuD7jpCArp+e20WVkQ8O6qQRfPK/IuRLhLHgNnkdpVYYgnxvqJe5lhKOOgLGCTOjj6HQZm
 DzZRhFYDgT/WnWDn95tCk3axXfeuh/w8z5CcrUb2VHJWviA+wPQD/tpztLHG2xV8Dkr+3bgqom0
 Gdi0VtryZafXFJXBpDALq0zfs1HrFG1bFFdeBq0ZdfTId1UAKWuUxaERtmATLfUbrUsjPDr51sq
 EIyLbqlf3xovS9mbk/S1GOSU2np3dBHBSJJNXRAnRuZ6qy5GyrR3/NIOSzPHZEKidpRFcW635qY
 gA+bkLlUdDTDCr/zs+taHCtSEJrgZo4GqaSJi2GirQJWd05jVKaW76D4W8VuosrVXfVcmL6Efq+
 oVX7WvFXD9PVEiXEZRRzp+E9ZYJWgmQV93Hj6xVCZEd7daRmFKMui7rt12WEK+XxXuaTXoRpaib
 LpLgVdhn6s1UL+Q==
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
Changes in v4:
- save->eint_fltcon1 is an argument to pr_debug(), not readl() change alignment accordingly (Andre)
- Link to v3: https://lore.kernel.org/r/20250306-pinctrl-fltcon-suspend-v3-0-f9ab4ff6a24e@linaro.org

Changes in v3:
- Ensure EXYNOS_FLTCON_DIGITAL bit is cleared (Andre)
- Make it obvious that exynos_eint_set_filter() is conditional on bank type (Andre)
- Make it obvious exynos_set_wakeup() is conditional on bank type (Andre)
- Align style where the '+' is placed first (Andre)
- Remove unnecessary braces (Andre)
- Link to v2: https://lore.kernel.org/r/20250301-pinctrl-fltcon-suspend-v2-0-a7eef9bb443b@linaro.org

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
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 294 +++++++++++++++----------
 drivers/pinctrl/samsung/pinctrl-exynos.h       |  50 ++++-
 drivers/pinctrl/samsung/pinctrl-samsung.c      |  12 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h      |  12 +-
 5 files changed, 318 insertions(+), 200 deletions(-)
---
base-commit: 0761652a3b3b607787aebc386d412b1d0ae8008c
change-id: 20250120-pinctrl-fltcon-suspend-2333a137c4d4

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


