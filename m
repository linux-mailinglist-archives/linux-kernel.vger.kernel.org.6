Return-Path: <linux-kernel+bounces-537971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081AFA49315
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4461894855
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7721A209F5B;
	Fri, 28 Feb 2025 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG8VGKBh"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF251FFC48;
	Fri, 28 Feb 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730431; cv=none; b=JN3K44TLsmvMWTl0bDfTXWyxH7HuN0NFoFW3dbkPCGS/17nvWEQPE/P4c9hWA7qlRXLRlUTiq4/YXnDzicCAXYvv0zRvbPMpeYaLodm9D1fMrzt/YH0fLwoaMSeDM6I/g03ToDtodscOJKmMYJwqVPwYb7gYOU+9DAR8jcPLNcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730431; c=relaxed/simple;
	bh=6s+XK8sAu7D21czy6f9zshJ0Pz1KXiHahNyi5hBbkuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9s3QGz0q+RgOTBpRHZckDVjsfgdzGD3h4osSaCicgaWDcc0xz2eMTSup7VheP80RiyzJKUAbTVY8piva9zQ0l+NZkSZs9JLJ+e1inh7vANplW0XykNOiBbrxrH/KhErxKvpy9CSvG4l5dAdAyGIP6y4GmJYfhHZGbImHU9ZUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG8VGKBh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22185cddbffso51529885ad.1;
        Fri, 28 Feb 2025 00:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740730430; x=1741335230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Na5VN2FPxgLTURi/r4p4P+00hEexnO950UJTB8eSOso=;
        b=FG8VGKBhcswfWn528suDB2vI11dq2LdaSfBH+69NwadjpTzdeDF9dB4CiP6ciwhz8C
         sQxhX9uffwlTwCMmK0v+dQo0FpOG4o7fdGc9ChX8ZCEeEZK51OTPeBvl3N1qLRb3ID/0
         wUxw8eyOtXJMvv0Ee1V+g+RWwhv8eKGJnPDK0vWodFnMkHhBUVJekhhJJ4/RKyFj9xpB
         Xf/pUOlC8Jzy1/XTyoV4NT2f5N7GWg0kpCwXDjmPGQ3+GFVzj1FiXCAA0jK0lQdQUxLq
         hE+c8OfY+pyKpbu8Z5wbti/fZoWvMdV+mTEkDPf3INtcidkAZc3+iBrS+67CXrJNOcis
         ycxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730430; x=1741335230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Na5VN2FPxgLTURi/r4p4P+00hEexnO950UJTB8eSOso=;
        b=TRU0+/7YHm12N7YFEUF1gumCOGohGX/EnKOO9dxGy8jtus0gwvONynlYgEU+JoFKBH
         Bs/0phmmYzryOIm5dS2nT88c2rvaXG/iu0NQm7MiuxF+OhEdR2xd6+I9tCwWwvWdude7
         JxztoWopu69VykbbdX45pVwbqPyoFcN66XwgKJzelUGBAnKsndNzmJ1R/blk9R9qGqH3
         lqYdlkzs4Ru20g9El3B0lyqPxtuzf5u5OawWyTnt+Gl8EKITgWekSNL4kzXRubrdC42v
         9/s2LwLADeETwKyBstjdp2t16wERwU9c21AbhzwVnpywOd39zMAomdghWLXRK0irmbfZ
         8jVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgT7x8k+fETaXLRq47YxzwfMdYf8oH26FwN3RWvVLeu64WwZYZHWfzidXCzgpCkiCam3gAE24uM9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJOGlZdsbUZ2EvJJN9hl8EhwXV5WsHZuJ4rtmobx3z9wcKVlf
	EN5gSzBukv0a3V13UzQaW06O6kBSgqs38ZUmLpEtGN5l2WUNvp750fEpAJmvV/LVfg==
X-Gm-Gg: ASbGncsRqlqjSYBg44XAhilA39v0ok5XAiXr0uddUkxUb9k7dxdoiJ0+ToNtbDqNWXX
	GyksDK4an3ltIjChkyC2TWpLYLfjJVboCRY3MCDYw18I18hdBTBAmx4dMr7zQc4wWZX1R+5b8iX
	WdY+5+LOCjXnD86JP7tx+9tUMtm61yiqP7979/zp03G//mYp76VB8CPPHGj8vcmN/8RX+MvLEcy
	/8eHkpM7Zq/rUpb8JEUzaGqw3WLpmgVUeqi6ClWHLBH+2c+jJOGCa4CvYMHF2D1DLBAIMXlz2f5
	XoiWWwzCiFvA7ynjx6o5RZj0IAeYRswMxdSEPEfRsGN2smyf
X-Google-Smtp-Source: AGHT+IHoMty9feq7PV3rqXBAgLDk345+dZ9XZSZ/bst47bwK7XsE+dtjNWN3IGNheEb3nyVP81+AVg==
X-Received: by 2002:a17:903:3ba5:b0:21f:1348:10e6 with SMTP id d9443c01a7336-22367455c16mr46890875ad.13.1740730429604;
        Fri, 28 Feb 2025 00:13:49 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235052c83bsm27857095ad.236.2025.02.28.00.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:13:49 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH] lib/Kconfig.debug: fix broken reference to fault-injection docs
Date: Fri, 28 Feb 2025 13:43:38 +0530
Message-ID: <20250228081342.42968-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the reference to point to the correct location.
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..35796c290ca3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2103,7 +2103,7 @@ config FAIL_SKB_REALLOC
 	  reallocated, catching possible invalid pointers to the skb.
 
 	  For more information, check
-	  Documentation/dev-tools/fault-injection/fault-injection.rst
+	  Documentation/fault-injection/fault-injection.rst
 
 config FAULT_INJECTION_CONFIGFS
 	bool "Configfs interface for fault-injection capabilities"
-- 
2.48.1


