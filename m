Return-Path: <linux-kernel+bounces-391049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641199B81CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8A8B22D92
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC141CCB5B;
	Thu, 31 Oct 2024 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AOQv+Joq"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F91CC147;
	Thu, 31 Oct 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397235; cv=none; b=RFMCKQNFXh55Zj6KKNxjI5aXaC7JKFiP5aK32qD7q6CX0ty9wpPlKo7eidPqfJcHztykIySSM/LwthJHSRtXie2FHtDb9XFv9KlfJSkN/jtQUt/gVGdA8va76fqeqxwTQvCntMeAhtTNU/ZAC/X0T2PpPFXXjf9Dys6Q/5Zq6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397235; c=relaxed/simple;
	bh=uUawjcWkSnRz6+496bAdLII+36tesOT/CJyAg3irReg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMHc8vqmcFtCwRDrEwpMaJPIZiAk8LYLwuyuZaZyR6U4oDktYfNhrcJy4/mc2meuqeW84qg+gHzo86NCkqX+T0NrCcMZ8raClm+OVRcxCJLAgBaYOwH44Qlyk0VUQ3kzqhg4n0i5H830Y7oygYr+nYRxBGtqAE60bdk8/SDZGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AOQv+Joq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC605E000D;
	Thu, 31 Oct 2024 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730397230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXNtTQEa6PQ4chY1V5pewNIjVgXipIVtKBwRPGWAEjI=;
	b=AOQv+JoqdeBdR9LhtvG0FYdrbRVCQS2yj37mB7CmHxeWGx4TASDwktx2HmE1K1LHkjK5Ln
	DgRCbs22iUbyYHZEHAVVKzkEknGlMmMzNrvP0BWYZ8cXm4iRDknM1ZEgV7abHRElC1w17r
	+HlYu8+0nPESVaKH/vBiaG4ua5pBqjDm0DgPhJHyLCnDVOwwfg7Fqibo+/Wq1Y3qVMf1wd
	BcThCt4AdWsbKUew12TQrzWBoqT0kSiy2mQL7UyTvYde1vHfJJ92JROw8eGclTOL3G6syf
	FOecWfcUd2ZmmyokGFeENCWqX6kRAD9/Vm2PBR6Uex0yt2xRhKrOhl9hlQmO0A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 31 Oct 2024 18:53:33 +0100
Subject: [PATCH v13 9/9] drm/vkms: Remove useless drm_rotation_simplify
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-yuv-v13-9-bd5463126faa@bootlin.com>
References: <20241031-yuv-v13-0-bd5463126faa@bootlin.com>
In-Reply-To: <20241031-yuv-v13-0-bd5463126faa@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 Helen Koike <helen.koike@collabora.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=uUawjcWkSnRz6+496bAdLII+36tesOT/CJyAg3irReg=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnI8Qdxj/4TIdGSmYfMyWUFQIdhiq6KblD+ndAp
 eBco+NBw5+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZyPEHQAKCRAgrS7GWxAs
 4nN+D/0Y/PPTh8mB2hpdcBh8KHUn5+3unK7HT1v3J+RNHjd8DFXSJXb8yOeCyC1xjNBOWyPqDOf
 mbRdhBItZXGKGC9fEivrH5VaHHKCRrCtOVMQsdWsLAvupBlVu5VALJmFl2FoVqLmXXg/kWDFUH+
 Y3ArXklQC/NupCY5+bq9M4OlhfCvEoVjPbzfnoiqfs6zy6LTNQIErZXkl71Qf6Fg2pAPdN7ikVK
 ml4XfsjEFisl17wOmZu1fpg4hjHDZ9a3RseXwuk16g6TJgZKAed4qTw3PVRB2umelRfjxuSQncc
 7JOuLNPGTaFQ1V/vRl0jviqBhQmIiZ9+ym5E3SLqir1tS4WPVk0OsLZzL2Gjie3LmMJjouo8UpF
 UEPIWRChQGrSG/Pis0nuGBxEhElK+Q4xh2ltBO+xZimEp7HknoBxTXmxyLTMkbwIOMDR1O5zxcE
 ++seqV41DGbzGt/mwpXjNeHIpfvg4LirIJcHbq22oiOmYJKoFktFoLYSql+T4jLf/0pJ9TKvXvL
 SWBv6Aotea1qFEDZBuKbZp1rZ9ZTRuywXwAlQtf/CWtiC6RvSZSNnoausL16h6PkeK1GxrhR7XR
 ICw2WxUAPzK6Z7tnyOEJ+2iF3u+gw/CksZjKfjgTJBCaIaJSRC3tYwarfs5Fff7UkM8/09jns0N
 j47XNRFTd3JQhTw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As all the rotation are now supported by VKMS, this simplification does
not make sense anymore, so remove it.

Acked-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8875bed76410..5a028ee96c91 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	frame_info->fb = fb;
 	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
 	drm_framebuffer_get(frame_info->fb);
-	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
-									  DRM_MODE_ROTATE_90 |
-									  DRM_MODE_ROTATE_270 |
-									  DRM_MODE_REFLECT_X |
-									  DRM_MODE_REFLECT_Y);
-
+	frame_info->rotation = new_state->rotation;
 
 	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
 }

-- 
2.46.2


