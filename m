Return-Path: <linux-kernel+bounces-571748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1862A6C1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D2516A214
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FF230987;
	Fri, 21 Mar 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cmihxms7"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45B22FE10
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578663; cv=none; b=bMpIqUmZkoOitxIF7SwYd9AoRuk8on7l+tNomCwQZ69u2FF1cKXXtO2D5ljPGx9ltp2NjZD/rP7OC4nyJt1ugOxTEKmY/RZv6cp3qt1yotGG6bNNWJr6ky5LmSqXwa79wCvcdJhUwglgkayMSaAZ/SlSsvKnlRz/xC6Xd2LXeLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578663; c=relaxed/simple;
	bh=MwpQce1IYP/xVDV0ph309+450HY6pIxryaUDUtEC12Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eTjbFoLbXK8YgaLILQyBBR48ih/j8pDB1dVkOgMcIfEcDPaXgZ+QcBpHdwwjDS2r6P4uEOHwWaPwtYC52c9gEAM2wcZaCDl4AoncYCj3J4/PFmxtJsCsDkviSR0KkuXkGL4RImsOFhK1i5VOhYjhRG4QODNJODRefZrB+s/2usc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cmihxms7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224364f2492so32200915ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742578661; x=1743183461; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVY3EzVTKOjztz/iA3gGAorv/v23BkdoPGQ1O9sMpRg=;
        b=Cmihxms7VFHae7SGYlvavkpX7+m5uW7WB6zwR4FG9M8/UpMmmVW47uzFf+ngCK2LXJ
         L5/3nxkF1RnHyLj1c4ubGfcGecs7IWHnT6oucrMq3nmfn8azNZKMYMOdt9ewre0fyeEm
         xsiC2KNkrz+1BZ/xS3WyvwXPGEoqrdKQTlsRIm91ry+m6Jvz8TObwQsrBSGWKKAphQc+
         A+1ZvV27EMXOhuNKbx0an6txFeq/TKWXzDH3bL8vffRLQMp5mSBJATEFktju/PkQy20T
         b+MbQr2PUotHehP8ynvHTDCQhr9FMCbwdi4fyQ4tP25L6qS3li74IJ1cT44Rvl4wnXLq
         1YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742578661; x=1743183461;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVY3EzVTKOjztz/iA3gGAorv/v23BkdoPGQ1O9sMpRg=;
        b=WnkMkojOprsRG/+pAp0Y2B7efxp3rdC147QXqU4ABYg54kwhxTzA4VGDq8WHAWj2J7
         bASCLWCaq1xJKlkSuRRKzdzbdEcoS7IN0r0b3ZCso4Ml+6OP9uwPtJaZlvmgRFnFR1Lv
         ZZue/19gqB5qq38M/9uEmX8aQkx6wstdL0FpfQjFWyGe/QJmE2Joq/vncEVmnTtuXIBi
         E/q/E819AmKO/fw2YlacwMim2/98GUYMzDDZNcKiI17oGBcc0bwgBa81p4tSKEs7jTjx
         1iPm7geLVtoLmXEqZDUG4jc14EDggUUs8KityulpJpBe6/qGgeuNsT5Fwx7LtvP/tQ0c
         jzCw==
X-Forwarded-Encrypted: i=1; AJvYcCUBs8yAkx/sQHd7HH2KuCZfOkscwSeK9iaU2ugDfvYUHu3XluWpH9g7KgEzbb/FV7YPbnULVGiq1LOKgn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgxvxnLL6JRV0zwgvxwKK0RCwJTOTlQRcgUVQ261BHMmbfiwuW
	cwYtKYthzULiU7TQ4ItxE2S085bKvdAH02EO/pVSA2o0+DRswssseEeWJ629u8xxHVJeaw3tDP0
	8DedHMxRplLsbcesQYbBvcA==
X-Google-Smtp-Source: AGHT+IF+cvqsQFV2a6Y9/WZ27WhrC22Tdz6Ik3urAFxxcSKORKZ17tAg0m4s+cXw6DmZenA0G9mdHnaddcz52VU3Tw==
X-Received: from pfbdo13.prod.google.com ([2002:a05:6a00:4a0d:b0:736:a055:1ce3])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:218b:b0:736:7a00:e522 with SMTP id d2e1a72fcca58-7390593b7f2mr6721955b3a.2.1742578661516;
 Fri, 21 Mar 2025 10:37:41 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:37:28 +0000
In-Reply-To: <20250321173729.3175898-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321173729.3175898-1-souravpanda@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321173729.3175898-6-souravpanda@google.com>
Subject: [RFC PATCH 5/6] mm: trigger unmerge and remove SELECTIVE KSM partition
From: Sourav Panda <souravpanda@google.com>
To: mathieu.desnoyers@efficios.com, willy@infradead.org, david@redhat.com, 
	pasha.tatashin@soleen.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, weixugc@google.com, 
	gthelen@google.com, souravpanda@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Trigger unmerge or remove a partition using the
following sysfs interface:

Triggering an unmerge for a specific partition:
  echo "pid" > /sys/kernel/mm/ksm/partition_name/trigger_unmerge

Removing a partition:
  echo "partition_to_remove" >
	/sys/kernel/mm/ksm/control/remove_partition

Limitation of current implementation: On carrying out trigger_unmerge,
we unmerge all rmap items which is wrong. We should only unmerge the
rmap items that belong to the partition where we called unmerge.

Another limitation is that we do not specify the address range when
echoing into trigger unmerge. Intentionally left out till until we
determine the implementation feasibility.

Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 mm/ksm.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index b575250aaf45..fd7626d5d8c9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2556,6 +2556,31 @@ static void ksm_sync_merge(struct mm_struct *mm,
 	put_page(page);
 }
 
+static void ksm_sync_unmerge(struct mm_struct *mm)
+{
+	struct mm_slot *slot;
+	struct ksm_mm_slot *mm_slot;
+
+	struct vm_area_struct *vma;
+	struct vma_iterator vmi;
+
+	slot = mm_slot_lookup(mm_slots_hash, mm);
+	mm_slot = container_of(slot, struct ksm_mm_slot, slot);
+
+	ksm_scan.address = 0;
+	vma_iter_init(&vmi, mm, ksm_scan.address);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+			continue;
+		unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end, false);
+	}
+	remove_trailing_rmap_items(&mm_slot->rmap_list);
+
+	mmap_read_unlock(mm);
+}
+
 #else /* CONFIG_SELECTIVE_KSM */
 /*
  * Calculate skip age for the ksm page age. The age determines how often
@@ -3644,6 +3669,58 @@ static ssize_t trigger_merge_store(struct kobject *kobj,
 }
 KSM_ATTR(trigger_merge);
 
+static ssize_t trigger_unmerge_show(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    char *buf)
+{
+	return -EINVAL;	/* Not yet implemented */
+}
+
+static ssize_t trigger_unmerge_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	pid_t pid;
+	char *input, *ptr;
+	int ret;
+	struct task_struct *task;
+	struct mm_struct *mm;
+
+	input = kstrdup(buf, GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+
+	ptr = strim(input);
+	ret = kstrtoint(ptr, 10, &pid);
+	kfree(input);
+
+	/* Find the mm_struct */
+	rcu_read_lock();
+	task = find_task_by_vpid(pid);
+	if (!task) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	get_task_struct(task);
+
+	rcu_read_unlock();
+	mm = get_task_mm(task);
+	put_task_struct(task);
+
+	if (!mm)
+		return -EINVAL;
+
+	mutex_lock(&ksm_thread_mutex);
+	wait_while_offlining();
+	ksm_sync_unmerge(mm);
+	mutex_unlock(&ksm_thread_mutex);
+
+	mmput(mm);
+	return count;
+}
+KSM_ATTR(trigger_unmerge);
+
 #ifdef CONFIG_NUMA
 static ssize_t merge_across_nodes_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
@@ -4044,6 +4121,7 @@ static struct attribute *ksm_attrs[] = {
 	&pages_to_scan_attr.attr,
 	&run_attr.attr,
 	&trigger_merge_attr.attr,
+	&trigger_unmerge_attr.attr,
 	&pages_scanned_attr.attr,
 	&pages_shared_attr.attr,
 	&pages_sharing_attr.attr,
@@ -4156,9 +4234,51 @@ static ssize_t add_partition_store(struct kobject *kobj,
 static struct kobj_attribute add_kobj_attr = __ATTR(add_partition, 0220, NULL,
 						    add_partition_store);
 
+static ssize_t remove_partition_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct partition_kobj *partition;
+	struct partition_kobj *partition_found = NULL;
+	char partition_name[50];
+	int err = 0;
+
+	if (sscanf(buf, "%31s", partition_name) != 1)
+		return -EINVAL;
+
+	mutex_lock(&ksm_thread_mutex);
+
+	list_for_each_entry(partition, &partition_list, list) {
+		if (strcmp(kobject_name(partition->kobj), partition_name) == 0) {
+			partition_found = partition;
+			break;
+		}
+	}
+
+	if (!partition_found) {
+		err = -ENOENT;
+		goto unlock;
+	}
+
+	unmerge_and_remove_all_rmap_items();
+
+	kobject_put(partition_found->kobj);
+	list_del(&partition_found->list);
+	kfree(partition_found->root_stable_tree);
+	kfree(partition_found);
+
+unlock:
+	mutex_unlock(&ksm_thread_mutex);
+	return err ? err : count;
+}
+
+static struct kobj_attribute rm_kobj_attr = __ATTR(remove_partition, 0220, NULL,
+						   remove_partition_store);
+
 /* Array of attributes for base kobject */
 static struct attribute *ksm_base_attrs[] = {
 	&add_kobj_attr.attr,
+	&rm_kobj_attr.attr,
 	NULL,  /* NULL-terminated */
 };
 
-- 
2.49.0.395.g12beb8f557-goog


