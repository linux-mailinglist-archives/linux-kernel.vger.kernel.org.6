Return-Path: <linux-kernel+bounces-224059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A18911CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40CC1C21D07
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FF916B3B9;
	Fri, 21 Jun 2024 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkhrwpF+"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1642AA9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954983; cv=none; b=k6yFWfCW2xpVGDaD7vX5Ra5gK2uB3xSOySIEEXHgzbHemkg1Ug9b0PEMoehdq9Hafr1VhBke08jHPNjARK4IwksG+OQf+VsUmpjdYRvnS5E3baiRgwo9muDrzTp3o7qIAPlCGCi1Ip0QVGU1gZhRE+/l6Qg0wJLlhmv1TY2IoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954983; c=relaxed/simple;
	bh=z/+kbpIF5LNZ7J3ty6ZU61tMvYLBU+K3nYLRk7lV960=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o6NMPq/nGDlg3ipOc5qDykRY9E2/Q2qciagwOkba4eXBsrdCHn8c0VumXQA3ts1B0NmxPpyXb1+8jTYiv7q8azPj3qOmlpuYDrjgNJGqa4i1vrkEpWDIwV+iwkpLCQDL1gqYy/2/cFbQmXM0JMi2l2ciaQr97ScuivekCEyxjPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkhrwpF+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-70df213542bso1211461a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718954981; x=1719559781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrByOuSSdJJfOiuZoGI/GCFoQPmJLRboTp7l6nd23AE=;
        b=lkhrwpF+wMLzWodDMH46boisIzdlMAw63/smpMCDIBJm9q6jDpYrogRANxkl/QjV+M
         NKqh2I84ksP3d0J5dYDryzs58/B/gJ5nDleJJqPSjzx5R4/BvP+qmbA7ykA34CQXkpDr
         N+wh8unfHDMeMXKaz232QdGfEjGurq4xe0LiN06VgIDavUV1ZNtD3YN1A9n/IPNke9Jd
         1NK1KO8QpRH4nRY3GBQnPRgM5AspuTOPUf3clhkvtS2+7i+xB/dRwzwD7K+6wlyY1D7w
         u+c3sUgE8nnnFWtBfGbxXkkqSxx1Vx+TNedb2TKz+JGqo5ma/xW9J5S9XeE70ds/aKBY
         9H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718954981; x=1719559781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrByOuSSdJJfOiuZoGI/GCFoQPmJLRboTp7l6nd23AE=;
        b=fpPLJWZ6UMuoAQpdqUNPWEW0nNaHakOqoiZlo1CvyIvTGmDw//60L59qUiOlb3sQEZ
         Jdgc/mDAKoigZ8Y/ilGXt9xT9J+SW2QbOQ/5u8flrKI/+JqLZWE43lPb3u4HrYBz1sSk
         6ZEFjw2pLKVb0+9EbbfWXQsgx3mE7TWy9bEM7XvPDbLOJXUzi184AOdY7GtW5EpmkoZy
         Ue8rngVQjXQ3oGOcYXz9YV4OTb8EnzIwUXYSKJJ8PWbyZlESZlo4cpg6pFnrouA1AWdX
         NTmDDBoS/ENx00Dbeu535Wx57Tug8Uf1ckqg9zSu0LCt79trKarqpnRrtJDq8qxOTfIW
         W8cA==
X-Gm-Message-State: AOJu0YzF5KnHTVNrRTsUecQCNyS3CIhy/1kSiIQ0ycaMdFC7i7+Y45+R
	0WUFinpxzfIRx6Kn6pP+FJegVrFMCCRYkzO2vdw71nbwkBKBUs//XavfkQ==
X-Google-Smtp-Source: AGHT+IH36ZSbgJoRUq8AQuSj05yz3pJQ27pCiatM/yWTzUS0uoW8mKFWZ6DWCfOkTPDTUm1rUANGag==
X-Received: by 2002:a17:90a:e00e:b0:2c0:17b4:85aa with SMTP id 98e67ed59e1d1-2c7b5c9f60amr7290865a91.22.1718954981074;
        Fri, 21 Jun 2024 00:29:41 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819db94f7sm881929a91.35.2024.06.21.00.29.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2024 00:29:40 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 0/4] workqueue: Destroy workers in idle_cull_fn().
Date: Fri, 21 Jun 2024 15:32:21 +0800
Message-Id: <20240621073225.3600-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

After e02b93124855("workqueue: Unbind kworkers before sending them to
exit()"), the code to kick off the destruction of workers is now in a
process context (idle_cull_fn()), more destruction code can also be
moved to the said process context to simplify the destroying.

Cc: Tejun Heo <tj@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>

Lai Jiangshan (4):
  workqueue: Reap workers via kthread_stop() and remove
    detach_completion
  workqueue: Don't bind the rescuer in the last working cpu
  workqueue: Detach workers directly in idle_cull_fn()
  workqueue: Remove useless pool->dying_workers

 kernel/workqueue.c | 87 +++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

-- 
2.19.1.6.gb485710b


