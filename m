Return-Path: <linux-kernel+bounces-277601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6042994A38A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCEB1C22EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1E41C9ECF;
	Wed,  7 Aug 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFPXhE37"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9621C9DDE;
	Wed,  7 Aug 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021289; cv=none; b=WLxBnwI+Go3hjWKzIuRZV1Bl/4z6zh2k8YpGgJGLjqlqDeohDdnMw8hKTxYVX3QgilL9fX/Cc/LD/2WpiTyfFx0/Pe6Z8zWBwd33BvRuWBeEW0bmuOi3Px0WKjl8eTr6DuvEiladSdEKFRJSnfUOpdQnXrmk7yzbt5/16ihg3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021289; c=relaxed/simple;
	bh=SlX8DXsZ+LVAASbH3Cqud1npEMh02BJvpmBSpjguCLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n4dVj9rvW0D0OwQ0mOMxDG30kCTTO7SDIbh90178eCBNM9p5pyTKAAMyGesCzefAsKKeRPM3Sit9YKEPv2BUyIn2V3fvD9Em1bkNhYtt4yFPXyKeYNMCZUgK8B+sNQZheoIa3ZdjqECR3PQHhq8Mz19CaW+Y5a+KhGD9SW1ijVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFPXhE37; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd66cddd4dso16660945ad.2;
        Wed, 07 Aug 2024 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723021287; x=1723626087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZyYZcWScXx3hCzshTooGI4mg6we9/4Iww+0qQQ3pQ0=;
        b=DFPXhE37DXE06k+MbhfnqTf/3KEnNc61tIZAON/IZitYeZCNFL+SrYqFCpX49Pla7m
         Iju2FKOwYN5EXGcbrX7QVU2Xz4Ss4ggzNLn/9WvmgeCvNXCSCG8HmzYNoUo5Fb0rVi3J
         kd1y9Z/OrUrXI/EjZ+0xJv4MHoaYolmhSDgtyjFKvqWX4ZUH80AULwNO4pHG2AEts08J
         sul7XolCTaQqAvIF4JK/1cKfVpKasuDI5UNsItXW7ZUFvX5O4RH9NeXGcjZKkjaix5Cr
         zj8x52qo0Uqy5T3MRYtRuAA+8rE2pXWdwIZr5W3yCW77Ltmy7tVropOkE8vffrqvXU34
         LXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723021287; x=1723626087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZyYZcWScXx3hCzshTooGI4mg6we9/4Iww+0qQQ3pQ0=;
        b=GKK581+zsjFZ+jg3IQPf33QAo5YbgcElaMGg0JW8xWkKwgGgTFekZIrH/Zu3VJS/S4
         YcbVqLtuuWLAzbmssaIWDj5oUBlqBc1wNnM5KQx33jLfc/lgPXEMy7PKOYJ5erRmU+mp
         YEzUK8x4N5Y3z1QzI4TUfLmJ9iJkpvm7OfiM4E7SR/w/PcSJnUJeBNRtk/iR1Y3hq2yA
         VDomr4MMfljC4g07PXCu0Pw01pst6dnuAlEiLSzQsJ5vKGIib6IPAvqNGU6uwxYjvKdv
         lIXQH+NsWxa3TUXPuuoZP+b7Rw6m/0FA7cX0H1HvhZY/x5hQu7VI2Ni3W2Tq0SarO4H2
         c1WA==
X-Forwarded-Encrypted: i=1; AJvYcCUQIo3YuikvDM227R5UvzDzFH1doUOk/YrEmv/4d9+zLzLZWOCVVSW9R9rlQ6Xi9lLypWjNUYJSEf79FMIGXJesKpq0fDpeoOpGU8y1EGhisd/ZIYytsxj+8Cz3BehmbTYfqUbd3B4Z
X-Gm-Message-State: AOJu0Yzq6TeG8kNzJI4/vzPMYKXVtfUi5Euk6Ox+r4TzJ89VuEYCqfLw
	+iccX+PQEDLY5/Hd9ZMSW2haLaox6lnf1JG9AVNBynvk+90BiTWR
X-Google-Smtp-Source: AGHT+IGS0K1I+nQ+fdK7tmFOM7XFjxcXffIfoQoZ1ulc1qDVT/0KTpNDWEz9eunY8iwx/PemP6mjFQ==
X-Received: by 2002:a17:903:1251:b0:1fb:9b91:d7c9 with SMTP id d9443c01a7336-1ff5722d9aemr255334385ad.4.1723021286963;
        Wed, 07 Aug 2024 02:01:26 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-147-99.hsd1.ca.comcast.net. [76.133.147.99])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20077167703sm29747145ad.86.2024.08.07.02.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:01:26 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: skhan@linuxfoundation.org
Cc: danielyangkang@gmail.com,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	dm-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: dm-crypt.rst warning + error fix
Date: Wed,  7 Aug 2024 02:01:21 -0700
Message-Id: <20240807090121.61064-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 .../admin-guide/device-mapper/dm-crypt.rst        | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-crypt.rst b/Documentation/admin-guide/device-mapper/dm-crypt.rst
index e625830d335..552c9155165 100644
--- a/Documentation/admin-guide/device-mapper/dm-crypt.rst
+++ b/Documentation/admin-guide/device-mapper/dm-crypt.rst
@@ -162,13 +162,14 @@ iv_large_sectors
 
 
 Module parameters::
-max_read_size
-max_write_size
-   Maximum size of read or write requests. When a request larger than this size
-   is received, dm-crypt will split the request. The splitting improves
-   concurrency (the split requests could be encrypted in parallel by multiple
-   cores), but it also causes overhead. The user should tune these parameters to
-   fit the actual workload.
+
+   max_read_size
+   max_write_size
+      Maximum size of read or write requests. When a request larger than this size
+      is received, dm-crypt will split the request. The splitting improves
+      concurrency (the split requests could be encrypted in parallel by multiple
+      cores), but it also causes overhead. The user should tune these parameters to
+      fit the actual workload.
 
 
 Example scripts
-- 
2.39.2


