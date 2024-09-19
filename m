Return-Path: <linux-kernel+bounces-333754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDBB97CD6C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E581C229E3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1D41BC39;
	Thu, 19 Sep 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3kyoyA5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65C1802E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768993; cv=none; b=ZMe+NJRRDyrX/LQA92Lam/2Tlxae2DOv1JnBcswnAc64FjWsJxkImZIM6ri2YlPK1C4dP28HmewyTMpkpXyYix/Lf84B9Mph8NAakbaqcYUk1Arh8SFQokHvqX+/Hl2uYBYrCape1ItsdyeweW5blqQmxbVJDBN2r1BWGaEavOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768993; c=relaxed/simple;
	bh=e0wtT19dYMDMyfhWCQLhYZ2yk+Cou298QlGCexKO5I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0tZd6WccPaVW++zghKZDjFicrwaN7D5bctWsJKfCqwv3uAuVo1dogD2iwJMsuB1m6/ee1igxnpt0bdloOwhCYHSRvD7xoMdjX9w2sC7rgee9jNcuDumXRj0UkOqhZTyUcAtsWwi0F0RaR+bou05AsA3b4o5bJwCsRxf39PCJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3kyoyA5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726768991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PEVVCV0eXxZeKN06cXXcnbtsFJaX89LX0ix5stsQGvA=;
	b=S3kyoyA5Vcp+wbHVNYBabiT3LqRitXvN78zIsjnHxPehvIppq6HVbL5FY+RHcYZjZXgkPS
	T8/5jkBknrlqRsMUvPyjsZq+F5H5z7j7PlharUTxu76ORNNZ3rNsC5xYZVhLpLnUIAR33K
	nLtwLXKtoEk3yhd5g52CCNJYxhOZ5Qs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-xUnFllUyNSqasKvXdEBnlw-1; Thu, 19 Sep 2024 14:03:10 -0400
X-MC-Unique: xUnFllUyNSqasKvXdEBnlw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a9cfe4442cso180885585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726768989; x=1727373789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEVVCV0eXxZeKN06cXXcnbtsFJaX89LX0ix5stsQGvA=;
        b=Sd5N6ht3I5hz2H8D+Nmo20ISlodAMnKQwt6efXNGTXsvkbs02ZJ15hlXlRk7dTOhOF
         Pj0dxCqV7Bhc7ykvXyuZY3n0RtUpBF7hQjgFMhTelX3z/Ndm6f9j4PF4p7cCHOoVu3ZV
         bZ44M4DRPwUpkFJGmN9dy8t6ScPyc6IT/2WPKdLxG2usPwo6BeFvdgP69ITnirMc5Xra
         ihD43Etj4Fip75VDEuV249fkaCIAH2KCnrQgRGis2+Z4kSGzkP39q7aV4Q8x6JoaV2Fn
         m/51SOc8hYZ3mxDQnyPtJnNY8GJm+F098eilJWlPJVkS0itpW1m8aCda/Zmn4huOTXZ2
         LGJg==
X-Forwarded-Encrypted: i=1; AJvYcCVHhFWsVDsYMDO/ppVMittlhmzbOwNrK7Y0SnejVJL/jwYP2DtiywxZmKjbRVdpxjlj+5aC6BYX4SPRcaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygpoNsSBF2GNdvytACAtEoffjGxDBZtXhByYON0VpgtOYP+q0p
	npwhp9E2/iTkjBp2opS16k1KYKac4m+O65uY/LRaQxiFly7xlQVCGnjfVywZy/MF/nUjDUcedBL
	BHcAizCIQJd/7iNH86rSkl+4cCtvV3HGV42eRJ8EbfZZYf/199uByfznVhEaazg==
X-Received: by 2002:a05:620a:24d4:b0:7a1:dff1:57ab with SMTP id af79cd13be357-7acb80ab1d4mr35905785a.23.1726768989425;
        Thu, 19 Sep 2024 11:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9RkMsz091nt5D4n5G79Ahwqx7Q5einp6ANgb25P9fWEAnjJsSSqRv5u4PVrzdbrAK6h6vXg==
X-Received: by 2002:a05:620a:24d4:b0:7a1:dff1:57ab with SMTP id af79cd13be357-7acb80ab1d4mr35902285a.23.1726768988985;
        Thu, 19 Sep 2024 11:03:08 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb07dfebasm96263485a.17.2024.09.19.11.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:03:08 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] pm: cpupower: Clean up bindings gitignore
Date: Thu, 19 Sep 2024 14:01:01 -0400
Message-ID: <20240919180102.20675-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Add SPDX identifier to the gitignore
* Remove the comment and .i file since it was removed in another patch
and therefore no longer needed.

This patch depends on Min-Hua Chen's 'pm: cpupower: rename
raw_pylibcpupower.i'

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tools/power/cpupower/bindings/python/.gitignore | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/power/cpupower/bindings/python/.gitignore b/tools/power/cpupower/bindings/python/.gitignore
index 5c9a1f0212dd..51cbb8799c44 100644
--- a/tools/power/cpupower/bindings/python/.gitignore
+++ b/tools/power/cpupower/bindings/python/.gitignore
@@ -1,8 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
 __pycache__/
 raw_pylibcpupower_wrap.c
 *.o
 *.so
 *.py
 !test_raw_pylibcpupower.py
-# git keeps ignoring this file, use git add -f raw_libcpupower.i
-!raw_pylibcpupower.i
-- 
2.46.0


