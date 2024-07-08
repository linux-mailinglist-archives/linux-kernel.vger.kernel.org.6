Return-Path: <linux-kernel+bounces-244706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4D792A82B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6F51C20D53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB63148310;
	Mon,  8 Jul 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epmia6mv"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D66AD55
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459383; cv=none; b=q6mAU+x09C4YEVmRdADIKd0jGjV0+eHmYyv07gNqOpFRRZVD31qJXLxCBvORCXDzTibtA76LdYKLDUPxTFAXK3iSDgMro1OgH3voqhUZp3UTvyFgO1cFFQzlcnC6rj/rE5ZIowit2iLRrJlgPsoFU4gch9C35F4Gq8oMROyvQ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459383; c=relaxed/simple;
	bh=qYq6s4bNLi2kzyWMR518+ntELHhG9kRHTZCMd61DDxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OpJrIAL1FESQIO4Tey+dF7eX+QDfKCymodw3bEUCKuDpjm29VUWSMHGCy1uEpZI/GxiH3UBHNp9r062Hqw0nQ5FF2FUarBuaIJ2EQRPY89eJ/lpK4pl70tUJxH223PKTTEiNxJ7AZI74cu+dwjCw+WN20GNZpHtPqzaWxqilnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epmia6mv; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1fb4a807708so32496785ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720459382; x=1721064182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8dssTOE5YtjaCpjIjX/bht9CAwJzQ5jf+TiBoCd/rc=;
        b=epmia6mvNlD59kzjYzFuQwAXQ+RQt6nE+qY8UEp8RFwu9uUR0tWfhqwhTIxbqLWKDn
         wwZEpN5o2N0qt9etGaFe/mnb1R86dHbPbBJrESW34VXVQwO1cZ3NXQgfyYLr4cogKzJf
         7BV6rrNvxq4dHMIAhPYB6NkezRRS+hOj0bWAW21qP2Cg5lhMnRBz7p3oLpCx+E9ghx7B
         qyUMOWtT3liVmC69R13fQJkcG2b2ydFn1E2t/Q4iafs/AHOZMd4TwWPhbB7sMt9QTZh/
         KkmQrzFL0ZLz/x1Av+yKYlco39eEy3p4+XZ0dsdv6SlRhJou3Pd/TvIyrP2UWzHXvE6p
         wC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720459382; x=1721064182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8dssTOE5YtjaCpjIjX/bht9CAwJzQ5jf+TiBoCd/rc=;
        b=RKOuZGFD98u9URsX4+9Agid+a74ECs7tV+gPIS7E/Yif13bW8i+jA8+oRZv6bfBKsy
         1u1c2Iz0PsheturTO0hKv8Nus2qwpKJC4zcMDSOkqgUyyRqTYwaT9jb/1kfL40kQ26X8
         Ox5pae0iUrXCx5cZc8D/lzrFezqGweUb+ubJv7H9qq7sswvxfekD1nWCPilmaz7AxgDW
         Q1ceRlO3wzfHTNdkABjmVF0DhBHwnfQ6/JwtQwnaxDIXME0hNG3VENXfOKHNMTuWl/d8
         NB7lvbXLxtSLfvgPkgnmPSaqbnct9aHgwQqnwElkyfFBsMGjF9Vgemp2dOrrg+j9Nptv
         +QWw==
X-Forwarded-Encrypted: i=1; AJvYcCXROPbFUcGiG/2dnSQMPwk14CTMU5JX6DWXP5xwLdgVhtFFIiC8lO4kb1SrMV9ZM8JRPrYjUw+mLZ34GWocDY/78mvli5XCzm4AAJYw
X-Gm-Message-State: AOJu0YzBV5vUQ/SyZtbfyPcnUJqbJse+nXHjHwJzqOrrzVMLef6lBS04
	Tttp0xJoDkuZLLtDb4Hx1W0TTrcrBIsMG19pSv+LfeZDqO0CZQ+M
X-Google-Smtp-Source: AGHT+IEnHd1r/rT95kPOKGYZBxgklx50F/DDhELRb5rGAwZPK7BNWUon2xTWMeDCG3gWIbiM3Cj76A==
X-Received: by 2002:a17:902:e84f:b0:1fb:3b30:8ce0 with SMTP id d9443c01a7336-1fbb6ed5798mr1508735ad.44.1720459381664;
        Mon, 08 Jul 2024 10:23:01 -0700 (PDT)
Received: from embed-PC.. ([122.173.216.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a10852sm1190705ad.27.2024.07.08.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 10:23:00 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli24@gmail.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Abhishek Tamboli <abhishektamboli24@gmail.com>
Subject: [PATCH] drm: Add documentation for struct drm_plane_size_hint members
Date: Mon,  8 Jul 2024 22:52:24 +0530
Message-Id: <20240708172224.46073-1-abhishektamboli24@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add descriptions for 'width' and 'height' members in struct
drm_plane_size_hint to improve clarity and documentation coverage.

Signed-off-by: Abhishek Tamboli <abhishektamboli24@gmail.com>
---
 include/uapi/drm/drm_mode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 1ca5c7e418fd..25891a636e4f 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -872,7 +872,13 @@ struct drm_color_lut {
  * array of struct drm_plane_size_hint.
  */
 struct drm_plane_size_hint {
+	/**
+	 * @width: Width of the plane size hint.
+	 */
 	__u16 width;
+	/**
+	 * @height: Height of the plane size hint.
+	 */
 	__u16 height;
 };
 
-- 
2.34.1


