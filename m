Return-Path: <linux-kernel+bounces-347115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA67998CE0C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1744C1C2117C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196D519414A;
	Wed,  2 Oct 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdIGbY/i"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124BD517;
	Wed,  2 Oct 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855348; cv=none; b=RiwN5ePTYwgJ+ZxrVF4brf95CEywAVJWwHoiGXS41f5mZ0O1trfeKPkwhbJsqbKDhfPsDie88n9UkcYXuNjdcruScnlLkOCBVHeIDqpEElnYgM4hvESR7wZ/1SU+lIL0u/xbBCL2HU/iBYazP9vL7r0y0zmX4cJQZVn8N2q0cX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855348; c=relaxed/simple;
	bh=B/dmr0tgHo+ZlE1/5AGRHjazMBxQbcDlxWSnGPnh+M4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qrunHGFiQl8YxtmyLoWBCejvwIfQxIIbS30f35G/XFIsqOrSxavax4T/YHma+6FSx9U7VT8gnsLojcjoi3wrEoMeVr6RwC8X6YCJQBq0Gq+EzLZA236xrd0stvmQIplTHrMMHmHQ94su2kC0/VQnNrEvjeXwyW1c2gOzDOnEGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdIGbY/i; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a98f6f777f1so97738366b.2;
        Wed, 02 Oct 2024 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727855345; x=1728460145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1sE33RK9i6Dr1qCPzfRCLBr1LX2ZDnRlOdHfUf2FKHc=;
        b=QdIGbY/iqsTHPDGI5gSnv7VWk5l/3sEebghQEuKCjnAGyJVxJ7nRsDbA0wrVVYYbdY
         mbUi3FDELC8ge5qulxEzToc3uoX0J52zx36f/vvqEVQaLT+TFIJCzizKX2+8dxgl/3xn
         a9i/4i/dzipUwl43wNly7lPVJPY1qYmjYOZmhtfFDQFkIJl9JCe/HPrxGqIk41fXjPxE
         vxHWMWjQc0Q55XS5uBFQuapH0/jqqhyv+nlMN42yNWYpFvziyVb6ZS1LG1V+JP+FIzwT
         ziWKBfoXvAG+stIFE8DbhJz75Rtfkaxu8t0gf+egnnjzbZNfwAp2ytDhd2tXj/8PyUwF
         5psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855345; x=1728460145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sE33RK9i6Dr1qCPzfRCLBr1LX2ZDnRlOdHfUf2FKHc=;
        b=TKHTOF/rPvOwdWOsTVZvTAbt7UPrknBv4wSR/Y1SX/agvAnv0IKaQR8bJROFg2X2lJ
         All9qLo+sNR3jmd6b/dh68Gf1HZkTkQVgfyHqd8p+WktRJCL+pMyyFxJAwatOqAR0Prl
         d/ZAN6gGsmhe4Vgu3B2y48iELs8+ygWvM2Iluhy3GNQV103lCP3ECQ20mBVfL4GbcaJS
         gWGjSPJNry98ZuLULj6075Foe3Jpr/bc3lYGsPaoexlp/oBTrzUMDuV5Q/seQpM1hXwe
         BBif7HfVnMJIaQYiUWaTdufMDZokXHG8IsH5rQqt+TF9B6yjm/Po8YpMCN/wY+QxgLuB
         DGyg==
X-Forwarded-Encrypted: i=1; AJvYcCWyCDVexv8GHr+gUvscIdX/mRT0GJHOm/OikhNLJrK3+dWL89pMjM4UDMZpcw2H00T2Auk/e5zhzf6AEIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH7+CvJg5CJL60dtRm4kRGjFb9JSl9qAqBp1pSLkGW7rqOSaFJ
	cWwN1+UfE3X9ZzwyqGdvFMYkskRlbNbE/yfp6FW/wmUUpFY5cx+E
X-Google-Smtp-Source: AGHT+IF1OGVlHVCOZY7ncJbcAHiJ3yHF47hZOCjc40mcpPrCwCrw9KqUsqhkQw283ZrsikK00WvzJg==
X-Received: by 2002:a17:907:705:b0:a86:ac91:a571 with SMTP id a640c23a62f3a-a98f83875afmr216654066b.56.1727855344841;
        Wed, 02 Oct 2024 00:49:04 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2999076sm824885166b.218.2024.10.02.00.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 00:49:04 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/display: Fix spelling mistake "Uncomressed" -> "Uncompressed"
Date: Wed,  2 Oct 2024 08:49:03 +0100
Message-Id: <20241002074903.833232-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a drm_WARN message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 74311bb9d290..a5057ee4cbe5 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -3811,7 +3811,7 @@ static void enabled_joiner_pipes(struct drm_i915_private *dev_priv,
 		 secondary_ultrajoiner_pipes);
 
 	drm_WARN(display->drm, (uncompressed_joiner_pipes & bigjoiner_pipes) != 0,
-		 "Uncomressed joiner pipes(%#x) and bigjoiner pipes(%#x) can't intersect\n",
+		 "Uncompressed joiner pipes(%#x) and bigjoiner pipes(%#x) can't intersect\n",
 		 uncompressed_joiner_pipes, bigjoiner_pipes);
 
 	drm_WARN(display->drm, secondary_bigjoiner_pipes !=
-- 
2.39.5


