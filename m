Return-Path: <linux-kernel+bounces-262911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA1A93CE94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE55B22D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1771741F4;
	Fri, 26 Jul 2024 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRDQjoMo"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE6381BD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977867; cv=none; b=saPT2dRiueLTWsDBMbloN5c7rZxHuwGwZQFuJCz5nhi/LvtLSzo+Ob6B+jSXdBr+KcPksABtTfZ5+hQrJWkBmyq3G5T+5Ob4tUmLxBlwB0eXH0X83Z0RhPqgMxViHEWfqoFiChUPqcL4NEX6OoQlH5q9K53IITDCq2bmktulRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977867; c=relaxed/simple;
	bh=OxMTAIrejg/R2mhCdG/fWd4YcnQTd7Yj6WVY/HjlbEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qHLAQ8YVkcvB2h0C1WZYg0vXt1QDo6n/EQBDGZw9/bGSi+CdVznF+0WxUQgULsmwol5H0FPu6+VXNulM6N9FNTbpDmx4CU/VVdwgfHFzwiD2BVh5E4DuJMAEieRdiknRB6f8vDhVJKb8zKOIDa9EJzTzHpg/sO3HHjN3LLAfkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRDQjoMo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d1d818c42so493920b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721977864; x=1722582664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IRwB2VYbJi/ARjTBQHl2ucJrLiHTbO9zck6Jgublm1s=;
        b=SRDQjoMoxMtLYrMhxmzAfy5L24BMVqrKufSQ92Zzx+Xen05Ntj1wpudjGQXC38seFj
         +NnVpzgo3+AbwYovHCplRICS+4xGJRCu5b2301EBNbWAaFWIRjehKGSsIzSmrXlxhGys
         cTL24kjZ5nhAUy1i2mKr6/4APyfY2vYv0ZYhpWNEXZ+TUlrUzuFWes8B6OlrRFJoHtt4
         9cCJXXWiDb9hXK38ZqMuP/UTYhJIMrqgC9vWLpuNOVKMC9K5SMrjE7QaRrB7vA1FT3dP
         NcOsPAuKmnKNdFRjTj2LH41Od+dPK0Dxe2U2xYPsWLjZNjBX0EY9wG0xCzibxh90Pa6j
         eEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721977864; x=1722582664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRwB2VYbJi/ARjTBQHl2ucJrLiHTbO9zck6Jgublm1s=;
        b=a+YkA+IpBVUvuJQSQyezIpJWp2lwSxEmD3yY9sikMaLSb1RUWtGJWOpOL32EoPozgI
         wWKt0q4UmdtmPHc/3dzel/mz1Mn41W04WdMB9owOZFxYySgK+WfRK63izNjB5ykaL4QL
         Tdi+SOKViFEk1lCguPNvsmqm+pOQ9Be2E1hGwXQ2cn9R+FHjJ51H/3xvnl3amyafk/vv
         WjPQaz4pqm6tPocr6tdfIQUYCzkemAwR8yUcqKdxRgZDtbMqZPKLuPK0G0FbZW1/wzgW
         mI67TG95KwBYKU4j2CrjvIC6o/Bof7ktoKzRg3c2LZXsK1T/Ihh56nYmgv5bD9gOMBil
         BQ/A==
X-Forwarded-Encrypted: i=1; AJvYcCWveCfWhHM98fa1ITYqtxX+vMNSNeA6RsIAMiXJIZW7zaXc5TNaMqYwQRlKbMqH+er7wY4Lbtkq7m2bTyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2on+Q489OdXtJf1RKO8U0GGXhq0fq9Qc+IWMceelMzkEjtp8
	SXWLk9mHUCtdARYor5nftdzhB/YR2+E2CBdThJw+1i3G6dP4HlKQ
X-Google-Smtp-Source: AGHT+IFxKTI0hi7yZlMUCGv6/+Isn9gBEnoyMqF/N6W+HG2hH76+Itzus3wNEOsL8ORitnN3iDdmZw==
X-Received: by 2002:a05:6a21:3983:b0:1c2:8e96:f767 with SMTP id adf61e73a8af0-1c472aabf13mr6944335637.31.1721977864003;
        Fri, 26 Jul 2024 00:11:04 -0700 (PDT)
Received: from SYSOS.. ([115.178.65.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c5668esm2644789a91.1.2024.07.26.00.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:11:03 -0700 (PDT)
Sender: Leesoo Ahn <yisooan.dev@gmail.com>
From: Leesoo Ahn <lsahn@ooseel.net>
X-Google-Original-From: Leesoo Ahn <lsahn@wewakecorp.com>
To: lsahn@ooseel.net
Cc: Leesoo Ahn <lsahn@wewakecorp.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/sparse: return right away if sparsemap_buf is null
Date: Fri, 26 Jul 2024 16:10:23 +0900
Message-Id: <20240726071023.4078055-1-lsahn@wewakecorp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparse_buffer_fini(..) takes the following actions even though the value of
sparsemap_buf is NULL,
1. calculate size of sparsemap buffer (which is meaningless).
2. set sparsemap_buf variable to NULL (although it is already NULL).

These steps are unnecessary if the variable, sparsemap_buf is NULL.

Refactor the function to return right away if the variable is NULL.
Hence, it doesn't need to take further actions.

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
 mm/sparse.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index e4b830091d13..091e4bc2f72c 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -469,9 +469,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 
 static void __init sparse_buffer_fini(void)
 {
-	unsigned long size = sparsemap_buf_end - sparsemap_buf;
+	unsigned long size;
 
-	if (sparsemap_buf && size > 0)
+	if (!sparsemap_buf)
+		return;
+
+	size = sparsemap_buf_end - sparsemap_buf;
+	if (size > 0)
 		sparse_buffer_free(size);
 	sparsemap_buf = NULL;
 }
-- 
2.34.1


