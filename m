Return-Path: <linux-kernel+bounces-383594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523469B1DB8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0122B2118F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16F156C7B;
	Sun, 27 Oct 2024 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWlwHyou"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C313B59B;
	Sun, 27 Oct 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730033841; cv=none; b=MUWJ/Xcs36nkGt/M/XO8TvGUcUF9P6BT9UShFZ2bY0Hanb2lMCeNlq5/tAc/FQkOtAn40X1UDzqz+PLxg/u12aEcDtDPJYwqWa4kgnfSbku2QDkt1uHVfh8eUmVAzoAsglbA31LocmIa3WEshRUy5TqtzY/Tu6SHLeiWWQZQlHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730033841; c=relaxed/simple;
	bh=GDV/ewhoJQw4FLl+cDGr5/4YsMIEpPNuBtvtftfsYAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofyUlpixiF+inp6W81XbeWqSH5SUNo1yNnKidDlqG/dLR1xllhPPSMvjpvqlkSdwigBNyT79bq3SbJheKF7T1KMl9GUetGZmEFEW5+zQhJEYPMp07rkGSSp9ZcANi3YvaAQ9VmChvTndMaSwq9gFu/eGnOM9lUQFNGktZ1ODawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWlwHyou; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431695fa98bso34174625e9.3;
        Sun, 27 Oct 2024 05:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730033838; x=1730638638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUM2YCgP1YU3td6vo9h1GwekL9d/r6rhNYDcoHoWQGs=;
        b=ZWlwHyouTVcnEmdkHZ+dx8tgXltoWhiAjDMiM+g7+9mScuOfo9eJzIWd0rHFZSOeXf
         Od3EF1/KfwU/2jYA++2F1zRbZUKECgYIr08NbENgRSh/VGZov63tdoMxvnMCFHYV8uR+
         KILQIMhH4R5iaMOW+d2TZfVgik4iqIanQhsmZVvy5D9DWeTrdq4yUGKsLMbVg/KnRBXO
         jbxyDygTKLM9RTE/LCcqPlFgPWp1BwS7Uhh3/yy3WhDBjn6TKeekJoVxCo3rpRQzgGmA
         P6mpIgU1QEja0vjR5jEwVSIqM3O3gcJcBBYyvhbycMPoKfiCGVAbNvDVtQMuWmLrFWu/
         GxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730033838; x=1730638638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUM2YCgP1YU3td6vo9h1GwekL9d/r6rhNYDcoHoWQGs=;
        b=phinH22+mG86IEmNRWDs4Ib8jIbCQ3L2g4stRKbo6M4SsDGMOorXj5RtoKRgBQM7YX
         DM/Vocxy1TH3lAEYHhssHpKFCFWS2nZ5VGLnhzMgEy3kHTUPUB3XPO0YntNHu+B6W/Py
         5ELKUmj/YV8A3hxMYjtUMsZ9lwN1gQwmk9ybDOCOQsorPrFk0BYNc/YGJpCD9rVsQLPT
         +LeNnkx/Q68uyAUaM9RD2tBB3HKW0ZN8b7seD/uCn3Z96IICzbASA8Hg6iGiOFgUplQ5
         7Vp0612yI7f2D6Uyf7X/GmHC8e9yNWjlms2ZDSMFC7oxoYhS7IV9LGlY3UdzTbLAtWTP
         4CsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv+w3QJU72RRUCLEpn5pb5RIeDePCKHQp3Fl1HXqkNk67WoqX9rXaDUCH+dCtJvYpDUXyp8lO9Xv/5@vger.kernel.org, AJvYcCXC0yHc9iduJpfysGT/m/j7LhTBhN7r+owUeWB+AYLjZ7KUe0DTRPa1EmM0Kia4CMZ0lT6hgkkC7i/ajHX4@vger.kernel.org, AJvYcCXDModYd8zKN8tfJyvIlTU3j0qm1U539Hev47jgFhazkKn5lKKiDINUxFh2w764JXdtDkeduXr92zHjXoxM/WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4dCiEYGDJsDm3voFkJ1IT7+7hBqE9pkYt0GEBoJ9pj8VWY/qY
	GnSzQLHbiVdKs9wt/Ejd8EBV8+XAx5lR5vEhgTlAI9b97mD4uCy4
X-Google-Smtp-Source: AGHT+IEExN056KF8Gd9onPpE6xpB4VKZwKvMLBeI7lz16UJtaUBi3JofI0FjUwVnIQrj3dM51yOqpg==
X-Received: by 2002:a7b:c5cc:0:b0:428:1310:b6b5 with SMTP id 5b1f17b1804b1-431aa802774mr423585e9.34.1730033837569;
        Sun, 27 Oct 2024 05:57:17 -0700 (PDT)
Received: from void.void ([141.226.10.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f875esm74349005e9.37.2024.10.27.05.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 05:57:17 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] Documentation/maintainer-tip: Fix typos
Date: Sun, 27 Oct 2024 14:57:01 +0200
Message-ID: <20241027125712.19141-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.149.g3e3ac46130
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation: a -> an.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 Documentation/process/maintainer-tip.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 349a27a53343..e374b67b3277 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -7,7 +7,7 @@ What is the tip tree?
 ---------------------
 
 The tip tree is a collection of several subsystems and areas of
-development. The tip tree is both a direct development tree and a
+development. The tip tree is both a direct development tree and an
 aggregation tree for several sub-maintainer trees. The tip tree gitweb URL
 is: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 
@@ -121,7 +121,7 @@ The tip tree preferred format for patch subject prefixes is
 prefix. 'git log path/to/file' should give you a reasonable hint in most
 cases.
 
-The condensed patch description in the subject line should start with a
+The condensed patch description in the subject line should start with an
 uppercase letter and should be written in imperative tone.
 
 
-- 
2.47.0.149.g3e3ac46130


