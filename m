Return-Path: <linux-kernel+bounces-410342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8786E9CDA23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EDEB22CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FE918A931;
	Fri, 15 Nov 2024 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNm+hVkU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F93416F851
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657623; cv=none; b=Tb5HJk85X8Sx2cUqWiSqLZvIpUos8bKyCjd6wf/VHseUClCUtPg8RNou2vNok2Q6YPeilNtoSBpesjABBk77cr2RN4bGjWfFmB+nZcyKha8orfPt4Rmfk+y/yooQMvmOxDJkBCOYyF3lF6o0kwy0iWthHxihLKpJKIlXtJ4+BB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657623; c=relaxed/simple;
	bh=7I9Dpf4vIeqGxg2ANx/uqzFrzV4Jcou62ECo2RBhnow=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LG+M8a/CHjgYABFcY2cwt3Mi4ypTuD4K/5FGoWIsSJJIfHFNi8mNZ7YbC7WUDsmEllgNrvJz7U0Nj/yso8eTdHMeOliqYlnLXROZf9yOy2g7Zs0F/wcjS6bbiADVgNNhyBKuwQwG2Zg7MIC85+eZQtVnI9ZEpj9DdH7IqHCx63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNm+hVkU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cd76c513cso13986565ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731657621; x=1732262421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfsfy9LrscUrRpjVUBT/GZ583qVwlWlgmPooq0UheVA=;
        b=ZNm+hVkUxtDggW6SxZ2en36MAY+svdpxvM6C1dF/EuJAGYyE0jFnzyzJba3JhU/2c0
         5+Nf4X+yEEB0Ls6Tboqo/I/eFRC5BTbq7f+DveuXqCF46AqBSeF69vjCl7adCuSom1nw
         WLyTg0OXORLEsHU0r7BZLBOVaIyaNPKrY4UgcqdiM8T/L+3aYu1BD8fEAJhUBuqsY7pF
         WYjmnjceU+Wv4BSQlZBGYBX+iGxswPv6uo5cOQr8umQ+J0+FM5IVqYBWd7LUbIp1E7P3
         YaRb7PU7NHFrubnj0h1yLxWrXRRZWt6dBZujUzR1t63zg43n4jZW6rXTg2cIyzYJo32N
         k4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657621; x=1732262421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfsfy9LrscUrRpjVUBT/GZ583qVwlWlgmPooq0UheVA=;
        b=BbCp6WADa0OfrObWtrYtRfesMCvYQ3dfBKSLhx4p48uShxOgzujECNDmnizt8SM380
         zAwvxeML1q+Vnf/R1Sz2Pc9FMcnhOp/mzG7g/ZdQpQryN+sq9R3dB+LkTO2EMwVF2Nje
         DYZHr9pzYJZYShvVfJ6RaXiZbvn1QThcw1nMHY+nArCBMixgjqhPMhvlZCCmuPdTMnr9
         32zJNRU2vmVXXSO5skwqMnp02VvS3iaL/rpynG4ghoWGTZxKpCX0btZULbjCbzSb2YAE
         bppT9/wy9nf4iFr/xrscIvB9eljK0N+GYFMpBKoxSgkglrSBP9aAm2JRDPd4Y6P2OsQj
         eRhw==
X-Forwarded-Encrypted: i=1; AJvYcCXpGvzNCJSoeed9Qs+zM9+/dv/rZUN6wzSED3eGF2RhEYEA7iFsF6WtsawvIP69D2N5ugyYRgrO7BNsxUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqbZbPsl/FLCtl2t2z1zTwZv2egRwLlwWD1vkiYtJQVRNM9Uvp
	siCgEJ+Y3dUk39cfibLo3qx7FK9xTC0c6Dw0og/8Fa682QqFXLpRA3f/m4Ge
X-Google-Smtp-Source: AGHT+IEvpCwPomO/0Q9FmOExYgVoGHcjaghFKE5dSi5ttGKcHh35wNzWC1V55UMaCqwf+9Lf3jpMQQ==
X-Received: by 2002:a17:902:ecc5:b0:20c:d5d9:95dc with SMTP id d9443c01a7336-211d0ebed9amr27847205ad.40.1731657621373;
        Fri, 15 Nov 2024 00:00:21 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-211d0f53ac3sm7161585ad.240.2024.11.15.00.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:00:21 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	"GitAuthor: Daniel Yang" <danielyangkang@gmail.com>,
	ocfs2-devel@lists.linux.dev (open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ocfs2: replace deprecated simple_strtol with kstrtol
Date: Fri, 15 Nov 2024 00:00:17 -0800
Message-Id: <20241115080018.5372-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function simple_strtol ignores overflows and has an awkward
interface for error checking. Replace with the recommended kstrtol
function leads to clearer error checking and safer conversions.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
v1->v2: reuse ret and remove blank line

 fs/ocfs2/cluster/heartbeat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 4b9f45d70..18333aa19 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2004, 2005 Oracle.  All rights reserved.
  */
 
+#include "linux/kstrtox.h"
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/jiffies.h>
@@ -1777,8 +1778,8 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	if (o2nm_this_node() == O2NM_MAX_NODES)
 		goto out;
 
-	fd = simple_strtol(p, &p, 0);
-	if (!p || (*p && (*p != '\n')))
+	ret = kstrtol(p, 0, &fd);
+	if (ret < 0)
 		goto out;
 
 	if (fd < 0 || fd >= INT_MAX)
-- 
2.39.5


