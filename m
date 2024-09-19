Return-Path: <linux-kernel+bounces-333803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68097CE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2C51F23C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F03D136E2E;
	Thu, 19 Sep 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt1TF/pW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AFF131BDF
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775824; cv=none; b=luUX6VopLXkWBYalRkMvwLUM8thm87w8AdRmWaBk03oTwEbLJJ8RPDDJ+KE2a9fq2ox83MwaGB3Jza/bAjxsfxfWGQthQ0DnXKHXtg8TcXBb5cbi+xwJwHg/BVxMTfmzrSFaPagKay0sIDElSwSVXgK5s4F0B5MZb4E5udvC+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775824; c=relaxed/simple;
	bh=oZZ2sP1CndS0ambxtt6hVsiy5Jtev2nB0LICcnbSO34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4Gb9EJWd7gku9TCpOhm3VWTitE6B3go2ALDWqyfAXVhCG5JDYoKX8fhoHcfXOwR6+f+khqEJ9sMu/2z4yybDpW3BMAHcpDBaidop3drrI/w+5nMIgUMjUAI+OVCtRVA8bvQObfWR8Q0KLRHMTu85TXoLflXa7efMPJyUVvsfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bt1TF/pW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726775821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IMRW3GhfouWxyFM1qW0RxKwI/EeZ/6kEKpBumcRNhfM=;
	b=bt1TF/pWEqMzmMJHs3llqPThM2Q0rUPLDivdOo6EAapvrOURAUbvhmAL93FcJj62GVK5gT
	B/9xwiriMqLdms14VS8+/32ROouyvb8F++P3siTm8n5repHLaMuTEmwwaPuHxkSXZxu69X
	nxpMatTEIj5TYEU2lT2YB6ozyJUpDAU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-mkGG927XMn2swUfmwNLpwg-1; Thu, 19 Sep 2024 15:57:00 -0400
X-MC-Unique: mkGG927XMn2swUfmwNLpwg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2070daaf8f1so17469565ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726775819; x=1727380619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMRW3GhfouWxyFM1qW0RxKwI/EeZ/6kEKpBumcRNhfM=;
        b=OsfzTZ9hWP1rJ5SGVLwwv6g1F83oWWOzpBjdwVm6vlY2+LKEAl/XClqqmPB5obxq3O
         jGnaniEs6yKdLIObEEi7yyWvNzri0PRoV0RE5VoeAJMWiQoOqVjhuBtj3ko/KmNaXxNP
         EDCebLvRAHajGpGljCg5z/PnWanZtwUR8BNTvylwhcN7FWBEHejgIyzLUESFXh34uPwV
         Cyj3+zVJbMidY9Na/rAE72z2fC/3Fn629ct7gYhK18+R7WJCrloWTbj2qpzKDa39Gx7v
         Aqov0T3k5S25/nZ8F4an1q4tX0PI4eWbxSGFeeJC31XnoDaRupwBkNtlYMdGWCgDP+W9
         aD4g==
X-Forwarded-Encrypted: i=1; AJvYcCWt/Ek+1+0CSkqQe8QzRb0AnkTlh7+9mPwQMPdynzETdtmGgNlq5KYwHJC6bfazgkiOGqaSSjLwsEhKoRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPKTC0PJLA/ho0EAOfDFc42itsl+jba12t5dqcWQUcIGKid1o
	Qr/E8ddywZsUKgBIIZ9GKFScWbzCcwaDVscv0PSaZshK5m8mC+Fv+3kFG5ekMst2ZjwthkUO5ig
	Ow87c5pQKVMW4u2+yoHN2b0Z1azb0h0afheLwgoqzbS9n2kANfy5ObCB5Ci7GtQ==
X-Received: by 2002:a17:903:2444:b0:202:2f0:3bb2 with SMTP id d9443c01a7336-208d843e50emr4377835ad.60.1726775819019;
        Thu, 19 Sep 2024 12:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGr7GInwwPBXgtjEdeapMFLPjrpXj+uov2FO6b3wLt5XLcSg1apNPo5wJne5Z+DckO6Lk3JQ==
X-Received: by 2002:a17:903:2444:b0:202:2f0:3bb2 with SMTP id d9443c01a7336-208d843e50emr4377675ad.60.1726775818688;
        Thu, 19 Sep 2024 12:56:58 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079470f1dcsm83787975ad.237.2024.09.19.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 12:56:58 -0700 (PDT)
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
Subject: [PATCH v2] pm: cpupower: Clean up bindings gitignore
Date: Thu, 19 Sep 2024 15:56:24 -0400
Message-ID: <20240919195626.26833-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPDX identifier to the gitignore. Remove the comment and .i file
since the file it references was removed in another patch. This patch
depends on Min-Hua Chen's 'pm: cpupower: rename raw_pylibcpupower.i'.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v2:
	- Rewrote commit description to use the paragraph format.

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


