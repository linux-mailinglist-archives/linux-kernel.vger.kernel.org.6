Return-Path: <linux-kernel+bounces-229060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F6B916A51
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC211F21D05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128D316C842;
	Tue, 25 Jun 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FRb4xkr0"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB316C445
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325580; cv=none; b=FjZG6nl5ZSvsMFLIPm6zdnfef0/50CEwqe8lDN2saakoo+XGsm7uL3y3TwIu/yCN8XVwC242QytB4K4ky5eX+D7lg4qkPJnOK/YuFSsmDJgildylE2Nd1hQ0oq3oGOTGw+YVa3YPADIjpJ9HBxaYqn7K7OwcvCrdOvurm59yiXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325580; c=relaxed/simple;
	bh=LCSdddfJ7Z4mnK+aitn1PNeqaIztUYavzKGIhHHipts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vf/514UqSedOAIPJOn6Z22V3YUewEc1PTl1hwOtlIY2LIW1aymt02CTmJ1RQu9oMsN/QpxEH2K5JHs2AiRqPWEQCOoPR24nEqhk4VoX5sHadqoMHx+aA0GPCCDmyxFxeCUXoweNyF4VE1a/B1rhvNnEX6ed5Bnuor937Mj0ISiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FRb4xkr0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217926991fso48579555e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719325577; x=1719930377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nnbM/UqNU7kz2IjENEyTCA2M982ffhA9NZXJCqFpGNo=;
        b=FRb4xkr0a0LWth+QZtZh+hhgoP++LkDP8dRqhbdSTF2XYvREVzCpzPQe8foWX78p6a
         fx4Hui0/aK5If36o/KfaOjuaEkXUQyD1TgDC0kIklEVbgRt3Dnl2BoEqQnc/fvt7KM1R
         2tdM22LF2/ZVElbYmLhGEbwdc2V/e03xuThftC1mOpCxQGqYU6LQUGEzYx/c9HiSJVVp
         p5x5VjGEJhf2a29/EWkfaPQ4LU9WeiR94qpcoODnXLYEpl0wunPmsOhBu15ngKrG2TDP
         nLW4qC5hqcJruZRZfyC2VMepI0/nUVnHJj3phNCK7uorGmssLR8SxjAKcbmUVDvO7yPe
         drOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325577; x=1719930377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnbM/UqNU7kz2IjENEyTCA2M982ffhA9NZXJCqFpGNo=;
        b=SSw9sAN2EUv09jOwfc7NVvxEYue7UbnrPn3LLYLx7rfdQXwVFa5EYUsXCsEfC9rBrq
         GZ4gao3SKbTp+WwpSQkrlL0QgBpwKbq3HIr7DZpRnZEFzw+goHRUxDqbTa+njS4HVBiO
         ADNF2p4lXI5bgUmlo/usAN6LAjkI5kGwMX/8yoEpGdPiwyj9oIDwsE9WaIbAVkFvnwa2
         dwCjfZ0LbVUS1rbTe6m/cOlq6PHH/KbO1CnSFQgg0B38A1iBqSThOS8fMGR1PtszwvBe
         3Df1Ym/d/of3G8ZD/dCX5rggK7nJZ8TRJpaN79yXyBagrNSMHMkM0Q8WK+lBomAdI+y9
         wU1w==
X-Forwarded-Encrypted: i=1; AJvYcCXkXK79Gwhfhai6g0vsWnUy1QSOfMXet2oHQUJOOZpc0c2GdvRtek1jKPqDl5ZwReRNsCrRCrshyikYSc6sbTwxW+BRDuoeKxZvt2t4
X-Gm-Message-State: AOJu0Ywgxq5qCliKkLMvX9BrpEZct96jrcrnjx3neVRUq7tRr6B1JjeG
	EePnc6KI+22OXAKq8/yZeBSyFa5PTtbbZX/zFz0n7attgzUAHLdBIKuAnuyosOw=
X-Google-Smtp-Source: AGHT+IHBC8yMvfpBU0+onzKrlaDVCnHDVjQCoibye6hJmIGdRXQU3TAea+VE4GZP205tIEuuyYEmpg==
X-Received: by 2002:a05:600c:4853:b0:422:6765:2726 with SMTP id 5b1f17b1804b1-4248b9cb18dmr53858545e9.30.1719325576775;
        Tue, 25 Jun 2024 07:26:16 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:b30c:4c5e:f49e:ab33])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d211881sm213770685e9.46.2024.06.25.07.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:26:16 -0700 (PDT)
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
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/3] drm: panel: add support lincoln LCD197 panel
Date: Tue, 25 Jun 2024 16:25:47 +0200
Message-ID: <20240625142552.1000988-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset adds support for the Lincoln LCD197 1080x1920 DSI panel.

Jerome Brunet (3):
  dt-bindings: vendor-prefixes: add prefix for lincoln
  dt-bindings: panel-simple-dsi: add lincoln LCD197 panel bindings
  drm/panel: add lincoln lcd197 support

 .../display/panel/panel-simple-dsi.yaml       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-lincoln-lcd197.c  | 333 ++++++++++++++++++
 5 files changed, 349 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-lincoln-lcd197.c

-- 
2.43.0


