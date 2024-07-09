Return-Path: <linux-kernel+bounces-246747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F71892C623
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17A6281F85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93B180020;
	Tue,  9 Jul 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Dl8FhKVV"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71713AD07
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563274; cv=none; b=IOl+Mu+ETZwlhZBqOPKw2ayrDh74DNdsp19rE3IzcXQZz7+jrCvRqdPskkdKn6/oYIbZOQ66Vbd8Gg98BqMSyn9zP57JzPpHYY37dL49hWZkFBCzMYGcALKS8tA6UEB3LM4InYo5Edyawx/m4qqe7ZPavkkeXEIZRRv0YhIPzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563274; c=relaxed/simple;
	bh=ABFlDw8mq7mz9vzgQ050tvvLcuTkWW9SbiF3GyEzHTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdL4IVA9Dq251VNFVOmEnI1NQ1/oC2CqWSi7zFv7NpyHwJudfVXIw7OGtphemaroJ3onwLlpSpzD/eWwdtJ3W/83yr+g3a52Kwl2CPIjohLVfIP0P2rTFybO265fAe3WxR3hfHTDD2+AOjUdn82jPg31acWY744o2hLiRfXtGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Dl8FhKVV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77c349bb81so512143266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720563270; x=1721168070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOArJoxyilSSGPXrWTqG3U1GwRFgQOeHlN66KV6fzR0=;
        b=Dl8FhKVVhSbC3wcPwyc5QCUs9821ax+ueEoAz1Mjg77TsJREFs2g+MFXRHYIALrLEr
         R4BTKO9Z4Y37N+Gmjt+3y3icICXYhCe2RgFH+ZMM9mDUkpw9lS/2/7YZ611QnHJjEreV
         YAnJBTgyTia7xhHK/DbIHgxBYYs2NWDmP6RVDUwCp/6w+jFyIqHh8qpfKQfJVN3hHoay
         ZIKPXyeU61Vte9D7mldF9Qac+vqjNEdSf38L0Mgv3AHlVE23QSa0Iqq6UdgCwwxiqQtv
         /w5z3y74dOSAJpI7KarjJ/84E8SiUgJvl20TNKE9x8skcqk8hhAZaNTLvQmMU02m5GlY
         SDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720563270; x=1721168070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOArJoxyilSSGPXrWTqG3U1GwRFgQOeHlN66KV6fzR0=;
        b=a90NnwXFoz4UdRUQ9KJLoQmh/yPAgGH9jrKRTJESoZBR9IMPApb4QTVOkyWfu05Lj0
         ZUWlGq+fh4DptiJy0rw0ELcs5Qh3gJBPtMicuH7vwfiLWr+1n1iDlNv+zPIWGcFdxXFa
         PPnE/vgLrfFfJTsDg7tNJELyA+HSFfIeGl0N1q4+3MQaXrrmPMarOX3W6c842HvC0MrK
         /VTwX25o5i2WVrlllJPHRb6wNcW5Juq9ndBrzZMsGqAYWvndeS9bGtvf/Q8MuNDwh2HA
         Lj/9Eq6GFr0J6kdXnaGgfdrbEUmZSjMx/j31/eOqsZUFwdQW/WuCHL03nBapdos9b1nH
         oNzA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3CWIdH8Jt+2Xaf1aK1zgkM+G9ufx8PI6UlZWvVJYcjPz41ZuEMIgODihwYHjXZ8dZ5OP+PXsbm+8aCccctN1rhKQP4AQk2bZukgZ
X-Gm-Message-State: AOJu0YzzfoKUzdTW9Aixo6lRBuY2D89DklWoXP9zq2QBKM6oCRLQ7bfA
	7EOZM9ApG5W3jLXbBJCNmJM0ALH74t8RLDo3KoGohhKDxdckIvHuO0z6gRCvYY0=
X-Google-Smtp-Source: AGHT+IEhMAL/BeK0wEsG7YU7fKP6fiy2pWaYrVzNziHBWN4NIwYK04hTgd/KylGrRGQJQSml0I410Q==
X-Received: by 2002:a17:906:81c5:b0:a77:b788:d760 with SMTP id a640c23a62f3a-a780b89f711mr220469166b.76.1720563270129;
        Tue, 09 Jul 2024 15:14:30 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-224.dynamic.mnet-online.de. [82.135.80.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc7c9sm110342266b.42.2024.07.09.15.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:14:29 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] drm: Combine identical if/elif code blocks
Date: Wed, 10 Jul 2024 00:14:02 +0200
Message-ID: <20240709221401.322731-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge the identical if/elif code blocks and remove the following two
warnings reported by make includecheck:

  asm/ioctl.h is included more than once
  linux/types.h is included more than once

Reverts commit 00c9672606f7 ("drm: Untangle __KERNEL__ guards") because
make headers_install seems to be able to handle this now.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 include/uapi/drm/drm.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 16122819edfe..315af7b19c97 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -35,13 +35,7 @@
 #ifndef _DRM_H_
 #define _DRM_H_
 
-#if defined(__KERNEL__)
-
-#include <linux/types.h>
-#include <asm/ioctl.h>
-typedef unsigned int drm_handle_t;
-
-#elif defined(__linux__)
+#if defined(__KERNEL__) || defined(__linux__)
 
 #include <linux/types.h>
 #include <asm/ioctl.h>
-- 
2.45.2


