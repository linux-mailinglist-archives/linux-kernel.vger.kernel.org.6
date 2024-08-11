Return-Path: <linux-kernel+bounces-282253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0394E15B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680A7B210F1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4A11494DE;
	Sun, 11 Aug 2024 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3KvJ8EE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD731465AB;
	Sun, 11 Aug 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382405; cv=none; b=tkKj3YqGLiQ+rJKvtycnaXhLLMFmRiMFBLnTqA8cUlc45WRqPGIz8JTDqxCTxIY5vzzwV+CMvh/1tCXiNOfB6cY+E7cB7DprtXOjxTrrRDHVyRNKJyiRHEsvdry2AKXUa36QWsUKeSWkwYUhC1pOQywfYn4cagVElH/ni8eULLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382405; c=relaxed/simple;
	bh=vA5/9/uP7eBB9B0pLIMbog/FOY8XC4qZn48QhFQsx68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR39QNDzsm9SWt+SX9UmfxxnKKjZjae87FfqXZyieHxuzHTEIS1iLyrVYE22WfSw3YO4ah3e5GYGh93mGBMMKXH8ROvdfrkAv+qlfzbDs9J4tMV7YOXVlR5UmrdTzuqjZz2Ze/rQKr1k5Uh9JPyaujffsnsh6CQ87e/vHH13gnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3KvJ8EE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-368f92df172so1755745f8f.2;
        Sun, 11 Aug 2024 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723382402; x=1723987202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dCrBNLYmwX5V9ZbHrmIPhcLnW58bQ6DGA4qjJjOg7E=;
        b=K3KvJ8EEKUxwU84RpP6AcNcdkgHGK1CoIvX45ZEkEHSU/1AiKA7VJjsK21ti0SoGPN
         lCd4sA69UqxMSefB6hZ8Aq4/aEX+M/HYslGnqUzewW8kRwFFnYl8w4hjTWyjCFE8Qyb6
         ATCpiKZIxSGViprhvqn7As5ctv07gTZwFmmY9vqQqAuwx/WCaNSO93NBggjc/OC6Qgra
         dHUoxXI6EhTy68MENT4khLhIOU0uqHU1DswQH9tn1GvYNUM3wUI33vAxGaLCshLwP6en
         T5MYWFDmVTchz+WcP/AwFPl3vZoZgSrYejPRqdVRODf6tRMK1NgP/+f7IA/M0Cs5kPQN
         yJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723382402; x=1723987202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dCrBNLYmwX5V9ZbHrmIPhcLnW58bQ6DGA4qjJjOg7E=;
        b=izdNI9RMaB5SkdxN0vtQNO3OmHDhOXhnzE+Ux5X9iChiNko17eaJcGH9FyZ8gg+veh
         85iIGZWt3HOtWnSWITU1LBeupOwzKvolst7VaU377pvgptzPXZJGYUNcnRVUYt2ctFIW
         sHZvo2L0NCI+zCG2lKZgIk8Ge+M5S7MMrtCtwu+SUS2k/HIbsB28JfgiUN7RKgIXGpfT
         whKojI+yk/gK+DH91aB/wDhbRI7dP5zPfon/VqzFCV/IytWg7V/OK1Oa4eBiI/pQpFb/
         JadxJ/ib6QbneOayYfGmcq0kH2pV0g3ai3PX/p1XqgcjlP2WsC4UujFQGeP9b2yCHM0I
         mVpw==
X-Forwarded-Encrypted: i=1; AJvYcCX2lI0Vjv/6qkmqYkwCHgnMnz3apxYcvFSppTcjKEcTGryP4mmLPtBvKRq42Dfifz/sKP4YfMJDTmN7Pn6SmpaLcU3ViLelHK4kn6q1
X-Gm-Message-State: AOJu0Yx9QFOAd24cnte5OazzaCjGUM4CFFOfsnb+J6dX2D8/CdxMHPQ0
	mUF2MJvNe9ucIRS/BUhUA6DW7Yi6gJE3U890LHztur/y7X3dmczf
X-Google-Smtp-Source: AGHT+IGYGUow80wFKt899xNqakxLmeqPlyvGf8420I39SDAMkf/bl6S5KOHQcyXWWjHRbrD/M6RgRw==
X-Received: by 2002:a05:6000:1542:b0:367:8a3e:c127 with SMTP id ffacd0b85a97d-36d60c169b8mr4425825f8f.63.1723382401868;
        Sun, 11 Aug 2024 06:20:01 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36b874sm4959680f8f.1.2024.08.11.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 06:20:01 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 2/5] platform/surface: aggregator_registry: Add support for Surface Laptop Go 3
Date: Sun, 11 Aug 2024 15:19:45 +0200
Message-ID: <20240811131948.261806-3-luzmaximilian@gmail.com>
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

Add SAM client device nodes for the Surface Laptop Go 3. It seems to use
the same SAM client devices as the Surface Laptop Go 1 and 2, so re-use
their node group.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index fa5b896e5f4e..4d36810c2308 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -398,6 +398,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Laptop Go 2 */
 	{ "MSHW0290", (unsigned long)ssam_node_group_slg1 },
 
+	/* Surface Laptop Go 3 */
+	{ "MSHW0440", (unsigned long)ssam_node_group_slg1 },
+
 	/* Surface Laptop Studio */
 	{ "MSHW0123", (unsigned long)ssam_node_group_sls },
 
-- 
2.46.0


