Return-Path: <linux-kernel+bounces-328781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726519788BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F211F2139C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBDD1487E1;
	Fri, 13 Sep 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKhuJb0c"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67014658B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255063; cv=none; b=rZwxY2y4zVDhXOft3qsNK64J1TN7tYApFhTpDxYpP3hG5AiVNsjo0FgDeQFGRS/O67Mkq3YJpX/aOetkXoWlLss1Ryy6vJvKWqjROn8NfJGOvpBTnBU3XYr1+5tXj82HH2K+Spwz6HAH8P/Gg1wGCqLqscPnSf09PaqQCNGAImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255063; c=relaxed/simple;
	bh=yWuHN4hOrAHckEToIrtlx40+ngK2VaRLBRCYDXTOO+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4lB+nGktpMygAxYHFyM4RKSHP1r004Q8UJVsFLZbeagrobG+gd1RWfQy71UDSgb0T+jmO6aH/KE+tsyV7NOqvtoVAlTGZIyBhWiad2sv4SjSCaR8bn+8tAx3WSIOqPdVepnuaZ8Nfqij54qnzxAZ/xPfwRl42+PJk1IUweQna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKhuJb0c; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fee6435a34so23660535ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726255061; x=1726859861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jcIHqWkgAfixknzcAhPYZoyDkQ52gLcOsIWSku0RSo=;
        b=RKhuJb0cKfvSaZpOFk+3Vljq3yL+HMD8VdV1J5nI3GvcDkHN3Y3MWPlriZxEZFBlav
         OPYpsIkTgQciG6PEbYdPrZjcem2YQi9uGHcpr97vifQM2FNGCIiQxRyqI1PGVN/zNiJQ
         /3sRHXry7t/FrUVtzS274QTbtrkMdO1oc3lzJ8cquKjTMdyM6FOhGFyXXZrEpTQl9VCP
         qTMZEgtwmEw2pedJzBeCPdMut8rwzsilcbIJzku0jIhlkoSNjIwKrtIBKPKh4dxsPnPp
         CRG/dJQNCYf1FoBEPGY3ADzzwTNu8yz8o/pNCvBPsoh7EqGMFuV44wWAwCJ+0nuCXAW3
         kmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726255061; x=1726859861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jcIHqWkgAfixknzcAhPYZoyDkQ52gLcOsIWSku0RSo=;
        b=JXM3bpifYYw0YyeGtupzicITSI7OWA2WdkQg2E/GVvc+YU0RCNJECOQVWP5b3tsfdv
         Z9OFiNzPssQJGZCF46FeLDUdx+bWRnCJMygl+NeXW//g586dnfXmPhQAo8ILpjD5SLnH
         XOPrytbDJAhe/Xk3QXC1HVaTVOP1jaUa4GMzo8EvtbzXl8booXhR4GPOsypkpN/rJevs
         TXy3LMOqLn6Wc6shcp4i1WcuRJn27Grw2wiNLEwAzWXEYx0KviWCbF8a8eHeyPGIgNuZ
         dMWFTwvdSqrv9cQMhvrnFNrURzcOrgXU9tHwJlQghp6K+6h1LfE0qYIK8S5mQr1u79P0
         C+uA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Kc7FQ63mJOj5aYvBkcnYDxuRDHee9P8ycDlWniIkCbhj/7BOYSz+ubIDdNpX3LHXHUjDOwxE5f1t4EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzplyNyk1TUYTcOK3X+bDXiucm/LiPFLQ1BmuBcnHoJWjfMzTIM
	LEmu59M3Sa/pH9cymJ0MnhkqWUlitGySOqnR9jxStGu2XbxiV1F3
X-Google-Smtp-Source: AGHT+IEefJq989ae2HFQTbfTrintN5mE/N+S5NGfHELvPZ6eTmyNQifeCKgcEqlVYLZymntY9GVheg==
X-Received: by 2002:a17:902:e802:b0:202:2cd5:2095 with SMTP id d9443c01a7336-2076e33e92amr108363275ad.18.1726255061405;
        Fri, 13 Sep 2024 12:17:41 -0700 (PDT)
Received: from embed-PC.. ([106.222.228.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b01b4d7sm30899105ad.295.2024.09.13.12.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 12:17:41 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: gregkh@linuxfoundation.org
Cc: skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: octeon: Use new initialization api for tasklet
Date: Sat, 14 Sep 2024 00:47:34 +0530
Message-Id: <20240913191734.805815-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new api DECLARE_TASKLET instead of DECLARE_TASKLET_OLD
introduced in commit 12cc923f1ccc ("tasklet: Introduce new
initialization API").

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
Changes in v2:
- Fix the build errors
[v1]: https://lore.kernel.org/all/20240912172231.369566-1-abhishektamboli9@gmail.com/

 drivers/staging/octeon/ethernet-tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index bbf33b88bb7c..261f8dbdc382 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -40,8 +40,8 @@
 #define GET_SKBUFF_QOS(skb) 0
 #endif

-static void cvm_oct_tx_do_cleanup(unsigned long arg);
-static DECLARE_TASKLET_OLD(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
+static void cvm_oct_tx_do_cleanup(struct tasklet_struct *clean);
+static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);

 /* Maximum number of SKBs to try to free per xmit packet. */
 #define MAX_SKB_TO_FREE (MAX_OUT_QUEUE_DEPTH * 2)
@@ -670,7 +670,7 @@ void cvm_oct_tx_shutdown_dev(struct net_device *dev)
 	}
 }

-static void cvm_oct_tx_do_cleanup(unsigned long arg)
+static void cvm_oct_tx_do_cleanup(struct tasklet_struct *clean)
 {
 	int port;

--
2.34.1


