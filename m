Return-Path: <linux-kernel+bounces-538017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBAAA4939A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B503B3F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9F2505DE;
	Fri, 28 Feb 2025 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk1t9kI8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384262505B0;
	Fri, 28 Feb 2025 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731606; cv=none; b=OM3p3E4+P+tevhNTS+Rrj85zoKVozwhCaz8Q2iqsXsjxtwbJbuQ37YqvJ8jfPmJDbwEZNJTkpodo0XbZIoKZnmTsMumQ5U5mpTDmw6n/wUpfXYbSNUUf8hQjLBKBIh7k38/Qd5mO327doo89QlfamlDRhbB85/DOeREDpcfCuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731606; c=relaxed/simple;
	bh=LRCy5Q6xrGTrkxnCGNdgxl18T95wjYXYomd6Qcd8JpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+G1qyaPyCFUo0+1nJt6rR1seg3QfqkdTnPwAbN+mcbQQY/dMz3N7EYzRmIIFQB0c7pfYIMZWLQTRT4wPVOo4AEecHAne/YQRPaQ/uYRomIzMIXN+7aZ61ysNkKk8Nmieonn7GO0/Ggb5yVkH4wSOw8cpkSOVg/d9IOf/c9yraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk1t9kI8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so11888405e9.3;
        Fri, 28 Feb 2025 00:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740731603; x=1741336403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=altOlD5OfS9XMQsr9JEVj89aEfRHMr4jhcpHBqrXJ/0=;
        b=Vk1t9kI84Jc9I8KCv57ch9YcjkHl+Ldespo6RzhK4cU3OSQYsB4jKgOnPHPWFmNsO9
         r4SWJUq8tjFtrhXvjCBcYsDgHAxoILZ3tlf2e4Fr54djkwI1MoUN6OO/7aAz+mBduxYu
         dwVBw+S+i8VsXKLsLx7t/J178aGaUUA5hzxNK7AAe1/dQLw4zkyGxsSJ7P6iGN+jTAYy
         OzrOU89W/Buz3e6oaJaJj32Hnm7RXdC4bgi/n1yya2M1j77YH9g5feLZeV79bYIUZkkj
         tJY9/S/LVZeg1PAcla4yjtrhK7ORXZr/0oJuVjSTwCRbHZlto2bP+YbtsnML5Fu0FD7s
         nNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731603; x=1741336403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=altOlD5OfS9XMQsr9JEVj89aEfRHMr4jhcpHBqrXJ/0=;
        b=KZtq7OxR+vzmW/BW8ikfGm4IiO6I2AN53JRerJrSy1p2VznMMgLhrFxolNF3a20TYn
         WZuqN7IHhLWhxoLz4P7/TSzD8oocD7uqKWHLwnGC7UxE3y8lPLeSUQWr7s06hAxxmV0E
         cTG86gI6uXfzL8qfRXL5i63D4DTw3DvxESIvemom0wjuRJ864g1MUXGBKGHrme2Bd8Ck
         B9DroNnRPXwOgJ6VnsdcQrwRImuKTf0zUyzRb5BmmuVAOgfOWm5ODByalxL2j18f5hlR
         N3YoxFGPD4RCCj6izfNXMYE3yMZs20AeX2CeQOuzVMl25GQSu7mCmMGntDJzW3ElWh5s
         JgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKcggbB5Uq1SORfy0L/0exsOaTlRCE64ei/BGMnEkTXz7xuRi95dvZJvawlqDd7Gu1si5oao8bwyG+lY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhg//eLXJzc08IY86ysAddSAFidDtOR660lTqitA5Ly136zixS
	R/q51gw/XRAd0Kfzt3xsZ2dho/HC7FxxZv3ElDnY3vihmc0LLTrL
X-Gm-Gg: ASbGncsOewJNKdueuu03z2WuR2pvOWTCnsGtz9J01k8tE5d1g2xnxnuPq9BuenLnAtF
	dMTLDnlzVr3dN1ICKz1kI3JaxPqqFYaLq8DjYhihkrklJXWIKw2RmnIS0v6b7liK0zwlNfPBsbW
	oniJI4TfnUCaEhuhz5lU36G/D4ahXiudpFVk8vDvD8BaGvgjL0uj3Sovliogs8+Wpe/kZoS1AE9
	TmFsugdLzxtIrpgky94/35giYSn4aZkisrXAzmDRD4x/tb4DI0QWHfSW+5EapbNvST9mkPUUaZb
	2MWpfgpclyHbYthv5Fli9He2hhs=
X-Google-Smtp-Source: AGHT+IFow7FUOytG/ykCncfTbL0sB2LYY5hKFmRDCWNXGIyfl+KPtU4kWQ6hYwmvBGNpZfuJxe3aQQ==
X-Received: by 2002:a05:600c:3b0d:b0:439:88bb:d02d with SMTP id 5b1f17b1804b1-43ba66da7eemr16388845e9.2.1740731603153;
        Fri, 28 Feb 2025 00:33:23 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba532b2fsm79801705e9.10.2025.02.28.00.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:33:22 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
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
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/bridge: Fix spelling mistake "gettin" -> "getting"
Date: Fri, 28 Feb 2025 08:32:47 +0000
Message-ID: <20250228083248.676473-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 2100a687096e..914a2609a685 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -887,7 +887,7 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 		lanes[0] = 0;
 	} else if (num_lanes < 0) {
 		dev_err(dev,
-			"%s: Error gettin \"sil,i2s-data-lanes\": %d\n",
+			"%s: Error getting \"sil,i2s-data-lanes\": %d\n",
 			__func__, num_lanes);
 		return num_lanes;
 	}
-- 
2.47.2


