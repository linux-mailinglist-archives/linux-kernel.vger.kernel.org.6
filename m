Return-Path: <linux-kernel+bounces-372029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D19A4387
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA50D1C20A65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699642022F5;
	Fri, 18 Oct 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByO4l1HP"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8D188CB1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268296; cv=none; b=A0xrWGo45CvfU5b0d6hyHZ/tLxtiXaPG7qsWLkutkUEoZWnKrmWDMI3SLrJe2yx1oPxK2asYDPwRcJs/csr4BzWyVNKr2hMXccNFwAdJN/7xR/o02ODKh9VrPXjUWfYcMBRJooRyNNxkt0Jb1+WyG+F7wqBZtWlSYDV7olASe/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268296; c=relaxed/simple;
	bh=m60wt0Afoo38qYwATjoz5uhXKASqlZKOF1Htm7PQBh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l7W/RYjZs8I3EYAKgVmshilLkXXkQ2NRWcgS2rp306w3BORo6mwV7OzwzxhNkYap7sjxrFn3LVMA5V67J5C+5aalQFDrxfQosSzsfffYDRNv4JraFKwDsfMVhY3s2FdgAh7WEW9Z/eA5XCXHVCT0q82uuesF23bEkLIKji9i7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByO4l1HP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso1629408a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729268294; x=1729873094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lI1lmoX0aShbqtjbwicYm75B+4+2640ny91XLHS0QLk=;
        b=ByO4l1HPUbrBikqDbAW0tybVNNKS5t+ZPefYREwQcLnwLBqCdvwG14lR3tUOaDMf4L
         EARvcILHaGIiadT4lw1YqOoOCQ94cllVlHqsOh6oG+6h4DEKKQoia3qnfFQpXij5Z+kb
         IcyNkO2qVw5HuY/aFL/hctwMCNoOxpYwXwKWA6nDqf8+1f0Yk7GzHjO73pzIxV1hiAoD
         5SjmOH2qHgL0UDMtOu3+ny6+sWDJp1FPVNz8YZBHZDY+/a1Gieo1yHDa3TKYxfvipB/H
         1kZeiOEAgQ7ooD50CDrrZFUCaNVDsnb8bUUmmMALAMUBWdG42n/a2IV0eHGw1mO8muYm
         DbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729268294; x=1729873094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lI1lmoX0aShbqtjbwicYm75B+4+2640ny91XLHS0QLk=;
        b=KxYLwuRBNcFXPrl5RColWz9xa/660W/07d1ELud5zK6mRxxTpwgCVuoAOWiZ7F+LsV
         MFKIPXLiUbSKbBIhgPi3H23l2QO0WoqNbqUu63qjnythuhra8D48Mx9kYcpLs5xGpVrh
         StgACJa90A727o2oEmg0l9J18BPiQ0Upl2OD2tA4y5x/hgzzkxfOAFkVuGqmmKqEYXRB
         Su3RGRfdmFHEiMZ+H2svQJZndb4fOGL2jZcvjhHvh1BKyiMR35ba5oR/5NExh5ezzbCt
         oRz2f/40ZkiSFXLc2Jvxlp7dKrVGnSBtTJqtprOBqEp2pDQ5yxe+N/CDO2GHK08U5QlF
         i8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWok6unb70QvrNsfdPtm47DmeTlhzzgfxOwJgu6ZGZdJOFcY/gwpc9E4dB5YxNVt+ZoHtwQXEfrdKrDO7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwalqzLiOn5kEOIKWTnS26svk44aj82UZ19y4IBiyGc2W78stJn
	exCYAm2gfVbsJbo1VTpL8dEWMcXPIfrZhKs+9AsfC46G5VjONZMT
X-Google-Smtp-Source: AGHT+IHzJGqOqiYMgY0XNWgsPScuQIuvxXcZGIlbc7649iguD7LwhL7RFqPyEBoqw+pUDCliOqawww==
X-Received: by 2002:a05:6a21:6801:b0:1d9:278a:9ab with SMTP id adf61e73a8af0-1d92c56d430mr4837764637.35.1729268294000;
        Fri, 18 Oct 2024 09:18:14 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea345677asm1692140b3a.147.2024.10.18.09.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:18:13 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 1/3] powerpc/fadump: Refactor and prepare fadump_cma_init for late init
Date: Fri, 18 Oct 2024 21:47:55 +0530
Message-ID: <a2afc3d6481a87a305e89cfc4a3f3d2a0b8ceab3.1729146153.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We anyway don't use any return values from fadump_cma_init(). Since
fadump_reserve_mem() from where fadump_cma_init() gets called today,
already has the required checks.
This patch makes this function return type as void. Let's also handle
extra cases like return if fadump_supported is false or dump_active, so
that in later patches we can call fadump_cma_init() separately from
setup_arch().

Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---

v3 -> v4
=========
1. Dropped RFC tag.
2. Updated commit subject from fadump: <> powerpc/fadump:
3. Added RvBs and Acks.
[v3]: https://lore.kernel.org/linuxppc-dev/030b6d46fddac126a6cf7e119bea48055338f0ed.1728658614.git.ritesh.list@gmail.com/

 arch/powerpc/kernel/fadump.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a612e7513a4f..162327d66982 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -78,27 +78,23 @@ static struct cma *fadump_cma;
  * But for some reason even if it fails we still have the memory reservation
  * with us and we can still continue doing fadump.
  */
-static int __init fadump_cma_init(void)
+static void __init fadump_cma_init(void)
 {
 	unsigned long long base, size;
 	int rc;

-	if (!fw_dump.fadump_enabled)
-		return 0;
-
+	if (!fw_dump.fadump_supported || !fw_dump.fadump_enabled ||
+			fw_dump.dump_active)
+		return;
 	/*
 	 * Do not use CMA if user has provided fadump=nocma kernel parameter.
-	 * Return 1 to continue with fadump old behaviour.
 	 */
-	if (fw_dump.nocma)
-		return 1;
+	if (fw_dump.nocma || !fw_dump.boot_memory_size)
+		return;

 	base = fw_dump.reserve_dump_area_start;
 	size = fw_dump.boot_memory_size;

-	if (!size)
-		return 0;
-
 	rc = cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma);
 	if (rc) {
 		pr_err("Failed to init cma area for firmware-assisted dump,%d\n", rc);
@@ -108,7 +104,7 @@ static int __init fadump_cma_init(void)
 		 * blocked from production system usage.  Hence return 1,
 		 * so that we can continue with fadump.
 		 */
-		return 1;
+		return;
 	}

 	/*
@@ -125,10 +121,9 @@ static int __init fadump_cma_init(void)
 		cma_get_size(fadump_cma),
 		(unsigned long)cma_get_base(fadump_cma) >> 20,
 		fw_dump.reserve_dump_area_size);
-	return 1;
 }
 #else
-static int __init fadump_cma_init(void) { return 1; }
+static void __init fadump_cma_init(void) { }
 #endif /* CONFIG_CMA */

 /*
@@ -638,7 +633,7 @@ int __init fadump_reserve_mem(void)
 		pr_info("Reserved %lldMB of memory at %#016llx (System RAM: %lldMB)\n",
 			(size >> 20), base, (memblock_phys_mem_size() >> 20));

-		ret = fadump_cma_init();
+		fadump_cma_init();
 	}

 	return ret;
--
2.46.0


