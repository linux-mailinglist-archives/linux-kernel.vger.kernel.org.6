Return-Path: <linux-kernel+bounces-326983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF11976F77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326B91C23593
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5AE1BF7F1;
	Thu, 12 Sep 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhaumEMd"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C47158DD2
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161762; cv=none; b=gqaxXQBXpxo0jRRbdf05NaQ/ool6+4jTAe1lmFEVDQxt/LWuUsRx4UFGoWY9KJ3Y+D+n1gDWY4yIrwrwMwlL/UUuJYqPyuGDBHD539mZOSGFlEcCOLlBfP1u3vI6VXKapFW7YzRInwUhFEBGG0fcybW3NwFxbqDLjB18f+BRVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161762; c=relaxed/simple;
	bh=pxNvmEq5QlTet3+8Ka3sAa3aczDBESjV67G5PvmWMUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mpmt0h7IuFBdtWUYPw2waHOtA+Qx4ckWh4RnSTujVsptDdDFiCYUAd01pnyt8+NICHoBHLlMimzmcLxk3N+XSJtOfVLyXnRj7jF1stVM2V8JT6hfQJ8pViCTHgAlS9qyd5bL8YIMhm6VpvqdP5BOHTDK4oJ0moPxYgJFIXFmUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhaumEMd; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso1148280a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726161760; x=1726766560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDOX5j9BpxBbwPDKPBgnjgeJFyPPtDXmwFa02m5fEQk=;
        b=MhaumEMd1Hp0WW80AqndF6RO31DMz1j4uKXCItugT6YBg2Fx8SmDM9pTsM8AICrTKR
         smDT+cK2IhgDgFn6qzRh6Qn0Yt/5+7ervbDHwg3HS1yu50oWbtgTXr1qLgG7Did5u/i9
         sP9y+qjTA0qv/VMiSWuxroSCW6hOfWSCtGYYzEuHKoKfIfWpAB5GHzRJJbkT8/+CwjAd
         bETyHqbBgZ6gb8jFaAhAamcCmz+U6Cv+hw3xZ5KIfvzLD5auJogtnGRaU8j2KNRv94va
         osTllgy2Xn3F6U+DY3DDgcE5I+yhg6lZA/8ed+vD0LYDduwgFS2qcOZBy7e+dlUYx3ZM
         cLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161760; x=1726766560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDOX5j9BpxBbwPDKPBgnjgeJFyPPtDXmwFa02m5fEQk=;
        b=wXvW39G35PGB9aUvGtQqnZ58gIw0ttY3rdydmiX9uoUps59oyqPjfWYG84ofUjiznd
         BLU9idos536RYx5dGdDHfjei/LZPyv/cjZLKXoILVDjrXg+ThiJ/hRBkldKpeWzyMiKS
         iW2M0CmK6usK2S5etbYX9sdwkhpNE0B+GVb0+laBquN4IbSMJB/4jMQ8724zRJ71b64P
         zxs4Iz3c6wvUojgURMiXQjhJb/VlQ/xKc/HtIZgeVEXAqjJk1inzXxVoUSIrB/+4agTq
         pEXAnEJFIQcCXorKpPsq1jzTJpI1TRcPThcxUwFi8kBUHsANnlh/+0jhFWXeTrgcgkX3
         yJBA==
X-Forwarded-Encrypted: i=1; AJvYcCWOPLLJxbq0PbpK+N3pqLewh3l4vhkdnZqSuVnTJdOpYWLIuPrXD6Q7aBQo8MEsT/upzFZ+JDO/0JJDxwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTfjgoEKcjYkeI2XorU3zYJSD9Fs/P1UIyxowdH/Pj21dcTJ4
	0+5d3ArCRwjT8s0kpYoO0DW3CWb0zcgV8J3avkiOehmeAWlUFgYk
X-Google-Smtp-Source: AGHT+IHOONd5GoqrCv28UoIPTOzPATOJf1fEQXU3Q8j5mHBTE7M6ofoDdgrilpG5VHlsshxFm5tMKw==
X-Received: by 2002:a17:903:2b04:b0:203:a22f:6b09 with SMTP id d9443c01a7336-2076e334c05mr55343525ad.13.1726161760382;
        Thu, 12 Sep 2024 10:22:40 -0700 (PDT)
Received: from embed-PC.. ([106.222.232.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af2745bsm16567035ad.60.2024.09.12.10.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:22:39 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: gregkh@linuxfoundation.org
Cc: skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: Use new initialization api for tasklet
Date: Thu, 12 Sep 2024 22:52:31 +0530
Message-Id: <20240912172231.369566-1-abhishektamboli9@gmail.com>
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
 drivers/staging/octeon/ethernet-tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index bbf33b88bb7c..ae1bac99b461 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -40,8 +40,8 @@
 #define GET_SKBUFF_QOS(skb) 0
 #endif
 
-static void cvm_oct_tx_do_cleanup(unsigned long arg);
-static DECLARE_TASKLET_OLD(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
+static void cvm_oct_tx_do_cleanup(struct tasklet_struct clean);
+static DECLARE_TASKLET(cvm_oct_tx_cleanup_tasklet, cvm_oct_tx_do_cleanup);
 
 /* Maximum number of SKBs to try to free per xmit packet. */
 #define MAX_SKB_TO_FREE (MAX_OUT_QUEUE_DEPTH * 2)
@@ -670,7 +670,7 @@ void cvm_oct_tx_shutdown_dev(struct net_device *dev)
 	}
 }
 
-static void cvm_oct_tx_do_cleanup(unsigned long arg)
+static void cvm_oct_tx_do_cleanup(struct tasklet_struct clean)
 {
 	int port;
 
-- 
2.34.1


