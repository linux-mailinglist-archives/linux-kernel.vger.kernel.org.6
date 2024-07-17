Return-Path: <linux-kernel+bounces-255759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA269344CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F24628444F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F4E46426;
	Wed, 17 Jul 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipDKW34L"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9B558B6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255079; cv=none; b=TKbe+uqBGDZHU+curczr1rnMia3EyLlV4/2WjW5eFa/oPRxK3vMJddxWju/jfmBJiGl0HY+XBFfqMIr8//inZL41jzXQi6mYPGQXtbLOWqyG8TdhMzMboA8DcfNY6pGfHBA0YRDlFaw7YeooEKHKMQrFMRl15Q/ylO9/Zu+nJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255079; c=relaxed/simple;
	bh=kMqdRxWNiI9YiTgGPD1e6dunxlUyzqetxFSiKFvNiPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CO0ZZ9LjtW8CS0LEws3iJEbP9AyZhzyvXNdipTZPVT9oUNgmUEVIuqpHZDmBUONY8JVBSbpYDHvXt/bdnfhPg+5olT0zC7WVIaTYe8PDAkmaQkiNRfDRS++AeITL9hjJmQ3x9G2/aZZFy3Ju9aNrmMKyGBfvV/4kjtFXJNWVCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipDKW34L; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-65fabcd336fso4296687b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721255077; x=1721859877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdMf+ufr3mRNGP33DXF0RnpzY+vpJ6GjjPw/JpyYHhE=;
        b=ipDKW34LDXjO8jvBw0bPwF8/fNk4EqV5BGvo9qg0sVImlHjWi1b9PmeFX59ArGeq+G
         +i92H6fx9Zom8toZlHZ9HQF5vhCiO1RQYmS6YLDnVQI2wGn+lq0odiF3k6V8ZJZbtcLr
         0LiqXaebg4WO/L6OdwhPdoVLCiQJBX2plUpgQ166DwNFAr9oJkRL1DkBp1M2g7DTyRxg
         TsBuG+pcUM4oVi7Chgdl8gb02CoLdpd3ksTFQuvOm/piV4JTADM2ueoReE4JYuHAbNR2
         Vp8XB1S2nK1Iu4hZD6iO6qPbwdttkv+vRU+IqIGfJ6DO7WdRbqqqSHJ2b3PDp0XbmXh1
         t69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255077; x=1721859877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdMf+ufr3mRNGP33DXF0RnpzY+vpJ6GjjPw/JpyYHhE=;
        b=V5f5BRsL6nB4uNxJGx1Z9Z8Q8VKXyl4AlLaBnRSaYVjgS6u0YzMdEalL+32A9g3dX7
         FChqL8G3BucjKV54j4jGqYYAgPhlyX9wwoQy8oLyCempotWp6NwdvYxc5QEwUJaPdmFJ
         GTjlZzb1ux0ITPnx6sRwj2ZiJbymIHbC6t6PPyWGpnKKhlaXjAxuLVwmFNFsWVLTtcqv
         HYH0pmg10/NpXj1nrecE6fXHgfbbjL8BQQoJwhjB8rd7he/1lGk+H9z/6k9FfDYfAZhy
         jvWsgNjuJKQA/VNtYvx9R/8H2SSmuNxrApfpllKa8izdpfbSsTqCHIdcpzUkPvRwpjE0
         a8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVZcqYNsqY12NeHlTZESAOYngA/rmtEMVeP51+FyYkJRX/dFlP7i+9fLJUHbw0uRcW9asVmhu1zXe0syhGGWgMUc4R6pSvd5cXj6bL9
X-Gm-Message-State: AOJu0Yx4bIYKkRB2EzGhZ1wIt/Unn43tJ9q7UBesIpZPb1uGtcKCI9Pl
	NLq26bmaDJfDny7cGwjVk76rM2FSX49IpJKkxJPwWSiQ+0jM3U0mQWQzezWn3UDKL8Iv+NZZeAB
	1+g6OyabgBWgWYTUBAqJX3WjrnokolA==
X-Google-Smtp-Source: AGHT+IEV6mYusUj8ULHke+1RPPJco+bwaOOORCvPCTttFeFfrfUKPgZ9QPG4zLl9wVzK07pSlcLnXXgBKQS8++ePE95q
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:690c:f94:b0:64a:e220:bfb5 with
 SMTP id 00721157ae682-666015f1508mr450367b3.1.1721255076965; Wed, 17 Jul 2024
 15:24:36 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:24:29 -0700
In-Reply-To: <20240717222429.2011540-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717222429.2011540-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717222429.2011540-4-axelrasmussen@google.com>
Subject: [PATCH 6.6 3/3] vfio/pci: Insert full vma on mmap'd MMIO fault
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
index 7b74c71a3169..b16678d186d3 100644
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


