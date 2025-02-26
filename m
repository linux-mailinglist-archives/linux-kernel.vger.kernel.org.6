Return-Path: <linux-kernel+bounces-534388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A290DA46612
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEE87A155E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D26D218ACA;
	Wed, 26 Feb 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPT2cpy7"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5C28F3;
	Wed, 26 Feb 2025 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585962; cv=none; b=ivDmArazTbou7nmZCcmzRQz86biQJxtyvN9jhVlmgRra6SsVG/d0CiT+L+XcDgLv1x63PVEHoXf/JZInl8VNriOMua7BGM2mzbXkTv/GpYJZpu8L7+obSE1dkMPhHn24hgb+8T+kV8kXV0H3KNZSIKxxoSFPQ7H1bJEyweynhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585962; c=relaxed/simple;
	bh=50SyHSPsZ2sNe0rMMqCy3BVIW13LLvsvmYC10oh50Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hD/mFRbHf1UO+h0je6MT8XiBcxscXvQGnecg3TkT39OSISvoqP0Lym3KdE7O/2iWvVwb6BESZjnKS5ikJG/eps/CAZ0hZ3pYnaLkuT86cqI9gjQwY0txMaL9uNWaGsjzMhj8AtE7Xmmz2oJscn5xAQaTOU20Kg00dq18OGwz1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPT2cpy7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390d6b29ba4so473645f8f.2;
        Wed, 26 Feb 2025 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740585959; x=1741190759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sjm0Buwjwxm+WDev80/Z7KsjHHkctsu1ONm9k/3wnjM=;
        b=PPT2cpy7HK3Bms1hWBFu3rSo9JJXFPxN645jZO7VaUXPoDO+3ByeM8D0s4Ampt52ec
         RFsiSBkxxtpOuyamUzJWEmMbIwNdFQzRxUv8G0pTwkmR42DPQlv5unRRi9uyHoblHCA7
         ZfmbOW9WeciSZOItLnljxjyWJT7n+HQDXqxvtKv5Vu3hHzgXJY6HHEbhofsOhoi2URIE
         rG3zmIvVgf6QQe1rUVxOlKnJwOThAOm+34PY/Hpk5yEkWnw+bCrjsGHKMedAA3t6GPUh
         8hW0NzTy1PwF7JcKfVH9E9Btoe+uyiAdPPuV0NjeyE4/SfQwt7R5KGaVhyczWBYyx2iF
         77tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585959; x=1741190759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjm0Buwjwxm+WDev80/Z7KsjHHkctsu1ONm9k/3wnjM=;
        b=Ki7qtdJcudpljODtX4a52AjmDLhkm58a3yZP7Z4Neh5cuxh4lTMc86rgninigob1ze
         vLG9V/xF/tuL1FZTdBs7tlFbgq78K7vPpsK3qgkCsRrWIbBAUEP/r/w/lhv5YFjhhYGx
         Ev7gVTTRM4UxbcJeVi4Ah05ch7HoRBd1qlDvdWGM1Sop6dEzpB3GF6s9ycnJEI/sgm3g
         9u9vhBDz4cETWh5FkVXqWdi7nS7FjOEIaioV3L5x1ufERIY656cXem3P77XioTdi4V5P
         Ai9YWR6aQPoD/tPTdjixFj1TZ5s9NPYJoTvr+XinWO9r4R2yjyVUoNAYcguWGQ/Z0GHu
         PSsg==
X-Forwarded-Encrypted: i=1; AJvYcCVlQiRK8L2YY4Iw40Dzr1mVpF3MsABZXzPtLGyucuamL+VWS1AD21c3OhOpZVv/Nc72OmGjdaHE/EeAstE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1N2ouvQsUt5CqDxy89eOswmJDQeS3sZZ8AsO27on8IqpAkAw
	ce5cn1iMhd6ZThOfNsuq7fz9vOpAkjGZVzyiinom+vYaA2LNDuDU
X-Gm-Gg: ASbGncu9MCq1qJB6+3kct3kC5NA2FKip7U4TtVrrNCMfgKpo/08N8ikNqL7xpqqay3d
	fhV5Ct5TtzxVn9uJhrfdmHRrljDRHgTUgJF+D7rO0CUj4E/fY9qI5+a2h1ELI2cEf9/A2rJDGo+
	TwSbGO/vJSdt+kTPln3OZwnis26TTagLs+LDmBk3vlCwjqt3S+e4hKac8J6CGh9BQJTMzUvH+tt
	w4B0c4nB3oyhwpUmFfsPVRqT9fRqwjmajhll11yObFiJXBa7c/KQit7hFPy9js5NhsETQKizset
	9rgpo+eMvoKYBVzeJd1XxxIIZm8=
X-Google-Smtp-Source: AGHT+IFVFHkpnnU9VW7aOfIZgP4iCvawfQNvVOj9zraHTLvEMvl93gNJtyixpuT6X2RHpxCfcLJtrA==
X-Received: by 2002:a05:6000:2c7:b0:38f:21ce:aa28 with SMTP id ffacd0b85a97d-38f70827b21mr15686879f8f.36.1740585958499;
        Wed, 26 Feb 2025 08:05:58 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390cd8fbb5dsm5943880f8f.84.2025.02.26.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:05:58 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/xe: Fix uninitialized pointer def
Date: Wed, 26 Feb 2025 16:05:24 +0000
Message-ID: <20250226160524.566074-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In the case where a set of checks on xe->info.platform don't assign
a value to pointer def the pointer remains uninitialized and hence
can fail the following !def check. Fix this be ensuring pointer
def is initialized to NULL.

Fixes: 292b1a8a5054 ("drm/xe: Stop ignoring errors from xe_heci_gsc_init()")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/xe/xe_heci_gsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
index 3ea325d3db99..27d11e06a82b 100644
--- a/drivers/gpu/drm/xe/xe_heci_gsc.c
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
@@ -173,7 +173,7 @@ static int heci_gsc_add_device(struct xe_device *xe, const struct heci_gsc_def *
 int xe_heci_gsc_init(struct xe_device *xe)
 {
 	struct xe_heci_gsc *heci_gsc = &xe->heci_gsc;
-	const struct heci_gsc_def *def;
+	const struct heci_gsc_def *def = NULL;
 	int ret;
 
 	if (!xe->info.has_heci_gscfi && !xe->info.has_heci_cscfi)
-- 
2.47.2


