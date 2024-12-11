Return-Path: <linux-kernel+bounces-441215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477E9ECB34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A67286943
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F2238E31;
	Wed, 11 Dec 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWE/rG4q"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F951238E0C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916625; cv=none; b=OTPMvVwtIxVXqoH8Jbxhc9LkqqcYJoNct+R7j8F8n4z+9m7ClANRhcGarh9vTC6L9ZbHYw2dQJl4sVO0pF3/DKRlB7wm10+D5ikK2JA9ywCCRAxYPvcW5CTBTQsM0VpynGWtnegaKZ+o7MkMCIq5tTvHJKOCElK4ReuGbH0rpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916625; c=relaxed/simple;
	bh=1cHQVx6NpxcJTfQGMBhXSq7f7GN9m3hHqgEk1+dTsuA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GlEg1icBCnWwdIFDX5XNpuXD4ODCjD+vrJHlRnIx3BhhGqRa/008TPz0zxzKPkIQZFXGadX7C2GbbmLzyIuT9vODcX8sdsjcBpmr7mmKuZ7SaPxg5/ny8wtI51kp6ysZFh0Op2/CgZvBhr6poSkR4l01ylmbH2HdM+9syHeypWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWE/rG4q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fd51285746so2187941a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916623; x=1734521423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm7UnlOycLo4uIYTULhRqFLg4FzZhs1Si7gj+QUy0Ok=;
        b=JWE/rG4qUgs272QBpdO/AGVAo0TGnNEnnNgFr6DRHvRY1UckzWEFwOsP/EH6xpVH6l
         /pKhm/0d0siFPC3lnvMxVfFWtdTlvUl9hmHk8ZqkwGu40aofVyrbNkQ/FrInvYu0bzgd
         WwKZk5d2fYUbukPR1tV4gPZdYideLIxpVH8yBCi6OeRi2hNSEDE929E2Q9QfSC2NAn5D
         HmJS2XEj6WZVt+d/Oifspah8P7V6rkazEJ0tFdPD8CtlGvNWZiyvonJ/bzm/8kPmmCKJ
         APmPwr1SL/b2r375YS8CYIx0pNF4Q9Mz/6of8OqOZuxZC1jbh+OkpJMgHvR5EXlPIkQf
         k9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916623; x=1734521423;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rm7UnlOycLo4uIYTULhRqFLg4FzZhs1Si7gj+QUy0Ok=;
        b=cqjgn9mXPEYPSLHltOfhqjXbL8VfPivG+qEWrSKnJ9tDf/Nd028f2CiXmDmJMt25Hm
         7I2XZrVpFbEOC9gu3APaJT7CBayPytXR/WdlaBPE1q8JkDkExAwSB1veD7QRe3ETm1eQ
         +mhcYeAoY4zmx0+4z1SuqGe0zvee9fUUP5+pxp9dwoTib8kzdqvc3G8q58QogWErHYPt
         yUvPqX11UyujQILihoVw+fXDz5Qrv5I4VmMYrM2C1pi+LvXCBwIW/rNBH5OpRjeN634i
         PAv/3vLgISX1Q/r8d/j6h3JRlMZaVNwj6C1zTTyouf/2rqeEtMxwOCqI8Y/wi9tvsall
         OH1g==
X-Gm-Message-State: AOJu0YzQtS7W9ckSccVrUXNr0ub7EXchzmEfK2cKkxK89BGZL8vAAznx
	EnlaPRHiUFaVvrMRMeRrjkxHfj7gh25ZaudvnAnGdCdaNsku3KoZfbUifA==
X-Gm-Gg: ASbGncsHFoviATq08SW6PC18zOlCQCuyoJ7XGJpR8JWCo7ek/mhiADIytlY67JsFiXE
	24wt7zz/dVrrPUx+p3ou1NSLjA8s19qmAGwWzMiml0HUkfJ0dMb3ZfDerD1wyQHuW+GAqPi2enP
	aUyGCnVvLKGRicLblihqf36UiO8D0R/vnu+rQ+foT8+vkKleZ1RXCh0MXOPtAnipPEY5NG07Dgg
	T6yY9ucJIg3KPq9d5SSMIgDHB9uI0iX1X1MMtXCnYfbfy/y8c4FYmQ0VaGoJvIiJOaCPwdYCxH1
	Wo2NQZTpOAJsUgBRHnX8/pfJtlGZj4uZ
X-Google-Smtp-Source: AGHT+IGEsKxQczSh7jdsp+3W7IskBTlm58SJjN6TpwoCSEUwTKO4h29XuhzCjlnndbaEa6Mx2SO5qA==
X-Received: by 2002:a17:90b:1c08:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-2f128032323mr3603639a91.27.1733916623225;
        Wed, 11 Dec 2024 03:30:23 -0800 (PST)
Received: from localhost (i114-186-166-114.s41.a014.ap.plala.or.jp. [114.186.166.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef7d302606sm8101238a91.18.2024.12.11.03.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:30:22 -0800 (PST)
Date: Wed, 11 Dec 2024 20:30:19 +0900 (JST)
Message-Id: <20241211.203019.1906828475608694378.konishi.ryusuke@gmail.com>
To: syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_btree_propagate (2)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
In-Reply-To: <670ea678.050a0220.d5849.000b.GAE@google.com>
References: <670ea678.050a0220.d5849.000b.GAE@google.com>
X-Mailer: Mew version 6.8 on Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Check if the buffer is referenced before clearing the page/folio state,
and skip the clear if it is.

#syz test

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 10def4b55995..ad99497f90af 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -392,6 +392,11 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
 /**
  * nilfs_clear_folio_dirty - discard dirty folio
  * @folio: dirty folio that will be discarded
+ *
+ * nilfs_clear_folio_dirty() clears working states including dirty state for
+ * the folio and its buffers.  If the folio has buffers, clear only if it is
+ * confirmed that none of the buffer heads are busy (none have valid
+ * references and none are locked).
  */
 void nilfs_clear_folio_dirty(struct folio *folio)
 {
@@ -399,10 +404,6 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 
 	BUG_ON(!folio_test_locked(folio));
 
-	folio_clear_uptodate(folio);
-	folio_clear_mappedtodisk(folio);
-	folio_clear_checked(folio);
-
 	head = folio_buffers(folio);
 	if (head) {
 		const unsigned long clear_bits =
@@ -410,6 +411,25 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
 			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
 			 BIT(BH_Delay));
+		bool busy, invalidated = false;
+
+recheck_buffers:
+		busy = false;
+		bh = head;
+		do {
+			if (atomic_read(&bh->b_count) | buffer_locked(bh)) {
+				busy = true;
+				break;
+			}
+		} while (bh = bh->b_this_page, bh != head);
+
+		if (busy) {
+			if (invalidated)
+				return;
+			invalidate_bh_lrus();
+			invalidated = true;
+			goto recheck_buffers;
+		}
 
 		bh = head;
 		do {
@@ -419,6 +439,9 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 		} while (bh = bh->b_this_page, bh != head);
 	}
 
+	folio_clear_uptodate(folio);
+	folio_clear_mappedtodisk(folio);
+	folio_clear_checked(folio);
 	__nilfs_clear_folio_dirty(folio);
 }
 

