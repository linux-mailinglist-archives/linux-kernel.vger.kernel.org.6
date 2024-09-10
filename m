Return-Path: <linux-kernel+bounces-322428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F179728DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBB91F23D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761EC14D6EF;
	Tue, 10 Sep 2024 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOseYrST"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9391531E9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725945628; cv=none; b=ITJPPKdz0IbkDvF/ag1T3Q5J3gYwcYhP41Lzakyr9epuTqbxyIOPtqowf0MxLVOJJDxzl735HpjWKWZuN0Ez1T68vuRLFq8JSTwar58VHG5cYSQE9xWbzlmJdhys/C6UmjC/7LEuWC45SE66rnB3e4MN3LmyfF7BP7WWqFzEvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725945628; c=relaxed/simple;
	bh=7b0Rr88eNSzpQLh5K3UFKt4jOcdnPD5O2wg7rMP6sNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CCZhnZ4Sbsm/ThnACP6wKSJ2VWd1jkZ9XbMCc6jx9vHVhp4wOexy0i5xGWMUh+Kq+tPIESFDvHppFsotyXWoTbtlsqSU8CSjupRWWkWpGKHVudxhiHBT0jzpkUD+sCqu+Ye15N0z4nF9mqpwwDiQqkltQw1ztGLlfxWXQkdQ310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOseYrST; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2057c6c57b5so27961755ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725945627; x=1726550427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38ixz8H0ArhjT/fAPUPjglJ0fnVIDwgldPg04iXAj68=;
        b=eOseYrSTRjpKrvOg1Ptic0llBJx6JE3tOaboPsTNlKf0XWhtnraE0tR9cwA9a1Licz
         R307ZQFHkpykT6boyVFj5EC+FV08945E04TsC42Ge0qW4FLsQQ4jEByClH0q/aU10yac
         dbzyCWxeBAw+klyFeBPzkCaYENSQfAkmgUwPUrM7UF2gIVsQKa9LbbiThmsJulrxr3Rq
         +bR/coxIjRrK0Oj1nuaAAkwyLnrjUYlgo0TYmKA3WfsVyp0qBWYJXyGS28HDgc2UQW69
         AGkJ4wR6LwGHTC5+RELpGLwaC+azwM7RV4B8CBqzq4qMj4g6nHhEXJzSiKaAWyYNamWf
         9VZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725945627; x=1726550427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38ixz8H0ArhjT/fAPUPjglJ0fnVIDwgldPg04iXAj68=;
        b=ZFr+TbBxzNYEUcEohhc48bkaOfrwbPuIVnwQ4hGZ74DNfHigEweQotW0f0QlxYKh9a
         c2r38IiWdjD2SRq5AWLvH09PCO++fk+jVfJbvpjOd5ToRQ5TQ3YsB1nrrR942p0s/hEd
         FeAdfyx8pP4+GFyRalU3xi0K9SEB8bbhOxebjFVIF4Ai0u/YzpaApe5jUsocJdAC9gzJ
         paSHmn8pOz2T8UqJRdY7CAQC5wuroprf928qR5QnmxfKon4sbXt1Hmx6CWulEFhv6cwo
         RHayrawg5UdT55s2xZ0dk5BwB/jE8OkQRXijWM1lyUirpvKjwvG7xz2ZULnCmthEIozE
         1FVw==
X-Forwarded-Encrypted: i=1; AJvYcCVCS/HFbbsbPssXV5Rt6WBgulxi+qFpelWJScaODZlcUH08OgeKeN/3PBgHjxhgbkiONZVBEqpeUaYrG48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVSdsi96qldXcOlSHyO4H4GGSHqjR4H1sbz7JDieI69e8YHuYF
	kxlmYa64yJojZaCYAkQSdCHiJ40gpaMHaxosjTkedouBfEJjkEIM
X-Google-Smtp-Source: AGHT+IGu3Y1CcJmRFdUpSbd0OW2QBX0fNyuk7bD9zsfOdokX/bim2pYUB/hyYkbt4ewLxgurBIZ5Sg==
X-Received: by 2002:a17:903:a88:b0:207:2093:99bc with SMTP id d9443c01a7336-20743a2150emr28751155ad.14.1725945626627;
        Mon, 09 Sep 2024 22:20:26 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1e93bsm41288535ad.199.2024.09.09.22.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:20:26 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: Laurent.pinchart@ideasonboard.com,
	patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH] drm/gma500: replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi
Date: Tue, 10 Sep 2024 10:48:56 +0530
Message-ID: <20240910051856.700210-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi since
monitor HDMI information is available after EDID is parsed. Additionally
rewrite the code the code to have fewer indentation levels.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
index 2d95e0471291..cfbf3137e144 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
@@ -135,16 +135,16 @@ static enum drm_connector_status cdv_hdmi_detect(
 
 	hdmi_priv->has_hdmi_sink = false;
 	hdmi_priv->has_hdmi_audio = false;
-	if (edid) {
-		if (edid->input & DRM_EDID_INPUT_DIGITAL) {
-			status = connector_status_connected;
-			hdmi_priv->has_hdmi_sink =
-						drm_detect_hdmi_monitor(edid);
-			hdmi_priv->has_hdmi_audio =
-						drm_detect_monitor_audio(edid);
-		}
-		kfree(edid);
+	if (!edid)
+		return status;
+
+	if (edid->input & DRM_EDID_INPUT_DIGITAL) {
+		status = connector_status_connected;
+		hdmi_priv->has_hdmi_sink = connector->display_info.is_hdmi;
+		hdmi_priv->has_hdmi_audio = drm_detect_monitor_audio(edid);
 	}
+	kfree(edid);
+
 	return status;
 }
 
-- 
2.46.0


