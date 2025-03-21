Return-Path: <linux-kernel+bounces-571749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39559A6C1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CA33B22D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C95230BD1;
	Fri, 21 Mar 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbQMQx5E"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915BA22FF55
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578665; cv=none; b=oiM9mSwDwZpEkhM11Yh58BrGnXpo11lAvD74eoQR/hfGAReQB0E9BRW1bI/23e0POKSoGh4Szr02UjZwdJxg6sksncBgy8iKoJZ7ntRUmgyIkK9InMbmzmhL8mhngSdFM1O1SiGQZn2koQuid+SAkbdCuGYaj/7VgECzSeo4Odw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578665; c=relaxed/simple;
	bh=IV5KDKRwIWWBaHx1XZgeNA+fBEOe7w8Yoh7U/uZjyGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=A4XMVBoXpSn81zn0jlYw+f9Lz3ABP+TctUFier458bmIIbvQruCtXuGMzK0qGETRwHtLmznHFhI12qfoOfyICdCGLiyOdNuWDXEFm3b8KjwkIGnQldG+Ivr9TSHv6QxgLx9WfVQ/X0CZ3/2frHcYPSFdf9tuhybosYxDA+O+f8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbQMQx5E; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so3394056a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742578663; x=1743183463; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGIlFeRwp00cBGERgxxLQ4RbBbIFX2vI8pKUuAePCaE=;
        b=KbQMQx5E4HCCI1O7oiTYw83/0AzF7pwXebfVq/i+dLfdtZm1bTNfcbeTtNQMMQ+Zbf
         nurfb9JSYjGAYkkfqpqFxX5Upgm+lzAmM+yPfF/iJIhddZnyz9L6ZH+aJuAZLKlFx+KW
         LIe3wWCp2P3x5AhEcvls4nKez3UQy9PaxIdl943204TtIVPL8/ErUTqgMLTsxe+LY09Q
         QXMyrVrBFP//OLNXrXNwVzL/T70cSmPIk19q2yXjTNrR0/xAxtRZa359i/HGo6teqpn/
         5RMlP4RztXeTHr+m8jnDvVPVcpdKamDo7xAbweubzZZ+F/DbZElvr60NddP4oQofBsl2
         zTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742578663; x=1743183463;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGIlFeRwp00cBGERgxxLQ4RbBbIFX2vI8pKUuAePCaE=;
        b=WCpvWrypRJJWn3a6M0z3ijkbGKCUBgvzeyFRm3OmICL55+skaXNy0NOKbvxa6H/rK4
         /mJVRBv83sZuKDKmhkzjWQoou7FnoyTLZAoIoxP3zR78cooCTDZr6nVb1y5yjZDyRAGH
         0aInQMBOHofjfhilW+9BJa47aNQ+6GHFCvCDxdqX2qWgSMO0/JPwmcD4cOjDeKBtGgc0
         e5Y301ndjJA/KK3RavLXk5kHkcn3ydEF6vDjm5cncKacu0dyue2B+Ui6C+25CYzbAM87
         JHXW9yMHrBGIfhj1uBajl2KSpB3H+Va7LQLm0AXXH018zj+Fc3EhA8S8C+IKaJoyeziT
         8v9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaZCGTPDzc3vSe2chSgShMdBjvOJM/hOrNj4YlbMmFq9vZHOSwnVqnwCoPRkmdCXEGh/+INAOv4XLwkpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIGohQWzIJiXC8Mr+TaiMt7FV1N2NkawcMGoM8Q6zmAtl+SRQm
	HkeezUIL9ZY97GH0zw7eBniRARrTkhezT6bFHsGQ+Dx0001iNhAtoy5deA1q1CxMyPPh8zVwUPc
	Estd/iPWhTrucbJvtCK84/Q==
X-Google-Smtp-Source: AGHT+IEi+XabJeuTZlJOMXJIuxzHgrE4b595XPIHNxfB9i6zloVLdGL4AH5NwI1Pnt5e4UJSRIwRL82NwESkLDRViQ==
X-Received: from pjg4.prod.google.com ([2002:a17:90b:3f44:b0:301:2679:9aa])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:280b:b0:2ee:d824:b559 with SMTP id 98e67ed59e1d1-3030fef09b9mr6204491a91.28.1742578662931;
 Fri, 21 Mar 2025 10:37:42 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:37:29 +0000
In-Reply-To: <20250321173729.3175898-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321173729.3175898-1-souravpanda@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321173729.3175898-7-souravpanda@google.com>
Subject: [RFC PATCH 6/6] mm: syscall alternative for SELECTIVE_KSM
From: Sourav Panda <souravpanda@google.com>
To: mathieu.desnoyers@efficios.com, willy@infradead.org, david@redhat.com, 
	pasha.tatashin@soleen.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, weixugc@google.com, 
	gthelen@google.com, souravpanda@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Partition can be created or opened using:

  int ksm_fd = ksm_open(ksm_name, flag);
    name specifies the ksm partition to be created or opened.
    flags:
      O_CREAT
        Create the ksm partition object if it does not exist.
      O_EXCL
        If O_CREAT was also specified, and a ksm partition object
        with the given name already exists, return an error.

Trigger the merge using:
  ksm_merge(ksm_fd, pid, start_addr, size);

Limitation: Only supporting x86 syscall_64.

Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   3 +-
 include/linux/ksm.h                    |   4 +
 mm/ksm.c                               | 156 ++++++++++++++++++++++++-
 3 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5eb708bff1c7..352d747dbe33 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -390,7 +390,8 @@
 464	common	getxattrat		sys_getxattrat
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
-
+467	common	ksm_open		sys_ksm_open
+468	common	ksm_merge		sys_ksm_merge
 #
 # Due to a historical design error, certain syscalls are numbered differently
 # in x32 as compared to native x86_64.  These syscalls have numbers 512-547.
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index d73095b5cd96..a94c89403c29 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -14,6 +14,10 @@
 #include <linux/rmap.h>
 #include <linux/sched.h>
 
+#include <linux/anon_inodes.h>
+#include <linux/syscalls.h>
+#define MAX_KSM_NAME_LEN 128
+
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
diff --git a/mm/ksm.c b/mm/ksm.c
index fd7626d5d8c9..71558120b034 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -147,7 +147,8 @@ struct ksm_scan {
 static struct kobject *ksm_base_kobj;
 
 struct partition_kobj {
-	struct kobject *kobj;
+	struct kobject *kobj;	/* Not required for the syscall interface */
+	char name[MAX_KSM_NAME_LEN];
 	struct list_head list;
 	struct rb_root *root_stable_tree;
 	struct rb_root *root_unstable_tree;
@@ -166,6 +167,106 @@ static struct partition_kobj *find_partition_by_kobj(struct kobject *kobj)
 	return NULL;
 }
 
+static struct partition_kobj *find_ksm_partition(char *partition_name)
+{
+	struct partition_kobj *partition;
+
+	list_for_each_entry(partition, &partition_list, list) {
+		if (strcmp(partition->name, partition_name) == 0)
+			return partition;
+	}
+	return NULL;
+}
+
+static DEFINE_MUTEX(ksm_partition_lock);
+
+static int ksm_release(struct inode *inode, struct file *file)
+{
+	struct partition_kobj *ksm = file->private_data;
+
+	mutex_lock(&ksm_partition_lock);
+	list_del(&ksm->list);
+	mutex_unlock(&ksm_partition_lock);
+
+	kfree(ksm);
+	return 0;
+}
+
+static const struct file_operations ksm_fops = {
+	.release = ksm_release,
+};
+
+static struct partition_kobj *ksm_create_partition(char *ksm_name)
+{
+	struct partition_kobj *partition;
+	struct rb_root *tree_root;
+
+	partition = kzalloc(sizeof(*partition), GFP_KERNEL);
+	if (!partition)
+		return NULL;
+
+	tree_root = kcalloc(nr_node_ids + nr_node_ids, sizeof(*tree_root),
+			    GFP_KERNEL);
+	if (!tree_root)
+		return NULL;
+
+	partition->root_stable_tree = tree_root;
+	partition->root_unstable_tree = tree_root + nr_node_ids;
+	strncpy(partition->name, ksm_name, sizeof(partition->name));
+
+	list_add(&partition->list, &partition_list);
+
+	return partition;
+}
+
+static int ksm_partition_fd(struct partition_kobj *partition)
+{
+	int fd;
+	struct file *file;
+	int ret;
+
+	file = anon_inode_getfile("ksm_partition", &ksm_fops, partition, O_RDWR);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		return ret;
+	}
+
+	fd = get_unused_fd_flags(O_RDWR);
+	if (fd < 0) {
+		fput(file);
+		return fd;
+	}
+	fd_install(fd, file);
+	return fd;
+}
+
+SYSCALL_DEFINE2(ksm_open, const char __user *, ksm_name, int, flags) {
+	char name[MAX_KSM_NAME_LEN];
+	struct partition_kobj *partition;
+	int ret;
+
+	ret = strncpy_from_user(name, ksm_name, sizeof(name));
+	if (ret < 0)
+		return -EFAULT;
+
+	partition = find_ksm_partition(name);
+
+	if (flags & O_EXCL && partition) /* Partition already exists, return error */
+		return -EEXIST;
+
+	if (flags & O_CREAT && !partition) {
+		/* Partition does not exist, but we are allowed to create one */
+		mutex_lock(&ksm_partition_lock);
+		partition = ksm_create_partition(name);
+		mutex_unlock(&ksm_partition_lock);
+	}
+
+	if (!partition)
+		return flags & O_CREAT ? -ENOMEM : -ENOENT;
+
+	return ksm_partition_fd(partition);
+}
+
 /**
  * struct ksm_stable_node - node of the stable rbtree
  * @node: rb node of this ksm page in the stable tree
@@ -4324,6 +4425,59 @@ static int __init ksm_thread_sysfs_init(void)
 }
 #endif /* CONFIG_SELECTIVE_KSM */
 
+SYSCALL_DEFINE4(ksm_merge, int, ksm_fd, pid_t, pid, unsigned long, start, size_t, size) {
+	unsigned long end = start + size;
+	struct task_struct *task;
+	struct mm_struct *mm;
+	struct partition_kobj *partition;
+	struct file *file;
+
+	file = fget(ksm_fd);
+	if (!file)
+		return -EBADF;
+
+	partition = file->private_data;
+	if (!partition) {
+		fput(file);
+		return -EINVAL;
+	}
+
+	if (start >= end) {
+		fput(file);
+		return -EINVAL;
+	}
+
+	/* Find the mm_struct */
+	rcu_read_lock();
+	task = find_task_by_vpid(pid);
+	if (!task) {
+		fput(file);
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
+	if (!mm) {
+		fput(file);
+		return -EINVAL;
+	}
+
+	mutex_lock(&ksm_thread_mutex);
+	wait_while_offlining();
+	ksm_sync_merge(mm, start, end, partition);
+	mutex_unlock(&ksm_thread_mutex);
+
+	mmput(mm);
+
+	fput(file);
+	return 0;
+}
+
 static int __init ksm_init(void)
 {
 	int err;
-- 
2.49.0.395.g12beb8f557-goog


