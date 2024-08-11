Return-Path: <linux-kernel+bounces-282255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B4894E15F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019251F2143A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98C114B940;
	Sun, 11 Aug 2024 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If7omKvX"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47C14A0A3;
	Sun, 11 Aug 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382408; cv=none; b=VaRU+ThDn3JReUC+A3r9VAaNfCF04S9lXE81gEqNm3/wYr7SAfsFQSguJOGmppxJp/+Z98ZgXW0FwR4+da3FpPefBeFJ4WsSRHfPWtsXdwBuGT/QbleozMSmTe1h8D7KWhal48W/5ZYVHsUBfAwKajFHWGN0ch3N4jfjAt2DDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382408; c=relaxed/simple;
	bh=xbuIwbVREaGl72WbclLoXSekNK6y3GPdMz3jKrtbzx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkaguzijUE0xCaoCfBZVXxsqs+BnDx8Ra0cvfBzXfLpb2zmkgHAGLfkqrTSWfHTnIfmGiPkYNtkAE/CL/d3KLQ/jnQXZlYFgF/RfbFJqky97FfaKeXtDjKxRQ0RybxrU4AyppA6SmJDULkiJ9Q0ZJw6guz7zkFkGIZiq6Vgmp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If7omKvX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3686b285969so1909578f8f.0;
        Sun, 11 Aug 2024 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723382405; x=1723987205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAAPAg6jwofzp+EX+VUUI1o/wD/iikXM2Q6rT6K+Yb8=;
        b=If7omKvXsEONEVRFjYTMY2sFrZm9Rm8EFo/tijLvkKdJ13KOtuVXKEUNdl6atqJB9U
         LkCF59d8MxNK2pCRtJHOPemget9jHSOYWCSPD4E7l7LGlqZ39j42P1PE86Xo9+uEk4Rq
         etUyf1pJ65BULI2x0HElANHuatskYLKM32dCq+S9lQqDtW1MVpPR5xjDhp3QmC3BNoOB
         fpRswzskLujOXGyNAmrdrtJJDSdJ0ofktM7aUHoyotjiaZj9KiGwdizNs+vx3Qc8o8JY
         qKbf6h2KNSyIKtBZJa2pmvXG0MVDuiMR3Ghci/aowGqOOANIoAMZlLUYU07NWEXf/HAp
         tivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723382405; x=1723987205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAAPAg6jwofzp+EX+VUUI1o/wD/iikXM2Q6rT6K+Yb8=;
        b=JFVRD27miyt0AQaoe6gg0ifJqmLiO7z1LqgpFMFecPWxwcTRTw1nqkGyGaFfL18Iar
         HpvirowJ80/oCbexbvNEEPWPbGGXkN3LWZo4RH0HAtKrWlPG844fb2Nf7TcPscLb49ag
         ZJ1Hr2F2xyPg7vw46n0Rk15uaw/CTU3hi6F99cbucjpCnAKIemKuA2YO/ZzO2+lQ/SDv
         0KqzL2+aYFloGesi7Qidx7CvYsXbFcPfF5n2ZQaKkc1+zCDq6UT7fIzVtNK/M/VfiXbs
         jyJECQOFmHoGx7hDrODhM/xsHaoI+eKH/kijPd/MzeBn2MV/eiG7LzkA5dR4ig7Ln/mN
         OM8A==
X-Forwarded-Encrypted: i=1; AJvYcCXZKIX+cplGahq8/JDnvXweN2YwphWqQJU/RT+l+yPVClE6A4sxkWH0K8/Rp5mskPtRVCGncti2imxNRPbAJNMIgBxcqC8h/fGM6xFB
X-Gm-Message-State: AOJu0Yx/205mIrO+OHV+rsQDJjgPVgUN9gbG3seCJyFhErpvroZida4a
	bzDEgSYYpEwUH02omtMGu7rtAxt0CIlvRDmA9/gwT0YkvMXQ+IIM
X-Google-Smtp-Source: AGHT+IHHXtqqZXb44TpdzuZYd+X34zxsoTJlYk1UUHNamaajGxkJbDQ9uwBQukZ6sFhGnXbsOmdLpA==
X-Received: by 2002:adf:f60d:0:b0:368:7e26:38d1 with SMTP id ffacd0b85a97d-36d5e4d015bmr5508152f8f.21.1723382404587;
        Sun, 11 Aug 2024 06:20:04 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36b874sm4959680f8f.1.2024.08.11.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 06:20:03 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 4/5] platform/surface: aggregator_registry: Add fan and thermal sensor support for Surface Laptop 5
Date: Sun, 11 Aug 2024 15:19:47 +0200
Message-ID: <20240811131948.261806-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240811131948.261806-1-luzmaximilian@gmail.com>
References: <20240811131948.261806-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EC on the Surface Laptop 5 exposes the fan interface. With the
recently introduced driver for it, we can now also enable it here. In
addition, also enable the thermal sensor interface.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 892ba9549f6a..4d3f5b3111ba 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -265,7 +265,9 @@ static const struct software_node *ssam_node_group_sl5[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_perf_profile,
+	&ssam_node_tmp_perf_profile_with_fan,
+	&ssam_node_tmp_sensors,
+	&ssam_node_fan_speed,
 	&ssam_node_hid_main_keyboard,
 	&ssam_node_hid_main_touchpad,
 	&ssam_node_hid_main_iid5,
-- 
2.46.0


