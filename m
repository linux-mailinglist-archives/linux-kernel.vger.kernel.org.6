Return-Path: <linux-kernel+bounces-247178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA592CC38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD77B23A25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A44584A27;
	Wed, 10 Jul 2024 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="dVAcPjKZ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259C37708
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597738; cv=none; b=IvAoBX9Y9KuGJi77AJZtZwf0E9SgaZ0MQKuulas1HvwkdBdAVqX7iu1uTIqjWkwYZB6CZOUWjGF/guJEUO9zeosLk0yGSQ31uXAD4wswrZTqAk/zhWeV+4IelfIH3qbhCWzisg6VECssU7R+hSsZ0wxXAYY8zOWrR/scsnvPnso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597738; c=relaxed/simple;
	bh=l57ULaTVxshBfT8ljxhHFmSRKxxjjQdae0gDKqMvOqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NitkbnC7c57uHXU/+SFZVpIcomBU0KLN56O+WO0CjwSJCEJUS32G8LlEncvOYj+CgDyE5gaBeB2TzXOVg/CxM5OB6xOrUSpnammV3KvbIlSnaM5VsTzaT7DbMd+W00mGoUMilrc1kml5OQHiNMxQOC+4UVstEACsHOiiOoUQUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=dVAcPjKZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e976208f8so6603089e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720597735; x=1721202535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNsDfIDnf4EzGjKDdcme11QFsKS3nMXn+3RFV1TKwBQ=;
        b=dVAcPjKZQbbmzoF+Ga0jLtPFKboNvgKH0wpVqS8GsYDL6B2QY5Hu9DO+ROJ63GBxml
         d+tzliWEUrHFj0GMxbiBqQfaWOpZmmp8WvcyXU5vARubm8p/efw67XSW5lK/yFN91yNQ
         dwpTFCcTSBUvfy0jtqaKdnTFEsCny7kj2Qhi1KsfaIKDfpoJHOrr3Wea1FbafWmDeX6Y
         cOzKPKkTruG7fOgRy+EPoBofiXe3ZNpV7bVE9ihEyXexjy1EcFuu2g74FSlAWBL7cz7d
         N3D8+eKBBS22UT2Ul9xQLV2FTCeuTrulgsv7ze5Qs2HfxFVPQPzoXSrCW9570/OQE9NI
         Zg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720597735; x=1721202535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNsDfIDnf4EzGjKDdcme11QFsKS3nMXn+3RFV1TKwBQ=;
        b=q+yMTpJsdA1iVjNUvCujzdvi2MDjPoSALtDwuEiVJp2VoOtMM7xAJhtJvD8gXy4H75
         /BlPK9ZUY5or0VkWLlU8eAcn1hPqnfOQAvcRsmYv/vJWolk8+nFYF/FMqxlEic6AWNk/
         FB2HouA3iKPnkB6gH1s/z4DrNt3KMFWrbfPQ6HIPf+g1v55/MQuG6TjBj86TXbOJyic9
         YQFb6CUVyKBAg1xZjD3aL5q7tslBn0RuJfB9vfcLTxNtSgxoFO+2DMKuTt2wEW4Pv9mS
         nm/DCYowfGNKEutj8vYNi0IdwQRP3yrYViHYXgS2ha10M6io5a/DFIIrStY+DRC/4xJ9
         8fkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpzMiYqwwHOVUg3yZYIM/wTjGC7x69WDiWSGWXFMbbN+/VIR/Z9DVoEHX6IJcHU2H3qu1Z6pjio6jitQ0zcNGeW/lA2ube4wf25jGb
X-Gm-Message-State: AOJu0YwC/DlxrQ8af17iuCtgfk1OYltgXq5xAMEQwkgzMaxA7CWlIkLh
	kTBD9pB1kXTa0o4UbWnHyLlL8h98pLP6OewoNr3s41YU6MFFcYo1g1JATHP6PkU=
X-Google-Smtp-Source: AGHT+IG80H6A817GZXvHI9egaLq2gNkzKl5Ws5DDQve3aWxctuque2YrycdsMJ8ERJDon1+bu1hJ2w==
X-Received: by 2002:ac2:5544:0:b0:52c:db0a:a550 with SMTP id 2adb3069b0e04-52eb99d2025mr2795508e87.42.1720597734730;
        Wed, 10 Jul 2024 00:48:54 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06absm4537414f8f.80.2024.07.10.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:48:54 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm/i915: Explicitly cast divisor to fix Coccinelle warning
Date: Wed, 10 Jul 2024 09:46:51 +0200
Message-ID: <20240710074650.419902-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the comment explains, the if check ensures that the divisor oa_period
is a u32. Explicitly cast oa_period to u32 to remove the following
Coccinelle/coccicheck warning reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 0b1cd4c7a525..24722e758aaf 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4103,7 +4103,7 @@ static int read_properties_unlocked(struct i915_perf *perf,
 			 */
 			if (oa_period <= NSEC_PER_SEC) {
 				u64 tmp = NSEC_PER_SEC;
-				do_div(tmp, oa_period);
+				do_div(tmp, (u32)oa_period);
 				oa_freq_hz = tmp;
 			} else
 				oa_freq_hz = 0;
-- 
2.45.2


