Return-Path: <linux-kernel+bounces-192241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198868D1A82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7DA1C22B15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5898F16D4C7;
	Tue, 28 May 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="epIAW6la"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DAB16D32E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897635; cv=none; b=BwpwY2Bkp/TdEdVzKsAaSy7hXJxMklDCgne0qiS9pzL09PtMn1i9ep3QTLnYJYduUIiJ/2maPksWhI2bt14sZ7lgWa4cKYzFSLtCNS8ifR9o/myHKSx43SgbKedyW0mjY8JcUynRtDV2dF8tyjjwStdMLZfOOX/Brb5IgTy6PFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897635; c=relaxed/simple;
	bh=r2qGhKgIPxmZe1bCE3EZ7bsyWeKHkaPXMLK/hUlbeWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PV3RA1Rr6rP6GU3BEpASZ69r174fLTYprgloySdQ9zNuAyX/+ZtRA8Sznz4KvZ1Pc2txcrPCI0gT+k8pc/Lkv5QNi4UgQwd/+IXsHN4a/+YM8rKP2reB5BqqJ3FFgGUpYfzG4Rhmz1SLKsYgj1sn91urEZgJlUSSxRK0uAENx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=epIAW6la; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a626776cc50so84190066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716897632; x=1717502432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd47idOkVXMEAeeUtocPVrfuJGOdG0xjElnNSFv+0/A=;
        b=epIAW6la0hQFqVdFHL7npFAImvZ6vijzR0p8KTPD3pmydhe3dMT5Wliwt3R0FMfkit
         gXxJa9uolvRsPASL5O+3PTrF5CTezDlqu4sMhF2FhjIJlBXz1yUGP8ws9eQ74q/xSYrV
         8so0khWokUK9IAY6D4kok4ffDX6YBMDPbhAgF4QHE2vvFe0eGybMf3CgOziI4ZY5VLgQ
         ifKoJAw5it0JChWQr4AnUa3ITPQQ2NuIAVhC0Ao4OouEKuOb7lNad583FYa58acIaZnp
         Y8qD5ghcm6Drr/QwerzBpZ5PX1dJ6QLpqlX+JITCSICL5TKLs+Xzjr6sgWxJDU4vrIrt
         a65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716897632; x=1717502432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vd47idOkVXMEAeeUtocPVrfuJGOdG0xjElnNSFv+0/A=;
        b=C6YqBv6/HBjwxPpXmjqeyJT9nHdCLQBgg4BEDWfE3eMMnDx3XowJbQ62doQbuDxOtu
         JH7uHHGW2f+o84LaDVtJDLe2UVW9ZISDqQiy/dKeVZwA90DCWm+cxvKCNAPw0Ru+7Xa7
         M8QPlBKdrU4vOtStr0T+jumT2AS8vA5xqYPA3iT5X04ED2ZnkvKRZ/xq7owiWujLCMNM
         E4ou9IX/aevk55hDd5LXr8bHLpHlpzuqzs8cLS3J8jdO9frtYblB/6aHJW4YyCWVSJdH
         8XvVb8WLhYv4+bkmgOhQuxPDNWSqNutM3+0m3HMOhwFRaMNfa5ontFERXjNxpTHWxerw
         Nyig==
X-Gm-Message-State: AOJu0YyomJhcDi5e/Jt2EgeTKFpGEJ5Rzev0+6tU818ufEuFvE7Gw9jQ
	I8jBiX9rQQM6hvv8V1zO91OEO/mQz/tWIRHV1wO9brNeNL8yx5Og8E1/tMh7JyM=
X-Google-Smtp-Source: AGHT+IF4WO5yygEASqtNmbAhKWOJT9TRh3VYjDi9FBpdAcuY93yYSViR3TjJhPYshCJ8QpWhz3D46A==
X-Received: by 2002:a17:906:fe06:b0:a5c:d67a:e8ef with SMTP id a640c23a62f3a-a62642d49bdmr1033839966b.31.1716897632047;
        Tue, 28 May 2024 05:00:32 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a63534935f9sm27970566b.146.2024.05.28.05.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:00:31 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] lockdep: Use str_plural() to fix Coccinelle warning
Date: Tue, 28 May 2024 14:00:09 +0200
Message-ID: <20240528120008.403511-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(depth)

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..31d7720c9b8d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -786,7 +786,7 @@ static void lockdep_print_held_locks(struct task_struct *p)
 		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
 	else
 		printk("%d lock%s held by %s/%d:\n", depth,
-		       depth > 1 ? "s" : "", p->comm, task_pid_nr(p));
+		       str_plural(depth), p->comm, task_pid_nr(p));
 	/*
 	 * It's not reliable to print a task's held locks if it's not sleeping
 	 * and it's not the current task.
-- 
2.45.1


