Return-Path: <linux-kernel+bounces-433571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33689E59ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BE416DAB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F021C9FE;
	Thu,  5 Dec 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p89gLn4p"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848E21C9FB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413141; cv=none; b=qHT23FO0mQeDXFQSMVEvFVtyhL1BCUXr5vqlY/mB3nhaK5q1l2tmMgpe7yYhmHvgwz0Gga92jD57BBSRLcskW123voXsmWy9LBhYZ3r3E86WpoEL4NFA4n1Day0lyrDgGltctAIq555Jn2zWRFp471kXlNoi7RgrT6M+hfeS504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413141; c=relaxed/simple;
	bh=eMLU40m6yyS+3MA74EptfLALTcQsAs0BQkogJ4+fbCE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OW2sPjkTljnRk44tSxGrghMiKwIm7b8Mg8rFthMno/xSWuXjIcYeDy1trGGvB42ItxXrAzDMMg0keSct76kcA2BiiUJLevH+lzKY6faiH9PcGgzGFVkuPSsZ0yIVhW9bq8nUlatftMUDCaehBYT/r2xu6CWfd4Y/+Mk/1nWr/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p89gLn4p; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4349cbf726cso6877555e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733413138; x=1734017938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MP2YmTkp08hVldxtV+ae1BU9J2EZ8GxsjUzKwg9nivU=;
        b=p89gLn4pNcPHi1zloAamJnOHsxthFfU4orwY1+ydYSy22MT0n9Z59LtYvMAdT1PZEf
         EPkpl+g773lejm9/un0KmQWiE2WvOXtqyZMmO9untrD0y8nfG5vcSPtsM8qa+eB3pw1h
         7jYWaTfUss7b6kUJT9DdnInJdNQx/pHhi0Q08T5kL0nYhaJw0WZe0gSPRjhfpVbwrCjv
         UBlBBPvJ6FEvtbgBeIfgQFwbq7+XaXzmuWDeMaIvVh/o5MUPbhJUqYRf4vFsca1vS/yu
         akPvPIogBpWeSnFc/C+EjFjI57+s8XyVTN204St6AxVUObtOhQ1JkFBzVSeScrNNgJqj
         Eq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413138; x=1734017938;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MP2YmTkp08hVldxtV+ae1BU9J2EZ8GxsjUzKwg9nivU=;
        b=Vy+Tj4im1QD4wp0ILsW1jgD67mkihafVh4Auk31WZhIxC/74PxI40mz6WnrTwALzvm
         bp6c3de/t0RWyc0KGJ0EbvRnMZjrj+VWeIeor5F91+NYQG44CUOk2p712uDdmzrDrjR+
         5hTgVt4ce17kmRt679PnKZ3dcAceF/Bfn6fohcQzb+97lhTS28AFdsTRp1Xj022zSls2
         vJ2GG93siDkPt1epMgjsC16TVna/fxJYQ4eEIc6Fnl1RJcAjqjud2wdlBQXbNR6Iyljv
         yFLSYSw3zilMYBofwodmJmkh1wj4c6wGGUrEr8p/OBM/ckP6uHNMK2R7AoSif6XOaWFm
         N82Q==
X-Forwarded-Encrypted: i=1; AJvYcCVabZdR17qLoxS/1KO/VqCRakKu5uLJsztlvr673QfdyugXVdOTmw/fv5BjBbQVSXLPshpK0R970SIpgdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIm8jrUiRIRkiA73WJsWbKMT+TtWJ7hYcaDQjznnrTuBXFp877
	fm9tR9hk2qPHeO2uQcodnVOuraDm2+Kbxvk3jVzz69F6gco8v8FhuI8i0ji/38of+9SjKejL9v8
	vvuteAvuX/w8yqQjVs9UNdw==
X-Google-Smtp-Source: AGHT+IEoqrP2g6h/KJaUaK1Q1DA58gB9rvHOePiYVQTXzTK975dcoE0Qo/s8PP/JcMhCdACbrqLc1V04PJctLxPEtg==
X-Received: from wmsn4.prod.google.com ([2002:a05:600c:3b84:b0:431:21be:a0dd])
 (user=peternewman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3c93:b0:434:9e46:5bc with SMTP id 5b1f17b1804b1-434d09bf04dmr106904535e9.10.1733413138543;
 Thu, 05 Dec 2024 07:38:58 -0800 (PST)
Date: Thu,  5 Dec 2024 16:38:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205153845.394714-1-peternewman@google.com>
Subject: [PATCH v2] x86/resctrl: Disallow mongroup rename on MPAM
From: Peter Newman <peternewman@google.com>
To: Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Babu Moger <babu.moger@amd.com>, James Morse <james.morse@arm.com>, 
	Shaopeng Tan <tan.shaopeng@fujitsu.com>, Tony Luck <tony.luck@intel.com>, 
	linux-kernel@vger.kernel.org, eranian@google.com, 
	Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"

Moving a monitoring group to a different parent control assumes that the
monitors will not be impacted. This is not the case on MPAM where the
PMG is an extension of the PARTID.

Detect this situation by requiring the change in CLOSID not to affect
the result of resctrl_arch_rmid_idx_encode(), otherwise return
-EOPNOTSUPP.

Signed-off-by: Peter Newman <peternewman@google.com>
---
v1->v2:
 - separated out from earlier series
 - fixed capitalization in error message

[v1] https://lore.kernel.org/lkml/20240325172707.73966-4-peternewman@google.com/

---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d906a1cd84917..8c77496b090cd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3888,6 +3888,19 @@ static int rdtgroup_rename(struct kernfs_node *kn,
 		goto out;
 	}
 
+	/*
+	 * If changing the CLOSID impacts the RMID, this operation is not
+	 * supported.
+	 */
+	if (resctrl_arch_rmid_idx_encode(rdtgrp->mon.parent->closid,
+					 rdtgrp->mon.rmid) !=
+	    resctrl_arch_rmid_idx_encode(new_prdtgrp->closid,
+					 rdtgrp->mon.rmid)) {
+		rdt_last_cmd_puts("Changing parent control group not supported\n");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/*
 	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
 	 * current parent CTRL_MON group and therefore cannot be assigned to

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.47.0.338.g60cca15819-goog


