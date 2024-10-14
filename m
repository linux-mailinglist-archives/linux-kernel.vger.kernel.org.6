Return-Path: <linux-kernel+bounces-364550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 802A799D601
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5F4B25691
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE11C75E1;
	Mon, 14 Oct 2024 17:58:36 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED51BBBC4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928715; cv=none; b=ku38d/BJEsnuWDOSc5kvQbr7EzyuQmwTP2AldUCgRcapbwxHurcPZ2kY9HFXkOq7EQreQhFubFqoLbbqqXr9uL5laJuaXuQv2OA7uM8tFvOBWhw/vOoZ+PUesHqTAsraERju5Q+T7vrs3FoXj+TRxA5z55tAElkq5WF5ljrsmc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928715; c=relaxed/simple;
	bh=WDEgOeaNwaJpoqXqZn24FE/CxtLrd+pEul87COOnzLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j81GckxGqlO8/rgX06QiqtZmnQ3kA4pEiSDqQG6Bie/RNHhiN9URaVHrCpGnFMJH+zf/xyl14f2Xw8JS9m+/3V15JMCNTtEsKlViQQMLT5Gq7uDWeizGJIMLEyGzBgp5xHnA2lJZfozgGMPCznSbtkw+cI5u1IxciLW1YezuYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e291b96a64dso2982127276.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928713; x=1729533513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dKXowJafF1Z3QxpyYT2YoF5bvfArXt4J7DnWxpky/s=;
        b=NIPStytYKrtYun1fmV/4N9jAYjjg8kTqYbPY4QMd19Lv4nqAUIria4bRhK9O7E3e1P
         XnzzeXUmnCP8KwkuA7Ua93y+qjuY3zprsqv8KVVF3INR/yEutVELgv92sYr33wt/qWyG
         ypISPWpj6M/ZfgmG2L+uNHmA6aWTIcv91LNenlAzcrCQ2BusNqRCJ54+E4sm5ufVBJg2
         wMeIFA0HvHgNKzpPF+s0NEuBRMnH7cH+IJPAQmTeYRcGHQgvynG3kv6Z+DoW+wAu2HLl
         hge+Y7CfCZ1O5BL+pXKBoGaG9eVfws08QQFs9IHKh+Es45CN+xR+7FHM8lpfNnCrjyfE
         Fftg==
X-Gm-Message-State: AOJu0Yz86j8CnRK3yZmOP0E9oV3PzyBo9UTsjQMcrDfZKTuZreV+0VY0
	ptUNFgY+Kjrippa+ovHh/d6QbLEq3YKwhXBOYHdRF0BuVfgsuFfS
X-Google-Smtp-Source: AGHT+IFXaTL+v/Bk6/s302w8doZcu7fQoXDo1I/C9cEsH9FVUJ+b6VisL7oyhstngLO/UYU9kDulcA==
X-Received: by 2002:a05:6902:238a:b0:e29:2bd5:3fe8 with SMTP id 3f1490d57ef6-e292bd540ecmr8185313276.14.1728928713078;
        Mon, 14 Oct 2024 10:58:33 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290ef5c514sm2448295276.40.2024.10.14.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:58:32 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	kernel-team@meta.com,
	Waiman Long <llong@redhat.com>
Subject: [PATCH for-6.12-fixes] sched_ext: Remove unnecessary cpu_relax()
Date: Mon, 14 Oct 2024 12:58:30 -0500
Message-ID: <20241014175830.5108-1-void@manifault.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in commit b07996c7abac ("sched_ext: Don't hold
scx_tasks_lock for too long"), we're doing a cond_resched() every 32
calls to scx_task_iter_next() to avoid RCU and other stalls. That commit
also added a cpu_relax() to the codepath where we drop and reacquire the
lock, but as Waiman described in [0], cpu_relax() should only be
necessary in busy loops to avoid pounding on a cacheline (or to allow a
hypertwin to more fully utilize a core).

Let's remove the unnecessary cpu_relax().

[0]: https://lore.kernel.org/all/35b3889b-904a-4d26-981f-c8aa1557a7c7@redhat.com/

Cc: Waiman Long <llong@redhat.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index cb1ab668e965..6eae3b69bf6e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1374,7 +1374,6 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 
 	if (!(++iter->cnt % SCX_OPS_TASK_ITER_BATCH)) {
 		scx_task_iter_unlock(iter);
-		cpu_relax();
 		cond_resched();
 		scx_task_iter_relock(iter);
 	}
-- 
2.46.1


