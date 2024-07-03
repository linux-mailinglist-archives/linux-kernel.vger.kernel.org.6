Return-Path: <linux-kernel+bounces-238760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC662924FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F051C228B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B189179AA;
	Wed,  3 Jul 2024 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePkE+j+i"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9C82233B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977777; cv=none; b=sLTQ/6mwMkz36NUgeYnFtP5AFSht6P2Or/jOijQxPDssjHPFjyyfDCNjHtIkFOAg328MgCsk43n7SQ8j9kH7Y2ECoSn5toIedOgFi9loPQP9O9kBPu+GeORWrdCSWVEdaXkhoNkm+8I6CKEijXoRFXA1GQOmpjuxZuIjICEH2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977777; c=relaxed/simple;
	bh=hDB7ErbKyrBBqUbkW2fkYqhmVxL7yx6cpxPwDaA56RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNwwhKgNJLv+BRu2cMVBTtJCnhDj6cybahy7eltPHFm7lWwZao7fcdHTqSzb7DFs/K0zXBm4/FblGO913/Ur+BjFauwH2Hpt37U97YvDuiPn4OsSkV0t5gZNSUBHC//d/jInG3/thXBe9CiofiX+NCWTFBQltASCgrXhPwZXe24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePkE+j+i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb0d88fd25so1500735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 20:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719977775; x=1720582575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmfbtIC8gkMyEyGpTQo1qvjL1gkxM76DMe3jF1C+RTI=;
        b=ePkE+j+iXYoBYvsx5gYk1aHr9iqk0c4t9S4Zs8EYd0Cw7MzZC7iueY5lDSEWI3TXhc
         g+qS0eevmZI12liLxMdl8jVYmbHt1KKHQFYizQRImEBtBTK4oFuZxmlhuZe5Fiph8/pu
         C9uwCraDBIMgxMwb+BMgw2a/wW1Y0QE8+H4ApGzXw7KA7V6iO+JsNZRLcmmYW4MEnOyC
         kxLpNw3KquvUO19h4/6UinjDrm8KYgBmkfiDhxIGmAtBUQy3dAq/OTgPsw1gw/BmWrm9
         d/mJexV3MhOt+Ya2UfOhmOYda8+zYu4QGNiDjiC0HYH1IDJSzyiL1SDJjFF0KoJwZk/W
         ACWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977775; x=1720582575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmfbtIC8gkMyEyGpTQo1qvjL1gkxM76DMe3jF1C+RTI=;
        b=CLbmBThHEfrvnPKuhyYod9bJgsnwALYOUqHLlt3GTj1NaiJDwqJiNYjNjV51KoERnr
         eRra1rg2wDvOHZEDEZDQaQPmsWCyhmZcip7wbd7FQXWzyny7qGOAmIt025S0fqHj706j
         U5v5c/XxrBoOnd0ZsUF2RSUXN7m1ql9EjeNUEDxNrTI5FZ+4WHrNkNtcvEa4BFdDLRBL
         FAyiYYmuySFS7KE6EjT5f4LNODqhqA64iLCSBtgS/ITZQ1EXuFYJRc8O6ZSggKK+YR7l
         o76ZCeFuC6XbXP/d7EZNaU5H8hr8t4T48MIlx2eNzhMeF8rhoihViCgn590nepCSzcga
         wcwQ==
X-Gm-Message-State: AOJu0Yxcg/776xe9TFwGVm0oOlFsJRGLLlqFRrNlcQDcDASnuGOqDZGC
	Sc+9wrB5Zf6U+YPYKmrhRN6SXwug8po+2DTM3hs0AbD5CejPfJIWkbZbVQ==
X-Google-Smtp-Source: AGHT+IEG4fucmaycNaPyVyLnYq9fuwy0hOO0gizsJVsEVzuilbHFrUVX4pMFgO5ui6l7OfmFwG9yjQ==
X-Received: by 2002:a17:902:dad1:b0:1f9:c52f:d9a6 with SMTP id d9443c01a7336-1fb1a02400fmr7829775ad.2.1719977775405;
        Tue, 02 Jul 2024 20:36:15 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15388d3sm92046925ad.181.2024.07.02.20.36.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 20:36:15 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/6] workqueue: Protect wq_unbound_cpumask with wq_pool_attach_mutex in init_rescuer()
Date: Wed,  3 Jul 2024 11:38:51 +0800
Message-Id: <20240703033855.3373-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240703033855.3373-1-jiangshanlai@gmail.com>
References: <20240703033855.3373-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

wq_unbound_cpumask can be possibly changed without wq_pool_attach_mutex
or wq_pool_mutex held in init_rescuer().

Use wq_pool_attach_mutex to protect it.

Fixes: 49584bb8ddbe("workqueue: Bind unbound workqueue rescuer to wq_unbound_cpumask")
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c738b3024cc2..cf1a129eb547 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5533,6 +5533,9 @@ static int init_rescuer(struct workqueue_struct *wq)
 		return ret;
 	}
 
+	/* lock wq_pool_attach_mutex for wq_unbound_cpumask */
+	mutex_lock(&wq_pool_attach_mutex);
+
 	wq->rescuer = rescuer;
 	if (wq->flags & WQ_UNBOUND)
 		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
@@ -5540,6 +5543,8 @@ static int init_rescuer(struct workqueue_struct *wq)
 		kthread_bind_mask(rescuer->task, cpu_possible_mask);
 	wake_up_process(rescuer->task);
 
+	mutex_unlock(&wq_pool_attach_mutex);
+
 	return 0;
 }
 
-- 
2.19.1.6.gb485710b


