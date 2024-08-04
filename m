Return-Path: <linux-kernel+bounces-273662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA35946BF5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 04:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5661F21BFB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03878BA4B;
	Sun,  4 Aug 2024 02:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQu42cSb"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EEF7494
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722739257; cv=none; b=PzWGXcdOaiF3ZtSXO2VI6fVPS24nBSftDN5WNq7S9h82Q+MwHiNXPzcsC/b5ady23/BUdt76WVklTfohK3Y4yEl8Mg7qXUwz0iBux+f4SIW7p5i5/yg6YFDjNatMRaPPLMtarVpjgPUYosy9MdOoBCbrhBwrZyg3dWejA+KJXik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722739257; c=relaxed/simple;
	bh=uUh/QIxr6vJsVN1KfVp4pd+1zTrSeNAgZkX1miQB/Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyh7w6De7pi5NoLoujuNdtDNuR45Od85ePtB6P0F8C+VsXVevftYFFYNbh9uxr4wc3wPwuS1+KDXalEqRpcvsn8QHTdqOWVRknLw7BukZoEV9NTQvep+JG2XeyKb5v9DGSyLjso0wv/5SKQFLEyUzAAiCMU3zjwkDyRtlq5x+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQu42cSb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso8135549b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 19:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722739255; x=1723344055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q76mlaSdXuo4CDSVWc8lZaP0zGRz6esPqIsDNNA7MeI=;
        b=gQu42cSbz0HBHXjV1gdp2uAfn46tB5bla8Md396EPgNtaqXIGBHzQTmlZtUHSfZC5X
         r0bmmDBp5WeHkwM3f2zMK6+IsNVcat3OLyboM5zNvRz6sicwVz8okqxTyNgcOms2UDyA
         06XVRJehA8rE8Qv/EtzNEWig4hfGoMni6Ute3/ya270iwwwQEMlGedod7gkeK4xNu1b2
         DJ/SzHFuJhKCSWs5j0Cp6F5QQW2MGOZbZKIBO5SgpaRfLigGc298uBQ802LLg3uik1qP
         b9UC5TRx0QZR6eukB8OBcSqaqR9fWeSk5rEKXYRk95GVc0wB7YESo4fIM/AHbeL5vxbC
         pIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722739255; x=1723344055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q76mlaSdXuo4CDSVWc8lZaP0zGRz6esPqIsDNNA7MeI=;
        b=iH5ZG3HGVBwjjGDpoGUJq7Na6qz+pi0kxJukxEqtEwnQh0oGK9TF7UgfggQG5XqGdB
         c5306uP8QcdQkiUD9xDJiLc7BRaKlS7jyncNNWqMSheAeHjPZNo/bELq2ZIQnMpHtPIC
         P4JrBMF4ww5QuqBSEdt17mGPO5yfcY+q1ATOWNod4xr0zyST0eRGTkvL2k5bJnTx8kc4
         GQTVkGhrhQsnBpHn6vkhwJipM1c3pxMVAEMz9ztIN7o9tMNPY5PhLhX6LJXDCyQeE9fR
         wSOZVm1wCklQsX2b4uqUM6+c8bKN1BkKRjtp30X503FOTbRZ019Sq4E9RloxFHSjUp7j
         giUQ==
X-Gm-Message-State: AOJu0YwD1QCFsCNvuVegr+DVIA17Vr+2TRhv0s/KcJ3e29ZD7aKV6MYH
	RB5eMcbx7jpklsJ2K3ih+UbZGkYKzdpMZY9C6FVdLfgj4Xt/gCI5m1Wb8g==
X-Google-Smtp-Source: AGHT+IF7HQRWSw3poa/9/YUi4lMNis5abblNCYmD5oCwo0+0P/A5UxbL5ZYkFgj8QLcvMKzaVWFsqg==
X-Received: by 2002:a05:6a20:7f8e:b0:1c3:ce0f:bfb2 with SMTP id adf61e73a8af0-1c6995aa7f3mr11051559637.23.1722739254963;
        Sat, 03 Aug 2024 19:40:54 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdff69sm3344210b3a.118.2024.08.03.19.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 19:40:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mingo@redhat.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] sched_ext: Add scx_enabled() test to @start_class promotion in put_prev_task_balance()
Date: Sat,  3 Aug 2024 16:40:09 -1000
Message-ID: <20240804024047.100355-3-tj@kernel.org>
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

SCX needs its balance() invoked even when waking up from a lower priority
sched class (idle) and put_prev_task_balance() thus has the logic to promote
@start_class if it's lower than ext_sched_class. This is only needed when
SCX is enabled. Add scx_enabled() test to avoid unnecessary overhead when
SCX is disabled.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7994118eee53..0532b27fd9af 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5836,7 +5836,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	 * when waking up from SCHED_IDLE. If @start_class is below SCX, start
 	 * from SCX instead.
 	 */
-	if (sched_class_above(&ext_sched_class, start_class))
+	if (scx_enabled() && sched_class_above(&ext_sched_class, start_class))
 		start_class = &ext_sched_class;
 #endif
 
-- 
2.46.0


