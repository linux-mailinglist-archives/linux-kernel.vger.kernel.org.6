Return-Path: <linux-kernel+bounces-530742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE972A437C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7571892EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E26E215F7B;
	Tue, 25 Feb 2025 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjaVFsXc"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B821576D;
	Tue, 25 Feb 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472457; cv=none; b=KtA/slHnv7/JurDrX8hsL0TnKsRj4SFq9aZyON+dgxFJftbbmnSiZvgt8cwAMDUPrSCxzycHdlsnKASHvSRymttgEVX9vBkLZvbzZZqmJK2kON+afzsPinI71gREFgXDtHjUKzNh6/z+bFNZ1CQ9D3cSSEW6JgAkAejjMu9aw6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472457; c=relaxed/simple;
	bh=swswjDwwHPx50kTtVC4IOrrP+hwyuhn1kLJk7SNX+w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1sPFv5/cJ3Rb28mn36a1f8MAqeAxNuB6LNLSXTMNo4KwTHami0pjzdFNsxGcXqx7N6HH6pf31JlXpawCZ8KJRsdQBORU094IiVJC4WJKfBjH/jt1MGNcyp0ZnPMFMRPSjkaOb1E8KhoIipO1ROJ3SKVbGjRGslwxPd0SD+WDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjaVFsXc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f378498c9so5150709f8f.1;
        Tue, 25 Feb 2025 00:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740472454; x=1741077254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAie+sSFo6Wruq18O6QZqBe2ud6CsbFB0wWs2UuJrRc=;
        b=bjaVFsXcW8B5pI0JhaL6SRKbbx6oB4ogGKtHZonl9QCNIGPdbUa9FjfoTKzSxmaBlj
         c20/XXXlnic8BzYt9m866GZuHuWzum6mZwZeHFXlNWvKVTe9vJ8S6jFUD6rt+EGQQAye
         zhL3Og803vO1o+1Rhe6tfpz09okjr85JAL0wW/tgPizQhYeQE+n44wqcKfjZg6JtDBe3
         wT2xAlsYicmD7wTLYbErUCrOsLR3IoKo5zYQ9k7AxGdbPeK6/9t9hm1ozb8+CD6ELqCw
         qnopmR7dySrUaNHXswhCXPj8BnBSnA21w9UBrL7EGoRte9NbCCw8t79xYRQKr1kJXiyT
         K+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740472454; x=1741077254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAie+sSFo6Wruq18O6QZqBe2ud6CsbFB0wWs2UuJrRc=;
        b=YC4I9oLIGpd7ygQOq0Zc+aEQ0qjp9NMy+Vw5RCnj3vpxtR/4Jm/M5wKv8qn0OzYP2o
         tlo2VfiveQlO4qlBVZz0hb1L50XTRr3bOQaX6yqHjYUP1Sh3Yx3ECl0vJd7L4RYaGIKt
         1/ksOwdEOuHElPnhPOVDhQ6nMhnNEL4ZD4GeEVAzpVEFVlDI18Z0knzzTpu94Kou1U7/
         9y5V3iKqs6DfwCmcJNsOrSuV83iq5OhRloedYR/JfPqQFN2miRqR6bHVBZDknYRQb5JE
         4p94Fm+duGjFk2wv23WBWEOoryicJ6UnWKhu3jdwEUwz2uIeJbVr9zUFHD97hm+MU23p
         GB0g==
X-Forwarded-Encrypted: i=1; AJvYcCUmVfGvSCwHJTPAgYaabPA/tb08cBsekpqF+gO5l/irEnovWuGSz3aLJv03tF6xBAB3R+aEtxkYa7YA@vger.kernel.org, AJvYcCVAxwavJ3/p/M8oOL4YTXA+XZqL+SeVwOTnD9b19p2YZCfwRDIrgyFpHkWKJKabWcFH3WkYTlXcGqHEHITQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQzTEb/op5HoISiDqNFFncaZ3SdN+sOCLBvTANhcu1Uhy7CpL
	7qZ7og2KXYBm5xhygZHRAIGq7ihaYj9EkBqm8oSlW/DxaiiP5H4W
X-Gm-Gg: ASbGnctf8tc+nH68MOuKrtimo64Phf+E6n+BlfxxEAB/nQgIrXMMZZtOaywHWThnkxb
	YQXs5P6C5vNCuBP7vYPznZChFpUCPFGqMHF92QyazZCt19Oq7WrPWZpJ2LOvBl9jTPvbETzo6cC
	C6TlwLtBuHVxX3n1DT9widjxmyAlLGh0pDsOskT4FtR9sNwVwuEktJL99eGLcETBf3SZN+g6Sr5
	VezZxn3ZmuHGhkyMCWU94NpW9cpvvvSLky6I/LabiRapzWK0yLARvmWPRYLKfnRED8c0zsmjxv3
	gEdQR/vJjCi83qPbMg==
X-Google-Smtp-Source: AGHT+IEvzxnmyAjZsfb0e+j5h+pA5J//LqIC1N+5T0Gss65x98CYcIC2LFS4QKxaVbkYqPE5QavCjw==
X-Received: by 2002:adf:e344:0:b0:38f:4fcf:d295 with SMTP id ffacd0b85a97d-390cc60a7d4mr1350730f8f.29.1740472454102;
        Tue, 25 Feb 2025 00:34:14 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdbe0asm102660766b.36.2025.02.25.00.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 00:34:13 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1
Date: Tue, 25 Feb 2025 10:33:44 +0200
Message-ID: <20250225083344.13195-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225083344.13195-1-clamor95@gmail.com>
References: <20250225083344.13195-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Schwalm <maxim.schwalm@gmail.com>

A simple HDMI bridge used in ASUS Transformer AiO P1801-T.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index ab0b0e36e97a..c0f1f7baaa37 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -277,6 +277,11 @@ static const struct of_device_id simple_bridge_match[] = {
 			.timings = &ti_ths8134_bridge_timings,
 			.connector_type = DRM_MODE_CONNECTOR_VGA,
 		},
+	}, {
+		.compatible = "mstar,tsumu88adt3-lf-1",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	},
 	{},
 };
-- 
2.43.0


