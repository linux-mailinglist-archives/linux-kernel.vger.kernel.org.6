Return-Path: <linux-kernel+bounces-334170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C551497D373
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E12128219D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C52139D19;
	Fri, 20 Sep 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgfEmQPa"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A520136341
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823412; cv=none; b=lPVBZNm4ziE5dn0xdELX7XY096m64q8LgBLa1NUuVW9IMI/JyKOl8ocoZoAqsYLqzBgLix5LvIZwL6DTNLnZGqaKDM7r50j2A2YMFHKBzbIPXOLDfD/oeHGjQHVVzdLQRPp2PhvS+OxzbfQPfcHtNN3dDMhd60Lgq0ROAWxAVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823412; c=relaxed/simple;
	bh=Th4wKPFyQncfLUvNbN3KixRu3cYwqzSdItC1CZxmc4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZlFx0hzTLb0LUnbS2UwnrEVL2f+3uLSYwOqkD7B50aHzwVl4qrKyowzjOdRcP1T6fvCURZW5r1XioD8tKFDmLBBdGL38rnpjYol+vRme21pxK961pqMQzqAIqnw025128zx4KFp7vQ1rZ+hU5O3TFhKuJ870nGPhfTU+ifQu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgfEmQPa; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1269018a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726823408; x=1727428208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QsjeiXcVbkhRS0S6mAuTlJso2qznjwKlAjYCJol6uhQ=;
        b=PgfEmQPaCmv3zNPSAj4Qg+8XeVL7/VlyaXIvIPQymuEq1ia7ObjuRkfvLKjIDXacey
         nZ1PDt5ruyARaPPWyiqTrwCEIOYnW16Q+ObViYzNE/AhVVgl3X+u0NB5ukfFModX+cHy
         o6vFDV6N45INx11h2xjx9AHZwnrwT/hOMLc7FkX1VOPvJL8XUu7IoVNVUZQY7OL6D9T/
         gvAQnnXAjpzFOiLT1t3c7X2xsgESGfdiNfTLa0QZipBIZ+rZA+N/y0aWk45K9prAbaOD
         1xnlkcpqp87l+JtGIGwf2WuyA56hTyaUlx+EElZFnm9HFe2ebbq1w2eXR/Rxe3ZZdkLp
         ALZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726823408; x=1727428208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsjeiXcVbkhRS0S6mAuTlJso2qznjwKlAjYCJol6uhQ=;
        b=hlIotmkqe7Wns46DCqxkJjvPiRfue/O9bu7v2DE5gHOiCM4uXhJyzowUGB8z2y4uM5
         VAMDjKniR3O5ZDTBuq1T9trl4u2TlKdsNy78OdAEdBqsT266cOg3r6gPToxSMqhakccr
         1ckhZidDsV6FLnHQji61v19kpin423BlaN60DQGxvY7xp7+A0xatqSVt8Qk4USfl+mXz
         /F26Lr55O//yqi1Adk+9rO67B2hbzVzZzjjt/fKvWFckNsS2K9U+itlWpDVC5Ct1B0Er
         D0+Qj273e41MEjTVNW7SclqjXeFd39ng/eDhhztfgnRYz8IxED9HvB0G91y0EPIlUf5X
         iknw==
X-Forwarded-Encrypted: i=1; AJvYcCXrvEFBA75MNux8WrFJsVih4+BpnIo94WFgAkJbOn2dQc/3SV0DIfgHlYrsf/Vyjuu+rzgpRDkHmGYPSWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLS3r0HOy1028yo6fyvXYKG18dP9oik2HJ/OyDmljGU8Wzw5uv
	/cGLIcUTZ8XMDlq8jYdznggRHnhwfRWNy4T2UjWKgRQmID2agOcE
X-Google-Smtp-Source: AGHT+IH8FAN48dFcmR+m08J6jb/G83Ca1mUzCilqajUAhPNAMop9IubRUvCxd+x0whCenAuCu2S9Mw==
X-Received: by 2002:a05:6a21:2d8c:b0:1d0:56b1:1aec with SMTP id adf61e73a8af0-1d30a9b4f69mr4170408637.35.1726823408509;
        Fri, 20 Sep 2024 02:10:08 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b181sm9455864b3a.112.2024.09.20.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:10:08 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: Felix.Kuehling@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: drivers/gpu/drm/amd/amdgpu: Fix null pointer deference in amdkfd_fence_get_timeline_name
Date: Fri, 20 Sep 2024 09:09:57 +0000
Message-ID: <20240920090959.30755-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'''
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:108:9: error: Null pointer dereference: fence [nullPointer]
 return fence->timeline_name;
        ^
'''

The method to_amdgpu_amdkfd_fence can return NULL incase of empty f
or f->ops != &amdkfd_fence_ops.Hence, check has been added .
If fence is null , then null is returned. 

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..2313babcc944 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -105,6 +105,9 @@ static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
 
+	if (!fence)
+		return NULL;
+
 	return fence->timeline_name;
 }
 
-- 
2.43.0


