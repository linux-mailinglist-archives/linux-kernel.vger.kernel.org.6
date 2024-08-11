Return-Path: <linux-kernel+bounces-282208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2394E0DB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E9F1F21482
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BD63E49D;
	Sun, 11 Aug 2024 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvD6WfAG"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5929424
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371974; cv=none; b=GzBJQSwRIr0FCyLbWd1qNT3NjGVP6nj/bOudntasbjYwLYa1gvl5QuSE4LTVmUsMMRUgqTCXexXVg4f8u7WMZyel7D2gJTl2uQO8n1za+Mi/NEGwNm1An6aFPhCOtcxbHajHHUHw25uArPxIHiutRrP4qMnz5nIYY8JHzHxJFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371974; c=relaxed/simple;
	bh=ZrfNi0Mgkt+yMvdlIDHXabQXi/swOE0PqzkHBCidFSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3PyKMjOATRC13Sc0y+pVflht2SmxoKpQMdPZNjyvcdhDEjSUV+OPmJITsMkYiZSQQzPGxzj6hplvHXS10vjPOLz+EtzAjeuLsTZyph0s5Cg/3Q1NAfmB++9GHe/NV33d8ps1M/126aD+Y2k1H7K0NblrJ8UztzzMPXAr3RnaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvD6WfAG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a10b293432so2473730a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723371972; x=1723976772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VrMQAl2Hs8NqoMzMBNb3FrFT3TtFUbe/Zaju8CjWfw=;
        b=CvD6WfAG+4kKXaYUSGFy9J/QdACDLbBsknJdNsQp2gu6z7+DKVBZS4JpJSyyttA7g3
         3rG/0CGx3NvADbj5+IKI4u7FWQVE4t8AYktFgKArJ/5BmvQxQ9dx6sQegiUZitkwcLN/
         ZR8krAqk2BCPvTT0hd131SDWuZk83wBJYrAuhmcBLdW07qxQ6xl80asc86C0IzyFoaCP
         TC9JUGweY1neOEg1/Gl31zxQNEB+mZP+GY9CW1tYOCtmc2hrC1gr85veyNy2gSlBJ4aR
         zvqK0mgdWe4kmpkuKTz041Hc96cQqHtVRZL3DXPZjNYHBFfhtQF0gv1lZu0VXHsFqqjp
         H+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723371972; x=1723976772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VrMQAl2Hs8NqoMzMBNb3FrFT3TtFUbe/Zaju8CjWfw=;
        b=siRq+fvmdSYmPM1sgHTb8fw7bUNinc+pkXw0rB5Rw7iZGAyCrIhgC4z6NZNFDgKiMW
         wg8G5R66+IwY6MMYKeS/tf8/zhxstHVvzLYYFeoaMGpfN+p24hSNyiURmwi3poDfsKVy
         Q2N9yvjcDJF3ZDkKcZ0Smxl52i6cf3u6FgB9/R/SrjZaoz/UBasyMH+I/+0L2LkF0d6+
         MkuWPqBVvALgu/z9Mg+6kzrhY9PL9C9lsJauSl4bwPcc7tmAy99+kzfqsaOlb7+EgnSw
         Ou7BQWc4Qou9bw9NGIna3NZryXZ0HiH59RFKOx/A2GvHBRgjzx6KUiIW+KF8xLwiG6bi
         OdZA==
X-Forwarded-Encrypted: i=1; AJvYcCVjj+AkQofGa/GDLz9G9sQ1eHuc4kUalGqUgvPhCvH+ECE/oTtTKqbM9s4S2QV30gmq+ovA00i4dky7puS/paHQCmlgDZB5fVzywcEy
X-Gm-Message-State: AOJu0Yy8Jmrlmbons183yiN93X6dZnmNKVVn3lYyIYAcwkmhvb4i7GZo
	VY7YslO4/cIdEyKk1whyZDSgxAjUgReiiuZogprkeRUwcF0ZMUls
X-Google-Smtp-Source: AGHT+IGceJgtvbEHrAhmOy3u7lAjDJxBa1LGz4pl6v6wY9aVymYthfS05cwQXQ+Nci/28SSEZGMX7w==
X-Received: by 2002:a05:6a21:670d:b0:1c2:8af6:31d3 with SMTP id adf61e73a8af0-1c89fe7208bmr6481901637.10.1723371972094;
        Sun, 11 Aug 2024 03:26:12 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.20])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5a8a456sm2217670b3a.165.2024.08.11.03.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 03:26:11 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: Mohammed Anees <pvmohammedanees2003@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Add missing documentation for struct drm_plane_size_hint
Date: Sun, 11 Aug 2024 06:16:51 -0400
Message-ID: <20240811101653.170223-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch takes care of the following warnings during documentation
compiling:

./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'width' not described in 'drm_plane_size_hint'
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member 'height' not described in 'drm_plane_size_hint'

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 include/uapi/drm/drm_mode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index d390011b8..c082810c0 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -859,6 +859,8 @@ struct drm_color_lut {
 
 /**
  * struct drm_plane_size_hint - Plane size hints
+ * @width: The width of the plane in pixel
+ * @height: The height of the plane in pixel
  *
  * The plane SIZE_HINTS property blob contains an
  * array of struct drm_plane_size_hint.
-- 
2.43.0


