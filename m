Return-Path: <linux-kernel+bounces-290910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545C955B17
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 08:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D221C210B0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 06:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609EED51C;
	Sun, 18 Aug 2024 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/XXAxsP"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA60CA6B
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723961309; cv=none; b=kvKpAly4vD3VJ6zOhnzlhhtWAVPUvU5mK0kWng0+Qk69q7WKwvO0ZvOw9ScI2x7/tQlLeD/Rvw/sYt+Xpe2k3LgsRxesgqYt5ZSIEdpNi88pmuimkb3Uv6usSYiqHqQtNaleNngbWVQfUTd0Jbv3DwzzpDrjnRieMTJhHsd4R80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723961309; c=relaxed/simple;
	bh=6XemUd95dXs7blr04QWlx/SWA1L71efejOPAJNSkYJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8c+XbxtaDjM545iExax6yg6OZJwjcMR5yKPD5QdoY1wAtf0uLmIKCRwFYJRD9Dga2BJ+xoqkRmoPPdNyGckNDT365A904dc/W+QS8KJjk1TJTEXzI5d07B7H6vvgPgvSF9IDP6OqNs2Ug6vpazhpDI+/q0IFSLsUpmTSdrhiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/XXAxsP; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-81f86fd9305so183344239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 23:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723961307; x=1724566107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TsZnNUNa74doCpaCcl5sTI+Cj3gu+bNSpGVWxycaCBA=;
        b=S/XXAxsPt0uv8aw6wkuClqC63fKy55amUMLqeBkpadhU7e5BtS52UOjxliOnhhzaRC
         TAIdEGkCurJX+5b2rLmxnNJvfNlRXJxhJjkLyycTV7PYEvGjpyMBtYWM5XlouB0zYYVY
         Wy38wN408iBWd+YqEPol9vPpxu11wwemEK63VPaGk34ZNl5FLh5Rw5mZgVAQKd7ZzkgK
         ETM1QRoF5nv+NmDlJApCiSndbXWZAhVs2RA6gvXVKPGN3wsvi1blA+pqlch6vZUaxNFT
         M3UqzyFc07Dfov71rUZikJshWrtxt/maihyE1FAlLDPVRN7s1mWVI9WnEikTm4JbjsyU
         8/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723961307; x=1724566107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsZnNUNa74doCpaCcl5sTI+Cj3gu+bNSpGVWxycaCBA=;
        b=X4XzSllXG5RjrJC/J/NJPeuLNKixGDcfSygPtgTChq0Qv7tbeuLKBJxl9hnUl/XqAz
         hdSAzegMRnK0S2g/FMmTlir/+EzFdoldHXMgO2OqbeTogKwwv/yVTr+oqCMyAxdHVeGp
         qQU8a+B/+oIrTKFc2K7Z5VSgeznXpSt39MklQhJ6UuAfNBEEAce/l86T1cYGEgCy+hPf
         g+meQ8qy6mk+xxHCKaD5/twr8y7HtuHPGzz8A/Rrue+xaUesijAUTnHORTZWuhuAZzIG
         43DnjeLvcvJnjejOfJKpseYi0bJTYWJN5WeHYwfFxIOek/ZO2HR89A14ci47C7eQ/5oC
         R3nA==
X-Forwarded-Encrypted: i=1; AJvYcCXQGCfQAEMOsc5ZFTD56QzU6lh8jCY82ef2MKPMYNKxPhOSU8ln3fUusMIQevOX9kck7qu/HK6l6sm1jvPr8luI18mZ377ZTT+zlWE+
X-Gm-Message-State: AOJu0YxrSnjFXxg3k77WBJnLWUr0QfSf1vEuRv3za3yffN/rlCuUIjFh
	hc2/Ef67rqA7/Voqh0UcJSgGZvGce5ElU/PvOs+rjeaZ67vlgIjS
X-Google-Smtp-Source: AGHT+IHCWNXE4N3u97vKsUqHD/HXszmlnh/RP8A6OPrnDdzp2otBIR9AWV8v+AcugvTcuVOyXb1PXQ==
X-Received: by 2002:a05:6602:1609:b0:803:cc64:e0d6 with SMTP id ca18e2360f4ac-824f267222cmr878514139f.1.1723961307159;
        Sat, 17 Aug 2024 23:08:27 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([2401:4900:6322:f541:ea23:e535:a48c:3c88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d4394e01b4sm236228a91.46.2024.08.17.23.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:08:26 -0700 (PDT)
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
Subject: [PATCH v3 0/2] extend "multi" functions and use them in jdi-fhd-r63452
Date: Sun, 18 Aug 2024 11:38:14 +0530
Message-ID: <20240818060816.848784-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds mipi_dsi_dcs_set_tear_scanline_multi to the list of multi
functions and uses it with other multi functions in the jdi-fhd-r63452
panel.

This patch uses functions introduced in [1] and must be applied after
it.

[1] https://lore.kernel.org/all/20240806135949.468636-1-tejasvipin76@gmail.com/
---
Changes in v3:
    - use mipi_dsi_usleep_range

Changes in v2:
    - Fixed return values
    - Removed extra error messages

v1: https://lore.kernel.org/all/20240810045404.188146-1-tejasvipin76@gmail.com/
v2: https://lore.kernel.org/all/20240813062912.467280-1-tejasvipin76@gmail.com/
---
Tejas Vipin (2):
  drm/mipi-dsi: Add mipi_dsi_dcs_set_tear_scanline_multi
  drm/panel: jdi-fhd-r63452: transition to mipi_dsi wrapped functions

 drivers/gpu/drm/drm_mipi_dsi.c               |  31 ++++
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 149 ++++++-------------
 include/drm/drm_mipi_dsi.h                   |   2 +
 3 files changed, 81 insertions(+), 101 deletions(-)

-- 
2.46.0


