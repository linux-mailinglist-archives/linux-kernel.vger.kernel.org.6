Return-Path: <linux-kernel+bounces-440402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93E09EBD76
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE151285FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580E23EA90;
	Tue, 10 Dec 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m8EdZ7Ew"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637DA23D433
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868352; cv=none; b=cXVYftiJc9eZ5L8NB45ZJzhptn0LbMVdSu0lq9FC7GovWgKO2SpQW4XF7WToSJw4zRVeP22l7wxOiVad1Qf5MRBYoERwziSK+rbvZ1LFeQQECKwlLAwauV8VU2KL43DMALIOfX6ILz1jehm0OoNZ/JHGvIbLOrGL2imgjH8wlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868352; c=relaxed/simple;
	bh=NI/VCBA4V00Ps24Jg1XYDOYEuE9C/bHGB4RLm7NSawQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCiNt9+lKUmpp0a1nqvbZxZAi1Y1RuqKeJsCUysunIqjmOJaPIo4TFPpo9koN8/hNmbJR88RzoHaNq8VonLJ5/Y3WdvTAB2uSjXf4GDzdDEOPQCZK22dDi6zmE/2b88JSbS4iJaiHnO4R/KeiSIg0hTz8s3hIclQWvgihje6+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m8EdZ7Ew; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467745731fdso10739111cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733868348; x=1734473148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oErJky2BLU9Af7jLve7daZWId/j12r2NaH/TqvsN93M=;
        b=m8EdZ7EwwcXdGFXJXBPI3dPzzacCNllhO+NMPLSyh0+DKq+Zjt7msnsbUWzoYSkOvP
         L0oRB2iMcGWMfxsVumcowsaaep8TuDD240Ecdzqln+A0sb4I58NdhJZ0d2dyBiuYUl/J
         MrKRwv8zRYHgDRT3Ba0qs+D7/ClCKODnQM6UGtiDKEyJc5t5x/XmKdlNqnCX2pdE/KVK
         0T7EaG6Hih5Hw+oTwTqAcIlh8kE44AsThVAX5wqGx74C879aCxLJGv8BMLM2Ll75cbSU
         6oww03NqRYHfMtn2Qc/j+yyBGZsrYnmi7n7Xzoq4/lrolbXu15ZiAdWLXSGJDcZ3yQX1
         /a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868348; x=1734473148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oErJky2BLU9Af7jLve7daZWId/j12r2NaH/TqvsN93M=;
        b=Lepef6kkMLYVHnXtf/tDGE7ZkYkvrmdEJshegOf7gJhvoG1Jj0sFJfl2UndZQiVbAh
         TJi7VNzOENGImJP8LvBJDsuMtuqWi+Z4BnXvJ8hqg3X3nsS2aLxhW9p9nNnpWGOQWNww
         I5p6/CRoHu5rIPnfFlTIrcclqYiWg76aLlru8PzgqW/YPSlvZvlpZlyaKo6cB8GmucK4
         ZGHTI6qcCF/o/eZrgE9kDIiQrimNpIU7kbxucamDNnB1Vbpdu34fK/3SOvNM8wbmdP/y
         v0UhsB5wBwGov/WAipPLjU8wH1SrU571x/XxPfz+/tX1/1e+dQBQMEo/W1wIxHa6T8yH
         VLcA==
X-Forwarded-Encrypted: i=1; AJvYcCWfQ0pl0qHkLNqWEdwrT6xRmv2oxQLKKGUe3otgxCGykiSnEgIKwFFJaww7FSVJqOhoz87f4+78v2XPGuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGerZrJD0u5x/IFq/eULDrw1nWivqTMz9JKH/hhp7JLCZUXct7
	5VlbElRvGo93W88KXsoVyTN49dOiAwJqsLaFQWlH7lkGXFwBLIWUjGnqZcgE21pzq3LR8T49i1X
	B
X-Gm-Gg: ASbGncuJ4FAs9X40bXeHg+bUy/7mVZjt5xjO97DOLQZhsK9YT4R2EhBjfBHhTd+Ovi8
	JjGi88s8YhwdMuxJAXk8pyKwTtBTYcc+FbNe3aojxJ5qG1ogDKk7ZH+4dvTyZIPs28bUayC6S6T
	LOuBsE8mZqZjz079PqVPYRApkTyTjOV/xQnAjZYaC/A/uM9ykRh+ex4CNBRcJIYBkwPI+hwhIxa
	EIPQmgvswkFswEEeVEcLgVJqzCM4lI369NdTdt2yg7ogwhp5X1Fmb4wcFsMnKwLtxMPu2JKq7SO
	0k78P/mJ7DqbHpxH1RSw5IUvines+S2eNX1sF3Y=
X-Google-Smtp-Source: AGHT+IENYQ0oAKQ+kT8P0UCH8ySBpUYpnMabT5K76y4L5ld+Nf2r6CwojmMzmHyhvdr+kBpYd1jW3w==
X-Received: by 2002:a05:6214:2682:b0:6d4:254f:1c8e with SMTP id 6a1803df08f44-6d934b7cc2amr10515796d6.37.1733868348294;
        Tue, 10 Dec 2024 14:05:48 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8eeb132e1sm49707756d6.35.2024.12.10.14.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:05:47 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	osalvador@suse.de,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v7 2/3] x86: probe memory block size advisement value during mm init
Date: Tue, 10 Dec 2024 17:05:16 -0500
Message-ID: <20241210220517.3744-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210220517.3744-1-gourry@gourry.net>
References: <20241210220517.3744-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Systems with hotplug may provide an advisement value on what the
memblock size should be.  Probe this value when the rest of the
configuration values are considered.

The new heuristic is as follows

1) set_memory_block_size_order value if already set (cmdline param)
2) minimum block size if memory is less than large block limit
3) if no hotplug advice: Max block size if system is bare-metal,
   otherwise use end of memory alignment.
4) if hotplug advice: lesser of advice and end of memory alignment.

Convert to cpu_feature_enabled() while at it.[1]

[1] https://lore.kernel.org/all/20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local/

Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
---
 arch/x86/mm/init_64.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..58ace82874eb 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1462,16 +1462,21 @@ static unsigned long probe_memory_block_size(void)
 	}
 
 	/*
-	 * Use max block size to minimize overhead on bare metal, where
-	 * alignment for memory hotplug isn't a concern.
+	 * When hotplug alignment is not a concern, maximize blocksize
+	 * to minimize overhead. Otherwise, align to the lesser of advice
+	 * alignment and end of memory alignment.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+	bz = memory_block_advised_max_size();
+	if (!bz) {
 		bz = MAX_BLOCK_SIZE;
-		goto done;
+		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+			goto done;
+	} else {
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
 	}
 
 	/* Find the largest allowed block size that aligns to memory end */
-	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+	for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))
 			break;
 	}
-- 
2.43.0


