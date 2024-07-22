Return-Path: <linux-kernel+bounces-259371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD279394EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72795283A93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7538A28DCB;
	Mon, 22 Jul 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkDZOqkI"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552DE3C6BA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681195; cv=none; b=kTSDh6OU0ZECAh/S+k/9IWCAuD+yGXgMDOYl0sLUb/Uixsq/HlKy8+UmBdbhP78oIhIQGSEygFzcHXf3kKWiIDd3DxeJivJeDFZCTMmblV2koZLhRjK0omUCo96tOS7IpXl/FvplkIiLCKyYQL+K+q3FZqEaMeWVX62IU1DZSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681195; c=relaxed/simple;
	bh=0p/5ngv6XCO83taddH9u5RDAVRbGDvsU173BdbpNyWA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZmWa13vZ6bQxa2C8p6xji7HGYglJ8uC+mhL6nwhIbwI+jZdm/Thmpk6j/8BdzR/WfvsSwuHPLeEUgaUuu6iyBLSVGyCkXNyhiKhc2vhuchmiQkq4yMPSii+8z2B0ymmghglTw6SisGLEMyGWtQuN5QlvPZhl+1B1rs7u8kK5VgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OkDZOqkI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70d1339c4c2so2433480b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721681193; x=1722285993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pdb7JuYkQVZLHjYJy7/Pp9N8EudoQcGMvd3VIzYqq/g=;
        b=OkDZOqkIFUne/8ubqTSfh6qioCqvzrgibeBZKBBD04JosDNUh4/7ecRHwVoUOtUsyP
         7z6SRnZf41X3luM5wQVJ3d9e+uLdBszj/0+6FrW+82EtUNIStoSFxvoxxRZ6j4TrN82N
         VbzI8LTLG0sDJnZiBww9YiYKUV2yDlG856XkGhWYLx4I/yyTIZy1zPVvQNncufsYsgvu
         F7LzK5IbDGS408CGNQZYJMobwvTy/MSqN6bh01NZg1YDhSQh4mOnLNo/Vv3vziOmEkLS
         wnU96rxF7pV4mfAiRfbwTmx1ITVHpARz1mj/lSB71HdVxNv09TZKj+0Xr9Ke0QtbBzWQ
         AY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721681193; x=1722285993;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdb7JuYkQVZLHjYJy7/Pp9N8EudoQcGMvd3VIzYqq/g=;
        b=tiOrITfd4xDKw0YfC+gXth0qTclPCTJeVjshfBNUAaizsDxw66e3QpPWh2Cn8tYZBy
         ugRW9xgBkskon0+CWVvxGcBsVpafK55iFu1byHyvN8GEoha2SWPsNfH4OLy93UL7relM
         5ZvfF42I6Q7zY4rMJs2rAZToixJON5i7YGk+tlj69hKOAsCIXZhBQiSIkq2Qg/6tHLYE
         MqtPu3OFtjdZO7zq98xJNTTeD9/HvfBW2MiKVvMv55Vuz7jf1Lvtmo4AgiDulrJK4tUH
         5VnvkjTGNdcZ96AdRNJiR10l7/eqhbSJmpiTaIetLSBUsiBNdrh95FprT8GdNqvfoOs3
         qJqA==
X-Forwarded-Encrypted: i=1; AJvYcCUXchI5YyMLMfIBqW2XxKEa5P8Rr/DmLUVJZihOpkB1oxhbjw5+rCYqFRhvnB7gl5zHABViQfBX7G4Sdct/bwL2oS+XjALbSGFWjh8M
X-Gm-Message-State: AOJu0Yy2XudQE9dR3EdhkxFBSUocASMIwwsnsBOmnxliZiHpCzmY50pO
	N+B1winDcnBjhJA4+TJh2t7N77ZdlztaEA5/lc56Fx6imNVDhd+eMH8WAd8NMdlOIZjf2UJNw1i
	0gXx6EfgeVA31q7TbIHpeow==
X-Google-Smtp-Source: AGHT+IFA3bkszRtIYCKKkuY8p4m3ZyHzNIjtlpAXdTSumNCIxUFKb6bkDapHkQMNVHfqi9J4ZqWZ/Iw4e7YrdojCBw==
X-Received: from peternewman-us.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3dcc])
 (user=peternewman job=sendgmr) by 2002:a05:6a00:4f8d:b0:705:27de:74e7 with
 SMTP id d2e1a72fcca58-70d3a8520b1mr64042b3a.1.1721681193245; Mon, 22 Jul 2024
 13:46:33 -0700 (PDT)
Date: Mon, 22 Jul 2024 13:46:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240722204611.3549213-1-peternewman@google.com>
Subject: [PATCH] x86/resctrl: Fix arch_mbm_* array overrun on SNC
From: Peter Newman <peternewman@google.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
	Peter Newman <peternewman@google.com>, Tony Luck <tony.luck@intel.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, linux-kernel@vger.kernel.org, 
	eranian@google.com, irogers@google.com, namhyung@google.com
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
---
 arch/x86/include/asm/resctrl.h     | 6 ------
 arch/x86/kernel/cpu/resctrl/core.c | 8 ++++++++
 include/linux/resctrl.h            | 3 +++
 3 files changed, 11 insertions(+), 6 deletions(-)

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
index b0875b99e811..43ac241471b3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -248,6 +248,9 @@ struct resctrl_schema {
 
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+
+u32 resctrl_arch_system_num_rmid_idx(void);
+
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 /*
-- 
2.45.2.1089.g2a221341d9-goog


