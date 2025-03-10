Return-Path: <linux-kernel+bounces-554997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE62A5A448
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8599C3AE7AF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0314B1DF256;
	Mon, 10 Mar 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="XRFB2hK9"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82D1DE3CF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636839; cv=pass; b=mGqLt43DjoDDafR5fd8qg0DambAv68Mvk+cvJSvy+QzppDepjkCdF2ZIM4gZNuKDveh+JZZC8bqaMLrUfwu7/We/U+xNF/vaNDXD9dOxVemjyXLJ3yjMVnf08ha50RhTPoEnr4p3GyZnpSmDtPmdpT/mo9Hc/Dv6FLxxYcYwjs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636839; c=relaxed/simple;
	bh=ah/fq5zpq8WdWRvwRTwcYeVhY8G4vnjYJDvQYIjd9VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjBVzKgT5E3hhetQLwZQGwz+5fflBGAMwFD02pBgnLff2cUOVzTqR9hK94aZr5EZfn+Xg9LmW4p+tlQI6nuMMUXbOktxm5wdclXDZ/jjcwg/mrGScxsPkZvKZNkCpk4embA+/BOg00eb6XGcBPESVvR2x5qDAfb9OdZJJLrUQOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=XRFB2hK9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741636816; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qyxr3aJkeBQAq0L6yjvx4RPkXyFEiMxLPcg6PjjDqbYBfC6EIxrM7c3oXROTecwsy0llDeAGgCVobyi1raYrYovEmi9ugwbRdJtnx1DQgh18kYql9G0SiCZn6Mr4xx3/2zlEKFNvTL+krZU1z7eUnAxjdcGrpP0QGnc4qF4LlkQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741636816; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZFdaB7brRwLIqNemNPKTG25GbzNbXSuAOMUD7Q7r3hc=; 
	b=MIqBBl36ZSvjTnWbQfb7iDBMKvhL2sW8Ae+r/YYNiYuyr6bOmjNKp6xFWjWr14/nlsc0o24rA2atfDLi8B4NXNkmbVLGOd2gSOMXT2CXOG22DG42GqDncj9krV0VVhFBAYx2piA5e29c3UDIrzhP9AUGqbb2vOH1+70fKvnFiFk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741636816;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZFdaB7brRwLIqNemNPKTG25GbzNbXSuAOMUD7Q7r3hc=;
	b=XRFB2hK94KDo+X/2ol9lRhnmk62XqlLS4u/WptOz30sIj5qc6tC7UxaCtuf0AkPI
	6miSmXzgg42EZpN5SyzRZZXLBYVaxRVJe0B/RLcJpyO7ar9tfplJ5JZTCmX11DZDwwW
	QEJ7Y1ZPxnc6rsuyL8lPygnXwV3YwKRN169eQELw=
Received: by mx.zohomail.com with SMTPS id 1741636814321993.7241909367491;
	Mon, 10 Mar 2025 13:00:14 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kernel@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sjoerd@collabora.com,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [PATCH v1 5/6] drm/panfrost: Enable AARCH64_4K page table format on mediatek_mt8188
Date: Mon, 10 Mar 2025 16:59:20 -0300
Message-ID: <20250310195921.157511-6-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Now that Panfrost supports AARCH64_4K page table format, let's enable it
on Mediatek MT8188.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 0f3935556ac76..d7b8bded6d784 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -824,6 +824,7 @@ static const struct panfrost_compatible mediatek_mt8188_data = {
 	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
 	.pm_domain_names = mediatek_mt8183_pm_domains,
 	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
+	.gpu_configs = BIT(GPU_CONFIG_AARCH64_4K),
 };
 
 static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
-- 
2.47.2


