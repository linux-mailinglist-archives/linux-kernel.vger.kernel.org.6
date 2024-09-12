Return-Path: <linux-kernel+bounces-326199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070049764C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64B91F249B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133EC1922E3;
	Thu, 12 Sep 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OE35+moa"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C91922C0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130708; cv=none; b=mZ2+RjjZ1luKZE1FlUK5QRAh1IdI5FZCRHO63uk7+3zHQHpXdSDSB/eV6zoAb5oeIt0V65Z1WWp1lzBzKXnc3YYzv4um4SRLcGRFUVf80+RpSEjTolCthMaO/Vh4lQwcQauXBTxnyJe18f9gKFruGIfHmuNH0d1jCz8oZ7jeX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130708; c=relaxed/simple;
	bh=mOqvLpNO+BNetEeobtLxC6/KmXf0MhVchHjd7Fyzcq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eNn74U73yz3LZ6yys043n9+mXOcutjJlHVTJmrcVO6qJ9bV6vKjDc1DuKU+qNvsE+8cTWMH4DqrGAaGMwTiV9U0wOO/Umm2I+3iu7HOsLPyiNkbGsT/ii0/on2N1vVP5gXfyuB/ManMpCsZGSv1lDFMZfJEvb6aPlxGuzq4nrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OE35+moa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so7373685e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726130704; x=1726735504; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iwn1or/bBYSNEeUGyuhOfxUWx3sWzISGdpZDtEwQt38=;
        b=OE35+moaE2ufayZNtLkRSoaoIlRDpTm0v5D6Iuvv4tjQMj3dp6cVHLhInIqNX869Fg
         nAphBFnQhWj8EkCiBf29MN+xLtpWoDWFgAWxn3HwYU4A8as2uvinfeycYTMSBfPLKOM9
         Ek4GgYmaJYuglzaAMgcchOSM6IBSPhVJab6pz30aNkY1Bqze15RaDCB23uwZ52ZiQnuT
         Fm51aSf1ghczKBubYkoSQ9oQ58oOW/YB/oUwbvmiIDwDWSANGQXFF4xoegXrA+KT7uMW
         Nx0wVddxeoRU1ZYFVw0J6x0EIgoae+3Jtk4lnhlLP7nnByGi3amVsQO0xtevw9wgcD00
         woBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726130704; x=1726735504;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwn1or/bBYSNEeUGyuhOfxUWx3sWzISGdpZDtEwQt38=;
        b=N4GS3Gfx8AlZhJEKjga8F+I05rwPQmyA28eAH7WxnsKzJXNFrL824jEato8R99f0GG
         SM8fvuVUAz+EgT4EVmbGos7+GCbvlogJxH0XjtkfE/sEKO0QV51x0G8YDWQgnESBrZ0H
         yCQMCics0k0h8ZRKy/LCKY745Ty2QMNTtbad6iZqGxfNkLiJbkVJFlvv+nrK6JdDu6Ed
         I3Gk02f1TZqUXRPvp+OZgiGPGfDV2l4Hlbo8MVgt1gDFzva6o3pA4OGNG0jTVuBZ94Xt
         88Y9GBXH0YOT65dgy9w03SfGXpuMfTfVTTjtfhpe1rlYJVeive7qzxWCFejYAgfCOJ03
         V+/w==
X-Forwarded-Encrypted: i=1; AJvYcCUQOKdZoHvbQAr+ieplzF+2s9iT5/zSCmwCXQxaskzZoXw9/TuUQ/3MV5nrh1p6EpRWD1oCkUs4tOSf9KI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7qBxWeW1qYlii/0b53Sa6jqltWAsY1UbzTJkWveEyIXhAzxO
	glhE3tXbnJBjjgZ8FD3Tr/H8GRrY81QOk1UAGEp6Fz28TUhEPiqlTooUWfPOZVg=
X-Google-Smtp-Source: AGHT+IE3jIKp1LsMR7cNfJjwontG8p+Vo7dQ6rcRj2YQpKpztKUglDivYbVOWQlxSgzVuxQlXUEEiQ==
X-Received: by 2002:adf:ae51:0:b0:374:c7f8:3d50 with SMTP id ffacd0b85a97d-378c2d588d5mr1389741f8f.58.1726130703593;
        Thu, 12 Sep 2024 01:45:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de262sm13712489f8f.112.2024.09.12.01.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:45:03 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:44:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org,
	Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Subject: [PATCH] drm/mediatek: Fix potential NULL dereference in
 mtk_crtc_destroy()
Message-ID: <cc537bd6-837f-4c85-a37b-1a007e268310@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

In mtk_crtc_create(), if the call to mbox_request_channel() fails then we
set the "mtk_crtc->cmdq_client.chan" pointer to NULL.  In that situation,
we do not call cmdq_pkt_create().

During the cleanup, we need to check if the "mtk_crtc->cmdq_client.chan"
is NULL first before calling cmdq_pkt_destroy().  Calling
cmdq_pkt_destroy() is unnecessary if we didn't call cmdq_pkt_create() and
it will result in a NULL pointer dereference.

Fixes: 7627122fd1c0 ("drm/mediatek: Add cmdq_handle in mtk_crtc")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 175b00e5a253..c15013792583 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -127,9 +127,8 @@ static void mtk_crtc_destroy(struct drm_crtc *crtc)
 
 	mtk_mutex_put(mtk_crtc->mutex);
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	cmdq_pkt_destroy(&mtk_crtc->cmdq_client, &mtk_crtc->cmdq_handle);
-
 	if (mtk_crtc->cmdq_client.chan) {
+		cmdq_pkt_destroy(&mtk_crtc->cmdq_client, &mtk_crtc->cmdq_handle);
 		mbox_free_channel(mtk_crtc->cmdq_client.chan);
 		mtk_crtc->cmdq_client.chan = NULL;
 	}
-- 
2.45.2


