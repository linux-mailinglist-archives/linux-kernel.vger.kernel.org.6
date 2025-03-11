Return-Path: <linux-kernel+bounces-555951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA48FA5BEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5217A3D79
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427FF250C1D;
	Tue, 11 Mar 2025 11:16:18 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D08B250BF7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691777; cv=none; b=bmzGlct8gOaE9zjN26+eyTN9ebOsYYar+xG3juisAsFmKb4FbtwhDKWMerklhnNl+WPcbO6oYJkDfBOw+Tv+nH0l6O1bjEW2IgA1b334wvZnvW9F2bGqdNqL2AT7RfwU3OOZ/srvNnrJA66yQyt57S6LyNNC8sXmK46PuHBn6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691777; c=relaxed/simple;
	bh=XG/rSXLaOcL6k7H140eanA/VEB364+N4FRu/KpUN/64=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HPuVD6Jweh51wJQXZgHA6+szH7Q67GCmc0jHAMRA+HLGtZcyI8iK01P0+N3pTL/k9b/4ZVHYtgRshUFT+co/scskYrnGo/kM03c5xwfUcfXNXdc8Q1MHCSEhc4GRnUSTqQ6CObYN8p3QRpmVthtjhqXZN/JG0htOa46sZ244WDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 11 Mar
 2025 14:15:01 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 Mar
 2025 14:15:01 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Alex Deucher <alexander.deucher@amd.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Xinhui Pan
	<Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()
Date: Tue, 11 Mar 2025 14:14:59 +0300
Message-ID: <20250311111501.9190-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

On the off chance that command stream passed from userspace via
ioctl() call to radeon_vce_cs_parse() is weirdly crafted and
first command to execute is to encode (case 0x03000001), the function
in question will attempt to call radeon_vce_cs_reloc() with size
argument that has not been properly initialized. Specifically, 'size'
will point to 'tmp' variable before the latter had a chance to be
assigned any value.

Play it safe and init 'tmp' with 0, thus ensuring that
radeon_vce_cs_reloc() will catch an early error in cases like these.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 2fc5703abda2 ("drm/radeon: check VCE relocation buffer range v3")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/radeon/radeon_vce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index d1871af967d4..2355a78e1b69 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -557,7 +557,7 @@ int radeon_vce_cs_parse(struct radeon_cs_parser *p)
 {
 	int session_idx = -1;
 	bool destroyed = false, created = false, allocated = false;
-	uint32_t tmp, handle = 0;
+	uint32_t tmp = 0, handle = 0;
 	uint32_t *size = &tmp;
 	int i, r = 0;
 

