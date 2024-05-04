Return-Path: <linux-kernel+bounces-168611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1B8BBAD1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392B4281F8F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC58820DFF;
	Sat,  4 May 2024 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6rSsirU"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360120B34
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714822729; cv=none; b=Sy3PZ7CHjyU6UuKnErZxdYw00s+VIP0uvUnXHxE3DKQna/TNRZh/sYp2z7Pz4Iw88y0K/bPj7gCi0JLs+7Rlc7BGyvi/fgWg3u3aiv5TjQ3R1OGV11s+6LhxWBMePNNJRZ/MJijYM7q9KSBsNRM90sfmyha534jvZXzp+EN84Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714822729; c=relaxed/simple;
	bh=W7sFU/NBzY2gTAuU7v68tSUG7bpYXdqwLPRfBVRFeu8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PKUb2BeNCWKpMnellrM2Q9ug5y7q1omWTG8TLdv49diG8llykE14dlKCvz/B+yIsb/qgV3k/CFmOlQJQlW3YgQZ2CmIZoxX+Z+YS8C3aYqD3qqcpFOreESOvEUnza9P2nBOWFP3/FzNPcf5QiDP6knRHkPQ/7R/deWuN32tgujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X6rSsirU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso3431475e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714822725; x=1715427525; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MA9CnCgEcVb7taExL/ppkOG7f3FT7xMxv2EZ6jhbciU=;
        b=X6rSsirUKwf83GPK55ontntEXXPnWa/x1vcp1AJtyHn4Pfkfax6iSIoqDLYEoieufK
         GEf+aUIWNcD9ck4d17ceNTX5xLYzwPIR1Al3F+AUBVPQ+reFZCRPNwU9R0fA3KleF8Aw
         nc4kyu9sjzBr2JJKNghChAvi9+yTgu2ZazeRyWJG2krXuaw0WleVTb46Um2dWhu0O7bF
         g3vleF1Zq8MoJ4vJdLs7u70d0ovT2GJyCsHqZV3JmvIlkKZTc299H/svEg7rdK4/dSIF
         UR3eWD3llc2/SBgxbacPV4gcXrSp3GwCw0g/XFXeJePmwuKGntIz1FkFBGlKr7YQD9Zu
         yLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714822725; x=1715427525;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MA9CnCgEcVb7taExL/ppkOG7f3FT7xMxv2EZ6jhbciU=;
        b=j065h7WGxbsTl7DfOfWue97sYtXU0eC+RvduxNK/uuaLhGoD/ECNWvuxaZ2C6do7EO
         y8ELO12mMLA93EIP30ZGVozgiwK7O2uipJ0vNE4Fxt7zi55gWN/qNsDu1hqQPr54ZGG9
         hGWfnGDiSotTvIJ9hXck+X4f2ZEIkouf25IiVbAeaH35GXrS9MiJX4oqOgptW0uArXu1
         8vn0PAixk/ysfMadrSN08sOz0S+qsmZAB4K2bJMNia9GLX/3xXXNyOCf4GgzEblC5HqZ
         wVAMG5xCygY1ULICHSomBoU9RZlYJpMkvD9NEn51Ezmt8VpOijXJ6K9SQmOrPkIL8qlR
         IC4g==
X-Forwarded-Encrypted: i=1; AJvYcCUj7p3Ctf5amheLkq+XszUg3JRcrHNL6oHX56R7b0/9HVYkfyVKnNtXUtff2Y8ebugdKaOO86UuY+i7I0m4lRiCEjx4Z2qI1KlDoFsH
X-Gm-Message-State: AOJu0Yyhtdl5s4kFvygWq1BLgpFhIMz6kgr3Xgnh8lFcH1wTGb/oJ/s4
	uc/+2WqEMC095iOIno5kvy4GcRZnWYNeY8yrTnc9GX74WSwQwpCfr3/LhXol4x8=
X-Google-Smtp-Source: AGHT+IEkJ4fOtICM941w8eVuYTvSQvPKGtFpzVYQYzbWbR7QYJoZ1oKTpJnJ8jAyaUP+45cwLrsaFw==
X-Received: by 2002:a05:600c:4f07:b0:41d:d406:9416 with SMTP id l7-20020a05600c4f0700b0041dd4069416mr4117137wmq.34.1714822725029;
        Sat, 04 May 2024 04:38:45 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4988000000b0034cceee9051sm6018954wrq.105.2024.05.04.04.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:38:44 -0700 (PDT)
Date: Sat, 4 May 2024 14:38:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Boris Burkov <boris@bur.io>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: fix array index in qgroup_auto_inherit()
Message-ID: <a90a6d6b-64c7-4340-9b3d-7735d7f56037@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "i++" was accidentally left out so it just sets qgids[0] over and
over.

Fixes: 5343cd9364ea ("btrfs: qgroup: simple quota auto hierarchy for nested subvolumes")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Untested.

 fs/btrfs/qgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2ca6bbc1bcc9..1284e78fffce 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3121,7 +3121,7 @@ static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
 	qgids = res->qgroups;
 
 	list_for_each_entry(qg_list, &inode_qg->groups, next_group)
-		qgids[i] = qg_list->group->qgroupid;
+		qgids[i++] = qg_list->group->qgroupid;
 
 	*inherit = res;
 	return 0;
-- 
2.43.0


