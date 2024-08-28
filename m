Return-Path: <linux-kernel+bounces-304672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D690962376
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A561F22247
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD859165EF5;
	Wed, 28 Aug 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiHvfsjS"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B986154C14;
	Wed, 28 Aug 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837574; cv=none; b=QW2tBD8Cul3Qd/2S6WYfzLchkinElC0aPSfW4EWw4w0qYv2VTOd6F/+kLkd0/ElOrYHGOZlQ9AzQyUXJgueDF7dFvhF0ZG5uLSxMDZayYfTI1whWJNaeZEAzxnu9wDoonXFXYQ8kq2rT0lZqwzCk4pwur4rsORyysdPCMdrZb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837574; c=relaxed/simple;
	bh=C7CJ6sxhVfA6wEi+9qrcBIbF+BVzBOVHgkgIM2/lF8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oSam7eGg7C/P8N7/pf+qRWbT6SNFqZxu9OM5IvVfYlR688qKtBmQcQHbRIfL9qBbRnfkb+gLfxAG/AkFMjoJGlWuufbqBEG5lqOHhiYriNWonn6H0h4KOV0Gkvvw1VwDkaG/0TLYwKo74jvQWnixHHDrMg9cPbpf80I+/tsm79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiHvfsjS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86910caf9cso79097466b.1;
        Wed, 28 Aug 2024 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724837571; x=1725442371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljlQm4Z756d2n9EnFl4azi2/3XalhuzYi2PKJHl8biM=;
        b=DiHvfsjSWCUQYGrs4vkhqzDA88FH2/z3LAgb4fzyB032BliRdPZpdutG060M+r7510
         YBhBNoJMBwYftI9txCkNm6tmvFr4QQY2zae8cS+DuecHsphz16w4EC8Qtj7I2hSbzBsZ
         ikTENf6BOuDyYYJ06Mpu62XDOm360SryEOvSoZu+xpNAShxYSGghEQlUFfke96zYntdu
         SRz0R1nqAJRfbwy71+CipVkPfG5EgJzYVwckuTLeBozpe+rTykjn+N7mOrSuociLgjpH
         wlgufFqxGLI1e+rSU4QFQac41BFLVmDAUiEGHx2f7PGZckpKVE3+FGzpxE8Fymki8R56
         YR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837571; x=1725442371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljlQm4Z756d2n9EnFl4azi2/3XalhuzYi2PKJHl8biM=;
        b=OqBFQnEkQZrfwWV9KJnTgWN3JqHLNMFRH+Nqw8iYAHeCYCTPLeBkEs7JcQHbkUrKyE
         5gbKwTU5tzIF5cCuHPNUQrY48ht+mbjZ94BenCzTq7WC2vuAiSpGeZ/jr1MZlq26xA8A
         kcnyx7VAS3P37OFN5B02JSdKkUmTw8BWpBTdsXgEcLJ5kQoWgPdf1gx1ZC/i1ofwxd7A
         jvb2AHymhJV29IBqZmk01lDo6nLqzZ9MymJpLEUMNSuCu8UOOe3O1UhRV+gc2s1Id+i3
         RhMurC8O88J7TAdRusTTcGZ2xM6O3kyMxaMahVkI6Sl8OXHy2BZGlWYd+3O+PrScq7AN
         AewQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv4gPckn0vIZb4Y6JCuxEnbpPpNqdzsA4D5gSSMf7e4nSzoF1WuZkdLzqi1Ofl7/Hw+MIhL8wZrV8UNGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0yaI3vApsSvbQ9E+ROdOrO8F7iql8uitE1YVnt6QtoqaFbeo
	jjDWccgnns8Oqn21PMVP8xvl+8pAXXiVZlpB2g+TPx9L/FOATuqU
X-Google-Smtp-Source: AGHT+IFZqJB6vFvBK0EcgsYJ7T2OksI6qWVL0bPPi01r8q10EQ7avC39obDkdaWm65VsU3qbjrEM7A==
X-Received: by 2002:a17:907:7da0:b0:a86:a6ee:7d92 with SMTP id a640c23a62f3a-a870a9ba661mr180942766b.18.1724837571236;
        Wed, 28 Aug 2024 02:32:51 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5487810sm219558766b.6.2024.08.28.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:32:50 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix spelling mistake "recompte" -> "recompute"
Date: Wed, 28 Aug 2024 10:32:50 +0100
Message-Id: <20240828093250.271358-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a DRM_DEBUG_DRIVER message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0859a7173a06..669fd8fb6c24 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1325,7 +1325,7 @@ static bool is_dsc_need_re_compute(
 		if (new_crtc_state->enable && new_crtc_state->active) {
 			if (new_crtc_state->mode_changed || new_crtc_state->active_changed ||
 					new_crtc_state->connectors_changed) {
-				DRM_DEBUG_DRIVER("%s:%d MST_DSC dsc recompte required."
+				DRM_DEBUG_DRIVER("%s:%d MST_DSC dsc recompute required."
 						 "stream 0x%p in new dc_state\n",
 						 __func__, __LINE__, stream);
 				is_dsc_need_re_compute = true;
-- 
2.39.2


