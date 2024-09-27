Return-Path: <linux-kernel+bounces-341556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F3E988198
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBA11C221FB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04161BB6A5;
	Fri, 27 Sep 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="qiGcnj7i"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4B1BB68C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430236; cv=none; b=keNItxgG/5aeF2cmb6w048q9aQB/UznP+RDBOizRMUgFlH5+STa1x9PyYtYjF/BQ7w3sNER/k31/gOvmJ13v+QSPzZOOd3voRDXk8sP92RjRRQYWfxcZZOxd/euoakpz1mpqZQf+VUW+r7bj68YNMQ2k3XVNaTwRXBfYAV+A/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430236; c=relaxed/simple;
	bh=SZ/WjC1lIsk4JRRqJ7vEbvQWyYdy8NWTG6kVixPdzTM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LEjO3d7BtZkWTzLk4frvXcTS0Z5+6wDSGE/YVnJo/q85/Hv5Ued5txkCpGHorIGBI8lLwwQ+2Qfev29ix9PT4Y1JOHuvXpor84gnBkXaVeKbZAP7LCNdJWJ0XwqmymPdEIpOjJA3kNlxAB4iARqOXymNqOUJXukLtYMRBa8G5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=qiGcnj7i; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e08071fcd9so144046a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1727430234; x=1728035034; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+EfgAcgWmuWiqbNHjJcsLkV7bQteBK+Xb+kdKI2dEA=;
        b=qiGcnj7iTyKcf2At3K1KhONqwRTNKkkSQHnxqJkFWyzGleaSB44xdh03eGvKjqxNTu
         LwQzJgb0W75bfwjDMREG2xlXL4LMDonuxriwDK44skqxO2YZ1mlI+WCJzify+UYlZiCl
         XIVvEkCNlX1wcbcnM51oBzP9PPpj/A9ELeAEeF8ZBlx1+qbGf+AXgXV88YgBDVHEooe7
         WJ8G9pN4rKDe+NVxsZSY5tVVBmfyzUdjhOx9Ise7nbOg28B7GBEY8vDb7llCPtVDNX8J
         NGUak1D5m6wkTFu//Sio3HsFcydaAp7OfvO7PYltIyGmN732+50EEhGlxT2780p+Fiwz
         PS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727430234; x=1728035034;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+EfgAcgWmuWiqbNHjJcsLkV7bQteBK+Xb+kdKI2dEA=;
        b=GRwM9MuRKreM+FpMDPBknO73saAsCSGNH2uVx2SkfRF7ymjFdITk137pgAkWmck1TU
         fRE7aiKoFeIZjbxmA1wc7tcBTU1rQX58+WZ9152mozcUEPq062H5n9a0BTz+fUstuGXv
         AQdBoxU8jGThTEcdLI51OjPmACNJQ7frNAyPUF39qcxJp+OS0nMBEB+XUmju9J91muTj
         c6VtFbfBDLEHNY7sBV2QijsiAw6CNlni5E7AyzZVkGebgiPCYnFF7/KrC9FePjsKpSWS
         91qcD/8Q1R3WjBeIlK0NMDFsFdb5/hhw9UgBD8dIkkihsWdfBkhIMR1exmEU5G+kSGus
         yRxA==
X-Forwarded-Encrypted: i=1; AJvYcCWS+0QO52osm8yZW7clm9Xqy1JB3QTzqxPWxXaToDUIXCPvJGhjx5YOXKJk1+hpAd3dzuThXXRArWqV3x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylLSEdlrLVahVuQ1ohBgKR4TJPiuFdOQ0EHS4/IVBRpa3LR09e
	eZibWVLX1BOhi9nK1I5b7aANV8mAyUqhFK8Fup6BfjpKlM+Vp+/w/EX5NWBbjxQ=
X-Google-Smtp-Source: AGHT+IH30NwnGAhwR7roVzndyBVM3XwwjJV1ZHPSohbZoxqPt652ZKf6bv+RWhQzpm+v0Np+G8T7Dg==
X-Received: by 2002:a17:90a:a78a:b0:2e0:876c:8cbe with SMTP id 98e67ed59e1d1-2e0b8ee52a2mr1300086a91.7.1727430233845;
        Fri, 27 Sep 2024 02:43:53 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1bae46sm5105895a91.22.2024.09.27.02.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:43:53 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dianders@chromium.org,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 0/2] Modify the timing of three panels
Date: Fri, 27 Sep 2024 17:43:38 +0800
Message-Id: <20240927094340.18544-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Modify the power-off sequence of the Kingdisplay/Starry/Melfas panel.

Changes between V3 and V2:
- PATCH 1/2: Modify the commit message 
- PATCH 2/2: Modify the commit message.
- Link to v2: https://lore.kernel.org/all/20240923134227.11383-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
- PATCH 1/2: Modify the commit message 
-            Modify the value of backlight_off_to_display_off_delay_ms.
- PATCH 2/2: Modify the commit message.
-            Delete the value of backlight_off_to_display_off_delay_ms.
-            Modify the value of enter_sleep_to_reset_down_delay_ms.
- Link to v1: https://lore.kernel.org/all/20240915080830.11318-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (2):
  drm/panel: jd9365da: Modify Kingdisplay and  Melfas panel timing
  drm/panel: boe-th101mb31ig002: Modify Starry panel timing

 .../gpu/drm/panel/panel-boe-th101mb31ig002-28a.c    | 13 ++++++-------
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c    |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.17.1


