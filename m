Return-Path: <linux-kernel+bounces-310489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0B6967DAB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084C02813E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46174282F7;
	Mon,  2 Sep 2024 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEnhAABn"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1722331
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242796; cv=none; b=cLeV2LTCqI++YdcevisQlWLsFJ+zO8BoASjKHHWOoLw2XnBE53YAMd/KGKWXkI7rHOUYYHdSxS/iV7+eQB5Z7zhC8aKjZXzHtgmktxVfb3mn4No47aw/S7jrWQHW/OCFVOVJLhm7eVwtwaw8TmxwtdgROPFKoQHbaf72BXRy3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242796; c=relaxed/simple;
	bh=UJg/x56Jz+qTbkQjthU1d8r8fhs3EjdozznxVV/Pte0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fkkp8G8VXLqWiJ6K/zm4sEOzGZM1EbwPZPCLDss4Ox5NZ4FC+m2Pj2mXsMYfu6dVYoMswpAK6wHiU1DdkIC8/pFvSdG/av8vHZc99YnWWetn+DtCX/BSwDOZPe9oxYVPGJU9NlQPkXBzndbGlHaE1ZNSuyW3z8zAVEmpGm722DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEnhAABn; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82a21186437so16942039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 19:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725242794; x=1725847594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzWETECRyzBQxo4jhG+80JiJ6wiccY5fJnvQim0a0Qw=;
        b=hEnhAABnhirIfRd8BprL+1Q84fqxrHdW4/xyTGhxa48cYNUKnor3mZSgnHK14+xU9t
         md1as35nwnUR99UUEGDrHgVO83koXeskwYkdlSnDhjSuz8U0Kb5wH56TwVu4b1QGK4fD
         GgRI8FYoii5FaUF6AKnbCd6gr40Zr46ew9M9cITVtIiOg6l373VBf74gdBjzM/Nyk+uU
         VCRlGlqMBD3pUDFkdu6SG7nqsz/bctWM8IiE06d7NlG11dBm4Qqq9U5r26v6CIjKel4R
         nXm8IViK+HwBzObrGzdtUF9uMdWGwoUIPrJ4QEnsuq2CE9i4iWv7syph5m+c1gGtFyC4
         FOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725242794; x=1725847594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzWETECRyzBQxo4jhG+80JiJ6wiccY5fJnvQim0a0Qw=;
        b=o6owuGPKk2KMSQV7UP8nDgTU17TeoObuVxNbXugvlxGNV7F3qEXifjs003dipl1iCI
         mRyXUoBqnIUrQOl9w2a5MTGcqgcqn5Bol3aLoLfPYj7ewcP3iaMOCQQX86IJYI6cIo+/
         HTsVWSOEdOSZjt3DbFKBm2/o9LzZgi+pLE1KVS8qjjQQN+rLVpQMDn0QGnItNNFyLvt9
         S5fp3jH5SvHp1xo4bwk3p2PGrJ4hA0u/RCtF4FMJn2w+sD5jL3oXZR5vIke+wfX0EGvr
         +AIDSFFRBK3GB99E07yPGlyprJkYlfIvWhXhTlXSRj4Z4R+MQA9QLJzGz3VTCfCkukne
         mCdA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Ls5toshz3z4r4Wx3MJ5dhXty4+rD64QyttZ9c33EBhkbLquyDrkwbdnpWC7yYXNJeBbSwpTa2kysNRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/kQWJrs/Y6PTTLjeRxVjAzph5toxLVSHTyTDgNaQDAlhEQOJ/
	3hU7qE3eG6CrVQf4Gg9a0fD562laHdiWO7QDam46kJNGIcwWkgaW
X-Google-Smtp-Source: AGHT+IHtLCA3jl/otshrjT4bzm5oMZQ84gh4JSRtB49L7kdyQ4ivl0Y1Bjnyg8amFH+H741S5oZLXA==
X-Received: by 2002:a92:c54a:0:b0:39c:2cf0:42f2 with SMTP id e9e14a558f8ab-39f410bf292mr49904945ab.4.1725242794159;
        Sun, 01 Sep 2024 19:06:34 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:5003:d466:54ba:50ca])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d6f76sm6379836a12.91.2024.09.01.19.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 19:06:33 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	R Sundar <prosunofficial@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH linux-next v2] mm: Removed @freeptr_offset to prevent doc warning
Date: Mon,  2 Sep 2024 07:35:55 +0530
Message-Id: <20240902020555.11506-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed @freeptr_offset to fix below doc warning.  
./mm/slab_common.c:385: warning: Excess function parameter 'freeptr_offset' description in 'kmem_cache_create_usercopy'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408292249.5oUpnCbS-lkp@intel.com/
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

v1 -> v2: Added Reported-by and Closes Tag

 mm/slab_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index d48ef4fe1ea8..ad438ba62485 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -353,7 +353,6 @@ do_kmem_cache_create_usercopy(const char *name,
  * for copying to userspace
  * @name: A string which is used in /proc/slabinfo to identify this cache.
  * @size: The size of objects to be created in this cache.
- * @freeptr_offset: Custom offset for the free pointer in RCU caches
  * @align: The required alignment for the objects.
  * @flags: SLAB flags
  * @useroffset: Usercopy region offset
-- 
2.34.1


