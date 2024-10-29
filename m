Return-Path: <linux-kernel+bounces-387587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09709B5347
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9022D2846B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E730E208202;
	Tue, 29 Oct 2024 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ny86Fd8Q"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514762076AC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233250; cv=none; b=md492FlEW/tSSHuojskO59FybKrqoTj6/jKBAXBMf4ppcDJtadCjf3y90NYkbPKHJlSiYQhAH9I+k/TY4AccwYpxX1pgyJoouZ6tjgQLRlmFVcVHhYJlZLZTq9BtfD2jJ+vRNYBzDE2b1+5YbaEwaASVI6algSJzKEIVd+lP9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233250; c=relaxed/simple;
	bh=vp/pABtvn+LXH3AXLSvAztLHPBydYo64dCzxrhZlQjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEiqC1B52qRqSPTALULxmPFp0sXhnY+F8qVaX5wFwUJ50iW886WhIE2OZAHxzv7YpYM+i8teIscRO5cyNpXvwDmxllpptryHRGEcxhdguQps4q8Yejin3/GfSt0fm0etAiy3Zgay4vDqBBuATlsmC6xgeQTqKwkHHL1NC/CrgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ny86Fd8Q; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so6151579276.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730233246; x=1730838046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLCkoovWy+4BTP/Blm5LQHaaqE7ZHx2x3Kcfu38vCw4=;
        b=ny86Fd8QvtRORo3sA0fckv7mqlt3eK7f3AvAa9o5Kpe/ZiN4ojjYXfF1KmT3CPZT73
         mVJTONfIDIPzw3Y0ObR6sc12Ie9nPHeNVyC+NE+mJBWh8zJN51Z95WENFKcy0R9ZhSMF
         9s38Zji0gCdtP8JVsGPBMQrVf6+1OY+tus0Q535p78rG5eUZiwptV3CfNZ18nnUATkgL
         p2x2N4/0pnH1YazRl0lkgDTNn7MGqe3fHXlLKXsm6LO3r1il+mn7U38AnVlWLhmBB2FY
         7n1vV5GoE5d/k+UdkQoj2ZtWy2qfUAIaI7DDget8u7Akym8sgi5X/hKgyvLmX0fBMQQ4
         zl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233246; x=1730838046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLCkoovWy+4BTP/Blm5LQHaaqE7ZHx2x3Kcfu38vCw4=;
        b=eYQEXHa6s7iMYEUDaj5fP5exb03Qsoelp6kDKtNqX8AcRI9FUYCnrAnf1XIUmrSY3H
         IdJTPc7sgf/gwZz1lzYR5Va6i2/SK+TeqjXGnkMgQDc+59r5EIRgZTBZbQsfipmK/k5P
         I1fNzXbzfxuzCKFRafOjiWhpOviA5r1DxISWlMTIjBh+pmgRVp8qZzb7qipRthyRc6KY
         n71NeF5F3j20keSrzktg+XvSFNF1h6wamr0dvxOwo2xxMUgQkGs5vz77QbRgXqGwM3YR
         gXbN25m9msMIFrFevmqMPWN81tkoe7c3MrVmC0H1PWldm3dnjbXpT820GIs2Qa5BEoX3
         gg4A==
X-Forwarded-Encrypted: i=1; AJvYcCXe0mz755te3PcqYZB97ufI6bxhvp82O6e+LUnywGEb+7R5pjMIy2c/RtM5xuz5BPPBAz+7KfmGS6L6pgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Egm5PezE5oBAgsho+RPjH241HezOf3ZodcMZrH8uuKnrw0VF
	BDS+URlCJkSZEYfoqHsOvi8Fd7TwhxyCSno7BqRGWgi9nj2W9GHMWI6CyHA94tI=
X-Google-Smtp-Source: AGHT+IHrVUT2Y/bn1A2eEhZ3B/4Cio2x63OgV+iZejuf4OHZLNTMyIcoastoD+p+X+Hd1T8kconCzQ==
X-Received: by 2002:a05:6902:102c:b0:e30:c8db:34cd with SMTP id 3f1490d57ef6-e30c8db3652mr2549661276.3.1730233246317;
        Tue, 29 Oct 2024 13:20:46 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798bd8bdsm45071796d6.54.2024.10.29.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:20:46 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v4 2/3] x86: probe memory block size advisement value during mm init
Date: Tue, 29 Oct 2024 16:20:40 -0400
Message-ID: <20241029202041.25334-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029202041.25334-1-gourry@gourry.net>
References: <20241029202041.25334-1-gourry@gourry.net>
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

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/init_64.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..01876629f21f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1452,16 +1452,20 @@ static unsigned long probe_memory_block_size(void)
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
-	}
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			goto done;
+	} else
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
 
 	/* Find the largest allowed block size that aligns to memory end */
-	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+	for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))
 			break;
 	}
-- 
2.43.0


