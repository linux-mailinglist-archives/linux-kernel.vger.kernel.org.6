Return-Path: <linux-kernel+bounces-399401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AD69BFE76
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDD51F22514
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C114194A70;
	Thu,  7 Nov 2024 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN4QyVzz"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3032B9DD;
	Thu,  7 Nov 2024 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961047; cv=none; b=BoV0hopnj7TT5uSSiZ5mkJHNSfjjF2nLbGzu56pSHc2keYxfu1d1zzKr0dsE2+zGKgrhSYVeZ3IzFtz2UJ1I2OOSmEQBC6RHaabKMSqMlkaXkiGwKwcdMSCXH20fPD4XcZ1t5OHgj6h62A5Nl5kOQe3h8+ZrB9Jwq5Nv5a/rjyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961047; c=relaxed/simple;
	bh=c0xw6QFHGeT5H5b7lLLmPn/NEJNuTUlU1VlFcjgsflU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UWHSfXWMiTb0lhpKPlxtxFIBEuTdOOQlTo2Qvs21Ygenda+Ocqkd5L4PIS4XuByeSsc38GllclggGXsDf7L/yUU+5kGSY1/DCKDMnvNqM9ezbKKdIOXO/8LKnnGqEE/0RBU5eikY6CgBpmSOdR74n/eme1C7VF2azOEYuI7hE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN4QyVzz; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so540264a12.2;
        Wed, 06 Nov 2024 22:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730961045; x=1731565845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NhAeNBnk5UCCI+1vhep/xtCYN3LRsWKDceL6il0Fnk4=;
        b=dN4QyVzz8ZZy3MOGc2M5aItWeKj7nscGg6jiiNCWaD1uh2rLTKcRDAHLCfURQ57qc3
         9hV/TZV5D80BhtK8P7jvQEVzY3OngMbnZHNPrRnkOCJnz15ElmLMlthxAWfiQVzcBDsw
         BuTXP0A9tJZK3kZ6aFMe6jVM9I6FvduX4AZwoRehqSN7A/JKCbAO7mFUNLEyoM2zSsh8
         05JBLEUp2sMOL3FB8jctc8b+S9d4rzxiWcsLUP2lkxybrPnNlQ8wNa27cJdWwXEnyD78
         VTRY+xDeI/wxRjNQA3FvXj2M8WtvpYHXm/tF1CYnMQ+ZTmfw1xnfDNegWkmw33bV8LZF
         BjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730961045; x=1731565845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhAeNBnk5UCCI+1vhep/xtCYN3LRsWKDceL6il0Fnk4=;
        b=Xj9MWzr+DivRU5dTxwaZGD02urLhj8QVs0Nss7/RjPe+XzkjkescWnuTyhnEpv9a4i
         6p4BlDQaeAni8mqr5Oe3qj2cS9v5+C+xuxHiix98ofTD3/BQbL+n+tEvnLtnfFLptmaF
         w5KOVbbjxEHU/krwrIyNq+7YzaaOenfpm4tNVIVeOrpmQfYQjSLR3uz7RGxfgrJvm5vh
         GMtzJ+qPwPkWlE4tcGAU7xlBKwoZ5+2w6tEzbfyiACGUP2Jt3cSZGcDrvM0Fjk6xEtpp
         sPh+DWoBm1foEnLBFAQjULS/42eDqEFAKFNmY0wRek533aAcMu0qbKlLZYuhTp5u3iOs
         if6g==
X-Forwarded-Encrypted: i=1; AJvYcCUzqCb/oTgoe4Fde4HA7vc3g29gZCgepS6M53JvNdpTbug/tpoCCvHAS/PWK2wY2LlI9QcBvF13LH1LJu+u@vger.kernel.org, AJvYcCXlytKd+uMwzQv08g214rAa/Q3L/GTejlwSpJ1brAuqEcCLakk773f/rUOmRQC14beVGsHLO6asJQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZcp00OUkGUKfUgZ40J19TzrH3vXgXWAoAlDeSv4r/vSYzFUR
	bORaADQg47OxBPnUFP2x0dvGQpkMvJlPcX7vnQVpW93jQGkDz7yJ
X-Google-Smtp-Source: AGHT+IG1VbB/6+p3Irp7fXFoIsnaAVKL1mLw0MG7955Bw8iIVmEoZqxiGeSAeKqdLDVzoK39Ar+Xwg==
X-Received: by 2002:a05:6a21:170f:b0:1cf:3677:1c4a with SMTP id adf61e73a8af0-1d9a83d0a71mr59470398637.16.1730961045398;
        Wed, 06 Nov 2024 22:30:45 -0800 (PST)
Received: from 1337.tail8aa098.ts.net (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f8f4e2sm725206a91.26.2024.11.06.22.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 22:30:45 -0800 (PST)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH 1/2] Documentation/mm: Fix spelling in hwpoison.rst
Date: Wed,  6 Nov 2024 23:30:41 -0700
Message-Id: <20241107063042.106228-1-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling of "focusses" to "focuses" to follow standard English usage.

Checkpatch.pl reported this issue.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 Documentation/mm/hwpoison.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
index 483b72aa7c11..dd02fae484dc 100644
--- a/Documentation/mm/hwpoison.rst
+++ b/Documentation/mm/hwpoison.rst
@@ -17,7 +17,7 @@ To quote the overview comment::
 	hardware as being corrupted usually due to a 2bit ECC memory or cache
 	failure.
 
-	This focusses on pages detected as corrupted in the background.
+	This focuses on pages detected as corrupted in the background.
 	When the current CPU tries to consume corruption the currently
 	running process can just be killed directly instead. This implies
 	that if the error cannot be handled for some reason it's safe to
-- 
2.34.1


