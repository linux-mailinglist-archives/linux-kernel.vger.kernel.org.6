Return-Path: <linux-kernel+bounces-290581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D509555EA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE6AB22CDB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D52F23;
	Sat, 17 Aug 2024 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hy4ZgiM/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125A12C475
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877575; cv=none; b=qa6uJphSct7b85X2+VBUUmL2oM4nXqt+2SuflOIf3EdHjRUsX4D8zrvVHekC1a3G0S1TY7T1h0Krv2RgdQ3B098UiQJeouDrQrobovx0l4C2BXrJRo4vnoW0VGARG1yC8DriOYIdaTYO8E8ptvLv69vOTRA8C8XQ+w//JMBFz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877575; c=relaxed/simple;
	bh=CzHStjjH4V8sPZdoqAFqWMk+oxPdeCbL03cvp8dl/zc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JQS9j/PK0twkJKdvwlsC94cxOqeQwlLaFwuiGizNqFN+2rtAx5ioCx13O6d2xx1gzDFVw+UGWXnLnAfdV2ud+r90UB4prIT4MHDnD9+p2g5unwQd8kdtyI8emVb739ZBZWeDjtkQOwdnTBgG172dmIMGUGGXNx+Ilce454Biens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hy4ZgiM/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37198a6da58so842570f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723877571; x=1724482371; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iayHuQdCGfrgLfhcreNqaNDx16C6Jh397QJm/SbJkWE=;
        b=hy4ZgiM/2D0kvCmQzX7EY6f74I182NKLsECGGQJxHlvdy/DiTjhAY1BYU9CXOFTQfB
         YRvoRp6b2wWvjIVI1hsZ/sRefkQO9Vk6TisKbMMf6XwMSq1blf26mkVDyF3KSUcDB865
         JMFhJQZ6+Yofnr50vk1SgeMlK7+LtixjxtNWLAbYaIxeXvxRAKiUnfUDb85b022Kaba4
         p9fpSO2gT1yKwuKeYnqiV+zGR0ZMSb7bPUjZ4k7a7K2ZxiDrPeOhD5zG6+shEi+bygJM
         LhWhSILjTvc797JrZh8yvQ0FrwPmEJXnWAqHbzROMPI15BhPG+8ldIXqKk93Q7Djv8qb
         yGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877571; x=1724482371;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iayHuQdCGfrgLfhcreNqaNDx16C6Jh397QJm/SbJkWE=;
        b=l7/MoRnnGLsAbbuEGZ0Ug/DLtJPtYt7SdJ0Mn/SB4Jxf1C5TXnb1q/N3MNQvRYibTt
         RpkRNKIuKzfzdnQgpa2+zC3H2M4r1/OKBbZUV6G8eVdguRgCae/SlPSGrAPZK+8qx6Fn
         fYWREE6Y7aoEZYb/jNEl+Hd/t9su+H9H03ezv8LPzgntKf6CTbFq4jg3+rgqKLI0w6gj
         BAx/YDizduxEny1oQLiTgYnt+ZRenMyTwSFJptz+/3DreTAkSex/+LMq/B5Z9+/LkXvj
         kkW11W8jExHGmCqVeFDx1kG+hChK3s/+p7vh0tbhnSKoh30yB5V4biBJ50u7Lh/kgRcJ
         60Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXyQc/6vCI0xqt9FNpMh4fdl9u7Q1FszaZQhGGEB9kB3uedmJ8wqb2VcdASEbycAHKdJnnGNXe0I+nQhaxdVz6u7GrlliBIp5SBHfsE
X-Gm-Message-State: AOJu0YzhEVhygZGszIeR/NDkJJJWiw536QEodl1oj/QDIDiHWPBX0NyB
	z/0dOL2xszao0bSuv5ZKDFIJHFNw6lrihgPdlSDVVYT2TxdDbOchOWjSbB8ySG4=
X-Google-Smtp-Source: AGHT+IFNIXj9oV9+Ox0dNnq+TrIQ0ML3idpxQu8xxGwKVDp40dG1KGsNY1LaeHzxO7S57gOvqrDEzQ==
X-Received: by 2002:a5d:5545:0:b0:366:ee01:30d6 with SMTP id ffacd0b85a97d-3719469ff15mr3757080f8f.49.1723877571207;
        Fri, 16 Aug 2024 23:52:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ab855sm5141246f8f.105.2024.08.16.23.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 23:52:50 -0700 (PDT)
Date: Sat, 17 Aug 2024 09:52:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] dpaa2-switch: Fix error checking in
 dpaa2_switch_seed_bp()
Message-ID: <eec27f30-b43f-42b6-b8ee-04a6f83423b6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dpaa2_switch_add_bufs() function returns the number of bufs that it
was able to add.  It returns BUFS_PER_CMD (7) for complete success or a
smaller number if there are not enough pages available.  However, the
error checking is looking at the total number of bufs instead of the
number which were added on this iteration.  Thus the error checking
only works correctly for the first iteration through the loop and
subsequent iterations are always counted as a success.

Fix this by checking only the bufs added in the current iteration.

Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control interface")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From reviewing the code.  Not tested.
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a71f848adc05..a293b08f36d4 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2638,13 +2638,14 @@ static int dpaa2_switch_refill_bp(struct ethsw_core *ethsw)
 
 static int dpaa2_switch_seed_bp(struct ethsw_core *ethsw)
 {
-	int *count, i;
+	int *count, ret, i;
 
 	for (i = 0; i < DPAA2_ETHSW_NUM_BUFS; i += BUFS_PER_CMD) {
+		ret = dpaa2_switch_add_bufs(ethsw, ethsw->bpid);
 		count = &ethsw->buf_count;
-		*count += dpaa2_switch_add_bufs(ethsw, ethsw->bpid);
+		*count += ret;
 
-		if (unlikely(*count < BUFS_PER_CMD))
+		if (unlikely(ret < BUFS_PER_CMD))
 			return -ENOMEM;
 	}
 
-- 
2.43.0


