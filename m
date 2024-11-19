Return-Path: <linux-kernel+bounces-414234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D304F9D2504
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3721F24E80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995871CACC1;
	Tue, 19 Nov 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QhlpCVMv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3FD1C876D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016345; cv=none; b=WSJHh1N6RDyiBCT2/jcv2AFXvEZb0gztP5nTte1WFu5Rs3VnCFdVt2bDzdq+gEi4fjArc3omWTK32rU+43xN1V5lvItcShu5ptIzaTlhsYCa/uPlSsAnP7WReEv2DQ6TdAU+APMQhBwzrAS5V24fGAxcjT1hPVyk//qet2hVZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016345; c=relaxed/simple;
	bh=jq7q5gMc0dxUpqOaGwo1iex6hNNf27GUYB57D9I90n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEoJ+XF71FLDcAucqrSIAT2dSx+lkyVDUO9ywCJ7FX7d9FYSGD/Dn96uAULSx0HOqJZhFFFWWAlk90mLkHpayXFDu04sCrTk6lRxyGBwRpw6zETE/aB9KO0YbJXt/2JR7ulvv3ZzdxR2cizckFUqvuYBw1b1C90vPIMVOYReMA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QhlpCVMv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43159469053so3044825e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732016341; x=1732621141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVb/aba7kAugbNKh4JU+Sc2Vx3uCwvVw0Yr+o1yHZGI=;
        b=QhlpCVMvV6mGw5ZivkQv7RMCv6TjHIraeQgCK5TrCtDUZgiudQFJrq0D8m72V5aIBt
         Q0ZHcm310Mg0h8nbKUXYO9ZECKQ7WpYDcG6Sb3SPzWxgNn3ieJXHlU2EnlcEggT1Zff7
         FpiZqsJqjTaZGePXOby0lFsE9UjTQBsAMiMbEMRnkJphGSbnB3SFiS9fzEVfkATyUFKV
         BF+rbf8YQEjzGXFGAevoP66cDot8PNDnmxsaCOvgJKzrRoDgt1hsDaEnDc7/qEWYhOrq
         CQFkRVlcuEmWmy6BT2LWnlJDyvPlFBWDYL72ZPcGfUTqWkouEbljUJiaHzb+pvnga6R6
         TSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016341; x=1732621141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVb/aba7kAugbNKh4JU+Sc2Vx3uCwvVw0Yr+o1yHZGI=;
        b=trVgFnneeL45k7q9Guo2LkeIv/N+RdD5Q8wKXTgZkY3eG5JvrnIIeiCQuMOuXhdr12
         XG8d8e9QGKjt0UDXMQE+SM9+DTsHZq/xMp1uK1Kva9P2GIh4GsbJF029stav6xdwWOKv
         F2nLLNG8SpP8s+q5gDdBdH5Z/IsWSfze3O2BJTlLVL9I9Kl2fJeaA/x6YX7ql83tvjPe
         0YO5DQh11vAqUvESC8ySIqBuvXuI0+mKfFAjQVjr61pcjc7yeYLk4LiP9gX4mXuF0dnc
         pq8iH31jG+d9eWR04HkeXnDuoIHgNe94zu2uD48or9BWWzLa8PBlV7PJsx17QBtE7iLf
         3wqw==
X-Forwarded-Encrypted: i=1; AJvYcCWbhhLkQKZPhFTBNorIA6kR/UOOQAOzpQ83t4JPEpIGD650HmXIf3oJhRmiaEbw86OMI3fbxAv6S0G4irE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDcG5FQxOTVZhnWZFehusOFjM2k9AOI+/0MD0tKG3tHhQxz0X8
	4YtSERL+Ikruapih58jMXP/Nh87C+UJkjcRPcf0pQPY8YGgjpr+KmH195t1Uqvg=
X-Google-Smtp-Source: AGHT+IFr45o9PycleaXFLiTzqXvscquGYb+Mn9zBNm7BOq5qHffbKvS1FuCE87Z0Yz6aN3Qi7Bsc1w==
X-Received: by 2002:a05:600c:4eca:b0:431:5632:448d with SMTP id 5b1f17b1804b1-432df795cafmr57581345e9.9.1732016341354;
        Tue, 19 Nov 2024 03:39:01 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7878esm192965345e9.14.2024.11.19.03.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:39:00 -0800 (PST)
From: Petr Tesarik <ptesarik@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Jinbum Park <jinb.park7@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v2 1/2] mm/rodata_test: use READ_ONCE() to read const variable
Date: Tue, 19 Nov 2024 12:37:38 +0100
Message-ID: <2a66dee010151b25cb143efb39091ef7530aa00a.1732016064.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1732016064.git.ptesarik@suse.com>
References: <cover.1732016064.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C compiler may optimize away the memory read of a const variable if its
value is known at compile time.

In particular, GCC14 with -O2 generates no code at all for test 1, and it
generates the following x86_64 instructions for test 3:

	cmpl	$195, 4(%rsp)
	je	.L14

That is, it replaces the read of rodata_test_data with an immediate value
and compares it to the value of the local variable "zero".

Use READ_ONCE() to undo any such compiler optimizations and enforce a
memory read.

Fixes: 2959a5f726f6 ("mm: add arch-independent testcases for RODATA")
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 mm/rodata_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/rodata_test.c b/mm/rodata_test.c
index 6d783436951f..3b60425d80fe 100644
--- a/mm/rodata_test.c
+++ b/mm/rodata_test.c
@@ -20,7 +20,7 @@ void rodata_test(void)
 
 	/* test 1: read the value */
 	/* If this test fails, some previous testrun has clobbered the state */
-	if (!rodata_test_data) {
+	if (!READ_ONCE(rodata_test_data)) {
 		pr_err("test 1 fails (start data)\n");
 		return;
 	}
@@ -33,7 +33,7 @@ void rodata_test(void)
 	}
 
 	/* test 3: check the value hasn't changed */
-	if (rodata_test_data == zero) {
+	if (READ_ONCE(rodata_test_data) == zero) {
 		pr_err("test data was changed\n");
 		return;
 	}
-- 
2.46.1


