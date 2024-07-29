Return-Path: <linux-kernel+bounces-265054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C983393EBF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53A71B213E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C439180BF8;
	Mon, 29 Jul 2024 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="hTfn86/P"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990382499
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722224613; cv=none; b=ABseTOk1k0v9C7VJLp1f7YKvGuRer3iEiYJyV43svChNii3v8Cl/uq/Zrd2XCN+tEgzcPSBxKYKjH49UFIh6b3fsW7oByFK7Fy+as8q4Q5Ln99LNfQS4MHO7A1xWGcznOgvr781TgDwu1JWUpjX2kgNwNkIbpGB57OwtS1R3iKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722224613; c=relaxed/simple;
	bh=pEkbjZbID4Zq2j7DtzyhYW9aOgsLz5p9bS111yh9LLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qv88ae38/YlVWTUOKtdOZ0xS0PMdDmbhhoSaT6zom/vPm7aZfVecRbcgNQu8h/2cIekmQ0GIss0sk69xzfy2anUQTlDsndasiqSu9XNVKYWX2y5YWN+GepIihh7MCTLQnv8c2Qt6d7sOHUew8Tc/A48xFdtUqCIrfwECoBu9bGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=hTfn86/P; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so1557191a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1722224609; x=1722829409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=piHZCWX7KlSFhT01GfvCJrIPEKqLIYqxVjk4iuVXV5U=;
        b=hTfn86/PA0QWaTkiRxFUSsaeszf+W2+7W9PeLTA4ygzmdq7QlGSg6ry4zn1Ag9+gJP
         wLCKFFYNzdJ6W9+q/+jaSEnnRQogz3fCaBXssQvmvo2/gDn9KTJOwu+TDfJpieaiGlqP
         BcFyISfUgCtlgnAG9rYRjdd4/GJDMyRZ75zIcZRXrJGxMpqumsjKsVKYZpEHIay+H0Pa
         PxSzDRWLL2FlZ0a18+faHVR0ivaStRYKweju3F5LJWUgRWMVSx8GUgh4mxOpiS90Kzv6
         QFMAUpGy8r0iwEeEqfDRXIA/6jB397SUI7n6Fqb0mATk4grcw14SgMJZVhLOi/kPBq50
         LBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722224609; x=1722829409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piHZCWX7KlSFhT01GfvCJrIPEKqLIYqxVjk4iuVXV5U=;
        b=uL7y8Om5TYiy+BN+h/2iPbJOY9P6VIwXZohBJWp4Gq8cpUncFT2vvXMtZI9YWPlawF
         draf3ACZdqdxQSoRo8msJlJReCgCskNz2Tc60Eyk3XqhinGbq4FNeNwRuZa1mUjP1c6e
         a6S4ZzujcpNgqxa2BrSLMsNGAGhGsF4K98UE8lt6JgJOHqa9PzLiCFdSGGzkfQp4pcbC
         U+gALc8jJRv/cAaBDNaBCOWTZ3LqQDI8VQn1Avu5TjpW3868o1B1iAz9tKJdZrC1bggI
         Sckq/4tviYMKbB6Voj58lYggxOITtOvnexEcBkMSAgiIpD54MzYJUi0We+P5/2ROL2Hi
         vMcg==
X-Forwarded-Encrypted: i=1; AJvYcCVjdZDdo8CbVRE1drJUQHgAaZAvSDwli8YXDR59UNGzbG6FRggLo7KRuCC7Q96OCrYnSPlzHunU3bQLeiZIt3sTxzYr2e4H5+9+9+Dm
X-Gm-Message-State: AOJu0YzT98dh4uBzMoN3YPZOU+92iIow4Fsi0diWZXevjFgXky57BIgk
	/SmJpZAO7eX3mI2uk7SpCLrzLM9t2r2JCPwNi1RRWTXd9vKI6Y9k64d6IT6Q1hg=
X-Google-Smtp-Source: AGHT+IF2b1afqpkK6mLINTP2M8mfrCg5KFRVnTaJ9z97pZ/8UZWwnShZFRvCTESYMiewL0mt65dCww==
X-Received: by 2002:a17:902:e5d0:b0:1fd:9590:6550 with SMTP id d9443c01a7336-1ff0494bc45mr44139635ad.64.1722224609418;
        Sun, 28 Jul 2024 20:43:29 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1ac12sm71553295ad.186.2024.07.28.20.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 20:43:28 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: miklos@szeredi.hu,
	amir73il@gmail.com
Cc: linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] ovl: don't set the superblock's errseq_t manually
Date: Mon, 29 Jul 2024 11:43:24 +0800
Message-Id: <20240729034324.366148-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 5679897eb104 ("vfs: make sync_filesystem return errors from
->sync_fs"), the return value from sync_fs callback can be seen in
sync_filesystem(). Thus the errseq_set opreation can be removed here.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 fs/overlayfs/super.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 06a231970cb5..fe511192f83c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -202,15 +202,9 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	int ret;
 
 	ret = ovl_sync_status(ofs);
-	/*
-	 * We have to always set the err, because the return value isn't
-	 * checked in syncfs, and instead indirectly return an error via
-	 * the sb's writeback errseq, which VFS inspects after this call.
-	 */
-	if (ret < 0) {
-		errseq_set(&sb->s_wb_err, -EIO);
+
+	if (ret < 0)
 		return -EIO;
-	}
 
 	if (!ret)
 		return ret;
-- 
2.25.1


