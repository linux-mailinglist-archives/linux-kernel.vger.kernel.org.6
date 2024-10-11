Return-Path: <linux-kernel+bounces-361781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A43399ACEC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E50A1F221B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8B01D0F66;
	Fri, 11 Oct 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXAWbZD5"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5891D0F41
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675768; cv=none; b=u+jzybAgy4QuvBY/BwVAml+5Pd6WPumdXnfspbAGSEtmXF1jEHt8HTMaLPKoa0m5N2+YydtdDyXR9QoW8I5qdvy6GQLGOcNvYm64NxOVKux26E5Z1w9Dg2w9lPPYESlvxGl8u20utd6MI+XdLPpBnIk6A34fTrCT+83kqZIfP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675768; c=relaxed/simple;
	bh=85s3yh7C9E4AhHzzxYnfMTj0KjOdGEaz607yZpREXA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SwFKJ74zDqThr0OxNQoOH0zTiefQYsbvog9PiUjFGl7NO2KV20eDISka6ijTIyEk33uUCf9XMwt2oU4FzGBvrdC2t2crVtoLqUIha5JkF8DsYmSJBl7EQ4SNrPKpGznn40/ZQFyFqOTxs707DDe2p7+lNBfUx5Nnm9+nYV02E6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pXAWbZD5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d375ecc5eso1590718f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675765; x=1729280565; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZGq6pr3z7F64KN+AVciDpV1SQYlsTgST6RCikrEM7Q=;
        b=pXAWbZD5Zy9AQvz0OWfCrOA1Pg70LfNpIVG7SlrcsuIvfzticU5ql4yJltui17mLLS
         5lHieZNmU0iuuJEuLJeM8u6KG7dIpr7V8ZcFkgGQr9oWlRxllbZCAggBatHSGUdtk1vU
         TWrAI7/lwyIg0t3FbdB44O7bJP3+tn6X3FY09ltK7qr6HnVGpvv6FbGs5Lk7pt4nWWup
         saH9hdmzYfXfgng6Xd36ungNq8vOLLmN+2s7dJ4MKm6podLGbzBULHKIxrAKUdSq1y9V
         2XlhE485zi4afEXM3yThjyoruebi2R9LCVyBIqOPXeUcN2CZB1AN1frUKepexwBz8SN0
         EvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675765; x=1729280565;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZGq6pr3z7F64KN+AVciDpV1SQYlsTgST6RCikrEM7Q=;
        b=IoyILeJAeUg1h1Zt+X6/DzN+LoEdOPkbUKGKArnfpzScUbbu8nst3ODZn95asKSHkt
         ojDLezWNfAAbQBsRFgcMJqne7Ixnyrap/z+R8eNp92S3KOqwHat8W643btLUpA+Ws4By
         pjH7dMq7AiyH1hh7rvGpYdj5iHBnmbWFewtPEhM2G5PMTi6GevTND4KxYCrCrDf5HZnx
         anUp3X/GTebz2ByPFGzYGalWGv8zmpPzFZhYLpulSeE+tUGm3KbPAnHRXGU3gB6rfst2
         UJXcy9BJPlZfRePVxyD7uj216jtOuKLGU8Q40grrS3/JgarMiur55cCFGTZhyUdTWVfG
         Rhrg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Mb4BvTfJhIkedqTqb5qC3Jf/pT9xeG29JNWj1WQZNL2Uuxdo/l1RitB9SMMJJd4/VKhsOcll1cE5kPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhr2Z8UTepzcqDF30wwb5O6PPDrWnqcqZ8Hq9lXbgcI37hCvf0
	Bry07fsg/yRrgXfjLf5vhbDOSvYKsPXNu6xJ7VrJESOeV5MXjxIK4ZpGvWWbJvI=
X-Google-Smtp-Source: AGHT+IFCNrJOiSqG/e7LBD2Xkmk4NY0UPLW2yMbv5jbu0JLA6sQvg79ITZPssZ7JeTNGLfi8yMk+Pg==
X-Received: by 2002:adf:f2cc:0:b0:37d:4517:acbb with SMTP id ffacd0b85a97d-37d551d5265mr2770332f8f.17.1728675765355;
        Fri, 11 Oct 2024 12:42:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd555sm4585466f8f.28.2024.10.11.12.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:42:44 -0700 (PDT)
Date: Fri, 11 Oct 2024 22:42:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] afs: Cleanup on error in afs_proc_addr_prefs_write()
Message-ID: <12f261b0-c44b-49ac-a5a1-9a2a18f987f4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call kfree(preflist) and drop the inode lock before returning the error
code.

Fixes: f94f70d39cc2 ("afs: Provide a way to configure address priorities")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/afs/addr_prefs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/afs/addr_prefs.c b/fs/afs/addr_prefs.c
index a189ff8a5034..c0384201b8fe 100644
--- a/fs/afs/addr_prefs.c
+++ b/fs/afs/addr_prefs.c
@@ -413,8 +413,10 @@ int afs_proc_addr_prefs_write(struct file *file, char *buf, size_t size)
 
 	do {
 		argc = afs_split_string(&buf, argv, ARRAY_SIZE(argv));
-		if (argc < 0)
-			return argc;
+		if (argc < 0) {
+			ret = argc;
+			goto done;
+		}
 		if (argc < 2)
 			goto inval;
 
-- 
2.45.2


