Return-Path: <linux-kernel+bounces-211444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57B9051AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B0BB247F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6B16F0E4;
	Wed, 12 Jun 2024 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N19E3IGY"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E193381D4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193267; cv=none; b=nu4fIeTtgjeU0KLmpodgUujH2+sWsMjEDXLtI4MeoVGMSp5wkSrBY6X3K/rH+CiNVb5MpSV40OA4QfCZcXgBo2zG0PM3t3chE5GqP1iGf5pMIFpAJkEz9otoJRAwHirSNH5uM1uqXyk4lkDfGJ+yGBOrj4tFtYHTgWfWxigp9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193267; c=relaxed/simple;
	bh=yQ9nVZWMADlJlNVpW4Xg5FcuqB5RW/gA9gxat89msBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kTJLdaxXF9wo+mlRKO6sdgBZ9eSLtQ0VeGVnox0hzdEEpa6Eh7wT+kYVGAh5CZ4ghjRQC7wLmgBHf2ELWWH9s+7p43hYQ5zD9etY5SlfILZGmEnpoZdbMpTOAi9GzQbMpozQ9C574UVuLMl1/pZ2X5DeN4+y2QUMK6Y9xwprVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N19E3IGY; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9a1so3209818a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718193266; x=1718798066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAXgHWrS1mgeDa6+LCBQEaanBVXAXlIttS5LPoYf4c0=;
        b=N19E3IGY2te8ixGWuLAWR6las/xaWVSOxTmhmr/rBw463TVvNf33poKDF7OyaZYrs5
         QayPoryWFT+zDqm8at21fbROxDbN5Yg9TRQz/jD8OH0wfO8KfTcESPXP0k0zbWNnuFkE
         kMK+Up1YHhrgjxk+wzU+jmz9KdRVcGPSfLqekmeySE6iD3tGv/RNHx/ZqzK/1Rr/NoPi
         80rLZsfMkRaUfN7P95bQnc2zfsSaPnABvin7TWZCQqzRH69WsoybwlECFd4CJ3bnvQDJ
         iOKSy8uAuQNzykeL/IikiNsvWnNJ2Q9xtlq1bXJ3Kq/8DNcSGTGWO0Tg4mM/3YmMt/WA
         zrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193266; x=1718798066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAXgHWrS1mgeDa6+LCBQEaanBVXAXlIttS5LPoYf4c0=;
        b=ARc6MIMwHbjUgT0GBScMs61GJnElljO/WTexRj1szfYQcSJrjOtQB9AVBT0sr+3k3o
         cCp+NnMcDD5572iLa54BQ3lxZGy/r805GPUVbjxTcdUJAxWVFv1Q1cjQlQcOx8ARy2Un
         UnrwexyLtm6wOyH2Uq1nu3EYi2jOdj0ivyRcS9xnTX4khCR8d9RAocqTFt3QQP1gf7HH
         8W9lcUC+Diztadjr1TYxUi5D3nD4ro4LkJt7WmqGY+rqwQzFm9wQSl7ig8kZGjpzHRpz
         oM0z9NmpFxWLGdHvNXxMpfGuZ8cp950YuMAZ75510STs1S3zU97U1Cdb4Z3kItxkhHLC
         95nw==
X-Gm-Message-State: AOJu0YwhaX1NqaX0lJg+xKNFF0tdy9DPAYiFlLbVbrLeaPxKruMjLzkI
	yNymcyfTmP/pKbpznBPp8nHjXAdkE+i2uisA13h3sDZUm6suYSTC
X-Google-Smtp-Source: AGHT+IFk19S29bxPOsu+7Vuhx1hRrW9TEaNEvwVAM7eheDVFdheZ9S89ysSDTedj1/SY89QZI4e1dw==
X-Received: by 2002:a17:90b:1001:b0:2c2:faf7:67a0 with SMTP id 98e67ed59e1d1-2c4a7624aa7mr1520726a91.16.1718193265634;
        Wed, 12 Jun 2024 04:54:25 -0700 (PDT)
Received: from A03-R28-I229-36-543TLP2.JD.LOCAL ([106.39.178.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75deecesm1529373a91.12.2024.06.12.04.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:54:25 -0700 (PDT)
From: zhangwei123171@gmail.com
X-Google-Original-From: zhangwei123171@jd.com
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	zhangwei123171 <zhangwei123171@jd.com>
Subject: [PATCH] sched/fair: prefer available idle cpu in select_idle_core
Date: Wed, 12 Jun 2024 19:54:10 +0800
Message-Id: <20240612115410.1659149-1-zhangwei123171@jd.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhangwei123171 <zhangwei123171@jd.com>

When the idle core cannot be found, the first sched idle cpu
or first available idle cpu will be used if exsit.

We can use the available idle cpu detected later to ensure it
can be used if exsit.

Signed-off-by: zhangwei123171 <zhangwei123171@jd.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..653ca3ea09b6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7341,7 +7341,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
+		if (cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 
-- 
2.33.0


