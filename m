Return-Path: <linux-kernel+bounces-276364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A7949280
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531231C20E39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E50205E0F;
	Tue,  6 Aug 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q910Dg+C"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB4E1D47BF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952817; cv=none; b=VVgL8JaI55P7OYy+iJXvjiEsDSxSxQMB82K0i8btjO3Q7gOq1dX4jZSHKO+DOCypIw9KAG5bGDvY6QKkqnZR0YD8TwmUZPvBP7JrHcBIhw4V8J6710a5Czj5Q+Mvzt3ZOTbY0MyNOEaLlHbWfWKbpcUfhDaVtVM8f1XTZXnDTxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952817; c=relaxed/simple;
	bh=J3QnHFizbAThjV/Ak0PxepbbrLgm3JDMZPRvb+8Gt6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uoWNecHPbdwOTrV9xYImpLbjL3XyChqMgS6ho+s/Lf8Nf9wY629DVbypRyWTB+jmutIwZyjT7EpHPJuYl+NDLJXrX4Gg1X7zoKP/n1Q3SodBwXUg+ls0zW+iYy8hfwJtz1eI33Swco0AmgSBweYQmng8S5pb/WLHByftcgzTLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q910Dg+C; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso525487b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722952815; x=1723557615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/rRqO+TD/clunwejOFWYg0tXtD2dZ47q/KtEadlmnI=;
        b=Q910Dg+CyddjCECl5erhzw+Pz6yDbMiEQbNnPQRVquuE2X9mTAXimAOTBW/VenQhSk
         5VqF81URaW6BEWOb0vcovb/BzKL2ilhRLcSKnVSlQBVMKIoMqihwWO8Khb+0sMp+B2t/
         6btFZKbI8n1MypcJj0ByxLGyB/zE2SOxU0AsRCLmY3rTBscH9U5EHwQchBUwylQG8eIC
         kM7Hmm5xiHJJgYroVmFSxIKOTZZJutk/R0BFwELr38QzxAIeNY+/KAZM+qwVk3QI4ab6
         9nW/GCOcT3fmN72HkhSp3FtnCWofJNj92mnQDmGHycsO7tBburn7n12ayvlONRedLdbQ
         J1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952815; x=1723557615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/rRqO+TD/clunwejOFWYg0tXtD2dZ47q/KtEadlmnI=;
        b=qoPH5nLHk2f1k2ECz2wJC1yXVds+8QX2iGxoGBKuVaEnwoQkIjsm0HocZ4pwtXH+SF
         CI378qhErNaTq3vsCezpjryhfEKta9g+HtIpmK7Cd1c08UBOS/tdKcKzi9SgyK98MRH6
         5NWpxFsIP66MFP1FxFoq5ecWugmiLiO0VNSVyHgeoKPhJ6HB00ORQfZ47HnVd/gVZG/b
         Kwv/b/96ojBfjlPnFr8zacWd69rhDQVgHKT9jFDSbpS1+xiwcP8ko4Ovww+AmGyrUyHg
         pev1NQ7SJRuzljoBS3SSYbpKRfoyd9iBVCW+zmrTmixpt1GoUFm1gAZIKT0ooSs6Yv/y
         5vjA==
X-Forwarded-Encrypted: i=1; AJvYcCVOJavqlhyzfssVrbJN3LmkS44lcZHH6ilsY0ToLNLgofTF5FKQGyeIlQ9c+2IEnx9Tx1xy5eAfACnXYzpuT3F2IKlPV28OAM5/dMLP
X-Gm-Message-State: AOJu0YyKhQ2dd0ntiaiCfaUC35G3INvzmHZwmpvbmppSj5SSfKUPyM3x
	DbALAnHuPDGpwOOYtGsK76ZoNauUccXoZCYexKDkeiHTOi5mvum6
X-Google-Smtp-Source: AGHT+IHZeNN3cg+Jxj3sx/33KxsUD/ghfNrYFKoaO6S9lGUHf30kNSMQohmWeyYOuIOqoZgLCuzOkw==
X-Received: by 2002:a05:6a20:7484:b0:1c0:e9dd:1197 with SMTP id adf61e73a8af0-1c699589cc1mr16798510637.22.1722952814667;
        Tue, 06 Aug 2024 07:00:14 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b8a7453e92sm4415203a12.41.2024.08.06.07.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:00:14 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: dianders@chromium.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v3 0/2] add more multi functions to streamline error handling
Date: Tue,  6 Aug 2024 19:29:47 +0530
Message-ID: <20240806135949.468636-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds more multi style functions and uses them in the 
startek-kd070fhfid015 panel. Additionally it marks the older functions
as deprecated.
---
Changes in v3:
    - Removed mipi_dsi_dcs_get_display_brightness_multi
    - Unmarked mipi_dsi_dcs_get_display_brightness as deprecated

Changes in v2:
    - Improved formatting
    - Rewrote hex as lowercase
    - Marked old functions as deprecated
    - Added more functions to transition

v1: https://lore.kernel.org/all/20240628182428.171031-1-tejasvipin76@gmail.com/
v2: https://lore.kernel.org/all/20240730060659.455953-1-tejasvipin76@gmail.com/
---
Tejas Vipin (2):
  drm/mipi-dsi: add more multi functions for better error handling
  drm/panel: startek-kd070fhfid015: transition to mipi_dsi wrapped
    functions

 drivers/gpu/drm/drm_mipi_dsi.c                | 194 ++++++++++++++++++
 .../drm/panel/panel-startek-kd070fhfid015.c   | 115 ++++-------
 include/drm/drm_mipi_dsi.h                    |  10 +
 3 files changed, 239 insertions(+), 80 deletions(-)

-- 
2.46.0


