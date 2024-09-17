Return-Path: <linux-kernel+bounces-331295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E98697AB09
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221B31C27575
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22777155382;
	Tue, 17 Sep 2024 05:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="c2zq8LlT"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005314A4D6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551123; cv=none; b=DC+j744dqEfU6Gb1ylwkHyK3gKZXs2pNG6kkDGLr7f84Llsai6Bh8fbYdtgO5XjOx5amkcYQlBVItsp0DLjsFEg7XWa4HYWDl+O2Mepiy7t1Wme8+QbJfwO7wjvCeBIMJRx4bNToHEuHS436FTOTaWgAZSJdh+9hFu4sEelrqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551123; c=relaxed/simple;
	bh=sZKvR71ldawsze0JADOPuPZo2EgNqxkqX5a28FxyXJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoXE7HO+2fR7Xq0Bdoj3DXfBK7OGEMb4AVaP7MCYAQq45E/nzpON3J4Ei0r3lTWjMZMx/p/Uk/V/lwIjM+zCP6nI8cqZCu5AaIB6iN9nExPHOYGokiReoXWZt/ocpxkU2qcv65pby/xLICcoQszuDoBncsjOoD1WvO34rPdEqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=c2zq8LlT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so3348395a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551121; x=1727155921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pue5cYUVUdCVtWaMNLqOU5DyP6NH1weXbYhUzVPJXbo=;
        b=c2zq8LlTzEZ1f6OuLCncl9ZYkyw5KqZm1q9V12evcFNt17ZlnGisiWsCZ4xnf3TmP6
         z0EhIvjzzZU1qJHSG4h9DDYJFnMZSD09Ixs+dj+k8B/ZyBWkdAzmd8ZnqVhmqSq6g4+m
         YhWcaDd/fqrHWO4b3P5tQhPxxvtLy/VFmwPeSjzJ9PAn38EN/vT1GtuNrg5Ux7SQLWhG
         ynORfkFFokFKvlba+3qlBFcDnGKOliJnxn57s7jSexoh9BBQrfVJh6N+TRX2g39tPzdB
         PL7M6aCvg43IWGAUBfXom6cnHQdE981xSMXQyPjtLzItoU9zq3kOfG1THmSbrsaRb4og
         +2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551121; x=1727155921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pue5cYUVUdCVtWaMNLqOU5DyP6NH1weXbYhUzVPJXbo=;
        b=cg2cu2jaX4u4hpG0ZpGuHMxh4nYGBQCxVkc6gLiIcGT3oiEYYoSqs0q6RUk5xetKFK
         1HzqFCyCbrTjM05ozU26LD9EHHW5RVG6kbXnEIurjle8m/eSPXcOU+3+h+qzcZ0UZaYC
         eMGz9rzpJvdu+qh4orAIUDujPjqwebh0y5kuOTMSP633s4taobXZOhyOppqxcBNXc7qA
         BpGo0rikmlMvbeuRQqZfyXkDwdm7nyYR85g+Z5B2JlcCQb+uelqLhb4FOOWywhk7CV3E
         69xNYG+hCAn3yPzusWbq8X5g6jZLqJhKVWvrU8yPnCnyChiYx9m2jFgCYZeVJ/bItfkh
         y4ig==
X-Forwarded-Encrypted: i=1; AJvYcCVDDbYs+wC9XB+NTXbOS+sLzjchrYDCUEurVGHyQ6IOtan3rA1CO7m47YvIIuXt0HCPQ44bau+nnqeGIfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLiKXzsNYJbfWj56Shgyc0clnMZmb4GMIRctDzszbp6bzaKpg
	0K9A4FRhd/w3IzrZK3q7KPt01z+MzNgLNi3no6oTc0sgnB7Mf359XovBOa+m3ic=
X-Google-Smtp-Source: AGHT+IH5imF1uaZ/NVYxBzjkFnbv4gJE+ngHUSuhcwjMjG06uQ0wy3S0dV8vfB8JzEj1Hz4kqRYfJQ==
X-Received: by 2002:a05:6a21:38f:b0:1d2:bbfc:774b with SMTP id adf61e73a8af0-1d2bbfc7bfbmr12305115637.37.1726551121245;
        Mon, 16 Sep 2024 22:32:01 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:00 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/18] Staging: rtl8192e: Rename variable FwRWRF
Date: Mon, 16 Sep 2024 22:31:42 -0700
Message-Id: <20240917053152.575553-9-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable FwRWRF to fw_rw_rf
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 8d645d3296d2..003343e75f0c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -613,7 +613,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 		priv->rtllib->rf_off_reason = 0;
 	}
 
-	if (priv->rtllib->FwRWRF)
+	if (priv->rtllib->fw_rw_rf)
 		priv->rf_mode = RF_OP_By_FW;
 	else
 		priv->rf_mode = RF_OP_By_SW_3wire;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index e9ca5a8768ad..c19522885d41 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -747,7 +747,7 @@ static void _rtl92e_dm_init_tx_power_tracking_thermal(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->rtllib->FwRWRF)
+	if (priv->rtllib->fw_rw_rf)
 		priv->btxpower_tracking = true;
 	else
 		priv->btxpower_tracking = false;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c6a9cc0b2760..5db03fe9269d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1371,7 +1371,7 @@ struct rtllib_device {
 	enum fsync_state fsync_state;
 	bool		bis_any_nonbepkts;
 	struct bandwidth_autoswitch bandwidth_auto_switch;
-	bool FwRWRF;
+	bool fw_rw_rf;
 
 	struct rt_link_detect link_detect_info;
 	bool is_aggregate_frame;
-- 
2.30.2


