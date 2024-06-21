Return-Path: <linux-kernel+bounces-224245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18934911F51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A14C1F27C13
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76A16DEB6;
	Fri, 21 Jun 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ojlhpd9j"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CD616DEC9;
	Fri, 21 Jun 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959879; cv=none; b=LCOkY0QfEJjkWzmRvSk7TZvCnqmdcygdlVupVwUVs0Dh4k9beII64O26+0K5AVC1gk7vyXF0fy7JeMsfYlej9y6hJKoJGV+PU/2qzPSU1OTIMB857NnQbFnGbczJBObHj8/AULmgoW4ENWZ/SGnKEZg8axR866KcmTbIsto17Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959879; c=relaxed/simple;
	bh=MlEE5bP5mVqm0UBIC1nRtLKrlXm2KJOOePQCo0DUNiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQitcWZEd7UUmjg+auG5qk2HITIZgB5ZbLpRZORaiLXnK0S2xBMj9JoDXKKdXUxa5b1C8o97LRgrShwOa7txLxJjt+FW2Bd9H62aOLzAHXH0kpEJKEh6LwD/NQWeT6CpnhW+o4FEbZA7q5ex7aCS8g5jz7RBw7RH31XvQ2Fs5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ojlhpd9j; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=7fK2nDbOPCfTVnFCT5bgdfJtFqNYEKbXiLXo72br+wo=;
	b=ojlhpd9jbMHFwsXeF1MR4/h6K5zVSnjIwOkuzy4nimC3HEuErsMgUVRP5HHI/3
	JUIDRErnEDVOLU8aYi/ZMQivvFw3Vmx/4QyNp+ilLmswzSdyrlCJojKXAOgNLLRZ
	xmK6VjX4Xl6s9W1dQXJbP/jGiffVuuotxYDW1meRzNQK0=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wD3H6SzPnVmZ4KwJA--.49714S2;
	Fri, 21 Jun 2024 16:49:55 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: longman@redhat.com,
	mkoutny@suse.com
Cc: lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-cpuset v5 1/2] Union-Find: add a new module in kernel library
Date: Fri, 21 Jun 2024 16:49:51 +0800
Message-Id: <20240621084952.209770-2-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621084952.209770-1-xavier_qy@163.com>
References: <b511173c-53fe-4a93-8030-d99ed1b65bd6@redhat.com>
 <20240621084952.209770-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H6SzPnVmZ4KwJA--.49714S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfJw48ury7Gw1ftw4kuFyxuFg_yoWkAFyfpF
	sxGryfZa1DJ34Uury0krW5Aw4Sva1rGrWUGayxG3W0yrnxAr10qF4jy34rtr95Gry2kF18
	XF4agr15A3WUJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfnYcUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYxkFEGV4I3AuRQAAsK

This patch implements a union-find data structure in the kernel library,
which includes operations for allocating nodes, freeing nodes,
finding the root of a node, and merging two nodes.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 Documentation/core-api/union_find.rst         | 110 ++++++++++++++++++
 .../zh_CN/core-api/union_find.rst             |  87 ++++++++++++++
 MAINTAINERS                                   |   9 ++
 include/linux/union_find.h                    |  30 +++++
 lib/Makefile                                  |   2 +-
 lib/union_find.c                              |  38 ++++++
 6 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/core-api/union_find.rst
 create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
 create mode 100644 include/linux/union_find.h
 create mode 100644 lib/union_find.c

diff --git a/Documentation/core-api/union_find.rst b/Documentation/core-api/union_find.rst
new file mode 100644
index 0000000000..7109ad608a
--- /dev/null
+++ b/Documentation/core-api/union_find.rst
@@ -0,0 +1,110 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Union-Find in Linux
+====================
+
+
+:Date: June 21, 2024
+:Author: Xavier <xavier_qy@163.com>
+
+What is Union-Find, and what is it used for?
+------------------------------------------------
+
+Union-Find is a data structure used to handle the merging and querying
+of disjoint sets. The primary operations supported by Union-Find are:
+
+	Initialization: Resetting each element as an individual set, with
+		each set's initial parent node pointing to itself.
+	Find: Determine which set a particular element belongs to, usually by
+		returning a “representative element” of that set. This operation
+		is used to check if two elements are in the same set.
+	Union: Merge two sets into one.
+
+As a data structure used to maintain sets (groups), Union-Find is commonly
+utilized to solve problems related to offline queries, dynamic connectivity,
+and graph theory. It is also a key component in Kruskal's algorithm for
+computing the minimum spanning tree, which is crucial in scenarios like
+network routing. Consequently, Union-Find is widely referenced. Additionally,
+Union-Find has applications in symbolic computation, register allocation,
+and more.
+
+Space Complexity: O(n), where n is the number of nodes.
+
+Time Complexity: Using path compression can reduce the time complexity of
+the find operation, and using union by rank can reduce the time complexity
+of the union operation. These optimizations reduce the average time
+complexity of each find and union operation to O(α(n)), where α(n) is the
+inverse Ackermann function. This can be roughly considered a constant time
+complexity for practical purposes.
+
+This document covers use of the Linux union-find implementation.  For more
+information on the nature and implementation of Union-Find,  see:
+
+  Wikipedia entry on union-find
+    https://en.wikipedia.org/wiki/Disjoint-set_data_structure
+
+Linux implementation of union-find
+-----------------------------------
+
+Linux's union-find implementation resides in the file "lib/union_find.c".
+To use it, "#include <linux/union_find.h>".
+
+The Union-Find data structure is defined as follows::
+
+	struct uf_node {
+		struct uf_node *parent;
+		unsigned int rank;
+	};
+
+In this structure, parent points to the parent node of the current node.
+For efficiency, it is initialized to NULL and is assigned to point to itself
+during the first find operation. The rank field represents the height of the
+current tree. During a union operation, the tree with the smaller rank is
+attached under the tree with the larger rank to maintain balance.
+
+Creating Union-Find
+--------------------
+
+To create a Union-Find structure, you only need to pass the number of nodes in
+the Union-Find. No additional initialization is required, and it returns a
+pointer to the node array.
+Example::
+
+	struct uf_node *my_node = uf_nodes_alloc(num);
+
+Destroying Union-Find
+---------------------
+
+To destroy the Union-Find structure, just pass the node pointer that was
+returned during creation.
+Example::
+
+	uf_nodes_free(my_node);
+
+Find the Root Node of Union-Find
+--------------------------------
+
+This operation is mainly used to determine whether two nodes belong to the same
+set in the Union-Find. If they have the same root, they are in the same set.
+During the find operation, path compression is performed to improve the
+efficiency of subsequent find operations.
+Example::
+
+	int connected;
+	struct uf_node *root1 = uf_find(&my_node[0]);
+	struct uf_node *root2 = uf_find(&my_node[1]);
+	if (root1 == root2)
+		connected = 1;
+	else
+		connected = 0;
+
+Union Two Sets in Union-Find
+----------------------------
+
+To union two sets in the Union-Find, you first find their respective root nodes
+and then link the smaller node to the larger node based on the rank of the root
+nodes.
+Example::
+
+	uf_union(&my_node[0], &my_node[1]);
diff --git a/Documentation/translations/zh_CN/core-api/union_find.rst b/Documentation/translations/zh_CN/core-api/union_find.rst
new file mode 100644
index 0000000000..071818e7db
--- /dev/null
+++ b/Documentation/translations/zh_CN/core-api/union_find.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/core-api/union_find.rst
+
+===========================
+Linux中的并查集（Union-Find）
+===========================
+
+
+:日期: 2024年6月21日
+:作者: Xavier <xavier_qy@163.com>
+
+何为并查集，它有什么用？
+---------------------
+
+并查集是一种数据结构，用于处理一些不交集的合并及查询问题。并查集支持的主要操作：
+	初始化：将每个元素初始化为单独的集合，每个集合的初始父节点指向自身
+	查询：查询某个元素属于哪个集合，通常是返回集合中的一个“代表元素”。这个操作是为
+		了判断两个元素是否在同一个集合之中。
+	合并：将两个集合合并为一个。
+
+并查集作为一种用于维护集合（组）的数据结构，它通常用于解决一些离线查询、动态连通性和
+图论等相关问题，同时也是用于计算最小生成树的克鲁斯克尔算法中的关键，由于最小生成树在
+网络路由等场景下十分重要，并查集也得到了广泛的引用。此外，并查集在符号计算，寄存器分
+配等方面也有应用。
+
+空间复杂度: O(n)，n为节点数。
+
+时间复杂度：使用路径压缩可以减少查找操作的时间复杂度，使用按秩合并可以减少合并操作的
+时间复杂度，使得并查集每个查询和合并操作的平均时间复杂度仅为O(α(n))，其中α(n)是反阿
+克曼函数，可以粗略地认为并查集的操作有常数的时间复杂度。
+
+本文档涵盖了对Linux并查集实现的使用方法。更多关于并查集的性质和实现的信息，参见：
+
+  维基百科并查集词条
+    https://en.wikipedia.org/wiki/Disjoint-set_data_structure
+
+并查集的Linux实现
+----------------
+
+Linux的并查集实现在文件“lib/union_find.c”中。要使用它，需要
+“#include <linux/union_find.h>”。
+
+并查集的数据结构定义如下::
+	struct uf_node {
+		struct uf_node *parent;
+		unsigned int rank;
+	};
+其中parent为当前节点的父节点，为了提高效率，初始化时为空，并在第一次查找时指向自身，
+rank为当前树的高度，在合并时将rank小的节点接到rank大的节点下面以增加平衡性。
+
+创建并查集
+---------
+
+创建并查集时只需要传入并查集的节点个数即可，无需额外初始化，返回节点数组指针。
+示例::
+	struct uf_node *my_node = uf_nodes_alloc(num);
+
+销毁并查集
+---------
+
+销毁并查集时，只需传入创建时返回的节点数组指针即可。
+示例::
+	uf_nodes_free(my_node);
+
+查找并查集的根节点
+----------------
+
+主要用于判断两个并查集是否属于一个集合，如果根相同，那么他们就是一个集合。在查找过程中
+会对路径进行压缩，提高后续查找效率。
+示例::
+	int connected;
+	struct uf_node *root1 = uf_find(&my_node[0]);
+	struct uf_node *root2 = uf_find(&my_node[1]);
+	if (root1 == root2)
+		connected = 1;
+	else
+		connected = 0;
+
+合并两个并查集
+-------------
+
+对于两个相交的并查集进行合并，会首先查找它们各自的根节点，然后根据根节点秩大小，将小的
+节点连接到大的节点下面。
+示例::
+	uf_union(&my_node[0], &my_node[1]);
diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7..a1a467c591 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23054,6 +23054,15 @@ F:	drivers/cdrom/cdrom.c
 F:	include/linux/cdrom.h
 F:	include/uapi/linux/cdrom.h
 
+UNION-FIND
+M:	Xavier <xavier_qy@163.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/core-api/union_find.rst
+F:	Documentation/translations/zh_CN/core-api/union_find.rst
+F:	include/linux/union_find.h
+F:	lib/union_find.c
+
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER
 R:	Alim Akhtar <alim.akhtar@samsung.com>
 R:	Avri Altman <avri.altman@wdc.com>
diff --git a/include/linux/union_find.h b/include/linux/union_find.h
new file mode 100644
index 0000000000..67e9f62bb3
--- /dev/null
+++ b/include/linux/union_find.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_UNION_FIND_H
+#define __LINUX_UNION_FIND_H
+#include <linux/slab.h>
+
+/* Define a union-find node struct */
+struct uf_node {
+	struct uf_node *parent;
+	unsigned int rank;
+};
+
+/* Allocate nodes and initialize to 0 */
+static inline struct uf_node *uf_nodes_alloc(unsigned int node_num)
+{
+	return kzalloc(sizeof(struct uf_node) * node_num, GFP_KERNEL);
+}
+
+/* Free nodes*/
+static inline void uf_nodes_free(struct uf_node *nodes)
+{
+	kfree(nodes);
+}
+
+/* find the root of a node*/
+struct uf_node *uf_find(struct uf_node *node);
+
+/* Merge two intersecting nodes */
+void uf_union(struct uf_node *node1, struct uf_node *node2);
+
+#endif /*__LINUX_UNION_FIND_H*/
diff --git a/lib/Makefile b/lib/Makefile
index 3b17690456..e1769e6f03 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o
+	 buildid.o objpool.o union_find.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/union_find.c b/lib/union_find.c
new file mode 100644
index 0000000000..2f77bae1ca
--- /dev/null
+++ b/lib/union_find.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/union_find.h>
+
+struct uf_node *uf_find(struct uf_node *node)
+{
+	struct uf_node *parent;
+
+	if (!node->parent) {
+		node->parent = node;
+		return node;
+	}
+
+	/*Find the root node and perform path compression at the same time*/
+	while (node->parent != node) {
+		parent = node->parent;
+		node->parent = parent->parent;
+		node = parent;
+	}
+	return node;
+}
+
+/*Function to merge two sets, using union by rank*/
+void uf_union(struct uf_node *node1, struct uf_node *node2)
+{
+	struct uf_node *root1 = uf_find(node1);
+	struct uf_node *root2 = uf_find(node2);
+
+	if (root1 != root2) {
+		if (root1->rank < root2->rank) {
+			root1->parent = root2;
+		} else if (root1->rank > root2->rank) {
+			root2->parent = root1;
+		} else {
+			root2->parent = root1;
+			root1->rank++;
+		}
+	}
+}
-- 
2.45.2


