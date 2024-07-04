Return-Path: <linux-kernel+bounces-240478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E0926E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8D51C21692
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241A3B79F;
	Thu,  4 Jul 2024 03:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeWp3oRb"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB563BBCC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064801; cv=none; b=mfaq4FdBghkwaPSE/5VW4GfEfUAOkE3fWHRM/PuiDMM+HllTLm3UEdKh7QIpoq3bGg+HEmbQRUyNlUeUwtlB9BkRkDC7dQ+cjBDutBbgblOJ+RLuZEm1cTvldlgrDEeWF1ojC30qJeIhtF/0ystpsXPxmgITEEWLBNSsQrMHCVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064801; c=relaxed/simple;
	bh=z/XeS/S1Pa0LeS2I3yaJ8rhI4Ye1O/Fb37d7D4BP9Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skk3W0r8eRJcp/95dN43LqPr2VrB0go5Q2gkwjiJ+mNJj0CI/7io9aQUIvOaiWKcXrDxUimsiMB0rq0n75EYD68Ju7UIapb1hdmg/SLR8Sb4VDhqhXR2PG0LZI8xJeK8TCRIBxSj0bfD5fj0idGOdSa+qOyEzSE9Z/oA+g/9s2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeWp3oRb; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-701fef57ac1so141619a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720064798; x=1720669598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWRDLhnXLKtkXkAKITd82oZMdwj+urGj9spLJB/oijM=;
        b=BeWp3oRbejMKUQ5gejRU3OLj6Y3OUex49+1o0kvcCRgWpt2vB1mpw/8Y++OIrs4DRD
         r7fpROLMD0RlK6poytDz+SuqFpf/6eU4ytKRWHEwBMaf/AUiRwRoiGvv7x/a3lBDFSEu
         EjrdDA5cooOZCOauTawX/+AsWcvrPvISfZAye9sd7d8uOX0y+pqbSxJ3N5zaiiV5rtIZ
         7ATbqAS1iLInPpgT5U8cLbPVHWHxOHlaP/Npgho7Ib2EgYdvNb/pyCmCsZoVoB22s2Vw
         RL4RrfkAKWz0dfCjQoTqyvQo/kJqwy3Wcoyu8JV/AjLlHX4eq2BWOOaN70689Vgnw/oh
         eQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720064798; x=1720669598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWRDLhnXLKtkXkAKITd82oZMdwj+urGj9spLJB/oijM=;
        b=azm/bQ0/aajyE3XrO9WvC3lBkosPmHLdIg9D8aen7ZwsC5EySdVxy+lvfE9IgchXiK
         EgD8KVd8b6DtZoFlJVke6d4bDV2jnfxBmQUrmG8t8PAde6pU8UrKHyLCgBRJ/o/wRfwe
         YHz/d2gSZh0xWM+VNV0Vij+C3FFjNuctOnuLE8xQtkBPBuEC8RfpINrSa4tmui6Ge52G
         U/28fv5fgFoV9WAh+Ezk/ptwdEr7w/PniQAA3v4IqDYUHvUR34XDsxbAYSg/idFUDw4S
         Vi9gJna19B8zKGSwg5X5XYuEp9r7C85L9L62xRq05Z4Ateo5piG7pvDDcLexYQtR44JN
         O2oQ==
X-Gm-Message-State: AOJu0Yx4bhj7SK1BMqIiBfbmTrdlbAJ9efUIaZ02wOi97mpZ8xyKZ1en
	XykeaPoqoi+/2mkUjGoJw28jlorTNOCzG3tIYWiGOGckCqGWk7KtmheZtg==
X-Google-Smtp-Source: AGHT+IHsXhFhEH+jURVd8CA4C2NFMSDx3+IR1pXgHDrbueGhEu/4TcyvsTGUfJIdRU9blDalnxE9gQ==
X-Received: by 2002:a9d:6b98:0:b0:700:cdcf:d3ae with SMTP id 46e09a7af769-7034a7e8385mr624690a34.29.1720064797560;
        Wed, 03 Jul 2024 20:46:37 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6b2a15acsm8817239a12.43.2024.07.03.20.46.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2024 20:46:37 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH V2 2/5] workqueue: Make rescuer initialization as the last step of the creation of a new wq
Date: Thu,  4 Jul 2024 11:49:11 +0800
Message-Id: <20240704034915.2164-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240704034915.2164-1-jiangshanlai@gmail.com>
References: <20240704034915.2164-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

For early wq allocation, rescuer initialization is the last step of the
creation of a new wq.  Make the behavior the same for all allocations.

Prepare for initializing rescuer's affinities with the default pwq's
affinities.

Prepare for moving the whole workqueue initializing procedure into
wq_pool_mutex and cpu hotplug locks.

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 904a1a6808b7..0c5dc7c06b81 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5690,9 +5690,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	if (alloc_and_link_pwqs(wq) < 0)
 		goto err_free_node_nr_active;
 
-	if (wq_online && init_rescuer(wq) < 0)
-		goto err_destroy;
-
 	/*
 	 * wq_pool_mutex protects global freeze state and workqueues list.
 	 * Grab it, adjust max_active and add the new @wq to workqueues
@@ -5708,6 +5705,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	mutex_unlock(&wq_pool_mutex);
 
+	if (wq_online && init_rescuer(wq) < 0)
+		goto err_destroy;
+
 	if ((wq->flags & WQ_SYSFS) && workqueue_sysfs_register(wq))
 		goto err_destroy;
 
-- 
2.19.1.6.gb485710b


