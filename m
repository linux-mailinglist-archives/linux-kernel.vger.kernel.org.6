Return-Path: <linux-kernel+bounces-415594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477A9D38B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74E61F24135
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6618EFC1;
	Wed, 20 Nov 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZP9G+wj"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C93199FB2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099858; cv=none; b=At6LBGQNlOOszqzP0lxL/kL/iizlR98CXhX7Lw/14Xu7GYTS9FffuQcVfEJUIFax1i8LED3aKoAuJqzXtH9pn2jFf0c4oT4/IfsY5Wd0PMqeVSeUhDxkJOmtG7zRU5r+Wrh5dnP/ukyQUgQX7faKcYQFwvXJsR6xpIt0UNUhDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099858; c=relaxed/simple;
	bh=Zy3W6yR8tuXi6Zd1AN2hvbo07g8dFqVeyyRaTJidvgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uo4wmw8u6NDJG5seAUBphPSn0hiDVLiVivr/E9jPtNopzulCpEaXcOKafkcd43D3r2fiQes8Z/0CGUV+jjrKTqGCxOO+O8p/i2XElqtA2UBzJSyetGFQpsxPWvz82AGZAkT+GrLxzgGnztjkV5yErwkMpbjSOYO/ikSJj0o+WSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZP9G+wj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso2891873b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732099856; x=1732704656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eylt6yQGAoNtadDrsoB7tHjzTJS7rDY6+L+1xqCK+nQ=;
        b=EZP9G+wj+Dr+7+AIVkFQGRuchNAtHwCQkxI/nsOTOm1ZPHP9dGHNKlcjaXHP6ADBmi
         otDL/9VGRLMMrEbS8UVj7qj+niVorkyrChG7V9uyXfJW00gXTkeDg57UON1V7OuADTa9
         9GSzCSIOBQ4CxxMPe9+GSqxh777pQiUmzhJM9rB4Qzu43r6zFO1Mxytkzn0YevzJbbrs
         0S9WTj76qy7/BcHutU7fgwAjCPhORRJG7ntypBZsjLg/dk3m88eNuTof25lf/CZCC485
         zZL0GFPByTXo7fFPE9K+2Ntp5+M4Om9NbOSrTa9s831q/rVC6ham/+ZvIjqlQAyjaifj
         042A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099856; x=1732704656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eylt6yQGAoNtadDrsoB7tHjzTJS7rDY6+L+1xqCK+nQ=;
        b=CvlWXH3/H1Sz+EOno7cd1x5FkCUlzfTTeCReY4zj35zq7ziDE6QApWTn6oT134r/+S
         2jQUfRQWkoSBXTTk56mOQ2GS/IEa84Slp29TTgg/7RwFULsBgNxVcQ3dPZG9kRo29QZs
         kskl1/uc7jYpc6mKxewHcFe8zscSq4aVTC80CgGhoDPc82Edj6kB6vWyBT3amkcwIzfx
         FRqwxspg5Nx11jONLFrT/5BPk19FUOpkUt0EGNslN3b7GAq4LVqOMmNJkfwfQzlnzQl/
         EbsPp9IlGsBxzwcGmj/W3s/bjArsTiZ8f/W2mjryUFmi2tYHrVbXRDcAUJrT847P/REz
         tXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx3UdLjK7k2ky92aVK3n7w5IvwDDLC1I+zi67Vs4XwNkQVDhF27Gcl/hoIyp+t9puMKUQL3GuWEmo97j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW4KYzK/J0a/AsK96l/KXPeandpcjoJ5KS0ZMnsB8JmLTzDjK2
	70AAA5YmTIerkEHvCpFpfGom0MDYHNB8+hlmoB6NNYzwLVISyi2+aR8IOQSC
X-Google-Smtp-Source: AGHT+IFHaN1umXbYd1N0+ik9zcJpDt6zs4w496D6NJqMK5RA4ZkG/NFXYt62lo/rx5lm3JI0W+52MQ==
X-Received: by 2002:a17:90b:1e42:b0:2ea:5fed:4a2e with SMTP id 98e67ed59e1d1-2eaca6d6d19mr2250806a91.6.1732099856011;
        Wed, 20 Nov 2024 02:50:56 -0800 (PST)
Received: from newslab-Z390-AORUS-ELITE.. (pc51.csie.ntu.edu.tw. [140.112.31.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead0311394sm1002860a91.9.2024.11.20.02.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 02:50:55 -0800 (PST)
From: Chin Yik Ming <yikming2222@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chin Yik Ming <yikming2222@gmail.com>
Subject: [PATCH] mm/memory: Fix a comment typo in lock_mm_and_find_vma()
Date: Wed, 20 Nov 2024 18:50:41 +0800
Message-Id: <20241120105041.2394283-1-yikming2222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/equivalend/equivalent

Signed-off-by: Chin Yik Ming <yikming2222@gmail.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index bdf77a3ec47b..9be3183ca8ee 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6150,7 +6150,7 @@ static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, struct pt_r
 /*
  * Helper for page fault handling.
  *
- * This is kind of equivalend to "mmap_read_lock()" followed
+ * This is kind of equivalent to "mmap_read_lock()" followed
  * by "find_extend_vma()", except it's a lot more careful about
  * the locking (and will drop the lock on failure).
  *
-- 
2.34.1


