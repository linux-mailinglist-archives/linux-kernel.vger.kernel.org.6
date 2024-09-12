Return-Path: <linux-kernel+bounces-325797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE36975E50
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DFC1F2332F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA168C1E;
	Thu, 12 Sep 2024 01:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/ChItzf"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E22A20;
	Thu, 12 Sep 2024 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102966; cv=none; b=OIuZaCtfC2q6J/wkLBTljQKRa1gSdYMCVutvm2Ngb8eMyfz3+Rzl9YGhoKwKsHrLaJi1HZOOc/wRxA6Mf3rqUvkiGo2ZCQWe3FHbc8SnFUw1EON0UKuk8GviAeUFDQVaA43Kj7HUBQP9pP48HcfGYlki+fb2ZIVVuoEgmb4IagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102966; c=relaxed/simple;
	bh=kgMUrb5VnJZXzPjSyoe8z0O898rpVpTzDFbnhUI3e9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbFpoNuil2kktvE6VUYrBqwb++G7GIeDbhoswkSc4eSxAlYK4LKtlAK76bt56kIGQccfo6FgLKjW8ZtrbXCw24QGU/3aQKD6gXWNHa+8aQe6tBFoTKJX3gsSrBzqOpfaoH6yEsoD27EtB2ocQTA2rrMJnf59WnaO+BjmnIduhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/ChItzf; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso2509736d6.2;
        Wed, 11 Sep 2024 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726102964; x=1726707764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhBfg/KfXuh3WRghq6RzRSBD+oKsI1VasMMAHjkTsb4=;
        b=Z/ChItzf+9lKPix48wJL76sxJIe0IJkQbXf08NwMfx8j7E8JwAzwcgjtWG8qP2Uh3U
         2ePyM1zuKGuCYKFvixapEELpRLJ5uhf7fIXgVlN0uJrw7Dq13onsnmG7eR2Icdp1CVx6
         tE9EFzG3Gi1wEFGHGNKVy6LnAuKpmnQDtGCwrIzVC7xi00jnGtx7K37+DLGum0lW/lz0
         zthVTwxqxjGnefSTco5UydAzUVQx05yxfFPczkRm2ZS937T3zi4lDm17wls7sx3GNFML
         L8lDRQ/WT9pb5TgK3ywY9qn0xY7eSSgK76bvlW9+jMe0R/P4EqaCHJQv4ziTAzFm4q4e
         aIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102964; x=1726707764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhBfg/KfXuh3WRghq6RzRSBD+oKsI1VasMMAHjkTsb4=;
        b=WwI+7TbB0EFXYV0wIiatkcozyGCYvggspOtOR++zVbmbWGGhd9uT8kl+qatIneDTEG
         WnDqKbPw+JjShdXgfpD362Z8ejRVGP5FuFrgS0uU75dKA03fkgr++mXFU9/l0vOq7FMA
         R8eA0QdAY23MYbH7gDG2/QC0pK5MohWdodUj5/4NBbQZ0DqzjW8vCaZgyR30inWLu0p/
         Lo+W9iUDvzqmHz6xftX5Yk3Gp6pmY0kXcPRmnaGh5luc9Bhl38DH7Q1bbNv4rwm8TQyL
         OpRr11/Xi+zuYhFhd8N7YMZaC/uglalucnO03RvD41t+v3lwRIc2zt2bdqhj8bXQcODP
         B04Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvCq1lnqWOWa7n2EG1VbNcyaq0h2bbUbF2aqRcWmjXLfbzWzmRKIe9RTcBqBJMV3woj9hgO2h7plIGh8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeZILSSs7vI9LbmJnyUlvc7MTUIBnlR1frAR5MzZ6QSlGhKE7
	zVfPhmiBQQe8qvkWpl+Y2ePFaM8QiKnl0BzchjD3zPdqRg2aSehMC3HpXqxj
X-Google-Smtp-Source: AGHT+IEN+qyzpKLeBQ9+lSdnRag5IpVESYQ3EOhBj11USzogqadYnHderpROBr6cBYi89w0VF2RuyQ==
X-Received: by 2002:a05:6214:4304:b0:6c5:caa:dd83 with SMTP id 6a1803df08f44-6c5736cc039mr18764546d6.41.1726102964337;
        Wed, 11 Sep 2024 18:02:44 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6c53433b551sm48174816d6.55.2024.09.11.18.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 18:02:44 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [PATCH] docs: filesystems: removed the :c:func usage in the journaling page
Date: Wed, 11 Sep 2024 21:00:26 -0400
Message-ID: <20240912010025.8181-2-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit removes the :c:func in the journaling filesystems page.

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/filesystems/journalling.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
index e18f90ffc6fd..e079c048cf6b 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -147,16 +147,16 @@ blocks.
 
 File system is free to perform fast commits as and when it wants as long as it
 gets permission from JBD2 to do so by calling the function
-:c:func:`jbd2_fc_begin_commit()`. Once a fast commit is done, the client
+`jbd2_fc_begin_commit()`. Once a fast commit is done, the client
 file  system should tell JBD2 about it by calling
-:c:func:`jbd2_fc_end_commit()`. If file system wants JBD2 to perform a full
+`jbd2_fc_end_commit()`. If file system wants JBD2 to perform a full
 commit immediately after stopping the fast commit it can do so by calling
-:c:func:`jbd2_fc_end_commit_fallback()`. This is useful if fast commit operation
+`jbd2_fc_end_commit_fallback()`. This is useful if fast commit operation
 fails for some reason and the only way to guarantee consistency is for JBD2 to
 perform the full traditional commit.
 
 JBD2 helper functions to manage fast commit buffers. File system can use
-:c:func:`jbd2_fc_get_buf()` and :c:func:`jbd2_fc_wait_bufs()` to allocate
+`jbd2_fc_get_buf()` and `jbd2_fc_wait_bufs()` to allocate
 and wait on IO completion of fast commit buffers.
 
 Currently, only Ext4 implements fast commits. For details of its implementation
-- 
2.46.0


