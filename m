Return-Path: <linux-kernel+bounces-273580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D51946AE1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 20:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3DD281415
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79631CD3F;
	Sat,  3 Aug 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOyuO3p/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67A1CD20;
	Sat,  3 Aug 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709994; cv=none; b=NGw9rEc9vkzs7PCKJu8wCmBh9ZHqJ0/Hrx3bV8ZhRWh6dLzjzIyMJsRTVaBBVCdnD4IrbUa+N+bdvjCn277fZvmJNwiJbf2GHdeUwHyrzx9HnoG9Krp8HU82r30RpdDhUBaA3i9YEOSqLXIYa3hQf5k6Ny5XP4ucVsSNjmEwMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709994; c=relaxed/simple;
	bh=rATF4I0UBm/YSsPSLhag8cqUaMrh2onGP0nh98LCzWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8X+gYBJ5t+96f9/Q0g/CaUZNRRlit1sQh7bvGvtlAMmCM/kCe0P3XLV+4CC8klpZry6KnyDtDvj8uqZuUncUCaS4gfnVjXea3fKl9C29gasD+XWPsWef08Rt6t8hxK4Oi0LOe/P/Imy4CTC/qyKcl0c9HdhvtlHevKruLcwiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOyuO3p/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd70ba6a15so71779515ad.0;
        Sat, 03 Aug 2024 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722709992; x=1723314792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2aakKcJP9JsSPtIr8v4x+tP3WdwFQXm3AQeWrFOwVQ=;
        b=YOyuO3p/o+8Mh7y1H+Bu75z3Aj/9qxJP7e79jMJe5ff8lDGdNOEA14qAm+8hKp3dMq
         9tVJMDDuDOVw5GfmvPyl8H5tTp8WyCm2OMCnaamCLTOAnnEUZzAbDpF4JFtYm4zNYYrC
         3R/ryfp3yFtkFZovHdYtzSB0HJUgHCAdeqI1xOgYS2EeRc8DUevMrOaCEK6srtXhcXaN
         kUtq7pubZkpw8+XqWKpSDJD6BVPPYIemjaV0YeEnmn2WotG7yEGNuE/VkDRQfjrY7gKx
         O9KHR2ay6HkuitM7IbrHx1dZQOlRLYkatE68yvzg4PlXcZmcJK1lhMjkBFnOANhOZPfc
         7YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722709992; x=1723314792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2aakKcJP9JsSPtIr8v4x+tP3WdwFQXm3AQeWrFOwVQ=;
        b=iSTGP8PXrcdifGDu0ZYp9K8XiuoEN82qc/Q75zYPrjotrRC5akPGM5WATIp7B601Dd
         cxklo4jAOvLvu03RzNB0KDuNejibNEMnocROTVHuraJRi1X83tSfaPk8lBzMUVWNWnjH
         Hnovw7xe3vUWb/BkjY+gHTfO8zo4z026+lsOhOZ6R3NnQgduj78w8T9IB+5Vqmf4LJee
         BwwTjz6iz4JJuL9yOYW0OLS5r4Pd30Ad2kH5TU+gE/rcpAZtJHxno3nX+0nVI17lJ/3E
         CyHPjTU0hWO+Tu4E0kTPZp8wt5CKKxIifcrWHINZSXjoLw9scU92BxHr3mJQKs4Zu/le
         279w==
X-Forwarded-Encrypted: i=1; AJvYcCUzX1B55QKAGbQ0UnC9yxXZr4z81AFvrRZJAw47jFyx8auQ6NWu8nWcRmgSnXu/GRKg/6pfvqUaq9nXUxLeMursAg3uPb2oFbsJzo3WTFc+df+MiPj39Lv2aRNRdcwkbq7CVcP4xskI
X-Gm-Message-State: AOJu0YxVlbLlBtpywJTdcKy42grXESBWrDL28cs5KVeKuC2TWk9mB1IQ
	6zuqyi2W3OE7qY7PbHyyo6t1JjB7l1qgW2vczqtTgL4wT8v6SjbQ
X-Google-Smtp-Source: AGHT+IHk2tCzpQmuh++pUzLvkOxxeNWPy2ZmkonA7aKva8irybQM9CH0bUHgy/A7WMxoONgpFVtJaw==
X-Received: by 2002:a17:902:ec83:b0:1fd:9590:6550 with SMTP id d9443c01a7336-1ff574dfe01mr83592485ad.64.1722709991809;
        Sat, 03 Aug 2024 11:33:11 -0700 (PDT)
Received: from localhost ([103.121.155.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59058d7dsm37943325ad.142.2024.08.03.11.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 11:33:11 -0700 (PDT)
From: Shibu Kumar <shibukumar.bit@gmail.com>
To: =agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	corbet@lwn.net
Cc: Shibu Kumar <shibukumar.bit@gmail.com>,
	dm-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Removal of unexpected indentation error
Date: Sun,  4 Aug 2024 00:03:03 +0530
Message-ID: <20240803183306.32425-1-shibukumar.bit@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While building kernel documention using make htmldocs command, I was getting unexpected indentation error. Single description was given for two module parameters with wrong indentation.So,I corrected the indentation of both the parameter and description and also added the description separately for both the module param.

Signed-off-by: Shibu kumar shibukumar.bit@gmail.com
---
 .../admin-guide/device-mapper/dm-crypt.rst    | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-crypt.rst b/Documentation/admin-guide/device-mapper/dm-crypt.rst
index e625830d335e..48a48bd09372 100644
--- a/Documentation/admin-guide/device-mapper/dm-crypt.rst
+++ b/Documentation/admin-guide/device-mapper/dm-crypt.rst
@@ -162,13 +162,19 @@ iv_large_sectors
 
 
 Module parameters::
-max_read_size
-max_write_size
-   Maximum size of read or write requests. When a request larger than this size
-   is received, dm-crypt will split the request. The splitting improves
-   concurrency (the split requests could be encrypted in parallel by multiple
-   cores), but it also causes overhead. The user should tune these parameters to
-   fit the actual workload.
+   max_read_size
+      Maximum size of read requests. When a request larger than this size
+      is received, dm-crypt will split the request. The splitting improves
+      concurrency (the split requests could be encrypted in parallel by multiple
+      cores), but it also causes overhead. The user should tune this parameters to
+      fit the actual workload.
+
+   max_write_size
+      Maximum size of write requests. When a request larger than this size
+      is received, dm-crypt will split the request. The splitting improves
+      concurrency (the split requests could be encrypted in parallel by multiple
+      cores), but it also causes overhead. The user should tune this parameters to
+      fit the actual workload.
 
 
 Example scripts
-- 
2.43.0


