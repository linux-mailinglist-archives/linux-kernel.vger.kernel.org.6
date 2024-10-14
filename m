Return-Path: <linux-kernel+bounces-364849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348A99DA36
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2421F22BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B0F1D9A69;
	Mon, 14 Oct 2024 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="KaHF8xR1"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A91CBE8B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949119; cv=pass; b=KErsoXSrR46XCaOxoCGn7xxo46QlqecqnXLt9J5+5fHTUBQP/fWf3eRDCUG7fbgevN9bmUizl4ShbfFStpFoqvphm/LiEwQ0XAVzbr4Ivi7X3LBPK+VqGTupI4n/8yeSNKGkxFcyfUREkfOyGDo7aSXyyASblEsUbNFh+ZyyFxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949119; c=relaxed/simple;
	bh=Kk01Uizugu1TT401a3KVO1Wg0J6F1PxS1oYcj0lEjnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWhnVRYYvP4PaXnqDH98bu4VblKcV0iFk0sNppGJ/PTuE/ESKfIemS8SN1Rm1CEfeWhNoTRtAjMmQBMrLTm+9H2TgE66d+J3UqCXluCcm7EywVKfeaXqBozUknqDt6rR9SmJdUvSiAgiukDIWZL/MLKegwz0iqVIwGLZiUAwjPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=KaHF8xR1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728949104; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kVKSjGik3bjfLBJjsLq0SWvQ3juOsJfwBDu1yb3Nr1ahJRVoq5OVArSZHrQroPzd1MKOLUZPDIJBuGjCvqz49LDfKyv/DvTmljnvhlQaL0z3nhHEbsDvnUwPIsTDH84yI0RF40GI1XIUdx5ABzTGcnLNmX4B83L7XEObZafkEvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728949104; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=al8Xn/8UqgDHT3bmnOEB4UV/humGKMCDi+xS3R3ARNo=; 
	b=WUonxg4QVQ/yDHh2+Y8cUU7y7gHIp4U/SXL53rnC7IRSaxu6FsRrNTcpCezrX7n8O6ZO5DLYsT+EiP3DNftC5vbpBRaDziR6BuGII3kOVDOoYJ3cLg5QQDU4y6UUclafTF9JYxSwv1FyVxuaQOrFx3VCoI73Qrjo8JJW8hslgac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728949104;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=al8Xn/8UqgDHT3bmnOEB4UV/humGKMCDi+xS3R3ARNo=;
	b=KaHF8xR1r1lp+iZ1gjkXjy8omTs/ChIk5Y9MUeNKly80XuUzEl1Q6b7WxELtfb42
	yPp/lslKuo5MSGI0O2lnBuHqerJpGQ6RfCXl2gvRl9vAPgc1A5mf9nKWqd2d4edMh0N
	bLwezTzXEXCyUDg+kju64jQNKHMJX2+U+7v7OdRw=
Received: by mx.zohomail.com with SMTPS id 1728949102859440.9679979166202;
	Mon, 14 Oct 2024 16:38:22 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] drm/panfrost: handle error when allocating AS number
Date: Tue, 15 Oct 2024 00:31:38 +0100
Message-ID: <20241014233758.994861-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014233758.994861-1-adrian.larumbe@collabora.com>
References: <20241014233758.994861-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we reach the beginning of the LRU AS list, then trigger an error.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c     | 4 +++-
 drivers/gpu/drm/panfrost/panfrost_mmu.c     | 8 +++++---
 drivers/gpu/drm/panfrost/panfrost_mmu.h     | 2 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 5 ++++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index f640d211cc3a..f0a4690bcdf9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -213,7 +213,9 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 		return;
 	}
 
-	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
+	ret = panfrost_mmu_as_get(pfdev, job->mmu, &cfg);
+	if (ret)
+		return;
 
 	job_write(pfdev, JS_HEAD_NEXT_LO(js), lower_32_bits(jc_head));
 	job_write(pfdev, JS_HEAD_NEXT_HI(js), upper_32_bits(jc_head));
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 2189e42d2bfa..8514a02d306d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -155,7 +155,7 @@ static void panfrost_mmu_disable(struct panfrost_device *pfdev, u32 as_nr)
 	write_cmd(pfdev, as_nr, AS_COMMAND_UPDATE);
 }
 
-u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
+int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu, u32 *asi)
 {
 	int as;
 
@@ -197,7 +197,8 @@ u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
 			if (!atomic_read(&lru_mmu->as_count))
 				break;
 		}
-		WARN_ON(&lru_mmu->list == &pfdev->as_lru_list);
+		if (WARN_ON(&lru_mmu->list == &pfdev->as_lru_list))
+			return -1;
 
 		list_del_init(&lru_mmu->list);
 		as = lru_mmu->as;
@@ -220,7 +221,8 @@ u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
 
 out:
 	spin_unlock(&pfdev->as_lock);
-	return as;
+	*asi = as;
+	return 0;
 }
 
 void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
index 022a9a74a114..0b2c0b59db3f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
@@ -16,7 +16,7 @@ void panfrost_mmu_fini(struct panfrost_device *pfdev);
 void panfrost_mmu_reset(struct panfrost_device *pfdev);
 void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev);
 
-u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
+int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu, u32 *asi);
 void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
 
 struct panfrost_mmu *panfrost_mmu_ctx_get(struct panfrost_mmu *mmu);
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index f30817bcf8ba..d3436240f847 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -130,7 +130,10 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 
 	perfcnt->user = user;
 
-	as = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
+	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu, &as);
+	if (ret)
+		return -EBUSY;
+
 	cfg = GPU_PERFCNT_CFG_AS(as) |
 	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
 
-- 
2.46.2


