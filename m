Return-Path: <linux-kernel+bounces-364384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B54A899D3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FCBB2E5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507B01AB6FD;
	Mon, 14 Oct 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDdSGTX0"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFDC49659
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921043; cv=none; b=MF/Nes1tucIpP8B+u2IKlQ/Uh4Il9sn3CGMXtWTsctxIfsfBhw9Qburo+PQ+/TkW/MWsngwafHhY/u/3uiPZgh1CoUzDjl6bNE/hxiGUyGKRyOXZdX89fkxyKpGK8T2rvvd6xQCehDWnJc4cV68N41XsAcFxNw+fgkVpkIPFeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921043; c=relaxed/simple;
	bh=yNo0LoVK5mIF++3tyamG3+Xd6Y2XYSv+MEfEoJoDMb0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=h0q1l/X857iZqjPv1yGduOf/Yuo7j/VMpadqX03p0u3Vd20O9mCXYZi21ukSG1vH8mM8HCX7yL1YopWDUETE6HvaB+jrMgHsockIAnYSBDKMJ09Q3sTqLFyJ8CseNE/v1X2tyZjVyiKyTTjjGf+amxIKCN2UKkHu7acsoPaaqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDdSGTX0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso3035725a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728921041; x=1729525841; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/IeKJ6LCIt10YFIwpbHRUPhtehKfsUr9oCaSW852f3c=;
        b=SDdSGTX0KdWcsb0gmshEJufRgPgOoNMRNg9bf6y1yrEjXV/XaIMVOYV4ZupLsy0mJ1
         O7+7XiV8ao6Ke2AOl0n+iyPCns/atDzpbU06f8YFLEaAmhd0xtjHUdJUNjNpFQdkEX50
         AAompuavIRQ59sxR/Bu3dFFtH19DhNJvZP5W/QrOOufy0NaPf+RRA7PEijPZ3acQxh+R
         yTncth3L+yY/fYB2nmgHvP+VZiFCcz32wfY/CJ7YOs/aKAZbeyqr8t3gDIGg8eZ2Bbyi
         xlW9YbTZ9HsZaoFK+wX5hpV5V+TiQNo2ve5dcV9nvcP6JPYmWGVJ1G0s9WnvDlaps3ah
         9fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921041; x=1729525841;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IeKJ6LCIt10YFIwpbHRUPhtehKfsUr9oCaSW852f3c=;
        b=FUn/+ejGiDM4bavF//ZMQdE0RZkR2iYbMLFlTNh1wpDxr5Ol6uDiDXxmfY+90xyvIa
         hAK/D+HC+O8FH/PIPNh54MujJq00WmOZkm9xk3NtiBG4wyZPvHlWBdXJ2nT1GKOLZhGS
         3dTMDoZDAu9r5mJrtx2l6CttmyneoY/kC9nn6t02urgdzKNTEbMAeAWyu4QV4Tk9dMFi
         uQJp/2XCQgmDPb/U9ghBo5a6U8PlWFZyYbemrMqX79MrEmrN/bCrpac7QqYOzXynlso4
         RTdoszmOprsfK2rHe+PNIEh5foEf2b5MiJ6sLmGNGqZWGWdJgCZQLYnUJupc6qD2XXCm
         oXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9d1noyDXg+DIF7DT4laBIhVnCRywQMn8cfGQjKcoTIOgT65mtNN3/hhWZsshW/yLzB5ctr/EQ2I/klms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyey39nIKx3KVGMSE8l5zrQF/+2QuVP0lc0AEgHYZBXct/0ZP1p
	nvSHbfYjAyqWRJtVf+Q01e81DNospQlH0rGv7AKbqMKHOghrSiSno4PBV1GI
X-Google-Smtp-Source: AGHT+IGrKVL5MRC+UUkabYrkNtXSulGzVxQfwobHsqEVxN+/SId+QfTvznZnCD7QJWOY4EL7SZmKYg==
X-Received: by 2002:a17:90b:46c2:b0:2e0:f81c:731f with SMTP id 98e67ed59e1d1-2e2f0af2ed8mr14578711a91.24.1728921041412;
        Mon, 14 Oct 2024 08:50:41 -0700 (PDT)
Received: from [192.168.1.4] ([139.226.29.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5dd38c8sm9098417a91.8.2024.10.14.08.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 08:50:40 -0700 (PDT)
Message-ID: <3a0c974c-41d4-4203-9ffd-f2ec4da898aa@gmail.com>
Date: Mon, 14 Oct 2024 23:50:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Benjamin Tang <tangsong8264@gmail.com>
From: Benjamin Tang <tangsong8264@gmail.com>
Subject: [PATCH RFC] sched/fair: Rename vruntime_gt() to field_gt()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Since commit aef6987d8954 ("sched/eevdf: Propagate min_slice up the cgroup
hierarchy") introduced min_slice, we can update min_slice just like we do
in __min_vruntime_update(). Rename vruntime_gt() to field_gt().

At the same time, we can use field_gt() to replace entity_before().

Signed-off-by: Benjamin Tang <tangsong8264@gmail.com>
---
  kernel/sched/fair.c | 24 +++++++-----------------
  1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b9784e13e6b6..598a7d38be06 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -541,16 +541,6 @@ static inline u64 min_vruntime(u64 min_vruntime, 
u64 vruntime)
     return min_vruntime;
  }

-static inline bool entity_before(const struct sched_entity *a,
-                const struct sched_entity *b)
-{
-   /*
-    * Tiebreak on vruntime seems unnecessary since it can
-    * hardly happen.
-    */
-   return (s64)(a->deadline - b->deadline) < 0;
-}
-
  static inline s64 entity_key(struct cfs_rq *cfs_rq, struct 
sched_entity *se)
  {
     return (s64)(se->vruntime - cfs_rq->min_vruntime);
@@ -797,18 +787,18 @@ static inline u64 cfs_rq_min_slice(struct cfs_rq 
*cfs_rq)
     return min_slice;
  }

+#define field_gt(field, lse, rse) ({ (s64)((lse)->field - (rse)->field) 
 > 0; })
+
  static inline bool __entity_less(struct rb_node *a, const struct 
rb_node *b)
  {
-   return entity_before(__node_2_se(a), __node_2_se(b));
+   return field_gt(deadline, __node_2_se(b), __node_2_se(a));
  }

-#define vruntime_gt(field, lse, rse) ({ (s64)((lse)->field - 
(rse)->field) > 0; })
-
  static inline void __min_vruntime_update(struct sched_entity *se, 
struct rb_node *node)
  {
     if (node) {
         struct sched_entity *rse = __node_2_se(node);
-       if (vruntime_gt(min_vruntime, se, rse))
+       if (field_gt(min_vruntime, se, rse))
             se->min_vruntime = rse->min_vruntime;
     }
  }
@@ -817,7 +807,7 @@ static inline void __min_slice_update(struct 
sched_entity *se, struct rb_node *n
  {
     if (node) {
         struct sched_entity *rse = __node_2_se(node);
-       if (rse->min_slice < se->min_slice)
+       if (field_gt(min_slice, se, rse))
             se->min_slice = rse->min_slice;
     }
  }
@@ -963,7 +953,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq 
*cfs_rq)
         node = node->rb_right;
     }
  found:
-   if (!best || (curr && entity_before(curr, best)))
+   if (!best || (curr && field_gt(deadline, best, curr)))
         best = curr;

     return best;
@@ -1186,7 +1176,7 @@ static inline bool do_preempt_short(struct cfs_rq 
*cfs_rq,
     if (!entity_eligible(cfs_rq, pse))
         return false;

-   if (entity_before(pse, se))
+   if (field_gt(deadline, se, pse))
         return true;

     if (!entity_eligible(cfs_rq, se))
--
2.11.0

