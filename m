Return-Path: <linux-kernel+bounces-347334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDCF98D143
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09031C21D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F731E6DE5;
	Wed,  2 Oct 2024 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6YPkVcg"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614D195F3B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865058; cv=none; b=Jg9YWja8RxZCXQStHqHlje6WZoHgNRT+BMrpIDS5YR/zJry+d2JyCOeaUigeD7whW8FmvxA9WnijhCKiQz64A1C6pU2geIHHxFSXZ07+cjMK6rjOtnT0PQRFfrczWIKvXis+fYrLHgkODXxySB/a7zXJG1a9MWlqnRShhO/twQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865058; c=relaxed/simple;
	bh=O2zyplXngg0UgckdTl8pf0GOLugFqd2YHMP6hf8uAQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hduG/u/wrtlHodYZ26lMtgsGXoESbCUEI8Pltip8HKEzhYZyNfxi8r95eOs64UPQsUlmezvq33Z54dN1y3qz4p8AJJUBaX/r+Wht9fUxS1IfcIpLBhnDhjF0OxKxIlLUKDtrfFT/8l55UR0/N2IyNFFVbukQmsOH2HB+b2WgLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6YPkVcg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso4372775e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 03:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727865055; x=1728469855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJODD5WTpv2RP8sYp+BdJNbD+0oYTS5tgAizDuA5Mes=;
        b=J6YPkVcg6cDRBE6/UOkNncAnPqTxFss9MQJLUOcYvBouXpS1grNjEzkpCDv9STSeol
         xyymT3CK6dUIYl/48wxGA/XSjk74GJj1KkLQM9HW5TNKXmaxhzasik4OmlFyXKP/isq7
         4wHChYaq3awT44+HM4CKY+cAFQgExCvV/mqwVUXNGMSJSmYbNgAa4SZdbSgYsHQOTVBz
         I05nJAiLJI8XxHKHznnWce6XmHUSPucfXcdVgLLs5WR9kqkJGpQ7nuUCpBNywG46eU1o
         7gLrPMhRDYhOyLTbkiK9E1k24dOX+fjV0+zW0yK2IkS3ZwsRH97EIX+XDw+6ZBQYqQN+
         E1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727865055; x=1728469855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJODD5WTpv2RP8sYp+BdJNbD+0oYTS5tgAizDuA5Mes=;
        b=Xlp4utaHeVq2W6wZMCoHYdBFzUcnpwsm8K0u1m2zS013BnhmCNtTDO6v7VC48brfO7
         2hPIpJBHn4YBHM8MZcz+HGvrF/23cJhcRCGpDVeZ2Y2GDdCjC0SEj72JRwYOtGEtbaHi
         WoVmbRN4aIG7ueCPYz2y/Yi5XGzZA/PwTgU69uaarFv/8NVI35N0BpMDqlKcL+WqYMeq
         BxSWkHn++GjpW3vz4YEwoVDyZppHXdBbtLmjhrDnTVGoMO9q8ajxorYXX3JlqdBZMoFD
         qsoCsm6SbV1H+RU58qvGiMm2jX5MC2KjlsrhQQkc+dsm6W4ltidBGAVIHnp3tkigSgED
         VCEQ==
X-Gm-Message-State: AOJu0YyqSJo8HRljCPwhoq3XW6vfuNov7SJrf1oTT75utSUHTY6HNDup
	YOJFG53QtP2/jPEGYqXYO0Ii7SkwG9Ik+CVOgJjZwDn42n06Leyw
X-Google-Smtp-Source: AGHT+IGj0RETjXWQbwpCEil2rn5jWQLEnh4+QfeTasijOsh5mUP4sPsaHb5Ff0dBgetuXHmQBUnH4A==
X-Received: by 2002:a05:600c:19d4:b0:42c:ae1d:ea4b with SMTP id 5b1f17b1804b1-42f7137c107mr40104025e9.13.1727865054677;
        Wed, 02 Oct 2024 03:30:54 -0700 (PDT)
Received: from cat.mynet ([2a06:c701:7630:f00:5583:746b:325e:d69d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eacba2sm14917015e9.14.2024.10.02.03.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:30:54 -0700 (PDT)
From: Tamir Hadash <udbe3333@gmail.com>
To: dhowells@redhat.com,
	brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	udbe3333@gmail.com
Subject: [PATCH] mm: Rename folioq_count to folioq_full in documentation to match function
Date: Wed,  2 Oct 2024 13:30:46 +0300
Message-ID: <20241002103046.24847-1-udbe3333@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the documentation to correctly reflect the function names in the memory management code.

Previously, both the folioq_count and folioq_full functions had documentation incorrectly referring to folioq_count. This caused confusion and warnings when building the Linux kernel's HTML documentation.

The documentation for folioq_full has been renamed to match the correct function name, resolving these issues and improving consistency between the function definitions and their respective documentation.

Signed-off-by: Tamir Hadash <udbe3333@gmail.com>
---
 include/linux/folio_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
index af871405ae55..3abe614ef5f0 100644
--- a/include/linux/folio_queue.h
+++ b/include/linux/folio_queue.h
@@ -81,7 +81,7 @@ static inline unsigned int folioq_count(struct folio_queue *folioq)
 }
 
 /**
- * folioq_count: Query if a folio queue segment is full
+ * folioq_full: Query if a folio queue segment is full
  * @folioq: The segment to query
  *
  * Query if a folio queue segment is fully occupied.  Note that this does not
-- 
2.46.2


