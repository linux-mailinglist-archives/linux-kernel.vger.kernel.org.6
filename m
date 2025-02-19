Return-Path: <linux-kernel+bounces-522237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF9FA3C7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3E8189E52E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB423215171;
	Wed, 19 Feb 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs1sMFMP"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552F21516A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989941; cv=none; b=rSQgNbBfntMUIJzyKd0Oz+rLXus6wUmF89QNQETnXP4sIA0d7/lrkxoU4GLBpoTfEWJcJsaxzGbN4V4TKOsvmdZYsp0UUrSSIzPFPmRu6EAIcRc4cMVTy9L89J+b7TAmvoMZTtzkwvQBp3KSpUU8H/0oSXQtqgObCYcbhnLbLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989941; c=relaxed/simple;
	bh=fpeqhpGWkHurwYKTB1xKAEQUJ9Ttk3Bi42IWr/pT15I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueSr01gJ684n871KXagslVGHpruPq0KMXBG0wYzr483ckqbeaFOG4mNFtO7cqQUBvfyIK4VsINirpMMQxdNiFHG+vOjpx7RLIWEgBj6usK1L7AJiBv5W0z46lZKYPg3O8Ct+Yf05JM6Kz7UtqE0c1vK6mIYUvyNyRbA/q0RF3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs1sMFMP; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-220bfdfb3f4so478015ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739989939; x=1740594739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AsR67bqF+fqYAZ1L+J2XlKEArNOWP27kWrQCUz/8HA=;
        b=fs1sMFMPREr1vJVjcv5bk/LAXiLoUIdvSsiULitfehQelFmpUOS3SoLNF+84fh4f3o
         AfsqtM0lMXmsAJ4/VjD4V7GQq+9STX9WgOC0t4R1hzPTzEn04AikmGnxWxi3T+o/5eKl
         uTDSvpdZTDWuBFzIf7LGJqsoZJ+CNRKZ3Kwr3DNLGn8rRhMRy3cyel8lAKsPRfHfQdkz
         1aCp5hA+LpT/XXsn9DHpV9H16Q0UxT1FFXuj3EOuMQYFrcYitndey5OODziYYXgLEY31
         Sr/J/c1ThzmrVKT9gtz324lyEHvXy2iClzU5nhqct32huoQlr9uezIp4/85XFvaoWCdV
         pYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989939; x=1740594739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AsR67bqF+fqYAZ1L+J2XlKEArNOWP27kWrQCUz/8HA=;
        b=lYGHw2Kloozc6IcYGO/whzneehh9bdVsf1ZHnPGW8rje0qA8jsnGqXL9Jf7xvQ6GaH
         2UO50AzUVgipw58zUCi/AlwpmOOmvjI7N00S84X8lVso9v3kw6CUZBcvACFcn9dBnUOM
         t4WKrnbCLpyx4t7bSnSdHGF12V29iFvYiatKMFq4ALiC7WGwMRlWvhi2AwvNwPU21i4z
         kSF8anMPlakw7Wdgl7F5+C4SF37fhqL5fEF5LJKsaiI+bGsOAFJ3veIJDiyvMMv5p140
         Ojp09Rhc6tclCCQ38pz5SxbbiXSq5TLyELZh8EYCxnLNUPnxn2zMlCQCTVOr3/FtNgiU
         dGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6QsyrB+uSctIodzV5aqhMrXPIg9/C8YSd3/OQ6VsJo+6ILUXE1zfxEJi3uo2oE+OIlSN5+zgYadcaYiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWPJYNavLWQvtGZWSt/okRwy6M0sC+KoVn8Xa2NqqH/nessuw
	Y448EMT1qFRy4xP/eTNWwNnoe4ynrzgMrFOMjJh32mm7mZk/yjdk
X-Gm-Gg: ASbGnctUGwIJrnwkIOqq4jq/u3qatjk6lL5sa2sx8ky4om8SWSb2QWfjWfZEAaNp+p1
	aRhwQo6AuO9MJMJFzcGwl/lAMljOrx8zxxuHqYHdPCB7QETtZP0tJHPgLbmHWj0H22RATOHc2K5
	3/cSJrJwj3g8p5wW8PJR2C4mJ74B0kra9cm3hM3xU07kIkIKG25HJaa7dS0ouklki7S4IyXmX62
	v/AByWCB9q3G6ySUVGFEpZtPOPT/Z5lsS7HODrI4aZsXPhUiJQfIXmZFUlMhzoa31YEDj9dxOUY
	voT/YFByeFbmQm0sdiwM
X-Google-Smtp-Source: AGHT+IFN9puy/zUj37o1/n/BhUF6gbtq8eYesYjBrUEvPWWngj5jKhyU6I6JOVjKzlM/PyHF2yhbDg==
X-Received: by 2002:a05:6a20:3942:b0:1ee:64c4:89bb with SMTP id adf61e73a8af0-1eed4fd4566mr6900917637.42.1739989938742;
        Wed, 19 Feb 2025 10:32:18 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:e1bd:18fd:9875:3b67])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7327fa51eb9sm5848883b3a.166.2025.02.19.10.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:32:18 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH] staging: most: Remove unused spinlock from most_video_dev
Date: Thu, 20 Feb 2025 00:01:52 +0530
Message-ID: <20250219183152.176679-3-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219183152.176679-1-kumarkairiravi@gmail.com>
References: <20250219183152.176679-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

The `list_lock` spinlock in struct most_video_dev is never used
anywhere in the codebase. Since it serves no purpose, remove it
to clean up the structure.

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/most/video/video.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index bd51125698..83b46476ca 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -33,7 +33,6 @@ struct most_video_dev {
 	bool mute;
 
 	struct list_head pending_mbos;
-	spinlock_t list_lock;
 
 	struct v4l2_device v4l2_dev;
 	atomic_t access_ref;
-- 
2.48.1


