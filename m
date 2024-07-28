Return-Path: <linux-kernel+bounces-264567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C56E93E527
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14921F21B2E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D6854765;
	Sun, 28 Jul 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7UP7Qvg"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0824EB45
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722170873; cv=none; b=JEcXEiht0fm8hmu028pigOrdbKe/zzJcNZd9+yxkg2hWMFxaSspg+uuzYQYqDoZZ54nBjuOlO0ilaNgctl80gxG8dhYpiB+ZG+tH5wBEidkXT6zhx/vOlY+hJZkTyqqUGEV3q/YX7bYIfL5MF0mNJSI4sOVd/IQP+TrljYdl/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722170873; c=relaxed/simple;
	bh=tXNikjiIVpkAuO+YtPShzcahdAqHXly5hwP+VTqWocY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guwtWFc6h5QKUh5QP1rgmH3JjBkYVofceFcK8Nxw4cETMe80bTJL01M0L9Lctn4cb7icsTxhLSUU6FtOSgvBJHQLB4cdsUaBYCl/ZnmLuKkCwMoaWo2WfYhSAwGJ9EtgY8AY/sFecHbqhf1vjeRuRpMIjrbb9lBra3vG5VZW1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7UP7Qvg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aac70e30dso355147966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722170870; x=1722775670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Rz1Sa7FCJDcDDRHYUxSDE566aPhABjKPXfQVVOA3+c=;
        b=i7UP7Qvg3mozy4VMKTNr/mW11ACc5jCb7bErPWl3/KWJQThfqRAWvm25672iAAVF2B
         bBvpYubomJvA0M8WIU44TvVHPdJzncd5fJBsl36Xr+NmizieL+Q5qRLqPKaFNII4R07t
         N+E7EuvrS0Bd+rEUAs0BNCBwqu9547fVTkGLx9TMfpNMh7j6T4wFElfCbktyvYCo6Jtg
         40E6eYqvkIyDDY1ekcWbmn3Iey5f1h2kBi1WqEOZgpH+Oq2XxyY1Ztr1X7BFqonrKlY5
         o6r3pLMf8PTUcuf5CABsLXaIWQFH8474rC4OeqJETEi9r6Aya8uTbG4D1CH0aogyrn01
         ynxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722170870; x=1722775670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Rz1Sa7FCJDcDDRHYUxSDE566aPhABjKPXfQVVOA3+c=;
        b=GQDmXKeyWknGNaNFQ1qv0P88MFKD9Z2fbHI+GMgXIxpiVl9HX3Q//8sAL29R7+4Lwe
         EjOL76z4v/KzwBvKnc5Caw2sL79fpcQMVDX0foTtKQsapH0RC53y1dBAV/6SFvS4oTN1
         xoQ2v6MqRK2crA1tEmfsFIjBc+qoue+7FPamEUQeToL+oj6hsBVrJBVS7yVi0oVEJLLO
         xi5LqnfkQHrpOxi2EpoAQKPTPrbJOsQoB2WLAuM4Vb3jH562J4QgBKHlgHvI5N0rZ54K
         RjsjdowL6NimmjpSx94qFazKbDogZQYcw2OM4XyGM60Rix/Nh5PrftNJNiLmD12u7+3z
         arAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNvD5UVHExdr3xn3RLcLhvOC1msooa9SwnrIuOazmvbK8uQOQ24CPr/0xfk0/51cb1viAd39SZfmJVhpO7/KrASV70t6biqCQ0NTxi
X-Gm-Message-State: AOJu0YwM8w8cWErhR2xV1pt5qRTJYhATvoRli2zq/EwwU3vWFgGVz3HI
	W24KCD6PBeNNGzTqGwqhvoswHvjfzyJPe+0zHuI6cFtz3cpvTyaMj7TTBYO4
X-Google-Smtp-Source: AGHT+IHEP2W4c4cuNq+677hX1/5oKQxE9h9C9dsqXF6zLDDzYSj4m2N672LJ2VpZFYw/WZ4yBiHy3A==
X-Received: by 2002:a17:907:1c19:b0:a7a:a7b8:adae with SMTP id a640c23a62f3a-a7d3fdb7dc9mr451783866b.4.1722170869976;
        Sun, 28 Jul 2024 05:47:49 -0700 (PDT)
Received: from Slimbook.lan (134-248-201-31.ftth.glasoperator.nl. [31.201.248.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9d3cbsm381125166b.182.2024.07.28.05.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 05:47:49 -0700 (PDT)
From: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	hdegoede@redhat.com
Cc: mripard@kernel.org,
	luke@ljones.dev,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
Subject: [PATCH RESEND 2/2] drm: panel-orientation-quirks: Add quirk for Ayn Loki Max
Date: Sun, 28 Jul 2024 14:47:31 +0200
Message-ID: <20240728124731.168452-3-boukehaarsma23@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240728124731.168452-1-boukehaarsma23@gmail.com>
References: <20240728124731.168452-1-boukehaarsma23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add quirk orientation for Ayn Loki Max model.

This has been tested by JELOS team that uses their
own patched kernel for a while now and confirmed by
users in the ChimeraOS discord servers.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index a1dfeaae644d..0830cae9a4d0 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {    /* AYN Loki Max */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Max"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYN Loki Zero */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
-- 
2.45.2


