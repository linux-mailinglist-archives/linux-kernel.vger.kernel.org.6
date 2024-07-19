Return-Path: <linux-kernel+bounces-257156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626879375F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E45428564A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12A136E30;
	Fri, 19 Jul 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZImnCz6Q"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D30823B8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381990; cv=none; b=a3+f8nem8TU0fWPWJwX3Z4zCkp72RPioqBeV2tzc18vF0Im4uZyAh7tbRdKrLkYhFIzBYhcCfOHgSdZPenxcFZdSEHDLFaMA98uCVf/P9OD7eSu9LFEBl/ixMe18Sf7rv7N/ZFXtOK/3SVTDQeToHfhWoF0N9MEtDyrwDllqCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381990; c=relaxed/simple;
	bh=ci+KcHwAigtpkpMNemilRAChZcTSbPV2xvcRYGetHnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4y1SOYuPa87pE9Pzn65TS+JXFrzVgNelAIKuvjHDmKxa3xv6Uf5Oxqthm6MFDlBv7j4h7H/Z58GD3/g5y2Gbqqkti0UzLbho9Dw3KKj23a6KVKE2Q5A8T6+hBZ+SdJT8zRSD8wB7nw4SGraqUuApbENC43YDXf7i5vWc6U4z+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZImnCz6Q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4272738eb9eso10641505e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721381986; x=1721986786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEbHlu47gMjntr/0lWZ1HMtnTqXHStCt809hwXsuo8g=;
        b=ZImnCz6QdOO94SYv+5u/IVcyKMeeqTBSXtCgIJc3gq+EbRk39g5uhO2hPjtLtXqoTZ
         V6WIUrksnZ8uJ2+MoRJuJP8VU7IAgu8oC/VMH5nILnOHRgV1KArPJ0SHH0gv7FPg/o7d
         JKVtBaKYT7mz0sOKmbaPrImMQPalRd4kyndrDnl7KBqcAFwRBsLFDDWbmnXdDK9RbY3e
         iPZTUVutIxqtIoLmr+B0An289Dg4Ehy0oEFHUkw1/s/1AGdU+8TFTBtnZDOa8UwpF4vM
         CCWi2i8rowy256NEnm2vFYco9YNV3pjiN4Q9f/97zd2WCGf2pJLOAN8V5U4KAOT0fQoM
         aqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381986; x=1721986786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEbHlu47gMjntr/0lWZ1HMtnTqXHStCt809hwXsuo8g=;
        b=HTZIACZXDKxy3HRQLZCqhz14DHCvuHVM/KEjMg9OzFKo6jdUlzBlabDDX9XfRaSudA
         hijdspy9DFqDwj4hXJg2QxYZfbYXMPW0SIt7rQZUnxA45rRVGyJorlVjqlB6cSFzxDBv
         ZjcPHtF/q/8qolPIHR/dHA6u0sFPW/7Um3DknaWN79e4w8J7xpEhBjxr6MDAF00WASsn
         JzlH/0Iq2VxY0Cl38wON63lNg1881mXvA5JEOVd9Oxk9itdTXAoLmjiOKDUcqLIPc8f2
         MifcoXjHX+ew5c4F8n5cP/Pw7wHpd4lVZzyZpfsMucoETCJXzRWQTlY4lVoxYsYrxSts
         fODA==
X-Forwarded-Encrypted: i=1; AJvYcCVj63EGUttkzVw2xkR4k231iqdrLixc0H9kWtcYA7vuFmI2dMcohHrJfKCu+CYoV5eUlmIND21/M97QTYAaOEcoaukFUkxJd2rx4C3B
X-Gm-Message-State: AOJu0YwOa4kxmyy+tZz3fD4Z0sU1YzRFcorgMV5ufk/GuFzyeJN/IGCp
	qPnPi4A0V3q58jFhOLBmh8pVyvAyMJdiXYa3bvboCYJerBEdgypcGYWd/nZVPG4=
X-Google-Smtp-Source: AGHT+IH4BxZr7nNiWWbM+lEJPkijyLd0iYBXu9qVNkbqOH0Fb5f61iPqIYleOo5sy/iDP8q/46Z88A==
X-Received: by 2002:adf:a112:0:b0:368:71e9:4ee3 with SMTP id ffacd0b85a97d-36871e94f3dmr1106799f8f.18.1721381985670;
        Fri, 19 Jul 2024 02:39:45 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:5ac4:5655:4dfe:ce97])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3687868bc91sm1100956f8f.45.2024.07.19.02.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:39:45 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 0/3] clk: meson: sm1: add earcrx clocks
Date: Fri, 19 Jul 2024 11:39:29 +0200
Message-ID: <20240719093934.3985139-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset adds the eARC-Rx clocks on sm1 SoCs.

This pushes the maximum register of the axg-audio controller up
again so a SoC parameter is inserted to handle that correctly.

Jerome Brunet (3):
  dt-bindings: clock: axg-audio: add earcrx clock ids
  clk: meson: axg-audio: setup regmap max_register based on the SoC
  clk: meson: axg-audio: add sm1 earcrx clocks

 drivers/clk/meson/axg-audio.c              | 38 ++++++++++++++++++++--
 drivers/clk/meson/axg-audio.h              |  2 ++
 include/dt-bindings/clock/axg-audio-clkc.h |  7 ++++
 3 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.43.0


