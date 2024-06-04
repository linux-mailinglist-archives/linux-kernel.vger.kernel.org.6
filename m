Return-Path: <linux-kernel+bounces-200030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B7D8FA97C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872DC1C22669
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715D213D897;
	Tue,  4 Jun 2024 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMeSJhsS"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716277A1E;
	Tue,  4 Jun 2024 05:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477679; cv=none; b=sf44/5TCeWg1IWRKV5biAuh4EjVUyqWHtR0r5YdHMW2Wwhkvs2CsOcMWTyMqEmclWuteTH69riXGD8gtLtOFtnB/9zEMArsadsQWrBq/00oPTsHtsUEJWbm4hwU2qpNAIAtaqhvjllEBYWvwki8nwdl7SD8VilpMC7inTozlV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477679; c=relaxed/simple;
	bh=VnrsrmJLTVbZ+4ruwjVg6IITpxxXal0ZQftR8DKsdqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WRs7j/OJK44MP+2W2EWppb6ypNMHyuNjPA+2o7r1tP2illu+wLAGvxjJpUt86EiIFC7kmRRRxBCzlyt6ap2DJTJu2LERPILXZeng0a01xK8ACmIIquMudkGFeTJzesLRlMlK8BPpyOaLaXU351s4zNxbG0bn8XZPLaQFt1XJCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMeSJhsS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso5763277a12.0;
        Mon, 03 Jun 2024 22:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477676; x=1718082476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/0KAwhBMFj0xeLutKDQ0UoKA+IxDQr3IVwvdATPXUI=;
        b=JMeSJhsScin/8bwQVpP6tzBODuZwN4ul39pP7U9BJXfjmpleA8CpnCTW17xuc2fGPU
         iOGCH3fpbd2dFVI88fwRbn6VUkHWiNP6Jckyj6TsEtVJSlE9jjdy70dit/m1cvKu2uyG
         MKuX+pQuM6avHa69m20foK9DDrQzVBs/vdFFBKJi6tbxj6hYCSWrQmMiLbN0N0jLhmw7
         v2jf0LK0ykdO/eKvxJ6Rqfa7/TNLh7/JHN86jnO0vAN8shEeku1V0v09nPUuCsit+khj
         +VR+0Bi3a+qIow/XXOgkiF482YK1o/Iv5UBX0dFGvwheyzZszQzoTunk1L804I/jHqhT
         cYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477676; x=1718082476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/0KAwhBMFj0xeLutKDQ0UoKA+IxDQr3IVwvdATPXUI=;
        b=r9mZQA3P4jltCEn3hiLO+jxIed35T/gZLYQwPdSi+LP69Xv5Z2KDwTt6JP7CS2WGvF
         5Mymy7IMew0j71Nla22yRn7bKaWPcudOh8VlbKJMdm5/Z1v0Y72J4/gfP9NmiphqgE6/
         3oowGncA/Fb7oWKn65xwoqYA7qfW2xAH3xIgUlRtbKa4uHVE8Ts+g3tJGxfWaFciqn6h
         nFpw1pGNI9wMZqnyj+RxjvZt0IbLSz/2/hpw8kTNfESZ1hdhkfTozeLFf+BgyjuaevFs
         VW3DztNON91uu2Nc/g7MedS2d/m3TI3Z0Bwgw2BDQ3WrwuUUm4HvsAp4Wmn7N3nwN3tT
         Q20Q==
X-Forwarded-Encrypted: i=1; AJvYcCX85ptNvbFAblNl9ZQXtgLQzje8EMGsQjj8UfcGmiJ8ru5XWJ+TnVmFrsC+xsPxeLatDS1dg1FZk2+twDpOV+0sidzFS3ihroMtJz5hKUwf9WbVwTmwuhPLe4aO+BTqAHTO5qYmEyfFWw==
X-Gm-Message-State: AOJu0YwLOFKSZUYXdMPtCnRHozY3TAApxa9W6pyAlvMF3dUfyZUeMuGH
	lSFdwlRZiaoGzbqmJyYinNXbsypCd1ccf9gCkLP9P56j2T5QB+Jl
X-Google-Smtp-Source: AGHT+IFqaCg6GVKaRQTD4ZnkvFD4mcPd4vzIPMyF2qE+BIWUTXix4cOl9OG9VejbKdNnvWP/5W0W7w==
X-Received: by 2002:a50:a694:0:b0:579:c2fe:886 with SMTP id 4fb4d7f45d1cf-57a43c36782mr5518061a12.14.1717477676221;
        Mon, 03 Jun 2024 22:07:56 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d45esm6636673a12.62.2024.06.03.22.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:07:55 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] soc: amlogic: meson-gx-socinfo: Add S905L ID
Date: Tue,  4 Jun 2024 05:07:52 +0000
Message-Id: <20240604050752.3312468-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the S905L SoC ID observed in several P271 boards:

kernel: soc soc0: Amlogic Meson GXLX (S905L) Revision 26:a (c1:2) Detected

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 6abb730344ab..7e255acf5430 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -64,6 +64,7 @@ static const struct meson_gx_package_id {
 	{ "962E", 0x24, 0x20, 0xf0 },
 	{ "A113X", 0x25, 0x37, 0xff },
 	{ "A113D", 0x25, 0x22, 0xff },
+	{ "S905L", 0x26, 0, 0x0 },
 	{ "S905D2", 0x28, 0x10, 0xf0 },
 	{ "S905Y2", 0x28, 0x30, 0xf0 },
 	{ "S905X2", 0x28, 0x40, 0xf0 },
-- 
2.34.1


