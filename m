Return-Path: <linux-kernel+bounces-533955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6961FA460AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500F817893E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900A22172A;
	Wed, 26 Feb 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNSHaRpU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E92206B3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576192; cv=none; b=ouF1jjtgK84Yd42OLu8fhcmIK9kVOK3TXYU0sN9XNwImVjdneqgt1P4LpDIQXCpcI7gF9Z3HYgUtn28RWlCErDVyCZET7UXy9IGU4UDsZbT4rNDxUaTSwmNh+yI3UK+EQzhf0dj1cdeEAffP5zGTbNKicL1VJZRENYCLmW7Z+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576192; c=relaxed/simple;
	bh=zb/ywQkAU/VZTJpUdxuoaD5DmJ0FlMmVf/JFfsbEDjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNplgUEFlTuJQVD7vX0RwOpaFL/gwMSpWOM8x304OBgwx7PkEYAEjq7Rapw38zCvpjWbd31pzof3ii2DKqT0QRBBXkWahU4fR+FsiHNqhHSuplWchF9tR5emJEGaisCvWSNqkejHebgQkl1GNQF1nyeH3OrPxSUazU22R8074TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNSHaRpU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740576190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ayxqWdfZtpuuFLEW5/IWnRh3wjbr3t43oqj3ksvw18=;
	b=dNSHaRpUYDX3N7mvoITAObQIOsFm9HcKge/SuO7l+GtI2h6vNdwZ0GyW1EP9BPlsfjIAGr
	lvTEBIUz6O1riBKTiZcvgciLRSiKRYBz09/Q4ta4X+PKBUVJDqyq2QeFRrcam3hQHVMtt4
	J+lWuKRzEZRB3Vawv9PPUcg5VhC41lw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-SsZGLmv6MsW6jatUHce-9Q-1; Wed, 26 Feb 2025 08:23:08 -0500
X-MC-Unique: SsZGLmv6MsW6jatUHce-9Q-1
X-Mimecast-MFC-AGG-ID: SsZGLmv6MsW6jatUHce-9Q_1740576187
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso62331395e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576187; x=1741180987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ayxqWdfZtpuuFLEW5/IWnRh3wjbr3t43oqj3ksvw18=;
        b=R2s8Np6tVUDaFGu6FmwxCE5/xcpu+naRALUlu+2uea/zym5VK4kjypTII2pIGP1azx
         1ko8bdSDL+pAhC8a9CjDgZH+lD0iW3aJFSbRig7PS/mmsuoIjWd/Wck3k9yrhLf6aQRv
         jrzLAy1bKun5FgW413THbqMEeBYxmF/s+x3ENLXxw390c7H3DKJekrAPygg/awIaioBZ
         2IGZNPmzGElwWkkgxijXLIgHCA3suRpH6RpZHwD+PWuXUC+nhL6suF4ra7JIGbMI01p7
         lXmylNW2Idxs8qfJ+LPEzgyLY+2rfW4i9oYrbtYVimVGjLbYRb/kwIdxXtGds1ov1YOy
         LdFg==
X-Gm-Message-State: AOJu0YwPUZ/US7exg64vCbDBnmAygKO2xhdtu4NcJY2vRkq3FDPg9GDH
	olmPYKBLqUS0VjDv9jGwjwJfR3wr36k5vR6fHVGL7+dE3d9MD9vptrXWsN/JYch+nzpgNhWJ0yu
	sE3vT6PLSk/7TDYpKRR6jPFywiXJbaVohw5+bh1xblNFM67MRKG33IRFUo0hbeX05swT8dfq4xD
	krNVSGZd7+9A5rb8BUSOjEaU9PZC2/G71HhsXnsNnP+Ly/
X-Gm-Gg: ASbGncszwWiUmtOTGIwtJXl5Mb9nPqMeZ6l0phVPyljFzGfxaR9GiM6kBU0EzgnoMro
	4Knik8s4qkNWhaSyKf1K4vnQqOSemzwnchw1bFwjJoSQnL/nKNlpIOkhf5pAgFuFa1Ofhq3OvUp
	0pA/STkuCVvHKkLUPsgV5ilxBIiKe1tU32c7vHQ/T/61Heft4MWj2PSzhfIa2xvpbSG5MPWQKux
	VE4PLpm7a5HQUh0fSpoLqpbsi1pzCElhvPuvDuTAUtI9Vr70sB/l4aj7WScwVgwkSC+NlCqg5HS
	hg+tedTwLifLjPL4ygbWeUzQkYsQKlRzldZ3t9crm1yOEfnnSqeVjbwma7CiDVZfjBy441eauFT
	P
X-Received: by 2002:a05:600c:1d1a:b0:439:916a:b3db with SMTP id 5b1f17b1804b1-43ab0f28872mr74312735e9.6.1740576187255;
        Wed, 26 Feb 2025 05:23:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZecayt4WE/OXHMqhCrGeiiVFvJ2H3x+MAoGPf+DIopmjwISLHjYgRgetExDyOwLcEx7l8uw==
X-Received: by 2002:a05:600c:1d1a:b0:439:916a:b3db with SMTP id 5b1f17b1804b1-43ab0f28872mr74312325e9.6.1740576186833;
        Wed, 26 Feb 2025 05:23:06 -0800 (PST)
Received: from localhost (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba544029sm21379795e9.29.2025.02.26.05.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:23:06 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 5/5] mm/mmu_notifier: use MMU_NOTIFY_CLEAR in remove_device_exclusive_entry()
Date: Wed, 26 Feb 2025 14:22:57 +0100
Message-ID: <20250226132257.2826043-6-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226132257.2826043-1-david@redhat.com>
References: <20250226132257.2826043-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's limit the use of MMU_NOTIFY_EXCLUSIVE to the case where we convert
a present PTE to device-exclusive. For the other case, we can simply
use MMU_NOTIFY_CLEAR, because it really is clearing the
device-exclusive entry first, to then install the present entry.

Update the documentation of MMU_NOTIFY_EXCLUSIVE, to document the single
use case more thoroughly.

If ever required, we could add a separate MMU_NOTIFY_CLEAR_EXCLUSIVE;
for now using MMU_NOTIFY_CLEAR seems to be sufficient.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmu_notifier.h | 8 ++++----
 mm/memory.c                  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index d4e7146618262..bc2402a45741d 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -43,10 +43,10 @@ struct mmu_interval_notifier;
  * a device driver to possibly ignore the invalidation if the
  * owner field matches the driver's device private pgmap owner.
  *
- * @MMU_NOTIFY_EXCLUSIVE: to signal a device driver that the device will no
- * longer have exclusive access to the page. When sent during creation of an
- * exclusive range the owner will be initialised to the value provided by the
- * caller of make_device_exclusive(), otherwise the owner will be NULL.
+ * @MMU_NOTIFY_EXCLUSIVE: conversion of a page table entry to device-exclusive.
+ * The owner is initialized to the value provided by the caller of
+ * make_device_exclusive(), such that this caller can filter out these
+ * events.
  */
 enum mmu_notifier_event {
 	MMU_NOTIFY_UNMAP = 0,
diff --git a/mm/memory.c b/mm/memory.c
index 50a305d7efcb9..79acd2d95dcff 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4046,7 +4046,7 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 		folio_put(folio);
 		return ret;
 	}
-	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0,
+	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_CLEAR, 0,
 				vma->vm_mm, vmf->address & PAGE_MASK,
 				(vmf->address & PAGE_MASK) + PAGE_SIZE, NULL);
 	mmu_notifier_invalidate_range_start(&range);
-- 
2.48.1


