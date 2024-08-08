Return-Path: <linux-kernel+bounces-279392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B8194BCBB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3501C288410
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E818C321;
	Thu,  8 Aug 2024 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="DjMy8tRg"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1914A4DB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118348; cv=pass; b=qMjIgSad3pqB6PXYk7FejRS65ZnhtYLhFZ1sJkeRlNDBKTGYlnUql4LMZXIxEc4G0btJFWYoUJf1DU2w52+iAA4dHiwy13nZRzFb3d2gpubBAMCs4PQAvd2rgP6AxVG20aparNURTL75dguBttSMl3U8DPxVNz8xP71zQ1dio7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118348; c=relaxed/simple;
	bh=nReUeCfu0CWsDznqy28R9hABGAxhx4dJUGmumEBXJq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b8vp60tyWt3UhK8RrhAfzSWhiW6msMhofobuZNinjdTLIGMKGWwSPIGY7mj+k0VqHgoNrYZmViLTFEv7M8cc5zSo7doKBTXU6kR3AAkbJA+uv9Mwh8Aqkp7UGzT2p7ytmwAcMWQQe0TSYqV3vltmKyQtlAzsIp13dViH2yzRrbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=DjMy8tRg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723118318; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mURPLIA4vd7lWdffQkpZXcs3WAN+g6N1oy/1Aw9AaQc3FkZSUGq4Azha/56zJ7gy3Be8SSeeKUMcBGXzQf4/H4Q7ObkO8JDaojKQkXyicJB/SzNX007HaxPR7BCXXURaez8KTQvCe2x++C/aYzTfrq/l2d8V+st2EKX/Bpdhlmc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723118318; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WMDBItI2xogayssnAPBndPmg8HyuNPCtZlERCJnLHAQ=; 
	b=kvbzknc31A9FHaiMDjqyPSVVgRxW5VLnQlX61scOWrw+TjhXJzyV6AgHI8dD79tFRCz64iM9F8C+Iwz8CnPNF9LjfVkh7ujzfdrxI3d+LsPWOljGt4lnRO/FV79QSP9Ej67V0Niuo9l3ZkuXEcweo5E12toCsrmFp2LZ+QnEyN8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723118318;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=WMDBItI2xogayssnAPBndPmg8HyuNPCtZlERCJnLHAQ=;
	b=DjMy8tRg+xKo2lpOY9ZK0xWCQP3Ov/9q4yCqsKDjyHTv/hhKT4nr7nusEHsAusaT
	D8iWzJXQT0IrKG6m1drCEnd+3qS2mAXW62JrgtIBvs1DzfJTnBaUiW9bYXWOYDtk5fh
	Im54m0QoMMf8H4ri3hxTXhV4yoh1CCivTfICcV4o=
Received: by mx.zohomail.com with SMTPS id 172311831804658.98418777154552;
	Thu, 8 Aug 2024 04:58:38 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 08 Aug 2024 14:58:02 +0300
Subject: [PATCH RESEND] drm/rockchip: Unregister platform drivers in
 reverse order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-rk-drm-fix-unreg-v1-1-c30d9a754722@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sean Paul <seanpaul@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Mark Yao <markyao0591@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

Move rockchip_drm_platform_driver unregistration after its sub-drivers,
which ensures all drivers are unregistered in the reverse order used
when they were registered.

Fixes: 8820b68bd378 ("drm/rockchip: Refactor the component match logic.")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 44d769d9234d..ca7b07503fbe 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -528,10 +528,9 @@ static int __init rockchip_drm_init(void)
 
 static void __exit rockchip_drm_fini(void)
 {
-	platform_driver_unregister(&rockchip_drm_platform_driver);
-
 	platform_unregister_drivers(rockchip_sub_drivers,
 				    num_rockchip_sub_drivers);
+	platform_driver_unregister(&rockchip_drm_platform_driver);
 }
 
 module_init(rockchip_drm_init);

---
base-commit: 1eb586a9782cde8e5091b9de74603e0a8386b09e
change-id: 20240702-rk-drm-fix-unreg-9f3f29996a00
-- 
Cristian Ciocaltea <cristian.ciocaltea@collabora.com>


