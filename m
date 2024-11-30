Return-Path: <linux-kernel+bounces-426358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C099DF216
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F2F280F4D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CFD1A265D;
	Sat, 30 Nov 2024 16:53:25 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E207B1922F1;
	Sat, 30 Nov 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732985604; cv=none; b=G30IavPnzoCvdcPhrkt4f+e9W/sTcxKzkl265oGTiwIPwKqBBYUiLSNqNiicktocviGlgr7VaD29BbPPkRuzygYmdseITUgbM5AE6TUOzyDQPkBXOHeme6ZzNA8T3HDjRfi63IY8a3eyb/E0zg569xd33UmoBUXPw5yWEMQPznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732985604; c=relaxed/simple;
	bh=X5Y43j/YUvAaJH0RdMgAo9oujFLSXM0w+f41Fr/W2uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eoSDwlofL5dlNC1ZFwGafy4A5idJtUqbyGJb1yDs/atRxq9rzIYyf/NOMtvwDolsnrfQZceMqMnIhF7dQ7K4k4Y8jZ1h7lyZVCelRyEJimHEEVSsejC1Rc5cWYCbw8+MS2CIFB2OK89jEm2v40OV/lydQ9oFzpC93fZJsLVK5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=nycode.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=nycode.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434ab938e37so17818995e9.0;
        Sat, 30 Nov 2024 08:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732985601; x=1733590401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1x0C6tj/aARPaW2gO9/yZtfHDLpoDu+dP4O2r8oZlgc=;
        b=t81f9wSx/Yoq/gBbiSI3trRirvtIMebuTdfJNnlRF1/JryrrF0JawXl3uojlrP0jaU
         iIvnSjTteYznhCShWS0btIWAugzuPqJD+awqzfeVjWTjiex5YaYx8N8Fi8//h6DT0U7Z
         w56UoEQhnoOOaKmCu4P3Ha/bT+SnhKkJhby8wfBVJYMLerQnxpLeAM0T2x1XW856PvLt
         GW+3DVQtqxn5zQj4IId2PmBwv9BRTymy4OOcifG/OleAdB7xasMj9zDK54+UQnrISTUk
         hVsZXjViy98i6nhbF3h0ac8jhPa12Wt3iIP4kjV09Xza/0A052hc/QZmjyFT6NqdMbbd
         ncSw==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZecuPTsgLOqPsf5tIlt/F3BwEFC5o9r4s0XkmBTgHf4w5WrsepGDjLMJNrmAnu8DWs3yqakuodzf6wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLI1UN4t16J0ytNIdyUq3fL+ipiMk1Hw0KMHVlgMzxnc40D8bN
	ispb3HqCNnaH8KfDlAbbEXjv8cuh8EDD2vLFfSsR57kTEapRyWivdnHrAc/n
X-Gm-Gg: ASbGnctyBPShJOSKGm/tMLgk4FCGsEyFrz6iI8jItw02iYDTuqzL1VvhrWv6/WZ03Ws
	ZvFJkv56QNdzArm0IDZP86myDvZxjAYAZYiL6sX9GB2ahSHtnzA5KGLoPn9xS81oozUs7pvDbRQ
	XscUbuqScuadLENNxCIzXAYKHqAW/5siZNXmbu5luJFi5qhGcPfDMc10ZEAMfIaLH/zE5MfyjIn
	XmNCMc6ss+UQmKKl2H8l0y3a034QprXeWqgKLi4+0h3m/VY3Bzo1mbcNqju8xMpL6L5V0l+7A==
X-Google-Smtp-Source: AGHT+IE3Wa72eOF83vB3yMxG2sgsVP7WAAuC3Kxik9MMp+Sv2vJ+IUgiYKvdLejUJ4e8Z+sIGPujpg==
X-Received: by 2002:a05:600c:b87:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-434a9dc3d08mr149616495e9.11.1732985600964;
        Sat, 30 Nov 2024 08:53:20 -0800 (PST)
Received: from marie-desktop.fritz.box (artemis.marie.cologne. [89.58.10.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dc715a74sm5708085f8f.82.2024.11.30.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 08:53:20 -0800 (PST)
From: Marie Ramlow <me@nycode.dev>
To: Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: add mixer mapping for Corsair HS80
Date: Sat, 30 Nov 2024 17:52:40 +0100
Message-ID: <20241130165240.17838-1-me@nycode.dev>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Corsair HS80 RGB Wireless is a USB headset with a mic and a sidetone
feature. It has the same quirk as the Virtuoso series.
This labels the mixers appropriately, so applications don't
move the sidetone volume when they actually intend to move the main
headset volume.

Signed-off-by: Marie Ramlow <me@nycode.dev>
---
 sound/usb/mixer_maps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 23260aa1919d..0e9b5431a47f 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -621,6 +621,16 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x1b1c, 0x0a42),
 		.map = corsair_virtuoso_map,
 	},
+	{
+		/* Corsair HS80 RGB Wireless (wired mode) */
+		.id = USB_ID(0x1b1c, 0x0a6a),
+		.map = corsair_virtuoso_map,
+	},
+	{
+		/* Corsair HS80 RGB Wireless (wireless mode) */
+		.id = USB_ID(0x1b1c, 0x0a6b),
+		.map = corsair_virtuoso_map,
+	},
 	{	/* Gigabyte TRX40 Aorus Master (rear panel + front mic) */
 		.id = USB_ID(0x0414, 0xa001),
 		.map = aorus_master_alc1220vb_map,
-- 
2.47.0


