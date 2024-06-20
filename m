Return-Path: <linux-kernel+bounces-222915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2E9109D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94B81C2083F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2431AF6A2;
	Thu, 20 Jun 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoN9W334"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8499158DCE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897283; cv=none; b=UfRLKzIg1WZ74HQC/3MTNTFi+sKLvgyCluuqrY/cvreAmC7ot8HohbwJWo3sbMkvJif31hsL2elZmrybeKlw0CZgdQYOYmzf1NYUwtYk0Gi1g+vQL+wMgAdTFcN5p+98r/phQHYlOujcFVL9xFm+Io2SdGKOiZmUzVTiU1WCb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897283; c=relaxed/simple;
	bh=Lq6ev/IOX8kK+kLgJjQdapCnQeiKAl7oss6pskcsUFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IFoWCmGQtic6OMbNFwsTDuP+/LXznmN+2tmwX6nFlMk1x3wk7xqPo56UkZFnQHa3hchzwSiKfiKtZWlFJk9P0KrtX1pyVU5BBKLXl52ArMkCf38LXvgOdqw68Lv6z3gfRvrtXpfrTaGiZ5yrgYG+XPgVANKGj/A65t4U80MwVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoN9W334; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6e4dbca52f0so806799a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718897281; x=1719502081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h8UoW2gDsuC/WTMxd+s3ovig9iw85Gd97u2Lu7zIm6Y=;
        b=BoN9W334evHv8Vx1b/MX8J6oiVAdw2KIIZACOQ50CsDDnjgsNPGLb8HQVb5M1DoXWI
         5BvbitV4dhUwlLnq8jPhDX5GlAeg/plkcyXP4GVb0OL/f++tcsa7PF9wHG/qrnVeoz6k
         iCQQ74mVr/gmMIqjdrx7HpCBg2tI14Wz/KbNYPhEg0pQa9KUgNk+gU7t9VIW3sgppzuv
         R/aYUti7wiKZdMhxQBebRqFoeerENVGZgTKCeZCUjasEicCMdUKegf0jh9XgB/n9aMt2
         zAmRL4voWOiJuZFk6Q++8BMOs+trqXT2Fhs/wxM2pBz+dQz34kOVuB+XLnpM3FK3BsJk
         +XwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897281; x=1719502081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8UoW2gDsuC/WTMxd+s3ovig9iw85Gd97u2Lu7zIm6Y=;
        b=lyyNYAsKKzyvyNROpmtAMOQXpH/MNgZ5W9teaibc+JfoFstUHe9lNAB+eSZ1J6uyEo
         xzC11HWq5QHkGtlvWQ80WXqewaOWCgZyvSlO5KuAm1eFET2yyxE4KleJXuH3TowOySrV
         ztUzaRoXaoIyg4Twl3nDuwUrUdo/0t/1gQtOGIFsnZS0joy0m5drW9DaABukTsrbq1xd
         BFxJetx74/f0VppWLg4optduZ+m5TWhv1/PBfRPyh0hY1If+ljI+NNyZRBGvRWurVNeH
         DQhI8bSzqL0NKXXrbAS2Z9rbhOwiH5nJZkhpsFTW9OL/fv0tPoKUeVOzZ3eRDpN8gamq
         Nubw==
X-Forwarded-Encrypted: i=1; AJvYcCURO2YcW2lPw49GrzCGOA3YnqKcFnLqTnEQiINxAEl0AqkE/wVFLIEbN/qpRKPzoKS9Ogd/PGzLYb+0YTaaTHx/lXWLUnBXwfD+cFbo
X-Gm-Message-State: AOJu0YwDAIabe6EDOCIJ9kpiWsCvi1WPHxp1M6vZF8qOaJe2JO5Vxv+k
	pEdzU6NqVE/8iV9YeuDXu5rymvaLTIF1Wuhyq+lwJH9MFz4BEGxd
X-Google-Smtp-Source: AGHT+IH2PX87ma1FbvOUxHxU3rIiaC1u7ZoE6yOCEBnMvfmo46HNm3smP9a+wJ28x9vaE7WsL1i28g==
X-Received: by 2002:a17:902:e543:b0:1f7:187f:cb5b with SMTP id d9443c01a7336-1f9aa46612bmr57851965ad.64.1718897280851;
        Thu, 20 Jun 2024 08:28:00 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f86e1d82aesm113382685ad.253.2024.06.20.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:28:00 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: akpm@linux-foundation.org,
	brauner@kernel.org
Cc: axboe@kernel.dk,
	oleg@redhat.com,
	tandersen@netflix.com,
	willy@infradead.org,
	mjguzik@gmail.com,
	alexjlzheng@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm: optimize the redundant loop of mm_update_next_owner()
Date: Thu, 20 Jun 2024 23:27:45 +0800
Message-Id: <20240620152744.4038983-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

When mm_update_next_owner() is racing with swapoff (try_to_unuse()) or /proc or
ptrace or page migration (get_task_mm()), it is impossible to find an
appropriate task_struct in the loop whose mm_struct is the same as the target
mm_struct.

If the above race condition is combined with the stress-ng-zombie and
stress-ng-dup tests, such a long loop can easily cause a Hard Lockup in
write_lock_irq() for tasklist_lock.

Recognize this situation in advance and exit early.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
Changelog:

V2: Fix mm_update_owner_next() to mm_update_next_owner() in comment
---
 kernel/exit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index f95a2c1338a8..81fcee45d630 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -484,6 +484,8 @@ void mm_update_next_owner(struct mm_struct *mm)
 	 * Search through everything else, we should not get here often.
 	 */
 	for_each_process(g) {
+		if (atomic_read(&mm->mm_users) <= 1)
+			break;
 		if (g->flags & PF_KTHREAD)
 			continue;
 		for_each_thread(g, c) {
-- 
2.39.3


