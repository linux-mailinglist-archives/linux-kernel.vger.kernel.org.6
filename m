Return-Path: <linux-kernel+bounces-168953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C44E8BC024
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352611C20AED
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DDA125B2;
	Sun,  5 May 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyaPQEpL"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060ADDBB
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714906473; cv=none; b=SULUEbiBwfhjjJhNroyx5SsAsrB5R7f5vLQeRF5jakrfmaT4N4oagfP2gq8l9bRXS5DLajZjTex4tQ0Y/+y1A4t0YdKbeNxbbi41B8Lwwz+lby3vcfyWhE53JEVdF21V1VW2uZ8GnGLTHc/UenhVH2aj3uMhAhEP8XM18TxTg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714906473; c=relaxed/simple;
	bh=YiQG2kd6fzRNGbYy3Gf4QHMrxt0Cziv8CrLIII4y7S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmvLBQv0wH5nG57ZBQxNSBMJfBMz4Y17t4IUIHwZPhjPXRkr4XlZeo1gu9PQ60QUrvtbHoRU2fHs4LC1lNG5iiwlFAdWI7vOvlRGtKnd3H0RvU4xwQdrMS7xwKGvj4cAkL1USnfU0uVm9FxPdXezFLShjnEA9jUrmTGH2eL7qz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyaPQEpL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34de61b7ca4so706363f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714906470; x=1715511270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB9zSg3HB56Gem+Nq6SEeYo/kBx2mBMxlcpr4G0CE0c=;
        b=IyaPQEpLjZlED0ig0GPbmmu74/wGdeGubc0qxb7d9a4d7gG2S8np+pjr3q25l3Mydo
         8IOSx2e6DWfWgs1VSQiR1+ED2eB6LoPRG5CYVZ5dMkJHnsxu58ENIyXZbPvWSwanS32+
         EioiSf+KBM96M017E5EOnVz9gzI3/2eTL3ig5krLr65f6gw2IpPwjrN2WxFQSsL9VY4U
         MGuoS/Y/AG+xqEIKKaFa3Z9iTm0fsKXKCDB65Sxs/pNqtj6jIVoUjaBV1pVu8ony/I4S
         +oR1FWWVHYrVxOzL8VvlBDRpfytAIOXkZhjDgQEVGUMpF+nN2kJvxMGcY9jbYaf+m5i6
         XONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714906470; x=1715511270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB9zSg3HB56Gem+Nq6SEeYo/kBx2mBMxlcpr4G0CE0c=;
        b=kPtLmoObAbYUOUS6pMksZaF9b9mCdZLTVB6ot46OGVAji3JjQyBNbQKOEdijSzvdkZ
         SOkXQcTU42uSIXw4v4C3qfzkMGoNcCdQ0Ob1c9RQA7JacPV5Y/VcGoc9KI0jpchcqdtU
         yuABy0C7tp6qzQQyJBOJqUHRO8rxtqvGXEIxGfrbRo8HZW7mSXPPgGaWJOpZOpqA/OR0
         xv0+6q4BhFaW6qjoFsSGEz/PEsxXgo5A7QsmEcTeZMnakau/xifBkkwlo/Cwip4iRP3j
         GXsBZ1zgUMkpGqgO0+aU0LW6XpOvX1/bDZ9sk7cd3bG4d1vnOY72Z2JZr3jHLkFGbAX9
         7N2w==
X-Gm-Message-State: AOJu0YwaYfkj2PQHyVQnOOzao550xC0Ad8tUmpwvRQRTkUR68CSa7fGq
	WiVz1AXNzg1yxM6j8irR5erLAd4to0fdBmUMqP9J8mrUtfCeGaVK
X-Google-Smtp-Source: AGHT+IEEKCBSvTXmBzAtmUqRF2lFLoJQ1ePwQ7uKfHA2gkbqMrv0jc4PsHSSE0Awa7dm/HkAeGB8DQ==
X-Received: by 2002:a5d:6da6:0:b0:34d:939c:d022 with SMTP id u6-20020a5d6da6000000b0034d939cd022mr7432427wrs.18.1714906470279;
        Sun, 05 May 2024 03:54:30 -0700 (PDT)
Received: from localhost.localdomain (host86-177-210-156.range86-177.btcentralplus.com. [86.177.210.156])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0041902ebc87esm12141553wmq.35.2024.05.05.03.54.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 May 2024 03:54:29 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: anna-maria@linutronix.de,
	rederic@kernel.org,
	tglx@linutronix.de,
	Markus.Elfring@web.de
Cc: linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v2] time/timgr: Fix wrong reference when level 0 group allocation failed
Date: Sun,  5 May 2024 11:54:26 +0100
Message-ID: <20240505105426.83553-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240505085709.82688-1-ppbuk5246@gmail.com>
References: <20240505085709.82688-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tmigr_setup_groups() failed level 0 group allocation,
wrong reference happens on local stack array while intializing timer hierarchy.

To prevent this, Check loop condition first before intializing timer hierarchy.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---

v2:
	- Modify commit message.

 kernel/time/timer_migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index ccba875d2234..84413114db5c 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1596,7 +1596,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)

 	} while (i < tmigr_hierarchy_levels);

-	do {
+	while (i > 0) {
 		group = stack[--i];

 		if (err < 0) {
@@ -1645,7 +1645,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 				tmigr_connect_child_parent(child, group);
 			}
 		}
-	} while (i > 0);
+	}

 	kfree(stack);

--
2.41.0

