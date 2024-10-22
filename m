Return-Path: <linux-kernel+bounces-377015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC39AB8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA012833A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAB21FF619;
	Tue, 22 Oct 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XI0zjFlD"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A91FEFBC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632899; cv=none; b=u4SdX+s82105VQGJhOrwqB+KIxoF2pIYAScI5j03JM4rfHUH6ToitAcJl59Lk8HXltflgUqle79AG+J49SmBxiQBrvWngGn5vkPrvekNI/7ZrsDp7CpYQ0bniG8RhAmyoD/SL0DITmGAsZrTBNjyKvaPrwuGLVbjQi+nohKS90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632899; c=relaxed/simple;
	bh=W1pk87B56sY3NmTWTw0fYcdlm0GNbCNKUts7riRYlbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD0NmvGcKoBQ24yUYxHnq2uNO22ZrLUU1oqQ2y22PgdFZltY9jGCp5hJ7y7ITRkIdC1pL06rrI1isw0nJPqGSd66b3fSDmUEVXdfIYdicDD2QrEGItv1sY/p2TFIT4++DDkt525DaYdxbtrg1W7Wd71+QNSsu7h1gwl6+rx2nSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XI0zjFlD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460d2571033so20861141cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729632896; x=1730237696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqCv7heAkmMbGyHort0yESB5tthHSXy3Avmci0WyUUs=;
        b=XI0zjFlDTySPEMo8xxPza+roQKJ7BQVdRPzHM0HsauL0+eoX5b58OZ8OeV/pwfVvJA
         aghuv+EkWRV3VIZ3aQxugkQTQd9c9uRXAsrpe6QhB8y7KNAEek5A2kU1Ebm7AKZxWUhp
         QRd+dGzfzhcrkCLozLAVvKlqKIuwYTDRr7b+rfbr344WDRFJC8zNah3r4ObwSiS1isC6
         EEIlyk6VPZ6ywHOZxEFNRb5iz8PqQ436gyDHMfWJbQrlc9oMmzIEyIa37LOW4qmhuOmt
         uG3aTrndbUejvgcqm2vYprkao/PKi8uuQ/6nnO5y5luMDfvBBphCOhIIztedfuMMsmW+
         XcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632896; x=1730237696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqCv7heAkmMbGyHort0yESB5tthHSXy3Avmci0WyUUs=;
        b=cyNFTgClaDtVElJdzS87T836/R5QM7RtYUqa6YmuHL+7Ch8ovAaaSazyJD5u/K4/OB
         N/k7Er+6Zpx2foIQdmMIlyCfVRyLFCTn6/J6y2qtuxQKcMysRqWEs+Y0FUOGWLif4NQT
         l413GZm+8LSzYqgOltWEI4t6sqM2+KCD3RBPns0j+cGS5pMh0LZlSJtmJ5Sco5M62Wji
         qrXn5jq0YEg5E2NuCxk2jP1bDTTrXmXe9HMS+W9fI4YtRBue0bJftGZwCWZWsg8C1Ygp
         QL+Rcv2kTCZZzbVgv/to2mEyZcWKpfQoFhqiTkGi4ITX11tSxSbjQZeDwEVTVGy7qhIK
         43hw==
X-Forwarded-Encrypted: i=1; AJvYcCXS07ylOl1wff6YKrd3bS3gmaGzB5XXj4V7MtbRGFiCfwJVieqqUPR1zTvzJnvFQ7oUIdT5pTOiMo+BF8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBshyjgQP6zzgrYTC0iQU0RCtR17msDfh3D/Lvah7gY7WkI+Yr
	kbJqUE6y/smSjSQPxrN6gAyT+yzVBeIkJGz3QZO3AT5jKQhCp4+OfeN7Ue1buCY=
X-Google-Smtp-Source: AGHT+IG6u8nXwqeHHa2iAZjSeQvjzXX9LlJNqnqKjo6O88p7xQbadR2zh6+g2YkgEfRojyf8qrAQmQ==
X-Received: by 2002:ac8:59d4:0:b0:460:8e3b:6790 with SMTP id d75a77b69052e-4611470b2b0mr4519561cf.48.1729632896082;
        Tue, 22 Oct 2024 14:34:56 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c62f4dsm33845841cf.28.2024.10.22.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:34:55 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@kvack.org,
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
Subject: [PATCH v3 2/3] x86: probe memory block size advisement value during mm init
Date: Tue, 22 Oct 2024 17:34:49 -0400
Message-ID: <20241022213450.15041-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022213450.15041-1-gourry@gourry.net>
References: <20241022213450.15041-1-gourry@gourry.net>
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
---
 arch/x86/mm/init_64.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..93d669f467f7 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1452,13 +1452,17 @@ static unsigned long probe_memory_block_size(void)
 	}
 
 	/*
-	 * Use max block size to minimize overhead on bare metal, where
-	 * alignment for memory hotplug isn't a concern.
+	 * When hotplug alignment is not a concern, maximize blocksize
+	 * to minimize overhead. Otherwise, align to the lesser of advice
+	 * alignment and end of memory alignment.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+	bz = memory_block_probe_max_size();
+	if (!bz) {
 		bz = MAX_BLOCK_SIZE;
-		goto done;
-	}
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			goto done;
+	} else
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
 
 	/* Find the largest allowed block size that aligns to memory end */
 	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
-- 
2.43.0


