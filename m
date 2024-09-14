Return-Path: <linux-kernel+bounces-329271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A7B978F69
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C2A1C21B14
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E8A1CEE99;
	Sat, 14 Sep 2024 09:20:55 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAD19DF9A
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305654; cv=none; b=i7Kh7muwcHmUe698LZtqG9Y4jgV3vXrdNlDFnE04RHBkhpyKvgX41imLdCm/KtfsdQubRyFLbMxjeAveC/xvIgtieYH4SMZz5O2Fbx5HrqZn/CCLhLJyu5nDFsFnYKq0nGx//qjn+mLWZZKWfL7RkNyZ3h9KMRk22xzN3OJ21h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305654; c=relaxed/simple;
	bh=DLo+EcGqaZDWB7H/W7ke3SvSeNY+Py+cKnrgjWY+JOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6yErnZZle2rMQQV0RU9AVXDfPC4RF/JIsKo7XogLU3UKiKyzagYijQwdF96NccVe/NQHs0JvVpJEmJSzPdaTrNZe0okgv0bNC5tKIUXMhCWNNrMG3ymYzPiLR/cbIuKyEwXzl1cIZNgJ6uSXK5sQKZB6DUPr2UJJN6S7aja8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726305646-1eb14e31a7105f90001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id MoHhmU3hjOb2miEq (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 14 Sep 2024 17:20:46 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 17:20:45 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 17:20:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Sat, 14 Sep 2024 17:20:42 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from zx4.zhaoxin.com (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 16:53:28 +0800
From: yongli-oc <yongli-oc@zhaoxin.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
Subject: [PATCH 4/4] locking/osq_lock: The numa-aware lock memory prepare, assign and cleanup.
Date: Sat, 14 Sep 2024 16:53:27 +0800
X-ASG-Orig-Subj: [PATCH 4/4] locking/osq_lock: The numa-aware lock memory prepare, assign and cleanup.
Message-ID: <20240914085327.32912-5-yongli-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/14/2024 5:20:40 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1726305646
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 15130
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130433
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

The numa-aware lock kernel memory cache preparation, and a
workqueue to turn numa-aware lock back to osq lock.
The /proc interface. Enable dynamic switch by
echo 1 > /proc/zx_numa_lock/dynamic_enable

Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
---
 kernel/locking/zx_numa.c | 537 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 537 insertions(+)
 create mode 100644 kernel/locking/zx_numa.c

diff --git a/kernel/locking/zx_numa.c b/kernel/locking/zx_numa.c
new file mode 100644
index 000000000000..89df6670a024
--- /dev/null
+++ b/kernel/locking/zx_numa.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Dynamic numa-aware osq lock
+ * Crossing from numa-aware lock to osq_lock
+ * Numa lock memory initialize and /proc interface
+ * Author: LiYong <yongli-oc@zhaoxin.com>
+ *
+ */
+#include <linux/cpumask.h>
+#include <asm/byteorder.h>
+#include <asm/kvm_para.h>
+#include <linux/percpu.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/osq_lock.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+#include <linux/reboot.h>
+
+#include "numa.h"
+#include "numa_osq.h"
+
+int enable_zx_numa_osq_lock;
+struct delayed_work zx_numa_start_work;
+struct delayed_work zx_numa_cleanup_work;
+
+atomic_t numa_count;
+struct _numa_buf *zx_numa_entry;
+int zx_numa_lock_total =3D 256;
+LIST_HEAD(_zx_numa_head);
+LIST_HEAD(_zx_numa_lock_head);
+
+struct kmem_cache *zx_numa_entry_cachep;
+struct kmem_cache *zx_numa_lock_cachep;
+int NUMASHIFT;
+int NUMACLUSTERS;
+static atomic_t lockindex;
+int dynamic_enable;
+
+static const struct numa_cpu_info numa_cpu_list[] =3D {
+	/*feature1=3D1, a numa node includes two clusters*/
+	//{1, 23, X86_VENDOR_AMD, 0, 1},
+	{0x5b, 7, X86_VENDOR_CENTAUR, 0, 1},
+	{0x5b, 7, X86_VENDOR_ZHAOXIN, 0, 1}
+};
+
+inline void *get_numa_lock(int index)
+{
+	if (index >=3D 0 && index < zx_numa_lock_total)
+		return zx_numa_entry[index].numa_ptr;
+	else
+		return NULL;
+}
+
+static int zx_get_numa_shift(int all_cpus, int clusters)
+{
+	int cpus =3D (int) all_cpus/clusters;
+	int count =3D 0;
+
+	while (cpus) {
+		cpus >>=3D 1;
+		count++;
+	}
+	return count-1;
+}
+
+void numa_lock_init_data(struct _numa_lock *s, int clusters,
+			u32 lockval, u32 lockaddr)
+{
+	int j =3D 0;
+
+	for (j =3D 0; j < clusters + NUMAEXPAND; j++) {
+		atomic_set(&(s + j)->tail, lockval);
+		atomic_set(&(s + j)->addr, lockaddr);
+		(s + j)->shift =3D NUMASHIFT;
+		(s + j)->stopping =3D 0;
+		(s + j)->numa_nodes =3D clusters;
+		(s + j)->accessed =3D 0;
+		(s + j)->totalaccessed =3D 0;
+		(s + j)->nodeswitched =3D 0;
+		atomic_set(&(s + j)->initlock, 0);
+		atomic_set(&(s + j)->pending, 0);
+	}
+}
+
+int zx_numa_lock_ptr_get(void *p)
+{
+	int i =3D 0;
+	int index =3D 0;
+
+	if (atomic_read(&numa_count) >=3D zx_numa_lock_total)
+		return zx_numa_lock_total;
+
+	index =3D atomic_inc_return(&lockindex);
+
+	for (i =3D 0; i < zx_numa_lock_total; i++) {
+		if (index >=3D zx_numa_lock_total)
+			index =3D 0;
+		if (cmpxchg(&zx_numa_entry[index].lockaddr,
+					0, ptrmask(p)) =3D=3D 0) {
+			while (1) {
+				struct _numa_lock *node_lock =3D
+					zx_numa_entry[index].numa_ptr;
+				struct _numa_lock *numa_lock =3D node_lock +
+						node_lock->numa_nodes;
+
+				if (atomic_read(&numa_lock->tail) =3D=3D
+								NUMA_LOCKED_VAL)
+					break;
+				cpu_relax();
+
+			}
+			atomic_inc(&numa_count);
+			zx_numa_entry[index].highaddr =3D ((u64)p) >> 32;
+			atomic_set(&lockindex, index);
+			return index;
+		}
+		index++;
+		if (atomic_read(&numa_count) >=3D zx_numa_lock_total)
+			break;
+	}
+	return zx_numa_lock_total;
+}
+
+int zx_check_numa_dynamic_locked(u32 lockaddr,
+		struct _numa_lock *_numa_lock, int t)
+{
+	struct _numa_lock *node_lock =3D NULL;
+	u64 s =3D -1;
+	int i =3D 0;
+
+	if (atomic_read(&_numa_lock->pending) !=3D 0)
+		return 1;
+
+	for (i =3D 0; i < _numa_lock->numa_nodes + 1; i++) {
+		node_lock =3D _numa_lock + i;
+		cpu_relax(); cpu_relax(); cpu_relax(); cpu_relax();
+		s =3D atomic64_read((atomic64_t *) &node_lock->tail);
+		if ((s >> 32) !=3D lockaddr)
+			continue;
+		if ((s & LOW32MASK) =3D=3D NUMA_LOCKED_VAL
+				|| (s & LOW32MASK) =3D=3D NUMA_UNLOCKED_VAL)
+			continue;
+		break;
+	}
+
+	if (i =3D=3D _numa_lock->numa_nodes + 1)
+		return 0;
+	return i+1;
+}
+
+static int zx_numa_lock64_try_to_freeze(u32 lockaddr, struct _numa_lock *_=
numa_lock,
+			int index)
+{
+	struct _numa_lock *node_lock =3D NULL;
+	u64 addr =3D ((u64)lockaddr) << 32;
+	u64 s =3D 0;
+	u64 ff =3D 0;
+	int i =3D 0;
+
+	for (i =3D 0; i < _numa_lock->numa_nodes+1; i++) {
+		node_lock =3D _numa_lock + i;
+		cpu_relax();
+
+		s =3D atomic64_read((atomic64_t *)&node_lock->tail);
+		if ((s & HIGH32BITMASK) !=3D addr)
+			continue;
+
+		if ((s & LOW32MASK) =3D=3D NUMA_LOCKED_VAL)
+			continue;
+
+		if ((s & LOW32MASK) =3D=3D NUMA_UNLOCKED_VAL) {
+			ff =3D atomic64_cmpxchg((atomic64_t *)&node_lock->tail,
+				(addr|NUMA_UNLOCKED_VAL), NUMA_LOCKED_VAL);
+			if (ff =3D=3D (addr|NUMA_UNLOCKED_VAL))
+				continue;
+		}
+		break;
+	}
+
+	if (i =3D=3D _numa_lock->numa_nodes + 1) {
+		zx_numa_entry[index].idle =3D 0;
+		zx_numa_entry[index].type =3D 0;
+		zx_numa_entry[index].highaddr =3D 0;
+		xchg(&zx_numa_entry[index].lockaddr, 0);
+	}
+
+	return i;
+}
+
+static void zx_numa_lock_stopping(struct _numa_lock *_numa_lock)
+{
+	struct _numa_lock *node_lock =3D NULL;
+	int i =3D 0;
+
+	for (i =3D 0; i < _numa_lock->numa_nodes+1; i++) {
+		node_lock =3D _numa_lock + i;
+		WRITE_ONCE(node_lock->stopping, 1);
+	}
+}
+
+static void zx_numa_cleanup(struct work_struct *work)
+{
+	int i =3D 0;
+	int checktimes =3D 2;
+
+	//reboot or power off state
+	if (READ_ONCE(enable_zx_numa_osq_lock) =3D=3D 0xf)
+		return;
+
+	if (atomic_read(&numa_count) =3D=3D 0) {
+		if (READ_ONCE(dynamic_enable) !=3D 0)
+			schedule_delayed_work(&zx_numa_cleanup_work, 60*HZ);
+		return;
+	}
+
+	for (i =3D 0; i < zx_numa_lock_total; i++) {
+		int s =3D 0;
+		u32 lockaddr =3D READ_ONCE(zx_numa_entry[i].lockaddr);
+		u32 type =3D zx_numa_entry[i].type;
+		struct _numa_lock *buf =3D  zx_numa_entry[i].numa_ptr;
+		int nodes =3D 0;
+
+		if (lockaddr =3D=3D 0 || type =3D=3D 3 || zx_numa_entry[i].idle =3D=3D 0=
)
+			continue;
+		nodes =3D buf->numa_nodes;
+		if (zx_numa_entry[i].idle < checktimes) {
+
+			s =3D zx_check_numa_dynamic_locked(lockaddr, buf, 1);
+			if (s !=3D 0) {
+				zx_numa_entry[i].idle =3D 1;
+				continue;
+			}
+			zx_numa_entry[i].idle++;
+		}
+
+		if (zx_numa_entry[i].idle =3D=3D checktimes) {
+			zx_numa_lock_stopping(buf);
+			zx_numa_entry[i].idle++;
+
+		}
+
+		if (zx_numa_entry[i].idle =3D=3D checktimes+1) {
+			while (1) {
+				if (zx_numa_lock64_try_to_freeze(lockaddr, buf,
+						i) =3D=3D nodes + 1) {
+					//all node has been locked
+					u32 left =3D 0;
+
+					left =3D atomic_dec_return(&numa_count);
+					break;
+				}
+				cpu_relax(); cpu_relax();
+				cpu_relax(); cpu_relax();
+			}
+		}
+	}
+	schedule_delayed_work(&zx_numa_cleanup_work, 60*HZ);
+}
+
+static int create_numa_buffer_list(int clusters, int len)
+{
+	int i =3D 0;
+
+	for (i =3D 0; i < zx_numa_lock_total; i++) {
+		struct _numa_lock *s =3D (struct _numa_lock *)kmem_cache_alloc(
+				zx_numa_lock_cachep, GFP_KERNEL);
+		if (!s) {
+			while (i > 0) {
+				kmem_cache_free(zx_numa_lock_cachep,
+						zx_numa_entry[i-1].numa_ptr);
+				i--;
+			}
+			return 0;
+		}
+		memset((char *)s, 0,
+			len * L1_CACHE_BYTES * (clusters + NUMAEXPAND));
+		numa_lock_init_data(s, clusters, NUMA_LOCKED_VAL, 0);
+		zx_numa_entry[i].numa_ptr =3D s;
+		zx_numa_entry[i].lockaddr =3D 0;
+		zx_numa_entry[i].highaddr =3D 0;
+		zx_numa_entry[i].idle =3D 0;
+		zx_numa_entry[i].type =3D 0;
+	}
+
+	for (i =3D 0; i < zx_numa_lock_total; i++) {
+		zx_numa_entry[i].index =3D i;
+		list_add_tail(&(zx_numa_entry[i].list), &_zx_numa_lock_head);
+	}
+	return 1;
+}
+
+static int zx_numa_lock_init(int numa)
+{
+	int align =3D max_t(int, L1_CACHE_BYTES, ARCH_MIN_TASKALIGN);
+	int d =3D 0;
+	int status =3D 0;
+
+	atomic_set(&lockindex, 0);
+	atomic_set(&numa_count, 0);
+
+	if (sizeof(struct _numa_lock) & 0x3f)
+		d =3D (int)((sizeof(struct _numa_lock) + L1_CACHE_BYTES) /
+			  L1_CACHE_BYTES);
+	else
+		d =3D (int)(sizeof(struct _numa_lock) / L1_CACHE_BYTES);
+
+	zx_numa_entry_cachep =3D kmem_cache_create(
+		"zx_numa_entry",
+		sizeof(struct _numa_buf) * zx_numa_lock_total, align,
+		SLAB_PANIC | SLAB_ACCOUNT, NULL);
+
+	zx_numa_lock_cachep =3D kmem_cache_create(
+		"zx_numa_lock",
+		d * L1_CACHE_BYTES * (numa + NUMAEXPAND), align,
+		SLAB_PANIC | SLAB_ACCOUNT, NULL);
+
+
+	if (zx_numa_entry_cachep && zx_numa_lock_cachep) {
+		zx_numa_entry =3D (struct _numa_buf *)kmem_cache_alloc(
+				zx_numa_entry_cachep, GFP_KERNEL);
+		if (zx_numa_entry) {
+			memset((char *)zx_numa_entry, 0,
+				sizeof(struct _numa_buf) * zx_numa_lock_total);
+			create_numa_buffer_list(numa, d);
+			status =3D 1;
+		}
+	}
+
+	pr_info("enable dynamic numa-aware osq_lock, clusters %d\n",
+		numa);
+	return status;
+}
+
+
+#define numa_lock_proc_dir "zx_numa_lock"
+#define zx_numa_enable_dir "dynamic_enable"
+#define numa_entry_total 8
+struct proc_dir_entry *numa_lock_proc;
+struct proc_dir_entry *numa_lock_enable;
+struct proc_dir_entry *numa_proc_entry[numa_entry_total];
+
+static ssize_t numa_lock_proc_read(struct file *file,
+		char __user *usrbuf, size_t len, loff_t *off)
+{
+	int id =3D (long) pde_data(file_inode(file));
+	char kbuffer[128];
+	ssize_t retval =3D 0;
+	size_t n =3D 0;
+
+	memset(kbuffer, 0, sizeof(kbuffer));
+	if (id =3D=3D 0)
+		n =3D sprintf(kbuffer, "%d\n", READ_ONCE(dynamic_enable));
+	else if (id =3D=3D 1)
+		n =3D sprintf(kbuffer, "%d\n", READ_ONCE(osq_lock_depth));
+	else if (id =3D=3D 2)
+		n =3D sprintf(kbuffer, "%d\n", READ_ONCE(osq_keep_times));
+	else if (id =3D=3D 3)
+		n =3D sprintf(kbuffer, "%d\n", READ_ONCE(osq_node_max));
+	else if (id =3D=3D 4)
+		n =3D sprintf(kbuffer, "%d\n", atomic_read(&numa_count));
+	retval =3D simple_read_from_buffer(usrbuf, len, off, kbuffer, n);
+
+	return retval;
+}
+
+static ssize_t numa_lock_proc_write(struct file *file,
+		const char __user *buffer, size_t count, loff_t *f_pos)
+{
+	int id =3D (long) pde_data(file_inode(file));
+	char kbuffer[128];
+	unsigned long new =3D 0;
+	int err =3D 0;
+
+	memset(kbuffer, 0, sizeof(kbuffer));
+	if (copy_from_user(kbuffer, buffer, count))
+		return count;
+	kbuffer[count] =3D '\0';
+	err =3D kstrtoul(kbuffer, 10, &new);
+
+	if (id =3D=3D 0) {
+		int last =3D READ_ONCE(dynamic_enable);
+
+		if (new < 0 || new >=3D 2 || last =3D=3D new)
+			return count;
+
+		if (last =3D=3D 0) {
+			prefetchw(&enable_zx_numa_osq_lock);
+			//enable to the 2-bytes-tail osq-lock
+			prefetchw(&enable_zx_numa_osq_lock);
+			WRITE_ONCE(enable_zx_numa_osq_lock, 2);
+			schedule_delayed_work(&zx_numa_cleanup_work, 60*HZ);
+		}
+		prefetchw(&dynamic_enable);
+		WRITE_ONCE(dynamic_enable, new);
+		return count;
+	}
+
+	if (READ_ONCE(dynamic_enable) !=3D 0) {
+		pr_info("dynamic %d: change setting should disable dynamic\n",
+			dynamic_enable);
+		return count;
+	}
+	if (id =3D=3D 1 && new > 4 && new <=3D 32)
+		WRITE_ONCE(osq_lock_depth, new);
+	else if (id =3D=3D 2 && new >=3D 16 && new <=3D 2048)
+		WRITE_ONCE(osq_keep_times, new);
+	else if (id =3D=3D 3 && new > 4 && new <=3D 2048)
+		WRITE_ONCE(osq_node_max, new);
+	return count;
+}
+static int numa_lock_proc_show(struct seq_file *m, void *v)
+{
+	return 0;
+}
+
+static int numa_lock_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, numa_lock_proc_show, NULL);
+}
+static const struct proc_ops numa_lock_proc_fops =3D {
+	.proc_open =3D numa_lock_proc_open,
+	.proc_read =3D numa_lock_proc_read,
+	.proc_write =3D numa_lock_proc_write
+};
+
+static int numalock_proc_init(void)
+{
+	int index =3D 0;
+	int i =3D 0;
+
+	numa_lock_proc =3D proc_mkdir(numa_lock_proc_dir, NULL);
+	if (numa_lock_proc =3D=3D NULL) {
+		pr_info("%s proc create %s failed\n", __func__,
+				numa_lock_proc_dir);
+		return -EINVAL;
+	}
+
+	numa_lock_enable =3D proc_create_data(zx_numa_enable_dir, 0666,
+		numa_lock_proc, &numa_lock_proc_fops, (void *)(long)index++);
+	if (!numa_lock_enable) {
+		pr_info("%s proc_create_data %s failed!\n", __func__,
+				zx_numa_enable_dir);
+		return -ENOMEM;
+	}
+
+	for (i =3D 0; i < numa_entry_total; i++)
+		numa_proc_entry[i] =3D NULL;
+
+	numa_proc_entry[0] =3D  proc_create_data("osq_lock_depth", 0664,
+		numa_lock_proc, &numa_lock_proc_fops, (void *)(long)index++);
+	numa_proc_entry[1] =3D  proc_create_data("osq_keep_times", 0664,
+		numa_lock_proc, &numa_lock_proc_fops, (void *)(long)index++);
+	numa_proc_entry[2] =3D  proc_create_data("osq_node_max", 0664,
+		numa_lock_proc, &numa_lock_proc_fops, (void *)(long)index++);
+	numa_proc_entry[3] =3D  proc_create_data("numa_osq_lock", 0444,
+		numa_lock_proc, &numa_lock_proc_fops, (void *)(long)index++);
+	return 0;
+}
+
+static void numalock_proc_exit(void)
+{
+	int i =3D 0;
+
+	for (i =3D 0; i < numa_entry_total; i++) {
+		if (numa_proc_entry[i])
+			proc_remove(numa_proc_entry[i]);
+	}
+	if (numa_lock_enable)
+		proc_remove(numa_lock_enable);
+	if (numa_lock_proc)
+		remove_proc_entry(numa_lock_proc_dir, NULL);
+
+}
+
+static int numalock_shutdown_notify(struct notifier_block *unused1,
+		unsigned long unused2, void *unused3)
+{
+	if (READ_ONCE(enable_zx_numa_osq_lock) =3D=3D 2) {
+		WRITE_ONCE(dynamic_enable, 0);
+		WRITE_ONCE(enable_zx_numa_osq_lock, 0xf);
+	}
+	return NOTIFY_DONE;
+}
+static struct notifier_block numalock_shutdown_nb =3D {
+	.notifier_call =3D numalock_shutdown_notify,
+};
+static int __init zx_numa_base_init(void)
+{
+	int cpu =3D num_possible_cpus();
+	int i =3D 0;
+
+	WRITE_ONCE(enable_zx_numa_osq_lock, 0);
+	if (kvm_para_available())
+		return 0;
+	if (cpu >=3D 65534 || cpu < 16 || (cpu & 0x7) !=3D 0)
+		return 0;
+
+	for (i =3D 0; i < ARRAY_SIZE(numa_cpu_list); i++) {
+		if (boot_cpu_data.x86_vendor =3D=3D numa_cpu_list[i].x86_vendor &&
+			boot_cpu_data.x86 =3D=3D numa_cpu_list[i].x86 &&
+			boot_cpu_data.x86_model =3D=3D numa_cpu_list[i].x86_model) {
+
+			if (numa_cpu_list[i].feature1 =3D=3D 1)
+				NUMACLUSTERS =3D nr_node_ids + nr_node_ids;
+			NUMASHIFT =3D zx_get_numa_shift(num_possible_cpus(),
+					NUMACLUSTERS);
+
+			if (zx_numa_lock_init(NUMACLUSTERS) =3D=3D 0)
+				return -ENOMEM;
+			register_reboot_notifier(&numalock_shutdown_nb);
+			numalock_proc_init();
+			INIT_DELAYED_WORK(&zx_numa_cleanup_work,
+				zx_numa_cleanup);
+			prefetchw(&enable_zx_numa_osq_lock);
+			WRITE_ONCE(enable_zx_numa_osq_lock, 1);
+			return 0;
+		}
+	}
+	return 0;
+}
+
+static void __exit zx_numa_lock_exit(void)
+{
+	numalock_proc_exit();
+	prefetchw(&dynamic_enable);
+	WRITE_ONCE(dynamic_enable, 0);
+}
+
+late_initcall(zx_numa_base_init);
+module_exit(zx_numa_lock_exit);
+MODULE_AUTHOR("LiYong <yongli-oc@zhaoxin.com>");
+MODULE_DESCRIPTION("zx dynamic numa-aware osq lock");
+MODULE_LICENSE("GPL");
+
--=20
2.34.1


