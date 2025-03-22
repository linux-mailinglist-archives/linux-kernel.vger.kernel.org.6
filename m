Return-Path: <linux-kernel+bounces-572221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F904A6C7FC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B96462615
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3C14502B;
	Sat, 22 Mar 2025 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loAaxt5T"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E529405
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742626692; cv=none; b=LZKYvY9au9nkNarh9xOCSXSRppz79/KXyOeLT0YgMMj4bYzDaI8xeQ6R/ergAaBi1tQbDaOYk7XG5FT0OPf3y4qXj//p5f/jAzOu1eFBb1jkLbfdlmFlKzAcoTI7tdgkeDRn9piea8MHjoxDS2790/YDn780P5tHe8VbTaPKGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742626692; c=relaxed/simple;
	bh=HdCqHk31IVrFS5wCjRMxdwYXQ5QQ5E8hSwrIOXTpRYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjySRokui13sCREtf6/mLPDfaZh5P509n+VxcqxNRIMAcGKOrLIQwPNQ2ojAKYwpojZ2arGhI2TJ1ObUOChBkDnWa+ZuS0sCO0LCBWzpJhbYF2N7aYlGdjZbsmDYP25Qtw7JZcgsCwiHLgJdp/Zx1Sds/n/hklomBPUbjxMflWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loAaxt5T; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso17390495e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742626689; x=1743231489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8emfl3/iA6hoYtuWERF3HJ4s5M5mU6RjMOHWHh7wDU0=;
        b=loAaxt5TQ5DTzksaDlN9RqzPcUyhCmPD5bX49Q2U07xo7H2f3OlCj8eRVYhol1ufWl
         +HqEQ11aY5SiYtBbnqzBmHMX1XE1mTXMFf4LmJswgPORiJH6T4BhV228aaMP8HplDVfm
         70EoA6HY/e6pxV9d+EibUssUl/wCeOQiRZHbJsCYvu0F1ruNqzzkhhVz22xyfBUu7EpR
         o11trL2QyJ9fVHdu6okpkUdFhHNKDbzLZaSev1VKuV0T36u/KsRDfleQp2Ru5HRdpr/a
         UeYHVTQWXQTVEyY9vP0jFQaMfrlAs/KA7CSQtYhzYq1K55WNfDDo8bCRMtZAQ5zy/0kz
         uySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742626689; x=1743231489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8emfl3/iA6hoYtuWERF3HJ4s5M5mU6RjMOHWHh7wDU0=;
        b=Un7mQ0DQiFgwdK5wM3qQfQmphxU5n/OWYOKZmGb/XD8/wJCpSyzXNBe4O6h/lf0VYt
         aFmfW+vqU9hHbXo/K41Tz9vAtLb1y1ZYV3JgxmYYwPscTOjPVtu+KQNvab9ggGpfJ1Nh
         XlqcltlpAluXEZ26Nv10Zbo5PRxSHC/rcMpBBPu7smP+n23RHaA0FQXJnjiK2Xbd7BNa
         PDIKLXe/IEXH6mK0+QF6jjfIeHT8dGoYT4hiommJrXCSJ+5PA8iKVCdfRHJHwlggvYRk
         WSfaqUCJ593MkN5o+Xh75CvEOB1GpyzjuPCTvc3alqypkbLl7LlIiP4hb5PznNbvBJQR
         NOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoNAgCCVJ692haBy4KTCxKcWEHa7dZLZ352hGqMZkHtNG685qkpICzNd7HNZvzZRgBrFDl+/oYZiRgPok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7ODdXQtyZZIUEOqKurqtUqFEWjSbIfSS6CdbdOU10i/30KvD
	FO/BNXeUbNEjeRYgJwDdiHQTPdYCgX7oMfhWNNtRnFtQ8GxPgVqz
X-Gm-Gg: ASbGncsw0+szfnZDXJnVxAStcBnLvTuCIebzGwhfJM+3eJr3N/8bAPM1jDbp823fWnf
	EQllv7KYH1lynsByaGj/2bHZTTtsg2bn6eOrNt5ipsJvI4q9T4JzF5jmcT82oLs4h2Solj5KccI
	Et8SRUAuACdL5+SkTgdvwO98nzVQ/mwmffF029seJUT2HYoRpgwdl/ChPBPpC7L23Ec0U9l6Y3F
	/fQ2gK53o1tgUTxTeWCwX/uzpy9p+/L1PFE7lWjZv4Qt7+fZyGv6sW/deH5POXI4+biVOGeoVh4
	GQ5gvlE0+VzE4BiP49RI3QL9cP4Zsr7Armo8nNQ=
X-Google-Smtp-Source: AGHT+IHNV8Bc+MdPoxMoHiudNZ/7s72orS1cZ4p20xYam3PMqwE8iNaxMoft8jHkRHlzJXMvlWH/Lg==
X-Received: by 2002:a05:600c:4995:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43d491b7dc5mr81439075e9.10.1742626688799;
        Fri, 21 Mar 2025 23:58:08 -0700 (PDT)
Received: from pc.. ([41.206.42.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd277c9sm49607825e9.22.2025.03.21.23.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 23:58:08 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: outreachy@lists.linux.dev,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] staging: greybus: Alignment warning
Date: Sat, 22 Mar 2025 09:58:00 +0300
Message-ID: <20250322065800.21361-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the alignment of the parameters to match the open parenthesis.

Reported by checkpatch:

    CHECK: Alignment should match open parenthesis

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/staging/greybus/camera.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index 5d80ace41d8e..ec9fddfc0b14 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -1165,8 +1165,8 @@ static int gb_camera_debugfs_init(struct gb_camera *gcam)
 		gcam->debugfs.buffers[i].length = 0;
 
 		debugfs_create_file_aux(entry->name, entry->mask,
-				    gcam->debugfs.root, gcam, entry,
-				    &gb_camera_debugfs_ops);
+					gcam->debugfs.root, gcam, entry,
+					&gb_camera_debugfs_ops);
 	}
 
 	return 0;
-- 
2.43.0


