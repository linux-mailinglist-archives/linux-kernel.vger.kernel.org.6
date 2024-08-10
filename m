Return-Path: <linux-kernel+bounces-281877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B794DC62
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 13:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAEB1C20D13
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779B15747D;
	Sat, 10 Aug 2024 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaRQpTCE"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A382BB10
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723288055; cv=none; b=u4dskoS4mOeq+rseBFtwbe2JTgkr9AF/Bv1kR0ABuME9LEfRTMvjioewV5OYfKmhuslxO5yS6GzfAV44kJjpDfWvGDmnvD+IQ6BziSWLW7h3+ayUm00n5qIwPZg2GZaNEzRrGmAXq6ypxHdWrHPCo/soCrXg6pqtHg17XmIWiX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723288055; c=relaxed/simple;
	bh=rFAusYgtmmqsH3RI4wnt7lrKP4z/e3ShRxt9BnDD7ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XeejL4EC+Y4cnWc1C0ImV18IYzyDQ1/u0ca1CXV4tHKJwVN8G0/TXxE+CM730RusZi4DrZS2tjFO/l+nl/2g7ZDIIKWtZGjTnW32dpaCX8e0BK0+dPyH7ULTsvA1ZPHXPyyIR/mDFb7roAKNftNy4fMM6u+wabZpYolZnCmAug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaRQpTCE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fda7fa60a9so24604755ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 04:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723288053; x=1723892853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WjGa1PXf2QdLqPrY3XfFGhbeSFb6g3387jwXF6umc8=;
        b=XaRQpTCE6l1crW28dn55mY9JhMVtC1lcFxi6KU18TwnnwjB1UQSpgDPcHoT4mLHRzj
         EFd0TmnATAzoJgIwvEIWNuvNeTqN0ElheEW1Dgn4xBTw1dctNtPHpbqr6en4DbvRJyQz
         rPyzv7tT4hW9wZR0cFlNBQ6IitN+wx/eAj+POU0Y7zImJuFLKecB3Nb4N0JrEHl63Bwt
         fcTFWDpKXiCba/yIbZxDi3a4K0cadnFRKLsRWBT3mnLaWRg/YF26jU2vIMPJSg4H+92C
         s18H8u+CI/kahqytH7uOyZOw3w4lJVAi6QVMFRtWs6vCFvjIa+UCA2bTHAtZfqe5ILwQ
         xagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723288053; x=1723892853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WjGa1PXf2QdLqPrY3XfFGhbeSFb6g3387jwXF6umc8=;
        b=TKq3ESaKJgpif12PzazKPBM7RGYebZeoMewlljYMe+uF8qv+WpazKJohDigfvHWwXj
         73VWNBTK48UIBFQLiCa3GXb92wJm1o4eCQBy2t7DHwaZAESczhGmADjx1vXBDwM69JBe
         P3lrNsORMSBbgPyFTKyWITHfeBZY9kV6bjGvSF5mXXq/UvB6oTWB60xrZ2qLmgSmx5LM
         Un1bxTLsfJqVeFbvohKfHJt/vVlgGNbTi/jggHnYyDment9aFICiuIkoqbF9vj5xvLPZ
         J/wdTHTbD5MHwoGY5UBS9UAOdNo1n+qnEKYJsP7i8BnLODLRlZ9NjDTRNxroD/uWDu66
         RpaA==
X-Forwarded-Encrypted: i=1; AJvYcCWBLVICFcNgF88mzu5f6GP5IGXjL0QN0T7UoZcC5Cf/gpGl5YKYbJFI+ir9hT5iuVk5+XL4ZQ10RPvZV0kMBjnst4yS/e8UlUdcpHlY
X-Gm-Message-State: AOJu0YzVS8ZvD9P77gvIOal7aWr9Wq1uyGbYYQMH00OWSPqMyi2EIc13
	xNGL3dckAIKRl3+8msGwlcSlP0jyHhvQghiU9zmZGDTh08SCiJzb
X-Google-Smtp-Source: AGHT+IHolzyz9S8pd+GOOcW+1R0bING8PpCkunpPTukviWMZPY/lvqyK2Uo385BypufhWs90tL9WEg==
X-Received: by 2002:a17:902:f689:b0:1fc:5879:1d08 with SMTP id d9443c01a7336-200ae550755mr57229755ad.32.1723288053298;
        Sat, 10 Aug 2024 04:07:33 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9038fesm10002735ad.114.2024.08.10.04.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 04:07:32 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	airlied@linux.ie,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: drivers: gpu: drm: mediatek: Fix warning: Using plain integer as NULL pointer in mtk_drm_gem.c
Date: Sat, 10 Aug 2024 11:07:23 +0000
Message-ID: <20240810110724.174338-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparse reported following warking:

'''
drivers/gpu/drm/mediatek/mtk_drm_gem.c:290:27: warning: Using plain integer as NULL pointer
'''

This patch changes integer 0 to NULL.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index f8fd8b98c30e..885ce6ac7bad 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -287,6 +287,6 @@ void mtk_drm_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 		return;
 
 	vunmap(vaddr);
-	mtk_gem->kvaddr = 0;
+	mtk_gem->kvaddr = NULL;
 	kfree(mtk_gem->pages);
 }
-- 
2.43.0


