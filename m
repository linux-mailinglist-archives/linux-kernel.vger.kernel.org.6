Return-Path: <linux-kernel+bounces-353953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C80F993516
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2145F1C23891
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C454F1DD894;
	Mon,  7 Oct 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0L81H1I"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB2139587
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322390; cv=none; b=dKFoLra9NRScUVwUhqabcvOqbveQWQYM6LAL23ZNQPXjrBpAV72zJvVJxYjivR98v0+IXba1Tgh1K7zP2Ovhg7KV+qEe9QpBZOyahQGsqheOzjPhSO+0kj7spWUVgNjsHxRTm8lRSPSaRVeVlTS2K0zXL7hcbdO+3oaSCPKu+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322390; c=relaxed/simple;
	bh=kunYKmDXtWow/FIc7+W/KJQpDs+aj1Rl0sIvJMgyvxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=flIsibcEQaML753STOtnPcNemtklDiCqxlQaP2coHya8hXsnM2OWMAdP074UGOq6/3HjOdkxA1428p6er9G4D0r7dlsRF1BMXG6X0o1QHysH7w92ZGauvG8HS/QoJtEJCZZPq0TU5jPeM41xU0//iVGwpJqr4NqnRnhZAgVYcvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0L81H1I; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0752be2d1so579465a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728322388; x=1728927188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBVwovZqhJiutGf/q57pmoMot4Vg5YimdUN+GQvqspM=;
        b=G0L81H1Imv2Yli9IbqtwSBwQnoP9pt+Sjt1GlBpE/2c9yH5rchINO3O1iqqV0f3mLC
         N2rzkjp3MmM2JzNkfxR7x5rul2Aqo3WwESjYidbNjYhDz81pqPi5Xc5LHQcwcsgS1soJ
         2WUD/80M59xjO0G2/9WFrL6wXGXMuqFtuWZ1OF3NuQkJb//uq5EjbF8KP7Jg/EoNmdcP
         maa+IGejw3iPixZPuIl0PB32TZ5c+FBdIlXdVgr9ZPwRKV6lLJcwq3OthhdUFz+Dq1OB
         AReTINFp7+L61+u9XrSars+aUh302T1j7FznSH0rxX+9BaH+hMzBO2Zrkp5DtY8fou2m
         Hd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728322388; x=1728927188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBVwovZqhJiutGf/q57pmoMot4Vg5YimdUN+GQvqspM=;
        b=vUR7itvBVmD6FWaaTzFZim5x1sHK3Q7MWdHr0Bq15WQxghKl5sKM8Cjxiq0cUYtwxs
         lxdRWN+cFGrFAHAXbGS+N57/39n54AdfmtJg+UoJRnEG+wSnr84b5i+8vL4eHKU+0wlh
         jfCK/6CxP3oK8pKecsZUL0oH1UT9phPhsz2HaAK7ACwEWHfOk/jkmLJM00eos/DS7oPT
         w3j1m14nhZS96mODbEJxpwxKcjvPGPwKp/4X4s22N6fNkTG/J5XzGFLmoj4RSYf1rDXe
         tLkRcmUO9zvfgXcSkJppKZliQ/Y0uDPuyMC9yqy33jn8yjcaQNDyfoGJVW0b4suTZzcQ
         Ngaw==
X-Forwarded-Encrypted: i=1; AJvYcCVQv2YJaYU339zQOJqd51WTMTfjavUPK/cv/JGPK15hd2Eo/cR99Xcos/P1rMRTom5Zucoly7waHqROTy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsH01charetl9KztBNuRcHh8DoHPddL+5pZp11S9uxoz+9Opp
	Ck+uVFcH310N62N1/QuteUmXjYDE2MAOGE1nN9XA4xrJju1UPSEb5SLzRg==
X-Google-Smtp-Source: AGHT+IGbvJGQl/UAHTUNNHtW5c/lWs0TlfWR9gt/d7p98Gcfl9rgsSZB50FW193XaadNkp+X0cxCxg==
X-Received: by 2002:a17:90b:1115:b0:2db:60b:eee with SMTP id 98e67ed59e1d1-2e1e63eabeemr6155040a91.9.1728322388268;
        Mon, 07 Oct 2024 10:33:08 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:a843:852f:eac4:ff92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e86657d5sm7442881a91.46.2024.10.07.10.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:33:08 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	imre.deak@intel.com
Cc: R Sundar <prosunofficial@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH linux-next] drm/i915/ddi: use string choice helpers
Date: Mon,  7 Oct 2024 23:03:00 +0530
Message-Id: <20241007173300.83902-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use str_enabled_disabled string helpers for better readability and to
fix cocci warning.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202410071601.TFpXoqgW-lkp@intel.com/
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

Reported in linux repo:

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/i915/display/intel_ddi.c:2225:7-13: opportunity for str_enabled_disabled(enable)

vim +2225 drivers/gpu/drm/i915/display/intel_ddi.c

compile tested only.

 drivers/gpu/drm/i915/display/intel_ddi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index fe1ded6707f9..ff4c633c8546 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -2236,7 +2236,7 @@ static void intel_dp_sink_set_fec_ready(struct intel_dp *intel_dp,
 	if (drm_dp_dpcd_writeb(&intel_dp->aux, DP_FEC_CONFIGURATION,
 			       enable ? DP_FEC_READY : 0) <= 0)
 		drm_dbg_kms(display->drm, "Failed to set FEC_READY to %s in the sink\n",
-			    enable ? "enabled" : "disabled");
+			    str_enabled_disabled(enable));
 
 	if (enable &&
 	    drm_dp_dpcd_writeb(&intel_dp->aux, DP_FEC_STATUS,
-- 
2.34.1


