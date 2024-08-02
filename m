Return-Path: <linux-kernel+bounces-272799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1769946158
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EE1F22E08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7E1C2AD;
	Fri,  2 Aug 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="a+sStoBK"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE471A34AD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614639; cv=none; b=DxH6lGVX8StfSt9kyPrkb7jWZLs6NK0pgzLhsnEvIJoeLegoVMw5fI8rJ7RMRTxMGDBjZj9E20z3GUaIlN5eTGTg0W106CPwpOwNCJ9lpLGVJyiMsNk7vRTyEb+QxM2LOjpBNn0O7Vau+Sj8s3Vhsujos1+Fy/NjQE0+QhvXtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614639; c=relaxed/simple;
	bh=n99g4/xddneSZsSDqYSzfeLklaGh7BlL8rCclPGvEpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1zMBRTAZ3f4uetzEBBrOYqxO9n+aDrAjydqNw36Ee6qXTIxe8R2TVp/3e7pU3QW8wNXNeC5KAZ8cJSF7GdqimxNupHXcYCV4XoUIGeL1WQC5FnRJS63Fx/qvfguXjiLg7Noy+JzTNfWKPyAfQ8/Um6ucGYAqW4D51ij9MRlQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=a+sStoBK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f025b94e07so106017711fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722614635; x=1723219435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vWX0mheMHoq/ICPp8r+x9QWJESTdzniHyuoFDx+Vayc=;
        b=a+sStoBKbI3VHt0FiSh884ZAbp5+hDw/gwnLqMicAeKPjWVzmKNceY7L3IDo/2PY4U
         slLs/uv0jf6o1eq8Hyqaq+ZzI5E/N5BymVoRlVZf9OubOPZ+u37IRLevv7sH0h5B/170
         fChOxKTlgntn53RwfszQBQfHvJ1Hs78FsxRV1h8bJ3C9t6cZkCRoKpU+hlqHEitVqqHr
         0qizdJzcK9GVYgWwK6/vto7uvpo2onva1jE1dH8ut2lf7VMVBEbPld6J+aDc8nrhDrLG
         co7ABIJ3i/bw+5+MAL+7VC3Du0Ko7O8DGPYhw14jV3cqA9ORcTI/J/ECYZHYqIjDfr9X
         65PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614635; x=1723219435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWX0mheMHoq/ICPp8r+x9QWJESTdzniHyuoFDx+Vayc=;
        b=D50B1yk/MxoNlBDe+NxnsJc4l46hQk6g/r71BtADViWimHrN7CvaD2SJhqwOigVbyi
         WjmuWhgW9mSCzdUFxabnPkvzrSwmPgVbTa69IlYhJk9muYc9e8tJW4iUEIfj2hvYs1rR
         CyOeYgnv45R4revcc2tMQvxwg2qsxBbUnCl3barbniepP7U6AjDuQuKNtEzMiP08PkMa
         /BDpqf/2vP38KTYD7iV390+5N17quFdJb1dA9KbQaPxIz0KUKSopLugBCB8l1Bk7COWi
         Tcm0DO/tIoTR520rf6Qdr6S14br0jW1nHuzClOofR7Z7YfgxP1M8zje7Z22W6bck8A0s
         8tog==
X-Forwarded-Encrypted: i=1; AJvYcCVDrFLCDB/q+2M64E5+h7oFLFH0XQKLiD9w7ygBb8BuRhvcX0LAZ0oJGP1k0vSzDgG0lGssEDoZ4Crrlk+yj/roW1leE5A6Vc+yFYOb
X-Gm-Message-State: AOJu0YxxmcGwiOWMxZmlqp5rO7OCw3mtVsJqBYnZTRTrFIAfMhq9HMGa
	+cWap9gA4OrA4HHHy7a9MH+3bZcVlCGWEpJZIvKAvhtHM6FoR55TajWejgkWvWQ=
X-Google-Smtp-Source: AGHT+IHWMAsctgqofI5c9OnE2DkE2XnE2nCF4IAIqFKxoTDbkmHYkLOn8gZfpr7W3peLpSgzogberA==
X-Received: by 2002:a2e:2418:0:b0:2ef:3258:4961 with SMTP id 38308e7fff4ca-2f15aa9919cmr26771621fa.15.1722614635006;
        Fri, 02 Aug 2024 09:03:55 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6cd8d67sm38603285e9.0.2024.08.02.09.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:03:54 -0700 (PDT)
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
Subject: [PATCH v2] drm/i915: Explicitly cast divisor and use div_u64()
Date: Fri,  2 Aug 2024 18:03:23 +0200
Message-ID: <20240802160323.46518-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As the comment explains, the if check ensures that the divisor oa_period
is a u32. Explicitly cast oa_period to u32 to remove the following
Coccinelle/coccicheck warning reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Use the preferred div_u64() function instead of the do_div() macro and
remove the now unnecessary local variable tmp.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use div_u64() instead of do_div() after feedback from Ville Syrjälä
- Link to v1: https://lore.kernel.org/linux-kernel/20240710074650.419902-2-thorsten.blum@toblux.com/
---
 drivers/gpu/drm/i915/i915_perf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 0b1cd4c7a525..f65fbe13ab59 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4096,15 +4096,13 @@ static int read_properties_unlocked(struct i915_perf *perf,
 			oa_period = oa_exponent_to_ns(perf, value);
 
 			/* This check is primarily to ensure that oa_period <=
-			 * UINT32_MAX (before passing to do_div which only
+			 * UINT32_MAX (before passing it to div_u64 which only
 			 * accepts a u32 denominator), but we can also skip
 			 * checking anything < 1Hz which implicitly can't be
 			 * limited via an integer oa_max_sample_rate.
 			 */
 			if (oa_period <= NSEC_PER_SEC) {
-				u64 tmp = NSEC_PER_SEC;
-				do_div(tmp, oa_period);
-				oa_freq_hz = tmp;
+				oa_freq_hz = div_u64(NSEC_PER_SEC, (u32)oa_period);
 			} else
 				oa_freq_hz = 0;
 
-- 
2.45.2


