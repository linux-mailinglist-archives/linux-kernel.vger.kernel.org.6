Return-Path: <linux-kernel+bounces-200406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3C18FAFA6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691472846AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9760D144D0A;
	Tue,  4 Jun 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="MdhtjhHM"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF71448EE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496031; cv=none; b=pMS/HLusWkT3PwAPMfR4K90qzhTB5MCP/ruUpw225NN0hHJfpcHqU9uwI/vn77desdS6U8xycNEW1+kmHeHo9oer9+QUGURpi7UK7AC7WP8pIIvQAwi4tqWWdraWu9vZC0PUzPaegqyElEWsjEB95Vs4fOmj2mHpURzFTuf/BoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496031; c=relaxed/simple;
	bh=Lfq24sNnErJv4Qm3+S5GTYGLWAjR7DgYocvpJ7DMxbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l2KyvXAAAc1/UtjTklaM8Fdq399H1PHukSvjKfMZqzCckS4bdGIufM8+JCmFG1GefndeBn4Aqng1Uadf0xjY7iNgxqnafZPK2biMNZXtZW+V8Jbjj3tjC2WjylUFcgRH2no1x94OlEttt4TCc42sEy+JfOFCnuWzTSBE62mU9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=MdhtjhHM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4214053918aso8584205e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717496028; x=1718100828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkz0DVSHPM581bQdM1mhT6UQMZ8po+xcZl4Qk7/o78g=;
        b=MdhtjhHMG72G5Y4dZpnK/60iMplzilUJye/zEIkxQT4T0FtzpFuMMeDMCX2PaSkQbc
         7w26Xresd4YaIMEZoItPjUCxwRozmEW5N1Afo4oNp+EcG2uwHvLFj09OJmf458vpS9+c
         xxrIXyOB1AObuJEwWupczA3flEDDwiMj8O5EEgZIVYQXajXmil5pp4T/44tMjzjQo6Z+
         WsH00udfY2lWWyvPMZHZOdcxchUDJkkmi7L43I3cZsCbXwcescKfq6sCxrUnWRm7yiwE
         EkVJJ0EOEuaTdFoMqzpgNCMvBLZO7yOtRxNmkXE/dsv8sS8e8rtaOYB6JkE9P9k1RfZ5
         IGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717496028; x=1718100828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hkz0DVSHPM581bQdM1mhT6UQMZ8po+xcZl4Qk7/o78g=;
        b=ipGic/YthD4Q3uV0Sia9+gQ01QW4ZYGOoYzn/mEptFi576erDiSQ1FMeEWqE1n8ZhD
         lZn30iMKMZUb5tnvqeQQooZ2mJNklmAxbN7rOkkE6FbdVoBJ2kf0d/wyeOCjtxncQrQg
         8GLh9Fz9MOQNsqVG+R0fn2S3nrqo/5FSNo0V32Wdk40OYXNvlaE9qHndhG+3qLSgsezy
         EzEwHjDdnrWCZUh+GGD498EcyT0dCiEquMHmcEuiDw4HuQK53R4nFRBee79RDJLSHjak
         wT0QRBw+Ah0unbBQtHBiQWesYPFVp280kW8Rd8VFwdukwxaq+Nex4T2AAb+Lv98MtJDI
         2Hjg==
X-Forwarded-Encrypted: i=1; AJvYcCXnUJQNK+3Bfs1gUyIKneVK2HZQkiztTQ7uBHWu30qjo8+Dh1M8jZ46q7F8d7vUgdLuhsCPX5TaJIu3L+6bVkidEC9Gfjzsh3XAH2dh
X-Gm-Message-State: AOJu0YwGyxwZJIC7CpVKmlqm61zKNwolgLT+i1piREof56e7VP09oQoQ
	j78hBK+8nF8O5te8/Qh1urx6xiMThBIBBwPnUWjO9UPgbtDNH6jnefVjlWQcvPY=
X-Google-Smtp-Source: AGHT+IGmr+mjlkB3IrxJZa093GkDQIwpDi38jRs3h2XnRLSE/PGxwx506ujykI/IZmoBxQJSs/mNrA==
X-Received: by 2002:a05:600c:424b:b0:421:29d7:f87 with SMTP id 5b1f17b1804b1-4212e09ba44mr90528305e9.27.1717496028497;
        Tue, 04 Jun 2024 03:13:48 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-160.dynamic.mnet-online.de. [82.135.80.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4214fdf4953sm12261565e9.25.2024.06.04.03.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 03:13:48 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] drm: Combine identical if/elif code blocks
Date: Tue,  4 Jun 2024 12:13:07 +0200
Message-Id: <20240604101306.2919-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
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
2.39.2


