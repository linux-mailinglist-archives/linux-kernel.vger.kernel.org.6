Return-Path: <linux-kernel+bounces-340930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2439F987925
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800F8B245FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B0B16A397;
	Thu, 26 Sep 2024 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoA3sg/o"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62DD13777E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375836; cv=none; b=DnEWG6pU5EUjTTkoPURPQDGWWIn/KmQGU6OtITTUpXprGrqJaaSxyzrqKMvXLihVB+QxVeix4pHMDziTw9SOei71au1W96qNYKs09eE/j/USfqvc6c89nkuKUbGMBKmbKsnDRdI/QTXMTD3E0Ri/t14ud/qopihfSpYJsDvRrtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375836; c=relaxed/simple;
	bh=JRfHLZNB0mzP/1R94z7ZrlcFEayHQz9WzfbePKbrsWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1cVgwypsdt061omKk1lsP2xHDGSpzXwbO1b+b1A6910Z+4aCwStHs6M7sM3nAkkvIDMd8l6Wqbuy6t2RvhpzMFWDotnI4AfQZwFin/Cg8rNe1PuXxumIo71u10ex6rII2a6+4OpW/V8UvXrYiF0bhdQAHa8PS+9uGVz7nju6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoA3sg/o; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1861982a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727375834; x=1727980634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+85r66f+dsQtAvZ2ojMyKraolRdBy3fkuiARcd5pSLQ=;
        b=LoA3sg/oufZwFFNQDWF0lY8mcaNqUA/Nuv/wcm6onhcPR4wBFZQLB914aKjGuOz1DP
         0R06Q1IQi20sjbDTozGI9+kV15p6c/56bPRJdFzuduJ55DtZofHXyOEqB2wJ18ztIBrJ
         esbd3Va97R3FLaYDXiu8ZlrmYpvd6gNckHcYJS49duJgax3QBnoJ/fmXAnSiBF8UFmfB
         A2sh42A9E3ocIQb6KzU1yYXybLdH21B5zaBtR+DQ8WJTJnGmgFdcwLIqXlPR5/0m0qrI
         h+8cHE4eAomsop2Hp3mXuc3BZaRrtHhkh3XwkGWlj2FEKKXqX9DbYWn59T4O2wkrsNyL
         oa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727375834; x=1727980634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+85r66f+dsQtAvZ2ojMyKraolRdBy3fkuiARcd5pSLQ=;
        b=N7a9HuaL0rERBblddl1wE3xQu2CuBKOBLbuH5qO24DAO/HM16yIQxMabMmOs+M4FmW
         n9RObCdMG4DocExLmv+cX0+toebE6PHNqxVYjZyIv7D+p6sPL6URU+R5ID1wotVSUnnD
         qRnMQN1P8Bl/iZ3U+XCU4J43wegG44Zia/qnWCzK/EpAJNdY6dACL8Q3QKgaJk05gCOF
         dlJ8SsvzF+YUJ9R64614PFpuoycMRgl0YPx0AL81Iq3VLPsw3QOuw15jua2EuzA0tiiN
         Q94QtoxWjoNpYNHDlKaJZSvbx24H9nSYFrTEiZIt7k8GBpBe7CIFQU79nPXs0y/uRO5f
         u5EA==
X-Gm-Message-State: AOJu0YxfY2HWM49+cFjfwrDO8HEvVaL53gESBCyE4MraJSQx+NjxdKfw
	PB2712GCCrqm2RQtk5+dfTVlX8QZiVxjPsUnAFT8TW8PXvrjvbbH
X-Google-Smtp-Source: AGHT+IF9RB5pon0jPs/4BtZuM3n7w7z/1RfXixExobhcuCZldK5MYI7L+n5m9x9r0uz2HNxrFE50Kw==
X-Received: by 2002:a05:6a21:6f83:b0:1c0:f114:100c with SMTP id adf61e73a8af0-1d4fa3c0a4bmr1263811637.17.1727375833923;
        Thu, 26 Sep 2024 11:37:13 -0700 (PDT)
Received: from localhost.localdomain ([115.97.189.145])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b264b7decsm215249b3a.47.2024.09.26.11.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:37:13 -0700 (PDT)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	tanyaagarwal25699@gmail.com
Subject: [PATCH v2] mm/mempolicy: fix comments for better documentation
Date: Fri, 27 Sep 2024 00:05:16 +0530
Message-Id: <20240926183516.4034-2-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240926183516.4034-1-tanyaagarwal25699@gmail.com>
References: <20240926183516.4034-1-tanyaagarwal25699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

Fix typo in mempolicy.h and Correct the number of allowed memory policy

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
---
 include/linux/mempolicy.h | 2 +-
 mm/mempolicy.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 1add16f21612..ce9885e0178a 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -47,7 +47,7 @@ struct mempolicy {
 	atomic_t refcnt;
 	unsigned short mode; 	/* See MPOL_* above */
 	unsigned short flags;	/* See set_mempolicy() MPOL_F_* above */
-	nodemask_t nodes;	/* interleave/bind/perfer */
+	nodemask_t nodes;	/* interleave/bind/preferred/etc */
 	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
 	union {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b858e22b259d..613fdb73c404 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -8,7 +8,7 @@
  * NUMA policy allows the user to give hints in which node(s) memory should
  * be allocated.
  *
- * Support four policies per VMA and per process:
+ * Support six policies per VMA and per process:
  *
  * The VMA policy has priority over the process policy for a page fault.
  *
-- 
2.39.2


