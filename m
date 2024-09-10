Return-Path: <linux-kernel+bounces-324019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BD9746DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 244DCB213A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41B01C1ABC;
	Tue, 10 Sep 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJKoPEL5"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927B1C174F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011923; cv=none; b=rUGpsrqFKd0te7gww9F8DX6orVW8zTQzCZQnmYDKdfPq2RiNSEIRJ4a038XzF19P4OJ3E0eVR0boOc66cJ3ubzY65O3NAWqQmJL9/idr9Q0TkNwWxU4w6aWB/mvdEC4NEwA8nrf+crYPY4Nn0DRhGe37ciUlQ8N8kqGJVwYf4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011923; c=relaxed/simple;
	bh=ypXICWB7lHgzaCptTfWhJZz4InV12rYGuerAaDggmsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VkSxCwLGRmKfeq6ETn842aJllq9VYeq6mu5ubp/7ibCjxMi5oJvXXj2L4NbJuirHKDCjZki0F7kOxenhxhcL1IBzbDirC8mNuUarymAim7kNKikD1icsKjf+8sUwD+Qt6hm2j+mD5XJhb7euZfYZOmEJD4sKNon5dkCKmbVlmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJKoPEL5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d8e59fcd4bso1530073a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011922; x=1726616722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSL2kMUQX0MYfWs91FUoGWuk2V9BSwbXfpTOfw5RJmI=;
        b=jJKoPEL5Pmb45B+8+RMGJFvQC93LQAVhjpNR/kyelVwfPPqFRre9/i0SdBLdj0UTAB
         nr2v33YeiY1URdOoTpIEYnz+/azVVtYvHt2agFroaKkE9v3BxrSVE3BmTpIKXSwnUNJ5
         dZai4o3wpezTskOwtSAwWgXXdXLeIiAn19bik6cyexknaV8OloCJgC95n1f6XR9chRJg
         JBQp0b+ea50PrOOA18fyqUx0fvWlnFOA1e5C+KHDXBhoiJFhk5aMGcjgc17HYN2LG7bf
         L4bg825BkuQjFPuFpUAw9CUYohp2qNqhTaArPek9nYagDCdt+NDpmSWo66GI2Q9wJyqV
         lwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011922; x=1726616722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSL2kMUQX0MYfWs91FUoGWuk2V9BSwbXfpTOfw5RJmI=;
        b=qCnl6LcIaRPvgQIljY0g/TJ7TxAPvjsIgwwdYzHbcTemVKRw5Ur2gcaMUJD4j4KnWG
         L4bHvuGYggYuLwFcGMvOJI9oC2M9Yfg++ESDWMGvt6H5WIe9G9wI32zJXpqcKYGpi9Kb
         iLEpnCAiIlpYViVesNFF5lkGw1GVwhZd/Vmq242YwX4DFrY5J8FusiniGlBqXm5NHVHp
         tqnS8/ppY3VYHTKPFdgPJTlSOtSvfveGfUBTnpRiERQp2hnXFB+LtF0Ab7y08mlzVopa
         ayGpIxZFcawx2HJHexbu5Ww8NG+trny8vtbNERoiyPkRvVPuZVAbDa+K7q8l1n4HBEFC
         z8FA==
X-Forwarded-Encrypted: i=1; AJvYcCWwCTr/gD4wSDZ1hvJjszZHk19kBiiGwt52eRN6sEKBXNw6JdjP//svtf1vhg7Lehbl6C23i1LT1sKutn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ltCv9D7aOJp3eePQvW3cBg3Dwce8RDmderKNTVHmnfQXwbW1
	vt40Ms6JF+Sv8wUI+88lmUD/YI8wzsNq+dTGjBfBwdkOh0Ls5zejpXM8qORWOFgf1GLBGH4KFuS
	0oy2+Mjv+btlOubWsaEsWWA==
X-Google-Smtp-Source: AGHT+IHeEJa/t3gbMh3LQ6wjI0/JOXt73EyPzcfCUwf0I0tvYHeE0b/ouOGMNpZEECjGvQ2LqF2A810orFlmLkMS4Q==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:c2c5:b0:2d8:bf47:947c with
 SMTP id 98e67ed59e1d1-2db8304d552mr2449a91.3.1726011921647; Tue, 10 Sep 2024
 16:45:21 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:59 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <bf66353ee3338f11283a3f4b7ed1f06bd0b268a6.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 28/39] KVM: guest_memfd: Use vm_type to determine default faultability
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Memory of a KVM_X86_SW_PROTECTED_VM defaults to faultable to align
with the default in kvm->mem_attr_array.

For this RFC, determine default faultability when associating a range
with a memslot.

Another option is to determine default faultability at guest_memfd
creation time. guest_memfd is created for a specific VM, hence we can
set default faultability based on the VM type.

In future, if different struct kvms are bound to the same guest_memfd
inode, all the struct kvms must be of the same vm_type.

TODO: Perhaps faultability should be based on kvm->mem_attr_array?

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 virt/kvm/guest_memfd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fc2483e35876..1d4dfe0660ad 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1256,6 +1256,23 @@ static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
 	return file;
 }
 
+static void kvm_gmem_set_default_faultability_by_vm_type(struct inode *inode,
+							 u8 vm_type,
+							 loff_t start, loff_t end)
+{
+	bool faultable;
+
+	switch (vm_type) {
+	case KVM_X86_SW_PROTECTED_VM:
+		faultable = true;
+		break;
+	default:
+		faultable = false;
+	}
+
+	WARN_ON(kvm_gmem_set_faultable(inode, start, end, faultable));
+}
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
 	struct kvm_gmem *gmem;
@@ -1378,6 +1395,11 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	slot->gmem.pgoff = start;
 
 	xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL);
+
+	kvm_gmem_set_default_faultability_by_vm_type(file_inode(file),
+						     kvm->arch.vm_type,
+						     start, end);
+
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	/*
-- 
2.46.0.598.g6f2099f65c-goog


