Return-Path: <linux-kernel+bounces-255709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A1C9343FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D128432C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C89188CAC;
	Wed, 17 Jul 2024 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMeOFSPQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBE18C338
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252035; cv=none; b=ctbtDT2rpmQE9S86Z5k+0GLPEsIXvdj+xD6QgdqzrqwiraW+XL8CnCqHdNCKq7JNcczLnFKDJLJtpc9zwC7RT3BtqG/k4U2aHlT15mjNM2O30jvtidWsG7OXTDG+pQQUoRvKVqtkG9H0L7jW/1S+bF/bBadNF5t2fzJFImeeygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252035; c=relaxed/simple;
	bh=FtL2WLykniLMH2iZnDeKB+u5uJJnWt1fxzXfySze5OI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cp23IujMK+hxd52b1I+vu93zTnCNKheXrnitMmPKO/3CKPmB+FWkA8jmUrFMuDLoRnD0nwvjoDYvjF871swmMYIJHEJ6L6/CWJAzBrXQzF9PzGQm4lYMEfCl9StQdewCy+uGuyJuY1jCJtZPK6ehTjjF40i9lgj/oxddpGL0ueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMeOFSPQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6522c6e5ed9so2788497b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721252030; x=1721856830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLtZj5tEts3mR+eoKmaIr/Y89zsbNNxQ+zwQ1LS5MPo=;
        b=RMeOFSPQ18fD4vaOzqmWhuP6WcU58VwGkM/zPE5MKvd+ynHfi1vPfKov84Aj9o37Md
         xd6G0njHZ/ZCs9pD2qVyvJVsbtMm0fvKfptHgbbccDlBx0LxYMZ+VMY55UNTD7NL2Emf
         jCUfcL3ld25fiOnjTvf+ma0rQcACO/mSL7RKDxB4535BCsFalyPUQYRot0o2MqRDn/ie
         DEB2TgkroVWMtrfMiXocu8Nb2siklskL5UeU1DazUpJ+4BSTvcsROELmnYLdc67Xq92B
         zKEDg5d1YyTQgXpBLUeSw6Uuz4DHtqo5cP/JiTPJh6WQzECruTCRDd9K5n1YnUy3wXvY
         fSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252030; x=1721856830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLtZj5tEts3mR+eoKmaIr/Y89zsbNNxQ+zwQ1LS5MPo=;
        b=KRdr16Kk5b6KQntANceJ5vy8/9SYsy8HTlM1S0r/SOcn2Yn0uN3lbMXCkZ52GdESbN
         eT7iBrBXQEf8saNTu1VKqcS1VoS3GSEMK+9fWjLYEFu3K6CRee9vvBnZiHTWliIBuRRN
         BbDsnrLt5WlHS2c3MYrZVdhp77iwMq9NSpnpSK926nAQNdkVXk09A4tlyZsPo+cssgjn
         l2n+1aTl9+DLJBHlEPiZ/ZI7hoXAch1V/a3ft0FeZQrJV8R9bOS/xoWYejMyEnVKTyyu
         iEJzhrcHWJmYBkCJQ1b3zQFFrTSS3+QAbHY/0bIJ5g9B80P3HDq4Y/9OMbunNcPIv36z
         Xhcg==
X-Forwarded-Encrypted: i=1; AJvYcCU5OFS2kUbqGulKzdRAxIRYXqO3T4oZl15wJ+vWJSvlrZstXKuy/RFN+T6RWpWnooTISbOzXxwHSpXAeYkxvvvVR/e7sRBJLvC/1u7M
X-Gm-Message-State: AOJu0YwTv87FKhn4XSl8ZLUXAzoXMLsVvyZmkCTfyge2BYmGXrognygv
	J80+82YUTyDW3ehWlwop0UHKTcuz1d+mpvksf5I3vSUwOkqJjz1imj85QgaRNAr4ub5Re0gIVPl
	obQXpJPFqXk9FElk8aDAIMolFHlCPlA==
X-Google-Smtp-Source: AGHT+IHE4njs2DlarzKbQm9eMkmED17D/9sHKkJxOr/ao4nCy9IEICWK9iZlriPw9z3+uBXfjriRyfh4WAQDV+e5utZ9
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:150b:b0:e03:f2ea:717c with
 SMTP id 3f1490d57ef6-e05feb87b5amr1284276.5.1721252029671; Wed, 17 Jul 2024
 14:33:49 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:33:39 -0700
In-Reply-To: <20240717213339.1921530-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717213339.1921530-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717213339.1921530-4-axelrasmussen@google.com>
Subject: [PATCH 6.9 3/3] vfio/pci: Insert full vma on mmap'd MMIO fault
From: Axel Rasmussen <axelrasmussen@google.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Eric Auger <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik <leah.rumancik@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alex Williamson <alex.williamson@redhat.com>

commit d71a989cf5d961989c273093cdff2550acdde314 upstream.

In order to improve performance of typical scenarios we can try to insert
the entire vma on fault.  This accelerates typical cases, such as when
the MMIO region is DMA mapped by QEMU.  The vfio_iommu_type1 driver will
fault in the entire DMA mapped range through fixup_user_fault().

In synthetic testing, this improves the time required to walk a PCI BAR
mapping from userspace by roughly 1/3rd.

This is likely an interim solution until vmf_insert_pfn_{pmd,pud}() gain
support for pfnmaps.

Suggested-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/all/Zl6XdUkt%2FzMMGOLF@yzhao56-desk.sh.intel.com/
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/r/20240607035213.2054226-1-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 74a3499a8a2e..e388c974f9f0 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1659,6 +1659,7 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
 	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
+	unsigned long addr = vma->vm_start;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	pfn = vma_to_pfn(vma);
@@ -1666,11 +1667,25 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 	down_read(&vdev->memory_lock);
 
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
-		goto out_disabled;
+		goto out_unlock;
 
 	ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
+	if (ret & VM_FAULT_ERROR)
+		goto out_unlock;
 
-out_disabled:
+	/*
+	 * Pre-fault the remainder of the vma, abort further insertions and
+	 * supress error if fault is encountered during pre-fault.
+	 */
+	for (; addr < vma->vm_end; addr += PAGE_SIZE, pfn++) {
+		if (addr == vmf->address)
+			continue;
+
+		if (vmf_insert_pfn(vma, addr, pfn) & VM_FAULT_ERROR)
+			break;
+	}
+
+out_unlock:
 	up_read(&vdev->memory_lock);
 
 	return ret;
-- 
2.45.2.993.g49e7a77208-goog


