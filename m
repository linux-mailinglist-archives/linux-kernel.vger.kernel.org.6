Return-Path: <linux-kernel+bounces-266974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC709940A99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96513286383
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A511922C6;
	Tue, 30 Jul 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw64Tnq6"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE4518D4DC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326360; cv=none; b=Z4WHNIJLl3RGEM4AVvNCciO3vQLBwOSYyapCuxCCXBMtWBLdhHcklzBI0uWjxYt1IdSJ5RAv5cJp1CLQXv0yZKhIIWAxSmolLIkCt9C6LI8rYQCk6e1h3Qm4Ihjs4nhkfdFDylmuFljAMi0lDAMLiGQZjH2Y1FfYGZG/R31MTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326360; c=relaxed/simple;
	bh=GEPj04JmoCgXOe4WCmAyy3NgAbiGw36D79b9P5r4TRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xq9MI6cU0vSkLj/w4VILY6nKjAMrEju77OOixlxRhwyqZavuUTGobODfahOwGrWmF/ZLd0q25Ck8JZ1LW28bRdUH9O14JmehKytVWOUw4CKHuAhVSnfajYk8CTLg9ayFiyiDqi9RYIthD68SczTz1CltR4YZWmy8kX5/E/Im9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw64Tnq6; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db18102406so3075418b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722326357; x=1722931157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hsKrDsbFmiXtekqhMmrRnCYwYxG76SWUBxZQ5Lytsdw=;
        b=Dw64Tnq6Eh4UbgZhn+u/9j8NUNzrW4jspAHfrqp1fXwCHua5CmCC6BgWMYfNNLn7G8
         Kq8m3TD3tejun8u+exB99P6wEWx/BaYdq0KRfyIMsxyZ4QjIZkDmaUF5KQno7kvCFjjY
         C4SnJ1MAiLdS1Vk8WZratQi/HR6B4n92BdqLvR+/QoCL7gh+FV9SkSnVOAavue1gFuIT
         8UFhxIgK2aGwuwUPnGQC0rwynLrlFNJPx20zzi17IIMrQxwiUo8KpYgoPuuqMrRhHVI6
         GLOI6yDkugWK0OzpONSmdw9o1adkAMn3CQpxF6m6DStyzJHWh3BbCbMSX1V8IpsYfAd4
         1czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722326357; x=1722931157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsKrDsbFmiXtekqhMmrRnCYwYxG76SWUBxZQ5Lytsdw=;
        b=L7iCmMh6rjOWd4/74IRAF6dMSu1lCcM+gnmwJj9+A590u7URE8P1rKk82NDwyZU+fu
         OXB9HLUfQA2W5bpztsauj5a9U8yVSsw4SbQtjHviTExkRsAtsTo28zRq0uc2cHvsi53g
         7UIVcVq+uOvlcGPj+X6fT+X3467/cE5g9Ljc+WmVoB0JdU+D86YxTVG0EJ5wqN+tjvAL
         vKlkqYoAeCmL3OcXSbxaEG1MeQBwkZExOuPPDd+WkTre4cWjlxKieQe7ta/h4uAkkR3J
         21NcHnKb8j7CkxkuIvr55M5NJB1cHIe3YnmoAlWh4ytHWcMTm0Ww6qIt7vfb7I0wjQHi
         Cl5w==
X-Gm-Message-State: AOJu0Yw4q+gPs5iE25tVZrWrmSr3oUXRsA+e61xIjGD2lkFvRGngGLKM
	GbJfvjVgARYVc+tVtd5De+nRtLVoM3XK/yPAdPdotcATa37VVNKv
X-Google-Smtp-Source: AGHT+IFxKFvFu3SsmFJtaeNIMKdg7DSpe5vNzLXHSgNZ50E+DMZCLOz0cLjsK9a2hwFT4s6Y+fYFFQ==
X-Received: by 2002:a05:6870:d8c6:b0:254:a917:cb38 with SMTP id 586e51a60fabf-267d4d4fa1cmr10713833fac.27.1722326357245;
        Tue, 30 Jul 2024 00:59:17 -0700 (PDT)
Received: from localhost.localdomain ([36.111.64.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead715540sm7898813b3a.45.2024.07.30.00.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:59:16 -0700 (PDT)
From: wujing <realwujing@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	dongml2@chinatelecom.cn,
	wujing <realwujing@gmail.com>,
	wujing <realwujing@qq.com>,
	QiLiang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] sched/fair: Correct CPU selection from isolated domain
Date: Tue, 30 Jul 2024 15:59:10 +0800
Message-ID: <20240730075910.573-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We encountered an issue where the kernel thread `ksmd` runs on the PMD
dedicated isolated core, leading to high latency in OVS packets.

Upon analysis, we discovered that this is caused by the current
select_idle_smt() function not taking the sched_domain mask into account.

Kernel version: linux-4.19.y

Signed-off-by: wujing <realwujing@qq.com>
Signed-off-by: QiLiang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 09f82c84474b..0950cabfc1d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6171,7 +6171,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+		if (!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
+			!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
 		if (available_idle_cpu(cpu))
 			return cpu;
-- 
2.45.2


