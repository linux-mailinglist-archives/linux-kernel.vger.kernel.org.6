Return-Path: <linux-kernel+bounces-336518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6258983BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77A91C21F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2874E1CFBC;
	Tue, 24 Sep 2024 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m6QWkVpr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343E718D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 03:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727149998; cv=none; b=meip9biH2NSnF70/YeXd/AT0ZXp8fUatqNnI4QHPZr5FDujJ75XxRTnlTzEZ1TVVe01dQc4aE/YCqiaKOZkHmwqNRF+txD2CWVJI9mhWiz6DijXFVjQS1h4QlUr0cBkDR2htEkpWzTf2RN84YaZOm+Q9sStqpeAY0Glspu6qA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727149998; c=relaxed/simple;
	bh=GQaf8wGm+ULoQ1uQTNj5pc90ydOZZoyjEWPipaZAzAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DR1gFt0tWIQyAv/cPKEO3/KKBi8ZqvzQTpsolThgZ9N2imZ+XOz0oYMWlKZYaGbv+8c2JHWZPXWAH9NeVS15Xvih4K5+Cjs7wAA4aTZPV9oLQB8A+v3XL0SmCdHvXmujagZ4SDq3L6qXIVESLSF6NGCW/Oa1lQoZk4AlCMQax88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m6QWkVpr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2054e22ce3fso49891795ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727149996; x=1727754796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itAoP6z6vkUpMR5lw63h40cd1DW9tcScRk+uvBsAU8g=;
        b=m6QWkVprUdkX3akcQqDBbQTQTBkb+KycA7ew6rexFA8IF51+93OH3IHaGBYHrrETvD
         cJLDfp1cdkak/0zQdjkpxBWiVVa/piGwNHWBEWNnIvWus4HlVH0TZMkBB/BVKA+j3ZBj
         8iVAewagAG1eW7i8+ArnJ2wmRULmR6g2R07BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727149996; x=1727754796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itAoP6z6vkUpMR5lw63h40cd1DW9tcScRk+uvBsAU8g=;
        b=J8AFy2krmHYEjqolwVJJpJ32EQkUk/D56ckk29BVxntv638W2SmFagw+0E8KgMG5dR
         INC1okQ0bFAIyJUChvPrMZKzEeWfGMYM0xPG5pwiXh854eUC3cBNVVqxh02gt9Y+R3M0
         WXrvntNaFtSsW4wEc/TAqrzFhuEaIoF1vWTYbztSLKTOiYJ2VBFGKHcV6M9jFvcDCV4j
         D6EffX4LKnUXG8QrP+RzR2xpVbkKiZgAhrzQNrT0UwruIZzm1jNMVeRLbgd8o+3m131o
         IBumxk5e/BV/lD0CgcOD793hl5n/IkPmKIgcG83u9eAraws6S0F3aQfKu1YiCelh5udE
         1ipg==
X-Gm-Message-State: AOJu0Yz32EMRywpZmWklaGi4WcpyaTsYRbVqjmBpZzmbaupwryWr2+/l
	CwK3YEPGWVu5avMPZTihezGUWks2dQHaBYcMu42LTC5CrasW07XtqHW67CqGpA==
X-Google-Smtp-Source: AGHT+IFky1LfGemAY/Su4SnOb/kwNfm+jkQA/oFjvASbwaAUL1I1hsKEb4eZXTg0Szlx4LIwBXJAJw==
X-Received: by 2002:a17:902:ce82:b0:205:7b04:ddf2 with SMTP id d9443c01a7336-208d839ac4amr227572735ad.29.1727149996583;
        Mon, 23 Sep 2024 20:53:16 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:727c:308e:bfa8:9ccb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1869000sm2555335ad.307.2024.09.23.20.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 20:53:16 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Xin Ji <xji@analogixsemi.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>,
	dri-devel@lists.freedesktop.org,
	Pin-yen Lin <treapking@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/2] Drop EDID cache for it6505/anx7625 when the bridge is powered off
Date: Tue, 24 Sep 2024 11:51:45 +0800
Message-ID: <20240924035231.1163670-1-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This mainly fixes the use case when the user changes the external monitor
when the system is suspended. Without this series, both of the bridges
will skip the EDID read and returned the cached one after resume.

Apart from that, we also observed a DP-to-HDMI bridge expects an EDID read
after it's powered on. This patch also works around the problem by always
triggering the EDID read after the system resume.


Pin-yen Lin (2):
  drm/bridge: anx7625: Drop EDID cache on bridge power off
  drm/bridge: it6505: Drop EDID cache on bridge power off

 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
 drivers/gpu/drm/bridge/ite-it6505.c       | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.46.0.792.g87dc391469-goog


