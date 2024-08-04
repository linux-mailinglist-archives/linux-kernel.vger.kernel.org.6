Return-Path: <linux-kernel+bounces-273665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308D2946BF8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 04:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2276AB21880
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AF718026;
	Sun,  4 Aug 2024 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyPZr2cM"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED77494
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722739262; cv=none; b=kZRYVTNFn825fLNJCky7fYNKr2h4cLubfcqFmeVfNiCvMIEOXesSaKqFX/0XUSnyndiJu0UdR+V4LIzG8derrHNwDQvTQ7hl+fEC+lefHwqra5Jzoajt6y7ZjEUSL+wD7EL7AuH4ERdcLeIFnTevsQ9HmbAKFYqaktyFGoiFSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722739262; c=relaxed/simple;
	bh=vf/ZNJEFQfwbvH4IaMcM+igGiBN33kARM8sQRJXjOAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UW57WzNKECp1WdziFVv1Dv2//2QN75uqmFgzIIEEfpE+4q8LlxUEyFyuvcJENLFB0NJKDc0G/LrTqvTtBMCRJf22UOWd/1D8VyWe1k7aqH4PYjhz5xxPdg/OeAf35T0kyiKhpoCcJqT0yq9IcBr0gI57RGLeNu1Ik7cQc2xIWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyPZr2cM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7b396521ff6so4140603a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 19:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722739260; x=1723344060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUNpQCo955I99Z1y4mszhTF/fpfCUHsY4sSRJl16+ws=;
        b=PyPZr2cM9ZSsJE329d3o9y2YZhjcKNSAy8hYFHeI9YrHoTJyoK8XcKAaa0CVgs5xgT
         QEEGHWcYaRFmy2h1z+D95/ZKwhqKG0AgHnj5IkTbCvS1yEEx+VAj7LXf4OUx8P/PWRnO
         n8IgpENZ/DEYdM2b770hRqPSsS+8ZIK5Fbo1/ywop8m9EEl+nitzWEKGsHL7zRK3uMA8
         ciWyZmC35474Jc5ndgkQjOL9dinn+SBDlKBnzgenlUw5xOR1u1TXQ4IvsDxMhzu4VqNt
         98WSkZM41+3PoMKbFqy4+wAuhUC6DCznFq8p0NYWNqbM9rgkVrcUf2L5maKJ2cBQL2vO
         ryZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722739260; x=1723344060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUNpQCo955I99Z1y4mszhTF/fpfCUHsY4sSRJl16+ws=;
        b=Ak2dAp9EfhcnbRT4BLVZcvctv9Wo1UlYodqLW04o1UxWK9fGDg92LL1785sLGOlsvB
         jzUzFYmjgY9fTlrZ026Pu/HaYcfV+B0NYK6nVO8EJLG5GWCMRBsWVO73dcPY7AYjRZm2
         oBlaIgoHmPfd1c8L6dveSPKibTvIrC2tt5drjtvag4GN8GliBFrK3ULJX02zdbyCosbU
         l40TD94FSHQHJbW9oOqqIPXcoRYatT05sUU/v/PzixpIyW5dj9jKeSAOq072Dgu1H/pH
         /hAXihVeizEUAhsf57Yo/+/BmIi893v2aSTo2z3WxfFJkkRLtOKyW4cTsksXSJ1M7NyL
         uo7Q==
X-Gm-Message-State: AOJu0Yy/R70OAW74ZcXU04zTceEVYIDm3O6dvtou9hPTNkgT00e0Vv5c
	yXAMz412g8YWtjCTursQjUeEpr1rtDN2EBkqBjY5jJ274uixah6cJlK35A==
X-Google-Smtp-Source: AGHT+IE/y5/51eW7DaB7x9bDcXjjM7REFQNsBV0btz1VJmS7tUhdM7vjF4ei5N2NUizVP3tNupVwLA==
X-Received: by 2002:a05:6a21:3296:b0:1c0:f590:f77f with SMTP id adf61e73a8af0-1c6994398femr11761840637.0.1722739260074;
        Sat, 03 Aug 2024 19:41:00 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfd2b3sm3447768b3a.172.2024.08.03.19.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 19:40:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mingo@redhat.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] sched_ext: Improve comment on idle_sched_class exception in scx_task_iter_next_locked()
Date: Sat,  3 Aug 2024 16:40:12 -1000
Message-ID: <20240804024047.100355-6-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240804024047.100355-1-tj@kernel.org>
References: <20240804024047.100355-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_task_iter_next_locked() skips tasks whose sched_class is
idle_sched_class. While it has a short comment explaining why it's testing
the sched_class directly isntead of using is_idle_task(), the comment
doesn't sufficiently explain what's going on and why. Improve the comment.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/ext.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 09f394bb4889..7837a551022c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1252,8 +1252,29 @@ scx_task_iter_next_locked(struct scx_task_iter *iter, bool include_dead)
 
 	while ((p = scx_task_iter_next(iter))) {
 		/*
-		 * is_idle_task() tests %PF_IDLE which may not be set for CPUs
-		 * which haven't yet been onlined. Test sched_class directly.
+		 * scx_task_iter is used to prepare and move tasks into SCX
+		 * while loading the BPF scheduler and vice-versa while
+		 * unloading. The init_tasks ("swappers") should be excluded
+		 * from the iteration because:
+		 *
+		 * - It's unsafe to use __setschduler_prio() on an init_task to
+		 *   determine the sched_class to use as it won't preserve its
+		 *   idle_sched_class.
+		 *
+		 * - ops.init/exit_task() can easily be confused if called with
+		 *   init_tasks as they, e.g., share PID 0.
+		 *
+		 * As init_tasks are never scheduled through SCX, they can be
+		 * skipped safely. Note that is_idle_task() which tests %PF_IDLE
+		 * doesn't work here:
+		 *
+		 * - %PF_IDLE may not be set for an init_task whose CPU hasn't
+		 *   yet been onlined.
+		 *
+		 * - %PF_IDLE can be set on tasks that are not init_tasks. See
+		 *   play_idle_precise() used by CONFIG_IDLE_INJECT.
+		 *
+		 * Test for idle_sched_class as only init_tasks are on it.
 		 */
 		if (p->sched_class != &idle_sched_class)
 			break;
-- 
2.46.0


