Return-Path: <linux-kernel+bounces-254262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341B93310C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB3C1F2241F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D081A2C1C;
	Tue, 16 Jul 2024 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaHnFdyS"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA41A2567;
	Tue, 16 Jul 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156311; cv=none; b=emidvmYBKTDTGVpf/VQ5QdTtftl93JfSrdnoZYiTIyQdJflm1Vl/wxKcTAhHTnwrzaUxks6WdqHDN5+b0rXG1v7lr096YT3yAksX4mdcVVjp8/xoLgmGcZ65f9oYm0R+tToqFfJpMemKz7OHUur6Eum2D1OTvFBNnTJZi+0iGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156311; c=relaxed/simple;
	bh=kI4EzI2u5xgxLnrKNc14ybNZ+NpA9p/bYyR+h8Gfb1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tauaahyb3CKbyZ91JbOTThUsKHlthbDJid28NXpwipL6OgZgFCtITAojamtiuaJvTdjpI14SN07LwNZ08nKpIK7dFpHJqmmN3OH+xoCzNi9pT4PvK8QTPWBj+ckoL86q5lyD+1OkMb3eg0gfiX8TlSa9mkNaD9/QNGzVVdPgNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaHnFdyS; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-807687b6652so6194039f.0;
        Tue, 16 Jul 2024 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156309; x=1721761109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvLBNvSR6x2dFu6EXQC/pHFuGqsHWoHN3dOHeNiP27s=;
        b=GaHnFdySfT5gzDnGJ4ynduUBi3cFFYJbkaES7P5Zr4eleAXDPrv/Gp3rBFFKv2mYM9
         zO3avIyzrAi13DYmni1CgwGAO+daer5oo5xECOH4a74SsQpPu+x/ph7FGNUzwih4pMVU
         BUrVMSmtIGGmWzw9PnuoH+dwxAEMQ8RcNOF9Qou3LpCDA1EmtKL7kPdBg3GpgKObmHXM
         A233NA3QzKSScvP1UFex/sTinJQcMtOC65xQxWBE/8X9Yb6MCeruFEFRVQ+fYJ5HpONf
         2mSthZw0VOmNhR1GKb8s52JDkjum20rtt3Ke5ufoQbUtMHBZp8fw/5yw+j7rZAz0mS+C
         kuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156309; x=1721761109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvLBNvSR6x2dFu6EXQC/pHFuGqsHWoHN3dOHeNiP27s=;
        b=iDf7cOij5Lb8MAInNZ91YSTnLW7phF4lOH+0uR5vGHoeabva/ZghjSKOG2nBV40s7s
         GHjaLAYePFX/pG/s5Q3iqfOXEES4Quby6hD4ikibqFBEJxNdD4BF8OfuTDDUsGd9hmnt
         91vkVfQ0wmNUdOKW0Q5R4FemfHBsyxsE0o2rnwOebL1LPMpgir8pCapQtnKpsQERKK0c
         l1xw9X/TNDM7i7MPjylY9kMZNnJSxHPzypXNWRd7mYO2LGtXNpCox2E8z0jnkSweKMY7
         Kw0MlTZmGBCTxpUWqRv9mVGy4FlC9UG62K0KmWO9jFO4J09aYa1xFt95jhjBRzMiqp0/
         K07A==
X-Forwarded-Encrypted: i=1; AJvYcCVQwFCw2txDuCR+zGiY6/oMFVH1NtZvSTrlBP4NpC2jUbhiHOiSuwbtCyCfagM4/5VFFjN4q3pAHkA0FaKWihSc5924r/dBgdhL
X-Gm-Message-State: AOJu0YxYaJ6XsQMIdPgk6GqtshIjpzlGsmqc4KttR7k1Qwi02pRFBmPb
	pOQ5FQG/Azp+IcVahK1hIlkDZrC1cSVfqMkAHb/Chl2RYFomx9kswsxMOrzG
X-Google-Smtp-Source: AGHT+IGpNXIDlFHBUcOjDfaz0mC3FKPHX1JcD+bIso8rqUAdibcBvxkqUwoIZnd4OgAitjHBItH6jA==
X-Received: by 2002:a05:6602:6d0e:b0:7f6:83da:dd12 with SMTP id ca18e2360f4ac-816c52c0398mr41748139f.11.1721156308751;
        Tue, 16 Jul 2024 11:58:28 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 08/54] dyndbg: drop NUM_TYPE_ARRAY
Date: Tue, 16 Jul 2024 12:57:20 -0600
Message-ID: <20240716185806.1572048-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2b0057058ecf..e458d4b838ac 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -106,11 +106,9 @@ struct ddebug_class_map {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-- 
2.45.2


