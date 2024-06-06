Return-Path: <linux-kernel+bounces-203891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFB98FE1AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3DB1F23356
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ECD14D446;
	Thu,  6 Jun 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzv1EepR"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86E14D2A4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663944; cv=none; b=dCvx5fvsPf8YatubM3a/7elwW4a37Kq0ssXtq8LIQYOirnirwBTDQH7uTkfb8jCnExmgSWSIl2BMtSwMas3Ss0WIpPGPnP5RWUuqWeTTnSLO22EF3tbpm8nlIGzleORrwjNkio2A9cyNfej5IoHC7HbcgvJ0W5vxi911vcjTzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663944; c=relaxed/simple;
	bh=I06IY7l9lT3T58x0Sk0bx6AgNOC8qgEbTEhIm2cYW3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGiumSDjQXK94G8K/5qYi9O5OtrXz2EIGPj/KAYO7rE71eXeT80bXLYTAOdRRkpoppaafMqllu73nkTIyrM7cozTCQdOW8/QZCJP/boK/emqypwaTxzjBf/Cj0PYQvdzHZ2kvELbBUGcHPf/K/9apWAptPFkFdnDxakqVXlxfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzv1EepR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f658800344so6434905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717663943; x=1718268743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m04RLKF6DOGZkrMp62XuDtkR6n73erwE2EEzWUvSJlc=;
        b=hzv1EepRlAlyOe+j166fr0OG99HMWKLdoz9An3UH1J6UJDjzrRr8Y87Bh6fzXPxrEu
         42+P+0p5aPitxq9iVzvW4O8FJWtnrXUveOwLQIl34RUI+LIS7F/YBMeGLl0zKwEjO/wv
         WPRSij4J+B3SjcrsIMXKHv1u4MrWnZv71eOYmCDOxMTfZvv+ONiSc6SvjWPusejyMNzM
         53UQ/RVeFG4H3t+CziXSfNKOG7pPjbL4D9ww5uqMfUDKxuSPEdb36dWvrwFe4GYmHBTz
         OhxLJpt7yXLu9eETtIgyom/V6WDKPdXNKUXERn4GQQ4whBSZp8I7eep86qhlrFrZTB45
         A4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663943; x=1718268743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m04RLKF6DOGZkrMp62XuDtkR6n73erwE2EEzWUvSJlc=;
        b=baY/jtLF1MBsMOBJCQuM80d2sj5jnmTxCzZLZbig2ppfcwIIxov8IPrfxQcnsU+1te
         ajRqjAtNM03yVZsxK02UTp1AVqGiwArP7REhSup3LVW/cpE1+ruah9U7QAhMQVyryzmP
         1ce6S1YHfmpn/Q9/FzsnDXBnOwYhHV7hwdouv5LVf+HzSCln2y+7soqNbBnYchANpDMx
         hLCgOBb0SOacaGVA5Y2WOiV2lWyVrfjBGWGk+f70ArKb9dwtpYxPlvTv1owGev18b34g
         oJwDHraHYAxrESKqFQY8xf1q3a5E52kakGc61xzgR9w1JRvz+ZKJmc436RLLjs58CKeT
         DNTA==
X-Forwarded-Encrypted: i=1; AJvYcCVZDMLd0r0tdYFmT/eKDp4i4YvMnT+pO1noPoh7Zb4u6TynI4VbQXIkHQYc0nKUt5s8oMtv6kQU8x8yIHxnsgsKH6ts1K5C1iF8ISxe
X-Gm-Message-State: AOJu0Yx00rmziCGjZiFuBhkZrp6ebpibxatOb1GWRQm8DMX5AFJtusKF
	V6wCpYnJLkavySlvuQJI7syOi0qLzfmv8dL99bcO20Fja8vhfCTGmHxfH0m4LuepFg==
X-Google-Smtp-Source: AGHT+IG44Iwms7e/O+5pF16sE89zsVrZVN3TIZfgEa5i+6+Xev5BLnMFF1PgACyl8fv8m/R8QcWLTw==
X-Received: by 2002:a17:90a:cb96:b0:2a5:e087:768a with SMTP id 98e67ed59e1d1-2c27db1b64cmr5244388a91.29.1717663942722;
        Thu, 06 Jun 2024 01:52:22 -0700 (PDT)
Received: from localhost (97.64.23.41.16clouds.com. [97.64.23.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c280639a3fsm3059540a91.4.2024.06.06.01.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:52:22 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH 2/2] workqueue: cleancode in alloc_and_link_pwqs()
Date: Thu,  6 Jun 2024 16:52:16 +0800
Message-Id: <20240606085216.3475033-2-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240606085216.3475033-1-haowenchao22@gmail.com>
References: <20240606085216.3475033-1-haowenchao22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wq->flags would not change, so it's not necessary to check if WQ_BH
is set in loop for_each_possible_cpu(), move define and set of pools
out of loop to simpliy the code.

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
 kernel/workqueue.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3fbaecfc88c2..078d56ddbe3a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5477,16 +5477,17 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 		goto enomem;
 
 	if (!(wq->flags & WQ_UNBOUND)) {
+		struct worker_pool __percpu *pools;
+
+		if (wq->flags & WQ_BH)
+			pools = bh_worker_pools;
+		else
+			pools = cpu_worker_pools;
+
 		for_each_possible_cpu(cpu) {
 			struct pool_workqueue **pwq_p;
-			struct worker_pool __percpu *pools;
 			struct worker_pool *pool;
 
-			if (wq->flags & WQ_BH)
-				pools = bh_worker_pools;
-			else
-				pools = cpu_worker_pools;
-
 			pool = &(per_cpu_ptr(pools, cpu)[highpri]);
 			pwq_p = per_cpu_ptr(wq->cpu_pwq, cpu);
 
-- 
2.38.1


