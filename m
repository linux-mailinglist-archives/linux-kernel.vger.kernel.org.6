Return-Path: <linux-kernel+bounces-535880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C7A47874
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB370171B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F12227E82;
	Thu, 27 Feb 2025 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Bn4dk0u/"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991C225403
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646729; cv=none; b=J/Rh+4ZlBOTA5F2VXpv5+ApN5Gr0yzqMeu3Bhm5KOJVwd6n9sdichLrrA+sQX+AkR9OxTh9GUEBegJivBCX9cb/M5HkCa1iHfPE1SLoXMaMflQFeXj24x4XS0aIwYwzFrB3Bew5qHkemBMjYbnLllWULnHMZ4sCSTGFuM48ubvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646729; c=relaxed/simple;
	bh=F/pyCMYg4GG1Ui6TfrD+lKedEtNPLQ3vrko0EKiXXxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQzQPS6CY2ZwSks1laEtLThSVtfsSs5RsBd2hAIhcPp23mRetFGJiPsYFADlUkn4MtfwJaxyvZlFpefrNfXMq0sKkrKjunYMS7AJUrvy190/8Memrfo2Z4vM8TguIYzfZU7xUTLDLVtvLY3Yp62tJiGt7jbaidPjyLv5+usjYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Bn4dk0u/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fe99d5f1e8so179680a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740646727; x=1741251527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RztYTcUCOGuDwZNpRIhVRzmvJ/fvvI+8zN2ekrhaS+4=;
        b=Bn4dk0u/8ivw27aO1Yh+h6cQIGDG1gje1vg6i/1TK5hdoVrXxWRvh3HWYvO93g4x8J
         6IM11yyI+J3Aq5yvBliY1EMlV+ovjAy30gKppx4SInCiZWhxcGM2TYeMhoZKRbEEvoCx
         Ho+/pZGk401WZ4Dz1RPQ2l12TPvUg+VN+4t/ulkkJhGKlNC7KY5i4LDoa5mpBTBFh1WF
         mNVDwi+rIZXZB2uyrWkhq31KIKPahpKepmTbuGkLyIgRrw3amFhRGq08DRBelhgEjT9N
         GkLyQ5arAIw+XodY9xWdRs8K2MNRfm8gg9GFJJaerx7gBPNpqXYGo5obHC7dRJSFctei
         dl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646727; x=1741251527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RztYTcUCOGuDwZNpRIhVRzmvJ/fvvI+8zN2ekrhaS+4=;
        b=h1E/Nmzwt2IYCyt526ThPTIzDU6m1Chg150jEuNCDJ/jA63tBRRzbaZWFwHGSbDx5t
         5vfBndHfBKyR4roDIzYzxpeJelC9Ih6VO63tyBJ1yIGx7IvMcFV+rNO1yJfAJ02ushKW
         DH15FWWv7BzHHSaGx+JL603Ijno9hr333WuGoeEITi3DFp/BLYfAini5bTBpEmXoWXKu
         U8bUXVSw3DVdtOCQvawFIld3QFOnrAW5YfsI03fBZKVMPjHFmlr6iWSeqe22MvbxTeBi
         7Ob/amcHBZvANMYvQoJd4zgJT+On7kah+SPWP2qIREyQdrCb8OtJJDkh2fWLYifKkEev
         8qdg==
X-Forwarded-Encrypted: i=1; AJvYcCXZzVLMhkb1AztVhCbqTF8tJEz16sPGFgzu9Pl7F2Mg59fc4Ec4jHKcmM+aET49M6KPvEpXhLeLzCSLSps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcxF94Iaspt8RA2OiD8ZE+0swuUY/QtRoiWoa0g7jdU6xZ9FLh
	VPRyFxitCStK6K5dHvwCaiJx4rNGsIrEM2ej2YYLj3HcNxI5001wriQQcj9AMohSSdLkrRSBAaA
	RTIo=
X-Gm-Gg: ASbGncuA2invPavs2v2Nli7YO5TXWMQswoJpQJHFRXrPgSR1/2xbIWltHL7m2eia1Nb
	YBw6BbNpMDTpHEqx2hIslDryZx82aflZCWc9VRE5xmjZQV/lYzsf2tVWE8RudKNWLSxMaVulT/G
	8PNQ1bSVK/+VB/5JEseoPMku/rn+rzhzvyr1Vo+MVLr+hA8gww1Mam4FZQqRMcHaEsx/NLCe9gz
	vzlnGfd9FnuBgrcd0nv7FQL63p8nn5wocnwBf684A4AXXh4OQftR0DpzoV/Fb8/SYJk+h71qa/u
	NZ1fJWYLtnpol3VZwZwF+M0DnQtMtIsYmU0tlTl8LLPMZtx9fhlzoZ9szzubpTta
X-Google-Smtp-Source: AGHT+IGBcxmV92ELKYzYWz+8wuGW9jStlrBsTQY/XdKwVGVAsNEmyFogVo4YoEVfDN30x6AamJHDGQ==
X-Received: by 2002:a17:90b:390e:b0:2fc:25b3:6a91 with SMTP id 98e67ed59e1d1-2fce7b014b9mr16107629a91.5.1740646727410;
        Thu, 27 Feb 2025 00:58:47 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825ba9b4sm3112759a91.12.2025.02.27.00.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:58:46 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH v2 1/2] sched/fair: Do not let idle entities preempt others
Date: Thu, 27 Feb 2025 16:58:12 +0800
Message-Id: <20250227085815.18131-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250227085815.18131-1-wuyun.abel@bytedance.com>
References: <20250227085815.18131-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A task with SCHED_IDLE policy doesn't preempt others by definition, and
the semantics are intended to be preserved when extending to cgroups
introduced in commit 304000390f88 ("sched: Cgroup SCHED_IDLE support").

But current implementation allows idle entities to preempt each other
on wakeup, which seems not behave as expected especially after
commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
so fix this by explicitly skip wakeup preemption for idle entities.

Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Josh Don <joshdon@google.com>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d042e94a79c3..aaa9822e9562 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8795,8 +8795,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	pse_is_idle = se_is_idle(pse);
 
 	/*
-	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
-	 * in the inverse case).
+	 * Preempt an idle entity in favor of a non-idle entity.
 	 */
 	if (cse_is_idle && !pse_is_idle) {
 		/*
@@ -8807,7 +8806,10 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 		goto preempt;
 	}
 
-	if (cse_is_idle != pse_is_idle)
+	/*
+	 * IDLE entities do not preempt others.
+	 */
+	if (unlikely(pse_is_idle))
 		return;
 
 	/*
-- 
2.37.3


