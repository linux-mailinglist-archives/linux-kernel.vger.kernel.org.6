Return-Path: <linux-kernel+bounces-347569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2D98D548
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD3B21ADA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E54F1D043D;
	Wed,  2 Oct 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtLEqPuI"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1271D049D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875716; cv=none; b=LHhE1uVx3WXMYQcOK9y4KJSJStkzBGgUPENeFyqmbt2cbYiVs7xYkzD/UPSdpfXZdLfU8ybhLuICu1Zel4uJYuKzkXimoMTK5tBtbujRMtpOCAT2zuZGEVB7u2xTMF4250ZHecn5Kl951JNm84qpphbsuDFHpjdyicn9Yq+8nv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875716; c=relaxed/simple;
	bh=5TU1SW8qHIohE1BHdZzxN64tdjxnxFrqA9ZfQdbi42A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjL2CUcc4W9ps9qYqGG5VHsIuXrShXpMgamCDPPu4TEtdXaCofjN5qOh7r32yLFRhyCZLbIfBfs6R12MNemQNkHM4cT0xGPv39NBhQyrYh98KOqRTry87mWe5ZCuO2l5vWBmXSrUQb4uduRqL7vcvpdYk3WX3M6agrFxmUgYfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtLEqPuI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e09f67bc39so5496731a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727875715; x=1728480515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2KUdZPsxrxfYclDZ4cMZEFGNcVJaWq3B2wNfqyElyQ=;
        b=LtLEqPuIbaYa/NXH/R+yX8sos8ZVlh4axNp9JAsk7hxJXj4fE7QQeiliaNHM4YZw8s
         dTx4N2SO6Jn1blP9m/yCUkQbPLk7uef0uwtBZQaf8EuBgM65oDo0G5kYDZcEWALjU4cq
         VFgMlvTHo4vbK3nS4+4Ccdd+hBlQUn5LpH7J5vSaaBgRBenk4au55kYXpIOHZuFR65eM
         VU8s2SoxmFmKJ7AwyV4wGM/R7vMbR0fAIxhjvDAv8O8X9ITzLpulFWedrTud7Byaq78d
         mJmrfCJqVJINsz8Se1xqm29OuUk2CbQgz1q0iRom6ZUcpqonMHCpIh7QmfuFBIpTpINA
         9hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875715; x=1728480515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2KUdZPsxrxfYclDZ4cMZEFGNcVJaWq3B2wNfqyElyQ=;
        b=qOSmCuNmckpV890P+uTFlzcQiL2tYktIYaESGmeipXSlqvPiXxZtDmdyA53hlI8Qr5
         hmYDYcSCnZnTNQjGp5j7TLunl6A0hmTAkgJ3Iolp1vQAYEWVUC6VVj0Rps4QuOR+QPqt
         ZQ5wKKKWM55h57L1vqlDQLLBjzLZz519A7W+ui3klQUNS2gKuo3anhDiXXo+Zuh55Khj
         lV4Au1jUi1bo683c9dI7wPtNh1THc2fm3t2Eft6JH3RR7V1isFPqIMTlvqaU6rUvi8gK
         ATx4HYkBs7oBK7UQN35FmKqAO6AU8d/h1oM67BO3GR/a6A3UTSC+y9PmCV+aiB8P5wbo
         pjQg==
X-Forwarded-Encrypted: i=1; AJvYcCUqAaXZYVEdQciIGyOwVR6ySc+Gu9oTfp0lNWZqYUkoiId/NaJ8W9S3XWYoG2zYWqeiZKf6XkpRU+2yFUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNACERshfN492O0c5GdI35PEEb4ONprIOlSwY79ogNi3VZ3jJT
	NbXYu8fMzokAyail3M1qyotCwix66HfJalxwUhexPXPFDZ3xo8ku
X-Google-Smtp-Source: AGHT+IEK5Ju6McLDb52scMYJjRIvfLxCIblhg4hiIlR/DRXCuiHOHjza5McL7RCgEWXhSriDM7Bi9A==
X-Received: by 2002:a17:90a:ead6:b0:2e0:a067:4208 with SMTP id 98e67ed59e1d1-2e1846e773amr4307123a91.23.1727875714597;
        Wed, 02 Oct 2024 06:28:34 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.173.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f7734basm1528740a91.19.2024.10.02.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:28:34 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-m68k@lists.linux-m68k.org
Cc: fthain@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 1/3] drivers: nubus: Fix use of tabs in nubus_get_vendorinfo and nubus_add_board in nubus.c
Date: Wed,  2 Oct 2024 18:58:18 +0530
Message-Id: <20241002132820.402583-2-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241002132820.402583-1-sayyad.abid16@gmail.com>
References: <20241002132820.402583-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change maintinas code consistency and compliance with
rest of the kernel codebase by implementing use of tabs for
indent where possible

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/nubus/nubus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index ab0f32b901c8..08cf585cb471 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -615,7 +615,7 @@ static int __init nubus_get_vendorinfo(struct nubus_board *board,
 	struct nubus_dir dir;
 	struct nubus_dirent ent;
 	static char *vendor_fields[6] = { "ID", "serial", "revision",
-	                                  "part", "date", "unknown field" };
+					  "part", "date", "unknown field" };

 	pr_debug("    vendor info:\n");
 	nubus_get_subdir(parent, &dir);
@@ -783,7 +783,7 @@ static void __init nubus_add_board(int slot, int bytelanes)
 	/* Set up the directory pointer */
 	board->directory = board->fblock;
 	nubus_move(&board->directory, nubus_expand32(board->doffset),
-	           board->lanes);
+		   board->lanes);

 	nubus_get_root_dir(board, &dir);

--
2.39.5


