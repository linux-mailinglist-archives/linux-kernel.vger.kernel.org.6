Return-Path: <linux-kernel+bounces-312146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5907C9692AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C92282D70
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865B1CEAC3;
	Tue,  3 Sep 2024 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cgQScIb1"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A842A1CA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336111; cv=none; b=PjjQomHOkHlh25zQXNfCF4wmST1raplVaU+aFp4AxxHjWTaL7UKu7pqbTW5MyhesTyJe+YqERIrVELpszxSBb/u9YV2ZMDnbe/UGIfhSm3HCVYjMhTrPI+7Y2oG4aBnRi+swKtB4H6z7QbnLIyczTFKx2m4gaRHsxAv1jK209PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336111; c=relaxed/simple;
	bh=atmh3TwGLm6A+mh57UlgIIzR2sMBOiiENgPkdxDSdSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWMnVrkzJzqqtAoJ5KxpeYXxea+RzFTk8ZJ9dUJEoxABESFTOEm2LFVDYI2tV6cBEU4bbhpP7yWvd45PyFwqG7P61ODGuXlosQEbV9be+yC2DvjQ1FioI9Ic0U5ymog11o9PRN5A5A3pI2BwFy5IuQvaVCo9SN3+8+oF8giVM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cgQScIb1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8b96c18f0so1385084a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725336109; x=1725940909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ftV8LT4FZJTlN5X5kHuknLXLmnUekYL9YIRf3bchnfk=;
        b=cgQScIb1eGT32AWZSRKXL5JCDOdZRKbRK230oJ6z8i0KyPq0QL0WFZuMTDBFErikig
         VbXkr7glZTzaPJclwOSgNj9pxb1mJ5w6EoGyp7+WpLiKpsVa6P9Dcweyp9YVQ82inkIj
         V5iVcbaCTCevhIpcmoXGiidx+3V1Umo0HACi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725336109; x=1725940909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftV8LT4FZJTlN5X5kHuknLXLmnUekYL9YIRf3bchnfk=;
        b=XsRMfBPiESx83tbqvgu1sEwsJo6wTblsq1k5OXoRgAId2N1KbmK86Fjz5Eyz1irJb+
         6O+UvTnpGd6mIyT9fOo/L5I6xToi8HDMpGZyUbHZKSPHweOngG/7orsMHwaEyGkg5y/8
         dK0UjcWdPSskdZwkPQsLK72pftHfnrAds/9+847LI0m4e8XiY3/7o87NRA6qOHEvwtop
         MkEVbI+vBsScOHslx24im9j/+NQo/r3bYe0B5WXaIiv0vIFVHVdG8GZKe1gVAoDBVGgL
         m+V9dOVqpXCo+DlVs9LmweCUVi/JZse8kZbl6y3K7OGPGJ+1pfu1w+Ov1rls2W0MN12n
         cuYA==
X-Forwarded-Encrypted: i=1; AJvYcCV/UO71PLbDtcnDR66F4hVBtb0osEc2QWgK8ypaqWFzuyLe7Us6ZS1k4JXEfCos3ozEvdre9iWNRxXXsIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9aLBXCsK8hp0iCy5jnGBEIUuTFbFf8RQEwzhkUaA/mirRzC3I
	ew6XblUvP9HrO2CaKn14YXwuZM7oBgrMdZhrSouYtzqKeHBdxq5vO51B5+3AlA==
X-Google-Smtp-Source: AGHT+IHgeshsC0UUKlfgFTKElAeJsUZNFA4bT2F36hiZ4Yerm4TqMaX/gtJKDrtvGKS550d1pNbbwA==
X-Received: by 2002:a17:90b:3717:b0:2d8:efd1:22e4 with SMTP id 98e67ed59e1d1-2d8efd1244fmr4399925a91.26.1725336109028;
        Mon, 02 Sep 2024 21:01:49 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8d71b9578sm3251294a91.6.2024.09.02.21.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:01:48 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] mm: Kconfig: fixup zsmalloc configuration
Date: Tue,  3 Sep 2024 13:00:22 +0900
Message-ID: <20240903040143.1580705-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zsmalloc is not exclusive to zswap. Commit aa3ba6d72ce0
("mm: Kconfig: fixup zsmalloc configuration") made CONFIG_ZSMALLOC
only visible when CONFIG_ZSWAP is selected, which makes it
impossible to menuconfig zsmalloc-specific features (stats,
chain-size, etc.) on systems that use ZRAM but don't have ZSWAP
enabled.

Make zsmalloc depend on both ZRAM and ZSWAP.

Fixes: Fixes: aa3ba6d72ce0 ("mm: Kconfig: fixup zsmalloc configuration")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index b23913d4e47e..1aa282e35dc7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -188,7 +188,7 @@ config Z3FOLD
 
 config ZSMALLOC
 	tristate
-	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
+	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)
 	depends on MMU
 	help
 	  zsmalloc is a slab-based memory allocator designed to store
-- 
2.46.0.469.g59c65b2a67-goog


