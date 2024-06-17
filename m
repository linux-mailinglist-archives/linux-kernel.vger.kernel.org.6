Return-Path: <linux-kernel+bounces-216959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED7D90A929
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08001F24C93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6A19069C;
	Mon, 17 Jun 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="AuE/mqPJ"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13E1190685
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615423; cv=none; b=Lb42FRc+Oz3nISQ+M+6slyr66NHT52EHO7I7RF6KZwVN3QXxIbQ0yVsYHDRIwtBJFBPng9GlYg7KbWImn9/cXQ+ceJ1Vajb4hjhu2V3ARa1lZ5/24rPhBLsYOY+DJnseD7YC5LBBy0xyegxZysLLldCV1fcksqqqDCAMz6tdEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615423; c=relaxed/simple;
	bh=DdCPOdQmrAjhuhY9h+trWlJUu0TJ43Y9MmSImJCW2uA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=XglVRq827Uf3Se79H+NkLvK/tduvpqd3aXi/Ya47GcyG4hb/X4NicRndZ5vyEYhJpWUrXc7utrCtxM0KyotI0QpcimdQ/3BAsZ9Rf7OnCC4fo0k4Hf0HpwvsJ+ir8guo93GP8cNCyn8v9yNlg3Lx/KbrXdk9ky/kqW/lKxqJvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=AuE/mqPJ; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1718615418;
	bh=3cwK7/F68hnzfW+WeXsBbPpNomD2U0ZeRwICxZjWgq8=;
	h=From:To:Cc:Subject:Date;
	b=AuE/mqPJvwBUXPzvRj7/iMiX8TTXA7DMfRYBsMO4JJM5e0lGMJtBKOSz5T+nDLV1E
	 Nq9z5SyLexPrJQyAIq/buqkwh2WYKjIfNDqrie54EypwHkN89gtb9Qd9vuN2nCK8Ze
	 //E5dilhJkfndcQVb/pGgwN7pCjKD0ooexXaS01w=
Received: from localhost.localdomain ([203.119.160.29])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id FA3A60F; Mon, 17 Jun 2024 17:03:58 +0800
X-QQ-mid: xmsmtpt1718615038t0ywb5yy8
Message-ID: <tencent_F6283AC33634D608765A49147F203961E308@qq.com>
X-QQ-XMAILINFO: Mi1i9A6j4UyX6l/q9sLmBwaskHCdXxA+7W3RCVvUTcj+VlB6ikqnoi9/4o7OUt
	 mf/0uAifwiUKPNqh+IWQvZ10usBaxSJknz9+PExUQAGNE7bbzvjYXw71gUtnoVctuRtT14nvHAGn
	 ZmkczWgT09fOUOjR1gnqbNwvlItUXbbINEAwv7oZoIylApHE+d89Jh8yQGBk1BlulZCaUY30EdQ9
	 71uG39iadx2V8wYjh8tk+A8PvjDwDbpP4l3j+EJvevcWDyZXRpAodkhCN61N2YRckZQkmRPUdNmX
	 eh61G6Rr+9/iJVwRKDx9RJlC2rAVLSamQJYzufw7cm/lt7UtlKtaCT+iephiv07zVypJSmHrDiNv
	 R03v8U14WYgpSqdk6/IyjEWiOvxs6OXRSv/JA/XsG2UyhxiCZmHMvn718uU5ms6ClJDp7kAAAT4C
	 fFhgllhjk7P7fcGjNDjomv/qd6/QsXCJ07I5TmVFBqpvH9OKDUT7By1KahPvklAHiqGZsvNZ+wyV
	 4/JZtHb6B/eh5CqQX7CAIBK6HNGdtd3WDAeTq+vaeZ9xe5hNOAp91SzQXfL9eiE3C/ZKom5gbJKf
	 3m4TMcdYznq55ijZFwRqug1wdOsxzN5t/cxEaCNU6d3DJncLeHu25ObFZH99eGR7hPocc1TO4pHn
	 wcnlfUsx82QTQlC1Y6hKU5enodN8aRtwvmO8l8e8ik2FP+i9w94pirRryX+Bg+HntaqXJoe/woiV
	 Gfq4/Rx+jyestsq4mD5NC3+w545ZmQE1CznF8b8Q505xMI6KRNDkqIUnwDOnbkNqTtPF1kr9KUYv
	 SQzZanCKhPTuGuvanMhc11Oj58dNJfDdq3NvMkFo2aHPMTULq2Cd6UK6LIH2PotWingAXo3yNPPU
	 x3mjpMBKFCOsrRKw40n4Rih+irrV2HuQgZBRl1AJV5x8qJNwSRtkKqHUnX7CamPJi84j/v2pEgr+
	 wMG0HlFFdOotmYtENgQTVuAWfIi1jQkIyxcpaUEwtoL7shobHCRKpuNjd2CkhA37E0tWl2RbCBjx
	 kMnDlldVrwLhWqS95eJ+SP4GNoHNczOoZhjlXgVF+9XCXmcqhbPOj0uudc4XFaM4yqEOutih0v6u
	 zGybo7faf1nXXeMpjz25wAOPuRGg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: wodemia@foxmail.com
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	Tao Zou <wodemia@linux.alibaba.com>
Subject: [PATCH 1/1] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst translation document
Date: Mon, 17 Jun 2024 17:03:56 +0800
X-OQ-MSGID: <20240617090356.54592-1-wodemia@foxmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tao Zou <wodemia@linux.alibaba.com>

Add translation zh_CN/admin-guide/numastat.rst and link it to
zh_CN/admin-guide/index.rst while clean its todo entry.

Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
---
 .../translations/zh_CN/admin-guide/index.rst  |  2 +-
 .../zh_CN/admin-guide/numastat.rst            | 50 +++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
index ac2960da33e6..0db80ab830a0 100644
--- a/Documentation/translations/zh_CN/admin-guide/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/index.rst
@@ -68,6 +68,7 @@ Todolist:
    cpu-load
    cputopology
    lockup-watchdogs
+   numastat
    unicode
    sysrq
    mm/index
@@ -109,7 +110,6 @@ Todolist:
 *   module-signing
 *   mono
 *   namespaces/index
-*   numastat
 *   parport
 *   perf-security
 *   pm/index
diff --git a/Documentation/translations/zh_CN/admin-guide/numastat.rst b/Documentation/translations/zh_CN/admin-guide/numastat.rst
new file mode 100644
index 000000000000..4f7fee557cb5
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/numastat.rst
+:Translator: Tao Zou <wodemia@linux.alibaba.com>
+
+.. _cn_numastat:
+
+
+===============================
+Numa策略命中/未命中统计
+===============================
+
+/sys/devices/system/node/node*/numastat
+
+所有数据的单位都是页面。巨页有独立的计数器。
+
+numa_hit、numa_miss和numa_foreign计数器反应了进程是否能够在他们偏好的节点上分配内存。
+如果进程成功在偏好的节点上分配内存则在偏好的节点上增加numa_hit计数，否则在偏好的节点上增
+加numa_foreign计数同时在实际内存分配的节点上增加numa_miss计数。
+
+通常，偏好的节点是进程运行所在的CPU的本地节点，但是一些限制可以改变这一行为，比如内存策略，
+因此同样有两个基于CPU本地节点的计数器。local_node和numa_hit类似，当在CPU所在的节点上分
+配内存时增加local_node计数，other_node和numa_miss类似，当在CPU所在节点之外的其他节点
+上成功分配内存时增加other_node计数。需要注意，没有和numa_foreign对应的计数器。
+
+更多细节内容:
+
+=============== ============================================================
+numa_hit        一个进程想要从本节点分配内存并且成功。
+
+numa_miss       一个进程想要从其他节点分配内存但是最终在本节点完成内存分配。
+
+numa_foreign    一个进程想要在本节点分配内存但是最终在其他节点完成内存分配。
+
+local_node      一个进程运行在本节点的CPU上并且从本节点上获得了内存。
+
+other_node      一个进程运行在其他节点的CPU上但是在本节点上获得了内存。
+
+interleave_hit  内存交叉分配策略下想要从本节点分配内存并且成功。
+=============== ============================================================
+
+你可以使用numactl软件包（http://oss.sgi.com/projects/libnuma/）中的numastat工具
+来辅助阅读。需要注意，numastat工具目前只在有少量CPU的机器上运行良好。
+
+需要注意，在有无内存节点（一个节点有CPUs但是没有内存）的系统中numa_hit，numa_miss和
+numa_foreign统计数据会被严重曲解。在当前的内核实现中，如果一个进程偏好一个无内存节点（即
+进程正在该节点的一个本地CPU上运行），实际上会从距离最近的有内存节点中挑选一个作为偏好节点。
+结果会导致相应的内存分配不会增加无内存节点上的numa_foreign计数器，并且会扭曲最近节点上的
+numa_hit、numa_miss和numa_foreign统计数据。
-- 
2.39.3 (Apple Git-146)


