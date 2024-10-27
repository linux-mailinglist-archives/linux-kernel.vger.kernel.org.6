Return-Path: <linux-kernel+bounces-383469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ADC9B1C32
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D52822D7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 04:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDAC3C466;
	Sun, 27 Oct 2024 04:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkrpQwlf"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518552A1CA
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 04:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730005123; cv=none; b=IVtc19GEjQAcEzXVzamT9gmKgQ+0OtKyoUu26ZbbPWzS65seKbKqzYZUJiGbn9PfxHWBLriCIwDTMRO7GG6qpQlwn1dVHYkZCYPrZO/yqxhgR1YY7+TWkTXpjUHrE1SqDDMlgCiD1XtRzIMgjNky8KW9FpAM/Y6RmTh5qZx9rQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730005123; c=relaxed/simple;
	bh=R4Wn7j49THnd7wwv7+nnTb2izUldriB3Glf7u+IXx2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tNen0rxDoUzYdHO3zk9Ivk8YYMc/CT+E5y4OWc4JLJNdgXBnzuX6x3LH26myH1sKioSUBJJQC0QGChxgxzrxTlCnhgHyk21pkhgOCR4jUSIJbLJzWoaH2wIz2Ha0olcxJZ22dzlXhrqT/vSS3vdy5GpkzD5p8iUexIbAGTr9Xgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkrpQwlf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so2333245a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 21:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730005118; x=1730609918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGcsHrcwLS5rbJAr8cWgtD+JmSxKpAfNabdsn2Sm574=;
        b=DkrpQwlfN79i70f9sIZGZAAlYjaLbGkWK6kfx7t1JjeAkPxDFDCFEiyciWAA7uIw1t
         XXO5BK/HOXVsQVarrbMzvi2VGW7lJiXV7ujNHlc+qhwqD98XREvHzO+x9eda9y3C+Nio
         XP8/oRqgbqGAtan03ctG9BCs+p5K6eh2vwFEF/ywyXVkVRjaNTvEvOfon0sCQfb4OF9t
         /k+0kfsHnH2rFchQHjt/jiMP95SUZM6cXYYP5O41kWM38qeAsuQAQuKsCDPh3GEjSEna
         ipb1bJi5q8XTBqEP+9N6DMUA+s9TupixrDo+0X0jrFZ97d6KML8Y+vexDZ2WzDs2oyxd
         fmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730005118; x=1730609918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGcsHrcwLS5rbJAr8cWgtD+JmSxKpAfNabdsn2Sm574=;
        b=re4HS7+6LGBy0RwZmHxxNl5AYn8ewcRcqdrNCsgOykVwtOA1XXawTD80MhOw7uz9BK
         yS+0fK2Lm0AqFAAVdYQFfCxw9LtxKtQL4EYtLaZSCCdXl84V+h55JR4HTe8o/ilZWmw/
         ArEH3DTzBFndfqbvv92f1I0p1PQwV/UrYeyrCiTDijwlB5YtYWKYucr9J/nO70pV7MRN
         8sIwkWHxwu764KLhE57ufYsPkTPgRPg9gFtcrKbA0C0Phvn305MUZLouslOVqI/10EMA
         OLIs165II+2k+ZrkKaWWjwrNS6b+TUo1mhVMAHPEDVc85iZDLZEZgul3lN/w/R752Oja
         qWWg==
X-Forwarded-Encrypted: i=1; AJvYcCUiOJAikqQcM4PQPxGQpfG2dYvAjByfQeLjlU2uyeAVr6L84VlJqrzTwPnqJswx+WgXHi2SeYuEV+5E6Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyrVwEtZjPChWN1VRTcV//GPNc3JGZT53DaiLtH7M50+Ccm5e
	YLlIOz0OHJIVYjuXbt5tci3CW8kujWIBTM4leQ6127HH8gbMt5LO
X-Google-Smtp-Source: AGHT+IHseJFxwF1uwMouwoVCFWM1YHzALcbP58rShHb5pBCj+o0tfLLl2KH1C/uR4GdJ9JZhP1kl9g==
X-Received: by 2002:a17:90a:ca0f:b0:2e2:cd22:b083 with SMTP id 98e67ed59e1d1-2e8f0d4dfbcmr5359887a91.0.1730005118430;
        Sat, 26 Oct 2024 21:58:38 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771e64sm4338817a91.50.2024.10.26.21.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 21:58:38 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe: Fix build error for XE_IOCTL_DBG macro
Date: Sun, 27 Oct 2024 13:57:52 +0900
Message-Id: <20241027045752.10530-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous code, there is build error.
if CONFIG_DRM_USE_DYNAMIC_DEBUG is set,
'drm_dbg' function is replaced with '__dynamic_func_call_cls',
which is replaced with a do while statement.

The problem is that,
XE_IOCTL_DBG uses this function for conditional expression.

so I fix the expression to be compatible with the do while statement,
by referring to "https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html".

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/xe/xe_macros.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_macros.h b/drivers/gpu/drm/xe/xe_macros.h
index daf56c846d03..58a9d1e33502 100644
--- a/drivers/gpu/drm/xe/xe_macros.h
+++ b/drivers/gpu/drm/xe/xe_macros.h
@@ -11,8 +11,8 @@
 #define XE_WARN_ON WARN_ON
 
 #define XE_IOCTL_DBG(xe, cond) \
-	((cond) && (drm_dbg(&(xe)->drm, \
-			    "Ioctl argument check failed at %s:%d: %s", \
-			    __FILE__, __LINE__, #cond), 1))
+	({drm_dbg(&(xe)->drm, \
+		"Ioctl argument check failed at %s:%d: %s", \
+		__FILE__, __LINE__, #cond); (cond); })
 
 #endif
-- 
2.34.1


