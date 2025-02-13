Return-Path: <linux-kernel+bounces-512845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E42A33E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF38169CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C6209F53;
	Thu, 13 Feb 2025 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D3Ygj82W"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F8227EBA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447137; cv=none; b=SlJVkR+5jTe3yGwshfORsb6dHgP0s90GReVX9NXrgTkRnVWu1Ax7SJ0M9tvI3tJcS3jUeTU+0XXK84KxhEFLj2M8T9Pdr8O7Yjb7fnPgMjxA/Jcn0yBX2yNF60BDaIi8h+DKZb6B87MNg02+iupLfBJi6CSLH0WRK9khxbpTTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447137; c=relaxed/simple;
	bh=YY+OU/b5R2NZDBv+XG+fDZujvR+B8cCjfW4SIV4pBfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbyhubX/0iDmqDSgH4oc3D7hjYa24+zdfMoFDgRpjDIQ5PRxxTbVMzxVKHs5Jt5Y+uqo+X56+dAi3GafrZh84CZHdkFmRsSLjTNfmuGRj82kcJlbsamVMLWL7MDcrOM39norrhxuehzslEy52dbeETx6MxKCRavuO0pHJ+1ZsbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D3Ygj82W; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7ee6f5535so14887366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739447133; x=1740051933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNK7rLFtZxlsVr2HlY81+ucXl/w9wHCFQRGCafrM+CU=;
        b=D3Ygj82W+/FoU+wszva4D3Pv4SGz0w68bY9agF1aosOgZAMx5aLqJnslYdZ3hWbzsz
         XIGEQGN6nU3BS+1NDLrf4XpWwINUoACa1XGP94ZXgHvUHeUtvJSDyQKVK++O1RvAtUZL
         U7y14eUWvbNIPcgUECwp9sVYDVvbPii6k5Wj5yGTIzy7DXrpaLGlSQqzCFsoQPGPpe8k
         DyD5Yp8YCJrlC91xhhOCTp+KSU/wDDdP4Lpw1Qg2A5oUtKoq9at31B8uvcOLx8tH53JM
         QigWfu///41DwuXIw2Dku1Cm1NcPeS+fF3NPJSUwbgP1Q+GTbaV8mLcdRXnSy9/xLF1V
         WXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739447133; x=1740051933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNK7rLFtZxlsVr2HlY81+ucXl/w9wHCFQRGCafrM+CU=;
        b=QVXi5HiFw5lRyMi106gvkOS8qVQ8G4RW0pFcT8NcAE7W2M59HEk5ZB8ZBssnIRdZzb
         0QcLorkwjm2hS4TKQZ4IwMogThAU9uKKYLP9LoTCKEXSLf+F1Of4ynYdiYxrrPQav6gY
         ie0KDs72M0ya7t5kpqz8Z4IrNUBpxu8Zt3FoaD8CEKIKyZcKpG8zesSH6XjS3s8bDF+W
         SuUGqs2cM/ksy4rwRNSq1Je/UAlIgp8S996kPZ1Zpw0SAV8guw8xhR3toFRRvvxO6fJr
         19ffYVLhRVxkMBKS9plLYWMX4kTlEv5DYLWnPEsOsX5O3PkVtNQOJ2NmSUx6ngZOQhOJ
         fa+w==
X-Forwarded-Encrypted: i=1; AJvYcCWtJQiElly9aqX+GN6yzbcN6WF4fLRP+cWk/UPnll25aU1oDIk2SZKFv5650DOiRHa6rLvqlKs40hXF+Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMAdyIeTmsPnVEZAnubAOJM/1S5qxU3ST3iOumTLPBJDFrGzvD
	4FMHeGh66M1kce14oUZzl/05mxI0fIcVIarqxzQEkTdn4tpL5kcSzp6VBsKemmM=
X-Gm-Gg: ASbGnctBAPh02FpCrmAz+mOAle66wDJyGn5PsiQ9JxwJe53rVpC1UiAvzK7jOjyxs/d
	O5onIi0spOehb5gU2GNv+oMRyDEaHeVB+dHs6XbP4olDWbL818Yw5NhH9pUzkK5hwsRy9D+aYlz
	uROkJg/WedQChG0dOl4eyIHNMgP+xy8fOmE817f4IdeBfjSyWaOw5hx02fmapRrvhTtWTl1uUjl
	OId92XSA/S948wfQj4/IZ0stESKn3TTurNwI5a3oku1mp2akSyRlPBU+J6YPcd51QtbqAp2BG5J
	xLIke1rB0CGALzORu+ld/U/x6Dn3jUAfiCOKbuhqiwDQBil800v+/OGCkozWQ+oTeBRlcMy9bcq
	14o6tug==
X-Google-Smtp-Source: AGHT+IFhwk4ltxE1xQ3p0mGfeZawu/5MpD6Z/sNSEWalFb7gtGBPeQtv4gNW8tEYCXMCRKVGAjZ0ow==
X-Received: by 2002:a17:907:60d2:b0:ab6:eec4:c9c2 with SMTP id a640c23a62f3a-ab7f33cd42emr238790366b.7.1739447133131;
        Thu, 13 Feb 2025 03:45:33 -0800 (PST)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339dec3sm115780666b.157.2025.02.13.03.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:45:32 -0800 (PST)
From: Petr Tesarik <ptesarik@suse.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org (open list:MAPLE TREE)
Cc: linux-mm@kvack.org (open list:MAPLE TREE),
	linux-kernel@vger.kernel.org (open list:LIBRARY CODE),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] maple_tree: Remove a BUG_ON() in mas_alloc_nodes()
Date: Thu, 13 Feb 2025 12:44:53 +0100
Message-ID: <20250213114453.1078318-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a BUG_ON() right before a WARN_ON() with the same condition.

Calling WARN_ON() and BUG_ON() here is definitely wrong.  Since the goal is
generally to remove BUG_ON() invocations from the kernel, keep only the
WARN_ON().

Fixes: 067311d33e65 ("maple_tree: separate ma_state node from status")
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 lib/maple_tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f7153ade1be5..0f2111d436c4 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1245,7 +1245,6 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 	if (mas->mas_flags & MA_STATE_PREALLOC) {
 		if (allocated)
 			return;
-		BUG_ON(!allocated);
 		WARN_ON(!allocated);
 	}
 
-- 
2.48.1


