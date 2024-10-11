Return-Path: <linux-kernel+bounces-361754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CBA99AC94
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3439228DF2B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8AA1CFED3;
	Fri, 11 Oct 2024 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHM1iFgF"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A644D1CF2B6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674549; cv=none; b=ORrDIsoC5LfsAB90B83WHekYiDvcrqq0+1WbD+iTbk3m6Ld+KAeBGc9GEW7wDy0iYtRJatKmbcJECOsKTGG4SUDSbk8Z1XZsOL/NTvJytygtf1QdUb+EtXSqEzuGOjLFF4KJS3KS1J8t9GwOXWQN3pLno8AggGd15h0mz+UbAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674549; c=relaxed/simple;
	bh=NIQyalFfWvXbrf5QDhsF9KSVr5abtwUFulTgkzyXOgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PoQ6C0Ftw32e4cHpw0TCFZMy9MxecTXGICE4y4mfvsDUELIUvwGgeS/xjYA9e5EwHYe1Kz7J5ScmPPfzhcYWIbeN6qpLM2iI8h8SJYPTfC0Ij35N4O1jxHWQ+Bia1/VAJZIARsrRXB4xFVuXBbPLYpj6cP5B2OlbtUN53Mevy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHM1iFgF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4311d972e3eso8116165e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728674546; x=1729279346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m894EEj8MKVIaKel5D8cwxspY83xIoj8l4L9T9MgTMM=;
        b=FHM1iFgFMugkvEYjhqvWHB+By2TpK9WfoBEbzjFSqw+G1n8zLbURELqsf6IO4M9yfQ
         AphkEaIO+lphtBRov5AIBCY4D7FsnJ6eoYEUJ5Jm6yFu4B4xP9rEJO2QzxxKqf4A5LDA
         ZB9DyNOx78PbLGtUw1rtJ4tmwY82ydWwNe74MeV1+jreXzbovgpwK9xmpsdvzvkmx911
         LgGL+1UW0J1mbx0FD/SGhxvwf0/HdcVlw5ZBwiZU+yThLMfBiGzbVarMKIo1VDzV+nZZ
         hy/tzSQ+35yFeQ5nvnh1WoiQiDzoMj4ld71Z6CLcLDDZV+iC7pgoGq8zl1QB5ZxjXr/l
         qp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674546; x=1729279346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m894EEj8MKVIaKel5D8cwxspY83xIoj8l4L9T9MgTMM=;
        b=dkC6L/5EMD09CXyCOVAW6S/6fF4QTzng2SrIwz+BpvRnaYX9MKKNds14aXjJIjDiqa
         T4HGJCO5SzXAFVBOZGOh+HsA9McATYLf7FHIxNXwDZdHM3N/dAjq9EDfk5IjP6v1TXOH
         LMXIzVjGdQIebqPQjp6WdkNrfFpBcELcjVCYcLbn4rIzBNP+bcjk94wby9v43RQc00FV
         cuIwSrt3LXP8n1HnmbITnVPT5LtMi5B8Jn7VURXnECJlMiqq13z0wWdQbN8dkPYYv7Qx
         mIopcChioKrjh6vcF4lyRUdgj5YRAztCyPf44PKAxf33or2zcjfE2SKz3xmcjnRAicXQ
         /yNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUCZiUUD7sKR6rfEE1XZr6ErIGVolS4qNBlUcTRXhn3bD5I0kL+VFNDBwsv1pptSryhsLsBiGqR50L0Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypVX7Vmw9qT7EG6OuHdRLePihpzIgftUHX8Zgc9ZapsULPHEN6
	LFQajgsQIWr2xQBlE1ge41jQwDwxIVW5IhZc2oy47zSX0RIl/2c6
X-Google-Smtp-Source: AGHT+IET3Ck++IAbg8SE1O1j1TEiGtDgB9CXJmSO93us894bSYi9oAhFM+9i9y/jH/CFuKjQZAnQuA==
X-Received: by 2002:a5d:4082:0:b0:37d:4d3f:51e9 with SMTP id ffacd0b85a97d-37d5ffb98b0mr440582f8f.40.1728674545757;
        Fri, 11 Oct 2024 12:22:25 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-55c0-165d-e76c-a019.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:55c0:165d:e76c:a019])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee49bsm4581663f8f.100.2024.10.11.12.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:22:25 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 11 Oct 2024 21:21:52 +0200
Subject: [PATCH 2/2] drm/mediatek: Switch to
 for_each_child_of_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-mtk_drm_drv_memleak-v1-2-2b40c74c8d75@gmail.com>
References: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
In-Reply-To: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, CK Hu <ck.hu@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728674541; l=1436;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=NIQyalFfWvXbrf5QDhsF9KSVr5abtwUFulTgkzyXOgM=;
 b=rbU7FqAOUJAaaOiSLWdKxgwrbugJ/grvJuThgHTtqrrqNwfI9iTGPlHUx/XB89McOBEJe5dBu
 yJhiWoNOe+BBmCJt5qEWcN0JkOJoUYWYGOxcxUVTsX0PA3p8LqE99pX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Introduce the scoped variant of the loop to automatically release the
child node when it goes out of scope, which is more robust than the
non-scoped variant, and accounts for new early exits that could be added
in the future.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 0878df832859..9ab656b10a49 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -372,12 +372,11 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 	struct mtk_drm_private *temp_drm_priv;
 	struct device_node *phandle = dev->parent->of_node;
 	const struct of_device_id *of_id;
-	struct device_node *node;
 	struct device *drm_dev;
 	unsigned int cnt = 0;
 	int i, j;
 
-	for_each_child_of_node(phandle->parent, node) {
+	for_each_child_of_node_scoped(phandle->parent, node) {
 		struct platform_device *pdev;
 
 		of_id = of_match_node(mtk_drm_of_ids, node);
@@ -406,10 +405,8 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 		if (temp_drm_priv->mtk_drm_bound)
 			cnt++;
 
-		if (cnt == MAX_CRTC) {
-			of_node_put(node);
+		if (cnt == MAX_CRTC)
 			break;
-		}
 	}
 
 	if (drm_priv->data->mmsys_dev_num == cnt) {

-- 
2.43.0


