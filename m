Return-Path: <linux-kernel+bounces-324018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B409746DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CAD1F26D36
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC55A1C1AAA;
	Tue, 10 Sep 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6yv1uUZ"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70421AED39
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011923; cv=none; b=bxBRNVHb69MQnyhdk3dmfWpioV1JBJCgwcbZrXa33Kyc2jFFBLvo8VQnN9jqWyEUkblFX9yNrYqg0ldKUbwA0ksojtKpU66KHfNTZeKBABrdjUAL1JvPls3Br7Bg7jY8xCJEIiJ51SwXc5iw/os1Krv9Av4LQB+O3EoiAjLC8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011923; c=relaxed/simple;
	bh=HDEODfs0sW9DcivdVbXGJVJf24chSDZ1+b7TBU5QrCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qaGxUimlw0tTydLo5DHsL/U3u8FuNd2Aq77wJL6W/hkdlh26h7lRMPm21j2Z2Rgi7l+GEwsDyNEwy+ZWBLNloaOSeChulUCwz2F0C7H11Zo+gKfhD8V5oqngZ+P3+EFGemT4bSJPV4xaZ6N2spWXO0rD2rG4sJxMdO8aPAtDCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y6yv1uUZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cbe272efa6so7146255a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011920; x=1726616720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=34wlcJFkfGNQzzb1hZdL7ujzeulibiS7N8dJMuUgV78=;
        b=Y6yv1uUZ1BTUTpadaccGK0CgdnG5qo6Av8UwKc8ujmKUD7nJFE6qIWjXAcGmH0hmWR
         bUEw2N56bXAOEA8K9zhtlFt1RuPbnGedMGnf1UHKK3oHo43947wBzPO1LxkNvjJvdVRL
         e3mOsdYBQvTSbkcIS4wN70mI2CEQyjNBueeO98xAL0CF6V7j2wi5j+wIEY7XrjLrKFJI
         uhOa1awuYB0bWnb2wlQ43QeBIPq5lOCyj7O8dUTlN9RBa2DMV986aKAlrgION4pXpgZs
         iL3cPHqf3kqay+PAzaaHM9X9WVemDidoCZ6jomBhTUVmG5bQyEhaozACxFTPzJm3ktN/
         AAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011920; x=1726616720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34wlcJFkfGNQzzb1hZdL7ujzeulibiS7N8dJMuUgV78=;
        b=rU1ytLEQeLrtERtxIohY4KjlJ/hceO4D4dgN8IUhMJ3+qU8IJ8XHGlNVuvYxOzbaoE
         T1mIdtw3TubqDYUT/Shp5lb9HJMJjEckHvxqvZzFIe/GVtMddDdPcnA3SvSsV3XS5QOl
         aPphujmsNAz+vdBama6EPlLrO3CnoaD7+1UQBH7k9+LmU+Ak5N9YB0x7A5rhjcoIAkDf
         mTnHvN1yInvk8SWYAWKM5uF5mRZGhrxI+CAxqzTK5vPxD1hY1qn1dpJYrrR5kh5JWoMW
         RYXeJAzNmvl+dGAAeSq6STHC7BA+FEk4wbhk1TssD5e46hqDD6PftmKsLAp0Yvv1+HAD
         D4jw==
X-Forwarded-Encrypted: i=1; AJvYcCVGvV/ZDUDhKnwgfBl2bKXJ1rFb6MDcajKhGd2mxIuLhZhI/ktaLtGCixRAKgb200E9TyzWjw+//zWFVQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFJJublIoOVE4IEmaqjaPEhJt/l9/FpSy7F60U75QUYfRxI/Y
	skrtwnbH1Z1+BX+prhhw9pvsJgLdmn+cEd0llGfhCsZTRSESn3kGDzuzHzn5b9L0Bf2obdrho8c
	QQUwyZ6JgUyGCoQ14SjDX+g==
X-Google-Smtp-Source: AGHT+IHhJHaKR4KPnPlGSVYGkBp4x4+Xb5fuhdBUkXuBYQ8usu5fhaV07d9H987RUToHw3cMQAZNLNO7RWO0YnhXdQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a65:41c6:0:b0:785:e3e:38db with SMTP
 id 41be03b00d2f7-7db08543c58mr8464a12.8.1726011919943; Tue, 10 Sep 2024
 16:45:19 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:58 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 27/39] KVM: guest_memfd: Allow mmapping guest_memfd files
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

guest_memfd files can always be mmap()ed to userspace, but
faultability is controlled by an attribute on the inode.

Co-developed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 virt/kvm/guest_memfd.c | 46 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b603518f7b62..fc2483e35876 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -781,7 +781,8 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct list_head *gmem_list = &inode->i_mapping->i_private_list;
 	pgoff_t start = offset >> PAGE_SHIFT;
-	pgoff_t end = (offset + len) >> PAGE_SHIFT;
+	pgoff_t nr = len >> PAGE_SHIFT;
+	pgoff_t end = start + nr;
 	struct kvm_gmem *gmem;
 
 	/*
@@ -790,6 +791,9 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	 */
 	filemap_invalidate_lock(inode->i_mapping);
 
+	/* TODO: Check if even_cows should be 0 or 1 */
+	unmap_mapping_range(inode->i_mapping, start, len, 0);
+
 	list_for_each_entry(gmem, gmem_list, entry)
 		kvm_gmem_invalidate_begin(gmem, start, end);
 
@@ -946,6 +950,9 @@ static void kvm_gmem_hugetlb_teardown(struct inode *inode)
 {
 	struct kvm_gmem_hugetlb *hgmem;
 
+	/* TODO: Check if even_cows should be 0 or 1 */
+	unmap_mapping_range(inode->i_mapping, 0, LLONG_MAX, 0);
+
 	truncate_inode_pages_final_prepare(inode->i_mapping);
 	kvm_gmem_hugetlb_truncate_folios_range(inode, 0, LLONG_MAX);
 
@@ -1003,11 +1010,46 @@ static void kvm_gmem_init_mount(void)
 	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
 	BUG_ON(IS_ERR(kvm_gmem_mnt));
 
-	/* For giggles. Userspace can never map this anyways. */
 	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
 }
 
+static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
+{
+	struct inode *inode;
+	struct folio *folio;
+
+	inode = file_inode(vmf->vma->vm_file);
+	if (!kvm_gmem_is_faultable(inode, vmf->pgoff))
+		return VM_FAULT_SIGBUS;
+
+	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
+	if (!folio)
+		return VM_FAULT_SIGBUS;
+
+	vmf->page = folio_file_page(folio, vmf->pgoff);
+	return VM_FAULT_LOCKED;
+}
+
+static const struct vm_operations_struct kvm_gmem_vm_ops = {
+	.fault = kvm_gmem_fault,
+};
+
+static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) !=
+	    (VM_SHARED | VM_MAYSHARE)) {
+		return -EINVAL;
+	}
+
+	file_accessed(file);
+	vm_flags_set(vma, VM_DONTDUMP);
+	vma->vm_ops = &kvm_gmem_vm_ops;
+
+	return 0;
+}
+
 static struct file_operations kvm_gmem_fops = {
+	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
 	.fallocate	= kvm_gmem_fallocate,
-- 
2.46.0.598.g6f2099f65c-goog


