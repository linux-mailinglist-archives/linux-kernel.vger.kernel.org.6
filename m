Return-Path: <linux-kernel+bounces-227622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4726D915496
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF86B238B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C228C19F463;
	Mon, 24 Jun 2024 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUReekDi"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E119E81F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247451; cv=none; b=TP63v71k2CiUMillhrJ8o05/LWbidm7E9K8S9Du0gxTtsv2Cou7CpZWH1hy4UVYoS8Nk5o2z+1PV4+zKJ+dF7IsDqKggbiGKlWkW1mMIOFbtV9NUJ1YDAzcgVDmHv9keOpsD3e3BHp/hFyoMaQuLH7S3B1lgExgHaBpcEa7zlc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247451; c=relaxed/simple;
	bh=wa0T80IF/y+nnAamP5x5ocsqIEtI9E9JOf3ilDfD1yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pzLMsSbLDx5iwTB8cDuVMGfkhTz8PBToj9shIy5elI05TpoMO3UaYsQ8gMTyVNs59Ja5mpxMmxAk4xrgEj7uAsyh5MeRUivBkrzGoLzpOJuELmg/1dHBktDq9bJlDJCIIHCu2o/99BE8Vtu+RQbMtme0FwEvsWq7T/Xr0Bkb66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUReekDi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so27004735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719247448; x=1719852248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ved9pZHSLvDLUPYxuu5ADz4/DRMPqTel82rQmFgJsv8=;
        b=eUReekDixC7xp2wkNcAxPFpnhMs+XJkPloPxjox4Tzsw8aqw3t5iHgfYrIHUDVpSyX
         0/+JrKeXFUx61ZZjap8cqPzn3kffiMXMqYyt6NB7WPf4rH6g2G0iQWKi5zDqqeo0qAHl
         6BlMvahxgd1GoaxkINDnnSLAgqPbaqKViKFDvDMYJcV5QUIRSJGVemKps7X2a5Xrb8M9
         MXMTEh94Ut7CbBjzJdLAgWqkppdNr5HI5vDVMk8N6RXe9S45YllaB/t0sn36Kf4ZOoEY
         LsLAyIWqCtE83M8eRj73Z1RzekhDmzcM0qFVWFmYJ3p51i27sCDd3ymQ1XM7cx2XV+5R
         +VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719247448; x=1719852248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ved9pZHSLvDLUPYxuu5ADz4/DRMPqTel82rQmFgJsv8=;
        b=P7+IzySL/PiovScCgnWVyoZGnlHpAkDBYNPbb33j4Jk4fVZSumeMGxXtIL6m0tYt+8
         CjXslmLwBPXv3uzuZJBqtB4fP6i4aB/X36SBQryWirZhYOiTidtR+JqrJMoAISHJ3aJ4
         G5HVHRqsdTUvxtYtUz6WwqAntXQbBJIeba/RIxuxCWZMaEFuvbjynm/frt6rQuWKYS6v
         PHKx0q3CrhHuU1alt2rTQx0VAKU6hY5L10ulH7u6OokAl+Fh9Sjw0r+SkG30/2pR2YPT
         2+8Xf/1GrRIZDJNYe8IGcGTY3Pf90t2t/Co4voyG+XeVi+V51ZYdV6L7wkspoBrHjo/7
         1Hcw==
X-Forwarded-Encrypted: i=1; AJvYcCVmLzMDCZY77d3tjFTLSU+uQOTLt+k1I090QEbVnpcdWNgcjxkYzKrklmP2/V2XFC8bMqbpjajJ3eSHCmclt1yfL62dhmICFHRr/Gzw
X-Gm-Message-State: AOJu0YyuM7i4RlBKxjy5MVqSURVXqiQlTHuvGwRbcDF8U4Brzh0cb3uy
	bgmrfZQz/SHKpa8o0/5awaBzvhebpGSQNhdd/izqjiEW+gcHZfvS
X-Google-Smtp-Source: AGHT+IFxufk+8bZWSFo5H95XETmbIR8xWYc74lh7Lzz8/zakL9+PW+wJ3qLYXaIxadr7Xc+Z3bl8Bg==
X-Received: by 2002:a05:600c:138e:b0:421:805f:ab3c with SMTP id 5b1f17b1804b1-42489533effmr61514635e9.14.1719247447674;
        Mon, 24 Jun 2024 09:44:07 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42484fc0aecsm126090365e9.12.2024.06.24.09.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 09:44:07 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 24 Jun 2024 18:43:48 +0200
Subject: [PATCH 3/3] drm/mediatek: ovl_adaptor: use scoped variant of
 for_each_child_of_node()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-mtk_disp_ovl_adaptor_scoped-v1-3-9fa1e074d881@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719247441; l=1676;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=wa0T80IF/y+nnAamP5x5ocsqIEtI9E9JOf3ilDfD1yo=;
 b=M9kK0ImZkRyD1NOWZet5N+FhNkzhbstvrwy7I96XW9Qwjr5TGDy8zsCLgzUzrxPsLZTtpED/X
 cFIZmEu7appC+67/uzXN9oG5FM74e5jHbRgj7YIRdMdBI8ar0b/8ytM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

In order to avoid potential memory leaks if new error paths are added
without a call to of_node_put(), use for_each_child_of_node_scoped()
instead of for_each_child_of_node(). The former automatically decrements
the refcount when the child goes out of scope, which removes the need
for explicit calls to of_node_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 3faf26a55e77..aec927cce468 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -493,12 +493,12 @@ static int compare_of(struct device *dev, void *data)
 static int ovl_adaptor_comp_init(struct device *dev, struct component_match **match)
 {
 	struct mtk_disp_ovl_adaptor *priv = dev_get_drvdata(dev);
-	struct device_node *node, *parent;
+	struct device_node *parent;
 	struct platform_device *comp_pdev;
 
 	parent = dev->parent->parent->of_node->parent;
 
-	for_each_child_of_node(parent, node) {
+	for_each_child_of_node_scoped(parent, node) {
 		const struct of_device_id *of_id;
 		enum mtk_ovl_adaptor_comp_type type;
 		int id;
@@ -522,10 +522,8 @@ static int ovl_adaptor_comp_init(struct device *dev, struct component_match **ma
 		}
 
 		comp_pdev = of_find_device_by_node(node);
-		if (!comp_pdev) {
-			of_node_put(node);
+		if (!comp_pdev)
 			return -EPROBE_DEFER;
-		}
 
 		priv->ovl_adaptor_comp[id] = &comp_pdev->dev;
 

-- 
2.40.1


