Return-Path: <linux-kernel+bounces-207270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E440E9014DB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 09:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DEB9B218AF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 07:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E971B28D;
	Sun,  9 Jun 2024 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTqKkS4u"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD56A28F0
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918538; cv=none; b=nePaFKscj7O08rpCA2Dh0zTjirwF/jQUlcS4n5YXt8ZUVzakZM1oMVmZ1q+hkf6y1jUf3jvtvBbIu+DGnaGSC59bvS4sGNcALVPD9Cgwwu0otX09ImJKpJjyvEz0sdMhXIh12udK9lU4qGskej6Uk9Faj5zkPwsTWk8mHx/BtPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918538; c=relaxed/simple;
	bh=igpddAQWDIZwXmJeryECdsrcMiftiOyDnYUQjLucsb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CdubBDB6q5/e41u1cf/BYVqJasOA1fmQT6euYXb3F8CwaQvts+h838L+3yyLvkSCS8tLjVsdefbsyh/BNBITQF6v+OF+1jkP1aDAc5HXz40EHRvBIUZSq5mRpneekglYhfp3zqxqNmj0FKBtfWUiJHSOkd9wAzgEaU3yUExIrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTqKkS4u; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70423e8e6c9so790689b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717918535; x=1718523335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NzkYU5DYxKNgpaqGInOs2vFDZEGApMIaKijlXwu6VT0=;
        b=gTqKkS4uCV6+r+EOMm62NxScg3euBj+A5lEgyuYvgX5H8+3PoLt9bhgO07f88Fl5m5
         1nSrchRMGEVL/Zaa8C0aG2v4hcCavwICWYVNS12cAk2AA7I31DksbrtksgFzqmk6G1Ai
         JGWi4JRNgXZ9+QkK2vBOYu6KQ1VUQnqiof4L13b3ICinMXyXRLOnCHy//p5eogjJLOFe
         5YlvpVFRgcjUj0GdnBQJ38BD4oXBw3qiZoec99kfGHz6j/DnGma1ULxQCmdWvYEzu1ER
         0BsIp12+TnQHr7DMPVKntnWJrSsThxuOgFrskaZYPujehETzk7DBPlwPs6ENZqsPpQ7+
         93HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717918535; x=1718523335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzkYU5DYxKNgpaqGInOs2vFDZEGApMIaKijlXwu6VT0=;
        b=YoXirqZl5MW1Dvq1c9OV6R6BBNX0MiaGo/NZPjyZY6+5cWrslKBM0NojQou9RfqJil
         4+KzhbvB8Mp5GUi/6+wQ97kdnqDs2lsrUMM1pQqPTMhzK7AiQ3NXGv3GZqlcJhf4JWXh
         /AuBIrzIUBy6MY6SV80TtVILiKWuPnAbYP1v7YSHy/jnLYyUJlBBNW5Z/8Vepc9Gs3yC
         6Sfu/8YjvkapTgp/Wno/8ixeRW7X4EHbTxAKT+blGoaHYKsVs0TSymO6mIkb0eti5gjr
         4nMV53eJFsJB/z30Csz83dJDkASfMeu+AMf1wmAwMgGw3tyUWfURC22GtLUhZLCHrpkC
         yFRQ==
X-Gm-Message-State: AOJu0Yz3u9G6qJ7ZhECa8Gv7taMwrN84FEEgZMXwn8y+dTPEvau2EVxi
	2E++GL5atjneQPQsmszrXx4Vew2HOxwwZZVJyXI3ejo1m4Y5KmQfa/nLxvNY
X-Google-Smtp-Source: AGHT+IFjjfbzyT04gCLt5Z5VWXHO/IzqK2eX+mJmOVXKXfkrF57ZyOMVn1OlV1XpJf6Ot9PML8NSdQ==
X-Received: by 2002:a05:6a20:6a20:b0:1b5:cf26:ed09 with SMTP id adf61e73a8af0-1b5cf270509mr2184206637.7.1717918534936;
        Sun, 09 Jun 2024 00:35:34 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28687382csm8476895a91.25.2024.06.09.00.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 00:35:34 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] linux/bits: simplify GENMASK_INPUT_CHECK()
Date: Sun,  9 Jun 2024 16:35:13 +0900
Message-Id: <20240609073513.256179-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __builtin_choose_expr() works with a wide range of expressions.
When these are Boolean expressions, some logical simplifications can
be applied.

This is the case of:

  __builtin_choose_expr(condition, boolean_expression, false);

which can be simplified to:

  condition && boolean_expression;

Because of the shortcut logic of the && operator, this works even if
the condition is, for example, __is_constexpr().

Apply above simplification to GENMASK_INPUT_CHECK().

This change passes the unit tests from CONFIG_BITS_TEST, including the
extra negative tests provided under #ifdef TEST_GENMASK_FAILURES [1].

[1] commit 6d511020e13d ("lib/test_bits.c: add tests of GENMASK")
Link: https://git.kernel.org/torvalds/c/6d511020e13d

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/bits.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 0eb24d21aac2..4cf27f329579 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -21,8 +21,7 @@
 #if !defined(__ASSEMBLY__)
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
-	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__is_constexpr((l) > (h)), (l) > (h), 0)))
+	BUILD_BUG_ON_ZERO(__is_constexpr((l) > (h)) && (l) > (h))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.43.0


