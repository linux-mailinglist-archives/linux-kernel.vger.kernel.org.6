Return-Path: <linux-kernel+bounces-184740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109508CAB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412FF1C21619
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ED66BB58;
	Tue, 21 May 2024 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hzoa8u/P"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B06BB54
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285352; cv=none; b=h1ImdSR72uqEqhNMoOMmqzfEypQQYIY9mcHgGlDMMdYNgqMrGteXTtWefCpaFjty8lXx65fay6XWa5hdxo1mcVByLH6SwNOtqkHedcglMv1ZcbFkAZU3a97oRQYPpcw/MSdJJ4YZa9YBDYPz+7b54zhUXxBrZDY5Qh3ETD8D3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285352; c=relaxed/simple;
	bh=qMTfM2RqcLcFcnpmgsM4+ekw46TcyOHKMEZUctQ7tns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhXuOKTPJj/5RN/b4bUyAVpG6RQcu4hFI9S0GY/DD0O+qANLanS6K3W3tRpNrI07SiLQEy2pCCfDSEN2Vh2ZEBjGMxN7d706IkMf+fEWqgBT5zDGsN1/0wxfrntE1OoeVyrLvXP4wdmh9Pt2uDdERFaFvYWQgEEyrrt1okS49rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hzoa8u/P; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f0ecec6411so2674513a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716285349; x=1716890149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIL8bJvqQtt10T5yeC3JXxYF7RA/JJU1vyZUZM4XpQE=;
        b=hzoa8u/P0M2zf2nPp2UUHs+5wCwCHYSNz7tFQN7N00aelg3onWOiAGArUGn5iXUcCD
         +OlDGmjAFf6u9KrxnrurSgfcdR0hJ8U4HcHuIEZ7FRF8rulDFvJ+uJxP8U2Lofh9DEnV
         U1YSvoOsIvQlSHfFeY96fE8Qy4J5s9YGFVn1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716285349; x=1716890149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIL8bJvqQtt10T5yeC3JXxYF7RA/JJU1vyZUZM4XpQE=;
        b=jYcYDGbyoNAHCPzla9Z+5AciJEYJSSxuDcO4U2ZYwf5C+8u3iaisqOvK2N/UFfyb8W
         b2UrRHikfBYoemE1q5gvvkUQFQ7ZuYxM8miukhqSuheWoAJJ2oIGTnREwzwH2l6MLEgG
         XELy6JSRzj8FenpIMY6i9S7yynxtvA6QadvpeNotjZeFKdB+B+Tm6Ruf8PIS+dkn2M0C
         2Car2BjeCBNdSJ3RmQbCwtt90WrhFA6SwsogYUzsdWAXzI1pC1neYsfLvXpuHHsuQKCM
         aL7IoM1XeEbLEVoFaPomHXC3wUB11wS1vF10Q91p/T8G1vwDDdSTr+Dp7fxe6jC1HBEz
         7Nwg==
X-Forwarded-Encrypted: i=1; AJvYcCXClOU+EyB5r2TY+zPuYr9W5IzSpqHvXBBpiBs0h1CvqyJBaZxQDA5QQTuAlaoSDcIRM3mzgQ9jIPmd8Sr/A/D7kK1IQtxVjBbre8Y/
X-Gm-Message-State: AOJu0Yyf10KAdaiLMqRVpuDd6OYgH6g2q5Xef4TtVmLeEqR/AXY7oi6K
	B8K3eOyge4zFtngrBLlI9pxN/eRPj9DVY8CMzo9ApO7TBjSjhg6BdoeGdSxY2A==
X-Google-Smtp-Source: AGHT+IFKIYFqTMarrGIwJW/xjD4E5TP4smgp1LW/1jUBwGpm9C4Gsb/IKEVVDk5X70ezxhmNydvPxw==
X-Received: by 2002:a05:6830:3299:b0:6f2:5b44:593c with SMTP id 46e09a7af769-6f25b445a16mr6106649a34.35.1716285349487;
        Tue, 21 May 2024 02:55:49 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:7412:b980:a8eb:dfa3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f679902e57sm10016198b3a.110.2024.05.21.02.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:55:49 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Fei Shao <fshao@chromium.org>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] media: mediatek: vcodec: Reduce msg queue trans buffer size
Date: Tue, 21 May 2024 17:54:56 +0800
Message-ID: <20240521095536.3869399-1-fshao@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the MediaTek HW vcodec pipeline, the `trans` buffer is used to
transfer the data decoded by the lat decoder to the core decoder.

In the beginning, 6MB and 30MB were allocated for the trans buffer to
handle FHD and higher-resolution contents respectively, but it turns out
that's more than enough in practice and there's room for improvement.

The buffer sizes were reduced to 5MB / 8MB respectively and the decoders
have been validated to work normally on the MediaTek Android products.
It's time to adopt that change in the upstream MediaTek vcodec driver.

Reduce the msg queue trans buffer size to 5MB / 8MB respectively to
optimize the memory usage per decoder instance and improve the overall
system performance.

Signed-off-by: Fei Shao <fshao@chromium.org>

CC: Yunfei Dong <yunfei.dong@mediatek.com>

---
I consulted Yunfei and he confirmed that these are the sizes they are
using today.

 .../media/platform/mediatek/vcodec/decoder/vdec_msg_queue.c   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.c
index f283c4703dc6..e36741179a97 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.c
@@ -29,9 +29,9 @@
 static int vde_msg_queue_get_trans_size(int width, int height)
 {
 	if (width > 1920 || height > 1088)
-		return 30 * SZ_1M;
+		return 8 * SZ_1M;
 	else
-		return 6 * SZ_1M;
+		return 5 * SZ_1M;
 }
 
 void vdec_msg_queue_init_ctx(struct vdec_msg_queue_ctx *ctx, int hardware_index)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


