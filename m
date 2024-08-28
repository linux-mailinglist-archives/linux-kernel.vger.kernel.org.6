Return-Path: <linux-kernel+bounces-305253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAC7962BED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6CD287925
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F61A38E7;
	Wed, 28 Aug 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RdwHPzvo"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7283A18
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858212; cv=none; b=InsYKfQEh8Els4CdbMY4EjAENOwYRyBDDKpW82qvPiVefAOWh6as7mLiVIul7ZGKUZusf379T3Ms6ZzQdJGT4VJ19YpVhBpozAPJUHkoVS0qxjjB7fA5a0x7iu0CEoR/PNl7BvBY6cF/DCqiSMG2a8xuIPLlCHUKvj4G5aSMsGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858212; c=relaxed/simple;
	bh=xSsUE8O0OBLsJlAbTZSDyVIm8np/3o39QtfG850Mahs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ip2zrHslgA/Zofkq8H4V+rFDd6UG2/KpO5Mj6VgitxnzCUczkjiNMy+iXTUMfse2oe7cwjeqdSecoBzHYXbPJTcseiLS5XHMw3Plcv5cXjwpsZv/Cj/Fiq1PA5MnnYlaJWsnxwHzHYjFf6WVKTUoDCKYtE5Tey/AiGcxe08HtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RdwHPzvo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so5655615b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724858210; x=1725463010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGorGxckmvbXxL6wgNnUsbdoW3Ac8a0ImG5glZMucZ8=;
        b=RdwHPzvotPt52kSEm+lfiPu2J1yWJAJ/aC05lzjdNpsK37wFi/Fu4pOlDr24J3fi7u
         xsljEsFxlWq/QxDc9YO/9bX8usuzP7qsYiOBIo8l8+OK56ud+XtwDXpKQ4eEtiWuPBSN
         tzCOMLlRcDpIajQ4S4O4TAPgL767foRtdMr38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858210; x=1725463010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGorGxckmvbXxL6wgNnUsbdoW3Ac8a0ImG5glZMucZ8=;
        b=lhOExnIeBf7qi2j+bzX57N4W1yKZ0zOfRVNWKCJ5lwshiFeT0YGTBpFg8Ay3Dv7aEK
         8WhUxFD3OqRpKSE5gP7dQRHvXZ6jg4l3zxQtEXhHfPQClrMqFTO3GwBqchqZzLKmo0XY
         U19x64pWGMvF7/ZOZ9+1/D4XII7XYp/fjBN3jq1TFr+sXMNJvWTyhM0NFVnKoueIwJfV
         l4uRxqeuO7j/QdAo9JYuKIZhHTGHH3SZuRu3+3XSxOz7JMvV+cr3+rLYav9tpOy4gYks
         VPDmplEjW5lC0oH+g5CrNHA6ILu2aRS3xfIeqOykC2aa/J0uCh185Vr9dx4VAi4eAc4P
         dYQg==
X-Forwarded-Encrypted: i=1; AJvYcCVL1KFoC3j2CHnm2c5NkSvR7Io0yat5cu6W8dPGpG8nfAQ17Ub9EWDluzPD71qUmRGcT07QbhVQXY7Ht2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNbMHDJjSI4YpTFBo6YYBJkzUovGDPtkJEO4lRiLtchJ6QzQo
	whcafhFl0jexqvbtifT2n6W4KccfLQetzuhhHR0dJwIhJGm7B/McBA97eJDCpQ==
X-Google-Smtp-Source: AGHT+IHh7AFyXRDDkAshsWM9475dqzQbE9aMYa4K9mjb6QVCeNbGlYkoS7LO5r9jYiUaTcHHtxhNHA==
X-Received: by 2002:a05:6a20:d492:b0:1c4:a7a0:a7d4 with SMTP id adf61e73a8af0-1cc89d15ec2mr21365161637.7.1724858210082;
        Wed, 28 Aug 2024 08:16:50 -0700 (PDT)
Received: from fedora.. ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430608csm10273508b3a.153.2024.08.28.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:16:49 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jesse.zhang@amd.com,
	alexander.deucher@amd.com,
	sashal@kernel.org,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v4.19-v6.1] drm/amdgpu: Using uninitialized value *size when calling
Date: Wed, 28 Aug 2024 10:15:56 -0500
Message-ID: <20240828151607.448360-2-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 88a9a467c548d0b3c7761b4fd54a68e70f9c0944 ]

Initialize the size before calling amdgpu_vce_cs_reloc, such as case 0x03000001.
V2: To really improve the handling we would actually
   need to have a separate value of 0xffffffff.(Christian)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index ecaa2d748..0a28daa14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -725,7 +725,8 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 	uint32_t created = 0;
 	uint32_t allocated = 0;
 	uint32_t tmp, handle = 0;
-	uint32_t *size = &tmp;
+	uint32_t dummy = 0xffffffff;
+	uint32_t *size = &dummy;
 	unsigned idx;
 	int i, r = 0;
 
-- 
2.39.4


