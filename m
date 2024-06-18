Return-Path: <linux-kernel+bounces-218577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F68390C22F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520481C21C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456C19D08A;
	Tue, 18 Jun 2024 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GFVu13Kt"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878B19CCF7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679705; cv=none; b=H667j4t1LjiMB5XhoNSjZka4UdT8uqvdd1doqhGwFUVB/RCIdlqQiraogQ7awASlSEOfnrgqdJbj0D68IkTrm6zfOcQs5CwEdkh2XNMna4e1zCTu0kQGkW8NEKOUVZgrgLNMLi+xWQtCPIOfuj3fRwLNE9wPTuHrsSNcyn9QdLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679705; c=relaxed/simple;
	bh=sCUClTzD2JObfGh/mO2XuAk7lNhMTdPSIutF+zN5g20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlOgSMXDiC/cuJKOBdbQpmOkI80TxNsXbq2Av8tjstcMrx3x6pKkbIIoAZ5IA4zKfg20MFxd70pyjoSatJ5MGhRwfeJL9GXRe94+JdcH6sVPT4Twv6lW6fhI4GqG1+pjclwrkz4Eu6PzZqOlcRieVfOh7frpeuENBfM9wgP6lLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GFVu13Kt; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BdhCwS4heWTOgEoAfCAMOH7viYR6HmLk2/z9WGziRvY=; b=GFVu13KtKUkFjhgBslo86PglOz
	n/L3kEvhiUtVpiW1+e+WDGAjDfnuh8foVFP/CKf2TEH8tpjN3fYb23ELRj/LGzcRP6a3QOcn00L9O
	cdsqfnXxVDsitk6UnvkC/IICqoaFkJ/a450c96edzo+4B5cdF1s8/AmwNGGeKy2PPnH4z7vyTH0a5
	DkFZy0QyPKe6Klshelkne64A0Yyd83Bqp1R9QLqOZ7BH4C8zur19EKogYVhMI7VqsRUsCwcphyi0K
	3E0xDHY1+zTQdixFvWnztzgPzl/EswjKvocXThFik6Jsj3TlkrkUzQFbHBP73eaHWWT2XdZaCk71o
	fGLopoEQ==;
Received: from [191.8.29.108] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sJP6K-004YXc-Q7; Tue, 18 Jun 2024 05:01:41 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel-dev@igalia.com,
	Melissa Wen <mwen@igalia.com>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v7 8/9] drm: Enable per-plane async flip check
Date: Tue, 18 Jun 2024 00:00:23 -0300
Message-ID: <20240618030024.500532-9-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618030024.500532-1-andrealmeid@igalia.com>
References: <20240618030024.500532-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the generic "is this plane primary" for a plane::async_flip
check, so DRM follows the plane restrictions set by the driver.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 2e1d9391febe..ed1af3455477 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1079,9 +1079,9 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
-		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
+		if (async_flip && !plane->async_flip) {
 			drm_dbg_atomic(prop->dev,
-				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
+				       "[PLANE:%d] does not support async flips\n",
 				       obj->id);
 			ret = -EINVAL;
 			break;
-- 
2.45.2


