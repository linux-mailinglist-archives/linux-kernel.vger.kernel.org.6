Return-Path: <linux-kernel+bounces-386669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974429B46AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA5F1C21D24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A602040AF;
	Tue, 29 Oct 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb+Ydevr"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286C204953
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197369; cv=none; b=czJQZ0SPZ0zRx3Say7jUVIVfengsG92Cu3uprnnrLdfq6loYWk1Q25Xqmfsznn99V02xF4k5Bn925eAONT9J3CaDyp6EHcaCbf1JHfTPpYARsWxuO4CJwxDo4nxKDBX/I1huENsyOaN3Egb4u1aMgSh9dsYf5+npkiJKDUyMukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197369; c=relaxed/simple;
	bh=zKzvozsHvMVGmliPLR7v7+fCyZLXuX2AiBoKviUE3N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LSKxEbotR/dwM6hrJ6Ixk/QETGRh7Ipb8QfsbIzZbB6+8V2gtW2Tb8W9IVfanP54oDoGtYeHvVUGj2mqVW4kO4MiVmuNYw9ROWiYfIZxzFQl/9fRt/87x2Y3gWPC6o9KfPpW9DIbOCqjRlqtwjYvzBzxHhWAZ1epVEkMAvIUjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb+Ydevr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cbca51687so48176595ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730197367; x=1730802167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01Umf8iUVZfC58kdjKuuiE82OEKV9wbOQ6pjiqKLUv8=;
        b=eb+YdevrRPwtNqbz7x/P0eFC0F8t/QuT50lnzzeAdZW3xGk9DsrWnD3Q/K1ukpojjc
         JfrrnjpDo3PDgGJSTk7udSUElEMf92sr5VM1r1UU1XAk/V4MdGQkXRuMqWqEDD9/uODC
         /ILMZagXD62Q8R4OxBKN9ZbFcceVKJ6l67J+b/yh5JFZeOjpB0+bd5pzvr689B2VWFgE
         0hR7hvhuQnJ/puMg2+gbo2QG/85EB2SzuQhDf7eLPK38cEF94LtEKGMggkalP3qR6yVC
         NuvSjffvrZjLXfHelyKRi2mMyJZH7z/Va8fp6L6lkv0pGUizHCeMIL8eGHckpATYCMs7
         I9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730197367; x=1730802167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01Umf8iUVZfC58kdjKuuiE82OEKV9wbOQ6pjiqKLUv8=;
        b=KiAzV1PoJrd3Vwy35KaqhBSt5BaBf+1AZYhXemArgePLBlKbJd8pJ/RvUywzkdJD8H
         qIUT6Rw0zm2vI4gQyUOxCsA4z96Wn5ngdk9YERGiD8EuMKnA9WThkmpndSvdftrkF6k+
         A96eswJYxasrwOcd5KKPMeQgaaKqnRWGbcBpmwb994nuMqac1lPIgOQpi7iz1YGfFyhB
         yHmHCcibbWUdbZlVDSr/iP5yEIzH+G5PUn7wuSAN/YTefRGSLat9NB4GTPIWkhDTqnIQ
         i2h7di+awPFnKluY+L3hwybNdRAB8qCPkqxsOzWO+v4+QAAWVZp3cWYNq8KjHCJBL68f
         aaAA==
X-Forwarded-Encrypted: i=1; AJvYcCXIFkEm5kjWihiVghnDs+doG5gPQC0HerCrxRJt5yi2kY2h4/fClQl9GkjCmsp48eu4zNXwo2jnwiv0Q7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02AmQcH1up3cqw7cl6J5KcdtbS+tgKz1b8LeKJeTAwz+nCJ6I
	hkWdr18B50ssIZlgm2phXLX8E36S1XVy4dbA/Je6T2iVDw9/tFHS
X-Google-Smtp-Source: AGHT+IElqNym4BeJPNCJTlbSlHkx0TRDzfK6WFA45y6XkQcbHMPJugv4gb8Tn9WYSnPeio2CIZlTCg==
X-Received: by 2002:a17:903:228a:b0:20c:83e7:ca4f with SMTP id d9443c01a7336-210c6bfd3afmr147760185ad.26.1730197366561;
        Tue, 29 Oct 2024 03:22:46 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6dd62sm63475445ad.95.2024.10.29.03.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:22:46 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix unused variable warning in 'drm_print.h'
Date: Tue, 29 Oct 2024 19:22:34 +0900
Message-Id: <20241029102234.187480-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

previous code can make unused variable warning,

e.g. when CONFIG_DRM_USE_DYNAMIC_DEBUG is set,
this outputs the following build error.

drivers/gpu/drm/drm_print.c: In function ‘__drm_printfn_dbg’:
drivers/gpu/drm/drm_print.c:218:33: error: unused variable ‘category’ [-Werror=unused-variable]
  218 |         enum drm_debug_category category = p->category;



so i simply add '(void)(category);' to remove unused variable warning,
by referring to "https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html".

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 include/drm/drm_print.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index d2676831d765..6a5dc1f73ff2 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -157,7 +157,7 @@ static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
  * a descriptor, and only enabled callsites are reachable.  They use
  * the private macro to avoid re-testing the enable-bit.
  */
-#define __drm_debug_enabled(category)	true
+#define __drm_debug_enabled(category)	({ (void)(category); true; })
 #define drm_debug_enabled(category)	drm_debug_enabled_instrumented(category)
 #else
 #define __drm_debug_enabled(category)	drm_debug_enabled_raw(category)
-- 
2.34.1


