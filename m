Return-Path: <linux-kernel+bounces-230927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1750E9183E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BAC1F2374C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7415A186286;
	Wed, 26 Jun 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FXJj/gM+"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AACC1849DB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411755; cv=none; b=puAug7yagDMp/621OjTF9zmsoiQvXjdpn2VklfAdBJoUt0qrdJJL5RyNc8bXF5oWAtwkypW8z4CDXf5Maj7/nRr1btm1+Cz06KWnypZtTmTiykinHrgxfoK6r01KQnsVghu3BSDdKPtQHHEDxnACIqzOf6+yoWRmGY5ids7wL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411755; c=relaxed/simple;
	bh=pam71S/q3brfmLgFHhm3OjGNc+Gd/rysVsROrFeD7DM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5iiuphpMvor/YjjKyVqxWOAiMUuFhvi0YEtdycR9/hVPH7rFt3/ZQ7D0/WY5bPlZRwKEDN5ZObHU1lsm5dFUT/1OJUSkFjrfGzDNcnEEVDFD44rgaKuuI4xLTd4UIAnt1UWVgKYJBZYMAds8oizWMD6xJcqDVEgPejFJUL6OdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FXJj/gM+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so78070721fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719411750; x=1720016550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7iH3JSmiJaSnX32RaYcorOWmDrnkufENWf0l16tdfQ=;
        b=FXJj/gM+dPwr36YLoA9RH2s5ulPFGvtAtkDgb/C0B4CannmhAZ5fdIYjRzV8t6yErM
         k789dkFTt1jgsPYx0faM+WEIX0tjbKuiwsWxZIMMw+SGbRBPVJXt+osR3hLZS+oB5ROz
         TsRKAerjfmetdqisxegsOvnoTiUAanLYnGNU+0nO/kBAgqSZCPE7aA+ZkxZhFHsy6uwv
         zbXCFrYPM3XS6kEqzqc90c7WpAfL3OnMBMe4ipPfBmS+yBsJWqwx4GV9bUjhTHYLLPjg
         +sk65klEtoCouX64vcSBAWAx8OjNk0N0ObNY/jp4v9M3CKu+NRyxfrPOVq+JC5wutvxd
         wdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719411750; x=1720016550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7iH3JSmiJaSnX32RaYcorOWmDrnkufENWf0l16tdfQ=;
        b=cyzLQjRJFVCmBQCJAyD8Hy5By1aLzpQmXIVeLL+25F4k+RUdSmsnbgKfCWHCeEnuZe
         +CaHunapbT82I8uolVGzumBTyvU7riV/Y86nrWFZPt5yxYBFvuToCxhM6ZrIcIW9noAr
         So0LMaJSlogFIn/xiDIPgi2CZWuG9UAa4UlY9V64EcRVGs2vB7UqUDQNMjHwVABFfHU0
         o1LKuj5m7nFWpkMmWyzUKfBbfZKkYRqvpKykTJasR8YBaPC5ESFXSxxe6hNW5TmRTyfB
         EpbP0Fu9p912EDMCvn+WBfxgEEQ02pJjCNNZ9TimvholoxsOytrbuILA7MtktAaYwPIV
         mc8A==
X-Forwarded-Encrypted: i=1; AJvYcCXDqdOm+URLStsxQSqAymELnt9V0TsbDq7h7udyRy26tpC/pSMIS8iVser7nHvcHgYhrocqPbuwptJUQNypv5U7BSrfS6huzFXGnj2i
X-Gm-Message-State: AOJu0YxwAT804GlWgOvbmh2S8j6iCGwZMlzP/zhg+7Tvd1qs/Ddz3Bi7
	FaCICCjVIUfNLTEQc5sCt3njAbZoKjg4TlT4eMXy3csmwfpgYGq9JlRIGjcEu84=
X-Google-Smtp-Source: AGHT+IHetDfsyqoRDtAkMQd5EyaDyXrcIZOcAmh59cPqxsnGl3jMLCu9/rXhsZFogKqN/Bv732PNYg==
X-Received: by 2002:a2e:8416:0:b0:2ea:8308:841e with SMTP id 38308e7fff4ca-2ec5b345df8mr57301091fa.24.1719411750430;
        Wed, 26 Jun 2024 07:22:30 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:7be7:aef1:af9e:fff6])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-424c823c28asm27141105e9.5.2024.06.26.07.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:22:30 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/3] drm: panel: add support lincolntech LCD197 panel
Date: Wed, 26 Jun 2024 16:22:06 +0200
Message-ID: <20240626142212.1341556-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset adds support for the Lincolntech LCD197 1080x1920 DSI panel.

Changes since v1 [1]:
 * Rebased on drm-misc-next
 * Drop vendor prefix change (lincolntech recently added)
 * Use mipi_dsi_dcs_*multi()
 * Drop the shutdown callback
 * Insert mipi_dsi_usleep_range() for _multi usage as suggested.
 * Downcase hexadecimal values

[1]: https://lore.kernel.org/lkml/20240625142552.1000988-1-jbrunet@baylibre.com

Jerome Brunet (3):
  dt-bindings: panel-simple-dsi: add lincoln LCD197 panel bindings
  drm/mipi-dsi: add mipi_dsi_usleep_range helper
  drm/panel: add lincolntech lcd197 support

 .../display/panel/panel-simple-dsi.yaml       |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-lincolntech-lcd197.c  | 262 ++++++++++++++++++
 include/drm/drm_mipi_dsi.h                    |   7 +
 5 files changed, 283 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-lincolntech-lcd197.c

-- 
2.43.0


