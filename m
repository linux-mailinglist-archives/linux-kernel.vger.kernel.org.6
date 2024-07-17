Return-Path: <linux-kernel+bounces-255396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A149934051
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87641F23DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7DD180A88;
	Wed, 17 Jul 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="fkDlNHbM"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584921D52B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233255; cv=none; b=USQxQPH0Q/5L7hNbM5XmWqINdNcBFgxrR+TEWMW3Tf5Ktnxmbi3f351R8+U5tRmljCpz61larEriPqL4LsRnEaxOaQL8Mq6CLP4n0ZY+0q7Uw0QNh237y+4xReK74QSnhXGrZXj1Yc7rM414LqDQwv/LV+vTgi+2rmgAmnbznoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233255; c=relaxed/simple;
	bh=C5sdX/k3C2kZi34tAdV5lN3RuZJbLfL/IMOD+weZPQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTOhBv97qn3OFeDjKHY0Gu+A/PMaPtZxEbQ0ZJocyy6YdNfwMZHH7b2/A65lcwB2wHh1l5jpGR9aqWQbugsZJjuH9yyzRvJAsYkbXz4LDfNuPP7ahO9+xWcqQ5oK1tW/rqD6EIZAwmyl7ZF1Wqkb+JZAZR8Kwg5FEb8QvzlHJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=fkDlNHbM; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b797fb1c4aso3220766d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1721233253; x=1721838053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HT+ibClvaBMM8FBjnsk4+k+U8sPfuRLXWRlww5Hnz3A=;
        b=fkDlNHbMmrctjT3T/7Ve2yKg761Exe2UxdSnWD0Fj3Wo3U+LICApZ6dfoWkmNXqjLf
         KhNOtKdoFICaeGgMJaoqq7LTJwTjdCXAYIfzR0crmKomFSUgOQUiG5eKYM7P6svg1zWL
         6wvsOSAO5FYQkB6e0IJ2PtgM/cksQIDEwkQzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233253; x=1721838053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HT+ibClvaBMM8FBjnsk4+k+U8sPfuRLXWRlww5Hnz3A=;
        b=EJf6lA5wjmyltLnGvySkAQzkwkfPJ5bfz651Lf4z5QPvcBE4I0AB5hnLhqkBhZsYH8
         SP3d/MZebLIjwk5nqwyNTHB9N6VziXU/ngloW0nawjORY7UAT5GZyBCgqP207w81ekTb
         Hzk5EcFG4aDXcbbXB2j/DHTivVsfHYImtweiwS7JyCTO/+Jyf2t7kIV7zCSgOIafOMQ5
         nPHUVfvB4a+ZRnLtTufEyueI72asH6m3aiPK2xaT5cZ4hwzmP/YRu3Kh44I4iKmdOko7
         k1oV+MCPLs1wUzL9Gm6lTffXRKjlFYfqkFz9bOHAVU+XBlfRbJ85olw8QoYPwHRrf3bc
         2wLg==
X-Gm-Message-State: AOJu0Yy5+JDz/UTSFJdjwblUGro2Z84p4ODS2glK/0xKYoH+jPV+KfZv
	4xftEdD0+u/pnbFvIoKslNOY2k3osFwKVAuWnoYpgLTpIsk54UMVg7mmyI1Lxv8lLtxoL2k+mvs
	=
X-Google-Smtp-Source: AGHT+IFBbVMpITZG3rIgjAKA5FrcIzG/zJJKAvLXCRGAdZsSayrfao9xnI+6329HcNeY/O7+CImzQA==
X-Received: by 2002:ad4:4eed:0:b0:6b4:fdfd:fece with SMTP id 6a1803df08f44-6b78e2d8b38mr28886346d6.44.1721233252931;
        Wed, 17 Jul 2024 09:20:52 -0700 (PDT)
Received: from rossla-pc.eng.citrite.net ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b76195027asm43636866d6.1.2024.07.17.09.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:20:52 -0700 (PDT)
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alain Knaff <alain@knaff.lu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] decompress_bunzip2: Fix rare decompression failure
Date: Wed, 17 Jul 2024 17:20:16 +0100
Message-ID: <20240717162016.1514077-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The decompression code parses a huffman tree and counts the number of
symbols for a given bit length. In rare cases, there may be >= 256
symbols with a given bit length, causing the unsigned char to overflow.
This causes a decompression failure later when the code tries and fails
to find the bit length for a given symbol.

Since the maximum number of symbols is 258, use unsigned short instead.

Fixes: bc22c17e12c1 ("bzip2/lzma: library support for gzip, bzip2 and lzma decompression")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 lib/decompress_bunzip2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/decompress_bunzip2.c b/lib/decompress_bunzip2.c
index 3518e7394eca..ca736166f100 100644
--- a/lib/decompress_bunzip2.c
+++ b/lib/decompress_bunzip2.c
@@ -232,7 +232,8 @@ static int INIT get_next_block(struct bunzip_data *bd)
 	   RUNB) */
 	symCount = symTotal+2;
 	for (j = 0; j < groupCount; j++) {
-		unsigned char length[MAX_SYMBOLS], temp[MAX_HUFCODE_BITS+1];
+		unsigned char length[MAX_SYMBOLS];
+		unsigned short temp[MAX_HUFCODE_BITS+1];
 		int	minLen,	maxLen, pp;
 		/* Read Huffman code lengths for each symbol.  They're
 		   stored in a way similar to mtf; record a starting
-- 
2.45.2


