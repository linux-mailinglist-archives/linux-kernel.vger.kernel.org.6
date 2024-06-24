Return-Path: <linux-kernel+bounces-227620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C31915493
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A761C23208
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF519E831;
	Mon, 24 Jun 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4IDlqn3"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820C19E7FD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247447; cv=none; b=JZjXR0Ozjwcv3Vo4lQAHLZGEXy6k6AavkZj0hrcY+fLMHGmSAX+r18HX/pRP5Z4XMhAzgdPyIDnVht2WbzWXZQ0q70lF7+wXI+K45rVHKMWxgI7unMYPDF27gsmwxZGhdk8Fr8b+EYtSK6zi1Z9D6mGB7grHRGXf/q1E3jDAeKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247447; c=relaxed/simple;
	bh=j/Zhl07/mGungCEQOMBPhb09WEiiiTeekEFTk2ivabw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmBOruLDQI/tmu//7omDfKgHdxt3DaduiGNpOwSTY9bjqSklQc5juxmrE7l8nyhx6zt+daw5LuWa1/LvhHgWAtFWxWCgTVkYRDHMhaMClSjc8q3O7S3cxp4E/lzDpHZfFUTrZ3G+kF0GebHff0jYSyLIvrQtR9tPH8KD+TPB9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4IDlqn3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso38767065e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719247445; x=1719852245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kHPT/Sbn+YowQq/I8VGD+WkhOqD5j84bm9SVl0pb1A=;
        b=P4IDlqn3HCm/Xk8G0C9NoNnmWHGQSU91ViEV2f7hpKXmrRXnptqZaKQ0HcnCcb9bRB
         W0OryiExioGmM8TY8fc8/mnsy07agwxVXSeHu9P9IIMWSuJQ65IsOuGFffXGso4+JlWJ
         zcf3/rtdl5yAGD8cN3xsXQ1CRZe/t3T712hRn+9f15f6fgX2RszP6DFaZiEbMU/Uac4u
         B2OZjxMRGU6Xo5pUORNs1XnQBrzOQ53XQSWoirZU0AcmlOPV6Jv0w7cHsCxdvr/t9Drp
         vChoO0721Opyzp7S42bGJGULeeW/DJSXbo+Vj1uoz2k07HqN00KGfRtYabN0GZxTSVuG
         FeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719247445; x=1719852245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kHPT/Sbn+YowQq/I8VGD+WkhOqD5j84bm9SVl0pb1A=;
        b=wLOhdCd579AM+FgCqbDjZd8cUctN6168liuRtz2XOsENePYgPIsrZa5HODk/4o71wO
         VOA5bJipElFGZ1DCuFlZN+DYIWRKFpuO0XfgQFey+On6WD7WwCAMhWV1gyER3BnjCDj0
         ShqiX0NmxqpQ/ka5yOJW93ULzzsM+k1wagMbSILRw61D5djDnwTw9KTdpoyLLTUEjFsL
         obuMEN/03nr3rQndqfD6dcgp8IcVXQZpLPrwHvMAzTUzfIRFVzcOSxBwFCA6jYPG94V2
         v//j4fWI+lSjK8GSzsfTsuWeloqTM6m36actJYrtKFpz59S747vVVihRhSf+0TiCQ7Uf
         N9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5ys5neRSY0+rXF4xcgO1VpS35sM8O2VDqJYLIU97tYsDoFX6QUVlOMuuP/MM0bwlJO2VrmspfnKlWI+2LZmwlh7HwBrqwMEoJJlI
X-Gm-Message-State: AOJu0Yzi1wSLuOHrtKo8kzXMNlYSO7oBBtHG34Vy6UvDwmjGKbakDulR
	1zuAAPZg8nJ3yEYVS0Ts+OFBGOa7X8ZpnlPiZ5/CrrfZ0nNinjdv
X-Google-Smtp-Source: AGHT+IH+MF/1j+d+mvD3UvJmt7w30GJxIqwd74Gd3nbm7skLi+nadm6az73r+6Ot9QMhLZdiwI26aQ==
X-Received: by 2002:a05:600c:450d:b0:421:7198:3d76 with SMTP id 5b1f17b1804b1-4248cc58b99mr34106605e9.28.1719247444697;
        Mon, 24 Jun 2024 09:44:04 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42484fc0aecsm126090365e9.12.2024.06.24.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 09:44:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 24 Jun 2024 18:43:46 +0200
Subject: [PATCH 1/3] drm/mediatek: ovl_adaptor: drop unused mtk_crtc.h
 header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-mtk_disp_ovl_adaptor_scoped-v1-1-9fa1e074d881@gmail.com>
References: <20240624-mtk_disp_ovl_adaptor_scoped-v1-0-9fa1e074d881@gmail.com>
In-Reply-To: <20240624-mtk_disp_ovl_adaptor_scoped-v1-0-9fa1e074d881@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719247441; l=718;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=j/Zhl07/mGungCEQOMBPhb09WEiiiTeekEFTk2ivabw=;
 b=nsHPwkldRVFX0qaLEQCcbPwptfpdpZshqISZVJXbL07KghajM9UUXAa/ztlPZoq/H7lrAeLum
 wFs+M1/owgeDqHH9yoZFm/ngRVpRlYSYb9NOtW91UJ8iIKqf8x5MLG9
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

None of the elements from that header is used in this file.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 02dd7dcdfedb..1418992311c4 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -17,7 +17,6 @@
 #include <linux/soc/mediatek/mtk-mmsys.h>
 #include <linux/soc/mediatek/mtk-mutex.h>
 
-#include "mtk_crtc.h"
 #include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
 #include "mtk_drm_drv.h"

-- 
2.40.1


