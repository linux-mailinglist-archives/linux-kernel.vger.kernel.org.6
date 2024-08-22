Return-Path: <linux-kernel+bounces-297858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CDF95BE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FE41C20D20
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9928313D50E;
	Thu, 22 Aug 2024 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkpZmcf6"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112E1CDFD4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724353356; cv=none; b=sj22bKMXpWn7VNvbWReWBOxNgc0/MidMI69NlWlZr03b5qXctC+uIwoEQEQzmIJCVuo71xz1DRTjKeW7y8vv8Hr3vZig7HxwstPfen4K0PpWCgGY7nWyFncPvSBBI9yeNk5ckoX1uBcVgHuCpVGt/PBfPwQ2pfusbkM2U4KrAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724353356; c=relaxed/simple;
	bh=awXhE23RvS3i0Ju2m5YQqEoM0tX6hS4c4GK9LQ57jBY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cLwSzTLzFCDBnvgj4blPQNQltDw/KkLq0Tk23oRGtKJhthsaYPfQ3pCO1WnlBEz11YIOgz/KWT+fIVnaPgJ3X5HUx06vsBjjISjR35qLTHH2WNA+zd+Tz1vB5xc6dZSsMKIbfpxHTRu4ZCXNw+/rQZ/OddNYZJe+APCn1dp/ukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkpZmcf6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7126cd1427bso942618b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724353355; x=1724958155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v1CB4OWu9jLr1XGc6AcgEFWqWefQoqHe49pDpQruJRk=;
        b=FkpZmcf6geDnecz83c6Ne2J5HEGLLf45ZB59gwXdOZ1VlR/sQIebD36z6ZL5xHQ2DC
         nZm6ulsKxDc1j304JDsvCdFZljElWsMJXemqF6b5Y+n2XYPfLiTMDWF/DhNQjcBZ7EoY
         BUlEvyeQmEtG+FIbCrNS3JscfRQM5mbMYPs2G6B/hqS08F0lMMD2lMVrumMAV6iPSIqS
         hcxYCYgQVRv1k/bgBwNEhv5AIfUlzuOUIKV2eqX0HyAqTXhTLfLNNToB+uP84zc7Cm4E
         JUTZPINW+ZyHgIhgfrVQzFMi1wtReO2xrKhcEVUms5/TqOczkw3li5jvUpWNeGpM41Xl
         mgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724353355; x=1724958155;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1CB4OWu9jLr1XGc6AcgEFWqWefQoqHe49pDpQruJRk=;
        b=demQIue73Inu84oz1zq70oUYrHXZ8nqrtTtnllDTHgU997KPA3iuNqIKMUNYaqVzlz
         /L4fJlxswXtmsG/OPZIR/I562pg6LHI389plzP74Dg+WV/jx3h89m8jvLq5Xfzmob0LQ
         J3kD4NjjxJSCSG/E9essyaSPHC3Uo/ixcdj2RiqeqtKQ7LGa5+jM6zazL3VHjrOmd+bu
         CG77EoTic/jPsjLwWt+NBbHyw31k6fP8M2m88Xz1e2NKaou5ravWgu4XelvSpHJKY3Ds
         i7w4hhlUgdjhT2+t5631LI0g/l98nNMeryXioh/8M/Z2Ts9yFHFmxf397GWiRHyFuXUY
         u6TA==
X-Forwarded-Encrypted: i=1; AJvYcCUE+EtbX6Tr+kU43do3rHBcNIh3aV+SGRRL+89jRoAhCnKhJndW8LIMi28gnp4OfPEKVp0eNRwVKM0/btI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvStnyT9h6tn4rr+TVGHldVn76szcK3IPgHLC5GT1ro5nTsBz0
	Y3nynEQbjG0z9P4hOE2/3sVIyR+AKCvqwn9V89dPIq24lDbrb0Ay6S6EGOn5uXMsE3shd7iurK0
	OgnfrltguGAR8krmTHID9vA==
X-Google-Smtp-Source: AGHT+IGNdguSmKfFvWmrW5xHYmAzGjP/WhbBma/sgkG8kRArpJKCn20sDSogDNG5Ix+pUK/+6p4tTsFNbjK6bmd4bQ==
X-Received: from peternewman-us.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3dcc])
 (user=peternewman job=sendgmr) by 2002:aa7:860c:0:b0:70e:9e1b:1a83 with SMTP
 id d2e1a72fcca58-714436323famr902b3a.2.1724353354433; Thu, 22 Aug 2024
 12:02:34 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:02:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240822190212.1848788-1-peternewman@google.com>
Subject: [PATCH v2] x86/resctrl: Fix arch_mbm_* array overrun on SNC
From: Peter Newman <peternewman@google.com>
To: reinette.chatre@intel.com
Cc: babu.moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	eranian@google.com, fenghua.yu@intel.com, hpa@zytor.com, irogers@google.com, 
	james.morse@arm.com, linux-kernel@vger.kernel.org, 
	maciej.wieczor-retman@intel.com, mingo@redhat.com, namhyung@google.com, 
	tan.shaopeng@fujitsu.com, tglx@linutronix.de, tony.luck@intel.com, 
	x86@kernel.org, Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"

When using resctrl on systems with Sub-NUMA Clustering enabled,
monitoring groups may be allocated RMID values which would overrun the
arch_mbm_{local,total} arrays.

This is due to inconsistencies in whether the SNC-adjusted num_rmid
value or the unadjusted value in resctrl_arch_system_num_rmid_idx() is
used. The num_rmid value for the L3 resource is currently:

 resctrl_arch_system_num_rmid_idx() / snc_nodes_per_l3_cache

As a simple fix, make resctrl_arch_system_num_rmid_idx() return the
SNC-adjusted, L3 num_rmid value on x86.

Fixes: e13db55b5a0d ("x86/resctrl: Introduce snc_nodes_per_l3_cache")
Signed-off-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v1->v2:
 - Squashed blank lines added to linux/resctrl.h
 - Reviewed-by Reinette
 
v1: https://lore.kernel.org/lkml/20240722204611.3549213-1-peternewman@google.com/

 arch/x86/include/asm/resctrl.h     | 6 ------
 arch/x86/kernel/cpu/resctrl/core.c | 8 ++++++++
 include/linux/resctrl.h            | 1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 12dbd2588ca7..8b1b6ce1e51b 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -156,12 +156,6 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
 		__resctrl_sched_in(tsk);
 }
 
-static inline u32 resctrl_arch_system_num_rmid_idx(void)
-{
-	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
-	return boot_cpu_data.x86_cache_max_rmid + 1;
-}
-
 static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
 {
 	*rmid = idx;
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1930fce9dfe9..8591d53c144b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -119,6 +119,14 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 };
 
+u32 resctrl_arch_system_num_rmid_idx(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
+	return r->num_rmid;
+}
+
 /*
  * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
  * as they do not have CPUID enumeration support for Cache allocation.
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b0875b99e811..d94abba1c716 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -248,6 +248,7 @@ struct resctrl_schema {
 
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 /*

base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.46.0.295.g3b9ea8a38a-goog


